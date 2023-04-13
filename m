Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AC2C77B6E
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 22:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79A346FEAD;
	Thu, 13 Apr 2023 22:36:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79A346FEAD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ViRQMhcF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=WLWbhSiM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IvXoWA0NRPB3; Thu, 13 Apr 2023 22:36:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D11516FEA5;
	Thu, 13 Apr 2023 22:36:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D11516FEA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A89DDC0037;
	Thu, 13 Apr 2023 22:36:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF5AEC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 22:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AFFD640145
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 22:36:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFFD640145
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ViRQMhcF; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=WLWbhSiM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4l__ycPu5H2a
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 22:36:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A91F4013C
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A91F4013C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 22:36:42 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33DKxUET028849; Thu, 13 Apr 2023 22:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rkDkq9tWO2ZxX4gOSDQkLafQ9AS1GVPzhy17y4poz20=;
 b=ViRQMhcFLeLslxK8CcG+HNsT876TbsDXE6hs5Ok7uNAbLBSvexjHJwd61pD8egSh2boz
 1FOLMoxds1fBKMTBNcUm/ghLElvptWKKIqYj2OT5E1DnjW465pD5X6Fnhi+l0q+wUqC5
 HCZUqIAnpfoENjOg9lXfHN2Ug20W0s8X0Oyb4/sfFtZ/7/cNLNEfMKHZLkgP1WVBjXPf
 p+A7bjbHukFtb6ltM4+wLlIHS4x+KAF6A7Dbi4tgyF5kOZzxK4E+JUZadb8SgYU4bU9f
 LMNUCfB8ORIfVSCLscAKYwaUNCT2PI3n17pSArMUjFZCKv1ND301uyZUTnaZYiOllKKq GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0ttvw2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Apr 2023 22:36:42 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 33DL8if9017509; Thu, 13 Apr 2023 22:36:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3puw8b7540-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Apr 2023 22:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl/XwRKPyooNJDdTucWHrum1oiLdbmzCUNacFugr/AaOMsSJV8WUjrZJ1Hv+p6LIZ7+lPCVruXvmE5XNzv5I7s2MRdBM24SCMgMER0p7VwsTdbcGQTe0al4B3VTiDOjjI9jtYABMz5Qo9tzFND4SFB3oWGdxShReADeF30CwwLRfC4idd8uCtDIW64dSU6WuIQ54iNyJp9Ts1L6ep7QRolaUDsjsreFgnoCeMKYz8NoUZjB/3iMoOK4fyiYHdAdqGqnDNYthlzcmVq1o5/uhyeS3cLNz8RUXkCXLuxr1fbPW1FFlTjZNGhzvsPDzCgO5HeIPV2HCAOyay6q6nzrb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkDkq9tWO2ZxX4gOSDQkLafQ9AS1GVPzhy17y4poz20=;
 b=UBy0TUAH/wNAEe+bUGLOAt5oaKU1ZoQUjFmIkqtT2eQGferML78Ra8wvFQ4BVAe/dM7REIMnmlWcoHUrIm4tzg/9Ts/B/EmcMk6cPfwmr0QRGD4vd5ol9SSNAac0JNkOz8hYVsPIUjCAW5C8qH0lXx6R7UiqLw5u4QvUQH4SS6aYTPGeEYh5iNAblIo5CLcH4x/Yw8Fiw0F0OsWbgMzo9y6UbG71UQUUDoLjTV8puXC7Y2GshyWnI130dR/jCZ3uXWTpFgI7RmWsedQWND+QbXpgTY1Tk/KuqcxH0fQnB4NcrSQ3/rZXQc2Fd2D9U6A3feWqfbWfTyzQ9/pRYaj2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkDkq9tWO2ZxX4gOSDQkLafQ9AS1GVPzhy17y4poz20=;
 b=WLWbhSiMjugtjM1OgfY6+NSkuQngmiewjCrHOUYuk0inlwGA2LqKVlY0NstL+9ivDhcAZRwrfH+dVpynDaSGbD9CVOeseG2Bbe9a0wPHoEbqAMnZ9ArHzDEscE7xC8LQyC4s2eIYVhW0rDfuHq9IQTo2PyiMSlHQ1WBvr+ZWhds=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB4910.namprd10.prod.outlook.com (2603:10b6:5:3a4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Thu, 13 Apr 2023 22:36:34 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3%10]) with mapi id 15.20.6298.030; Thu, 13 Apr
 2023 22:36:34 +0000
Message-ID: <26bae999-4375-ab02-a97b-056282a84ecd@oracle.com>
Date: Thu, 13 Apr 2023 17:36:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 11/11] vhost: allow userspace to create workers
To: Jason Wang <jasowang@redhat.com>
References: <20230328021717.42268-1-michael.christie@oracle.com>
 <20230328021717.42268-12-michael.christie@oracle.com>
 <CACGkMEuvAGKHVtg_tdiGJRN4+5utdDVbvnkycN97eb2fE2Ddsg@mail.gmail.com>
 <faeaa023-c1ee-cd81-3397-edecc0579e8a@oracle.com>
 <CACGkMEvrvpu-xdJTzm5mVq-9JGuXRnsXZHEU7tgwfsz6qqFc4g@mail.gmail.com>
 <0ce314ff-0a1d-223d-0ccf-d2cb876b4306@oracle.com>
 <CACGkMEs5GdXuoMaOiZjWytG=JHqhzdZmCu=dK7GRRvYcx8t2+A@mail.gmail.com>
 <c7da1c60-1b89-5fab-942a-1e74214f03d5@oracle.com>
 <CACGkMEsYK5yWuFECrUM-_fLA1V4H=WayxfovT2ezMeQCmwcDoQ@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CACGkMEsYK5yWuFECrUM-_fLA1V4H=WayxfovT2ezMeQCmwcDoQ@mail.gmail.com>
X-ClientProxiedBy: DM6PR02CA0067.namprd02.prod.outlook.com
 (2603:10b6:5:177::44) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DS7PR10MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5c4b81-9090-461d-b0ca-08db3c6f8907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RGyGcJeiLGifMIsmxU7heLv5DFQs0J/nRS46LY75gdY1Z1fFjAipp2K09VHgksLEA9SagXjGWOIPthvMNL1/+XJHwyqJOFNFTfNX2PU5yLfKx7AFyk4HoauYx94pHxT6CqDASBUsPRPYNAV4vV9rPhw0goePYQ8gYMVHXBOQlyGA01IS14Zt1YDPO9nS0ESdZ2Vi+Klu0dJFyMvlbnTzY9w5BjxFxqGVfbDo/LPnpuR1JPFWoZ1uc/seKAAwxPg/ECehDJs4EZSFwix8ezQEfZ+pkZ7i7jNVV2KjR6AInD6cmMTj1v0KcthE5TUDZe9cLS2DQIHNoNPEMOMfTBDnggGAMNKkQg9uj2kGWGrMy9Y8jtfdaEJBXWxzH9EUCZqu8O3SUCSkUnDge4+pcl8Y/j4WmKlj85jNi3jw/Pu1qPuyO2wGs2ckJWgE6j9p9e9HAcrdXkMmGGPlV04PGR8Qk0xiYvVb3hq9WbCoinYk/m8IOl5J09/aX3NgURMkWHT+HZwOCZAdPdkKgBrXlISVinHFKqc9oyvtS3k7eHLTCYLWTBAstp9BrKpGFUyzE4kLXhzJ2f36PyoxxvVEw1P5vypAzGrZ6DbhwCveznbFY0l1STnh/BG/4X9f3i3oqm2L1XCNX2Bk4FusOS/RU72U2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(26005)(31686004)(66476007)(66556008)(6506007)(36756003)(6512007)(53546011)(31696002)(2906002)(4744005)(6486002)(2616005)(186003)(66946007)(6916009)(4326008)(86362001)(5660300002)(8676002)(8936002)(38100700002)(478600001)(316002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnplMjM4RGZMa2wrOGtuNnc2c0hZTkIyOFNNNzFjNnN3SDUwNHlYcUpvTzY4?=
 =?utf-8?B?elFOU1V3c0xhTEk4NGcrQjJjOTlTTWRpcFgrZ1B0V2VwcUVhNjQ1U0JSc2dR?=
 =?utf-8?B?TDFZRkhidk0yZlgzZi9SaWxkRDhrZ3hZTmJMV20vWXUwdXc1b3ovSERMUEFP?=
 =?utf-8?B?THVaZXlkRFRqeDdQOEhzQ3Vpb0QwaVh5RGxIbnpXT21PM3RRZzU2dk8xa1E4?=
 =?utf-8?B?Qm9FWDRVWEs3UHF2TU52MTF6Z2h3cVlQTi9NQVhtNEJaR2luL2VnSyttZGlF?=
 =?utf-8?B?dkxBc2lodUhTRmU0Tk1weVBpb0xEYWFlZzJkWHdmNExmSlphNUVvYlg4dTNS?=
 =?utf-8?B?bUMxZ1FQY3RxeEJFeEx5OHJNYjlrNklNQzJUeis1VTdNMWRiNDdHQUo3cVMz?=
 =?utf-8?B?K1pyYWMxRFZPS0pabldNeDBVRnZFU1FwNXJ1aytUTmEweEhnY3M1WFBoVE5J?=
 =?utf-8?B?b3RROFlITlJ6Y0JycDNOMC9xQzhWeURkaDZaalJwcG93WjNOSE5ZY1FIWWJ1?=
 =?utf-8?B?Wk5jYjliVXQxcG9JeXVhVkxtNTFsbTN1VXdod3VoUS81T2FkcVhmR2ZSeUE0?=
 =?utf-8?B?b3oxcTIwdzVkcWFuQ0VJMkw2WktONEYxQlVWT3FhYnIwQ0RvSUthdXk0OTBV?=
 =?utf-8?B?MW5mQk5VT3JGdTVabXNpbVRRV0x1M0dUaURJUkI0S2lXd3d3Sm1kN2dZK3o4?=
 =?utf-8?B?emV3N3p6Y2dFOHMydVovdU03UlEzaGM4cDlNcCtYaWpXeUZyWXYyWStoaGU2?=
 =?utf-8?B?dDFVVllCdW5aakNtbnIxL2RDaXVXL0VJZTNJa2prTjNGYnhmVmh4ZTlmMnJB?=
 =?utf-8?B?V1RoL1h4a1pTc2N4aEJrcG1adEEwak1EdFJFQi96ZTExaFdYUG03Ukx5eGJ4?=
 =?utf-8?B?SWprak5aNFdxN08zcUtsdEFMbExZTk83bG5IZGMxVFFOTkMwOFZrVlI4K1JT?=
 =?utf-8?B?ZFNCaEFQdWttNGw4blF5SHAyR0xud2R6NzZpVnFFQ2lmbElsSkl4dXNmMys5?=
 =?utf-8?B?V2RNNG1NZVFOOHRaYktTTlhmcWxJdDNlRWZkTnJHQVVTc1hLVU9ta29BVGRG?=
 =?utf-8?B?ck5Wb0FEMkZCdEY4V00xYksvOWRxbVE3dVdZdmRFQ3pYdVFQWGFvcTYyUVgz?=
 =?utf-8?B?Q3VlOFU0eTdRalROZ2FvZ0Z5emxqMU5neFJaMCtqVUlpVVVUbFRwSzlEdDQ1?=
 =?utf-8?B?TWd3OUttMHU5Y0JSMjAxRURlZCtiS2JmUy9ONVNxMVJxTFJQeStyeE1KZmtX?=
 =?utf-8?B?aHpxbmw5Umc0dzgyNjg2N1NqQ2JQenVSN0svZTFZOGJYT2tLbGZwK3NTYktW?=
 =?utf-8?B?V0wxMElTSHpKRUozS2ZsSE5INUgrc0gwM1gwbkFZMzdkNXJOeWMvQ2cwc25z?=
 =?utf-8?B?c2V3MCtKYWtoM0hMYmFyak93T3A5SlBETXdHK1BNdW1RV0xmU1hrYVd6blQy?=
 =?utf-8?B?c1NQdFdNbFdvdUNHb2xsM3Ayb3lUUkdrRVBiVHdpRkdZaGdrMTFkaHBxN1E4?=
 =?utf-8?B?c3FOd3E5TmFzYkNXOEtWUUUwS2NUVlZGdU1CQzNINWw5cll2L1dsZlo1RUlC?=
 =?utf-8?B?NERtbzhZSVlSQ0s1am9PM1JhcUhwM3B1b3liZmhOTHQvbWc5STFpcGd3dk03?=
 =?utf-8?B?SG4yK3Jnb0Z4RUthbEpwN2RKc1VCY29QdGV0MlhOQXB6WEpuWFVweUtoSkF4?=
 =?utf-8?B?STlsOWtsVUZXNmE3Z0I2TDBLTC9sNTczSmRYdE4yRXV5T0Uvd0hrWEF2Z0x6?=
 =?utf-8?B?OTBjcUFXbW5Qa3BBMFJSdnpGY3lQb2JhZGpEN3g0Z2hZM2c2ZDlPM29JbVJB?=
 =?utf-8?B?RGRha0ZURVZWVUtXRHR0UTUyTENlOEtVeWFiRmxUS2x0N05LTlU5U0FzOFVX?=
 =?utf-8?B?Y2MzMnRPNnFkd29EenBkRFVMQVpFcEtwMDc4aUNVaXlWKzlLNWlJRkgzSXRx?=
 =?utf-8?B?VnREM21DZmRUSGU3VGwydmppSC91ajBiTEEvODQyMUlhbU9oblJyZ29PaXVa?=
 =?utf-8?B?VGx1TktTRlI2Ny9tMWVPNURhdFIrc0N3eVVEYk0rZW1UdzdxdVcwcWIvVk5H?=
 =?utf-8?B?bjNNakRVQUFmM1B5THB2OGNhUjJId2ZLeHhhOEpvQ2JkcnU5NHkyaEhxV3Vt?=
 =?utf-8?B?SDMyeEdlRFYvcXNCYWpkUHMvbnN4WjlqVWsrVVFmUEJsS0pIeVIzSFI4cXJa?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MVaIU/YrJLd9zdv2aUY3PqepInbfkhsNDIRRBwwTMpBR0A2FdlnZy1jO4PJmdfYrNV7r3P6UtFd9MSrLQh/pFqLPwVoJsTetQp322M1XEZpeTTYFOnypO2NXY+pKRb4TS/Z3aAeGpAouu9dIG/+OgpDSOntU5I99wEYSUgX1LQWBhvWM0Z5rkAIO/LZclQGjAwby/vVnEA2CfyyDEZsFIMmBC1u4jjlTzjso2NZ2z28BSsZJKjMjIpbhjdYLLzZwCuQokeXVfdPep3NLh2aOQ4sUNFkrEOf2tMCKP34Tyh7dLk09DwdPmh25xAo5hN7tDBlqIAxGZGFHOD1p/4XHwfKtbDFMsRVWMZxT+hAWybQ/3eyGcCr4VMMDfrwRRrzispqQtNtxUuTeP2Wo82KT2nXzGlRM7RmmFiBeDdkfcXybmQH3xkNcciXgtJt6miFBvot5qGA/SZZWC1eLbcVfBZpnvkT1gS7p3EErvioabb5qCOL1fPsPQ96OAX9iNx94SUHxbe00V8VYUerJ/ChHZtDJTfs8/9dinCT65aLxAzeA2INa28/Zm/ogvEolUZjaJ2N6oVLY3MV6w+QrRYn5pTpaWNMMuc6x/3E9SfqkpOxeM+alCOboYmVvqQSLABFSfUarCDNVc00vTDJiwIkK5Gu5kZUFqL66hZIJ5PnGts9Jr1s0FcSTiRJzRSzLD7PQd4FeRo1xouNdtQBjwSm8xcpxfeHts/Fou0BJ9LVhDct3+/LpyiV/I0p9cyqIAc470EivP+VOj5ZJ3HPlINebwvjIUFAckKP0k064q8zix4oXtc2tvzx3mgZDGxoTds3S
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5c4b81-9090-461d-b0ca-08db3c6f8907
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 22:36:34.3346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlgddeelC2L98dMryWQ2D7H/0N/smS1epkE/cnZuudKoIPrJ2oAu3cZwLJrvcC/bHoNMRLf8UyAyLgxW6R0qFK7MNVvof5p8cHaWlWTvM+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_16,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=869
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130201
X-Proofpoint-ORIG-GUID: qYWtLrr8iOKxggCKMAZsADfaABi_Ck1b
X-Proofpoint-GUID: qYWtLrr8iOKxggCKMAZsADfaABi_Ck1b
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 mst@redhat.com
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

On 4/12/23 2:56 AM, Jason Wang wrote:
>> I can spin another patchset with the single ioctl design so we can compare.
> So I'm fine with this approach. One last question, I see this:
> 
> /* By default, a device gets one vhost_worker that its virtqueues share. This */
> 
> I'm wondering if it is better to have a vhost_get_worker() to return
> the worker_id of a specific queue. In the future, this might be useful
> for devices that have multiple workers by default?

Yeah, it would be useful. Just 2 questions. You mean an ioctl command to get
this info right? I had added one in one version a while back, but dropped it
because for some reason I thought we were going to do a generic vhost sysfs
type of interface. We are not doing sysfs right?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
