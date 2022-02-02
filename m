Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C33C43219
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 21:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5801F41634;
	Wed,  2 Feb 2022 21:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AGpHHRjlYzX7; Wed,  2 Feb 2022 21:02:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 57BC141645;
	Wed,  2 Feb 2022 21:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A362C0078;
	Wed,  2 Feb 2022 21:02:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00281C0077
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D840400D3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="UJq9PiMS";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="aNuWPCDo"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id azxNoouZ5THu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:02:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 812FF405AE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 21:02:27 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwoRe024816; 
 Wed, 2 Feb 2022 21:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dnvdctlMo6/aOvaVmFL0UErE4V0yMtOhL3uazVi0amw=;
 b=UJq9PiMSLrBxvM+27lKb64BNuGje1UJUWBs/hQxACm+hpXUsHeaUuSMm5V8LV+KcTiVW
 ANKU11Z2mQtFu/BVleiaaUDAayy9uuJcSPmlZ/116QRhEzNCRxYDHymYu/XqYvIKRqT0
 uW1pr51WQ7pm8jB3QA+8GqZRlzqASUyzSJipf7d2C7azNi04BXSdInKo1cx55lQ29qzr
 WG/WcL2OlI95GNpFecoyG+yUB2ZMNuZE1wcYWHAcTwhuCksLoPnIqHTAf70laHFr4YDe
 1NVrW2ZKQvcnRcK1g/2x+UuWLL9fG26OloxNQmf5YcGCGvw2Kazn5rziWlEIwY7kbJUK fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatyf0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Feb 2022 21:02:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212L1Ejp021471;
 Wed, 2 Feb 2022 21:02:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by aserp3020.oracle.com with ESMTP id 3dvwd8xt3n-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Feb 2022 21:02:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9TBpsx5y/FLCaFyXKCb1fM6foGgrr53X1ZQgL8tYaanl+JScP5Q8hQFDNBZa7F1E4h4I/CZI4hqzzQz8wZwd8/1QEzKFMsLmgC59XAGiAqlcUCMiN4QoTFk/RpKecd9hDNH0i3aMIYHHtR62chCzhVbAE/1p8QduD4VESICjIAHnf8eEjaw5sllxw17sqfKFu+cnTsOfEfJOJAW0IffyqoNlIIg5AnipIW0Pefn0BhLgPWePO3Hf6OIbqUk+CuY5pM6B7aBnfITIEhrT/BdH+gZPdvDVc9UCLXM1u7hSRc0Fx6UXT+q3f89HLUWTBYWxouosVu6/8qaO4ryR9DZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnvdctlMo6/aOvaVmFL0UErE4V0yMtOhL3uazVi0amw=;
 b=Kde2DntAvTwMBv/k5yx7BItKCqTSqoTEAMsIqXuFTJrNYkPjSDoSQ6TO7OOTMkqn63H6uj4HE9p7IHtmQszYgNkzU1xcbr8lWKuINACWdHtu0YjfBCicrZ3lr0Xs0JC7TVDW7dqdlk4/KtoFONEkpVjHHtdz1w8871PDEiPdRzMijKEgbgr/OPruHSBTmB7S2A6AqtEo/QU3v9X8u66uxkDq/cwuBarKk761WmyZJ4YHYXZp53Le1nWYW39BtL7IALY/fWuMjFhUjW7r03N455uwM+C1HDX9onYiGuLUZQhHHBYPxHTZ2cmhcv5y2MrQ40Cf9zNT9Vfh6xiiYySM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnvdctlMo6/aOvaVmFL0UErE4V0yMtOhL3uazVi0amw=;
 b=aNuWPCDoxrJnLXzKJ1F4BwZVYaeBrdfAqE2H4bPxebjyopK+mmJwUTJJJ1SstFPlwKkGL+16LPdFpOuKYloOaAd/5/K4kCtM5PxxlqPkAspPb1o0JHtmEWu/KcEmzqhX3Y3GnJ/MxVfzDAzS3H6QSDTzACYL0ev/dzKzkO7cq74=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 21:02:14 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:02:14 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
 stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, ebiederm@xmission.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] fork: Add USER_WORKER flag to ignore signals
Date: Wed,  2 Feb 2022 15:01:56 -0600
Message-Id: <20220202210200.5235-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202210200.5235-1-michael.christie@oracle.com>
References: <20220202210200.5235-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:8:57::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 789fd326-6656-465f-1f3f-08d9e68f47f8
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4014286EEEDA6F253BFC0100F1279@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/ixR7EuADLaLJdhorWBlMvh1GplMBp7jAjAA+ogqPC83WtbcJ5Y6SDVA5ww9wC8Ge37ZXfJexWFciiVYDOBJWVQBvn/KlT8tGMLLSF/PpKYyINJiebSgVJVZkWqmkQ6nG7FOUm36xNc5Kt31z11ww9slW2ZzgvcpgNnbJUgDJ5Jg+OUCf5Y3Sq/LwjqdOal5QPQo8joyIepihzG6VAFfjoHrOGR0s0GoVjgWy/gkmoyU8T8Bm3HjOR5DnHVGmnSVEndVtZK8P+UiYv3x+1V469iVq4ZC90h4nHc6/ooxMRwUE2uKH+h8+0KwNTDEH4q59XknNgKAIWLWoYBiJx0tS49Z+IvP6YXZJUK9bUNf6YLbk4mjtxymlIxWFiLpjVggQejDwJjoTeUE3o6Zymhulve0KujsIh6UuK+GdBWPgYWkjiR4pwTtF7UBhTNuPZvi+aINB2NotZxnXeLKqHghGm3oLCxjdvhcgMuYwmfikGyHfnBihF946O05V7cn5OPUPU7Geh23DLkahGcJgAaB8BLmc/K4rriUBwfLgBOllHwU5rno0v5XMA2jy4gkfZ4PxfWDgF/3FOB8Awb1UM93eX5qfguRLMr0ibptPTbHip5FN5pe06CpByvyB4QFWggIJnNsFKYSbGUTqv9gLNGt54nTXIxe/W54qQSoO264ktMEXOSFH0w0tUAkWoLqXi6fr8HOegm+wAjqBcIt6NntQg7miWvCI4phxMMgLktlEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(83380400001)(6666004)(2906002)(316002)(38100700002)(1076003)(54906003)(38350700002)(5660300002)(186003)(26005)(2616005)(66556008)(4326008)(66476007)(7416002)(6506007)(66946007)(8676002)(52116002)(921005)(6486002)(8936002)(508600001)(6512007)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQz3GgEY79qgCAnu6NwsjuoseyEyC0ItF32HG6u8TmNhrZsjw7m4q05WBbin?=
 =?us-ascii?Q?gDxr+iuwxAZC43Llrc+ak9KgoTOrEJ3NNLP72c2G+V7znIiL2JILNt8eKxNP?=
 =?us-ascii?Q?5rUag9cOid1NouWZ5EkkRYPbMuTj3vKKa+mQy1lnh9O6Y55+NNFL7YmlAxuN?=
 =?us-ascii?Q?s+fOx4dQ+hvzN/xggL22sNji/TLdXQm26b8ZZ/orCNfBWfB7b8l56Oe65xLk?=
 =?us-ascii?Q?Lslj2xqNp3N1782LdmvEtIY9swmriDtMpcHOjR7hWpSqmYQJW18wpEsviI6f?=
 =?us-ascii?Q?spSciSvBzt9SS45ZjXdfGM1GUUrpm5YFu7k7PoTj3h9uPh+qYXa+0vQv2yHe?=
 =?us-ascii?Q?eErqaxv5M+KCrGU4yNE9AHULKzl8Bk/UtdpEwoPp8HcUyCGwIThfe1X5eaj0?=
 =?us-ascii?Q?iTFGzPMxPePvnbYp8zcMV94K9S8jmpWKc6obwDLDMN6MnM9MpPbXz/XwrLed?=
 =?us-ascii?Q?SjlUDCahPVPea40YeoBk+WV1xnb7fq0zl5aa18zZ+73WwwZyEMl1jDiykYx8?=
 =?us-ascii?Q?peL7cKClgs2WHaLR9cyPnIvydCneFVld8tCWjSv84e4MDruDm6xMmObRZI0v?=
 =?us-ascii?Q?efUg8eozarD1hByS34nKqHyt7Aw4kYUl7qPejf9IhYK0jShgXPMoEhPYugjh?=
 =?us-ascii?Q?Q/mtDhpxggQxtPbnv2uMio9lGPpkvgMdANJsVAyxSSP1orjCAjH/Fv+zI+e0?=
 =?us-ascii?Q?jNAvSeGSYGv+B0G/RARijUChHiJbNBm6LYLJdZ8G/bF6v43u/eOBGG4vfGHe?=
 =?us-ascii?Q?jPq1AsgqzqjCMBFtkvQwfA6WRK18r8wgeNiWSjHtLTztnWg4H9FyLfvvjrKw?=
 =?us-ascii?Q?rwjhBIp875x0QGYqYGHwI5ioOJ3gcaL4qmOQLzsFdMf5/M62UX9y9R5y4aei?=
 =?us-ascii?Q?y5oeANoBHRKK9gBIjKHv43TJFa2zspSQnsJ6vdGKzgUn/LL5cpReto1l/HBp?=
 =?us-ascii?Q?EB6nEDjbSRKBpctjLaFkYqUalrXt2agmjtDb6MdwC6D7xONEDFORs1Xtf9CS?=
 =?us-ascii?Q?6jbVXV2lPvhMIIVfjrOXGe5ruvHMh0/uBvfeykdcsyHhfluxzWA5m+34U0pa?=
 =?us-ascii?Q?wUb6ZAMQB+PFOGIIrz9v6DypJTZg8g7VIp9fec5B4Ru66Ho1bVIdE1KsWqJd?=
 =?us-ascii?Q?YMJ051z6TCBxEmNlHzGetR3acxPVxchHXoYtXegVmXmmcdAVLmgUw+l67un6?=
 =?us-ascii?Q?COVqia/Pwy+6FmSDTUkSQZ+EsBnt9JoSu58KUv5B+ECKolOfYutIG3fuxDP9?=
 =?us-ascii?Q?uBdB6YaX8hZzdLCBOa6IPXlfO6T22yfH2sw1KlP76KcJixM8s8IFY6TGME2e?=
 =?us-ascii?Q?tEa3R2S9QNPo25E/MbmFM/8g4xRWVQq0Xup96gQm+BrOyT0IIPCFI9nK1IIp?=
 =?us-ascii?Q?USavYm67oTodnkLbnnU9kM1UredRrPy8c45pJbDFk8EVXpAaBNK2cVopHQ/U?=
 =?us-ascii?Q?xpJs/WcnGRELgbZOZF64yPa9nHd99l96KZ+T057m91Vu+4i989HyyOG2+noF?=
 =?us-ascii?Q?nBlQYFQq8q+6aGLwIz11OM/QzoaKitxb25B+k6uHUVNoFOaN+suoB5gKLqum?=
 =?us-ascii?Q?tk7uRzAOtDHDxCwXYXQUlJ1W+JjWoT0wzxUNFVV5uahYovANTJg8vb/RPhcO?=
 =?us-ascii?Q?qTsTieoRTMAVxaQq8m60Fjy82n2iL12CVcWUa/PL3q67ffKx2BoT5agAgGbV?=
 =?us-ascii?Q?wOvRyA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789fd326-6656-465f-1f3f-08d9e68f47f8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:02:11.2884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9+LbEPf4ppnckKvl2oujgJnvJ0cyWfqCD0+RhAoav0SgGRbAM7pYiYDBnIWPa5KjH8fRDYjN/3+FWwHDkCW1XXDiH0VkDeTIi5w02vH/4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246
 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020115
X-Proofpoint-GUID: GyfXRJeFz4Xig3QVInQWxkkuBacYuvz4
X-Proofpoint-ORIG-GUID: GyfXRJeFz4Xig3QVInQWxkkuBacYuvz4
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

From: Christian Brauner <christian.brauner@ubuntu.com>

Since:

commit 10ab825bdef8 ("change kernel threads to ignore signals instead of
blocking them")

kthreads have been ignoring signals by default, and the vhost layer has
never had a need to change that. This patch adds an option flag,
USER_WORKER_SIG_IGN, handled in copy_process() after copy_sighand()
and copy_signals() so vhost_tasks added in the next patches can continue
to ignore singals.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 706ca3dc3423..c001d0fa1426 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -21,6 +21,7 @@ struct css_set;
 #define USER_WORKER		BIT(0)
 #define USER_WORKER_IO		BIT(1)
 #define USER_WORKER_NO_FILES	BIT(2)
+#define USER_WORKER_SIG_IGN	BIT(3)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 81a1096d6ee9..6a04860fa1ae 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2185,6 +2185,9 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	if (args->worker_flags & USER_WORKER_SIG_IGN)
+		ignore_signals(p);
+
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
