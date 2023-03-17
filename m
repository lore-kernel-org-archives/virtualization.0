Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87F0C7618A
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 09:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5530441733;
	Fri, 17 Mar 2023 09:20:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5530441733
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=iAIn1av2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=f74I0h74
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xVb41iI6NwWH; Fri, 17 Mar 2023 09:20:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 47D1B4033D;
	Fri, 17 Mar 2023 09:20:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47D1B4033D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EDEBC0077;
	Fri, 17 Mar 2023 09:20:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 399ABC0071
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0508040348
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:20:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0508040348
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LN0sXbTR1RMt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:20:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1E354033D
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B1E354033D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 09:20:28 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32H4scKh028742; Fri, 17 Mar 2023 09:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=81v422BketUFiiYJrLOmog9o1JYZFF+b9wS2anIyaqc=;
 b=iAIn1av2riAVlVqyi07qMl1DUz6nb7Ij0qoyNdic1Z1xWwPXKhOco/mUZKmFnvoH6sAB
 Bpc6o2W6iOaBzvJKHnrEz2AEQ4up8KthHxreNexKwfu4ZwH2xwqvIeCtxrUVUE873kJG
 /s5JWC1M4FhSXgaDI95Kv0tbseG61OTqZztRVUCDYYEo27asPOWhOSenII3P23/oGtus
 g+iLzMGxJ9q/ZfO+EaNdDyy7Hd2PUnuwUVeY5UifgpZOVXXeVQ9Ooyb3QdL0CZOsgPmm
 v+f0ktTFa+PWNoScb1lu1lAr/0Luo9a1s0N2x2kNYZcehQtrsyTmLURCTjfiWkDwN+nX hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs29kfan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Mar 2023 09:20:27 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32H8STso020420; Fri, 17 Mar 2023 09:20:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3pbq47hap2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Mar 2023 09:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZCplY68qU/PD1zRct9EkfKs2U0DZym4p6jGL56I0YWWNhFuWYs9LBuyaZFX7cfJMQStrwmXh0f8M7kVpiTQHS59/gfvZXOvVLjU5oypT0SgBKnt5kNPAz1/BwwrGhEyN+l9WbCaK9ug18ijJVX05iwddVXefR0c1YjnkYtPUoYVwfE/uLzopgS8Z8sULVc/CQIT927V8GsTy2hb9JvYkl045hhMa1UDfYMxJufCf1Qh6o8vYF7H9fmoD4u8eKGTGi3rldwNXsg5QrAy3UP0+2eecqHnlKrSv649mfmeYhsT9OetgSFfqvhuHMjXi6A5cd4sp1SElfSFZMlee8De3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81v422BketUFiiYJrLOmog9o1JYZFF+b9wS2anIyaqc=;
 b=GTIMzKdU/uUfAnX4WIv44TYk/fznrig+yOmXGtVW4uqggV1bJTH4nFrsmT6TKvjQCf98HjMJggY2mUtT/1xeC9P4+Vo1lfH6ejWmFoNa/ZqRGhgHJ+V3kHDownijGMpvI0HXwg4EDukukDQ1+kIXmNnWYCJSg4fR7Fu0W1mt7hiXlka4iHa3eo1PtB2+zlW2eTGRQyWq6SQ852AVrdHs1+fwBCq2LJ9fsEU7yBXJwhNSSs4LHFrffw8vAd91YTU2xBRAduS7vxeknsoXb8WOvU5EmU0F+IeOWbLCxxfP3Qw2ziemWEWADOTgEEnn3rZxTfJVK3Iy75HDgfEoJuxaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81v422BketUFiiYJrLOmog9o1JYZFF+b9wS2anIyaqc=;
 b=f74I0h74sdEaZnKYjNeMNmLYeiKz8tlEd8PK2o7IT3j7WG1UXD+RYruqWNTLGCawZJ6WynPkJxr4yTq65ZVsT5PWvwwXd7n6DhwTrGmPQEpYCKGt08f2Ba+4DFu2o0rCunPGTK4T6V6iSFWeQbg8rHmJ55e44g0B4x8u+dvGWBg=
Received: from DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
 by DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 09:20:25 +0000
Received: from DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b]) by DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::9ee4:1e8a:76b6:959b%2]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 09:20:25 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: Feng Liu <feliu@nvidia.com>, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 3/3] virtio_ring: Use const to annotate read-only
 pointer params
In-Reply-To: <20230315185458.11638-4-feliu@nvidia.com>
References: <20230315185458.11638-1-feliu@nvidia.com>
 <20230315185458.11638-4-feliu@nvidia.com>
Date: Fri, 17 Mar 2023 09:20:20 +0000
Message-ID: <m2r0tnhgyz.fsf@oracle.com>
X-ClientProxiedBy: LO4P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::18) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|DM6PR10MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec6f467-3159-4bb1-dbd5-08db26c8d743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O25PrZN9C90ZtofotRKVvXB0+upCd6BbrfWmRazn9FdW9ebvFNWFg9/Wn/lzRzk9FFAGtQzB1a9wgxZiIUsbAuLZ7IcnBgtRlhrZ2doB9TUwUJzVpQAAyjQF7nwy5yW6FfCd+IOoN50Ap1HBB2H94b4t2MHoHjA+BAprk8f3i20LFjAWg625KLk5ULgeQhbGvSOYmgIYQ10fOQJxR65q0V2yYmnBTiVPjndo5oGNi9rs1unoweIrYI/nvU3CyKwiyBJFuS4bOdIp6kLCIlv7P0YebpNgUjKT/P29uDJ6ZEtR5+HqOo0+ahhDhW7qRdPYtpEhN3GCd2enwd/jDvDPVumNxESw5i7EA8CW2IjEXOLXdy4XRt1IGjkxCQGEFPIO4fSoWr35EJRI8ZfSDqmP4XIFDFJAScXe/567+JJUwCJpNmYbyn9ZeDo6pzT325Dzts12JTntES0UlJHvXSreOtoNDfVZ8VDm44pCKB8kCDbBI6MAKSgHZEgYopE6Wgj9Q09vyx7VC+4Dso2vTLhaBVUy101apvycVOQyl+hznQPsJU1Xn5H1ltD7BPa26DGHn8Zm1x971EBgWzf5hIRmXfnLn4NoTyT4u/mEUdSucUY51vy6UeMu1PZ/od2L6bgTX5oxSoTritIixd1QoWVGoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4926.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199018)(6486002)(36756003)(54906003)(38100700002)(4326008)(2906002)(66556008)(316002)(8676002)(66946007)(66476007)(478600001)(186003)(2616005)(6506007)(26005)(83380400001)(6512007)(41300700001)(86362001)(6666004)(8936002)(44832011)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W4YP33xTm6PtRxZyrIsQnxNLcfTunOZZvzzfXOjMCiqlDv6j6k9CrTVwWXoK?=
 =?us-ascii?Q?XfY/56FkSGaleBBl4GgQ/dKN3lzB3hiBF6hyIbbI1d22NmAZvJpCk0tRhVhK?=
 =?us-ascii?Q?6Uv7uSI8BvgTc324NX/5sp1/3251o9BxJOFSA1k/iW455RIAzO+1r1IVfDKA?=
 =?us-ascii?Q?7WDI2uQgb1VsNfCFLDzC5caDBcjL9zV9JjxovQSVyqPpTSssyI8sNFgaqQp7?=
 =?us-ascii?Q?OdMeoogfl8402VRrMZF51hkhaDsTTo4Kvag89Jam3ZtNWyICBRoKKJYLlOxT?=
 =?us-ascii?Q?Bss3YUeGxOaZNdTmYFM5S9o8KddmDjdm48G58plQ/W4DN7pFP8o/fR4FTf5s?=
 =?us-ascii?Q?8E1UwoMVyjIeAmQTDngx4fElRdIOr4Vhe8V+YzvrKRMQSn+Hh+j3s891jpFF?=
 =?us-ascii?Q?paOuBwban5NPitHqrHIXW5MmplF2xIrhw6RB3/ij4H0gj8m/ra8dI/w4QG9R?=
 =?us-ascii?Q?1fsuDcqIOMfnwvT6frNZMzgScA8vX/MnR53bR0s+LHNBXgiJid8bocyYGphs?=
 =?us-ascii?Q?mZlcoR8/YZOk5aONfbwiyjr9P2n3vbgkOJooVGO6zI754z3nGn25+oB2PHMa?=
 =?us-ascii?Q?yx/K0SU+V6gNswr8vkYMpsTPhe5pCRubUCtn8EtsfUCBiNv52cJNJCrZp+rM?=
 =?us-ascii?Q?dkavi8pLXFPdLo+U+lSNvtKUFMoDkJj9YXMYbYwJ05Nch8cUde46DSFGZ2wI?=
 =?us-ascii?Q?CJ5se3iDO8YmGfxPI8S4d6IDB9U+RVm6S2pEBu59OJKzvupDxqguBCHxrMyu?=
 =?us-ascii?Q?6oWNXxSf6S7CCli3lrNnUpuhkyX7sU252/6sid7QAc/I26uVe/VN+a+6kpxo?=
 =?us-ascii?Q?5uWIKYNh5kH0JpuGcx5tCB3PTJwE36oJj6qyd6D/oUdmf1+mBkF+/xLpJEfx?=
 =?us-ascii?Q?dlcLsRW7w1gx+mHqZeChbhzkQThAfOnJRaotzyF60WCHuOXMtQJt/Cr/4MH5?=
 =?us-ascii?Q?f3Su4Lq/ksN4/iHantJdVNR0fdblzVAUHR9z/4bg0QmGJNJpZIgkrD+DVgM3?=
 =?us-ascii?Q?J2idZT4Is/5XsiF0/KibWCVOhzsxw1frRfKdJ/IsVoahzGU6J5ltS01DM15J?=
 =?us-ascii?Q?ceIEJrjLveACllQSwP1jc3Q0m114DFIdh3mmvJ5UdCikDKu+jcBdSUvURb8e?=
 =?us-ascii?Q?LjvVD/+6b2L06THhOFN+i8lMsKwoQs6Bf8IKXfU/bCcjDAz6uPMwk+bKQn02?=
 =?us-ascii?Q?9s1sQ3TaOzMAqMnj9vGp/C5o06IUMNhHSb8GbkNlrBeZkWR8XTnDZQQaABjT?=
 =?us-ascii?Q?KMIiGt49OZW8w0jYgHoqEGiqqUfHMJOklIxxjLXRTfDfR2RRWdWFKZj4GV7D?=
 =?us-ascii?Q?Aawwj3xaTlRp4Kqb54jCQIQzw8OfQUiNAyCrCTNPuD1QzJG+NkhnomtHTsUZ?=
 =?us-ascii?Q?ydaCI0jrKWwGolzEXSpdqA32c1f+7O5BUOuJSQez11/INaiacXKTeZl12IZz?=
 =?us-ascii?Q?xnix5PtRayIgwqwZB4C3gRwbl4B1+vhTW9b5mpzRs85QY7M4L44KdjBRuvPE?=
 =?us-ascii?Q?zWOtfJLEPKvIqZaCDcLGE35fnoFRLWZ6sIF5QuqScWstMtamgX9Bx15fxnUL?=
 =?us-ascii?Q?X8DJAL7Ifm4RklZX50fp3ofojWrdTMzPoFKfAvgBFA1mzlrGyQsuVU9qYEJi?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6YQJReIisyP7jg7tZ7EP1J+xBeiLMVqipqX9C2mmGVVRHGlkR/xDkX5E72RpGFbPiNEzEuqew5Kdfo9qP6bMiGxjGfuyP8iyE5kMqnN5kMbHy91O0XI6QasD4K+6Z3QR5HWn3VeH/abkii76MhtJ5FPwCQSJzGGwFNgGVLQraPebh8ynm4Lp8R7iykCagcEGfMImFq1qVKyCaF6uD5c0D2BW2RNeRE6gez+nyQHQ39RZKXAiWKrf/sl6234MC/bkErTj29/NTYqUIndl3y7r16H8BAj07SMrkDi7DMy0/zr1LO2Bp9T9wHLRC8rj3ZpSYxZ0jduVt70qhR9FfKqVhZ0a9gCt4qiR1UpnqnCQE0yR5VDedFdwJY5uN9frWaC0+nmWTE4QQyrbWmkMwdjJDwvF0p0FcoiBe5gThoKxzOLJlDJAaq/RxIOf0+mnw/7TaRpJ6PCDHOrjOlOgoVtMSYzhlER8KrK3j3Pr9DSEtqvCzsizZVkS7PMEs+jJU/NGQtn1QbJozaA9jChXxt7OisXcjaQnPxNp4Q+Ba504qFgIOhQjYiGIWHMc+Kjl3hp9LUDBcecO1v8vs2DZBV6L10fzazpZFjhIWnQPVwpJV/6QPX8ErSCqUHv8/Ia/xTQKUA92I5kGlagdeEKy7MQJZa4cA8Ac3gF4WHiNaryXjK2oNWo3YmgzQ8qzvU4hVTmahi/pGrd7HpATuOWz4+nk/0idHyFzjdcWTtUrnpo2DPTxOOcoMds02yda//cc5muT9EaZ3WPv4z0/OqX8xBS2ZkSrmVdZElvQOIAwBnvBajX8WRnw5pYq0MwHyLBJ6XPv6Ce3perCNTgFoLfyMon37jiOyrQPawAoMCb+oPJm56M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec6f467-3159-4bb1-dbd5-08db26c8d743
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 09:20:25.1794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EULMPl5iMQnG9KeTofF1rokNl1iaM3IIa4Lt2r0TgnkuTznpQ64SvVp5pBnowwulgWtAlhYWqu3tZU3wno1eqFZyRNMrGfBwqtLGam/Lvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_05,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170063
X-Proofpoint-ORIG-GUID: _69bN3NrbMdndllDexTyYkxGu94T11Bx
X-Proofpoint-GUID: _69bN3NrbMdndllDexTyYkxGu94T11Bx
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

> Add const to make the read-only pointer parameters clear, similar to
> many existing functions.
>
> Use `container_of_const` to implement `to_vvq`, which ensures the
> const-ness of read-only parameters and avoids accidental modification
> of their members.
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> v0 -> v1
> feedbacks from Michael S. Tsirkin
> - use `container_of_const` to implement `to_vvq`
> ---
>  drivers/virtio/virtio_ring.c | 36 ++++++++++++++++++------------------
>  include/linux/virtio.h       | 14 +++++++-------
>  2 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a26fab91c59f..4c3bb0ddeb9b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -231,9 +231,9 @@ static void vring_free(struct virtqueue *_vq);
>   * Helpers.
>   */
>  
> -#define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
> +#define to_vvq(_vq) container_of_const(_vq, struct vring_virtqueue, vq)
>  
> -static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> +static bool virtqueue_use_indirect(const struct vring_virtqueue *vq,
>  				   unsigned int total_sg)
>  {
>  	/*
> @@ -269,7 +269,7 @@ static bool virtqueue_use_indirect(struct vring_virtqueue *vq,
>   * unconditionally on data path.
>   */
>  
> -static bool vring_use_dma_api(struct virtio_device *vdev)
> +static bool vring_use_dma_api(const struct virtio_device *vdev)
>  {
>  	if (!virtio_has_dma_quirk(vdev))
>  		return true;
> @@ -289,7 +289,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	return false;
>  }
>  
> -size_t virtio_max_dma_size(struct virtio_device *vdev)
> +size_t virtio_max_dma_size(const struct virtio_device *vdev)
>  {
>  	size_t max_segment_size = SIZE_MAX;
>  
> @@ -423,7 +423,7 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>   */
>  
>  static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
> -					   struct vring_desc *desc)
> +					   const struct vring_desc *desc)
>  {
>  	u16 flags;
>  
> @@ -1183,7 +1183,7 @@ static u16 packed_last_used(u16 last_used_idx)
>  }
>  
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> -				     struct vring_desc_extra *extra)
> +				     const struct vring_desc_extra *extra)
>  {
>  	u16 flags;
>  
> @@ -1206,7 +1206,7 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  }
>  
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> -				   struct vring_packed_desc *desc)
> +				    const struct vring_packed_desc *desc)
>  {
>  	u16 flags;
>  
> @@ -2786,10 +2786,10 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
>   * Returns the size of the vring.  This is mainly used for boasting to
>   * userspace.  Unlike other operations, this need not be serialized.
>   */
> -unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
> +unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
>  {
>  
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	return vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
>  }
> @@ -2819,9 +2819,9 @@ void __virtqueue_unbreak(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
>  
> -bool virtqueue_is_broken(struct virtqueue *_vq)
> +bool virtqueue_is_broken(const struct virtqueue *_vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	return READ_ONCE(vq->broken);
>  }
> @@ -2868,9 +2868,9 @@ void __virtio_unbreak_device(struct virtio_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
>  
> -dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> +dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *_vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	BUG_ON(!vq->we_own_ring);
>  
> @@ -2881,9 +2881,9 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
>  
> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *_vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	BUG_ON(!vq->we_own_ring);
>  
> @@ -2895,9 +2895,9 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
>  
> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *_vq)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	BUG_ON(!vq->we_own_ring);
>  
> @@ -2910,7 +2910,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>  EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
>  
>  /* Only available for split ring */
> -const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
>  {
>  	return &to_vvq(vq)->split.vring;
>  }
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 2b472514c49b..c4225653f949 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -84,14 +84,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>  
>  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
>  
> -unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
> +unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
>  
> -bool virtqueue_is_broken(struct virtqueue *vq);
> +bool virtqueue_is_broken(const struct virtqueue *vq);
>  
> -const struct vring *virtqueue_get_vring(struct virtqueue *vq);
> -dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
> -dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
> -dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> +const struct vring *virtqueue_get_vring(const struct virtqueue *vq);
> +dma_addr_t virtqueue_get_desc_addr(const struct virtqueue *vq);
> +dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
> +dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
>  
>  int virtqueue_resize(struct virtqueue *vq, u32 num,
>  		     void (*recycle)(struct virtqueue *vq, void *buf));
> @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
>  #endif
>  void virtio_reset_device(struct virtio_device *dev);
>  
> -size_t virtio_max_dma_size(struct virtio_device *vdev);
> +size_t virtio_max_dma_size(const struct virtio_device *vdev);
>  
>  #define virtio_device_for_each_vq(vdev, vq) \
>  	list_for_each_entry(vq, &vdev->vqs, list)
> -- 
> 2.34.1
-- 
I do believe it's Madame Joy.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
