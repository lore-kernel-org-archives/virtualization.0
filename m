Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750ADC0015E
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 23:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D8DF74056E;
	Mon, 26 Jun 2023 23:23:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8DF74056E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=LWA/GP6t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=hTLjhu5P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w_WnA4LIogRR; Mon, 26 Jun 2023 23:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7E9840908;
	Mon, 26 Jun 2023 23:23:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7E9840908
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 569AAC0099;
	Mon, 26 Jun 2023 23:23:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37E7DC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1320E60594
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1320E60594
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=LWA/GP6t; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=hTLjhu5P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0mFm8Skx_zbZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12A436059D
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12A436059D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 23:23:24 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QNBZ3H005192; Mon, 26 Jun 2023 23:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=jVCzNXAlb8zTBJalaea9TXxh3/qP2c4ZcE3jUg/z3cw=;
 b=LWA/GP6t2h/1rUAHlzbLWwBEp+lOZZo7bYTZkLSuq/2RH3Esti2CtPBEpCqeoETadJ65
 zFzOnQ9OlzL6h64R/w/Q/nKFIb2w+01kFp9BOrLr4yxsW0O6YiaNI1+PlfGL6EHNu687
 g0BPVRu6DhLGTFfLR/kYQpagXPVFvCAmbUsJQWRsRodGOeVlMhHGrS8SBFePJy023PVZ
 Ho0AzBP+LOiXDOHbAlvYEal1HGUvc6PHLO2vF7T3ryrVkgjt7sP696Rq0vPT6CDnPf4j
 P9RZ6h6rXJkZuER2OPniQglazbB7PJlw+e9X98RJzH3gqZwjLIJQiWCbdMeXXhlSSEm5 3Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdbtqm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:23 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QMJNkb028275; Mon, 26 Jun 2023 23:23:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx3rgcu-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 23:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA+CZ0s8M+IL02l1PKEP33xdIXfwVlrLtK//5amlseE7ou516rE9GtoQX+rLQUb7pgC9kSNsubnzZZhFUT//1FRk7tIXIN1xd4QixxtnbYrbHqNVjlMWuMQy+3kI4Hu28TAWB/oYJI7zvxXXoQlmdM91OOh2g2tO78jl0FqWCNljDRben5WUOtCX3A46QrBJVqo46nF6TXA6CF7DcBTFSY3oeiWN/vTDvWfFlCyA3Garg0PI0id4dPgvcddkrI0q+HTv9ysUDfUIS5bhkxFMvKk2BVzWhQw462ec+DcoTY5tYoaagPQ38nZKhYDIRlRngYeSJdMxrC3KLiuQB/T9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVCzNXAlb8zTBJalaea9TXxh3/qP2c4ZcE3jUg/z3cw=;
 b=N0IKENXrfVfst7bbK5+Q4UF0UXVuZdgOg5S4ght1pXhmWcj219iDXIoot+iNzC89gbPe8F3VbkyZ4YgPWuHvWAMMkg/Khi6sRZxENP/gbps0k3UehW+xPHh8LByGHIGRcSGyYJWu4D7sfQ6TErM6uHmUled3NEwUEM2JkM4OoXJ8QTKIZIl4nX+CL+jAEnxNLPJNKKiSZ/Cez9HS3qygUrGc5cUav86iyM5eaFtej1Qah9membH/MiXtzmF6QmaxP2/lNfj0QKYUcsXxy8eGI405FUwO8OI4TUZct6rR//lgkhMFQT7ojjAg5789373pRARUnlqqbaUDAeabfWinuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVCzNXAlb8zTBJalaea9TXxh3/qP2c4ZcE3jUg/z3cw=;
 b=hTLjhu5PSRjGif+HhA9PhextOmGLAs2zGCt5EFdqFycudYPdsZHMkCPB48HgaXzd3KLnbIQo13xdGQJImy1v1MlZLizfPhgntXePU4o848Ugzkth7P4YiPz1D9abfNFOzYrPHp4KvfmRvfVfhtgMk9Q/r+kyP1tEnvJsWmuBYI0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB7377.namprd10.prod.outlook.com (2603:10b6:930:94::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 23:23:21 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 23:23:21 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v9 07/17] vhost: convert poll work to be vq based
Date: Mon, 26 Jun 2023 18:22:57 -0500
Message-Id: <20230626232307.97930-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626232307.97930-1-michael.christie@oracle.com>
References: <20230626232307.97930-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::7) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 93dff7c3-361c-48ac-c978-08db769c5502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 165wnca/SNNy9n0LuVQjJTvO9CEvM9iC0SXHIefIQiMioxO/erRhx6lJ4fRR9Bw7FIC7t14okJTgsDZCCYmHm+KnxpkPcNR73gbxMSvMJYInPRP+9qpEIhQnIZyia9UsJaSh40KwuycG65NLkCvVQjR75xZtgnSwGJHzKVuD210aRTLVJPDrow8WobHiK97wxg0IL/6+esnr1w4pGyOsBgeVJlqFGDBsnpfz0nrbkXmlq7I/8ZfqeYJiH6T184/WUCh8zpFNM3tYQVdz/TOt6Mg+nebqLom1yLC/g3u0XImai1sQtAOq1mfO0+OKZJqknYdOsyHbbTBtWe85MHK2yUPN4WHLzmilxhQuaOiRMgyMMwlcPQblx7XDrVlY7OxzOvFDh6N5LYYrcCnD53L1/IxoBW0G5F3t7HaoGDOZoMiaCCYBslnXNPsWfU7HxVj95+EdCzpzTKOI+W0ownZruGXQQN2+rUzOTVrp1LdoSuAib4RsyE6lcmE+POyTPEvE7AnNrS96jgfGNeQ15r0cpwAky2b8Za4/QaBm0f+4UXwJne9tTs4TdnEpTKhCwbF9egduhvhBwnIDK9SP0tiWz7wfhGIp6LQbrGdHnjI9tqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199021)(5660300002)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(86362001)(41300700001)(6486002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(2616005)(107886003)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2iE1qfe/I8S0pu+rKpnk+3kGGniUYDAOdMSmeJJCWxMDAre46VfBeZuzibHM?=
 =?us-ascii?Q?i2Oa9EiOfZfv+l98L+/GbLr4LvilDgFcmyaXWa+OBcx+O6ClAw3I+TMhwOZk?=
 =?us-ascii?Q?1CrjvMvcKPAIqQWieU/iVarKNeE/DbR5/UePDFYd/LtU6lt6CDyJ1CZrKBQ8?=
 =?us-ascii?Q?MvKDX/pcY1ak3mAwXJp+Iy8f+S0wpBCGKNX3Vuls+3sQHfCmlgu1dpcRmYRA?=
 =?us-ascii?Q?L2wWOF0F+H3SC1uchg1sz9Hy353TPsKT9ExUItXNZkf9p1v9C3WmvtM8IfS8?=
 =?us-ascii?Q?nj3KLkROn7P8O1H9ekCCOXp4h36i2NS1y5ifQYg6kb0qPrp0n8uAHCrf6mLW?=
 =?us-ascii?Q?HiXnXWm1yD/l/IXEvqsw4WkYWQHFfgTDPWkDV1peMe08z7DZrc+06dJT3OKs?=
 =?us-ascii?Q?JSCuEFX6clBNlJIM7GGrpfjPYAIbsRNp06EumLPIsuu3ZpyjBoS60ERet2Av?=
 =?us-ascii?Q?uSBGtWQS6vWWVmKGLaA8Byb+zDo3cKU2Qa5M9/2XOjCjB3hY3xi2k9yuulaG?=
 =?us-ascii?Q?1jl55tVFrpqTO4yJMay8YlIlc+07oBqoSveRjTT8qb6nTXujIjtWWgW8xTn1?=
 =?us-ascii?Q?B8D//C+KewPEJQJt5oGz6id9G2VMkhZM3+/Z/lL48JOELncxAAqNKkeF1MJU?=
 =?us-ascii?Q?Q66CmSnhmWAM1pRjL3wNvyosmEoNDW+5uIQ1mco9WA7G/GUvdNYSNqRVivvZ?=
 =?us-ascii?Q?H1cCNl/GNoMqE+wzCu9AemjUfsnuFQkXPm6rrWWrgp1e32ywVGMUZh8wirZ8?=
 =?us-ascii?Q?EIHDhkVRmWkKoKzHbIqSAn9fRQft6Y4FeJYVfAFkIZqPRiQ/aLfZ3uGSGBqw?=
 =?us-ascii?Q?Q5buKUyDJSEESalyLVzu9NaMUU0HK0r4fC7YS2vr8ifi+ShY8aFRr6TD7J9W?=
 =?us-ascii?Q?yP1Bc2zpt3OtTZJZ6uE6WTkiv23A1Cg1C97hKMeD/xCoYyYIdfz8z4xSo6vs?=
 =?us-ascii?Q?JwU6fB2klBmNIT30AlYxRldJTkryKZaYyvHz8MbXrXKVRTjdaUqH0/Vijjj0?=
 =?us-ascii?Q?+t271FLQuE+8iTb79T/GHWCAI6GShkZfniqBUmrm8HueXcnh+BzDsKWNjby3?=
 =?us-ascii?Q?3urlQrGeDXimDKE/ao25K3uDXXHRkKJoFxYaEUaTZ+ZLuGgF7P4cpnL/u1RA?=
 =?us-ascii?Q?jJxk3Ap5j7o7WMWaJczg+iJFqJ2VkEPF3ma2K9tTV0o3P9kxVkdgqiYr/IkM?=
 =?us-ascii?Q?MDJVoxN6BopSafRfbBTHRq2td1sNvX7N54txN2mELnCmKD5xlivwSF7X9aoz?=
 =?us-ascii?Q?FnbiGi6Ov2/8qTD7kVIuko9PZ9VyM6KA0M9xXH1rV3hzryzxL/7aaVwFbVGT?=
 =?us-ascii?Q?wmiN0hXCv7UdvgZ0xobGLjOlcxs8SnXxzb2zow4sFGAL6fd0E6rV0ZqLc5+9?=
 =?us-ascii?Q?X63eUdEuBC+SLQxQNiNNi0mr7iGvhkot4KjgLNf0CIYektiNpgDQNrLMPJNH?=
 =?us-ascii?Q?PYiKcM0U6t72HnDrK7xk5ASI5xpW0TtLGlUJ1zV6twBhDE7bCGmVp6zoc8tE?=
 =?us-ascii?Q?Rq+R5KKhcl52ZgOBMYjo/mX6Q1bvkTvWnKLTtt21zD4ScRsb8tUk8DsFTNiR?=
 =?us-ascii?Q?cKA8Dydv4RjkZKWrpdOeivoTa7rDsqgy0WCyV39uSPSi1OJkn1fut7c3KEIC?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xn51OK4EYeFBHY+vmsC/cEHYz9LXWwbHJhX6q8lyz2P96W5/b5o+inoYsJxXwRAgM1w4saxmIHutL/pfffh47kwiVKzpeoEDYAOfrnMV7KKm6AAY6acUMP1ybf2xtLgGqqwvbRkDygqOgM5uaSYmfglyLuLM43fyQjT84X1aqQpQ4TCnMNR60L0LsDUjoDSaDN/23O3+XRnmyLfmenvL0MfVbdt62QKIGu1a/5Uaxto1gsF08YmgLweXztuYvC/lnU0t/1vdJvgVxFTCsS42UYVCeN0JkoKfG3b07BEdlWlMLX2achYcdKYC7j3OPZNf9lZR/YmtA3Bzv6GY95AP8bvlaRb0wOapnJRrKFel9o6FYSvittyyBxKYtg87w3c8d/ZrLNFAGdHMQxKTa+xvkpoZaeNLQbpdBQ9FDNBk/nQlXD4dWcWfm0NI9/wE2CsuJUpmE867Mu1URax+TNOrcRUu8NLt46rZw03kpkwuF0x+eeX1+YKjLse1ebjw1VO5jfMI1nkgU3LfHMkPbOGtCLIUBso24wYcg26jlLAMPusxC+kE1CuHiYv2RX1GwCZO+/OT5jrpAwXIpHvNO8DdjChMN+XHFI7Ohka33bqCxTbvnm7VeVeQ2U3Ax6ylkAYgPZU80HZg2hlwhU+XKCdLwAgKLdcdUvrqnOTbnI+K85UUETvtgMDafxVFbYcr7Gt2J6ovRQFIg25yAAibd0px6xZXV4vVNz+VQ2bf4m/lWEpMUDbRbXH1j2dUu8Kr07BQIgiQTzU34oQvTQ0WkzANADfBx81fTO2nU7UbX01mfzS8YJrsu8wBA3qWWP5BxS+T
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dff7c3-361c-48ac-c978-08db769c5502
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 23:23:21.7269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+gNwO+tXB90fdKgWv8OUknKBH7smfOonow3GF6OgyVT4DXuBzCQz9hU/vP0EO5J/+1CNWjvI0xHgO2zP0elPCbvFOcfdL0pSurHbx3fLHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260218
X-Proofpoint-GUID: RxDy4foyXjivoaaqoYJ2VGBUMfIj-0yY
X-Proofpoint-ORIG-GUID: RxDy4foyXjivoaaqoYJ2VGBUMfIj-0yY
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

This has the drivers pass in their poll to vq mapping and then converts
the core poll code to use the vq based helpers. In the next patches we
will allow vqs to be handled by different workers, so to allow drivers
to execute operations like queue, stop, flush, etc on specific polls/vqs
we need to know the mappings.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c   | 6 ++++--
 drivers/vhost/vhost.c | 8 +++++---
 drivers/vhost/vhost.h | 4 +++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 98bb957eb3b9..f2ed7167c848 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1347,8 +1347,10 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 		       VHOST_NET_PKT_WEIGHT, VHOST_NET_WEIGHT, true,
 		       NULL);
 
-	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
-	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
+	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev,
+			vqs[VHOST_NET_VQ_TX]);
+	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev,
+			vqs[VHOST_NET_VQ_RX]);
 
 	f->private_data = n;
 	n->page_frag.page = NULL;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2ea107e867a1..b6149ed8acb4 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -187,13 +187,15 @@ EXPORT_SYMBOL_GPL(vhost_work_init);
 
 /* Init poll structure */
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     __poll_t mask, struct vhost_dev *dev)
+		     __poll_t mask, struct vhost_dev *dev,
+		     struct vhost_virtqueue *vq)
 {
 	init_waitqueue_func_entry(&poll->wait, vhost_poll_wakeup);
 	init_poll_funcptr(&poll->table, vhost_poll_func);
 	poll->mask = mask;
 	poll->dev = dev;
 	poll->wqh = NULL;
+	poll->vq = vq;
 
 	vhost_work_init(&poll->work, fn);
 }
@@ -297,7 +299,7 @@ EXPORT_SYMBOL_GPL(vhost_vq_has_work);
 
 void vhost_poll_queue(struct vhost_poll *poll)
 {
-	vhost_work_queue(poll->dev, &poll->work);
+	vhost_vq_work_queue(poll->vq, &poll->work);
 }
 EXPORT_SYMBOL_GPL(vhost_poll_queue);
 
@@ -508,7 +510,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vhost_vq_reset(dev, vq);
 		if (vq->handle_kick)
 			vhost_poll_init(&vq->poll, vq->handle_kick,
-					EPOLLIN, dev);
+					EPOLLIN, dev, vq);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_dev_init);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f208f9923c88..3882266fbbf3 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -41,13 +41,15 @@ struct vhost_poll {
 	struct vhost_work	work;
 	__poll_t		mask;
 	struct vhost_dev	*dev;
+	struct vhost_virtqueue	*vq;
 };
 
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
 bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
 
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     __poll_t mask, struct vhost_dev *dev);
+		     __poll_t mask, struct vhost_dev *dev,
+		     struct vhost_virtqueue *vq);
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_queue(struct vhost_poll *poll);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
