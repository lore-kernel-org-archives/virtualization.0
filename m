Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BABEC433EF
	for <virtualization@archiver.kernel.org>; Sun, 21 Nov 2021 17:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A72C80EF8;
	Sun, 21 Nov 2021 17:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Shj4zPjBpXxv; Sun, 21 Nov 2021 17:50:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 632B380F1A;
	Sun, 21 Nov 2021 17:50:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A99A5C0042;
	Sun, 21 Nov 2021 17:50:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40DBBC0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 053394045D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="SB/rBH9O";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="seZuQF64"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymt7IajFRBQV
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B71D14043F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Nov 2021 17:49:58 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHPpo6007323; 
 Sun, 21 Nov 2021 17:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=W0Rytdc0l5QWqNp5tZ8p7WidQP/k88bStWgcvhD0LPM=;
 b=SB/rBH9Oe7DqnxGSN4RrViwU3e058JCPmgPr6iuwteo09m3y8tRRrHxsNqO3OAcFC/6C
 8SmxSoKg6d87pvGmUlDLG9+bBzbMGgPoscVSDqHh9ruR2k2Q8KK4tlyFtY3B5y+lZKso
 3L5c/Qq9A+mKovCG8dOlTujqu3328D1xOJ5kmbLnVcYZnopJqm5E34UciZDJVgvkv8E/
 4ftUoImAIyt9ojbK+jKF82ZWJGuoDo2LYQH/ySa5/qHdvstq/PiA8Ao5qSuj/DNzcCVk
 Ocap4yIIPpCuqd1+cQfxdKCf4fOd6fdXcKDmczrtazTn8m8NwtcBTQwecW5QzR9cLgou kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3cesjtmd5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ALHkUY3015043;
 Sun, 21 Nov 2021 17:49:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by userp3030.oracle.com with ESMTP id 3cep4vp60k-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 21 Nov 2021 17:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWz/qgtxtkbd+LEvE6DDyy89SGYqxqr+ile/XVWL8jANZHI/X7TH2XHWt3UpTiZTIvv3KVOvTOKv7Hn0LKmIu3AiFQRz9N+sr/ls3bJBBEInUSjAhUNDvW9WLSK2FQoUCNOecs2bANos5mfjz76FOKOowUsRq51asV9qOb6C+pM0cycoH1T7rXfdfbue/69DyXmCV+JelfEpW6mG3UQJ0zOCNWD7EosCv8rFbX5S0PAdaw6ACWLsmfWV6Qzufil7LYDMFZRlx/06duCc94DO10lC1Is3vl2HF5ZWww8CcOzBkdqYKf/snABUEQzKYzQ6tMUiIUkcElTCdfKh9oSUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0Rytdc0l5QWqNp5tZ8p7WidQP/k88bStWgcvhD0LPM=;
 b=M0kAPHs/XLd3Fy/8txnJC18Gv7k0q16wvx5oka282lraIy++KA2/v6SNTrVX5ArhnjJwYg/2FGfuAFuGzgCl22IsMddCTWDWD2v6zYIWl5UFwiiGELOsApXu/ygJYbWyzfIDkxl2Ll8HAJwLdllLBYTyvEvkGyZN8HM60ZdlZs87rh0HA4ltO2DEJakThktKU3u+dbS6UNq4jVeC21RsY1bGmMpz70+iXbLyYzoWCjAyWRVAmsyvtb7jHDFEwemWgpU4VS6Vng2MOBdNMhagi5XvuO8IUNYGmqPKjeHFICQjLr2WcTW4BZLQuB+pHijjA6B2PMYCLXY2EiE2tTxBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0Rytdc0l5QWqNp5tZ8p7WidQP/k88bStWgcvhD0LPM=;
 b=seZuQF64g4LX8cTyyo3JSSrJVXM0YoeD71bE1DZAAxZhpT3dRc1xP9u9NeacHs+Rs5yM0TtFiEDO35lwVtI9sfBVAZhSGDzUl0KJq7DT2cIj/WkOkB6EWyV7UtXogQEjwjkNVvYvutUomFcjYONO2BuI6jtqBRtfYvR66c9TEX0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19; Sun, 21 Nov 2021 17:49:49 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4713.024; Sun, 21 Nov
 2021 17:49:49 +0000
From: Mike Christie <michael.christie@oracle.com>
To: geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
 hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
 mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org,
 christian.brauner@ubuntu.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH V5 07/10] io_uring: switch to kernel_worker
Date: Sun, 21 Nov 2021 11:49:27 -0600
Message-Id: <20211121174930.6690-8-michael.christie@oracle.com>
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
 15.20.4713.19 via Frontend Transport; Sun, 21 Nov 2021 17:49:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ef1ab5e-3479-4bfc-242a-08d9ad175044
X-MS-TrafficTypeDiagnostic: DS7PR10MB5055:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5055CA0C0AB8C6915ABD694DF19E9@DS7PR10MB5055.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrI8ZVRKFVAI93odc6Egav/62n69lRpt5jrJlu3e6xZdXmf0PRCPJfxBz2dnhgV68Hbss6cUNKnBgILIc8GY6edEiIa+TewI57oVjPqKbOEHBMvhYTpIw/8UqqFPGKpFIV0u8DIKQZp6NZxCiQ/ogn6Lbt2WjIuqrKVVaPXCvkoGt5ii4btV8TQf2gRV4YsfxyQ41YyKw5cx4OvvBKYnpXNRUutnj6mZ2OBup8bjddLASLdkJsSOcSbYt+ksF6HTcyp61yzM/Wu9E6b08MO1PGUeqQv6VQ2/3lQQX1oM3DVLy32yazmGcnxwhE/+tuHzUiwRWP8+AX2u5IjHLoQcI+ShvtZ17alF8/5czyiv0nUQw90+MO/YyN+dONJ7YPdrTwGK4V65/ZyFpDRd+y/gjMemx86qvDxdTNZLGCIZ+K1LjfVgK9uTBaTMz9jEPaE6fKPnE7gSOllDCchRfvB+TURFBUu/dmICZcfgZA3cRqzTcSd189j75JzslRxbr0njA/+pXr5eAyNlPWrwQYJWl3Jizb+ixaKeo+IxHluzRkwO1pTDq+0sPspxmFSeyT5EAk4o22w4oL2ryY3sVa1oiA70aI8fAC1z64jzUqPrNAfusyeQrJCE3211b/6i1kfW0NdPeqfjpKfoYQzGTtp8SAN+q3oyeclGk9uBK/MjUXyvORaUvGlPJdLpDie1GW37h1cBHjDEZDvfP4ncPqr9Sicy0tSl4NMPQZtDjepqX9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(8676002)(66476007)(52116002)(38350700002)(5660300002)(8936002)(1076003)(2616005)(6512007)(6666004)(6506007)(7416002)(66556008)(4326008)(2906002)(316002)(86362001)(921005)(54906003)(508600001)(38100700002)(6486002)(83380400001)(26005)(36756003)(66946007)(186003)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ql0aMF6qpFeFR3Nt4E9yjIzPrL6Z6WBD7djEyPlinIrErlgGzmkKuuLPdFDK?=
 =?us-ascii?Q?sMYTqsDXX0DHDkeUkk+4MiBcpBWoNF5qCZgYo1o7pntMW+2+3jRoRcAO9R1G?=
 =?us-ascii?Q?tepFBBhy56Ra+zvT1TNd+icOGF6Up2w6hhz9iJYl0OM8tV+5fdcnKspEnMdm?=
 =?us-ascii?Q?T8TpQ+IxIECmWGLTgnj/aBP4RgsqVw0n9APqMkiGjWxFyAmlqx91Q2GN5ZvD?=
 =?us-ascii?Q?GfLT8RoZfeD2UJcgxQY4D6GeaER4CBYmklF6lbD71uyx1tnM9wXW8G2i70+C?=
 =?us-ascii?Q?cvG7Sy7qHzdcav7mBKQ8CzvsNUso93Jdm67DQ+GyjGILtHx5lnZfAHnGwJn0?=
 =?us-ascii?Q?FJg1EFMARtacreoswozLeBDqeRWU2FViiX2Nu9exIAdF20VR6X1crIDEjjWw?=
 =?us-ascii?Q?02qvSrpo7nHl85r2y9RSTdoHiyA6KtNLnnZV9FCNFDJ5fIPQOkK/Wp6o5JtV?=
 =?us-ascii?Q?gIOQ1d9mKRWvmsegS59aENp0W5dDFfrVrHiEGhiM0YS8WV/PlLvwHQan+Y5h?=
 =?us-ascii?Q?Wxd+ESO/neCV3CfwPUx4xljO8nj74g1cEYT3Qyj6EhgaDsI2AvOJFR9QWnwO?=
 =?us-ascii?Q?pbYJqUgvrzZ2pI7UBn+U3+Hr2ytN9jVKpX3vu5HcmAhSI+ChRRqZe3F4XZyz?=
 =?us-ascii?Q?g67NorPv5M8FKCivydlyjoyp0zCIMpg2wqzN6acNXDnU0i4yliIQfgxd+QE0?=
 =?us-ascii?Q?wLalgWkIlyM7TbVP5nANWutZ2+rBe1q13s+SvrKwmmISFUSphSOmFknkiuAO?=
 =?us-ascii?Q?mycECAnhC8FqobfdEw65GU31gkPbNaGeqLNo3w5g0Q5n+VA1Ui0puefZ+Vvn?=
 =?us-ascii?Q?o5up0pvz/w+n4rBloer8rVQxb6qrHIMzsmj3xG/KSMWezWJnQ48Wjla5Bttm?=
 =?us-ascii?Q?PXINgctSCPGf/3Qzlpf97PzwqaE1CyY04AZ+TsLT/9aJhAZzTIV7DkNJ7i0J?=
 =?us-ascii?Q?AqQmhEOL7/XD22UiDSBPnyMVJdZIM2kXehwPSxqe6zcxidNdkRMUadETY01W?=
 =?us-ascii?Q?F7NRl3tnR8P/iUDkwIpvOXYqQIXIsrnPxrv/W+Q9fSym11Q1cWjslm0zjc8P?=
 =?us-ascii?Q?XckyjqXQicqaYuUqWnhND3V/oxFf0wJ8mE+AbkVRmrFRCsGNnJEhN1m0r5/6?=
 =?us-ascii?Q?ypx+asFz57c5MG6i3Sk3YKjmB6es9wyPF7vVruGFfqxKBaCA0RW1qsD7qGI5?=
 =?us-ascii?Q?u4P9MBLL5x3beXxhTeAlqubpGweAgr8zcoWX4nPTlX7kh+fuGuzL8KMa5N9M?=
 =?us-ascii?Q?/cJ0qj5MLkvK2G0Ns5LTQw5CHsqZXLgcIsZV+YMcle25GIKlz6nqxXT7ISmd?=
 =?us-ascii?Q?oN9QQlXM5060xDOQFGXcHwbHSQQiks3nzhHj7s7OcoO4Ut6cH9EDjLFDpniL?=
 =?us-ascii?Q?uZpjdE8b9m4nBvxSBtS6WrRPF5EeEtpaMq915QOAhvs8YQTz/DCGl/PWFhCK?=
 =?us-ascii?Q?g8+zxF4CO6eZW/SVgj7QqEMp01qEs2zjv8AotpS6HySFwWrj2rDvT/JKQuf+?=
 =?us-ascii?Q?e0NES7mtdRGaHVAx86eMmEzBlQe5uUiWsnHajbbhyV6neVJCIRkvk++lKZst?=
 =?us-ascii?Q?l448NHZlEkBr//r+aV9lLhDWQXtAoRRpv0egQBjt35RBIUjdYtQBKfmb6K9U?=
 =?us-ascii?Q?pgaL+lkbgjk4OjzQdAK41rxGmEqzFG12uuCvgclD5RhhDtiwjDO8w/rm5PEC?=
 =?us-ascii?Q?UoKTxA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef1ab5e-3479-4bfc-242a-08d9ad175044
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2021 17:49:49.3471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtwmRTG+ARZE688MZlHMzhPvYjtuHedderyjSzqRPVABjYEMkh0IpYSP1pzpx38Ee/yA4Br8JAb9AOyuMo04jydnp3F/PYr5xPgOUL83fS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10175
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111210110
X-Proofpoint-GUID: G_kl9wNk__CWexunvymJeSEj5fgUr2Lm
X-Proofpoint-ORIG-GUID: G_kl9wNk__CWexunvymJeSEj5fgUr2Lm
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

Convert io_uring and io-wq to use kernel_worker.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/io-wq.c    | 15 ++++++++-------
 fs/io_uring.c | 11 +++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 88202de519f6..b39cf045d6ce 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -70,6 +70,9 @@ struct io_worker {
 
 #define IO_WQ_NR_HASH_BUCKETS	(1u << IO_WQ_HASH_ORDER)
 
+#define IO_WQ_CLONE_FLAGS	(CLONE_FS | CLONE_FILES | CLONE_SIGHAND | \
+				 CLONE_THREAD | CLONE_IO)
+
 struct io_wqe_acct {
 	unsigned nr_workers;
 	unsigned max_workers;
@@ -600,13 +603,9 @@ static int io_wqe_worker(void *data)
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
 	bool last_timeout = false;
-	char buf[TASK_COMM_LEN];
 
 	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
 
-	snprintf(buf, sizeof(buf), "iou-wrk-%d", wq->task->pid);
-	set_task_comm(current, buf);
-
 	audit_alloc_kernel(current);
 
 	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
@@ -704,7 +703,7 @@ static void io_init_new_worker(struct io_wqe *wqe, struct io_worker *worker,
 	list_add_tail_rcu(&worker->all_list, &wqe->all_list);
 	worker->flags |= IO_WORKER_F_FREE;
 	raw_spin_unlock(&wqe->lock);
-	wake_up_new_task(tsk);
+	kernel_worker_start(tsk, "iou-wrk-%d", wqe->wq->task->pid);
 }
 
 static bool io_wq_work_match_all(struct io_wq_work *work, void *data)
@@ -734,7 +733,8 @@ static void create_worker_cont(struct callback_head *cb)
 	worker = container_of(cb, struct io_worker, create_work);
 	clear_bit_unlock(0, &worker->create_state);
 	wqe = worker->wqe;
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = kernel_worker(io_wqe_worker, worker, wqe->node,
+			    IO_WQ_CLONE_FLAGS, KERN_WORKER_IO);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 		io_worker_release(worker);
@@ -801,7 +801,8 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	if (index == IO_WQ_ACCT_BOUND)
 		worker->flags |= IO_WORKER_F_BOUND;
 
-	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
+	tsk = kernel_worker(io_wqe_worker, worker, wqe->node, IO_WQ_CLONE_FLAGS,
+			    KERN_WORKER_IO);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
 	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
diff --git a/fs/io_uring.c b/fs/io_uring.c
index b07196b4511c..d01eef85cc03 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7431,12 +7431,8 @@ static int io_sq_thread(void *data)
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
@@ -8665,6 +8661,8 @@ static __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 		fdput(f);
 	}
 	if (ctx->flags & IORING_SETUP_SQPOLL) {
+		unsigned long flags = CLONE_FS | CLONE_FILES | CLONE_SIGHAND |
+					CLONE_THREAD | CLONE_IO;
 		struct task_struct *tsk;
 		struct io_sq_data *sqd;
 		bool attached;
@@ -8710,7 +8708,8 @@ static __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->task_pid = current->pid;
 		sqd->task_tgid = current->tgid;
-		tsk = create_io_thread(io_sq_thread, sqd, NUMA_NO_NODE);
+		tsk = kernel_worker(io_sq_thread, sqd, NUMA_NO_NODE,
+				    flags, KERN_WORKER_IO);
 		if (IS_ERR(tsk)) {
 			ret = PTR_ERR(tsk);
 			goto err_sqpoll;
@@ -8718,7 +8717,7 @@ static __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 
 		sqd->thread = tsk;
 		ret = io_uring_alloc_task_context(tsk, ctx);
-		wake_up_new_task(tsk);
+		kernel_worker_start(tsk, "iou-sqp-%d", sqd->task_pid);
 		if (ret)
 			goto err;
 	} else if (p->flags & IORING_SETUP_SQ_AFF) {
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
