Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98074C6FD1D
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 09:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14E4F42269;
	Fri, 17 Mar 2023 09:16:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14E4F42269
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=W8eW6UFV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=yPAzDghR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BqL_1wFuihGC; Fri, 17 Mar 2023 09:16:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 542B140002;
	Fri, 17 Mar 2023 09:16:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 542B140002
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 187E9C0071;
	Fri, 17 Mar 2023 09:16:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C404CC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AAC641620
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AAC641620
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=W8eW6UFV; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=yPAzDghR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mp3TUJ8vLBK1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:16:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70AFE41612
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70AFE41612
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:16:13 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32H6BtdR008927; Fri, 17 Mar 2023 09:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=mQw04rs4jtIhEJxUhOhiUReF2Q8BI/LKiFlEkN/zVLY=;
 b=W8eW6UFVp8ECAZgHr1XzG7+2yg7tBrAuFg2ZEMPjPrplbMmVd7p2QU3yed48mu4JLvzg
 UML7el9Zjnu5cTyR5ZhRyuVcCjRANM+KHk2pBNpGBin1DomRbMkVZxRNl+AiwVIGxQ0S
 oxYgU3fWxTotfwkWGXlGZnTH/Kr4SwBGuUgucwNEtlnKR58vNLw4DnaJpdEvlhgudfOx
 AcoUyTQuaL7hu7uo+hgninUd0rubhGAO8F25xTCmW4oEz8jTei1NElk3le7O3G5SLLM1
 6IAbd9h2gBIfZcULtP+22XMSsBFoqD0j6yJNcveP26yvhMtUThVUespSfGehEnRnvw3D Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2au84g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Mar 2023 09:16:12 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32H7GDwI029626; Fri, 17 Mar 2023 09:16:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3pbqq6fnqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Mar 2023 09:16:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbdNSRJbR7cUjdCCrxenIF5x8LuPOVHxKHiMUe7ByzCah6NPdDcb235H2wtynHWbZ837BGWSmIkw7d7dimGB9CPkkK3hGbGwa3vNGwazqI7lUQHWFDBuslqc9g76vMqyalMike1MFcbT7clElG6ZSO4OOjdH5c4s+L9mkhembBEF7+huYm9dhT2d88nDSfBq31Rdvks1/r1oD8+fSnGDMsETopnOwv8ZCuUW41OKyUYKqz12AG/g1s1XMRl7FQMx05QzqAPdmw20J2b0UZOtfCnqi15b4rdcDJW7VZdnznRE0ttSAt1gqeepY08Ba7n0UowHi+UqCYL7Q7yXvFuNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQw04rs4jtIhEJxUhOhiUReF2Q8BI/LKiFlEkN/zVLY=;
 b=l5vOcKq6E5SPWAr/b3qisp8gOnQ+OPFIZ0WxF5XsJ3Nv+kyp6pLk5MSWFCGJXUYfTiQlKiDeX10vM5qIcFyeKM34YbtPJi8lf7cFbNvrPryX0EE8jh+HdrWSjYQGjN3dcygQHapuYHG5EJbHc7/xDrgvdz+4xTrD98vHJxdZL6FJxapnvFsnedrViYYDHtFxQYiKcDneHxmPYJLJDDFHyS5Sq+AkbUQLOyAufvmOXxm4NoZTTDePFhOLobzx+2mercnN/rMJm0xfkkT+NFkPGU0GepnKmA/W/PlOHV0lzWbL9hllu0t6g7mzk9FXyN6ZKYQSE2Rc9QwHKx79JvIsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQw04rs4jtIhEJxUhOhiUReF2Q8BI/LKiFlEkN/zVLY=;
 b=yPAzDghRzVXPXJvIkvD1Tr3FK4MSUdWK5wwoVnf8bgJCeqAXGNAA8G27q9Qy+qxy5bF0IDhTjak4eBm0jIpm1SEdOo6obcCVO5x+l8Gl+//7fJklgK9CRnNRTvBQK8INhEyB1imORoJLPglzGMnl0kAvoCkwaAiuK0yysMliunQ=
Received: from DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
 by CH0PR10MB4940.namprd10.prod.outlook.com (2603:10b6:610:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 09:16:08 +0000
Received: from DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b]) by DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b%2]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 09:16:08 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: Feng Liu <feliu@nvidia.com>, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/3] virtio_ring: Allow non power of 2 sizes for
 packed virtqueue
In-Reply-To: <20230315185458.11638-2-feliu@nvidia.com>
References: <20230315185458.11638-1-feliu@nvidia.com>
 <20230315185458.11638-2-feliu@nvidia.com>
Date: Fri, 17 Mar 2023 09:16:03 +0000
Message-ID: <m2wn3fhh64.fsf@oracle.com>
X-ClientProxiedBy: AM9P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::19) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CH0PR10MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: f7722521-47d9-4215-25e7-08db26c83e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiTN5fV2JiHxqqN2lLKtiols4aM8mq3Tn4PjZdN+bZlfTd4gQ0Y5j1tRAEuB/V5Pqefq8zxvF0/RjV9QipCrowsRs4v4d5zuCB7Oq+a237lzx+Xtw3uTpZN3uvKioKDzP9KGJRLEQcnm6ffXp/ZprnV5Iz2sEJdZ9/FFY6M1P1SOu5njczT7PRSm1XksGxV95pzuC6gssiVdOWYq009x+ZHSp8Wnv+LRXGlEycgDgYWP/D9P03PtfqHwddK80YrYZK7xKQevKQBrlCbuFYRpHFtXdR7gsfMEM1RxbiCJXvEKIJEkEiKmT28vQx71XToSBj0mkirAsjPeA7w/JAwwT03aP5wk6suK4k4px7kXvQyiOVLvEbRlLItfNDPxxpiYfVxPP2vhYb7nhoxTybFEnLfNJ7oC4ffNha1Fq6q80SYHphzV4RRawTuDgOHk2jlP5lZ/m81lYbD8REaoTXcboT6/lnPUbwLsw1aJO3ALZMe9g2PdCCrh0B7R6AUOLI4eeeJ18Sv1U7lcxAAvdsWmRNgblFD1tc+9nY2mrWteUxE1jpwGrgCpd1Ojcns4Koimd/5CJGBG8n9re/z9hCx/mHUAFjqwQLZCIPZs46k5TGtEQOPP4a2R2biGeHfHefyLhZlXbzrXA34+Uww3TCkS4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4926.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(2906002)(41300700001)(44832011)(8936002)(4326008)(8676002)(66946007)(66476007)(66556008)(5660300002)(478600001)(83380400001)(54906003)(6486002)(36756003)(6666004)(186003)(6512007)(26005)(6506007)(2616005)(86362001)(38100700002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TSZnkSR6C1jSACBwrISF+Y+CC5CTEQ1KJGJvjGvoYNDiTz0uFUqKYmTW7xLz?=
 =?us-ascii?Q?uDOseMwnnMmjy6k/LAtQMXObUe3brsBF5cK3le5cbWMrAhQwbBSCVyYloNJG?=
 =?us-ascii?Q?9MhOoGdvRU8JDgvzOWXL9UW/RCD78OtP/SehKhoUgFmYzpkyisgSlH+sraAB?=
 =?us-ascii?Q?l3R9XcWOPGo9DG8ih+jRh2HiUqe3TQIrkuT/bYls+jXugSBp0RE51atBeNp8?=
 =?us-ascii?Q?EyWaIHEQ9inAmYVviRae0w869TpyholMvrPrJ4TbugvIhqtGQ+NV64HQMEjV?=
 =?us-ascii?Q?0BFy2eKTfQ3HB9sYdRCgABRE9eNTfIAMYAR4H7+jl5jEmq1dgMiU5Q37Du+G?=
 =?us-ascii?Q?ZK5956JA8Mu4ZpkjbxHE7mMaIboK3YQVnLQYngxWopbr9V+pJTb/ug7OYTu4?=
 =?us-ascii?Q?j0TmHwcbv8/GEXADWiiBje0hRJUxcp9CrnWKBKNWuUeGyBLyRSdNUtnn6HCX?=
 =?us-ascii?Q?XGaOzo9CaEkprsCouKythkg76MjMXA2NQwIgzsb+AUI4KWJxdPDUeUZar57P?=
 =?us-ascii?Q?PKiqfV38Xk0UsxPVSkKA4amL3e+lsNwnF5+Key6hvWKH/3f5CdGKR4bH2Nmu?=
 =?us-ascii?Q?jAQO7YCjGcL2tja/Nlftb8S/MM9c8IRigP3hO2pU42a30R2djQ7nr9HQXiM6?=
 =?us-ascii?Q?t8AKuUIn1/MnTAq6j5kzvJsXp+YUIcqDQ65KUzodEPA7xfHiLCFY0/2iJi2m?=
 =?us-ascii?Q?76aSsU+7i/RK7ypl+VLvwiUVL2H4uKMYiZUm1ZgbE2NuO9YMr4gWQfgWpt88?=
 =?us-ascii?Q?pnwwevkucogQZXkjleueWJIHJAKxCTvDXp/hEVSYpOAtMnFcrlLyPFvWTrIs?=
 =?us-ascii?Q?KLxS5bnBFXYC9UEPEJIA7iL8cKDEriA+2EqFt8wJY1VP8kRcOUL1d+TAdiCh?=
 =?us-ascii?Q?Cqft7R5jIRmsljse4MRCf7FkkPb/YCS3QkUy2/PT/pNr1ENf0VnkB4WZIIxU?=
 =?us-ascii?Q?1U/JbtzE0LolFQ5U2Y33JlQ6KKpAjSd4UkhmyKHZvrkVzaoxkCOJdgJsNFlx?=
 =?us-ascii?Q?FTnfwo33G42upsx+1YO51sGN+TdqFA4jQQyMUfe4DLXfuhotMafN8TyCDKxl?=
 =?us-ascii?Q?n9zfgnDGq9ttxVNLkp3skxPDJx69BlhFU2P9c/AVCuT4mX54jy+vXbYp7V7i?=
 =?us-ascii?Q?evJ2Fk2ys00OBP8hjzWdyhddd3RS7pkrL2V0H8Oc5Rmvb1ayGf6k5xNyp7z6?=
 =?us-ascii?Q?/WY7fkr4O9nBL+76dnhNdtKxOCcol6vn/ZEtET4IQqjW0ZLwZ8z2jGmsWgEA?=
 =?us-ascii?Q?X9lfjEQMNvOXWq1zynjUqbm2sxOagcJxqYE+SHOXSmS9IEgUd3qifvxlP3wS?=
 =?us-ascii?Q?6XWDWx/mpQzC11WAa5DJAsJ5JV/Ks0QTw6PePKwce+elvNbHIH9nEIlVNYpH?=
 =?us-ascii?Q?+RjQymBkXI7NQi6HvKnUaEyfXEpHz1O6eQ9n6Ig+5R9eNQX9PLcozyXiHLr1?=
 =?us-ascii?Q?a2T1Xm3Mk+QzBIQxZkl2VahbXnYdpVzUmB/Se+yAw9UVoK4cX18XL+ZFIg8O?=
 =?us-ascii?Q?CN9SAtlFlQjaFjzRDU/HJj0+y9rXrNqdCdb5QRk36HOwjjij+P1oozprxm6F?=
 =?us-ascii?Q?eSwtGvLBxKombGNOfQJfZkvnbcdgWJ4e8ivvE51M9U/Wi3W7VN1NpsHXT/iJ?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X3/ioGfEx8qIk6Yefs5YBNBbT+nijtn1uy/jz4LCLJO35xv9lBg3oIUFecQZgZ/AkNAwXPxgvvreGiFmyWQuThssdz1ppQiPfqNaIjIJnMGEW5ze0isMnunAXPPYCbPvGCEXqG15gg3PpvKy/pu1RIOR7agSB29IXrI86YZiggwRxBITnkmj+666jvKqliRBY4xHOivFkWOzMs5cpFMLciMp2z5jQ/yChM2gCpKfBZ1PFjgy0mJNwzV1KHQTqhKqeUejA0nyGL0XpbIonb+pcELYbyQlW4PorJar9moYXYqcjlVM7Bzib0uOqhSvnUJXtEKJb3U3x/eDR4SvS0kJYAUatslV6mN0NLUW91ejrp0ZYgT9x6KPym6qWCn2bYGIZfkt3isLQhUrUU/Ff31SFAck/1ZQcih/Cmi77VHIGUvwE7JWCBMCbrVDSCko0bx+tyzjp4QGz4OOwSbw2Xnb1bxkZ7bNrC2iBdWZB7Tt1V0gJ04Jndx1MQEqO9ESMboD7uzRd67ydBEyBUnElu0xj8vuhXblFbRnYxcROifpTbwhuXAuqWhXS8Xpt7U/i8ujiXgP7LNlA53YRZ1dClBhySSFn21H0Uqm8R42tRKlMnAHmor2uPnbNb/kmhp93oc3cciVKb2Bm2VsEafTsxkKDh5+MSOONfSIpndH491SD/BSmA1wIGFPhbrgnwr1WU0FmWEWxzzCvDNxanHcvGh1DFAdDDDw/orroDLSCxBbauPQvv0HYTN0JHX70sJQnMB9cSQDLVEo/DKHyCxAZW2sTm7//rNIGovCtaMbIQO1F1kByZ8HvKV4hmoCk0mmcgEofJOqmB9GK4Z5icxj5h7SoGT/P3rsVf2wtyL00kfcD5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7722521-47d9-4215-25e7-08db26c83e2b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 09:16:08.3392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpZQvYfSTUOK2X85Ugy5LRWLkBcTeH1mN0IGBPVwYRykhGJdQmFYBn85Nyuh25tzPtnZ4sX+tQvlwN1eMnzwQBqcHNNWSzjm8gahSGl7M/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_04,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170063
X-Proofpoint-ORIG-GUID: Eny4YQeq3fl9rGOjSCOIMb_90UsAE5A6
X-Proofpoint-GUID: Eny4YQeq3fl9rGOjSCOIMb_90UsAE5A6
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

Feng Liu <feliu@nvidia.com> writes:

> According to the Virtio Specification, the Queue Size parameter of a
> virtqueue corresponds to the maximum number of descriptors in that
> queue, and it does not have to be a power of 2 for packed virtqueues.
> However, the virtio_pci_modern driver enforced a power of 2 check for
> virtqueue sizes, which is unnecessary and restrictive for packed
> virtuqueue.
>
> Split virtqueue still needs to check the virtqueue size is power_of_2
> which has been done in vring_alloc_queue_split of the virtio_ring layer.
>
> To validate this change, we tested various virtqueue sizes for packed
> rings, including 128, 256, 512, 100, 200, 500, and 1000, with
> CONFIG_PAGE_POISONING enabled, and all tests passed successfully.
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> v0 -> v1
> feedbacks from Jason Wang and Michael S. Tsirkin
> - remove power_of_2 check of virtqueue size
>
> v1 -> v2
> feedbacks from Parav Pandit and Jiri Pirko
> - keep power_of_2 check of split virtqueue in vring_alloc_queue_split of
>   virtio_ring layer.
> ---
>  drivers/virtio/virtio_pci_modern.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 9e496e288cfa..6e713904d8e8 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -310,11 +310,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	if (!num || vp_modern_get_queue_enable(mdev, index))
>  		return ERR_PTR(-ENOENT);
>  
> -	if (!is_power_of_2(num)) {
> -		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
> -		return ERR_PTR(-EINVAL);
> -	}
> -
>  	info->msix_vector = msix_vec;
>  
>  	/* create the vring */
> -- 
> 2.34.1
-- 
Do not leave the building.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
