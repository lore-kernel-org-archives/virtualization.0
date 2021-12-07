Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5766FC433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 02:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3A4660E55;
	Tue,  7 Dec 2021 02:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E6fhNxGjqyeJ; Tue,  7 Dec 2021 02:45:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6A3B760E5A;
	Tue,  7 Dec 2021 02:45:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 472ABC0075;
	Tue,  7 Dec 2021 02:45:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21861C0073
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55EC841C77
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ztyVj2Ti";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="dGZEGK9C"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fEUy66LChRIc
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82ED741C6C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 02:45:26 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5Vqi007608; 
 Tue, 7 Dec 2021 02:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=nFfjrtQ7/XdSCxWsHV0CFQy/6KuGBFBgA5UH0N/duPg=;
 b=ztyVj2Ti7jqdDl14cQwYlH3AY2hzHC2OuiAE9iCqz/NZe+3j7A3f31cgutBD7jncgsFJ
 RYiXQVPk3CovczhTNRbB6irmHBNnv7mtuMNAsNC5snaZZMCu5Ttje4s02LzeoTNkP/Ts
 4s/xPqRYJtRcxO9rN7y0dearL114Wh8k8Vo3STtE5AJyA8lH7KPaP3QzBuEQEdSVgV+p
 yLzm/ehstl6w/5ChbRylY2YZ+oAre1mckZpz/4QTZ2h7zQ8B1UTwYJbOIm1J1f2iMpjg
 KjaraKzlOhDZBf3KIcch9dyb/RIzoIO8dS7xeu0EQFTmJoGvtPbJLSv8Bffj1q9kUs2m Iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csd2ybuw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B72bJeq124653;
 Tue, 7 Dec 2021 02:45:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by aserp3030.oracle.com with ESMTP id 3csc4snh1a-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 02:45:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1eSFi/QN5S2ijqf6mzDu9mI7sHWp+Bod5KMfyJMV1xQe5CW1S4os1un8mLLWXdi8vSjBZy1Ae/bXolOfKmmxhXOuA87LApvtMYh0DmVCTXqOfXPXa2WR0LNDhP3D59p5CJIqY5q1eJ4NPTXSr+7FPvtQpVZb9jpDtA/fMlmw3Cdtqgm9yS4B53qVlM/cAADQlvRWkSrjhrKYnWAVrxCAAX0Cg5T8rVactFR1m3FnBberlzIgrIZ4FmPIJm/Il1VoGGZz7CgNFEcqRBjQPljtUkgU5KNebQ8sFUMerPK2WDQfUpfUum2ROhIMxxzQ0T6tR84d4sGTi5qUP+aWykvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFfjrtQ7/XdSCxWsHV0CFQy/6KuGBFBgA5UH0N/duPg=;
 b=hGysiJss7pghV+h0h9+EccARDv2eaDHk7cyxIurtgqtmUupwsghjZjSssstPNqb48oEWMR8Ma6xxaD57pbFS/84U19YCmfKIY/QoGN810CXc5Tn7edG7rCK0aasiHW16hQ6U24Yt3c1gjRH++z4ZR6qrk4mBY28pfms5FcM5+8kYrY2/DcTibIe+sS+dTtj04HVX85IB6lSz/qocRhy/oFRH6FzTVprNchuud3BE/ADpuDjnTFbdM5zCMYSW6BRJCvPuBwpIA9DfQzaCYeGvcuYrLCwMMfz99IRFGQwUZyIp2jXkymr93Ml8gapgYDukwCXQxGFS5MtsLHY8/m/bKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFfjrtQ7/XdSCxWsHV0CFQy/6KuGBFBgA5UH0N/duPg=;
 b=dGZEGK9CJEnpAes59dU9XQNTYVHoFxvzUWJhnfT0uqZMA6s6Vr2g44xe53eCa8Ht65HuqO7v6oZgRJuIWAtgtuw8GUG9Ez2VqW0rDUPCdx2MaKMapf7EhquVDs53DKcrHJ94zLCtc6nKD9YAGEjNEQ/HbCUHpKGVJgZ2/63b/fU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Tue, 7 Dec 2021 02:45:21 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:45:21 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 arbn@yandex-team.com
Subject: [PATCH 6/7] vhost-scsi: drop flush after vhost_dev_cleanup
Date: Mon,  6 Dec 2021 20:45:09 -0600
Message-Id: <20211207024510.23292-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207024510.23292-1-michael.christie@oracle.com>
References: <20211207024510.23292-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM6PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::39) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Tue, 7 Dec 2021 02:45:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7815fa93-df26-49bd-d76a-08d9b92b9ca0
X-MS-TrafficTypeDiagnostic: DM6PR10MB4347:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB43472AB0F49A0C3D7675822DF16E9@DM6PR10MB4347.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcHc4/lA0o1uTCC6bPMRBfQFklYPP3LUtYcmvqiLZCk2Ubp3UedNx5qCGU7RUhVGQdglADKEdZZkL8Bh7MeaBaX+MSoG/cEQs7tlcDEZSwBRGJC6HM38MaqrEe4QPdOFGdFFvKBhPckiYyQNOKrEoIa2xioAkBygZFa66cRgFIpTpfMNkIj3GvxMt/+jwUl36T0RJW4eVSlH0OTEtDecFPvtdoZgmYzqiCc5Ddqwfjxzvs/pAo0gMYEEiKEyEdkv1rf8rSfYp9IS1o79oZmHTPRRTCma55q9PWhL0JM0Dtw5OKSuXMS7qU15maG/YoOWopcnCPQw0VrNXOPzOg4ohAWZSTCsjYIWWAvqkgoegOSH+wOuiBVXc1yltzOujARQeVji5HWFhFiq+RrkbFx1ZKfKoWSYraGQBmy/L/uWSk8tSAN97lEAlTa0oSgGfLjj8p5CMkK0e3tBT98blvcfRJe6YqrahWRD+gmsWOg0NRHENvDKEG8Sk3KsmzWXpLNTAvxnUzgTPc4NImiqqcmm2A6UO4JRD+EEzLkw3WS2kyxbU280H7hFBxPyDB9cUUo0QUWTOPmel75eYyAREKZYE+4sUACGZl7d5/oViTj+BYwjxLqt8FLez5Jdt1g2xJBOielRKYoBS6CKe3Hau+bob9ABMzosTIjmet+5oCE4NBVLABBkOQOa9SgLyX3EDcrKye7tdGIAoBjVVEvuVt3+4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(316002)(36756003)(8936002)(38350700002)(38100700002)(26005)(8676002)(186003)(6666004)(66476007)(66556008)(66946007)(83380400001)(4326008)(1076003)(2616005)(6486002)(956004)(52116002)(107886003)(5660300002)(6512007)(86362001)(508600001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VOc97O+uJ8muPnFwbj4GycCvWi/JT75s8ikiNN2Q+ZhjjipGlI4sU3sfnVAQ?=
 =?us-ascii?Q?Cmd7aw9uvyZmVA3S/ARvB2awUT3iSC8KnItko0weh/Gkl+qSiyOiKfQyB3gJ?=
 =?us-ascii?Q?LQ3nLfxFEA3aCn3JXAbBAQ2LhjUtmSdSACZhfWoc/poOkZlG5E1FIL4t7lld?=
 =?us-ascii?Q?sU74LVfKCyVupt08tyklHUz3pqH27G/tb5ezabSiij06R89crxZiAk3QYBcA?=
 =?us-ascii?Q?7p9RK3jwW6Lgu2xvZWFpZfbkDMtceP8zxbidwCvOOqZx32tc8jjrluE8Z8/6?=
 =?us-ascii?Q?ATz0Avsx1ihokZSwZVRF+1CRt22KF9WHcKbin+EcMORLHIR6b3vVhvaATt2N?=
 =?us-ascii?Q?uWkVzhffJI/r/rXCvZ2H/B6tgpZ4rEYmB7yE9CP18iCzpX9lBkb4u1IwDlml?=
 =?us-ascii?Q?F/2ytPhjjocQqQx6K6TWuQ3qeK/Z1zqe/LFcZ7xIwucdYJ8GVxeKqbmBd4Uz?=
 =?us-ascii?Q?hWiL2q1mkp1zfSy/iFu3krzGFYZkw8XlaE0gAgYspHGwC1XXJk6YWsXO8JqJ?=
 =?us-ascii?Q?KjDNWYW+xK3eBzF7rXl3JhLHEwSKGR21TP7sG3/GbZQCyZVgj/nvAafQuLvI?=
 =?us-ascii?Q?VbYXYfCZh120M3gb969aWPMaDREpxCKZFloy8eRoEsetXP5VstwTMpdk2y4e?=
 =?us-ascii?Q?ZQd3ooyHkU/19OJFVhvxaV0LKL4sQEg2xPkjnZlIjcrKAxjltY/vnMywwC14?=
 =?us-ascii?Q?cX592lT6DDptMaXDNFUXESCqrc3i8yX49sA4Qc+nw99Qt/ziS7RMNKz4u1oj?=
 =?us-ascii?Q?TpH1GpOikHchsL+TlHHKCdyVXxLCSgUqp8oKjFo6B5uJwQmCOh9lpLu05v21?=
 =?us-ascii?Q?s5sJQ87j16ICWbQAI56yQHMSazI5cZvP3aiwVdpi3T4c3bkr8NiDzsmk0Eba?=
 =?us-ascii?Q?EEG+cXZcxq0xlFR7IfyXzWzLmcL4TMjtHl31Mg2LF/C1Apc6+vq/n3V97hcf?=
 =?us-ascii?Q?GjZt8Pfafgu4wIXI0LIzb+7Jrz2NU2yRh9Yoy+9vvHt58JnwsGERtTFuolBh?=
 =?us-ascii?Q?EezR7JGaRwPjJoUjraJP5gyInGW42fbdWxYKKTGhMCc1V4ovTbB8p46Se8WK?=
 =?us-ascii?Q?Prd3fdUv/Ybk/ZOE5P2Dvz5AE4qgLz2jxik3gseiOy3PQxtfAp3N7LSeUyQE?=
 =?us-ascii?Q?q22XgSkIEreCjjc5iLKVN+2pu1s22kkOZnaZrjtyBvQCWiSbGpGbjyHv/AOj?=
 =?us-ascii?Q?HwyrunUtyjyBL3UbniW2so8vZKWCmOnqZ9m+7VfPKMliJD+EsVvCTEhfQKKa?=
 =?us-ascii?Q?i6YipMyY0vNaoKxvEamZa6ECXWpB/dVLtemNtK5PT6q2tLGHTWUaXlic1zQS?=
 =?us-ascii?Q?weDO0cVTA2kxKt/KnONsx0yoV8tL2H0DikA0128ewgnJOJ1PX22Ql0ci+MJH?=
 =?us-ascii?Q?zTBetwYp2+gTahGd2DvzKbNyIteDXbicfBDxLAi/uaLRZGbP6enzbAmavNQ0?=
 =?us-ascii?Q?+6rcPpcC22E5F8mGfQw+lPG8rqGh1rbCb07aoqSlQqiXf0BonajY+9gcB/Ch?=
 =?us-ascii?Q?7f+CaQVMrtcb0diH9SX3o0XBeNgnfTNH6x3HKXH5IQiFtw15XxDJTQsnJ7C0?=
 =?us-ascii?Q?iThF9Um2WmCDZjogTZld378oPS87xi2dE/DEpm8G3Fqcm7hdS/hzNveLHfKS?=
 =?us-ascii?Q?EtU0SitZS8Qgw55YjYgJ77JGWhMCwNQOPbR2/EIkeOYFaOhNjoQMN0bQ9sY0?=
 =?us-ascii?Q?I4W2LA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7815fa93-df26-49bd-d76a-08d9b92b9ca0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 02:45:21.3554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+aN4LNyB+d3SXi5iJLaBMH7FOsr+sQzIu7qM3+Ca7BmyLJ/fN5GeVmhoHJ9hT44aM8N0BVMrm173qOUVCV/WUd7jXwXVasaaFbUuMKZqUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4347
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070015
X-Proofpoint-GUID: sCgdHHEknjP4TSAQQnIKptZyvF9v3R38
X-Proofpoint-ORIG-GUID: sCgdHHEknjP4TSAQQnIKptZyvF9v3R38
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
