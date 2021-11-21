Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3440AC433EF
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD9644043B;
	Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9QRigU3Edksr; Sun, 21 Nov 2021 17:49:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 507FB4030F;
	Sun, 21 Nov 2021 17:49:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 133E2C002E;
	Sun, 21 Nov 2021 17:49:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C34AC0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E31880DE2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="g+DLXoSr";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="Ipy+uFl8"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id udmJOc6mbB0H
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 171D880DB6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:53 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALFtrOF000555; 
 Sun, 21 Nov 2021 17:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4MZ8tu00TvFfRUqxtO+rrkpSt/W1FvBjmwKqoL4odoo=;
 b=g+DLXoSruk2sUdhROhWxh4y7puLwCIn3Tk5Sn9q5BBXmoI/Q3E1/XOtTDhhlLlPEXJEz
 6NeFFT3O9rzFdNapwi4b84wHG5lJ3pPM3UBgpRh8XzgLpMTeOlXZER+s///tLHc4VPJY
 z7abeAOc8j4tO/U7VdcbaV5lZl0ftttle2Vilix2kd6wdj7pOTL3q8rmn4EWKZYAmscA
 P6mx/T7gGTbqtTeecxlGhkv1ItVPmDkRvpl1e3d07ONfo1x+gJXUHhDFWsH0Oh+rH0kk
 ww4sev2QzcQ/ER4g3Iybrn/ryPs2LST8AzoagP/Q0zCvr+yjflpFTvTfmmjPr1VMX3RF PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cermsmgft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkers100938;
 Sun, 21 Nov 2021 17:49:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by aserp3030.oracle.com with ESMTP id 3ceq2bnn2j-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne1N/OxmIX/oOG2ucX18ldvw2FeHbEyoVLZeM0wQHF1leoi3jBEwX4mTuJWXSwcTZqvAWtE8B5h6uix8ThCPnZuhg4YqEXM4euegltxHJ6Hb8FZyCvNFn09+Q2aOAMB2i9CZCfeK9+LC3kVoVUoOYwZDkm9V+1LjJ7ND26lx6UEwc1/egpcntv1IGi8d7CD2pucUl1yOVxH37bHdCuXQspbltZy7Ul3Pd1ff4KgAwt1pmYEzSUIcBJa7r4r7nLr4VkJk5y+NLNhkaMfuV6Xemox5fxshXV/XDxNjYVTg0lSUMwIrhUq4n+/k0N9b1ysheBMBM7QfU20pDJ9WocLxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MZ8tu00TvFfRUqxtO+rrkpSt/W1FvBjmwKqoL4odoo=;
 b=ZhNl90e14vdYvvT5yEmjFqm/qyP23aaGszzA1h3U2Qlc+LkDtnweofsTrGv+9/S8lZ2Y8esBCfLaXm4MVayC8Y3TD9aU1dCZPycZL4FuXOt05CR5z63C4FR2wNcjtmDL6OM1hSEtwDxrxru39BEAIkJvyGLw9dw84xQtpHfx5aG7eYwBoBcrcCUK5RXdfdqZxZ4dNj7UMZD2lHh6BrHFkBRWKFvP9Vz7UNwAubjSTkAiOzSLpflGe/OLQrRT0sFsMOQvU7eMg0+wHcYjEW3P88MKHM9nmeeLgg+PCO1cYjpHVd24MjmYCmYP7ZjLU5jKMOjsd38xSpQuJETEYc3s3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MZ8tu00TvFfRUqxtO+rrkpSt/W1FvBjmwKqoL4odoo=;
 b=Ipy+uFl8tjx9rHjOODRnXyjJHvu298X7cefLrpYrH22q2Dwp6AqBBrvUncsiXziAex9lAK0kMwUY2Vp17Jhry3HfibyZlPZ8xozYey/jxNxIIHnVOqaWXkqyAnPZMv2C/vSBGp/Chk3LfinfQS9xos4NbhustK0NbDVna7YGH+8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:44 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:44 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 01/10] fork: Make IO worker options flag based
Date: Sun, 21 Nov 2021 11:49:21 -0600
Message-Id: <20211121174930.6690-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211121174930.6690-1-michael.christie@oracle.com>
References: <20211121174930.6690-1-michael.christie@oracle.com>
X-ClientProxiedBy: CH0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:610:e7::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by
 CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a34c6308-e8e6-43c5-b85a-08d9ad174d2c
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5055B4D500B1144B3058BC48F19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4k1BGrCtLRN8+DyLzn6JM/w53zSiInVmRhz58M3kdWQfn2xCIWJMI1G1JgLYEIR7uCztUmjYHZsxeFkQJplrBt2v3WMjT9Tm1qJT/pfxpid4BF4Mv4qmr0Zlh69BdxVd5m/LZUms14ZTPT4Pc2jlDnYsUho7uce6hzujxBBVArjq3X2+VfrzBqhMoO8y4FJpz0j8YOBQlEpohP1cYbRmac//ub6QdekzAWgGDD6RUSbNBGE18soI9gwcK358tEGnkyaITrkikkS4vx1B4wvTqJxzR7F8gzz6u7S2EkRWB9pXtvn5zFwf0UOiPRvPyqBDHsz180PAAuABPlRhj/SVX/XhwHs2Phyq0XR0KLlDD6mAC354eivu4PxZD4rayC8TabqckTBzXBUQvhEKYvfEj0E5ksLkGcnjtvvMTwRWGWAlxUi7CaxnLe+6mDfFm6Kia9XyoqGKNbRp/BgvyioJubk9cC/wlUit/3F7zEinaic4jHM9ssaq6sCHwR/3TpjoDtXM93RCzCrKWzOyedT2Ca6vzR/hqQ7V+W67bJVsdcnnprDN62M8RRfpyXpE5/D4nuzbtZ2GtOQNcXD0XAYguoufvOHegoU3PCcCN7eGSL06mJSTItWE1aacf1jOqrBN/KUmm5MRTnmiiaBfUotuGZSfk4Kq7lJ6RpksZO/Oo8plaCiPz9bxloaNhB6dR5lgHMOpbfJw9tt6IVmnMRYxNpodfj9JYmPfuaJOZ8dpci0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(6666004)(6506007)(7416002)(66556008)(4326008)(2906002)(316002)(86362001)(921005)(54906003)(508600001)(38100700002)(6486002)(83380400001)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oUailx9XtzWIBycEAtiQpeNfT9XeABOoCBaQJTL0VZtGJSzi7L2Oyj4l8aOo?=
 =?us-ascii?Q?2tJUxd4Knd2+xoJkjDzMOyevBbJrpzJ/MaFymyV6RE/nnpBdfb3ux/g5AIsr?=
 =?us-ascii?Q?Ij1b1/PxXPJ63uUCeDDXXo2zYYFfklNe3wXcS2Wrymd+mu729OuOiS/m+jXc?=
 =?us-ascii?Q?MdGNcXJ7yCPERs3MppmF+RLcmPc2pzkvVAykLIY/4Nvkib408wXDRFdpuWsQ?=
 =?us-ascii?Q?iDrdESjXa73uTgkz82L0bIZswb0xuoeEjJPazgEdPcjjbn7wIeH+i0qBwJg9?=
 =?us-ascii?Q?2FX6u4688wwwvPGsT36UO+wAW899oe8SuPROPwykTPBCo5iHwrDsjZdsc1tV?=
 =?us-ascii?Q?tyTg0WTx0OnlW6cRSsJiENqFEJJTXv3+Gde9W2hs6LqG4IbT9A1MzJcrKqYD?=
 =?us-ascii?Q?ZODQW2Afk0lH42Wojr7pF0AlE6ZMwhFPikBC+8A0lHcWYd57ax9AnoXCzzZv?=
 =?us-ascii?Q?GRfydjPIvZWjATpw6htVVV8eKvbEp8fcofcyyaf7QAfxLQYbynCiAbxRUt8G?=
 =?us-ascii?Q?SjzmicR4MdV0IhDxEIRyhGR8xIxT/BHzjeLUkQONLcC9W48yu+FtewaKCPT9?=
 =?us-ascii?Q?3adQe7dIxSVXO3Pik3XKSLnpedgnYjgNJ62kB5ZG8L20YWE3waPGDkUBZ4XV?=
 =?us-ascii?Q?icYYtSpv+94QENW91SKVp5DKsajBkOk4KbRAiBXvCg7Y6kaLDx/4NYZ1FcSV?=
 =?us-ascii?Q?mpJcW5N/pFHpiSinQxBBx7Q5Pgw0+QCbXvdu+Z5Co7IVOSmU9Utm/1g6pwFz?=
 =?us-ascii?Q?afrtq6N3L0G9eE4TYtKcQbxOfucd4RuZmqycdnONGbHEygxFgN17oHUtiSwp?=
 =?us-ascii?Q?9zuUTbWZZUxqTfpMfy/MWA7WImyeQ5ZkgtG8AlZsq1QiYtxaQt9pCRNMX43O?=
 =?us-ascii?Q?4zAefr+f7ntTdZFWOYFOFQj6hYdo70LbMnYDOR1bv71bSxTwvPAuUjMxFl2H?=
 =?us-ascii?Q?IJLiNyP28PXuTZa838hzWSHFTLQl4o16A6cPVC7W8CJLXm17SvoW812PrmL4?=
 =?us-ascii?Q?qZYS3fXjiv3kxEo9mqb7oE6nsrrB9c94kfzF+jVMnGj2MaNUC7H3SFV6aVhz?=
 =?us-ascii?Q?u4dcbveacEklUufA1GBzDmAkqz3ZVKW0pnSp560BRYR7N8YPkESs5tMAliBr?=
 =?us-ascii?Q?gsLeha+BLyhR2Ww4F8zyHKSLVOhin5FMpdZ1LyKg80moXOgktc5Slrdr55aT?=
 =?us-ascii?Q?codHTpe4IfcZjaCYb5LE3SVFQwkJKoSGrjHwrv06Zcqnph5q+3QI110oEkp0?=
 =?us-ascii?Q?ORzi3M/gVHZcS2ANrdJ+nQuOs/sOOXrQgyet1EXYJTPwAW8shKKb7kELUiVF?=
 =?us-ascii?Q?A6F9wzwiHxqcabJsVz/EGaywCD5AVk0DYkBhmGQRN9QKaYCiZTA1B/DcWsho?=
 =?us-ascii?Q?eZtVmgSxeqcD2YT/13Zal0ua9X1ARJrlJqhrgQnwMGU+oPy946OqNR/JosnF?=
 =?us-ascii?Q?Y6pIG8pzhQDYxq1mn7xaQr4+xkmQFAXlmcoXLpbYGlCtOw8Wilotu4fLkCuu?=
 =?us-ascii?Q?9fMk3AwnSTg/KZ0uHHPgAYg7sJ17tzNOvyRNvJWj+tO06KG6jGjSkBY/aEaV?=
 =?us-ascii?Q?7axsFwhQ5uOBppVjJODmgS8jiFD/E1blbrEHtP7oiarL8rItNRFj8QYBji92?=
 =?us-ascii?Q?h+veXRLiE14ysFEE9xYiepV2WaoRnjcYiARmeMfH1DdvXGbvNdx5/EXedqWA?=
 =?us-ascii?Q?RR/nMw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34c6308-e8e6-43c5-b85a-08d9ad174d2c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:44.2014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaLlFH0sBPjwwJC4xgMRLufRTJH4pWWIuyo9oZ4sPbP8TZMvXj3Y0R6wtGm0IzNriszixEuEs5hy/rMZvO4ZKnpnd4QyOTYRUR5PWOJacws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-GUID: A4dCw6Np9eE_vJFxBqVcNlGO-fsgSB0N
X-Proofpoint-ORIG-GUID: A4dCw6Np9eE_vJFxBqVcNlGO-fsgSB0N
Cc: Christoph Hellwig <hch@lst.de>
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

This patchset adds a couple new options to kernel_clone_args for IO thread
like/related users. Instead of adding new fields to kernel_clone_args for
each option, this moves us to a flags based approach by first converting
io_thread.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h | 4 +++-
 kernel/fork.c              | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ba88a6987400..c688e1d2e3e3 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,8 +18,11 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
+#define KERN_WORKER_IO		BIT(0)
+
 struct kernel_clone_args {
 	u64 flags;
+	u32 worker_flags;
 	int __user *pidfd;
 	int __user *child_tid;
 	int __user *parent_tid;
@@ -31,7 +34,6 @@ struct kernel_clone_args {
 	/* Number of elements in *set_tid */
 	size_t set_tid_size;
 	int cgroup;
-	int io_thread;
 	struct cgroup *cgrp;
 	struct css_set *cset;
 };
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..58dcbf7dd28d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2023,7 +2023,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
-	if (args->io_thread) {
+	if (args->worker_flags & KERN_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
 		 * fatal or STOP
@@ -2524,7 +2524,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
-		.io_thread	= 1,
+		.worker_flags	= KERN_WORKER_IO,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
