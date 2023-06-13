Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495B5C88CB7
	for <virtualization@archiver.kernel.org>; Tue, 13 Jun 2023 01:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6885A408DB;
	Tue, 13 Jun 2023 01:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6885A408DB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ELiZKAv9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=N8bZg6nc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l0YRau4e4ewV; Tue, 13 Jun 2023 01:33:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7F460405B7;
	Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F460405B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BB43C0087;
	Tue, 13 Jun 2023 01:33:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F624C008F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 306DA402D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 306DA402D5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ucrMHCxK7v6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CA354029B
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CA354029B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jun 2023 01:33:18 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35CKNjCC020940; Tue, 13 Jun 2023 01:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=fQMzSnpzvjoBtBpFADODVj0Sb32b+vHjVxQ6gql6XvQ=;
 b=ELiZKAv9InZJyRZMveq3UdUGA5Smz1eM8j3BTtZ6mAut/DAQxUb8ORZaj8m6UnOPC/4p
 /HPOT0Q0oXGN9VyexDLmNnXab5239Hqmb4yHMlUgaTYmKTNRD1kdpV1Izrkd08aDhu99
 YKuUY9O/q6lZ5mAT0kMO6lk5u2RbBHQcl+HfPnJl11peG2pq3XJMCwldXPc0xYKqY8mP
 NRtd9Qd0wUdtpOt/Sz8j0X7iZHSeMbz/X9hp3r3/8lUAnmykf4IrMF/TWZbOVIcfNr+Q
 9pQ3knz7umliuy0peQ6qP2BC2vV/VVDSe9Z6AfZiOuZIMhZ3vni9icwgIntnrNktXSBa +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d451g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:18 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35D1CJRF021613; Tue, 13 Jun 2023 01:33:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm3hg44-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jun 2023 01:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O92bRjo5e3sGeCpcVfBh3lwkhKcGgwpB4z3fndzMIbaSB6n2DHitRUQ6/axH4v+lpjK5iemO5mwiEPMiUEohOpxls05Zs4S1n2hGMEWJtHLVTRwLnCQoFddKmzfcz9U82oaBitVLIAWwmmg/xtEyOyPZPiUDJePILWD1Bw1liWPJ3S7qZEMNIPcQAtaFfqqOm12RAvi7ZPB5insEkoQCFaswQ7R0mIjfW8EcSdEWHCVMbawf08YOpahzKVvqeRjHXF6xsf7kmW2GPExMC+yWvX2fUKWIcXc09BIrLQc3BFrTMXdzIlFiZHsPC3UoCnYpIOGXM6Y2WBVQ6k3AYRUjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQMzSnpzvjoBtBpFADODVj0Sb32b+vHjVxQ6gql6XvQ=;
 b=C8Tw+Hb7t3vhRSL8wUGp3SSe2k9h2usUCqa0Ash0pci8yatNoaEre2gqYS5gSDYapP/h0SjFGylhnLLJu4u9k6Pp/OUdNOOe+m4joHEUviOJbEjM4p+qPRYsMUoVecX8R+BVrea6QEES2qhW+ERPyKJr8fde22C58EmbwhkZ+EveIebFlSinLNgWVhoOF3+LqWKEPzMeiiZ5q/kB6/8H4SHl5RQwR3o/mDRmgkjZ7UQKL9/sX7ORROnLuT3KvtGODjexJtStQPvBp8sr0T+7MdzUCdtyAZpStnLp0LdQExvhAcgv6Wyx77X7JC5xRpfscASOHMlH8JQlRqJFwLsD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQMzSnpzvjoBtBpFADODVj0Sb32b+vHjVxQ6gql6XvQ=;
 b=N8bZg6ncbk7EfJVnoeLTX5Atwk+nIbme07jvRb9P7t0ZSfPHvcRc0FF76Y8nGbF2o2aMNFtxYchBQDFupNd/YYlNJBreESpau+raU0cfpJWTib4xn7X5nSVH9JcHeuR8aY+yoUk0htJ2pnQGpmDGr1J0AJTZS/0oujj+AT/f4MY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 01:32:59 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 01:32:59 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v8 05/17] vhost: take worker or vq instead of dev for queueing
Date: Mon, 12 Jun 2023 20:32:36 -0500
Message-Id: <20230613013248.12196-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613013248.12196-1-michael.christie@oracle.com>
References: <20230613013248.12196-1-michael.christie@oracle.com>
X-ClientProxiedBy: DS7PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::34) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e66b608-73b1-4b82-36d7-08db6bae1ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1oqpvxH3HLQygDzktrxhGdixEZrOOBHFym0mrPn2j3sPQTxB6fgT8j2rW2Y7ut2eiCEeixZwrD4j/+3jNA16TyFWLDV7dAJhJGkJOdKkHYgxk5w8f47mpEGR8EYkk507TL+Vkk/H1iUuzHR2zRWV0R1egSHydL9hXbUyw2LTdx4d2VSLyIsBNJzN//GHFAUsweglc9iON4hIj/qDAwOEdQDCj4EgEVP4GOtdLckOIXnqCYXVP1cAMrJCXugd9m9vO1luXNL8b1Q41S8WR9Jm2zemGPYA3MphztuuMhq65Tuye1gHZ5DlU/sGQTjteZNE+3MF4aXnvksx9IiorGlOhPb8bZKc+LnJAoKCpxYSVzlAuq75B01/D3cdolqD8RUdUS5TJ6lGdAdd1bieH75qh4ZAX9ZWntjbqts8HYkyw05kEOZe4gZEJDmoVp08j1GjmkInwHlVOdxC+Gzh+ZnXQyKlUaNKpg7wc4mRQm+cxjpymksa3qH+DB5xfh9UUcx+/irydg6y/VlAc6Bhan1SwCoD4IJeY5wIWcae1Tlvd/aQMZ7vfqy3ywglTiGLWgZ1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(36756003)(86362001)(66556008)(4326008)(478600001)(66476007)(66946007)(6666004)(316002)(107886003)(6486002)(8936002)(5660300002)(2906002)(8676002)(41300700001)(38100700002)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uSNMJ1TmyMRS/oJZzyNXbfCmSoKQUx4yZ8flErk/6aseuIB1SJstNgzl/twA?=
 =?us-ascii?Q?buySpZnVnH1h7CCChq6yqkUYfa1ttEERt/I/Mwgk0YYWtVE4h2XIZxCuFInN?=
 =?us-ascii?Q?9X+8y5kJYvQuwrcwHtGdr7wHS9t/wRwA53zU+mb4lcbcSZesVmiNKpC1jY15?=
 =?us-ascii?Q?TzSbisgCb17tjnpy0KcNFpMqBN08XuSuNNIFv/r9TSLz4eROuLhBFxf3OmsO?=
 =?us-ascii?Q?e7Zcy13FcN0d5bwDP/C2EYC7DIDDJ6xaRowKZ3cKpCiybEHy7QGw/PWTvSvp?=
 =?us-ascii?Q?yPQOE9a4rphS/ErOC4DB+or6OfYsZZtR0RwIcgmq32aXiEhjtL7XzPTW9ke0?=
 =?us-ascii?Q?DcPTRxsigvB31wuy0sz7DPH7daUAnXrbZDtQTZwHCI1aon6n5oYlQmsXrJJ2?=
 =?us-ascii?Q?Lg+eZBzkf5xNtSesysISzIYVBRSPgtvk/o0zh5lfr6sqBN9k52lksDmjC4oy?=
 =?us-ascii?Q?12E2VT6MZyzueKNBszg8QVd8nLPg5p5cEKCLuJg1gkvQbzbdEtyCTl5thwAN?=
 =?us-ascii?Q?JfMFyvlZ0aWHiezyj9u7WJws6RqeZWJHw9nxFXoVXP3b5FpfsvEDzMmR7A5A?=
 =?us-ascii?Q?p+RHuyhf6zCi7SidE9mUjS34CpDDdRWt79lUgLGMvBXt/juKfOIzXkWtZGqn?=
 =?us-ascii?Q?ZDPLYeaQpEPrFpafYsoZJw6EcxlsEBzcPYuKzRYHPzVqp1iCFRFClyQXHxn1?=
 =?us-ascii?Q?sMuoE06MOmrDhfORJFphrPbFJB/euYp3o6chZ8TK0723swJWGwmOow7hugHY?=
 =?us-ascii?Q?2rHMXVQH3v5oEiOeFszXmKevfmzmwv9m/WWVVP7k4Jw/TbJdHlzPe2Mri8C7?=
 =?us-ascii?Q?dHRnImXs08s9ZUFdSYr9wrz0faRJbjwUlOTKvj/FO8mfSi3h4KcHWiSC9n7b?=
 =?us-ascii?Q?RAt7DVyaSb0XfLPotvbNIbkoq7opEOmdCOdQA5fqG/xy0ywqhC/B1FwOc8cA?=
 =?us-ascii?Q?ubKOG7R8PzCKVwpuWrZ2GhIXPksP91R1MTq5rQSGEoqvgNSZjK/auU0IPXPn?=
 =?us-ascii?Q?tjIsr9i5lsz4iiXy7pssDrUTdMCf/cnYC6m8tnIQGcL9poPPuIacY0g68Q7Q?=
 =?us-ascii?Q?ZQXjPHQPmODVWUd9nUBz9IRmkTeqD4bFaS2lATOKZjqnBj8Y9Xeu6IvsI7BC?=
 =?us-ascii?Q?Y/zLCf1z4D+ZQiBnUF1oNWiUU1lWLieiOOUo3vorB3JMt8YEVRWwFPq/zFAi?=
 =?us-ascii?Q?9G9083m6dMQlF2EDdaeKELomiL1YPPFpNJaBQPvmUcwex0iOU9/yCa8VGoGl?=
 =?us-ascii?Q?37ZAjB7QIGo0v186aMzSOzs/wAM5Su2zbfGwxeI2W1rdPdFSv9pHc2dr5h77?=
 =?us-ascii?Q?Bmlb0g7n4L0nMy17984C/SfH4H2UBfiYICG+fWiFuL4lve+fhfhLCvRlC5DC?=
 =?us-ascii?Q?eTSZiJqUoth92uPtpZpS3AlkEr4NHHxXJq6cOVhNyN+YTo1AP40NDhyRhozf?=
 =?us-ascii?Q?rjBj3XN+Rj+PhJ9cWft7LtNpWdCC5z5UjpnQqqZSTrR+wniMODJ0rV7SaH1x?=
 =?us-ascii?Q?DAGd/9Yfp5ZOtgogIk+AH9trwPqqj135awz43UroxzJoqMP6XP4e8yu7D2gw?=
 =?us-ascii?Q?20CuBkmcytnl620K0YkldhWPRlXUq9TO9hlJEMz+6u5IuK3UOk0a8EmtmNhe?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DDNSSgOq6y0xeVs4Xr97ZJ7+/VkOYl6lgmRgNldXkKIpodCgpLOaxNn79AhrUz6XkLNkx/aSf0XWV3iEB8fW+XKnFfc8wo2UuEy1FgcGxgGYZF1emcZTzn2qz9/TuF0bh9ljoWaIS7n+pHMqCII3RvEIMzLpp1Kmbgme/ir+sjA5B6XOQDLi8e3L+k34sAeVGxmNiaTHAgZVuRSxt+wSbzEZKHrtqQY0xCL6pseVtf+9vv0JDy9lgrW97wEBxR/zJEMijbMuulV/90UYRsHIUndl7LE5l+yHK6ndnHnuSRwQ7oWt9CsSxNfKndM08sZnbw1SANPTlEudEQq3a1LhgbT0SC+lyJ95RatZ3cB66Gc5SQRSXWI4qkv1E2IGSTrqoNsGgdC4aaFWb+NprwCupZcFTejHlAwwde24SmZrr4hOjqm6oOiKfudEaIcUiCdMleQxiZJby5LsVa+C0sxG0NJTBrVEoQVVjJse/Qqlr5rsIRFQrJogUhpbAknMphCtCOLTrdxsETBUzWdY/Z1rfAqlPXGhx3X2J2Gq2ljwQ6vvJdBhDlieXfLxGjCAz/UjiOsFpyD/pXZc2YuMDHyO7WBXXsPZL2CP45WQqKzWSq0zePdpZlZHjfyMOvRa0wF1hw62vIRHot7wgOEQbcO4+nKRhs3toXfeLYUQlNlX026NGqfo+e18GOT+F7DZkIRs0cInzUu20rEZ69O0R0J727SaNW1WYDIBM59EZ5cGxDuSo7hG1biaH6acNrylnSKj3QwpW5eYvISD4f6l6pRBlXdb8/5/L3tWS4LONPtQW2sypIUhZS2JfaELrItBRa6V
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e66b608-73b1-4b82-36d7-08db6bae1ef5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 01:32:59.2232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3O2OzJPl4CuRsBwTH7fNJbWG8wLaKLKTyCEPKBMZwkoolm657Hi0xPOCUaQfUUJKmT2eaDgecUOCPPpINTnOxs0eRh0vfUvfA5li7toI0HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_18,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130012
X-Proofpoint-ORIG-GUID: 2cpwXx_lJU-J47fc5nppckM2u7vkfMcA
X-Proofpoint-GUID: 2cpwXx_lJU-J47fc5nppckM2u7vkfMcA
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

This patch has the core work queueing function take a worker for when we
support multiple workers. It also adds a helper that takes a vq during
queueing so modules can control which vq/worker to queue work on.

This temp leaves vhost_work_queue. It will be removed when the drivers
are converted in the next patches.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 44 +++++++++++++++++++++++++++----------------
 drivers/vhost/vhost.h |  1 +
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a832ca692eb1..16630c19bcc2 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -231,21 +231,10 @@ void vhost_poll_stop(struct vhost_poll *poll)
 }
 EXPORT_SYMBOL_GPL(vhost_poll_stop);
 
-void vhost_dev_flush(struct vhost_dev *dev)
+static bool vhost_worker_queue(struct vhost_worker *worker,
+			       struct vhost_work *work)
 {
-	struct vhost_flush_struct flush;
-
-	init_completion(&flush.wait_event);
-	vhost_work_init(&flush.work, vhost_flush_work);
-
-	if (vhost_work_queue(dev, &flush.work))
-		wait_for_completion(&flush.wait_event);
-}
-EXPORT_SYMBOL_GPL(vhost_dev_flush);
-
-bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
-{
-	if (!dev->worker)
+	if (!worker)
 		return false;
 	/*
 	 * vsock can queue while we do a VHOST_SET_OWNER, so we have a smp_wmb
@@ -257,14 +246,37 @@ bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->worker->work_list);
-		vhost_task_wake(dev->worker->vtsk);
+		llist_add(&work->node, &worker->work_list);
+		vhost_task_wake(worker->vtsk);
 	}
 
 	return true;
 }
+
+bool vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
+{
+	return vhost_worker_queue(dev->worker, work);
+}
 EXPORT_SYMBOL_GPL(vhost_work_queue);
 
+bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
+{
+	return vhost_worker_queue(vq->worker, work);
+}
+EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
+
+void vhost_dev_flush(struct vhost_dev *dev)
+{
+	struct vhost_flush_struct flush;
+
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
+
+	if (vhost_work_queue(dev, &flush.work))
+		wait_for_completion(&flush.wait_event);
+}
+EXPORT_SYMBOL_GPL(vhost_dev_flush);
+
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_vq_has_work(struct vhost_virtqueue *vq)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 37c183b37c42..6a1ae8ae9c7d 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -198,6 +198,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct vhost_log *log, unsigned int *log_num);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
+bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
 bool vhost_vq_has_work(struct vhost_virtqueue *vq);
 bool vhost_vq_is_setup(struct vhost_virtqueue *vq);
 int vhost_vq_init_access(struct vhost_virtqueue *);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
