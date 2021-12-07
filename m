Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2572DC433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 11:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC9A660E61;
	Tue,  7 Dec 2021 11:48:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJctOma7gG80; Tue,  7 Dec 2021 11:48:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6688606FD;
	Tue,  7 Dec 2021 11:48:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A120DC001E;
	Tue,  7 Dec 2021 11:48:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87428C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6822F40284
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="FePrJTTw";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="pABl7r2x"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZNa3q-5RnWmz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:48:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92EFE4025F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 11:48:37 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B79A9xW019273; 
 Tue, 7 Dec 2021 11:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=uIiM48642Fmqz/+AByc+cBPKB5/NptlamhfeEhyNl9w=;
 b=FePrJTTwSzVx0oQC2sMHzJAPyXjUYQ92JDGQKcOMZOy3e3/tHVkD99oD5ax0mXF6764A
 KINYieguJbgsByZ2fyPGC1QWfBTbhfxQa9bKV15IbTCRnWt8jKui6pkOB1Vb0i7cBZmI
 mRuAdls5S2qT2drcNPXUFbuSRKP2WAACAPmcsND5qoVcLtb/P+MxlmjNyy9HGaaCBg98
 ZUrUldgAPhBQXLcXfbulukxx1jPCRh8SdmR2CWtt1BeVAqQbGihhyszmT0mIFZ4o7/Yz
 wGvtnuUn/JN7qyGl99dxJokoxAIknh+rtuu9VE8OoVxTyAPFS0I7wvTWSPKdzSVMcROd pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3csbbqnguu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 11:48:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7BlAIw062653;
 Tue, 7 Dec 2021 11:48:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
 by userp3030.oracle.com with ESMTP id 3cqwexjkxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Dec 2021 11:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz1qMrlLgrkolInnzTBpeMPt/AVE+Tu5xQkQlcqDDMUd6FH37mSl+yWRjubTXt2LW6mHhfjl0bcul1Z3oEridG+D+0toZaqwmNyjRERiqC62M0M4TLIJM/0YJ+D6IH+g7jwPaagIu+1NPnXGqlVN7ks71v4eRv36V90/WeBtxV0ZZ/oTnugeQYH213Ni4w3p0eo5I3kn4qNBVMr3UXGfYvtqJghtqffjaN5oUFs/k5A0x3OpTccehFJIqm7Tl9YhBZKrqv9VF0lD9uhGoPAjOKCLd05h9oqbDQo9TSIRz2Ak15yTio1ZH5crmuqOqWY1M0AITB3wbC8N7ES2oDECbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIiM48642Fmqz/+AByc+cBPKB5/NptlamhfeEhyNl9w=;
 b=PH+PD//bvoi9LvVwG9o/AZI7hGyVioi7unQTVnMNBztauiNmH/jel18N58hG7bxneLnu96/TLLG3MaAFuoCUWni6PiO3g8y9YN6cN7y1egIwg8Cif3dFp61VBWeXrHOqUBvdW8PVj+ySzEpV4gLp+52pLdv0H630/LiBYuVQliZplc7gXgxOeW61ArXjXMzDpf0Ssta9JAt6NN1ceC/bcPHZ8rd8+5d+yq/ihUCSF+T4fUrvB3tSrbeqXM/6/ZwxqLMdu4yyCjGoP5tEt4/kXuULic5Krnjer8H2lvyVgbpiMzVxN5fWZ7X3PUxXVcW8TI3LtKFVi/vqZB/yawNudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIiM48642Fmqz/+AByc+cBPKB5/NptlamhfeEhyNl9w=;
 b=pABl7r2xYP5EuPqqOB3vzf56jVtcUUNKRYEbIqCRzir3fV2s9TKxD0UALmSNe8Un6hb4NrZj35l8kQSFJE2PSvWPo/6Fsmz4gR+GzXpRCb09sh4bF813BV1CAkA+kyb84NVzjiRrvMUDgMqIbhMmq30DewCKrcrpIWO+toGZsxQ=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1608.namprd10.prod.outlook.com
 (2603:10b6:910:9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 11:48:32 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::fcb1:e595:35ee:6233]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::fcb1:e595:35ee:6233%5]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 11:48:32 +0000
Date: Tue, 7 Dec 2021 14:48:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] vduse: vduse: fix memory corruption in
 vduse_dev_ioctl()
Message-ID: <20211207114805.GJ1978@kadam>
References: <20211207112146.GA27784@kili>
Content-Disposition: inline
In-Reply-To: <20211207112146.GA27784@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27)
 To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by
 JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16 via Frontend Transport; Tue, 7 Dec 2021 11:48:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eea03ca8-d8d6-46b6-3cc7-08d9b9777e52
X-MS-TrafficTypeDiagnostic: CY4PR10MB1608:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1608E5CE57EF3017A4ECD43B8E6E9@CY4PR10MB1608.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbkTkDRFYP+SU1H02BI+uapKIuL9ZSfK7o9x6xfkDSMksdLS1bSeZdkeYGXESgZgHhyg3gKc5vzB4pekbOK2M4cWosHhzBQcJNSWRtDwYHY53Ew/BQGprbRdExVbD4V7CTIjr53f3kltFUs/pajpmRqKTLDXeYRqRWFufj7+ufXeBcgd+w7nv6IRwFfTiH9QfMga8W+LWlxavi/GXu7RujWy3KPtB551JNrz53pdDfcVI6qpOhgPOXi42sn5Oz0AtNftAtx4QdK+i5bv/XP/y1y5by1Nfe0aNDPTZwo8HSUf6tSKb7hxQQnPR+HBSaMYgmVmYFlWD6HQwjawqzwXQC321kztyOFhZV3BbRiu1HGYJb1GFODbF+FlrA16mRJgy2Gd9nlqwVsKMe8VU49v55V5+gtfau6XGvuyUl0TmA/fkDfdwdYwMZLxFJ/fr5SNK4zsYXbz90OMvuVhHIEW2eFhVsf0VI2KT0ymGZxC554Y4swrl3O/nAAeP+0Z2UaCXtDSyh38vLzfwiTFrMgnB+MrSfGiCjhG7wclirjqNSXeYnA9KbfCgXscIqWqGYN+NfZ3V1Hw/Ek0+OUFzOiWO66WqOc1MbuPe/sp3km0hqSTknwHwksBtVJr+1EtoLzav2B4iz+7vvXAkzEZVZlYd54bowFXrjd2tCwK2flRvzIH9eXaOydgzhNPi3bMp9xmFy/bMy7Yb9fprTvGFNIK4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1001MB2358.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(5660300002)(2906002)(86362001)(9686003)(55016003)(316002)(83380400001)(4326008)(54906003)(186003)(6916009)(9576002)(6496006)(66556008)(66476007)(38100700002)(1076003)(8676002)(33656002)(8936002)(33716001)(508600001)(38350700002)(66946007)(52116002)(4744005)(26005)(956004)(44832011)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z+IFoFgKRhOmOWeiMSzz0m99q5PvC7P1tR+XvoT+oxKYBB6NjonVvL+M8FFY?=
 =?us-ascii?Q?aqQthT0H7nCfFAEQ5rxFSjciT26Qx1gT8hd4Is5i/CG36kagVTBBUO9YF+/O?=
 =?us-ascii?Q?8F1enUMdGKp3D4VjW2DRTI5BgrdtlRQfZ2rZH2bNKcv1eY/IJyf2vM6mdNnV?=
 =?us-ascii?Q?9wdtoCE/14NnqdFWy2HmheOwS4/lCXhgDyZpuOOFByltIsCQG7uciJ7BjjhU?=
 =?us-ascii?Q?9KpyXAuUcynfWG8aCrFY3OXgn7w1iU9RrtsRzp8HrqDWCddP+wnG8j06uewg?=
 =?us-ascii?Q?nQQnCkKxxWHgQGC3vLD3ioqYDSkAtuJIqUyi3FQQuhHMo7kSyxaJQLdZ0IdU?=
 =?us-ascii?Q?YATzBMgBMrSMr6hpSLcGxtx/y7W6bIpgRUdiKMSRrPguwwIHOX6Nhkblrdvw?=
 =?us-ascii?Q?ImUbW1kdTFH6oFgCSvEY9ETvHVOXdQ2uycMwiAzm5uRxxoLu/0o7WRrjAgmt?=
 =?us-ascii?Q?QjSLGtUxJ7oCxFuU+5fKNrbR0NP3H4Os6WhwHN3+SbFV9Da58kE+J2OopBdb?=
 =?us-ascii?Q?Rcx5ZxOZB/PrMchBOjquawaETMJz039sbUA6071SwvAWR4RewNKWvWsxQTiw?=
 =?us-ascii?Q?Yw2tjrmQGKvvGfBKkIwDHVjcrNiY94mRZehccIP5u/cwCA7mFkpjbdhsXwvg?=
 =?us-ascii?Q?+SnSJ4GykjFkJoavvodZYJWXzvOOfDk1TJBdnNXFxiMRcnz51WzD0pEkPX8O?=
 =?us-ascii?Q?dZFKi367a/EOx6l2g84ykVozrKstEBR1Uj35AqXmdZj/0kkZNR0t8So85GCE?=
 =?us-ascii?Q?9PBNzbNG8gGP45MVkPdBngUtlxKevHYjeNFNzef+txyLS1+Z4qLnIP7oQfqk?=
 =?us-ascii?Q?+wgZpp5yrqNBT3URqkcbOhB9HwPLHUV2e4m0DV1Dyj4k9kXWeyl4h+0irABU?=
 =?us-ascii?Q?TcCNYXC373VnZaCxXjomP+uUVR60MCh2wRYVozQBSJHmAHpaf6qvSyR3cSE9?=
 =?us-ascii?Q?n8qi8qXLpk9bR5Y79ngkxKATXUQ+/TSbMOVWJsceQZtgSG/Cho0Mt/2u9ag8?=
 =?us-ascii?Q?RhQRzXnrm/4eZAeLZwG/YoRCrCanJjXeTTejV15Zph7Vs+Sjh2fhT1dLtWrp?=
 =?us-ascii?Q?6W+cNqHJIaVdqb3u9/XT9jZB9eqkxi9nPEl+hMy2gqcZGi5KkrD0evuRKk2X?=
 =?us-ascii?Q?bNTqsnJ33kYJu46ezkDhxtn5ehrp3LoPFit8hDNkz3oZtWBnAzT2HyywlqZi?=
 =?us-ascii?Q?e3y7d1126K6Lds15WUrcBcGrL3s3r3w8+GmzhCw6uZnCHc+UlPm4zXsgB1nx?=
 =?us-ascii?Q?+BbxDdzm0dHTsAUJeTNIEtuJ82vXYPOhW29zMnfF5i7FN+MA6FRAhDPhUI80?=
 =?us-ascii?Q?699YRy2SgK228xd1AjmfBf8Fe4+gZbEJ8ts/96+fPj7T2m8cZqxNfqy6fru1?=
 =?us-ascii?Q?42nubkE84RfO5F4KS19HHitr6JFj0ns3yfI13vGvmrrPq9Uzyqzn7suGDaz9?=
 =?us-ascii?Q?Zm6G7ZYl/iUyrPGRmoEC+/uUb1lDBLZ8RCNhxsKyYMkeA5+zuu6uICXjjPUI?=
 =?us-ascii?Q?6KIswV3b7GsWyiDMgdh3OnTbnRp8YkKIgkYTOAZ58oUmCschqTVMcYdi2vgZ?=
 =?us-ascii?Q?mLsJZ4OMdUB46Of3OdCC6Wd2vUJ16iM2oHMgtX4US5isAtBjBgQ1tFLs3kSF?=
 =?us-ascii?Q?TL74pguq6u22Z4lBttTRr1duMjwpSZGhALbqnzzc3B9fTHgKfM6yxXOYnue/?=
 =?us-ascii?Q?NJRiC3PqKKEASa8PiuHKiT1g+xs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea03ca8-d8d6-46b6-3cc7-08d9b9777e52
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 11:48:32.7294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSCzHDYBIVnbqRlcb4qbgmT1vQZhs5ilEeSxspFshQ59v9P3UaiWMNWEN5WiaO3jlOJBwLHOsEEQIZyQkfRN5MMdVxZwSwz4yXqoaoIgpdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1608
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070068
X-Proofpoint-GUID: SHwIZd6Q8PIBXPuJyuGkOxYtJBG2DLTi
X-Proofpoint-ORIG-GUID: SHwIZd6Q8PIBXPuJyuGkOxYtJBG2DLTi
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Eli Cohen <elic@nvidia.com>
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

On Tue, Dec 07, 2021 at 02:21:46PM +0300, Dan Carpenter wrote:
> The "config.offset" comes from the user.  There needs to a check to
> prevent it being out of bounds.  The "config.offset" and
> "dev->config_size" variables are both type u32.  So if the offset if
> out of bounds then the "dev->config_size - config.offset" subtraction
> results in a very high u32 value.
> 
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: version 1 had a reversed if statement

Xie Yongji pointed out that vhost_vdpa_config_validate() had a similar
issue so I'll send a v3.

regards,
dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
