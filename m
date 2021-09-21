Return-Path: <SRS0=rv7y=OL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB37C433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D787460F4C
	for <virtualization@archiver.kernel.org>; Tue, 21 Sep 2021 21:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D787460F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4A06613A1;
	Tue, 21 Sep 2021 21:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JcugeoIZneQl; Tue, 21 Sep 2021 21:53:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4927613A6;
	Tue, 21 Sep 2021 21:53:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6339C0025;
	Tue, 21 Sep 2021 21:53:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F183C0021
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A83FC40433
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="Xsh2Cn5v";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="B02c7ASz"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id svkVzdWjaTAk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CAC84042E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 21:53:05 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLECU1027984; 
 Tue, 21 Sep 2021 21:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=YlCaqHv+xap2jRCJX/onV6I0HfComTsxsIhC+u4XWH8=;
 b=Xsh2Cn5vzv0nMsCz3XVQGY95Lipi7+kcuuWDw8POGXL/BFngoCtvUtFxcNyvr60tM4cO
 zBFcNVz7aVzRUYRzIFRHsIyvPLgDQpWC804kdi006sq2EyOL1RkVBL+4aPic3YAZ9k1m
 5rixuVywVUiIRJVU4/q+ZkQQB+uOtkGtmvWyWA1Er2KoBie2BkqQ3heAUfM4EGh2hlOl
 Q4J+l9nQ+q93NY3tY5TZyk5q0lk8A9SaYDubaVmfdhQ2U4YodjWJyxQc1PIp2ivCmAag
 FRn1Odk70vtYJOik4WWrsp8+YWBJV6XnPNvkg0NgJn6Mjp9a5zn7zsyfzp1QuoFQDPRZ jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4r855v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18LLnWRn189379;
 Tue, 21 Sep 2021 21:52:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by userp3030.oracle.com with ESMTP id 3b7q5m175b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Sep 2021 21:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkTyZhO4x7judWF8h66f72lXRbjrgx38WRQHHyI0M1L24LMJBFdtAU3UzAdosK71J3IaDSoRO4OJRCJT1tW1KOBcvt1NSLPL6wXiM/zXx/c5ISwScy883VjlFj5ggmEc/0/yLkEqxHKVRym6434Uao465is+UhwNA/J7k3eVMxcwFC7tTpNi3BzJrqeqFtkX26Yqh+mhoX1oDqXDy+s9WdqJcYtfRNxUP4++mXY1cYVS7i7/pgB4Jk2b+tFJcyZw+hg0TbM4UQv0Dr7MyNhz3EsSZsQhKQ7zVhrOf6UYljb1WRmh2OQFfc0ZxpO//5OxADNjJHFdqJgDKDyNztZbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=YlCaqHv+xap2jRCJX/onV6I0HfComTsxsIhC+u4XWH8=;
 b=Eln4HWCeMIlLXemBH8AvBtRmIltNdNE7OzKK9HonjPms+jwDv1/KGzJMFfqinSVZ7YeHA51fh65QZdEXvN+/y+sbQZqZQZ9UfvPSJsoxMMgBInfy2JF6OfeU/DRLb9ICM0qPCJSBrsKLTqB2hEh6IFffjFGU86KSKaoRKx20Gh12akE9JN1FGlg4/gVTXkjvE/LAj99blBKwsE6wKHRJ7e8dsW5v7V9Ar/frBQ9hbOpHkWiu+RvybSlRFcw04jPwcSRuqh9r0S8qT24jJMOXjU9vi2EU1VvoIDpwmnTrWDJ3QAjlVan8kLije2nAam1DaJdbJ5lc6T0G10LDUI189w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlCaqHv+xap2jRCJX/onV6I0HfComTsxsIhC+u4XWH8=;
 b=B02c7ASzhmKobzd1gdAUFoDskJx6fMWPU4Sq9ak9Azcuib09LOULunJr+dCMu/qeBGbschXF6NWtQFqQrUiRzpqKoiyNsFyye6oABW20DEO46Y1ARt6m0UZ0tVEHkxJhvpmm83IdIopV1DT5F5e0KB8X72GJKZaCnW+PT2pVilE=
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB3892.namprd10.prod.outlook.com (2603:10b6:a03:1fb::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 21:52:35 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 21:52:35 +0000
From: Mike Christie <michael.christie@oracle.com>
To: hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
 jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/9] io_uring: switch to kernel_worker
Date: Tue, 21 Sep 2021 16:52:15 -0500
Message-Id: <20210921215218.89844-7-michael.christie@oracle.com>
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
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 21:52:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9949abab-808f-4b06-5b2b-08d97d4a1f22
X-MS-TrafficTypeDiagnostic: BY5PR10MB3892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB38923511F8B0990222375EC7F1A19@BY5PR10MB3892.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:79;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+mCWpM4cZ2DP8GC3c9ve4VmXtvYMHnglRWiNf9mVV9253J9ialed+JImnBtJdY01VbCcVQvCxy/MqHapDgVApSPo04UJJml90yUi2zpZ7WJteXxoI0nObdhDUwcczxcqFibe10420rN8vE9UTNyXMCia4PmzS2dVo2lnzzv98ODW3CVUgq+fh1oXjyKj5xIhGUjJW0hX3VBpxIJEXjhtLvkoG5F2lNzpjTLc2SdOyusbUX6d7KcdxarOgKuYa7/DWa+Qea8bVVjWLfexiMaCg5h5lTmr7mxvMLia35EKFrsmPBJLZ5mXKjwzH6/eZXeI6c08p9rkjZGB3/UbS+BuYoCDizaiD5aQhTu8X8wcM4ONWzE9e5IAZ7XJPLobreZcNNNtZSCMAmDoGzWOavEPXv4N2gwo5Jozh7S0OFDlH5M/2VMurt+mBFbHZBGdF51MJ6WL4fRfhtJHvKNI2GHoZwgSyf/dYTO0mpRWj+iqVQHeBZxkkRrfrsZ77AjG+aaIQADRiMhwD7o3FwdLFYbD6S3MsFXQpJuslFaVjaXZYtFlNQhMxrZVKcb0qVYOLDWGbCC0pkSY0VJogxj0M19PLjrcQxK0tJ5lJ+u0gR8BGTHflGPYmkXP/x9zYkJEUStHG1h2GOJDBFs7/f5156mSO7Lidxju2tBQ3DchKg05bjUp+F5M+chkG1JtSMoklcLnJblB+/jjyqbXbaKUTHgeitDWOwutcnLPdXIFQf4fsA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6506007)(52116002)(107886003)(956004)(66946007)(26005)(4326008)(7416002)(66556008)(2616005)(66476007)(86362001)(6486002)(8676002)(6666004)(508600001)(316002)(2906002)(6512007)(8936002)(38100700002)(1076003)(5660300002)(83380400001)(186003)(38350700002)(921005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjRqgchNWXeop9jwh+7H5abJsmIUwt1gmv2vmFyNUTJzJPvhKbN7AL9OnKyO?=
 =?us-ascii?Q?YMyhUNqHHxNJdnOjW3a9TuULvVkyXwSOJPf1j8yF12CO3BKpCeVNUj7LMkFV?=
 =?us-ascii?Q?luW7OA1m+UmW2DRm+ZQ/nHIgnz1ZZsNN7022csLoepneoKWFtKfRC4Q7lS0l?=
 =?us-ascii?Q?lPvmfhfN3JoCO30SWJe3CXRDbrOqBG03Es7ngSkfCSO7l5kJxY8PC6p+PV7u?=
 =?us-ascii?Q?vnuCSlVKyBf1XC3DIk/GB6WOgueRTInWLWY4PftrIga8m0OOmTJW2LyYc0TZ?=
 =?us-ascii?Q?QUpANVR2qIOSBV/6SLm91HK5QFsxJpQTVUz2TtAAzT6pKqlKwBYgH90HfeA9?=
 =?us-ascii?Q?1KdfCH+BPTLm8a9rWdW248vMgiI9V8d6sxgLBB3HPx4KSuK22IYR9FNbdTJ3?=
 =?us-ascii?Q?dhPOtDevg68/XnTjcoQF8AuxgJEoT8u8EfqLuPaNwo+wMOzW8i1KZJzdYw+4?=
 =?us-ascii?Q?OV4XyDv/+rrugntKu66+I5a9oJnQVx85KmnzUReRJ5r84arwK4Hg4jGZUEyn?=
 =?us-ascii?Q?UVtTPAyydewhq0RqZonRbk57GLBdg24O+4t/tur1qiUIKGPtVoZPgRBC2bUp?=
 =?us-ascii?Q?nOw6JR1Iv9BNId4ueerrYqUrBPSoYKca48v+erxi8OweHIRPnWiGcid3bzwP?=
 =?us-ascii?Q?MdBgoD4RxCI8j3tzDnaC39t+ZqtCKEylQG0sP8qiGzd3+32Wok2f/HUPRpka?=
 =?us-ascii?Q?aVa+9EBPBf7eVr9HdTthfxuK4/ZZVEXD4pJD+4COMPARDPBM/o1qZDmaQ86W?=
 =?us-ascii?Q?9TgtvHZl8k1bn1eiND+7ze7RSXbow79hqfI/E20jgE/quLHomhu8jnDkRAQb?=
 =?us-ascii?Q?voawPFmlCyIKqqGh4/3VAxJLU8wPUiAPPgMavh2+WRgIMp38N+P2ISFA0wSW?=
 =?us-ascii?Q?x3EGQw02ETf0u8UkaKLofoVSxHagNUSjZ8KPxPVv4rQq05YMk0K/uNQg5fd4?=
 =?us-ascii?Q?OmifBiV1qNQNeGYa3wqVGWOgTpZ4yzgSSrJgKox1uzmWgkpoa3fuydkCTPJp?=
 =?us-ascii?Q?BJygCRIURPwQJRzTQlzOT6I+XpfJBLjXOn1bweJcaKM2eOISLfQelPgdm1T5?=
 =?us-ascii?Q?ftB9UDxLD6JVgQgREw8XW063cPT+GQhr/11Lgk7PQsUl+9X3u7noRWFhzcLY?=
 =?us-ascii?Q?/VECLix0TQD3TFtnXUlVD0duSeQ5i8fXWcHInSqW0Fhm1zgCQNj+lbdQp//a?=
 =?us-ascii?Q?oo71IQSs/aEgw07HaH2fpqeyABJjzycjwzIkeliG22ZCErv82qckER/PNvWx?=
 =?us-ascii?Q?2HytMR3mA+3ar5ARwNmmef7uZYKsIPQ0KV3W+Y93oJXwUlLhSN8leJBEfP5v?=
 =?us-ascii?Q?Fftp6VC2t49UVg62Zp7RnGXb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9949abab-808f-4b06-5b2b-08d97d4a1f22
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 21:52:35.5321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMjKIG08g6NAi0C7dO2M5Tg66qVccZedZPidsyZLkuv0/qDMtJbp8IQyowBN/g8D1j8QjbV4zqbha5vSom1oo2PJ/sNnhXO/P282NuI0rk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109210130
X-Proofpoint-GUID: yBpT444-niMNGlWhvpNUKULParUxBPNq
X-Proofpoint-ORIG-GUID: yBpT444-niMNGlWhvpNUKULParUxBPNq
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

Convert io_uring and io-wq to use kernel_worker.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 fs/io-wq.c                 | 15 ++++++++-------
 fs/io_uring.c              | 11 +++++------
 include/linux/sched/task.h |  1 -
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index c2e0e8e80949..74e68132a227 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -69,6 +69,9 @@ struct io_worker {
 
 #define IO_WQ_NR_HASH_BUCKETS	(1u << IO_WQ_HASH_ORDER)
 
+#define IO_WQ_CLONE_FLAGS	(CLONE_FS | CLONE_FILES | CLONE_SIGHAND | \
+				 CLONE_THREAD | CLONE_IO)
+
 struct io_wqe_acct {
 	unsigned nr_workers;
 	unsigned max_workers;
@@ -549,13 +552,9 @@ static int io_wqe_worker(void *data)
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
 	bool last_timeout = false;
-	char buf[TASK_COMM_LEN];
 
 	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
 
-	snprintf(buf, sizeof(buf), "iou-wrk-%d", wq->task->pid);
-	set_task_comm(current, buf);
-
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
 		long ret;
 
@@ -652,7 +651,7 @@ static void io_init_new_worker(struct io_wqe *wqe, struct io_worker *worker,
 	list_add_tail_rcu(&worker->all_list, &wqe->all_list);
 	worker->flags |= IO_WORKER_F_FREE;
 	raw_spin_unlock(&wqe->lock);
-	wake_up_new_task(tsk);
+	kernel_worker_start(tsk, "iou-wrk-%d", wqe->wq->task->pid);
 }
 
 static bool io_wq_work_match_all(struct io_wq_work *work, void *data)
@@ -682,7 +681,8 @@ static void create_worker_cont(struct callback_head *cb)
 	worker = container_of(cb, struct io_worker, create_work);
 	clear_bit_unlock(0, &worker->create_state);
 	wqe = worker->wqe;
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = kernel_worker(io_wqe_worker, worker, wqe->node,
+			    IO_WQ_CLONE_FLAGS, KERN_WORKER_IO);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 		io_worker_release(worker);
@@ -752,7 +752,8 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	if (index == IO_WQ_ACCT_BOUND)
 		worker->flags |= IO_WORKER_F_BOUND;
 
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = kernel_worker(io_wqe_worker, worker, wqe->node, IO_WQ_CLONE_FLAGS,
+			    KERN_WORKER_IO);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
diff --git a/fs/io_uring.c b/fs/io_uring.c
index e372d5b9f6dc..1df7bec8bd76 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7393,12 +7393,8 @@ static int io_sq_thread(void *data)
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
 	unsigned long timeout = 0;
-	char buf[TASK_COMM_LEN];
 	DEFINE_WAIT(wait);
 
-	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
-	set_task_comm(current, buf);
-
 	if (sqd->sq_cpu != -1)
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
 	else
@@ -8580,6 +8576,8 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 		fdput(f);
 	}
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		unsigned long flags = CLONE_FS | CLONE_FILES | CLONE_SIGHAND |
+					CLONE_THREAD | CLONE_IO;
 		struct task_struct *tsk;
 		struct io_sq_data *sqd;
 		bool attached;
@@ -8621,7 +8619,8 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->task_pid = current->pid;
 		sqd->task_tgid = current->tgid;
-		tsk = create_io_thread(io_sq_thread, sqd, NUMA_NO_NODE);
+		tsk = kernel_worker(io_sq_thread, sqd, NUMA_NO_NODE,
+				    flags, KERN_WORKER_IO);
 		if (IS_ERR(tsk)) {
 			ret = PTR_ERR(tsk);
 			goto err_sqpoll;
@@ -8629,7 +8628,7 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->thread = tsk;
 		ret = io_uring_alloc_task_context(tsk, ctx);
-		wake_up_new_task(tsk);
+		kernel_worker_start(tsk, "iou-sqp-%d", sqd->task_pid);
 		if (ret)
 			goto err;
 	} else if (p->flags & IORING_SETUP_SQ_AFF) {
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ba0499b6627c..781abbc1c288 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -87,7 +87,6 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
-struct task_struct *create_io_thread(int (*fn)(void *i), void *arg, int node);
 struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
 				  unsigned long clone_flags, u32 worker_flags);
 __printf(2, 3)
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
