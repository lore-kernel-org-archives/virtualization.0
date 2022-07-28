Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2E1C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 00:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 812C140A30;
	Thu, 28 Jul 2022 00:57:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 812C140A30
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=uhaR1E6n;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=lvzx49Cg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oq3gJMRW571C; Thu, 28 Jul 2022 00:57:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 42CCD4053F;
	Thu, 28 Jul 2022 00:57:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42CCD4053F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0788C0033;
	Thu, 28 Jul 2022 00:57:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25B79C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 00:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E007E41768
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 00:57:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E007E41768
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=uhaR1E6n; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=lvzx49Cg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zI_zJadm-0OJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 00:57:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E9904175F
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5E9904175F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 00:57:09 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RNOHfR020314;
 Thu, 28 Jul 2022 00:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=MKyafCMyIkZnSaUxNfR4tRDeGx8YKMq/dKIPGJb0mLI=;
 b=uhaR1E6nRCZv4hzICEDzwdacGbJeTUW2kIWyCWL7f+gg0yQkajpvM4YOeuIXUBNXBda5
 oDtK0Ch5Q+xTrJ05OLVW0cVTOlDRbSM5lE8AWb7YNYRmZKbohSXOik891aj6vlYAgiSk
 WqXKoA26sm8yYVrKaBtA1E9mStmoFJDqB0fQ6vEwfBwglg9jHO0wjwiM+0plx9MRW/h1
 5Rwt+RVaHUUXA2w5Qe4/ZCf+TI5HISCZQOXSIydlS34bXcXGIzlfOxU9xWWe2u826aFJ
 tjtV7QsT9bSRVTalhMFf6d5t0sK3CzAB5nNvRvOBuSpdauDW+2Ihx0dqK5gZIFToLdss Dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsuk5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 00:57:04 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26RMjCIc019878; Thu, 28 Jul 2022 00:57:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh63a05qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 00:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILE36v68WrK+pWgETLoDuKOpuG9ImNKrbvKLZjMNVQjCFP2uULLkKgdbNAJSsxcVQL/zBTU086XG3j528aW1sVP2HwGXMPXsq3gcfr0dbH+sC3X+ZRWzEUO0TLhqKOaW++oz5fn3KUiS8khqy4B4aHA791MyOulBZvzJrImpAo9vVZknMXM//fBVkjb/kQcMR2E+yAScNRhVLfZRbPYYuQZdHb58Fk+4lht1GVhq7/haV5bnEJ7X3HQ6FCUWNHLo8iQfkAnnJ0O7v6hqZQziuup/KUeC+MvCc82xTFkFhcBVitJResF6HGEFezBKJg56O2mufn2514qSTv8kXcr7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKyafCMyIkZnSaUxNfR4tRDeGx8YKMq/dKIPGJb0mLI=;
 b=QevqZa4DfO7AKfk3PqEEKmbx4oVhTRz6iLoWHe8GAHFj2doGOigcS658TJLqmlP2O7VcZGfe9H6CDujRoHIg7Bq3ukruOQOHmQDnuXELAx0PkbQ8h45MDBOfqFb93JW7RdRfswVQ8MzEGoNpA0Vo6MT3N5PnFU/23Y6t9BpBFuGYJIanzk4a2DNI6jB9J5I/Ye+UQXQT0T78OZjhZNRLJGQP85n9lw9c0T7mG5/uzL0ClNMBhdVhngxKrJPu+8/K65oBjQHpymZ6M6I1SYNjYX+en7Av99Ks1Zx1hJaOTkLgax4BecAMz7trzf76NBMCCtjbEhHwPF8Gw4oazmETCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKyafCMyIkZnSaUxNfR4tRDeGx8YKMq/dKIPGJb0mLI=;
 b=lvzx49CgiHZz+9hgBkwDeyvdkGD1GNln6FaaaJd0lOssUyOFxdDk/Vd+1A1k5RrDSRWgPFnlnxb8cS6FiFrgmAtbx2X0/TTowyOeilWjG7wBRDUIiEL4meM70SHxpknAJuLcl8TNLdofrUwa+IJhJy2qr/U/NYxQe4tfeQu74m8=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DS7PR10MB4957.namprd10.prod.outlook.com (2603:10b6:5:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 28 Jul
 2022 00:57:00 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 00:57:00 +0000
Message-ID: <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
Date: Wed, 27 Jul 2022 17:56:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Parav Pandit <parav@nvidia.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
 <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
X-ClientProxiedBy: DM6PR10CA0035.namprd10.prod.outlook.com
 (2603:10b6:5:60::48) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31719794-e739-4175-de90-08da70341400
X-MS-TrafficTypeDiagnostic: DS7PR10MB4957:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +gCS7sRVbuXCOPTsvYtA7GlKG3R8B2zohpgThB5YRqzLEnqcIgbrvXWSxkLi3N3GX3OTDZ42+lSfDu8Y+rWJ9rK+dBSjep4xbPgID4cbhmAC9LOaRGkMZseffPyQiAt3VFsua6fbqF+8VvfDTGg6YsPyajO3dPvU5fELsd38b6QSUupuuH10hLsiws3aN+a5zXnEyG/YhDGwFDwt+Ejt/dnFRmejkAqj5KfLbn6lHOrI7IRHkcS+TAyg7+3eK6zBlnOu+LHvxW8hOqR6IChH6VFiPOAMMpvf/y9WKNzFwB0VixuBMPg2OxYus2iLO4ZfulmlmjhzmFW77SVxfg+v6Mnw5EShNob3wEzOm7H1cSvfHduBKc1QOrFDNBI9nySq2ll10q5iEJebYrOyUqmED3G656RwclYmdK7zUiWGnceM6tmC2eeKvKYO7ngq4OOAqJkf9YhsqgjythxmG1Ai3R8Y/Fl/wq2RRlQe0OQAbNzDIONpSeLFs8xqbrgPRVZkcXW4Nzs9wRWKE4V1aeguQ107m1Xf7s4gZny6T9Xl8q7OEsC9c4jREdPpVsJ+KkhgZFmWAE4qHXV0gLH7c214mYXsvIBnlBY1C105Fzxu5CbwHVYDZjOwyWFqLLYINi6S22JKRppjTrxk1/IjA+SkNB+026IDbXT/421GmrB787wqcvAaoHYuRj5ZVJ8i6sLB+Ir+MVvTChzIOBDpw4dWv+qynyoYkC3FZIICRKHWCRO78O0Z++DaGe9VY4yRHuIzh6soiXP00DS7l9BWxr1SaQ82k1e1+B+AYTsMBEKCr1viYb7XimD8+4rPNEaoKRSf4l2Ln3sFrIco50HcIRVrnttLZIueN07G8dlQKdBuSODgWSgwiIThY8a8RaRmauCE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(396003)(136003)(39860400002)(366004)(376002)(966005)(53546011)(38100700002)(31696002)(6506007)(36916002)(6486002)(33964004)(2616005)(26005)(86362001)(30864003)(478600001)(66556008)(6512007)(6666004)(166002)(2906002)(36756003)(186003)(5660300002)(8936002)(31686004)(41300700001)(8676002)(316002)(83380400001)(110136005)(4326008)(54906003)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YSt6L2lBMi9BMnpKOENJdWl3Q25tTWUvMlF3Z1dqVUk4Q2J5SkpFcmxZVEdG?=
 =?utf-8?B?ZzVYZU5CZk82WXY3eDBSRDA3QTRQTXFDTXpuby9lK0hvaUppZXovamRTcTh2?=
 =?utf-8?B?U25mSjNZL2RFblY0eEtpTC9VN1Rqd3RWNktvMzBwMTJsMG5Xa3hPQ080TXZL?=
 =?utf-8?B?c0lNbS9BaG5WRTFFSjJGTmJhdVFtM1duT0FFNStnWXJ3RkRuUXBqb3hVZHFY?=
 =?utf-8?B?NzYxTExiUGVFUDcrcmtmRkdaVnZRN3FBc0xwZUJnOHRveVVQSEFvcWd3UG1O?=
 =?utf-8?B?YXZLd3d5R2FvZmJRYVduWU40Qy9XOXNxVElreGJjb0lYMlhGWHZuNDlrMWRP?=
 =?utf-8?B?cmQ5RDFPNEIyMHppRkVyTVB3Sk1VcjRXbXlsVXdJSmVIcXNmVFE2ckpJODVG?=
 =?utf-8?B?ZXdnZFdxbWdwMXhvcE1FT2x3T0JpWUMrL0g1bHJzZGcvcklVZ1oxb3dsM2ww?=
 =?utf-8?B?Q3pVRFYzTStPRWhkSkg3NmRxSzhWZG9pajQ0bVFiV0M4alphbjVZRE8wbzZu?=
 =?utf-8?B?bzVENDlRb0NjVndCYzIvOFNOOFhTWm9yWnlsL01GbThIMG9ROHBDYUVGZGww?=
 =?utf-8?B?SkttRDBpak5KdDNsNVRQN2o2UDhDaUxBK2h3WWY0eU1nTG81U2hLQWJRbjJz?=
 =?utf-8?B?TUNxZ1V5aXJMa0NxUjY0clhaY2xpWEFrUmxLSFlLVDRFeUY1WDZERXBtcWFD?=
 =?utf-8?B?SzhoN0pPWi9SMTBLQUQvYVRtMmNyUXhJMk9oWGVvWmVTRnEzcmR6Wnk5bjBm?=
 =?utf-8?B?SHROZHlNSk1TQUtVak9Bd29OMzFnempkWWlzWFlYcWE1UUlhSmtBSEFRbUIv?=
 =?utf-8?B?SWxHZFVDZTJDZ0tJVzhMS3FrWDlqN2EyaTVvOS9xalk4a0o1elpwaFNMaHVa?=
 =?utf-8?B?eXBOSGFoVUVxQmxCcEw5Qi9jQmNQVXBrOFA0Q1NpeTRlVzZGTXNaUlJ5dDRE?=
 =?utf-8?B?Qm15c2R1alVSSmI2cnpQUkVKKzZtNCtLK2VYKzJWRGRvczQ1MHUySTZnb3la?=
 =?utf-8?B?L0ZtcmVwcVdrVlg4VlRZdHA1dU0ycDRrYUZZemRFZks0eG1pbGtjOWNYdGVn?=
 =?utf-8?B?Y1JlOVExUFFqNyszVlJBcGh4Z05wWjRQOU10ZDNrc2RMalFuZmZYdTNWREc4?=
 =?utf-8?B?SnVtc2h2NU5tZnl0aEhwclF4NTlrVW8ya3RxMlZwalpLUkdGVHRrOXFNVkhC?=
 =?utf-8?B?RzdaVS9lNFVkbGQzSEtXb3pUU3lVMEduWnBBRUNBaHlnNDZNYncwNExjMEE5?=
 =?utf-8?B?eEFaenBXeWdLczhvTzRGUzNWY1g3b09SODgzcUc0YTFIVlVVYkVOYW92QUFL?=
 =?utf-8?B?VnJiNVQ5bEIydWgxNVVVOXM5UWtEUnhnRGFHOFkya0x2NnZ5eUVwUCtJZlhs?=
 =?utf-8?B?OXo5Wm1IMGpBRzdTNjJTaXhtVGhIeXZYLzkxS2w0L0djbGUyNmhUZktydHJp?=
 =?utf-8?B?ckxpSHpwczJmVWdCYkRQTUcxZXp4L3kvc2hGaFhGMDNocTM0Z1RFeG4yV3Ro?=
 =?utf-8?B?eHByYXJHWXBxb3gzZkk2WVJRQUxXRU1hZldqdzk0MXF2WDJ2U1NzUkZNTVkz?=
 =?utf-8?B?czVyczlMMFk0d21HZStNRS9sQW9DRUQwMkVGWHJkN050VDJrU1oxSE9ORDJK?=
 =?utf-8?B?SFVlc21rb3VqVHBFc2xHWStSZkw5VkRFL3VIRXFpalZFOVJ0dWxYa05YNkxa?=
 =?utf-8?B?MERRR1RxcTAyNk5Va3QySENDWGR4bkpEaDdUSFZTeDArSnRrcW5FYjlFNUFV?=
 =?utf-8?B?Y1ovaEViTENjeVpUMktHcGRWQTJxWjF5YXJwWmNXOTlERE14TlE5QWZSeEt1?=
 =?utf-8?B?QzZJbWVVQWhKK1ZKTHlhREZmV3lxaDBGMEFGTDQxb0pORUtEMGVaZjNORmJq?=
 =?utf-8?B?bXJRU0dGeDRIVTEveVFvREphQkJBMzlRL2I0TGx3d0RvZ2JwbzdZN0VuWFBu?=
 =?utf-8?B?ZXk4WENhZXQ4QXd5RWpBNmZCZ2ZwMU9iUmVvRHNiTVMyR2V5R0FHZ2M3OWJr?=
 =?utf-8?B?ak9HZHkvdkpQRE0rV2liK1FZSVRQZ0ppb2lSUDRDUFdydVByc2pjVFpuWFBI?=
 =?utf-8?B?M05NUWxnSlRtSGNqNGpwbDVTQ2FWY0xQNmlNL1JhUmpjcThDMjhHYmEyZzRW?=
 =?utf-8?Q?sDOx4yB/JEMX68ME/Rlz6mOTA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31719794-e739-4175-de90-08da70341400
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 00:57:00.4276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTJO1TU5yoFCAtq4Bo22LBl/Tx6e6WXI4oigFtjD8olU5zUrdtmtQFi8JfzDw+ctmspPYNGFOVOCyODn6tV3VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_08,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280001
X-Proofpoint-ORIG-GUID: wFfpLLQr3oj_IV9-zJuJoF_ipIIrqyXk
X-Proofpoint-GUID: wFfpLLQr3oj_IV9-zJuJoF_ipIIrqyXk
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>
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
Content-Type: multipart/mixed; boundary="===============6005399719952267790=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============6005399719952267790==
Content-Type: multipart/alternative;
 boundary="------------jBtDiNACHm9TxpGyVlbCikUc"
Content-Language: en-US

--------------jBtDiNACHm9TxpGyVlbCikUc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/27/2022 4:47 AM, Zhu, Lingshan wrote:
>
>
> On 7/27/2022 5:43 PM, Si-Wei Liu wrote:
>> Sorry to chime in late in the game. For some reason I couldn't get to 
>> most emails for this discussion (I only subscribed to the 
>> virtualization list), while I was taking off amongst the past few weeks.
>>
>> It looks to me this patch is incomplete. Noted down the way in 
>> vdpa_dev_net_config_fill(), we have the following:
>>          features = vdev->config->get_driver_features(vdev);
>>          if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
>>                                VDPA_ATTR_PAD))
>>                  return -EMSGSIZE;
>>
>> Making call to .get_driver_features() doesn't make sense when feature 
>> negotiation isn't complete. Neither should present 
>> negotiated_features to userspace before negotiation is done.
>>
>> Similarly, max_vqp through vdpa_dev_net_mq_config_fill() probably 
>> should not show before negotiation is done - it depends on driver 
>> features negotiated.
> I have another patch in this series introduces device_features and 
> will report device_features to the userspace even features negotiation 
> not done. Because the spec says we should allow driver access the 
> config space before FEATURES_OK.
The config space can be accessed by guest before features_ok doesn't 
necessarily mean the value is valid. You may want to double check with 
Michael for what he quoted earlier:
> Nope:
>
> 2.5.1  Driver Requirements: Device Configuration Space
>
> ...
>
> For optional configuration space fields, the driver MUST check that the corresponding feature is offered
> before accessing that part of the configuration space.

and how many driver bugs taking wrong assumption of the validity of 
config space field without features_ok. I am not sure what use case you 
want to expose config resister values for before features_ok, if it's 
mostly for live migration I guess it's probably heading a wrong direction.


>>
>>
>> Last but not the least, this "vdpa dev config" command was not 
>> designed to display the real config space register values in the 
>> first place. Quoting the vdpa-dev(8) man page:
>>
>>> vdpa dev config show - Show configuration of specific device or all 
>>> devices.
>>> DEV - specifies the vdpa device to show its configuration. If this 
>>> argument is omitted all devices configuration is listed.
>> It doesn't say anything about configuration space or register values 
>> in config space. As long as it can convey the config attribute when 
>> instantiating vDPA device instance, and more importantly, the config 
>> can be easily imported from or exported to userspace tools when 
>> trying to reconstruct vdpa instance intact on destination host for 
>> live migration, IMHO in my personal interpretation it doesn't matter 
>> what the config space may present. It may be worth while adding a new 
>> debug command to expose the real register value, but that's another 
>> story.
> I am not sure getting your points. vDPA now reports device feature 
> bits(device_features) and negotiated feature bits(driver_features), 
> and yes, the drivers features can be a subset of the device features; 
> and the vDPA device features can be a subset of the management device 
> features.
What I said is after unblocking the conditional check, you'd have to 
handle the case for each of the vdpa attribute when feature negotiation 
is not yet done: basically the register values you got from config space 
via the vdpa_get_config_unlocked() call is not considered to be valid 
before features_ok (per-spec). Although in some case you may get sane 
value, such behavior is generally undefined. If you desire to show just 
the device_features alone without any config space field, which the 
device had advertised *before feature negotiation is complete*, that'll 
be fine. But looks to me this is not how patch has been implemented. 
Probably need some more work?

Regards,
-Siwei

>>
>> Having said, please consider to drop the Fixes tag, as appears to me 
>> you're proposing a new feature rather than fixing a real issue.
> it's a new feature to report the device feature bits than only 
> negotiated features, however this patch is a must, or it will block 
> the device feature bits reporting. but I agree, the fix tag is not a must.
>>
>> Thanks,
>> -Siwei
>>
>> On 7/1/2022 3:12 PM, Parav Pandit via Virtualization wrote:
>>>> From: Zhu Lingshan<lingshan.zhu@intel.com>
>>>> Sent: Friday, July 1, 2022 9:28 AM
>>>>
>>>> Users may want to query the config space of a vDPA device, to choose a
>>>> appropriate one for a certain guest. This means the users need to read the
>>>> config space before FEATURES_OK, and the existence of config space
>>>> contents does not depend on FEATURES_OK.
>>>>
>>>> The spec says:
>>>> The device MUST allow reading of any device-specific configuration field
>>>> before FEATURES_OK is set by the driver. This includes fields which are
>>>> conditional on feature bits, as long as those feature bits are offered by the
>>>> device.
>>>>
>>>> Fixes: 30ef7a8ac8a07 (vdpa: Read device configuration only if FEATURES_OK)
>>> Fix is fine, but fixes tag needs correction described below.
>>>
>>> Above commit id is 13 letters should be 12.
>>> And
>>> It should be in format
>>> Fixes: 30ef7a8ac8a0 ("vdpa: Read device configuration only if FEATURES_OK")
>>>
>>> Please use checkpatch.pl script before posting the patches to catch these errors.
>>> There is a bot that looks at the fixes tag and identifies the right kernel version to apply this fix.
>>>
>>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@intel.com>
>>>> ---
>>>>   drivers/vdpa/vdpa.c | 8 --------
>>>>   1 file changed, 8 deletions(-)
>>>>
>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
>>>> 9b0e39b2f022..d76b22b2f7ae 100644
>>>> --- a/drivers/vdpa/vdpa.c
>>>> +++ b/drivers/vdpa/vdpa.c
>>>> @@ -851,17 +851,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
>>>> struct sk_buff *msg, u32 portid,  {
>>>>   	u32 device_id;
>>>>   	void *hdr;
>>>> -	u8 status;
>>>>   	int err;
>>>>
>>>>   	down_read(&vdev->cf_lock);
>>>> -	status = vdev->config->get_status(vdev);
>>>> -	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>>> -		NL_SET_ERR_MSG_MOD(extack, "Features negotiation not
>>>> completed");
>>>> -		err = -EAGAIN;
>>>> -		goto out;
>>>> -	}
>>>> -
>>>>   	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
>>>>   			  VDPA_CMD_DEV_CONFIG_GET);
>>>>   	if (!hdr) {
>>>> --
>>>> 2.31.1
>>> _______________________________________________
>>> Virtualization mailing list
>>> Virtualization@lists.linux-foundation.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>>
>

--------------jBtDiNACHm9TxpGyVlbCikUc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 7/27/2022 4:47 AM, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:63242254-ba84-6810-dad8-34f900b97f2f@intel.com">
      
      <font face="monospace"><br>
        <br>
      </font>
      <div class="moz-cite-prefix"><font face="monospace">On 7/27/2022
          5:43 PM, Si-Wei Liu wrote:<br>
        </font></div>
      <blockquote type="cite" cite="mid:00889067-50ac-d2cd-675f-748f171e5c83@oracle.com"> <font face="monospace"> Sorry to chime in late in the game. For some
          reason I couldn't get to most emails for this discussion (I
          only subscribed to the virtualization list), while I was
          taking off amongst the past few weeks. <br>
        </font> <font face="monospace"><br>
          It looks to me this patch is incomplete. Noted down the way in
          vdpa_dev_net_config_fill(), we have the following: </font>
        <pre id="b" style="font-size: 13px; background: rgb(255, 255, 255) none repeat scroll 0% 0%; color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">        features = vdev-&gt;config-&gt;get_driver_features(vdev);
        if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
                              VDPA_ATTR_PAD))
                return -EMSGSIZE;

</pre>
        <font face="monospace"> Making call to .get_driver_features()
          doesn't make sense when feature negotiation isn't complete.
          Neither should present negotiated_features to userspace before
          negotiation is done.<br>
        </font> <font face="monospace"><br>
          Similarly, max_vqp through vdpa_dev_net_mq_config_fill()
          probably should not show before negotiation is done - it
          depends on driver features negotiated.</font></blockquote>
      <font face="monospace">I have another patch in this series
        introduces device_features and will report device_features to
        the userspace even features negotiation not done. Because the
        spec says we should allow driver access the config space before
        FEATURES_OK.</font><br>
    </blockquote>
    The config space can be accessed by guest before features_ok doesn't
    necessarily mean the value is valid. You may want to double check
    with Michael for what he quoted earlier:<br>
    <blockquote type="cite">
      <pre class="moz-quote-pre" wrap="">Nope:

2.5.1  Driver Requirements: Device Configuration Space

...

For optional configuration space fields, the driver MUST check that the corresponding feature is offered
before accessing that part of the configuration space.
</pre>
    </blockquote>
    <br>
    and how many driver bugs taking wrong assumption of the validity of
    config space field without features_ok. I am not sure what use case
    you want to expose config resister values for before features_ok, if
    it's mostly for live migration I guess it's probably heading a wrong
    direction.<br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:63242254-ba84-6810-dad8-34f900b97f2f@intel.com">
      <blockquote type="cite" cite="mid:00889067-50ac-d2cd-675f-748f171e5c83@oracle.com"><font face="monospace"> <br>
        </font> <font face="monospace"><br>
          Last but not the least, this &quot;vdpa dev config&quot; command was not
          designed to display the real config space register values in
          the first place. Quoting the vdpa-dev(8) man page:<br>
        </font> <font face="monospace"><br>
        </font>
        <blockquote type="cite"><font face="monospace">vdpa dev config
            show - Show configuration of specific device or all devices.<br>
            DEV - specifies the vdpa device to show its configuration.
            If this argument is omitted all devices configuration is
            listed.</font></blockquote>
        <font face="monospace"> It doesn't say anything about
          configuration space or register values in config space. As
          long as it can convey the config attribute when instantiating
          vDPA device instance, and more importantly, the config can be
          easily imported from or exported to userspace tools when
          trying to reconstruct vdpa instance intact on destination host
          for live migration, IMHO in my personal interpretation it
          doesn't matter what the config space may present. It may be
          worth while adding a new debug command to expose the real
          register value, but that's another story.<br>
        </font></blockquote>
      <font face="monospace">I am not sure getting your points. vDPA now
        reports device feature bits(device_features) and negotiated
        feature bits(driver_features), and yes, the drivers features can
        be a subset of the device features; and the vDPA device features
        can be a subset of the management device features. </font><br>
    </blockquote>
    What I said is after unblocking the conditional check, you'd have to
    handle the case for each of the vdpa attribute when feature
    negotiation is not yet done: basically the register values you got
    from config space via the vdpa_get_config_unlocked() call is not
    considered to be valid before features_ok (per-spec). Although in
    some case you may get sane value, such behavior is generally
    undefined. If you desire to show just the device_features alone
    without any config space field, which the device had advertised
    *before feature negotiation is complete*, that'll be fine. But looks
    to me this is not how patch has been implemented. Probably need some
    more work?<br>
    <br>
    Regards,<br>
    -Siwei<br>
    <br>
    <blockquote type="cite" cite="mid:63242254-ba84-6810-dad8-34f900b97f2f@intel.com">
      <blockquote type="cite" cite="mid:00889067-50ac-d2cd-675f-748f171e5c83@oracle.com"> <font face="monospace"><br>
          Having said, please consider to drop the Fixes tag, as appears
          to me you're proposing a new feature rather than fixing a real
          issue.<br>
        </font></blockquote>
      <font face="monospace">it's a new feature to report the device
        feature bits than only negotiated features, however this patch
        is a must, or it will block the device feature bits reporting.
        but I agree, the fix tag is not a must.</font><br>
      <blockquote type="cite" cite="mid:00889067-50ac-d2cd-675f-748f171e5c83@oracle.com"> <font face="monospace"><br>
          Thanks,<br>
          -Siwei<br>
        </font> <font face="monospace"><br>
        </font>
        <div class="moz-cite-prefix"><font face="monospace">On 7/1/2022
            3:12 PM, Parav Pandit via Virtualization wrote:<br>
          </font> </div>
        <blockquote type="cite" cite="mid:PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">From: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com" moz-do-not-send="true">&lt;lingshan.zhu@intel.com&gt;</a>
Sent: Friday, July 1, 2022 9:28 AM

Users may want to query the config space of a vDPA device, to choose a
appropriate one for a certain guest. This means the users need to read the
config space before FEATURES_OK, and the existence of config space
contents does not depend on FEATURES_OK.

The spec says:
The device MUST allow reading of any device-specific configuration field
before FEATURES_OK is set by the driver. This includes fields which are
conditional on feature bits, as long as those feature bits are offered by the
device.

Fixes: 30ef7a8ac8a07 (vdpa: Read device configuration only if FEATURES_OK)
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Fix is fine, but fixes tag needs correction described below.

Above commit id is 13 letters should be 12.
And 
It should be in format
Fixes: 30ef7a8ac8a0 (&quot;vdpa: Read device configuration only if FEATURES_OK&quot;)

Please use checkpatch.pl script before posting the patches to catch these errors.
There is a bot that looks at the fixes tag and identifies the right kernel version to apply this fix.

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com" moz-do-not-send="true">&lt;lingshan.zhu@intel.com&gt;</a>
---
 drivers/vdpa/vdpa.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
9b0e39b2f022..d76b22b2f7ae 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -851,17 +851,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev,
struct sk_buff *msg, u32 portid,  {
 	u32 device_id;
 	void *hdr;
-	u8 status;
 	int err;

 	down_read(&amp;vdev-&gt;cf_lock);
-	status = vdev-&gt;config-&gt;get_status(vdev);
-	if (!(status &amp; VIRTIO_CONFIG_S_FEATURES_OK)) {
-		NL_SET_ERR_MSG_MOD(extack, &quot;Features negotiation not
completed&quot;);
-		err = -EAGAIN;
-		goto out;
-	}
-
 	hdr = genlmsg_put(msg, portid, seq, &amp;vdpa_nl_family, flags,
 			  VDPA_CMD_DEV_CONFIG_GET);
 	if (!hdr) {
--
2.31.1
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">_______________________________________________
Virtualization mailing list
<a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:Virtualization@lists.linux-foundation.org" moz-do-not-send="true">Virtualization@lists.linux-foundation.org</a>
<a class="moz-txt-link-freetext" href="https://urldefense.com/v3/__https://lists.linuxfoundation.org/mailman/listinfo/virtualization__;!!ACWV5N9M2RV99hQ!LDynmbymNkIgZ-j_42iYXBJp8Vhi4QiQkE8Q0FdeqMPWsM_uIZ4pT5CnK8kWg9c8kmxlTr-37myDtRbsLlTaVuA$" moz-do-not-send="true">https://lists.linuxfoundation.org/mailman/listinfo/virtualization</a>
</pre>
        </blockquote>
        <font face="monospace"><br>
        </font> </blockquote>
      <font face="monospace"><br>
      </font> </blockquote>
    <br>
  </body>
</html>

--------------jBtDiNACHm9TxpGyVlbCikUc--

--===============6005399719952267790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6005399719952267790==--
