-- Organization
-- Workspace

-- For reference: https://looker.corp.mparticle.com/dashboards/115

-- Ops Ticket:
-- https://mparticle.atlassian.net/servicedesk/customer/portal/4/group/11/create/82

-- {Org} - {Workspace} - DM / JIT Cleanup
-- Can the following SQL be run to do DM/JIT cleanup - attached in comments.
-- This is attached to the Zen Desk Cleanup Request below:
-- https://mparticlehelp.zendesk.com/agent/tickets/XXXX
-- The number of rows is written above the queries. If the queries runs correctly, please run with commit.

BEGIN TRANSACTION

-- {#} rows
	INSERT INTO dbo.SchemaItemTransformation(
		SchemaNameId,
		WorkspaceId,
		SchemaItemTypeId,
		MessageTypeId,
		EventTypeId,
		EntityTypeId,
		SAId,
		SecureOrganizationId,
		CreatedOn,
		CreatedBy,
		LastModifiedOn,
		LastModifiedBy,
		IsHidden,
		IsDropped,
		IsAudienceDropped,
		SystemHidden
		)
	SELECT
		SchemaNameId,
		WorkspaceId,
		1,
		messagetypeid,
		EventTypeId,
		null,
		SAId,
		SecureOrganizationId,
		GETUTCDATE(),
		'javioli zd XXXX',
		null,
		null,
		0,
		0,
		0,
		1
	FROM (
		SELECT DISTINCT
			s.name,
			s.SchemaNameId,
			b.WorkspaceId,
			4 as messagetypeid,
			e.EventTypeId,
			e.SAId,
			e.SecureOrganizationId
		FROM dbo.EventClass AS e
		FULL join dbo.ApplicationFamily AS b
			ON e.applicationfamilyid = b.applicationfamilyid
		INNER JOIN dbo.SchemaName AS s
			ON lower(s.Name) = lower(e.Name)
		LEFT JOIN SchemaItemTransformation as st
			ON st.SchemaNameId = s.SchemaNameId
		WHERE e.secureorganizationid = OrgID
			AND b.applicationfamilyid = AppFamID
			AND st.SchemaItemTransformationId is NULL
			AND e.IsVisible = 1
			AND s.name IN ( --OR s.SchemaName

			);
	) AS sz;

	-- {#} rows
	UPDATE e
	SET
		e.IsVisible=0,
		e.LastUpdated=GETUTCDATE(),
		e.LastModifiedBy='script javioli zd XXXX'
  FROM eventclass e
	INNER JOIN dbo.SchemaName s
		ON lower(s.Name) = lower(e.Name)
	WHERE e.secureorganizationid = OrgID
		AND e.applicationfamilyid = AppFamID
		AND e.IsVisible = 1
		AND s.name IN ( --OR s.SchemaName

		);

		-- {#} rows
		INSERT INTO dbo.SchemaItemTransformation(
			SchemaNameId,
			WorkspaceId,
			SchemaItemTypeId,
			MessageTypeId,
			EventTypeId,
			EntityTypeId,
			SAId,
			SecureOrganizationId,
			CreatedOn,
			CreatedBy,
			LastModifiedOn,
			LastModifiedBy,
			IsHidden,
			IsDropped,
			IsAudienceDropped,
			SystemHidden
			)
		SELECT
			SchemaNameId,
			WorkspaceId,
			1,
			messagetypeid,
			EventTypeId,
			null,
			SAId,
			SecureOrganizationId,
			GETUTCDATE(),
			'javioli zd XXXX',
			null,
			null,
			0,
			0,
			0,
			1
		FROM (
			SELECT DISTINCT
				s.name,
				s.SchemaNameId,
				b.WorkspaceId,
				e.messagetypeid,
				e.EventTypeId,
				e.SAId,
				e.SecureOrganizationId
			FROM dbo.EventClassDetails AS e
			FULL join dbo.ApplicationFamily AS b
				ON e.applicationfamilyid = b.applicationfamilyid
			INNER JOIN dbo.SchemaName AS s
				ON lower(s.Name) = lower(e.Name)
			LEFT JOIN SchemaItemTransformation as st
				ON st.SchemaNameId = s.SchemaNameId
			WHERE e.secureorganizationid = OrgID
			AND b.applicationfamilyid = AppFamID
			AND st.SchemaItemTransformationId is NULL
			AND e.name IN ( --OR s.SchemaName

				)
			) AS sz;

		-- {#} rows
		UPDATE e
		SET
			e.IsVisible=0,
			e.LastUpdated=GETUTCDATE(),
			e.LastModifiedBy='script javioli zd XXXX'
	  FROM eventclassdetails e
		INNER JOIN dbo.SchemaName s
			ON lower(s.Name) = lower(e.Name)
		WHERE e.secureorganizationid = OrgID
			AND e.applicationfamilyid = AppFamID
			AND e.IsVisible = 1
			AND s.name IN ( --OR s.SchemaName

			);

ROLLBACK
--COMMIT
