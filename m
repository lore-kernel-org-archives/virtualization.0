Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3748C7EE21
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 21:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1842B820B0;
	Tue, 25 Apr 2023 21:26:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1842B820B0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=e06wfPo9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xSJLQs_csBHZ; Tue, 25 Apr 2023 21:26:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BC6D820DC;
	Tue, 25 Apr 2023 21:26:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BC6D820DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66875C008C;
	Tue, 25 Apr 2023 21:26:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D257C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C98E660F2E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C98E660F2E
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=e06wfPo9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uUX9gqalt5AW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA99860F3F
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA99860F3F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 21:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njtZBkW8hn5THEYc6C64S9OnQ2x19qGvKE3H2ugOx/b0H6BAcypvO61j9OpZM78nCj4jGonu7Z1vm/YUzasQ4opuZ7WIwZd7Pq1KTedbl4KGArWPzsbvesPG3wQinW6iW667uv4mvUOsZEG3FpgoSnop6rQHt+WSI2w8rBPFXestJhViSp70zJciaS7PErdYzW3MPiNzu1tVCpQuuZSDKFmfko1R+gPLTZQIWO9Vqx4y39mUiI8pn/nAQqOcTrTu/bAzLYH9BvzFDT/AUOuAy8y/vK1QpCpXunGhb6jrQv54VnMPvNG2BkvKbkw7mMgunFOjU9M29GuGuqpNUlFg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DN/EFBNnTn1tJG4ExFgRBsBrlQ6ASc8w4qK7iE7P2Qk=;
 b=doyhq4yWlgjC+spyRWcW1HKjmd4YWqyDfZi/ah282wj2jbRGp0OMyBT3uwqBqlPdOuVXh9SOphAGIBmICQyqPBTEWxQegS0/p2sTTZQSSS+GVJmjCgveaPfeyhZIq9LlDh50FmKk1DCK9OFtZUuRdsSD7xbbwMtETWYLRjUTpOLM2XB95szE5SmKycPPkJgSVZONpyeRowfxGOB4IiY9POSrUYFIIsfDQb8k9lJ4/EyDaeiwmtWfouUuIqI/vfXIyPCjXspZsMNi+mE8nhYcS5buubUJ8fO82w4/Ud/fG5VyRglNCkC2J1+YykExtebSmdGT2NSyhiNBtz9Yg5uQyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DN/EFBNnTn1tJG4ExFgRBsBrlQ6ASc8w4qK7iE7P2Qk=;
 b=e06wfPo9CgX1nl+C3Wa4wPdNVZ8WXqMIKQHUHAXKU1WqiH7brwusVb4U8Lv8xRyNJ+vxPZ9U7yQZjz2dXiEOt3bCOH4hc3BIzlRMsI2qc/EWdA+IC4VPUOxRA9iNxZAn26/cUa3MPUAocwESKQ4AVI7VZgiaXZbB77gpCABSn4A=
Received: from DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8) by
 PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Tue, 25 Apr 2023 21:26:21 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::d3) by DS7PR06CA0024.outlook.office365.com
 (2603:10b6:8:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20 via Frontend
 Transport; Tue, 25 Apr 2023 21:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Tue, 25 Apr 2023 21:26:21 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 25 Apr
 2023 16:26:20 -0500
To: <jasowang@redhat.com>, <mst@redhat.com>,
 <virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
 <brett.creeley@amd.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 virtio 04/10] pds_vdpa: new adminq entries
Date: Tue, 25 Apr 2023 14:25:56 -0700
Message-ID: <20230425212602.1157-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230425212602.1157-1-shannon.nelson@amd.com>
References: <20230425212602.1157-1-shannon.nelson@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 582c8ab1-b7ad-41f6-d898-08db45d3b721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4GuGpq6tbhJUJcu584DzxUlON2zE4Ny5ncZJ5EoxZCZH3ayJl6T+mQOgsuBaA3a867Mb6e28qp6rYRBHHgpKmqFIPdom2TvmIDaW8sm8FNs9dunrSxN75uEHb+OqQQ3V0vC3+YmBqiGCaSMDxesAzt7MHH0s178p56Bf+v2mYdD444391tvf/YNxOXa7gEP8xfzHN4ynZ/C2XxxlFktzc1AdsRvkcQaYCajplWaF4KZR87+kmBMiIk3ENHW3LvOfRRQ5KeMYIkVykJZ5FiK+bVWh9Hj/JntI6sY86MAgoJl+jz5eFWT0emeNzhtWVdSA4D0A99R08p3VwO+C4NNLaQ9aWU8Sy2uXclm7ouGTsIGtaLgNiXYm1bNz1VBylQpTcczCzueMBB1oduZyeRxsoHnYNMcR3l/IkpnVnlH60YrCk5nU9Lsvi4q6tOthfrzz3aNHyKCrPT3LRZGxRzzDdmfiu2lRQybUCTWiXwBjjVci3sV6KiU7srvuNKnP6YJWAOrqGFpBcJpINY1A7+YTwUShA+ltkPNxWcpoTMYtu5koSG5hADSwqPbJp5Wkufc/FvY71R/X3QBocbfiOlNFjtJmu49BS0kTGOt5LovDaTIAd7SnZ9Fs6GtTlMqrSWlCW+kvJHD9H6cSCAllU/QSp75kYPalpWXctF0SU6bUWkynw2cn+2jecx1egYBDJ7/CbMrXwwOJXQLjxyB/hfXvGSEYRGfKi4qyWSLB8DUnKhs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(16526019)(40460700003)(110136005)(86362001)(36756003)(186003)(26005)(82310400005)(1076003)(40480700001)(4326008)(316002)(6666004)(82740400003)(44832011)(83380400001)(70206006)(70586007)(36860700001)(2906002)(41300700001)(336012)(8676002)(356005)(426003)(81166007)(5660300002)(8936002)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 21:26:21.5140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582c8ab1-b7ad-41f6-d898-08db45d3b721
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
Cc: drivers@pensando.io
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Shannon Nelson via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Shannon Nelson <shannon.nelson@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Add new adminq definitions in support for vDPA operations.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 include/linux/pds/pds_adminq.h | 266 +++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index 61b0a8634e1a..c66ead725434 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -605,6 +605,257 @@ struct pds_core_q_init_comp {
 	u8     color;
 };
 
+/*
+ * enum pds_vdpa_cmd_opcode - vDPA Device commands
+ */
+enum pds_vdpa_cmd_opcode {
+	PDS_VDPA_CMD_INIT		= 48,
+	PDS_VDPA_CMD_IDENT		= 49,
+	PDS_VDPA_CMD_RESET		= 51,
+	PDS_VDPA_CMD_VQ_RESET		= 52,
+	PDS_VDPA_CMD_VQ_INIT		= 53,
+	PDS_VDPA_CMD_STATUS_UPDATE	= 54,
+	PDS_VDPA_CMD_SET_FEATURES	= 55,
+	PDS_VDPA_CMD_SET_ATTR		= 56,
+	PDS_VDPA_CMD_VQ_SET_STATE	= 57,
+	PDS_VDPA_CMD_VQ_GET_STATE	= 58,
+};
+
+/**
+ * struct pds_vdpa_cmd - generic command
+ * @opcode:	Opcode
+ * @vdpa_index:	Index for vdpa subdevice
+ * @vf_id:	VF id
+ */
+struct pds_vdpa_cmd {
+	u8     opcode;
+	u8     vdpa_index;
+	__le16 vf_id;
+};
+
+/**
+ * struct pds_vdpa_init_cmd - INIT command
+ * @opcode:	Opcode PDS_VDPA_CMD_INIT
+ * @vdpa_index: Index for vdpa subdevice
+ * @vf_id:	VF id
+ */
+struct pds_vdpa_init_cmd {
+	u8     opcode;
+	u8     vdpa_index;
+	__le16 vf_id;
+};
+
+/**
+ * struct pds_vdpa_ident - vDPA identification data
+ * @hw_features:	vDPA features supported by device
+ * @max_vqs:		max queues available (2 queues for a single queuepair)
+ * @max_qlen:		log(2) of maximum number of descriptors
+ * @min_qlen:		log(2) of minimum number of descriptors
+ *
+ * This struct is used in a DMA block that is set up for the PDS_VDPA_CMD_IDENT
+ * transaction.  Set up the DMA block and send the address in the IDENT cmd
+ * data, the DSC will write the ident information, then we can remove the DMA
+ * block after reading the answer.  If the completion status is 0, then there
+ * is valid information, else there was an error and the data should be invalid.
+ */
+struct pds_vdpa_ident {
+	__le64 hw_features;
+	__le16 max_vqs;
+	__le16 max_qlen;
+	__le16 min_qlen;
+};
+
+/**
+ * struct pds_vdpa_ident_cmd - IDENT command
+ * @opcode:	Opcode PDS_VDPA_CMD_IDENT
+ * @rsvd:       Word boundary padding
+ * @vf_id:	VF id
+ * @len:	length of ident info DMA space
+ * @ident_pa:	address for DMA of ident info (struct pds_vdpa_ident)
+ *			only used for this transaction, then forgotten by DSC
+ */
+struct pds_vdpa_ident_cmd {
+	u8     opcode;
+	u8     rsvd;
+	__le16 vf_id;
+	__le32 len;
+	__le64 ident_pa;
+};
+
+/**
+ * struct pds_vdpa_status_cmd - STATUS_UPDATE command
+ * @opcode:	Opcode PDS_VDPA_CMD_STATUS_UPDATE
+ * @vdpa_index: Index for vdpa subdevice
+ * @vf_id:	VF id
+ * @status:	new status bits
+ */
+struct pds_vdpa_status_cmd {
+	u8     opcode;
+	u8     vdpa_index;
+	__le16 vf_id;
+	u8     status;
+};
+
+/**
+ * enum pds_vdpa_attr - List of VDPA device attributes
+ * @PDS_VDPA_ATTR_MAC:          MAC address
+ * @PDS_VDPA_ATTR_MAX_VQ_PAIRS: Max virtqueue pairs
+ */
+enum pds_vdpa_attr {
+	PDS_VDPA_ATTR_MAC          = 1,
+	PDS_VDPA_ATTR_MAX_VQ_PAIRS = 2,
+};
+
+/**
+ * struct pds_vdpa_setattr_cmd - SET_ATTR command
+ * @opcode:		Opcode PDS_VDPA_CMD_SET_ATTR
+ * @vdpa_index:		Index for vdpa subdevice
+ * @vf_id:		VF id
+ * @attr:		attribute to be changed (enum pds_vdpa_attr)
+ * @pad:		Word boundary padding
+ * @mac:		new mac address to be assigned as vdpa device address
+ * @max_vq_pairs:	new limit of virtqueue pairs
+ */
+struct pds_vdpa_setattr_cmd {
+	u8     opcode;
+	u8     vdpa_index;
+	__le16 vf_id;
+	u8     attr;
+	u8     pad[3];
+	union {
+		u8 mac[6];
+		__le16 max_vq_pairs;
+	} __packed;
+};
+
+/**
+ * struct pds_vdpa_vq_init_cmd - queue init command
+ * @opcode: Opcode PDS_VDPA_CMD_VQ_INIT
+ * @vdpa_index:	Index for vdpa subdevice
+ * @vf_id:	VF id
+ * @qid:	Queue id (bit0 clear = rx, bit0 set = tx, qid=N is ctrlq)
+ * @len:	log(2) of max descriptor count
+ * @desc_addr:	DMA address of descriptor area
+ * @avail_addr:	DMA address of available descriptors (aka driver area)
+ * @used_addr:	DMA address of used descriptors (aka device area)
+ * @intr_index:	interrupt index
+ */
+struct pds_vdpa_vq_init_cmd {
+	u8     opcode;
+	u8     vdpa_index;
+	__le16 vf_id;
+	__le16 qid;
+	__le16 len;
+	__le64 desc_addr;
+	__le64 avail_addr;
+	__le64 used_addr;
+	__le16 intr_index;
+};
+
+/**
+ * struct pds_vdpa_vq_init_comp - queue init completion
+ * @status:	Status of the command (enum pds_core_status_code)
+ * @hw_qtype:	HW queue type, used in doorbell selection
+ * @hw_qindex:	HW queue index, used in doorbell selection
+ * @rsvd:	Word boundary padding
+ * @color:	Color bit
+ */
+struct pds_vdpa_vq_init_comp {
+	u8     status;
+	u8     hw_qtype;
+	__le16 hw_qindex;
+	u8     rsvd[11];
+	u8     color;
+};
+
+/**
+ * struct pds_vdpa_vq_reset_cmd - queue reset command
+ * @opcode:	Opcode PDS_VDPA_CMD_VQ_RESET
+ * @vdpa_index:	Index for vdpa subdevice
+ * @vf_id:	VF id
+ * @qid:	Queue id
+ */
+struct pds_vdpa_vq_reset_cmd {
+	u8     opcode;
+	u8     vdpa_index;
+	__le16 vf_id;
+	__le16 qid;
+};
+
+/**
+ * struct pds_vdpa_set_features_cmd - set hw features
+ * @opcode: Opcode PDS_VDPA_CMD_SET_FEATURES
+ * @vdpa_index:	Index for vdpa subdevice
+ * @vf_id:	VF id
+ * @rsvd:       Word boundary padding
+ * @features:	Feature bit mask
+ */
+struct pds_vdpa_set_features_cmd {
+	u8     opcode;
+	u8     vdpa_index;
+	__le16 vf_id;
+	__le32 rsvd;
+	__le64 features;
+};
+
+/**
+ * struct pds_vdpa_vq_set_state_cmd - set vq state
+ * @opcode:	Opcode PDS_VDPA_CMD_VQ_SET_STATE
+ * @vdpa_index:	Index for vdpa subdevice
+ * @vf_id:	VF id
+ * @qid:	Queue id
+ * @avail:	Device avail index.
+ * @used:	Device used index.
+ *
+ * If the virtqueue uses packed descriptor format, then the avail and used
+ * index must have a wrap count.  The bits should be arranged like the upper
+ * 16 bits in the device available notification data: 15 bit index, 1 bit wrap.
+ */
+struct pds_vdpa_vq_set_state_cmd {
+	u8     opcode;
+	u8     vdpa_index;
+	__le16 vf_id;
+	__le16 qid;
+	__le16 avail;
+	__le16 used;
+};
+
+/**
+ * struct pds_vdpa_vq_get_state_cmd - get vq state
+ * @opcode:	Opcode PDS_VDPA_CMD_VQ_GET_STATE
+ * @vdpa_index:	Index for vdpa subdevice
+ * @vf_id:	VF id
+ * @qid:	Queue id
+ */
+struct pds_vdpa_vq_get_state_cmd {
+	u8     opcode;
+	u8     vdpa_index;
+	__le16 vf_id;
+	__le16 qid;
+};
+
+/**
+ * struct pds_vdpa_vq_get_state_comp - get vq state completion
+ * @status:	Status of the command (enum pds_core_status_code)
+ * @rsvd0:      Word boundary padding
+ * @avail:	Device avail index.
+ * @used:	Device used index.
+ * @rsvd:       Word boundary padding
+ * @color:	Color bit
+ *
+ * If the virtqueue uses packed descriptor format, then the avail and used
+ * index will have a wrap count.  The bits will be arranged like the "next"
+ * part of device available notification data: 15 bit index, 1 bit wrap.
+ */
+struct pds_vdpa_vq_get_state_comp {
+	u8     status;
+	u8     rsvd0;
+	__le16 avail;
+	__le16 used;
+	u8     rsvd[9];
+	u8     color;
+};
+
 union pds_core_adminq_cmd {
 	u8     opcode;
 	u8     bytes[64];
@@ -621,6 +872,18 @@ union pds_core_adminq_cmd {
 
 	struct pds_core_q_identify_cmd    q_ident;
 	struct pds_core_q_init_cmd        q_init;
+
+	struct pds_vdpa_cmd		  vdpa;
+	struct pds_vdpa_init_cmd	  vdpa_init;
+	struct pds_vdpa_ident_cmd	  vdpa_ident;
+	struct pds_vdpa_status_cmd	  vdpa_status;
+	struct pds_vdpa_setattr_cmd	  vdpa_setattr;
+	struct pds_vdpa_set_features_cmd  vdpa_set_features;
+	struct pds_vdpa_vq_init_cmd	  vdpa_vq_init;
+	struct pds_vdpa_vq_reset_cmd	  vdpa_vq_reset;
+	struct pds_vdpa_vq_set_state_cmd  vdpa_vq_set_state;
+	struct pds_vdpa_vq_get_state_cmd  vdpa_vq_get_state;
+
 };
 
 union pds_core_adminq_comp {
@@ -642,6 +905,9 @@ union pds_core_adminq_comp {
 
 	struct pds_core_q_identify_comp   q_ident;
 	struct pds_core_q_init_comp       q_init;
+
+	struct pds_vdpa_vq_init_comp	  vdpa_vq_init;
+	struct pds_vdpa_vq_get_state_comp vdpa_vq_get_state;
 };
 
 #ifndef __CHECKER__
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
