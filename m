Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B821C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FF961264
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 19:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38FF961264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19CBC83C55;
	Mon,  4 Oct 2021 19:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fxYASW7pSbIC; Mon,  4 Oct 2021 19:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7869083C51;
	Mon,  4 Oct 2021 19:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62235C0011;
	Mon,  4 Oct 2021 19:22:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BD54C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DC45405AF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="zDnH1Ke+";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="nwaLorn6"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GckxnJXGgQIU
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68FDC405B1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:22:16 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194JD1aU029400; 
 Mon, 4 Oct 2021 19:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=qLItirQ7QSOZa72340ploNQ0S2V4Fkh8wiSn/GkVRDo=;
 b=zDnH1Ke+q79roebJ/ZUURUEIZASe23CFH7HXmlNGG/EIU9gYPWsSS/gSxQekxRCCNCWJ
 +bUiWRQSz4u+uVkTIDZm6G3Lhn+/WWBWVue/SrMC7G2w6GVHqGJwygxg8qHyEssNTO9P
 TnLAIT+i5Y2PDYkxxf8jVSQWNTbC+LPBApNNYHfDiIphBB6KouL9X8ehyvqg/+ZHifGE
 B0gNxz7Bqq+2dsK5xVYQu7mYNE2TYfMq2O7FwD/6MrUKQyMzMX94cTLoozBwrOfWQ+C3
 oREYexPJkSwjYcvGNALLek/L1WQjB8DDuJrwH3MY9AfGFNAL4j7zW5uDPXYFI8oPkyuk fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kj161-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194JAbkt095280;
 Mon, 4 Oct 2021 19:21:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
 by userp3030.oracle.com with ESMTP id 3bf0s5c7jr-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Oct 2021 19:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzJYXZ8Bg3+6PNk2QK23vF/EDlHwa5lskeumhFzSU50yMg/wOfKc2ix+97FQ/aXwbZt24gtYjDsSc+BSiRykfMtkNjb1Jjcp0flpC7PvPZI+Velg7eqHyeYdLy9Yg6AIk6OQK2xt2VaZ/WtHa0rgl2UFHLGxm0l/qLFOlMM8dbGSDlSseb4sk8/hySkDtyPmNG9EM8BHRBTNyJQqhIHfyDTBa/I4EhzKeNYoKpLz9vNGXfjsFz3uj25uDwUR8iBoaJ+Q43fe8IqJdnzEbAPk5n023qByumJeF2SIiyz7DYNbDNYY9kMmFLzR9NgPMo07hD2vLnz6QyYh5RMRo5mU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLItirQ7QSOZa72340ploNQ0S2V4Fkh8wiSn/GkVRDo=;
 b=KhUGV3BL3pHmyLilvgGoXm1ROPwHBez6YFSzTwgLDgx4cBDzj5uxadb4rAcPFRDnJZSBJMdIxG1maA5KdSwMshLhNNDx/CY5Qpe6RISkFSWTJB6lZ2Jn+HTlw4HWQ1X+E7duVDw1KgS+N/wcd7JEVs4eBPkt2BPZ9/N7lhXNfK+9B8c6pMvcgFvELROqhn/JfhfkWwZDQjwaM4bWnGi0JTEQkcEBz55T+XzCjbtSgIzxfwQeDoF6XA6WNyhabZekVxbymQULaNwW5ZWMt/radkfbP3KH7gROknVI6KAWC3mrmCrjRXFJRjhMD4O6FwowxZYJjrXop3rEbeYKCAtiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLItirQ7QSOZa72340ploNQ0S2V4Fkh8wiSn/GkVRDo=;
 b=nwaLorn6f6bIPkQqB10mmmQvONjc09ECuzHMocBnBr7gnSXKue/50HohUvEgCUM8o0NwKMBJcL3leIqdxkVo8dlam9cP0hWxdIMotqkg4KjePYCMFyT4AxGA26Tt5OIzGGKGm/M7Vvu9+uQagesogJ6qJYwJyORUstQHRvXBYkM=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1548.namprd10.prod.outlook.com (2603:10b6:3:13::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Mon, 4 Oct 2021 19:21:44 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:21:44 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V3 9/9] vhost: use kernel_worker to check RLIMITs and inherit
 v2 cgroups
Date: Mon,  4 Oct 2021 14:21:28 -0500
Message-Id: <20211004192128.381453-10-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004192128.381453-1-michael.christie@oracle.com>
References: <20211004192128.381453-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR15CA0034.namprd15.prod.outlook.com
 (2603:10b6:4:4b::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:4:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Mon, 4 Oct 2021 19:21:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 296a1422-1bef-4e0b-c6cd-08d9876c3352
X-MS-TrafficTypeDiagnostic: DM5PR10MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB15487F3BDD2AC35F246DF0D9F1AE9@DM5PR10MB1548.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7bwS+VgAn4GqEIyyFH6/1Oxcs4x7A5dIha4+K1ZgWkdnNKDRD36T4q+MVb0JqB2Q+qoURCGn2daQ3gC1Htxj4KZaHpFP7L1GP5NB9rkhiwTcg1cCc9DkOYR86cJhuvn9MeQIAZ3JZF2HwCrSqYu7qthChDzjA6gFTxjyerpgPBoZZrq6Qyl3RPxWNGirvuQ8L/FPt6kn4veya+oi1360mEbbcH10b1yrsbKXOiPxSDxzqy8JhXwwRKqKTNEKOpIAkFZvF5GgqrPaLDYq/HOwePCoslsAdaiywx7trZVc9TLxnig2/FVH5rkGz90YxKopQgZ15HOAE5ui+8SxN6g3CtG9Z30Vsz1sSl5xbC6hBNSIBIk1244WGnqR1YKAqKCR1pkSC+xjPkYCjIscive5jr8JxaRntI6mPSvMM66eZGJwwykEo30NLGCfgteQ67DKZJfZGfcwLyOWlbEMS3nmGvJO3gj/wwNMHkreMW3pyxoOhTDaaw7uetPCUdoXQY59bFqZsALyFrbv8swWceURWMYcOBljzZ6Fg2ThuN9BAGRkHZoCTSrzfvdRnkknfWicA7hTzd9X1B64POgsY4g99w5y46mJxjoVr8sOBkmpGBxZ0BohHHqCi+DnGCU6xHKxnNzW0zI6yywrsh2xNGIDV3k5RIIKHLRYd0HKHk/IfiKlbXE4TtiZehYvbgJGu2Ltq6Xp+qzdxpmSJMsd6qp1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(83380400001)(8676002)(921005)(7416002)(186003)(38100700002)(38350700002)(6506007)(8936002)(4326008)(26005)(508600001)(2906002)(6512007)(6666004)(86362001)(316002)(52116002)(1076003)(36756003)(66476007)(66556008)(66946007)(107886003)(2616005)(956004)(6486002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WvDzvoGjVbQsD/9JmxAJ1/wPJ68Zp0bIYKxpYNoRwH4cog/jK1xVNKKJv5uG?=
 =?us-ascii?Q?mRur110+Nm/JI48oxB3mbZIicnVsW6soCrZiW3aXhwu1gLrUktYN3CD5Ag99?=
 =?us-ascii?Q?omxLdOsRxMTrf3cBit47umHFO1kLyLspeZdrwVVxc88PnPPxXgzbqI0+LkXm?=
 =?us-ascii?Q?9griTFhI4QduUKT4ucTe7lkO/B5x6KtxkQ7lxTzw1DxM0Fc7qOc13k35DCTZ?=
 =?us-ascii?Q?2LGTLJf8DdHdji4sVE7ygTeLF6C4FcEuWiQWvYYLqvyQx2zSo4s+VV5lthmj?=
 =?us-ascii?Q?Cd6otc3yHcPRpk6vb1gIGpKy4JZlfuG4g2KN2g2jOg+13gnz3EExUYfdu+46?=
 =?us-ascii?Q?V9k/7nWMqXxfhcA0qvdQU9UPrSMiZbUpu7ALC3FDOMx+8xZmQi7J23osDsu+?=
 =?us-ascii?Q?S691r9kLAEYHsDOWNMgJDI5HOgwjeOicOzjSwxu+3Qfjb8bAc0pL03WSf/nD?=
 =?us-ascii?Q?n/Nt9+xhlLORpFnxALB9n7HhKXwqbEW1gFGTYeglkZzb4UlLa/LpKLF7gSeo?=
 =?us-ascii?Q?4h5QTHnAmVypkae22/SCseL/rvfOiLKGGY0EGSe6qYpZivjJHy1MQtuQRMt7?=
 =?us-ascii?Q?FcB+4xWv14kx+dqR9xPKzU9rrMOXS4mtl7A+wI++VBj3/gtOvOLk0FZpL8c+?=
 =?us-ascii?Q?S7kmDEeZyWjHsl+AZZaVP2hOUuFK6MWuB53dfxE3TuY3tnYOteLPIQrLWn5A?=
 =?us-ascii?Q?PeeE1Pi0VW6BK0qi6COxA9QCb34tttEPpCHlZNhrqJzzvUdJqe9FRL6OaBul?=
 =?us-ascii?Q?s8NfbYWZDbxreozWCnuP94mX5/Oz8ivJOjUkQZ1xWHjmu9f1D+FPqFmTnbXw?=
 =?us-ascii?Q?lBuBrsJnJVnbtLmKVNSmkeSx3hBdls2tKjCbjhecVmYSun1QDS8Z2xIYv602?=
 =?us-ascii?Q?EFN7u4Wowa98zvy00FSMKI5tn8cthGavrcXnBeZ6D6xzbDIDIv8+0hDtiU3F?=
 =?us-ascii?Q?w4tljqJfiM/7BMWBfgeyVJJxnDSBuHjPzm4uvQGG14MdHROW6jYt5juRqRM8?=
 =?us-ascii?Q?CUd71M1H8+B4A/KEYeoTHrPmSiwg7t/dAzFNQ6ftclFOAJLIcHZOnT8VMmFj?=
 =?us-ascii?Q?bXApyk3gDEVnEHMuo1JJutplt+859jlcpvzGV0kQupqRX+xrCx8BogmFgVxI?=
 =?us-ascii?Q?+eyJjxcfeUqFk4vXo2yEsKH443PZqHlw+d6YbfS0+20ymLMgvd5xFeLzRYk9?=
 =?us-ascii?Q?hkHLQmYf7IVbY1fNv5bOj+LeE2iBZMDEYZYeOMYkL/FZfiJgZaIDfxnjLUce?=
 =?us-ascii?Q?NM7oR6bKNH9/WeZ/yb58HkcR2piHcAo0lt85pOMDAqWofXGbgeBkTS2tJAlF?=
 =?us-ascii?Q?uIt9YQItZMudNxZrMHBtk988?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296a1422-1bef-4e0b-c6cd-08d9876c3352
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:21:44.0774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 355+a58jbc0bll3fkufnNu9U4X7CsNlDnANnSZpZAcu6XgwpIBmUBDPB8vPAq9HYRDiXM3AgIKUfXF3SS+juPAcEhKfOlTr9QXHETXl/fpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1548
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040131
X-Proofpoint-GUID: CtH34_iRtE1tZcpypDe8msS4ASbXqdls
X-Proofpoint-ORIG-GUID: CtH34_iRtE1tZcpypDe8msS4ASbXqdls
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

For vhost workers we use the kthread API which inherit's its values from
and checks against the kthreadd thread. This results in cgroups v2 not
working and the wrong RLIMITs being checked. This patch has us use the
kernel_copy_process function which will inherit its values/checks from the
thread that owns the device.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/vhost.c | 68 ++++++++++++++++---------------------------
 drivers/vhost/vhost.h |  7 ++++-
 2 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c9a1f706989c..7a5142dcde1b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
-#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
@@ -344,17 +343,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 static int vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
-	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
-	kthread_use_mm(dev->mm);
-
 	for (;;) {
 		/* mb paired w/ kthread_stop */
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (kthread_should_stop()) {
+		if (test_bit(VHOST_WORKER_FLAG_STOP, &worker->flags)) {
 			__set_current_state(TASK_RUNNING);
 			break;
 		}
@@ -376,8 +372,9 @@ static int vhost_worker(void *data)
 				schedule();
 		}
 	}
-	kthread_unuse_mm(dev->mm);
-	return 0;
+
+	complete(worker->exit_done);
+	do_exit(0);
 }
 
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
@@ -517,31 +514,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
 
-struct vhost_attach_cgroups_struct {
-	struct vhost_work work;
-	struct task_struct *owner;
-	int ret;
-};
-
-static void vhost_attach_cgroups_work(struct vhost_work *work)
-{
-	struct vhost_attach_cgroups_struct *s;
-
-	s = container_of(work, struct vhost_attach_cgroups_struct, work);
-	s->ret = cgroup_attach_task_all(s->owner, current);
-}
-
-static int vhost_attach_cgroups(struct vhost_dev *dev)
-{
-	struct vhost_attach_cgroups_struct attach;
-
-	attach.owner = current;
-	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
-	vhost_work_queue(dev, &attach.work);
-	vhost_work_dev_flush(dev);
-	return attach.ret;
-}
-
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
@@ -579,6 +551,16 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_stop(struct vhost_worker *worker)
+{
+	DECLARE_COMPLETION_ONSTACK(exit_done);
+
+	worker->exit_done = &exit_done;
+	set_bit(VHOST_WORKER_FLAG_STOP, &worker->flags);
+	wake_up_process(worker->task);
+	wait_for_completion(worker->exit_done);
+}
+
 static void vhost_worker_free(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker = dev->worker;
@@ -588,7 +570,7 @@ static void vhost_worker_free(struct vhost_dev *dev)
 
 	dev->worker = NULL;
 	WARN_ON(!llist_empty(&worker->work_list));
-	kthread_stop(worker->task);
+	vhost_worker_stop(worker);
 	kfree(worker);
 }
 
@@ -603,27 +585,27 @@ static int vhost_worker_create(struct vhost_dev *dev)
 		return -ENOMEM;
 
 	dev->worker = worker;
-	worker->dev = dev;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
 
-	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	/*
+	 * vhost used to use the kthread API which ignores all signals by
+	 * default and the drivers expect this behavior. So we do not want to
+	 * ineherit the parent's signal handlers and set our worker to ignore
+	 * everything below.
+	 */
+	task = kernel_worker(vhost_worker, worker, NUMA_NO_NODE,
+			     CLONE_FS | CLONE_CLEAR_SIGHAND,
+			     KERN_WORKER_NO_FILES | KERN_WORKER_NO_SIGS);
 	if (IS_ERR(task)) {
 		ret = PTR_ERR(task);
 		goto free_worker;
 	}
 
 	worker->task = task;
-	wake_up_process(task); /* avoid contributing to loadavg */
-
-	ret = vhost_attach_cgroups(dev);
-	if (ret)
-		goto stop_worker;
-
+	kernel_worker_start(task, "vhost-%d", current->pid);
 	return 0;
 
-stop_worker:
-	kthread_stop(worker->task);
 free_worker:
 	kfree(worker);
 	dev->worker = NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 102ce25e4e13..09748694cb66 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,11 +25,16 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+enum {
+	VHOST_WORKER_FLAG_STOP,
+};
+
 struct vhost_worker {
 	struct task_struct	*task;
+	struct completion	*exit_done;
 	struct llist_head	work_list;
-	struct vhost_dev	*dev;
 	u64			kcov_handle;
+	unsigned long		flags;
 };
 
 /* Poll a file (eventfd or socket) */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
