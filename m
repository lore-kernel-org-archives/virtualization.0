Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA72C433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A0960FDA
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24A0960FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C9AA40401;
	Tue, 21 Sep 2021 21:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xd9VGwJTvMyO; Tue, 21 Sep 2021 21:53:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 94B6740433;
	Tue, 21 Sep 2021 21:53:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B164C001C;
	Tue, 21 Sep 2021 21:53:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97B94C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A4C560839
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="vGdIxXcQ";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="WaAqs2Xw"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LvLYcwlFDC2M
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3EEF60832
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:01 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLEEea013587; 
 Tue, 21 Sep 2021 21:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=grzrkheUf/AUTax6MwLoWRaJA0vx9VV75WXR4SB9qdg=;
 b=vGdIxXcQwBHZthoAi8ONqfnBLP1/oHaMHZgBpGwreSIzgc1DnY0ADl+Kyz++ogEEvs6Z
 aCveL1iS1SNNUKnQ4zeKDPxwng1ID8NwIp0njJBRnBnQKuFV4Gk0YYr8s3ZG+CRPAHSS
 7L+xl5EHOmib4aHxKYLv90K1aINQCYxMiDxiksid+IMWRbYAlVi3d64TKWDizsmTnR5W
 4QKPEykSD8CgmMuyHtWhafzjkmuFQ6mqhT6m1LE4rFF08gOHs8iG/iXf3SCiSZK2oTAk
 /bnp+B3D4LmETrg9H+LoFzU06zKFE+I9iXZvmM+FYzJlBYJQF4yuxeqS+gKkmn2EEyGJ iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4s04xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LLomVf154016;
 Tue, 21 Sep 2021 21:52:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by aserp3020.oracle.com with ESMTP id 3b7q59s7my-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er4+0h0mu3ohXHJreX2InOYC156Z58kGAy67pNm7FtNLKktqI2002s65fGkIBsJI33ba9MiZiyUOtCkfTUioLlxh+gbV3zTzg8MHyQ3hKaKBNjCxDrYwnCLVkvh4jRI76sdNeQHdc/0FsVrjiDKU2wkTuDLL3IlzRHHji4lJn8tg9rz39NylJyvkihqlQHbtGlc1jA4YUK/xGCUMwKC5SbfHLGgDvdYT75rrfGrzD1LiJZ6CjGkavCxRnew1reb0lhvJIaODrmD0AeUrkd/pY+6C0rgWpV5MqqZRapU73kYwr6JAUOgA1VihHlRzVjk4g9GPzLczFNRi2NpGOrqc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=grzrkheUf/AUTax6MwLoWRaJA0vx9VV75WXR4SB9qdg=;
 b=R+z8dTOCAyfKvugPh5VZkQO0erJlfpujwvjqI5/dBs+VGfv+nRbkIRvQv2pdmgzzl20dnmKTjTs/Oa75LWJKFUJhTgePRuR9d0isXvGROLEWJCD65k271qcDwMBar/DlVtcIWx+XZ3v/kT6RzW1MvcVRd7511/EgounLu4RC7NI/avnWop8SsuX662Op+BdNioDzW+cSm0siZTsz3laWup3itAVIh2h4b6kxmX3n5odiFSp06duY7XEwUZ1qx3DKvdx5bg5wtmC1aifK2AZkdb2IujMoqcJW6w8pxJs4o9m9ENLydlTjYidRZRJURAZISiOs90gwbkM/tsFxI+F9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grzrkheUf/AUTax6MwLoWRaJA0vx9VV75WXR4SB9qdg=;
 b=WaAqs2XwCunEFis9/dzN+Ur8WGxekrn19LFhSmyUr5v627jUvpxQNoJGgC6Tavxy4teiRV/xpxb/k9e0dqHhbZR5gByh7fyFpiqikSykLF5rVyKb0dVUgEYrF3WjnKgf8+wBnStOAnudXbzgU62G2DJvPrh69wKCjLcdF4l74Ak=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3892.namprd10.prod.outlook.com (2603:10b6:a03:1fb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 21:52:33 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 21:52:33 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/9] fork: add option to not clone or dup files
Date: Tue, 21 Sep 2021 16:52:13 -0500
Message-Id: <20210921215218.89844-5-michael.christie@oracle.com>
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
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 21:52:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 522ab1ab-8f8b-4131-662d-08d97d4a1dc0
X-MS-TrafficTypeDiagnostic: BY5PR10MB3892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB38924B77B538EAD3BE8D32C5F1A19@BY5PR10MB3892.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWW17t885MZfU+f5yricMEvlytVqjgWbpUYMtC11W1MxP/v8vp5Yd4RYSq2c/0NHf0JdroQnGGj7CJhpifU8dyexrEDZ4V4Ggo9OTYiTvJNnMSMlBG8+EF4eR+8rFOGgd4UKAko1kmBQq6VeQAHa+XQlM35OLYqKtm0vVruJ3sBzYvQh7QVk5TGUa8f4jtJJ/Oua7+taofn90E2gOkpPNik8X9wIPEArSV2SmWUppYuWmXswK5DMeayuLDfis3aPxZ7oYfkze0LMGyP6Stk+M8/3c42j4h8EJ8hmy1+v9jmEe/zx80oZOMbvomAUuzThXWY57bR+iQXBtn8tbmu62JFBSCmz3RMd7/wKdjLTBUnzruV3onpoqjD5DnjyZ0Ul2KlWJwNq/EUSh+5HJDYerG7UbaJWtdZ2UDfQnxAbg8a3SWCoEUTSOAMsIE3OFainpdDa7JRgDHP1x9uYQo85bF7fu0oxVSvjRHO5lDBKwsEdQxAJAoECiDhLvRVZhK2I+HPeMnZAMy3ZamMgcAjqU3tcjkf/ifOKTVxm8RunT1jgYcHR4FRiqdVjzoloN0L8HD5/PZyRep52qt7v9hXXt1IgWfLJNnTCRGbQ44h1t1HCKLstQSlpaTmDgqkahrrrwgLhPvePabOjEms69/oiqhe676o7PsA+Jmzk6Fxrc/XhJpDmBiM/vwbBTzhx+qLe9ExWq1VHV+qLjYTVg+JZ3gexd+1OUhQr5X38qCcj3aI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(52116002)(107886003)(956004)(66946007)(26005)(4326008)(7416002)(66556008)(2616005)(66476007)(86362001)(6486002)(8676002)(6666004)(508600001)(316002)(2906002)(6512007)(8936002)(38100700002)(1076003)(5660300002)(83380400001)(186003)(38350700002)(921005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/HHjmEW4e6QMHl0tfu0ScS7ASz+saGWsbFMVcQlpRtTy3r/v4h0V4vo9FZzX?=
 =?us-ascii?Q?T56zG+qmgDBC9Wj/SWXXxEg4KSYlHUO+pRA8sWRrZhl/wfK+6in6STbRSo+y?=
 =?us-ascii?Q?wiKzJ5JAfRgwz38wayS8OWNTqFbbwDvBsrgVnY6cJ8fCicC2/01y6sI0qWXT?=
 =?us-ascii?Q?fNnJZiDv5hGu6Pdt6HCrzb6S4RgbutaqHrPB7SmCK3eonW/fHofilZ6dr7Po?=
 =?us-ascii?Q?UPC2V8x+ut6WUqrracgV/HAl/3QoMhQ6EAISjJj7megHpGKPfu3PqeYrj6V8?=
 =?us-ascii?Q?n0yvTGQrpQizZxgXyCXM3Ll0ywrb2TgLj6C1T7xl3/PVG2nJqxlV3tGwV/xZ?=
 =?us-ascii?Q?T0fUeh6dz4oWSmrRcQmNNomfFQHYw6bCvb5D1qzb2hl75WJbUNE6jgHovLaQ?=
 =?us-ascii?Q?GFtSgnekzmrab+amHoapUh8N6sG3+8V/A+CikShWIqW1lmYsPWxgVW+EkhQT?=
 =?us-ascii?Q?VHniUFxWqT0Jq1qV3i7dAxcOsjiXpY4acg08uNsF1MNMuR+ykqZmmRRSVjeq?=
 =?us-ascii?Q?RZJaW4puATb0SYnAvrorLeod8SNYwQy++wphZGdMkfY+hc1aD5unlt74Tqry?=
 =?us-ascii?Q?jU2JgHCL3SXRqFlme5cndFZreVGKLhYs2eLFPv2HUXbtFRjt4woFhnyFBukB?=
 =?us-ascii?Q?g0bMpzI7U4km2sq6yoBEbcpvZLCgxuAjTjZyRACNBVZBharTv2aDujW0xTE4?=
 =?us-ascii?Q?OL4IPao5I7rqKUYP3JrJf4U7Z2kpvWcnkpLJv4mzJVG7YLEyQM6b+pXi9LWg?=
 =?us-ascii?Q?vIPXcxr1Y1AZHyftsVYKbUm67cLz03OVmKuj8xaAM9KGtdTuJsdce2Hpy+8t?=
 =?us-ascii?Q?/CE950xuvGe/MdI3yrVNzFxzdZxuI/rJkCOXXDz/Wu16rRTh125Wdg6b5kU1?=
 =?us-ascii?Q?MImkByWDSV5sBIS/rfgV/wPgJAr/vUlo4J709oFJz4M3VrAFL/MD3icEW3hk?=
 =?us-ascii?Q?cexmvOfsJK6iedrC8eg5Lgoh3ots+nVaBL9JPMNetBK4pINDzPIoGwynJRIL?=
 =?us-ascii?Q?4mmZt0FjTaaSvQfHXZWjhvLy1BYeZ2cKqvofiIp/llRkoKY3NL5V+ZEQa8Yg?=
 =?us-ascii?Q?oqWEEo53aedlb1Ci8jd5Q6x6ttkWu57N30VGos8a4NMwLAtevlydFAKvnCdZ?=
 =?us-ascii?Q?vQzjb38fwYpFwqUeMuk6VclQ12t/D/iXHoPea5gHbvUItii0VaPR9WAJAcIA?=
 =?us-ascii?Q?meKoITrPLFNsGbq/WAfUXPscbL7VzowTvlDDveLRJvuPJOFhAW7nzZdQ2A2Q?=
 =?us-ascii?Q?H22Q6bshPdKIh7DuIsumbio61UwdH5EfYpBPMmCqsIAKYjbA5SxkXlzlKH5c?=
 =?us-ascii?Q?ygXdb641is6ZAORwH6HgIz5+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522ab1ab-8f8b-4131-662d-08d97d4a1dc0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:52:33.1525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmCIvL0nysQSH7Mc9Yuwp+XTMXac8gMMoI1Y5jgtpo/QKWP04hpChtCSseKFucSvri1FFMnyjzaNxwtaorjDiInhpIMS+VYpN3YQbsWcQXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109210130
X-Proofpoint-GUID: sjf9ewVuIzLs4ohUMjrlSPh_dOHpDvgp
X-Proofpoint-ORIG-GUID: sjf9ewVuIzLs4ohUMjrlSPh_dOHpDvgp
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

Each vhost device gets a thread that is used to perform IO and management
operations. Instead of a thread that is accessing a device, the thread is
part of the device, so when it calls the kernel_worker() function added in
the next patch we can't dup or clone the parent's files/FDS because it would
do an extra increment on ourself.

Later, when we do:

Qemu process exits:
        do_exit -> exit_files -> put_files_struct -> close_files

we would leak the device's resources because of that extra refcount
on the fd or file_struct.

This patch adds a no_files option so these worker threads can prevent
taking an extra refcount on themselves.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h |  1 +
 kernel/fork.c              | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index cf7c9fffc839..e165cc67fd3c 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -20,6 +20,7 @@ struct css_set;
 
 #define KERN_WORKER_IO		BIT(0)
 #define KERN_WORKER_USER	BIT(1)
+#define KERN_WORKER_NO_FILES	BIT(2)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 4b0e8257993b..98264cf1d6a6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1532,7 +1532,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
 	return 0;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
+static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
+		      int no_files)
 {
 	struct files_struct *oldf, *newf;
 	int error = 0;
@@ -1544,6 +1545,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
 	if (!oldf)
 		goto out;
 
+	if (no_files) {
+		tsk->files = NULL;
+		goto out;
+	}
+
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
 		goto out;
@@ -2179,7 +2185,8 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_semundo(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_security;
-	retval = copy_files(clone_flags, p);
+	retval = copy_files(clone_flags, p,
+			    args->worker_flags & KERN_WORKER_NO_FILES);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
