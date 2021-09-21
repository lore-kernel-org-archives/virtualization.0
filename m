Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60791C433FE
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B3D60FA0
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25B3D60FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBA1D613A6;
	Tue, 21 Sep 2021 21:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hHp_yjXHUHXm; Tue, 21 Sep 2021 21:53:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3B48A613A3;
	Tue, 21 Sep 2021 21:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24B5AC0011;
	Tue, 21 Sep 2021 21:53:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6095FC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40F0340474
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="IBDj0lNW";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="oBbz+X+q"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hqf8WLyTYUK1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D518A40444
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:07 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLEBfx028880; 
 Tue, 21 Sep 2021 21:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=UDzD+wE69P1GE2KI5B6hgMfAV25h205Jca/VihiNBXM=;
 b=IBDj0lNWeK2+GRSqdnfVW+AzVMq+hKN9fN3gzIn2XLgsKOEIzLPCngUdCPsB0mODvNSm
 iVeKmEMXZyqjH1jjRbLqWxAL7BSlmp3KyinFZqVH/XLUN43miNVhJVEnuLo9yhdLtEO9
 l8DDrznm3NdroTP7DSZqj8GmNxPSo8AMlmAPpWjoC1R3y90RbIepD361A3Dg7YcK8eIN
 OdJzcQU2KfhSYjgLHqXiYbUhyZ+zfRrXu8DyGXUr1vVBGdJ8dehUoyWpkAo2V97UxTGl
 8xeYAXbzui7pdwggDn1SWUKMT1Go4RPmXepsHvcSUH8Ze34Dz7KKE+NkeduTKPdH3xoA 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4r85g6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LLnWGc189326;
 Tue, 21 Sep 2021 21:52:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by userp3030.oracle.com with ESMTP id 3b7q5m177g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf34dEfDgAkq5OZUU546JYXAdyyAI3CPT8eBfrAP9QKKPvs9wV8MpB/QUsC8prBg4p3ECfnEpQS9jz2oFTBTuBQLZAWFuIAlctZg16iJgdBO/e/mvWdiPhmae+vUDFgw1rNs00V/IdyZcOwT3IGrABmeD4u4yj+7ibkXXaVGE64ZBHFC7rEeDxr7sQTcb4kOTNqbUhvNOTavWru38VfoaVUYWcfGxOzQrI8gGl2UFD7C/uliYjIg62AuHRQ2EuxovF8v0rfzSU12J6DUh1aKUmCAwSaPB/KOJnbudetwJYaprdcKHLylTL2DT/YIVxgk2kbvQgV3oQEAyuN/UOBvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=UDzD+wE69P1GE2KI5B6hgMfAV25h205Jca/VihiNBXM=;
 b=kJUFotoIvZEcxkZTFaOFfH96KZDsrpK0G+OHqCe3novcKxmmupbV/IgCOTXZqW0FyNhxtaUUhliQNPc9sk3zxJAcxd/24DEFaWIpJ+vC9R2unt2e3a28ieLFa+bUGwjWngiFjRhOJ82d5eLpzzJ4JmWcjJ+QGwRynU3SWdUKYz7ieuagybJmqNEVi1vzVM92AFa8fSOQSkGUXRaVFPfctH1n4da5pGJNT7ht+opT/P28Cybg9+Q+CIolBnyMUUPgQzOb+cc6J/LMFRPPE0hJYIV8iLrUi+0NDv/YsynuV5WsWsTgXrc4ZFBGCWIgM4B/55s0gEFp/vdU4ubMxfUdqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDzD+wE69P1GE2KI5B6hgMfAV25h205Jca/VihiNBXM=;
 b=oBbz+X+qAMOHqZL68YNxjdDt1ElLNMSXf1OrgshiI2YjHTZpLmi/xgTHbZkAAyoD/6fyLOfA40TgozaEG3JEtVzYGpS3KcJkNcbVFPyP/tdE1VDOP/FnrbeLsvTHU/NNfyJdVdtIsaLJtDeV7Q3vKKIED0c8/bgXikDeSZqjW0c=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3892.namprd10.prod.outlook.com (2603:10b6:a03:1fb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 21:52:38 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 21:52:38 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V2 8/9] vhost: move worker thread fields to new struct
Date: Tue, 21 Sep 2021 16:52:17 -0500
Message-Id: <20210921215218.89844-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210921215218.89844-1-michael.christie@oracle.com>
References: <20210921215218.89844-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR1101CA0021.namprd11.prod.outlook.com
 (2603:10b6:4:4c::31) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR1101CA0021.namprd11.prod.outlook.com (2603:10b6:4:4c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 21:52:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da36f4bf-6dae-47a2-dfb1-08d97d4a20be
X-MS-TrafficTypeDiagnostic: BY5PR10MB3892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB389273E0FEDB79C61122D2D1F1A19@BY5PR10MB3892.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CdORpiFY0MKyNENALA5nkO11yP/OkFA1StMT3rMvS6TzOxViEUqJqfhVcWzeqf4jtUzVTAMgDbEsPy2f6d0G7dVmoF5++DlqMAnv0rfJeP27CpXU72BYQU6sLgmllkMGZeyV/P7SlbRjua1NRHfFDBv+CtdEY26xD4dHZhkRqUCPMhdoBlxQs8AvpO2VWCjySsM8mxOpCWJLQ3x6ZPTgRR133nCU4YPcuZnU3aw0Q1UcoM2F1LlU8g1+31A1ST1MYRv3sKuSDjfJw7XvN4SjQbGTYTJgJRedTJ6OQH6ryiORzWz8m9LeRiwMet9VQTkHJ/qQECyGXNnvIUObB9wie/YTe+iW7kxO/e7c4lCatI+JnW/7GxKeYtN+Xqr62LLFBdovk5sydUH5nWHjzQrVscOp0P37i9CFhU51Ozzjv338e9K8YkHu8HBqaDN2lcCF7mdRTFnFtRgXG7gGBGcPct8vkkxNSSunVrQ489Ax4JEz66X8bF4vBB3CAUdRP/Se9KPX3vckxdj+URb1oopDR7gDY2+PyBETlwgJsAiMToOZtTTl7F5+ln+CIv2jaftcs6rk9lpdMfPyknC4BJh+LbS1Pau5yXctsBQtejRQ+eLx6sKHAraHoisCSzdHJrU/FhDdj3ETYRXGwFy6LrSkyzEfMFWgvaM/HC9frtnvHYGPibVb4eSlC162P6qZuVgpGz/JysrPv8bg7lF1yQiBIYd3JPn2J0C7CVi6NxuE7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(52116002)(107886003)(956004)(66946007)(26005)(4326008)(7416002)(66556008)(2616005)(66476007)(86362001)(6486002)(8676002)(6666004)(508600001)(316002)(2906002)(6512007)(8936002)(38100700002)(1076003)(5660300002)(83380400001)(186003)(38350700002)(921005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0RKkvFQvQ/1atoxEaA1lAJKtkEtfnU15T4r50Z5xchD3OqkeTbcWPt8n9Zc?=
 =?us-ascii?Q?4yADREFTQWohgrIWMAWkIQN7YfGEU8PsUHHcQdnHvO48mKB4/VWhgJnPtb6j?=
 =?us-ascii?Q?Ta8DylmP8j2FvrTK5WI1ng797xZl68BoGTkqxrZ/BXg9vo80wsh0RMhnD8QW?=
 =?us-ascii?Q?mkbZUvatm/RQf3Fr9Imdc4YDAc4BW6MV2OnZWaAzCmNRA9spO5h7PMJdlf+d?=
 =?us-ascii?Q?+IuDgq70UN7Of+UW4g+DZnZVRTj7I7+TiqvMWLG/CXzVheADZahPHOiNTVuB?=
 =?us-ascii?Q?OMPWPqJJjfcSWlFejYSuA++f0YuoVwZUFigHuE1CwwR29a1onjrE+2ggAL03?=
 =?us-ascii?Q?L5APn2USV3C5+EIvYh2zlh4vyOUGRg6PUuMQ6dLQsVzxOWX6eIxiqubqJqWA?=
 =?us-ascii?Q?UfGmKY5RunWZYPo8Hryp13SmJtwQFHdgp4rJWQ5aKFs2j8IWbUXNlLCz3Eu8?=
 =?us-ascii?Q?YIagHJ+/gVn9y42vwt4N522NvDH0lP+BjvMjhdcYPAwcDOJW1hKFt+W/Huds?=
 =?us-ascii?Q?1t6DDBJz4mBZS7hvR6hSmz35qTB6H0/nVdltkSQFujUn2ACMBX/bjXGpewnD?=
 =?us-ascii?Q?axvDpuFracCIte6aL0dYFfdA3pFiWGK4NeT9x5dFdX/jfRo9rhQIN3UMHBRk?=
 =?us-ascii?Q?PutVl6JqwQFM8SBgUghTz+oPVks0lWLa9aHmmtUIcFqg6DBXPs4qCYAGGF4Z?=
 =?us-ascii?Q?NCT+I6d/QLm2+UWFoe7CKL6CsJ0nCMt1kkYE/72+yN1TgSUJQc9idnzEmvJ+?=
 =?us-ascii?Q?ig+1fygwh/MfP8FfjdLfRpvuBwSOEkTjLU1WCldBHmYgxN+kFpbdsK6qWlMn?=
 =?us-ascii?Q?/zJB91BjqG7nbTIOPXMjjfLwoNSd0NjT77MNQ8tgbpe2mP/o9sLJoO7PHLld?=
 =?us-ascii?Q?PgyDBFw4QsBRZ0BGYvV03raRdCqGmwZQTjc0lz3DU2LoYXXS2ue7ZNsnLcv4?=
 =?us-ascii?Q?0Eqj/ZkoG90ArFZHtToR/w++ytvGOyb/ZKG/R78m+aOGmxbTrGjqqPk8MmyV?=
 =?us-ascii?Q?kHlX2JZazFL18COJ9zkNIhRcuzX0JbaNg6qQl6qLZHsw4c6GT2DOlu4s/aZx?=
 =?us-ascii?Q?qeQd5ATWIunjgHT0Yy0nllH9oeFAlswImc+2CcApbCn9VCmRA66kAU9KL48U?=
 =?us-ascii?Q?dCDncz8613Fnn2T8SxLn8CGvsCeOihRfr8rBJHHv5cR79wa5VH2r+pCzt2R6?=
 =?us-ascii?Q?vokqGcgNnoyKT37Ilo4cJJLsb1kHhiWUhjK0HOO/1MxpymU7BQtqu6w2BYRn?=
 =?us-ascii?Q?d3P8fZeOloyfmcNWp31LWtn9Q5JFe5d0BHCLea6+vY15OAgERmyFjQuHkJKM?=
 =?us-ascii?Q?101sqaYE2BZKe46ZTIwVm6WO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da36f4bf-6dae-47a2-dfb1-08d97d4a20be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:52:38.2296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUkqIeOqKA85080w4y9vGbhWAjSzrCk0/IC+ipqBFMc8m6q0hdykeY/4bIWl/FmktzDbIYrbCNvcoArxKkZkUSwWxugzuZ0uLtwSn8t2VqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109210130
X-Proofpoint-GUID: B2GDzAZN0W9HzyS-2-56aco6dxrSjl4q
X-Proofpoint-ORIG-GUID: B2GDzAZN0W9HzyS-2-56aco6dxrSjl4q
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is just a prep patch. It moves the worker related fields to a new
vhost_worker struct and moves the code around to create some helpers that
will be used in the next patches.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/vhost.c | 98 ++++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h | 11 +++--
 2 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..c9a1f706989c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -263,8 +263,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->work_list);
-		wake_up_process(dev->worker);
+		llist_add(&work->node, &dev->worker->work_list);
+		wake_up_process(dev->worker->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -272,7 +272,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->work_list);
+	return dev->worker && !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -343,7 +343,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 
 static int vhost_worker(void *data)
 {
-	struct vhost_dev *dev = data;
+	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
@@ -358,7 +359,7 @@ static int vhost_worker(void *data)
 			break;
 		}
 
-		node = llist_del_all(&dev->work_list);
+		node = llist_del_all(&worker->work_list);
 		if (!node)
 			schedule();
 
@@ -368,7 +369,7 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
-			kcov_remote_start_common(dev->kcov_handle);
+			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			if (need_resched())
@@ -487,7 +488,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
-	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -579,10 +579,60 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker = dev->worker;
+
+	if (!worker)
+		return;
+
+	dev->worker = NULL;
+	WARN_ON(!llist_empty(&worker->work_list));
+	kthread_stop(worker->task);
+	kfree(worker);
+}
+
+static int vhost_worker_create(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	struct task_struct *task;
+	int ret;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return -ENOMEM;
+
+	dev->worker = worker;
+	worker->dev = dev;
+	worker->kcov_handle = kcov_common_handle();
+	init_llist_head(&worker->work_list);
+
+	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_worker;
+	}
+
+	worker->task = task;
+	wake_up_process(task); /* avoid contributing to loadavg */
+
+	ret = vhost_attach_cgroups(dev);
+	if (ret)
+		goto stop_worker;
+
+	return 0;
+
+stop_worker:
+	kthread_stop(worker->task);
+free_worker:
+	kfree(worker);
+	dev->worker = NULL;
+	return ret;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	struct task_struct *worker;
 	int err;
 
 	/* Is there an owner already? */
@@ -593,36 +643,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	vhost_attach_mm(dev);
 
-	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
-		worker = kthread_create(vhost_worker, dev,
-					"vhost-%d", current->pid);
-		if (IS_ERR(worker)) {
-			err = PTR_ERR(worker);
-			goto err_worker;
-		}
-
-		dev->worker = worker;
-		wake_up_process(worker); /* avoid contributing to loadavg */
-
-		err = vhost_attach_cgroups(dev);
+		err = vhost_worker_create(dev);
 		if (err)
-			goto err_cgroup;
+			goto err_worker;
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
 	if (err)
-		goto err_cgroup;
+		goto err_iovecs;
 
 	return 0;
-err_cgroup:
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-	}
+err_iovecs:
+	vhost_worker_free(dev);
 err_worker:
 	vhost_detach_mm(dev);
-	dev->kcov_handle = 0;
 err_mm:
 	return err;
 }
@@ -712,12 +747,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	WARN_ON(!llist_empty(&dev->work_list));
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-		dev->kcov_handle = 0;
-	}
+	vhost_worker_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 638bb640d6b4..102ce25e4e13 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,6 +25,13 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker {
+	struct task_struct	*task;
+	struct llist_head	work_list;
+	struct vhost_dev	*dev;
+	u64			kcov_handle;
+};
+
 /* Poll a file (eventfd or socket) */
 /* Note: there's nothing vhost specific about this structure. */
 struct vhost_poll {
@@ -148,8 +155,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -159,7 +165,6 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
-	u64 kcov_handle;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
