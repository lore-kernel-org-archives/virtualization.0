Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37B0C4167E
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 18:09:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BBF361034;
	Tue, 17 May 2022 18:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qjisR2LHYL_A; Tue, 17 May 2022 18:09:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DCFC9611DB;
	Tue, 17 May 2022 18:09:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FFA9C0085;
	Tue, 17 May 2022 18:09:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39C7DC007A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD3AE61113
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N1IofpYo5mTB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 048D360A84
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 18:09:09 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HHSjLa008024;
 Tue, 17 May 2022 18:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZCbNvY6u0N/8C54qI6QOW7euyjQ1+xE3pKu2nvmwvSE=;
 b=I4QkT10An9PK4uDszsnNeWFNu1LQMuHuYELIyeJPYJpCdLQj8PSbvxW2HC07AfoWfNdt
 +wzI+bOnFISSXrEGOYb+9dVUggnsvBGfawvbzw/z227azbkAMySvLbKYFSybWyG2wJBB
 WuMvtIQBrjz64h1pG6P6VApxYkZe4+DXGQuh2V4U+PRRii3YwRXL2DZTXkhwiWhaCRUI
 piymhxWJmKw1H024gV/upNKS7WyA7+Ov1I/+K98r+fFT+MUYf4t7HTbXn5Obf7B2TQwm
 yIMjSrG9y1ZvTTbY8wqSjKO0geHtNcwuU765xby6m6thvOoMSrNgQsxI1PXhoV/uJ923 WA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc6xme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:06 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24HI5VfS017126; Tue, 17 May 2022 18:09:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v359nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 18:09:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLUSFVWCXgPekxDQ9NPb1ATKiMNj/8Z4V+/60XtbyUY+iyUiTczz8M2nqU2i6PtB0FvomOKlianSAp2gIRsP0NvprYz8+yaOQTjK/lHW0LiNf4CSt1dwtAnEbD0hNHNpDOXTj/QfmRTkaRgzpblMEt5SDeCU2ya3gMYnYdVAneNl8pzumMW0GHSY00ofZ1LMMPIRVF5nZRhAhaaqoQSFFIKK3cdonzP7a+D333cS+UTkNsdVJu7NHUWkycnsO6I8ergmrCOT68XxU7BLKfRrXj8Pz69ShqqdxMIEsi8+kFQHF9Cn6lFH1X0+LH3/mmqP8f8JqXhk2qho3dmQv4O+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCbNvY6u0N/8C54qI6QOW7euyjQ1+xE3pKu2nvmwvSE=;
 b=dEOHGnsXMRddFaLawg99G2coRJZinBAHgPs11wBBKzmNCgAJeH+xOhFy+W3nBbXD5ClfnLhfNNVew5OzNdnQpOPBJF/Nk/lnI2hqZLrKbhxY4PPQVV4Kc3h8U9nOOKpeeSzpvSJP4w6QFD3nTrZ3OFaLTzUKOlOZahk9ZM+9LWVZDncFF6zvYRT/Dk9v9W8yRIKBVrURakrSlFbB+/VZiAQxyScMOdWODaZyapJMXTuOeh9EDq4HfNjjdeUo/x4wAL78WyTTJ3hRJU9QNKN/qVZLKxazsJEV9lowuyXXb4+XE4DHwg6QmJsz6Skh4wDZq5tCduOzN8C8q0RqDPvg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCbNvY6u0N/8C54qI6QOW7euyjQ1+xE3pKu2nvmwvSE=;
 b=YWoPFG2P4EJTJIASHPwBUQCUDegl3tvf6YC4OAxbdtAgPHWIvlKiVDTlzgCk0gwFfckDRVSqp4GQTSqRYt8S7F0neiGZqHAnN3A+JmcWgsaMN5mGf2VlEZEAzRjcjvH3Lxmu8dzZXLcCLVz8eAJf2bKc09TsdAFii6JDcxkQnAk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB2873.namprd10.prod.outlook.com (2603:10b6:5:63::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 18:09:01 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 18:09:01 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH V3 6/8] vhost-scsi: drop flush after vhost_dev_cleanup
Date: Tue, 17 May 2022 13:08:48 -0500
Message-Id: <20220517180850.198915-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517180850.198915-1-michael.christie@oracle.com>
References: <20220517180850.198915-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:5:60::36) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d98c8d7-60c1-4bfb-f6d6-08da38305202
X-MS-TrafficTypeDiagnostic: DM6PR10MB2873:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2873BDE86B08A35EF5E25541F1CE9@DM6PR10MB2873.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqapS0GRs8MLsxQZFjIDDLNk4hXvbSJeb7tN2TCb0D36omgRLScl3XTepWEjpz8Im2vEzW0Ew2EOkG+slTqvnVMRCESu3o42HAMShRie+HpBfkNKZfsaFkdRZ96/IZkbUuFpQf3m0hOcQ5+zBoKCoNAR6r2rPWIf6QicmklyOKPXCxZLPPiHkrtBwa7EmNUoOB5I/5MyqrNIB/8EXPSq21/k7bS0PAn30CyIOGRj+tRGf3hm0CN3OZ5zD5P2k+jtcXaHZiskXa2AWMQb4RmOWVsq3O0fQp82cjYaKdBEDgnCOLO+GFYKlJWKmXt+SaoRkCA19FlPg6fU7MsHdsIbJtnPOPAon98KKhoReTyl0vJUDYSOVufzMDOHDT5A4MvQlZLVzzauKZfdwQywfn/I/ron6VFIJoKLg1Mof5MDfsOlQbLSocDZqMs/Vwhze8G0xfgxzRt4tNAXSxMcV9jWJIv5oNq7bdFfjb8oVtIh95M9wYwIF0g0LJDmV1ojIRCRFTwTIHEL4P9grgcMEYlxcLfn6XdIud7YXqu9ljF1McnfWDQs4ev89kLGTm22CuKobII/CDl7BspjCgp/VhcYAJgdRSKshJdh/wWEsaJE0cjfrEYVONEd5J5oM1IM/rsR9r5hjSwr9RR/rtI3ahW0shwaZRf0H2wIji83oaaUdmTWPGF3/CVuuviMsoZBtmVnNymeYDhLKv3Act26yKFsbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(36756003)(5660300002)(83380400001)(6486002)(316002)(1076003)(107886003)(38100700002)(6512007)(6666004)(2906002)(6506007)(26005)(86362001)(2616005)(8676002)(66476007)(66946007)(66556008)(4326008)(8936002)(508600001)(38350700002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/2UJuAnsf2at0wqLrys7yAjSKlWK4TcPDtHLpW91JjodWHscWvXWU9cUZGMw?=
 =?us-ascii?Q?GoaUbJeIM9z3fCG1dEbOm/RfRtL0cMT0kjaL+CCz69hOjdMFFc3S+4YcuGJH?=
 =?us-ascii?Q?rl32VYHZCwVnp75rUBLaj3/Lt7mNxYaON6OjBhGKoiIOfD0jW996EnvYDO8d?=
 =?us-ascii?Q?vot7svznr2RYXTPk2m0e5L/06zQ5cN5/00enEXstzUaYd3tJmwgbm5Xmetup?=
 =?us-ascii?Q?aSJbSl7S0I7tiMrDGC4eIU//K78f4SPac/1V0fzwz68SejNmnhAccXLfiRUf?=
 =?us-ascii?Q?O3sCHm3vOhNF0WKlM2/Bavhy4BiA2EV1hDqr0wCw0lpI2QmvWWE3RX0rmddW?=
 =?us-ascii?Q?VYTE8u3zplvcrkUM/xhCN45kc9qbFSs5nV8VZVF/OMvIMauWyR1a3aNJ51OK?=
 =?us-ascii?Q?H2oQI9qiYzQ6wsR1wEXUpiiIPaLZotu22Yp38H4WqzoC+KNO1/T2Mns+jPwI?=
 =?us-ascii?Q?KFHqOIs3fvn5Y+Bffoyxr/Xau1sHhMlh+Bkf1ibJEKjo9PygzYa/qMeguv6T?=
 =?us-ascii?Q?tZxoj1ZvRuUtP9zv8deUfEGr18FJ6JCk66NPcS1n1DdCQClokwPkfij5qJHj?=
 =?us-ascii?Q?JhXV0vLkNRZRnEjiJpuAMHKDQZf7ECSsOvXXSvWMGGYuw3o2I7eWkA7hFu11?=
 =?us-ascii?Q?3sYOdQ9E6zxOJqbnKbAhAjb7DaTti+0XRxjHz79Vl+mvAA05Hp0tJUj2RL0X?=
 =?us-ascii?Q?2/WJeQrfMQRLuMTdokAfEfKV8YvbrGuLhVkf4unbADjHqKOMDBv8sJ7BF0nw?=
 =?us-ascii?Q?D1krmcHiEbMrYDmAmHyjXrdowXxBlMp6lQWBx7I+e9c1FA2k4o1HDZwevtwi?=
 =?us-ascii?Q?HhbZUzAGkFyHbuw4BYbDZtWQXqN41H36gbnWkoGySqR3+XNqNruc/qy6YPja?=
 =?us-ascii?Q?QEdYlGWBbb06kYBxOeDT+Y860viio9FnIumtGOlpIdm4I64lUKm+f/sL+HoT?=
 =?us-ascii?Q?kKbhjtpLhZhzkm9JLunp0AUyajjMWUCRk3vTkRrOEn6xoSSMikv928MdTqm+?=
 =?us-ascii?Q?qp1sA/DeKQDtaavS/mKZO2WMWHlruFgC61xVhxBCTy7Ja3GIHSly8VlR05Sh?=
 =?us-ascii?Q?3a+zOjHSs58NxXjPx6wi8AB/2/dMCePtSYnUUx4XNQHerFn1Y/2ceHA4esID?=
 =?us-ascii?Q?9SZC4UPqWgTtkz56aOD9Zsf4VK9MUxaNQEnt1KdRo9xDzKsADpsmJvwg2vZ3?=
 =?us-ascii?Q?CWBtixPMbGp2fVguxg+c0ylsXOYYnQl/CQ0ngL6pMUf9eNPC69mcYXcrxwR1?=
 =?us-ascii?Q?NaqNvqO/Ucb9QmcSTd7tqRzHLtxgtOCZE5FJ0ki2FtCowqtuMeiB5sMcbtwd?=
 =?us-ascii?Q?Va8KXFluMYycFv1puCl9B1LW1ABQZWTx+CDJLkERG8mQN9vFRg6EqYjRW1C0?=
 =?us-ascii?Q?3QjJEYKUJNrv2kDPVzA4tP8SmpqccO9v6WXMHQlKqq45uvNweWtwmTjWNXHI?=
 =?us-ascii?Q?H36YQ7UAC2bhcISePYSlZPPuWadIWQk0/vIaM2VGr7d2BKkQpFDL9Fwq73K5?=
 =?us-ascii?Q?UY8kdaQpjbnGbs9xCmQqfH/oHzBUn2UHDqAOZw0odcIKoFRYbpPhlDdUJ2a3?=
 =?us-ascii?Q?jx95nKNmiL0xOsmXBHRQAISZnBMpELdCtB9v4fjIerkWagBj+Wt8bLk/iSuG?=
 =?us-ascii?Q?06N3YdqAdfOVLX1iKIeA9OVE1UxRfLSpxPdaYdsrlmkdaSUr5jeq+LAp1ymz?=
 =?us-ascii?Q?FvSt+j0TD3fvVASBDAHLK8vdhGzZ2gUr1la7td/yHjixN0/KIhBJVvya3At4?=
 =?us-ascii?Q?3Iv7pmjmvSCmXoCqDga2//yIwOOVSgU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d98c8d7-60c1-4bfb-f6d6-08da38305202
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 18:09:01.2951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOlDrXHjFuMZK0ikUjNV8MKKhnOtRYHczCFLL4MkuVLVKACSiNeAN+Rml4A6nGxHBkQuSLFf8eFtGUbocuy96z78xMkxbdRGKzsGQ0jRstg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2873
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205170107
X-Proofpoint-GUID: RuRXpdNTse5LbZGOTk8ER76VgUYqe4p_
X-Proofpoint-ORIG-GUID: RuRXpdNTse5LbZGOTk8ER76VgUYqe4p_
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

The flush after vhost_dev_cleanup is not needed because:

1. It doesn't do anything. vhost_dev_cleanup will stop the worker thread
so the flush call will just return since the worker has not device.

2. It's not needed for the re-queue case. vhost_scsi_evt_handle_kick grabs
the mutex and if the backend is NULL will return without queueing a work.
vhost_scsi_clear_endpoint will set the backend to NULL under the vq->mutex
then drops the mutex and does a flush. So we know when
vhost_scsi_clear_endpoint has dropped the mutex after clearing the backend
no evt related work will be able to requeue. The flush would then make sure
any queued evts are run and return.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/scsi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 532e204f2b1b..94535c813ef7 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1827,8 +1827,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	vhost_scsi_clear_endpoint(vs, &t);
 	vhost_dev_stop(&vs->dev);
 	vhost_dev_cleanup(&vs->dev);
-	/* Jobs can re-queue themselves in evt kick handler. Do extra flush. */
-	vhost_scsi_flush(vs);
 	kfree(vs->dev.vqs);
 	kvfree(vs);
 	return 0;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
