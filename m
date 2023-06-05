Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F93C7EE23
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 18:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25328820BB;
	Mon,  5 Jun 2023 18:57:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25328820BB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=imUla9Hb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=eZmyEBTj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id juuILjnvOPE9; Mon,  5 Jun 2023 18:57:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 86EA88208B;
	Mon,  5 Jun 2023 18:57:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86EA88208B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6186FC0037;
	Mon,  5 Jun 2023 18:57:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7312C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 18:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7196841606
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 18:57:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7196841606
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=imUla9Hb; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=eZmyEBTj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tUWXWbroeymt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 18:57:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7DB841605
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7DB841605
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 18:57:37 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 355HiYvC010089; Mon, 5 Jun 2023 18:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ohI1Httff2neEuS3GHeWTYFULt8gvA9EymRQ/Fzn6ho=;
 b=imUla9HbC1dQYmcgjIq0UP/ruxgkWBrXPDeYgrd3ydrYGgs0he8Rw+zDEcwyoNg2GT4X
 9XX+5ou1GyjFPui5Ie4s8RLbvHvqA3G49DlrNqn9a+UASb5OjK5QAKgzeotIFJVPK8J5
 fExkSk2BRcm95FmFNaUlYw1hpM7xFCnGQvK32gEiB65EJ8FsUWq2GdyKjRDySXODXz5a
 6uPIpOytLAZBA/QU9iiYFahs6XgBkI90V9Z9e2r6tNpls1t0/gf5lYsEpcSr2X1xORIM
 3Eom43NfE7cpTvOcw4Q8BfiJ2IarJGR+T4kBH7E204wIKXcLnhRIZeWCbwBwEP5itCyi 0w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx43umdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Jun 2023 18:57:36 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 355HFI5S010817; Mon, 5 Jun 2023 18:57:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r0tjycmps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Jun 2023 18:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ4d4rPtrd+ZajrSzWcWl0yuXT3RIiAW1zqaiiIX3t9XDUGoFPQaOeBq8R4lEuOT7WiGHhKOTdGOzmYiOQ5Adpmmj7UCHeply78awFUaVgMQ+m7Vd+b1l8gUA9o8VHBDAg73xqiFOAg9ZtVZnlyJz6GxZrFC8vIXAYxk56usPSWTAjZes6fROicnVTblb1rxrPcUv5y6YqgZ2gAky9OAjyXZ2ner/nh3avdbxmdtLF+RM6u2FkML3aez4cwhEIo/G9C9UHxXNa1Cs1jKgrJ2orYaFqKQLCwjrF6SPP6cgb7Htm+HK6BVc+YNwPmLsxq5NLLRw3uuh6Q/cfK15FGQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohI1Httff2neEuS3GHeWTYFULt8gvA9EymRQ/Fzn6ho=;
 b=ZsnLvFHVc3/AwvuAB4nAe54LZaDC899FuNmy182fnwqsf1o7wzdEuOdqkndcsXoAlNMCRPIL/tTfSi0sCPMTQNH8+HyjkiQfU0Lys24U2LdZYwIUvoe38/KV7VRmDqNTcgngV/VykUgBbS8MwxlGJ3DUkSAs6vCxAIX5j095BcBUyevDRjWXDa2zs9kirpclvvAmzsxLgOA5tMCv6DXB/jcKdOStFruUfb/AuuVRfaVYAVWQeR9STcx32Rx3DAJuCxaRvTbWL25WFtRTCytxyZEDSHdmgsTI810Z0G6W6JiecTyPggYMVUGZvhJeJiy+nfdGZn94/ctIgUQbfSQYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohI1Httff2neEuS3GHeWTYFULt8gvA9EymRQ/Fzn6ho=;
 b=eZmyEBTju9O2tkb8F+XxH6BhuSytdi3iLkKBfOD6Cc19hyp5+6loDN33Cjm72Xde53ZwHuBhF5Ov+O9Gh/Ofap6rkcq/Y70410ykt4M+eiJsmBTVm/o32E2PUihmQlNpXUYd14vbWlnIyJuSxkdsKg+B7VRy9KLAg4PuZmPfZNg=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH0PR10MB5869.namprd10.prod.outlook.com (2603:10b6:510:14b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 18:57:32 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 18:57:32 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH 1/1] vhost: Fix crash during early vhost_transport_send_pkt
 calls
Date: Mon,  5 Jun 2023 13:57:30 -0500
Message-Id: <20230605185730.6560-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: DM6PR02CA0099.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::40) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH0PR10MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: e3362aa1-0dc6-47ff-6588-08db65f6b7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGg9RmGyS8R44EEwTXhNwWdfZZlyBFafNC+YRZ1ngB688ySEFtoIdr3vcaZhUBsza0VqGCU64NkcQZh8ep6gOrrSqO8agkGrKfVcmNfmprnLNAvawOhgmMmEL/whTJ+8LjJ38NefV4VEQQy2JZSuvHIPbHKNl/Wgl0z6jR8GwYlpawHmoCrK1QgpF8x9ILgHXptOcZhIST4N92puO9QIJB/E1U4ZuxQxgRPm9VKq5z9JLAvaGAAHfcyddctccczQsA4pACEC1WrI/LwtxBQKOoXTMUS3umYp6xY5yUJZaczaBgxtKt92No7R9YjD5GV2dHOhqvoHHG/eDYbabIUusyKAJH/iqqj/vlC3ZvvdbyW+av0lPaE6nZgRod8937ssv8QwRMPxQWjqjcjkoGpHJN4BqOyRAmpWapG1jbVlLDilBakhiFHMXclKEeeDwbU4xwHVT+SmN2b9k0rWYml/3VGx3yJSCMBBOyOao9KCNZwBmNAN9AYfpARPOTMa/zRKl/1Xumh8dg1dhUw5jCtrjQIyo6aSqoFUqUN9qv5DEVoqVVbH/heomzLyP3rtoNCi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199021)(83380400001)(478600001)(8676002)(8936002)(41300700001)(316002)(66946007)(66476007)(66556008)(5660300002)(38100700002)(86362001)(4326008)(36756003)(6486002)(2906002)(26005)(107886003)(186003)(6506007)(1076003)(6512007)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KNp3ihSturwi6ElJH+48mVZY3e+v2/FQTz1KVuvLaKWCpWBW5utkNi59ajUG?=
 =?us-ascii?Q?fSyHC3aECaWDl5x1g3+vvB1UK0SncEGLtZ0NqRMrcPf+9fmYent2DIfegjsw?=
 =?us-ascii?Q?PINlcbd4mUzeufarQuaOQzAXThHBekf99jF0ZEjliU6+0i11caGcO3jUNzA5?=
 =?us-ascii?Q?UMuO5pjiqtTFLW3GSaj49K3QGwT/tpCVWQifHveJIhRlQICdu8oNcaSCQpIt?=
 =?us-ascii?Q?kU80Iu5fMaexHzqTC6tjnY9MetJxDGluozxdWNS1nKWbO/2lTsOXD+Yrf44Q?=
 =?us-ascii?Q?D725zw1jcQjESLJc/LUux2RKpZU2xVVPOkHWVTasTKDNgKtk96nePjdNX66l?=
 =?us-ascii?Q?4Pnm6Er6CjHGyCd2NGFlZziMSDDgweifAb5HWqGiELl9RFzJB9p7YQHE1hPj?=
 =?us-ascii?Q?+64kaUBlbucgLOESkKoBmZfTlC2xFDlmX6AnzSjOpOseoFI4c7lWtPvkP588?=
 =?us-ascii?Q?KnYaqvsF2L4Tq/keVIgTKTTlAjYOQAlIil3FXaj/vOeFoB7LIIzAf7t0oZkv?=
 =?us-ascii?Q?JVSnz5WCUZMXFnbTzPugHb69LKjUZw8TdcbFSfYw36ehLYLPP20bfyOymm47?=
 =?us-ascii?Q?4gMJ1jQKwmG6JrqYQFTiVAPkHRogFNnMIUhZhK/3UFMI9BsmgRnSU0h8nAAa?=
 =?us-ascii?Q?ieSrapTNF8T1ZsOgrZKSHnQAid79a53/mDJ/eOQMBxU0w/eRwswZREevp1gI?=
 =?us-ascii?Q?orPnHkP80uTuqZdbe7cspMo0XV15XzTvcfpyipPcyue7VWeXKQKX26kzHSZP?=
 =?us-ascii?Q?7nmyWq3HRoYtOCrURsl7XsSdj4d6qaGDhHvnyKr59sMsLQexfTtdpbf3eCb3?=
 =?us-ascii?Q?gwyQD9spFgVbwfSPUOQtfOpj44NQrF2OANKoWMnW5JTNgsFurdonW0pHNPfI?=
 =?us-ascii?Q?NVkyDfK6h0q+hG/GjiyLz9VUBdDWH3SmsNahua5n+kaRPThlV4oljiHZGOyZ?=
 =?us-ascii?Q?pvR5G8CO5KV9bcU0damtV4awrT9nQMh0du6gTKhbh8lE9Wny2zsLBFl3r8vx?=
 =?us-ascii?Q?RTRJu5/tthI6ev3jSP87JU3NZzOkC056GQumz1Ji6FE8AtAchISPA4ssyl9Y?=
 =?us-ascii?Q?5AzBZ8G8+Y/fu1wqu7kWUIbtBwhISGfDuXe1K1U/y0jaw9/qHmAHBB/s4Wpv?=
 =?us-ascii?Q?qo50s9wqlY9/mzRtA3veZSxJkj2KCyqoDw/+WMTdkzCTGvSR3LTWk8MUFE21?=
 =?us-ascii?Q?W9Z5g5CeVd4kgxrYcmzqLa+14VTXM8mXPObi22Eul/Mc3UjfL590gZ33+vR7?=
 =?us-ascii?Q?IZuIw7VVTIgtQUJglPwVi1KFpbAs5WUKKiBXdBKJTWxjIvmI3p1VBRq7KJs7?=
 =?us-ascii?Q?htXuTor1YRYfnvH7ObVbUmdeipdgp0a4hbbtXJoIjHevRAwd/uhhuavurtFr?=
 =?us-ascii?Q?LgC1sZQV5Fsj+UWJHFTC3bic3JyM3fUSy9hddDOM4Djo6395bWFJpInRfKOD?=
 =?us-ascii?Q?r1g/Hf+alhaVEH3P3VZ6+5TYUzS3Dh5G1oWSMWCq9uGIkbAY8CJLfpb9T+Jh?=
 =?us-ascii?Q?+9T8l1zHSvgGjOSCueTXjvoVAr2GFl3dUnC5seeRowt6f8XbiMhQtbA/YvFV?=
 =?us-ascii?Q?E6XgvMGHVzsw/j/iMQ9RiWOFc1AFBOk9DUpf/z+XnRgl9qOEcy2+3JvYwLec?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xnUZqbipV4ucl0hYJsRxW6zZrxMyNpHkkOWzs4v7En6GUZYgYRtMMhBBwZzHY2oNOno5Uovn2LCdLaDd+i9vSMeysXMH4XCv1lt1FbvcOMdnvlr5rYqHLDKuX6kWM2dPlcxfDw4FfQC1ZGIMG+NZNwSIF0dV6VwlxCPekR9L7irtI0aZsLxpQn+0W73xvtPYqnhkdVurjVwauOiWVo6OPXEQp2U8FZrYrkkyEiJbIJQyL0IL6boiozKS2vJU7wlY3RB3+dV1fW7rfD9QsxZjge4G7GnYxfU+BCdg5+tsCuBaSsDIc67F2z/i4k0VtJByoT2yn9zkm56JKYy4XPJK1hzxBIAA4/2pazYVlGMfFmNI3Oytk/C/i/I23/eFHOxNC9/Z8iKAAMUV/mHDoZO3r3m6f5Q76juQzR20r2Sr4La6V0vQztJmwoXWacCZt9f8iYmhzQG6J3wdhJ+uAiw+YyRlGHC+eS/kPc4pqb1HyyRim9jT6ulytLcwtuhesi4PWnyAh33WLMiUSApwiYMb7QCbKOOWtInM51AYVhbrB/Bx/hYc17Hr3HoIvkYQoa71NxPW0VyDoSE5jgwAX/w4QAoE/kymOYGQEpxn0gMLbbGasvPH/z8/OXFPAsqYqylpyY4F8zqFENcg4nhocFe13JjA8qejUF+2S3da2y0nH3uQg+nxexBNXPE99NE3gQ93ky1sF+ZIQLP+CLQktwnQIkbtCkK8F2JSt94NiZLbKh3oyJMeUEqy7WM2wmZf6vz6AkBgbcQPDCvxjYBpnKHfVCfcNGIefofBQ2xTxXKG+JSYCi6YtDAnuC6bH3elRO3Z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3362aa1-0dc6-47ff-6588-08db65f6b7ba
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 18:57:32.4201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BymUBOCPtCOWLEIso441pfhpp5euFy86HK9TBqiSvSyFYdy8oxFse2Ca+1cdji6hbnS8zfB513M64UuaN1VX+vCq+bYdcX3G1AwcPuaTKD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306050162
X-Proofpoint-ORIG-GUID: WUwcoreaYfZPiLKIjVUoax79sWESuUAr
X-Proofpoint-GUID: WUwcoreaYfZPiLKIjVUoax79sWESuUAr
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

If userspace does VHOST_VSOCK_SET_GUEST_CID before VHOST_SET_OWNER we
can race where:
1. thread0 calls vhost_transport_send_pkt -> vhost_work_queue
2. thread1 does VHOST_SET_OWNER which calls vhost_worker_create.
3. vhost_worker_create will set the dev->worker pointer before setting
the worker->vtsk pointer.
4. thread0's vhost_work_queue will see the dev->worker pointer is
set and try to call vhost_task_wake using not yet set worker->vtsk
pointer.
5. We then crash since vtsk is NULL.

Before commit 6e890c5d5021 ("vhost: use vhost_tasks for worker
threads"), we only had the worker pointer so we could just check it to
see if VHOST_SET_OWNER has been done. After that commit we have the
vhost_worker and vhost_task pointers, so we can now hit the bug above.

This patch embeds the vhost_worker in the vhost_dev, so we can just
check the worker.vtsk pointer to check if VHOST_SET_OWNER has been done
like before.

Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 50 +++++++++++++++----------------------------
 drivers/vhost/vhost.h |  2 +-
 2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 074273020849..0ad9fea7c170 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -235,7 +235,7 @@ void vhost_dev_flush(struct vhost_dev *dev)
 {
 	struct vhost_flush_struct flush;
 
-	if (dev->worker) {
+	if (dev->worker.vtsk) {
 		init_completion(&flush.wait_event);
 		vhost_work_init(&flush.work, vhost_flush_work);
 
@@ -247,7 +247,7 @@ EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 {
-	if (!dev->worker)
+	if (!dev->worker.vtsk)
 		return;
 
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
@@ -255,8 +255,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->worker->work_list);
-		vhost_task_wake(dev->worker->vtsk);
+		llist_add(&work->node, &dev->worker.work_list);
+		vhost_task_wake(dev->worker.vtsk);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -264,7 +264,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return dev->worker && !llist_empty(&dev->worker->work_list);
+	return !llist_empty(&dev->worker.work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -456,7 +456,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->umem = NULL;
 	dev->iotlb = NULL;
 	dev->mm = NULL;
-	dev->worker = NULL;
+	memset(&dev->worker, 0, sizeof(dev->worker));
 	dev->iov_limit = iov_limit;
 	dev->weight = weight;
 	dev->byte_weight = byte_weight;
@@ -530,47 +530,31 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 
 static void vhost_worker_free(struct vhost_dev *dev)
 {
-	struct vhost_worker *worker = dev->worker;
-
-	if (!worker)
+	if (!dev->worker.vtsk)
 		return;
 
-	dev->worker = NULL;
-	WARN_ON(!llist_empty(&worker->work_list));
-	vhost_task_stop(worker->vtsk);
-	kfree(worker);
+	WARN_ON(!llist_empty(&dev->worker.work_list));
+	vhost_task_stop(dev->worker.vtsk);
+	dev->worker.kcov_handle = 0;
+	dev->worker.vtsk = NULL;
 }
 
 static int vhost_worker_create(struct vhost_dev *dev)
 {
-	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
-	int ret;
-
-	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
-	if (!worker)
-		return -ENOMEM;
 
-	dev->worker = worker;
-	worker->kcov_handle = kcov_common_handle();
-	init_llist_head(&worker->work_list);
+	init_llist_head(&dev->worker.work_list);
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
-	vtsk = vhost_task_create(vhost_worker, worker, name);
-	if (!vtsk) {
-		ret = -ENOMEM;
-		goto free_worker;
-	}
+	vtsk = vhost_task_create(vhost_worker, &dev->worker, name);
+	if (!vtsk)
+		return -ENOMEM;
 
-	worker->vtsk = vtsk;
+	dev->worker.kcov_handle = kcov_common_handle();
+	dev->worker.vtsk = vtsk;
 	vhost_task_start(vtsk);
 	return 0;
-
-free_worker:
-	kfree(worker);
-	dev->worker = NULL;
-	return ret;
 }
 
 /* Caller should have device mutex */
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0308638cdeee..305ec8593d46 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -154,7 +154,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct vhost_worker *worker;
+	struct vhost_worker worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
