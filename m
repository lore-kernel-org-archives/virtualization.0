Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FE6C433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 01:12:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E4D64E31
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 01:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E4D64E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5D116074E;
	Tue, 23 Feb 2021 01:12:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AcpB8s0LkRAh; Tue, 23 Feb 2021 01:12:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F7D460707;
	Tue, 23 Feb 2021 01:12:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E3EFC000A;
	Tue, 23 Feb 2021 01:12:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9636EC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 01:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7D33B87152
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 01:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rzQcAE2iA87
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 01:12:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 93192870D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 01:12:19 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11N19CTl172732;
 Tue, 23 Feb 2021 01:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GkRh8iv09tX2YyX0Bisf8UWO6+RG6ZbBSXklIykkIls=;
 b=wulqWBy9FTPvANiu2S99Xaw9euBWe+WHbF0MdHvO5KWHklDxnBDfMc8pbn8PRF6yyH+v
 eMfUCYsUMCDQN/P4PmZKX7YOC0a/LGid0AtDxc8a5gtBUEG8CH7Uy5r88Oi3TR1fkQL3
 5qfu54pYHkN/1U5qlAcD3L9cBVDXPHOO7TDGcyFx/dndwDJGs7temGM665B7EaSHTicy
 WWr330OFOwl99Rk6XDULOvM/kOX8ZFKYloP3dCLNyB9SMX5E4C6puPrmBjOVqv4kTmTG
 EXP//SDEy6jRYVeBybBPDzlNJuoB5aKqyBtMVcMAd2PCTvDTGXIAoyyzXPycJ3LYXa2z BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 36tsuqwmer-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Feb 2021 01:12:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11N16RLb130384;
 Tue, 23 Feb 2021 01:12:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by userp3030.oracle.com with ESMTP id 36ucbwtc3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Feb 2021 01:12:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M68gHJFkqj7qlXKfdY3/qoXCLocUT10MOE/HKy6rU85wWmqsrt3Kx7LGp0Hxatj5y3qWZQ1q4PzH2zncZeUpczFlt9wk8BnmdwGIzfX8ys4/0lfyDRXQ1z2SsCxe/bJECqXShchY80Tjkigf/EKW4Mcsnodize4hpNnKddbdZnwXQvK6Sx1T8ZGx6VKC3WloKJr38MnygRh/DBBA14EcL7gDQSm4OFuyZSYfnepNw4XO36Io9jjlHVS8oODrQwNOiIgHZDtYUJeZge1yd63bfZ1TedEuU/SPXoWnBpMFIvWagFlIZtdQ5ZdfuRQ2nrnaeggKTYzo40FpD1WzMLZQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkRh8iv09tX2YyX0Bisf8UWO6+RG6ZbBSXklIykkIls=;
 b=g6PBqLbuADn7NrgWstZUNlw/Ypy9KHMN6d0jgY+t8YarzbQGUFH5FNrgN1AOUbscJgrVsfkDCBpmiC776Wzs+a8nZYRExXR2Rd2Eda9buTYgC3f90unv3HVu8z8+SWAax0gtUj8ZKWSoBPJpVmlu0s4lk/km3khhc4tjdDEmDpVAsSQ0bfxHPtSEJzqbdcPpY3p1K2gpU/TH79dBDjLe22tPiZYEzd2u8AUrRpXogdX5khbeLstPU80iSwIG33GWRA2CrK4nU4OUvAqkdN789cNBUoQXzcRZbYNmN6EhYnhs/OD1O26hk+wRdSj5mH5e3D1sNEst7eVoClFFJCvq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkRh8iv09tX2YyX0Bisf8UWO6+RG6ZbBSXklIykkIls=;
 b=I4BFLq2KxmO1xJxPBcIFWyIwzjGouLw2ClvtVnUShG8Wx7W92afBEVKMFIfGIl+7s+D4u70V+NC4qiGkxhmgMCtXJpgYMUIq1fBI2utY1TRI9VNzVe8+sda14ieN5yXLgKRae2l3ZB7tlkXIqkjHmyHldFQbk3wqcaBJti3s3r4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=none action=none header.from=oracle.com; 
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SJ0PR10MB4511.namprd10.prod.outlook.com (2603:10b6:a03:2de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.41; Tue, 23 Feb
 2021 01:12:16 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::45b5:49d:d171:5359%5]) with mapi id 15.20.3868.031; Tue, 23 Feb 2021
 01:12:16 +0000
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
Message-ID: <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
Date: Mon, 22 Feb 2021 17:12:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210222023040-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Originating-IP: [24.6.170.153]
X-ClientProxiedBy: SN4PR0501CA0144.namprd05.prod.outlook.com
 (2603:10b6:803:2c::22) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.19] (24.6.170.153) by
 SN4PR0501CA0144.namprd05.prod.outlook.com (2603:10b6:803:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.10 via Frontend
 Transport; Tue, 23 Feb 2021 01:12:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e913a42e-10e9-495b-4159-08d8d7980f08
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4511:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4511314D056DF4916105855BB1809@SJ0PR10MB4511.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+22IUYNuuk8BlIfUs6chcJlSaAhvL4TDnUh6d74JkUwic7Ipj0yFvAg0Uphqy2OqOCn3GzmTXi0W+O0y1vpQPiUueD6SGHO2JngcH+0AxBz9EGDUzP413+OH/oKbw9O+K3d4+Pagk7/YCgxIk/QZ/7ItNoVhFzDeMttUAycXZo1aIPH9LLarMede1Wo59QcxT0aJtm2HC13fm81uTYBTvaNHWkkdZdRfl6lATauuPvyHseuEaRDVvGDtOkA6aevkTPiFi9ah/Q1eeUidrpBtQTnhQLlu73HMlpx9TdCWHNhuxhcZStXi+qfVUtgAPcpD6xjD8Ag+g/lf4/oEBDi+AOBkBOsBGfKitRhpxKHqW3Oaii9XecvwDgR/m1PRZPV0vIG/p82JpjitfSLcJiCcUeeI0NarfSzpp4+u+XPPXUcq8NxDkXPPTBd741VWZqYWn4lykYeY5Y9hJu4gRCVesWi5zlSpAoUOZdyTRMaT4EfJnDeCj+5E6sZSnSUyxfKNjn8ShRDSvN2ddTwh40HathyLnwjaT6GQrJ9CjAVWbBhVhh+rnndZrZQxb8m/447IZugzrfQsIQTZKZXf6GbCtuDRhE4KkeEeIE9TWttZV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(136003)(376002)(396003)(366004)(4326008)(83380400001)(36916002)(316002)(6486002)(478600001)(8676002)(2616005)(5660300002)(6666004)(31686004)(956004)(36756003)(16576012)(66476007)(8936002)(110136005)(26005)(2906002)(31696002)(16526019)(86362001)(186003)(66946007)(66556008)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2VhTWIvM3NkR056NVlYcStLTWVoL3FkS3VwVW1GVTMvOUxGZEthL2ZrY290?=
 =?utf-8?B?WU16bUQyS3VFODBWalB4QWc1S2JzMGs2K3l6T0YyaHFlTCtpQ3BkU09qRFZY?=
 =?utf-8?B?MktUT2lvaDYvV2xzQXJ0a3dzdkJ5ZVJtVjJwR0pleEFPWU5EQWRCdURSRjdp?=
 =?utf-8?B?UDZpUTZWSGVnMkJTbUNpSGFWckt6VVJ3ZGt6UGpyOWRicGNWbnUybUJ6c0Ux?=
 =?utf-8?B?dFJqZWgyVXVra0Mxcy9MSW5GQ3VPRXpWYXJaaEtZaFVZVHFzWEVvN0oxcGFP?=
 =?utf-8?B?a3JUSjh3TzFadk90bnZCTGN5RmRmbG10WjZJc1gzMnVtTUx5Nkw1NTFIUndh?=
 =?utf-8?B?bncrTEdRWnlxS2FPMEY4TUxneW9PeHZrZmo5NDZ0ZGxiUGxNVFBpOUVZRk9T?=
 =?utf-8?B?WmZrMlF6WFZCa09SV2hmdHpvSzQ2dmlVdDRHNk01S2ZkbW1OZ3QycjZYVXRQ?=
 =?utf-8?B?R0FsdGhFZEJqS0ZGdG9tK1JCeEwzdkVVdWF4N0ZyYzdESmFBWE5BZjF1TWRw?=
 =?utf-8?B?eGVielpPYVZaMHVjT1NOalh0Z01xTm0zRjNpWUp4eGRkR2wxT3c3bmdPMHhF?=
 =?utf-8?B?K1J6cjJTQUFGNlhscEZYSnNzckJTa1d6T25kSmhmVXAvdW9EV1NKSFNraWpk?=
 =?utf-8?B?UnB1WGJpV2FNMGtsdWtLNWFUa0Z6b043VFhndE5vK3lWd21JZitIQWJtU0tl?=
 =?utf-8?B?cXdzLzNnRStWOHlyTkhyRW5tdWk0L1ppd3NRU2J5Qkl6K3Zwa1ZHNWdEeDNB?=
 =?utf-8?B?MFM1bzJWQUJuL0dKdk4wQnZacG5TZ2cvRGoxWkJWYTRGSitlU3JFcjgwYU5L?=
 =?utf-8?B?RUo0RXJUb3FHYmNOMXVIbU1CVFpuVURtL0ZIZ1FqeUtwSm5wYWViUVZHdlRQ?=
 =?utf-8?B?WFBOM1REZU1hcTh4ZURlT01KNVpWbWpMUExWbHl0RVhrdGtCcVIyODlnVFhp?=
 =?utf-8?B?S1JKR3JvTHBsN2lka3V5b2IvaTd6Wkt4U2lZdm5qb3R6ZEFhdk8yVUQvckt5?=
 =?utf-8?B?dUVVWTAxR3llWFRFNGZtNTlOanhDYnZzUkN1MDVqMGlYNkFKb2dFbUl4Q1pI?=
 =?utf-8?B?SkQ1VVdxdFBkQW1xbTJuNHUzYjd0TGpsVXdXeVpQQ1I1S3JraGxWYS9HcjN4?=
 =?utf-8?B?ZUpxL1RiYktwTzZhSTlKY2t3RURRcFI5VEpnOEpqcGkwVVRNcUFBUEdZdTB5?=
 =?utf-8?B?b2MxaDcxTFVzVmt5UHZnWWZBbEtSTWRLOE9uMCtZNWk0MStPSi9Wb3V4aDE2?=
 =?utf-8?B?TlJYYzRGVnBsU3U2cnJuUUpXRXlRcWNnMm9QMWV2NThQMTc1bDdINUJxVlhF?=
 =?utf-8?B?N0ZKenlGZmw2YVRMeVUyeVhKZDF5TXo0TlNGMm03Z25JSUJETjlZTFpUdzJX?=
 =?utf-8?B?WXBXazlIbmw2QXZsckdXMHhmTWRJT1drQXBuWkVudlg0aG1yN015OTRZUWVL?=
 =?utf-8?B?aFVWWS9JV1lpYnVSZGZKUEdJcG9RVUNXMERjZ3BxSmxLd216dzk5UHVKWmo0?=
 =?utf-8?B?bHFlTGNPRHh1T3JXdVdkenNmVmlyb2pLWVdHRWlleWNrVC9FdHdLb1VpbjJV?=
 =?utf-8?B?eFRleExub0trSDJkY1lrY3J0VGpkZm03bFJ2Y2dtLzh3V2hVVks0aGJHZkcv?=
 =?utf-8?B?UG1PbVdmNFJFYzViYXA0VGZ4NjlQYWdGbEhBeW93N0h3V1VrU3IyNCtCN2xV?=
 =?utf-8?B?cDJ5MUY2M01ONkRoWkwyWTVWbUEreGpXNWRlZ3p3TjQzd1ZBdzJHYXhLWFB6?=
 =?utf-8?Q?zVdZNQ/MV4gNmgKPuV8px3OX3R9DRS19L/MaoPi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e913a42e-10e9-495b-4159-08d8d7980f08
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 01:12:16.4152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9nChHu7oNCAwlPe92MRymibkPUOhuk+/0VABU8oB502ybBrAxElC6ZSucuizOLGMY4Sinsciq6/txYVgDu2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4511
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230006
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102230006
Cc: netdev@vger.kernel.org, elic@nvidia.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiAyLzIxLzIwMjEgMTE6MzQgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBN
b24sIEZlYiAyMiwgMjAyMSBhdCAxMjoxNDoxN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBPbiAyMDIxLzIvMTkgNzo1NCDkuIvljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+PiBDb21taXQg
NDUyNjM5YTY0YWQ4ICgidmRwYTogbWFrZSBzdXJlIHNldF9mZWF0dXJlcyBpcyBpbnZva2VkCj4+
PiBmb3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRpb24gZm9yIGxlZ2FjeSBndWVzdHMgdG8gcmVz
ZXQKPj4+IGZlYXR1cmVzIHRvIDAsIHdoZW4gY29uZmlnIHNwYWNlIGlzIGFjY2Vzc2VkIGJlZm9y
ZSBmZWF0dXJlcwo+Pj4gYXJlIHNldC4gV2Ugc2hvdWxkIHJlbGlldmUgdGhlIHZlcmlmeV9taW5f
ZmVhdHVyZXMoKSBjaGVjawo+Pj4gYW5kIGFsbG93IGZlYXR1cmVzIHJlc2V0IHRvIDAgZm9yIHRo
aXMgY2FzZS4KPj4+Cj4+PiBJdCdzIHdvcnRoIG5vdGluZyB0aGF0IG5vdCBqdXN0IGxlZ2FjeSBn
dWVzdHMgY291bGQgYWNjZXNzCj4+PiBjb25maWcgc3BhY2UgYmVmb3JlIGZlYXR1cmVzIGFyZSBz
ZXQuIEZvciBpbnN0YW5jZSwgd2hlbgo+Pj4gZmVhdHVyZSBWSVJUSU9fTkVUX0ZfTVRVIGlzIGFk
dmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4+PiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZh
bGlkYXRlIHRoZSBNVFUgcHJlc2VudCBpbiB0aGUgY29uZmlnCj4+PiBzcGFjZSBiZWZvcmUgdmly
dGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4+Cj4+IFRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0
aW9uOgo+Pgo+PiAiCj4+Cj4+IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCwg
bXR1IG9ubHkgZXhpc3RzIGlmIFZJUlRJT19ORVRfRl9NVFUgaXMKPj4gc2V0Lgo+PiBUaGlzIGZp
ZWxkIHNwZWNpZmllcyB0aGUgbWF4aW11bSBNVFUgZm9yIHRoZSBkcml2ZXIgdG8gdXNlLgo+PiAi
Cj4+Cj4+IERvIHdlIHJlYWxseSB3YW50IHRvIHdvcmthcm91bmQgdGhpcz8KPj4KPj4gVGhhbmtz
Cj4gQW5kIGFsc286Cj4KPiBUaGUgZHJpdmVyIE1VU1QgZm9sbG93IHRoaXMgc2VxdWVuY2UgdG8g
aW5pdGlhbGl6ZSBhIGRldmljZToKPiAxLiBSZXNldCB0aGUgZGV2aWNlLgo+IDIuIFNldCB0aGUg
QUNLTk9XTEVER0Ugc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGhhcyBub3RpY2VkIHRoZSBkZXZp
Y2UuCj4gMy4gU2V0IHRoZSBEUklWRVIgc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGtub3dzIGhv
dyB0byBkcml2ZSB0aGUgZGV2aWNlLgo+IDQuIFJlYWQgZGV2aWNlIGZlYXR1cmUgYml0cywgYW5k
IHdyaXRlIHRoZSBzdWJzZXQgb2YgZmVhdHVyZSBiaXRzIHVuZGVyc3Rvb2QgYnkgdGhlIE9TIGFu
ZCBkcml2ZXIgdG8gdGhlCj4gZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRoZSBkcml2ZXIgTUFZ
IHJlYWQgKGJ1dCBNVVNUIE5PVCB3cml0ZSkgdGhlIGRldmljZS1zcGVjaWZpYyBjb25maWd1cmF0
aW9uCj4gZmllbGRzIHRvIGNoZWNrIHRoYXQgaXQgY2FuIHN1cHBvcnQgdGhlIGRldmljZSBiZWZv
cmUgYWNjZXB0aW5nIGl0Lgo+IDUuIFNldCB0aGUgRkVBVFVSRVNfT0sgc3RhdHVzIGJpdC4gVGhl
IGRyaXZlciBNVVNUIE5PVCBhY2NlcHQgbmV3IGZlYXR1cmUgYml0cyBhZnRlciB0aGlzIHN0ZXAu
Cj4gNi4gUmUtcmVhZCBkZXZpY2Ugc3RhdHVzIHRvIGVuc3VyZSB0aGUgRkVBVFVSRVNfT0sgYml0
IGlzIHN0aWxsIHNldDogb3RoZXJ3aXNlLCB0aGUgZGV2aWNlIGRvZXMgbm90Cj4gc3VwcG9ydCBv
dXIgc3Vic2V0IG9mIGZlYXR1cmVzIGFuZCB0aGUgZGV2aWNlIGlzIHVudXNhYmxlLgo+IDcuIFBl
cmZvcm0gZGV2aWNlLXNwZWNpZmljIHNldHVwLCBpbmNsdWRpbmcgZGlzY292ZXJ5IG9mIHZpcnRx
dWV1ZXMgZm9yIHRoZSBkZXZpY2UsIG9wdGlvbmFsIHBlci1idXMgc2V0dXAsCj4gcmVhZGluZyBh
bmQgcG9zc2libHkgd3JpdGluZyB0aGUgZGV2aWNl4oCZcyB2aXJ0aW8gY29uZmlndXJhdGlvbiBz
cGFjZSwgYW5kIHBvcHVsYXRpb24gb2YgdmlydHF1ZXVlcy4KPiA4LiBTZXQgdGhlIERSSVZFUl9P
SyBzdGF0dXMgYml0LiBBdCB0aGlzIHBvaW50IHRoZSBkZXZpY2UgaXMg4oCcbGl2ZeKAnS4KPgo+
Cj4gc28gYWNjZXNzaW5nIGNvbmZpZyBzcGFjZSBiZWZvcmUgRkVBVFVSRVNfT0sgaXMgYSBzcGVj
IHZpb2xhdGlvbiwgcmlnaHQ/Ckl0IGlzLCBidXQgaXQncyBub3QgcmVsZXZhbnQgdG8gd2hhdCB0
aGlzIGNvbW1pdCB0cmllcyB0byBhZGRyZXNzLiBJIAp0aG91Z2h0IHRoZSBsZWdhY3kgZ3Vlc3Qg
c3RpbGwgbmVlZHMgdG8gYmUgc3VwcG9ydGVkLgoKSGF2aW5nIHNhaWQsIGEgc2VwYXJhdGUgcGF0
Y2ggaGFzIHRvIGJlIHBvc3RlZCB0byBmaXggdGhlIGd1ZXN0IGRyaXZlciAKaXNzdWUgd2hlcmUg
dGhpcyBkaXNjcmVwYW5jeSBpcyBpbnRyb2R1Y2VkIHRvIHZpcnRuZXRfdmFsaWRhdGUoKSAoc2lu
Y2UgCmNvbW1pdCBmZTM2Y2JlMDY3KS4gQnV0IGl0J3Mgbm90IHRlY2huaWNhbGx5IHJlbGF0ZWQg
dG8gdGhpcyBwYXRjaC4KCi1TaXdlaQoKPgo+Cj4+PiBSZWplY3RpbmcgcmVzZXQgdG8gMAo+Pj4g
cHJlbWF0dXJlbHkgY2F1c2VzIGNvcnJlY3QgTVRVIGFuZCBsaW5rIHN0YXR1cyB1bmFibGUgdG8g
bG9hZAo+Pj4gZm9yIHRoZSB2ZXJ5IGZpcnN0IGNvbmZpZyBzcGFjZSBhY2Nlc3MsIHJlbmRlcmlu
ZyBpc3N1ZXMgbGlrZQo+Pj4gZ3Vlc3Qgc2hvd2luZyBpbmFjY3VyYXRlIE1UVSB2YWx1ZSwgb3Ig
ZmFpbHVyZSB0byByZWplY3QKPj4+IG91dC1vZi1yYW5nZSBNVFUuCj4+Pgo+Pj4gRml4ZXM6IDFh
ODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4
NSBkZXZpY2VzIikKPj4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3Jh
Y2xlLmNvbT4KPj4+IC0tLQo+Pj4gICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
IHwgMTUgKy0tLS0tLS0tLS0tLS0tCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDE0IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+
IGluZGV4IDdjMWY3ODkuLjU0MGRkNjcgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKPj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+Pj4gQEAgLTE0OTAsMTQgKzE0OTAsNiBAQCBzdGF0aWMgdTY0IG1seDVfdmRwYV9nZXRf
ZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+Pj4gICAgCXJldHVybiBtdmRldi0+
bWx4X2ZlYXR1cmVzOwo+Pj4gICAgfQo+Pj4gLXN0YXRpYyBpbnQgdmVyaWZ5X21pbl9mZWF0dXJl
cyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHU2NCBmZWF0dXJlcykKPj4+IC17Cj4+PiAt
CWlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pKSkKPj4+
IC0JCXJldHVybiAtRU9QTk9UU1VQUDsKPj4+IC0KPj4+IC0JcmV0dXJuIDA7Cj4+PiAtfQo+Pj4g
LQo+Pj4gICAgc3RhdGljIGludCBzZXR1cF92aXJ0cXVldWVzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0
ICpuZGV2KQo+Pj4gICAgewo+Pj4gICAgCWludCBlcnI7Cj4+PiBAQCAtMTU1OCwxOCArMTU1MCwx
MyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1NjQgZmVhdHVyZXMpCj4+PiAgICB7Cj4+PiAgICAJc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4+PiAgICAJc3RydWN0IG1seDVfdmRwYV9uZXQg
Km5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4+PiAtCWludCBlcnI7Cj4+PiAgICAJ
cHJpbnRfZmVhdHVyZXMobXZkZXYsIGZlYXR1cmVzLCB0cnVlKTsKPj4+IC0JZXJyID0gdmVyaWZ5
X21pbl9mZWF0dXJlcyhtdmRldiwgZmVhdHVyZXMpOwo+Pj4gLQlpZiAoZXJyKQo+Pj4gLQkJcmV0
dXJuIGVycjsKPj4+IC0KPj4+ICAgIAluZGV2LT5tdmRldi5hY3R1YWxfZmVhdHVyZXMgPSBmZWF0
dXJlcyAmIG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlczsKPj4+ICAgIAluZGV2LT5jb25maWcubXR1
ID0gY3B1X3RvX21seDV2ZHBhMTYobXZkZXYsIG5kZXYtPm10dSk7Cj4+PiAgICAJbmRldi0+Y29u
ZmlnLnN0YXR1cyB8PSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgVklSVElPX05FVF9TX0xJTktf
VVApOwo+Pj4gLQlyZXR1cm4gZXJyOwo+Pj4gKwlyZXR1cm4gMDsKPj4+ICAgIH0KPj4+ICAgIHN0
YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfY29uZmlnX2NiKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
diwgc3RydWN0IHZkcGFfY2FsbGJhY2sgKmNiKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
