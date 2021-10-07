Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2CAC43217
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A3A610A5
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 21:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3A3A610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 849DC40A3B;
	Thu,  7 Oct 2021 21:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OUiGyIIaCKdW; Thu,  7 Oct 2021 21:45:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2378440A14;
	Thu,  7 Oct 2021 21:45:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4597C0020;
	Thu,  7 Oct 2021 21:45:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AEE1C000F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A06B84094
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Cwn4etpN";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="vYsuxDlB"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tKpmia7pS7rI
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76D7684024
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 21:45:33 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197KYYQa025313; 
 Thu, 7 Oct 2021 21:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=jxSGjirH9B/FMWi8QOfSZlWOC8P+NFz0d82awMMRdtA=;
 b=Cwn4etpNE2SjtNdsc4XEfKySHxA9zU9DEQ9A1DtGGayeJ1uaUWS8Kwcx6mMYku4xr+RM
 MZEEdwsuOPISww+4kZ8Fwd+GbMTeYcWd6hsjnoz0fZnfowdyhIcX6/JIhVFY7JWhKoPE
 1yWZhNsfsF7F6bOekCu0niImBpEnWuZkKR/6eJ7Hhpfq7i38GSSlM4Jc7wOUXarjZgaK
 y/I7lwMGrE5X9PRvpGLonfxSzjLmEco6j5BakIRbzPOpC/Hg3WRQTEtqckGv/EEqHR6r
 6KO89QfgDitgW6HzJxSf91QJSBbDk8oOrmol8oaGlYQyT1fXqGj74n8HIiBLizxcXzpY og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bhy2dcdud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197Le7IV113075;
 Thu, 7 Oct 2021 21:45:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by aserp3030.oracle.com with ESMTP id 3bev7x4uju-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Oct 2021 21:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0d+U5QIwyd6kCjWNTZdPcYL+NvMMoXcovG96GIxamkeYic1sSedfxncHdHM4OrGpyKstnchn4t9kAKyV9mK18Pnk+ExCP3OaOHhZYPuFqvUaFrrQzZ3DJTnTupm2rjg1VdSMZCFL1CzXCObuqxNqaXWXmM7bJEQuFCv4ruHKgmQzzEiiC2CClOv8ojOLgYzGL/QWgpGg62eMx7gGa80Cxc+3Aa8ukU1k3aVUH4vNGP+LA/BKckJL5KhsEbGvRCFSnb1Qp3TzHCVhhWTfgk0xM5v38XDYCtI0x4/O40AOm3/p/7ZaLuXK4E7REtT2lOmYm20Ad1hlIcD5TXyGS56fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxSGjirH9B/FMWi8QOfSZlWOC8P+NFz0d82awMMRdtA=;
 b=U6EHDCQazrIXDH2ttIKUp0H5UiLQ/RFohyEwJKX89Z4ozP1zxpPpeyDYMxrR1+mFQaXVLj1RrHCwiTA5Q8CJkRYBn2Ml+uHBbt1EnPlxbMCbCBFyYdRO416xabMfJdP0GAEVd7qOg0WNlrBQnPqzMJRkoBKGPvhtimLcWWvUFY+XLDFbX9UPjU9TgtMaLoUNwU6nHU/mu/L+G+nqEoV+DGLwv6+mEh9Q1fgmVQuHDCmce4+4tHU5lbHkRd7U388mekU5d5TjCQX/ONoEqZqC2dIgOhDRZUHd88iJIMkbeHrXQNFmF/jDvd1c30l8iajTKlpK6yunNtvrcaUvXqdzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxSGjirH9B/FMWi8QOfSZlWOC8P+NFz0d82awMMRdtA=;
 b=vYsuxDlBMvRC+R7oqGqjxQpGloO7vkVTbxaqv9qSdVwq6QTe6uKX67BKfi2XVNihghCVI0HM5ltOteZKrepi1/KQS+iciqcNkQ8q95o05I9uLz9AOU4I2JIj84veyztCllOo1ruJCdylOs9ukPFN5e3u8GWO//+hJEf1EoQ4fBw=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1612.namprd10.prod.outlook.com (2603:10b6:4:5::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.19; Thu, 7 Oct 2021 21:45:01 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4587.021; Thu, 7 Oct 2021
 21:45:01 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V4 8/8] vhost: use kernel_worker to check RLIMITs and inherit
 v2 cgroups
Date: Thu,  7 Oct 2021 16:44:48 -0500
Message-Id: <20211007214448.6282-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007214448.6282-1-michael.christie@oracle.com>
References: <20211007214448.6282-1-michael.christie@oracle.com>
X-ClientProxiedBy: DM5PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:3:93::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 DM5PR20CA0008.namprd20.prod.outlook.com (2603:10b6:3:93::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 21:45:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26642a96-3a55-4d5e-5b38-08d989dbb71a
X-MS-TrafficTypeDiagnostic: DM5PR10MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB16127E1B3BC655AEA4118C75F1B19@DM5PR10MB1612.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:187;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGH5DAD0DIabpw5QA3r/Tj85qhVkq/IR0nD3+szS1kZsakGosxWi0aLpUwDVqGUGHH4WsxFFijGk3cKMUDjQGKv9gC31VzBXiUWXdFNVdAcVtdBVSjvM64giFInFiIviWqxZEba8ph5TQT3oRuDQGi1COFBcs1vxGNuqV/AaC6BWvOG6V387jdxfyHN4TTRtfK4rrCZACJm9opLLdAzHHLqbgxae40bv7p6yDnscX7QJ2ma0cFPjq5BkFKiypdOGMvU9D20HXzE1pX90hCCAeoJFYmHGkBc6hWy0NDJ7AVFudM6C3UT7BEEFBMJ094BFIHlOs3n/QI077N2oAleEHfzZ8fSso5mQPwVl+OkBq9aWp1j+zCGoTU7fFYU4dRvNE8HHqsEVmVIZPQPoRn1FEYlBXEmoBJdbW/N04Kiys5AI2yARFUqf7nEvhOaHbYq1wPhievcFmn/MprsExp7wYLsDA20S4bD1Jb88iCZIqfGamv7I9h9cvWxcvt9Kj4mZZa6Afi4O01IWVTz0w4XUlVG9SDnO6JCXObAOO/FNI/qvVaBwBsQqwH4zpPNJFY3g+FBNSf50HR+yKg8ofSCHB5T7vZ6FGti7jrvcEI7TrHQELU5szluACyBJ30kPvQGQ+XdW7vqcXYTEA12HqZ7etad5ZUmr+GEXVR7NiWWAnTpQD6q2zi+UjX3QKqdZbg2rDIaDuY00U6f1ovQBYGVjbRHoWO2h0UDqIt8Tur2Q8co=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(36756003)(2906002)(66556008)(1076003)(66476007)(86362001)(186003)(6506007)(83380400001)(508600001)(7416002)(52116002)(66946007)(6512007)(8936002)(921005)(107886003)(26005)(4326008)(8676002)(2616005)(956004)(6666004)(6486002)(5660300002)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HlT71LstvwvrH5k/ZPRt3jei2uJAo5qAGwHsr5WryzS5uuP2WSTn+g3dXuNO?=
 =?us-ascii?Q?vb3hsvWgcsQ/Vli5IKan4FNN/2IkumJJRlAIcp6ckOsReVFGXtH5FZcCftce?=
 =?us-ascii?Q?+qdL6V3LFebxvjY9DqlP1lr/EU9l1s4aNRiUCxF/pxrGHx4x/DO7oT8I8g0/?=
 =?us-ascii?Q?M2CbN7H9gzqtvFcyAyntfxV1ZE4PW5MtDuw65lXikk0FTRlGl2iMS5K3iT9P?=
 =?us-ascii?Q?NrmhscMQRqRnXzHISagM21ZQWKCnoNVszzbHN9ox49DzaRlddjdA4Hs+v86U?=
 =?us-ascii?Q?ulENs8WBgNboZbVOf9bv5Cp4uKS5GJ5V4qxvNdDU4PfhDICAP/L7GpE2N0Ry?=
 =?us-ascii?Q?Vy3du2aOwrHRxwPsRov5P/Bes/piLn8xZfDXpoVRCokHwle8yviPmtlZxvjZ?=
 =?us-ascii?Q?foVl0iffuSapLDtqWfvrENEMTf0Pk4G7q2z75dmncKtpOJjcNqm1yVGlIVEw?=
 =?us-ascii?Q?UO7p5Vy1mPoB8wQDjPjyghKK7mxOF/cEi6PZt7E3AyXmYs5B1LjxZ3ECJCQ6?=
 =?us-ascii?Q?+bQfv7KSrdRiprkjpDHNVWBdHAY0wjonMcmMZ6uuld5N+GAdccSWyMMGCMc7?=
 =?us-ascii?Q?/mIDt6c0/oMMyqQJHwumRODxbhExKpuKBJmfM4XJTdtWn5NjcqdjtCvf41ib?=
 =?us-ascii?Q?4K2DD4ZbCTGWPmpI9ovfFqkH0SBH5dcF0z7UWzuYMWD8T6nn3OY6TAVwDGTo?=
 =?us-ascii?Q?mkj91mzcPmykMe6AJFRJVMF0G0VGmoDqj8gC4iI0ExMDG2lK/ooWCq/Z1Kaf?=
 =?us-ascii?Q?myUjxr/IV8HMXziTTgTnNIVwZV9ZuLGh+5jYiukxHR+tZCjf/Wylattv7m5U?=
 =?us-ascii?Q?sq7iENo8QmIwoVfGFs56KYS3bKbena3UHASWuJ/du7Mkns3jMsPtXsXZBiGK?=
 =?us-ascii?Q?iQvtoSwbKZOXTAhLfM+Zy90d8jK55PjeuPXTjXCOL3t7EXyWjncyPfsGho0b?=
 =?us-ascii?Q?gs3XrNsAxSSdaPIxA7RuWcQ7uECn+TNTWVWW0zq3ptqgPmMGw2ieN3ELIM+R?=
 =?us-ascii?Q?78C9RnlCuKyKKE6/f3bmgFHKqCmFZjqM9nfiPnTe8rgnhsXsTenT1Toe7M+S?=
 =?us-ascii?Q?0OxUASSljTCCQFhkaW9t3EDpba0Jx1IS8uyTZANprjXL5j8Wj5CGoOVOfH8r?=
 =?us-ascii?Q?Cjna7TLe8Lcd6fk0q/HAdceEWWupnbyMIKW+hLQn11VzHJPeHutmbEinI621?=
 =?us-ascii?Q?LW5rZ63X5o3p24zL939H9D84DLYOa01pOUXxWEo71d993SOtkZ9Dm8JW8Jxg?=
 =?us-ascii?Q?NDbH/TYJ6LTuo7WXgMKxlkMWUIvrRNIX+KjqXXhBttLQJf8Mp6GI62fqfsWr?=
 =?us-ascii?Q?UOfd5cO1QwfJc3z8VMTUVD9j?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26642a96-3a55-4d5e-5b38-08d989dbb71a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 21:45:01.4126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLQgLJe7RpLAbkuSJNsDjgx5PL7Fgk8dZo5LvxG1pHAG6O+G1PHQ1hqdOcZNbuCU2wBqPpmyUIjXQuoXJuhGUsrMg4l+qDM++xhlP0eHptQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1612
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070137
X-Proofpoint-ORIG-GUID: MGy8SUDRyWzKuQqmOoS8o9lbkxCSF7Dl
X-Proofpoint-GUID: MGy8SUDRyWzKuQqmOoS8o9lbkxCSF7Dl
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
 drivers/vhost/vhost.c | 65 +++++++++++++++----------------------------
 drivers/vhost/vhost.h |  7 ++++-
 2 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c9a1f706989c..9aa04fcdf210 100644
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
 
@@ -603,27 +585,24 @@ static int vhost_worker_create(struct vhost_dev *dev)
 		return -ENOMEM;
 
 	dev->worker = worker;
-	worker->dev = dev;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
 
-	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	/*
+	 * vhost used to use the kthread API which ignores all signals by
+	 * default and the drivers expect this behavior.
+	 */
+	task = kernel_worker(vhost_worker, worker, NUMA_NO_NODE, CLONE_FS,
+			     KERN_WORKER_NO_FILES | KERN_WORKER_SIG_IGN);
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
