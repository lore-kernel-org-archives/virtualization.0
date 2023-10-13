Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DC9CDB47E
	for <virtualization@archiver.kernel.org>; Fri, 13 Oct 2023 07:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 37622404B5;
	Fri, 13 Oct 2023 07:36:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37622404B5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=H5Zoc5Bu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=g8reebux
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yibS9jzVzIcY; Fri, 13 Oct 2023 07:36:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1FB75400CF;
	Fri, 13 Oct 2023 07:36:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1FB75400CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED126C0071;
	Fri, 13 Oct 2023 07:36:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9938C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 07:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1D0160FBD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 07:36:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1D0160FBD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=H5Zoc5Bu; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=g8reebux
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g9908NeXhZao
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 07:36:11 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DCA660BCF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Oct 2023 07:36:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DCA660BCF
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39D7P4mB009503; Fri, 13 Oct 2023 07:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5uDO4fGaZ7Gow4UzSq6JSnpnGsb9ZjhkLxKeTppcVCM=;
 b=H5Zoc5BuHZM/7ysKtcsrZK4oFvFhoVmYuUutNrZjDzjkPAiQiGqTbRs9ABYZVjX3vX9T
 4We/ZxnQfkTD6EJ+09NDpjtrD9HN48GnwMGMH3DS7c6rX6x+ELdrSy/7unZwzHuWljP0
 A1WJiPZy0huXTATj/wTvSr/6rI72YQUa7W7BGfAIYzRE/NsDK8iMKDD4/IUZ6wlJs87Z
 4cIoSZP06UzaOMlHMFTgQABN4jWoG1NXswy5PcaHn0dWPJSZQF0qF/pG/Fy/UUzIfm+C
 ewpeJPgkymmqzTv+jjfT+jqDMQvWots43f8U3aAZOZ3TiqxJvZK3FsipqCHk/c0vkCFe cg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx2cfhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 07:36:08 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39D60QcA021846; Fri, 13 Oct 2023 07:36:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tptary649-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 07:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA1FXd3IAzhxX673FVztHzeQSc2L1Tl60RSdjBiwHBfiqWLD9eh6eDfaBE5xNm4om86Unagf52gt3z7j/3FEkxU3D+FUY957vGXML5tW51RXYoJ/0Yr5c/LjAMOZXAKQyiP3IGi4iWUdJwbqHyQzOOPfOwbmkin78atvwrUB6v3ymHXrnmJF89XYsdHFqoiqvtxNG35TsFbgdBJ8juhWMY3KRIJ+XPP/x4IRN1ID5RWR/y1Y1aCgEs9Oc9TARvwYfgAkdOhND9rOtDV77XHOXLmyuVZ3l631uZVk4BIbnoLjD235QVxTd3FKAEb0uF+SS5bGysuTopnq7TllBYZgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uDO4fGaZ7Gow4UzSq6JSnpnGsb9ZjhkLxKeTppcVCM=;
 b=DJCKR7pXaitstfRcbTL6g5qK2kzwTBabvAiMoCKektMUlEEWFd4XZIngfPNcRK7iOYzwR44iHqsM4j5fgRFcg8TegeUgQEoghkVrHcSjkQzG/E4lkge9yrybmoG62AW0juiVvkqRyfFQDgxJEHVdP/bukqtJx7hxxf+yPizkG3pAD3mEYQ25zmD6wlTfKZinQ19WZE0zgImIDnzk0mNHZYuuR4khEQXYAA7LAnGvS4jVSKbjj0zwaIY6AgSWEmhM3y1YL9fiYOEURgi5xb0o6ozczBZJTJT1a9sSbv6kcGztcWiYtNZoMtb4Wd7yoT6EaHU4aMFnK7vQ1U5unyeVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uDO4fGaZ7Gow4UzSq6JSnpnGsb9ZjhkLxKeTppcVCM=;
 b=g8reebuxo866j0bIeYg11CPBCl3FTfnDfS3fm2C6x5BLru6ic67pU2VoR4s0PMxiLtLuE0/Ko5t12WcsjOeukh5CQx6mS2yEua4WEebCJR150GU/fLQiq3XSMm/lN60I4mCZjQSF8O7YiPd0A/TAkhOAD/QasitxAJzLrPX2Zbo=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 07:36:04 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:36:04 +0000
Message-ID: <3dbc36b7-28c2-4b62-97dc-a8280f10dc36@oracle.com>
Date: Fri, 13 Oct 2023 00:36:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] vdpa: introduce .reset_map operation callback
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-2-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEt2vohDVG=BOpvn=7QgPiADgB93KoZ6xWwrO4T=Wgj6Pw@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEt2vohDVG=BOpvn=7QgPiADgB93KoZ6xWwrO4T=Wgj6Pw@mail.gmail.com>
X-ClientProxiedBy: SA1PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::13) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: b2617f11-29cc-47a1-0f75-08dbcbbf0e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6xc8MuOP08eJapsg4RyOoGj/CGXB4OLC04B1wU8zr1KEkJEgJnuizmrpSOp0SjULQqFnLyGKY5cPaaqQy4KjUH4qRSwd6it3UyqGmGOHWNO9Dtv2w92n9cfkV9jC9FRHY3RrbRNj8QgvvcdW/tZ1MqneYKd8hIMnQbelJk9iI4B4H15k69n5yairHbEdiop+DHbtnBPJr4kDALAuNnPpOabJ7I8ADe9savau1WMd5ExFMSaTVsJykhiMC1kjQZ4Kss580ODHLJhjDUMf1enyHrsGUP+Dzzvmf49Rl8C7IDxZdpwkCVqh+8oPnV1aL8+LV5JTbUiOP8WKcgK2Q3tD1sdkZw1K7e0KOOf6uyrxuxjzsPKkBUSSCWOOKXF7BkhtKtMPr2Lo29TbhOwbHPnBYT0U+xphMaSomQTYRekM4WY/hMFnSCErArqc7qDCQZeKlAT/BTm6JpsDlRtOh1dLwYyCmagvW2JEL8djyhj5/dFzz1uLk7TU08Rc5pzMtdduyjpsbfLMaDufzrijcjg9QO6NZJLT8fEQQTgEOfUXvdQTr3pnGgn3fxsgvNwit0M17HZTUC3frr1Xi6zCXQ9vhnD0GcvBjMl9i3ifZTwbpC0cHhGFtCMv2whRoZeWaUpGZshKi/xK0m39BOOiWgq5iwL0CHXCO9BveGZ3LtPltnFuV2mS77jUn7sDCzYXSX3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(316002)(6916009)(66556008)(66946007)(6486002)(5660300002)(4326008)(41300700001)(8936002)(66476007)(8676002)(31686004)(2906002)(83380400001)(2616005)(31696002)(36916002)(6512007)(86362001)(26005)(53546011)(38100700002)(6506007)(478600001)(36756003)(142923001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ArdkdTZXpGS3d0c0pYQWZGSW5IWFc0TXI2ZmZHRGRDMHRmYTllbjg5SGFr?=
 =?utf-8?B?Y0ZiaWhrcXRSRXZhdC9uVGFDMVJwa1FyNVlQeElNZlkreEl0aVpPaVBtWU9Q?=
 =?utf-8?B?eTkzZW1UWHRmdE1Rc0tkb2Z5QkplVld6Wk01RnlMdVR1aWxUZGNEaVNzMjNE?=
 =?utf-8?B?ZEZLaW14ZGtzQi9UeDUyTHNyUVkrc1pRVThaelNHOVRZMWlnZlZUVUZ6cVFB?=
 =?utf-8?B?TFR5RzVmUmxnc1EwcUZwK0VwSUwxTXdkRXZNd0Jncndna0dvWDJhOFNkMWt4?=
 =?utf-8?B?TG8rbWdqdS9XaGtWb3RwZml6dldnNWZhUXBZZVFHZWhWNG1RWENhZEFvd0lz?=
 =?utf-8?B?eXV3bWttRzQ2Mkg1bG9DQnJsL3VWVWlxMllmaFdhOFVMRExUV1VPMHloL2hx?=
 =?utf-8?B?VUJjeFhPUmMzVWgzTnRzOElYcllxbHE4eUU4MDdhOGdMVFVwV0tLbUMwYVhD?=
 =?utf-8?B?a3FBL0Z3QnVIWlZGYUF6VnMra3RkcmF0dFFxR0VyTkJWNnlPYmJWTkE0SEhL?=
 =?utf-8?B?ejJsbXJpYzZkbEJ4V0FaODJ2czVuM2luVU90NkI0em92NmxPTUpFZk5Zejkz?=
 =?utf-8?B?TkkxUmRVdytlbmlRZ2psVDB2S3RObENyNVhIV1RsbHpBTkorRCsvbHJLNWRs?=
 =?utf-8?B?aEQyRHRCQ1RvZU9XYTkxRTFuNm14MVdGdmMycmlHSERwMGtCZE4yQkRKOUcv?=
 =?utf-8?B?Q0JjUHlkNXFIdC9YTW4yaEdGZTNoTEI5SE1RZlJaeTBOQTBOZGF2NWZOemtz?=
 =?utf-8?B?MjYyZ2UwcmZNUVBoQTVtNDNyTVVHYkpKT1AzWmNzdExkem95c1hHZzZ0Z3ll?=
 =?utf-8?B?blMzOC9xMHlNdVVtSDZKdzBKRzJCN21yY0RFYUMwbjNld0FneDZTb3Q2dmVD?=
 =?utf-8?B?b2hVa0F1SUIvb29XN2xTcWh1bURLSmhMUXJrbkdmWGNBNkJTVUxqWm8vbzBW?=
 =?utf-8?B?SFVMdlBhaklKdDlCNGwxaDhmZkJaTEwzbVNBbDJLRW10NTErd2tXUlB6OGpn?=
 =?utf-8?B?RENteGZIa3FhV1lRS0xiYWdUdDh1TWQ1NC9pS01nUzNPdGZ3Y2RpSGp6cU1X?=
 =?utf-8?B?cC8vS2hNS0xUNmFpdzNXRUlSc0dTWWV1MkYxZ2ZhYnNaekpMQ2l2R3lXb2FX?=
 =?utf-8?B?aXd4OVpHdDAxNnhUZ1BZNnkxQjFDZldoRkVBWmt5eTNpaUNwWHBXb0FNYmww?=
 =?utf-8?B?QW1INHRzeGdrZHFmRVB5djlHSWIvcU5aYjNYMVJiaHVTVUJIcy9NS1J3U0Fw?=
 =?utf-8?B?WkwvbFhHVGYxVXhJNGVtZFZsN0JKRnp4UEJxTko5Ny9GWXJ1NDgySmJNY2tS?=
 =?utf-8?B?czVGN080SHhLMGJiRnZKNk9zTHRSNC8wMnpDUmZCaGtUVlBmMWp0ODNaMlIv?=
 =?utf-8?B?aGc2aWhXa2kyTkprUnA1dE9CV1RPU3A1RTJMWkNCQnJRNndsUkhoeHdPK1lw?=
 =?utf-8?B?dXJJN0Y3Q3Naa2lFSGRKV3JnZ0RMaHhKV1N0MSttQ1NId09IMG9iQ28zcERl?=
 =?utf-8?B?QTh3K1dPa3hzVHlCdXM5bTl0RFFITDRrL3UrM2FOclM2QVpIUVFrcHV6TSs3?=
 =?utf-8?B?SmhVUzhWVzBzRWZxeFlhVEZycGFNTlNnbEk4R1VrSVk4cWxUQ3VGa3BVZS9h?=
 =?utf-8?B?b1ZWbDhQcFNxV09PQUlYRVI2UEp0N1NCVzlRNWVhVzFGK1d3WGNiOTU4M2Mr?=
 =?utf-8?B?Y2JCUWFGQi9oQjJsMW9YV0pVMDU2MlMxUGw3YTIyQVJsaDIvUUJXdVJRU3JW?=
 =?utf-8?B?b2dqcXNnbnJTc3NSTFdsbEg4OXY1d0Y5SDhDWkVydC8zY085RjBYVjVnYlN5?=
 =?utf-8?B?WkJ4MHp3NjRML3MydG9aMG9lclRXOVhrQ3JkRzR6cG1VN3NpSUdjdnNULzFH?=
 =?utf-8?B?VU1RMGFKWms0ZHpaRHV3dnFURVVTakFpbFY2TUJuTlNtbWIrRVNxVTJScVFS?=
 =?utf-8?B?dWp6SWhXRlU2emErQWtxQjhPUk9ENVhvR0thMlcrbzV0eXQ1M0RSb2pXa1c3?=
 =?utf-8?B?blQ0ZUxhenFueXFYVFRnSkl1V0hSNjBuRWxyQi9zZjNFMkVLZXJ3bUtvckVL?=
 =?utf-8?B?VHQyU1B3SlVSc0M4UlZrT0xMd2pQMWV2R1RxM3F0MFZoRGhaUzRLdGk1WUZ5?=
 =?utf-8?Q?SjlN3JewscCdydxWxRctIH1p6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TDhTdS9IMEpvV3ZyN3cyWTRlWTl2bWNHaDZhN2k0UlRmTzNOcGJCQTZVVmFG?=
 =?utf-8?B?R0cyMnhHUmkvNUloQzNKSG9mb0tQN3d3eVNpb1NzeEM4TERnYzhiV0lxVmw5?=
 =?utf-8?B?TldnQjFIcWx2WTJDdG9ZZCtIMGppQjFpaENFMTdtMEFZdHBmcFRYN29FZGhL?=
 =?utf-8?B?M2hnYzh1dzA2RW9POVV0ZHdWdnBZcWxhd3loZ1JTNXdmdHd3SE9ESnNkSDhK?=
 =?utf-8?B?R2dqVFJmM3dTV3lMNUExWWFjN0c4U3BmbDJQc090Zm14YUI2SnptQ3dMQVhp?=
 =?utf-8?B?ZXdDVEx4cnJDV2I3MzF5d2gvSSt6Yy9weVJlRUVsZ1E4S3A4VkZ6SGZaaFVC?=
 =?utf-8?B?MmVBOFZueDRzcklCd2JyWmhMQUFLYVVGK3FDVmlia3NLZXBxUERHZkJHc3E0?=
 =?utf-8?B?N25nMDdzZG1sdTdHTFJlTks1Slg1ZWdKa0JnQ0E4M01CT21DanhIN1oxV21w?=
 =?utf-8?B?QitSQ3NnSEpsTlpQK0RQZW9LbGx0bkduT1BFbGJvV0Z3cjJlMmtnNnlvUDFM?=
 =?utf-8?B?a1dQMm41aEFobmxYK0FFZjlzMGtUV1JsKzR2eThoV2dzdDF2TTh2N2JPMmxT?=
 =?utf-8?B?RlZUb2FuYTEyS0pNNzRXYjdCWHcveUpzeGpFQVlTMGZOSDAvTU1HcEVRSFZ2?=
 =?utf-8?B?UHVzZU5zeVpMTDhHMVo0SHI2SU0zVWlHSEh5bklHaHp0TXdGOFNLZkdQNVhu?=
 =?utf-8?B?cmRZOUVuanBGYzNpdEdmL0pXNksyelZ5RG1xazlvMjc2c1JIWnJWQjFzR1dl?=
 =?utf-8?B?WmVpRFI0YWNKTlJ0T1RoMUhmWkN1UWRhUzZuV1d6ZWkvRTA4ckRFWml5RXE1?=
 =?utf-8?B?blVlWVpBbnc2WlcyVjBodGo5ajV4SmlPWFR1SGp0NEZOVFVCVFZhQnBLNURm?=
 =?utf-8?B?Yzk3U0t3SWxLcFF6YjdFb0d0b2t3SlcvdXJDN0t2UzZtNWRManExL2wwZUZG?=
 =?utf-8?B?ZlVqOXlvVGUvdWZtM2dSbTRtY3JhSU8ydklMS05lWFBWQlJoSU00V3NiOExY?=
 =?utf-8?B?TkFRQytoT2ZhaitMcjZHTzVDb2ZJZEV0MG9SQkF4L0RUVWM2YWZ3UXZxdUxU?=
 =?utf-8?B?OFZMTGpuRThwc0tVdTloM0N2NmtXTDh3OEFaYjg4cCsvczhOMlRoalJLcndH?=
 =?utf-8?B?VGxrdm8yYVJEdmd6OTJoMWtFUUhuczd5NURsWU9JcnZVSjFHc3I3a2orN2VX?=
 =?utf-8?B?VThMZlFPM0dMZjhkOGRidEVIMmZCWVhSNjhpUnBlQzB5R05xdC8vSzllbENQ?=
 =?utf-8?Q?ya7sQ03UkraEoD3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2617f11-29cc-47a1-0f75-08dbcbbf0e84
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:36:04.6932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o86tbLhbt/2NAy+A3NtIYiSiYm8ingDkz5BEfpkEkaCh2A5roUveq/xXnMx8I9s1uA4V8dIbvLlQtEx41jhX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130062
X-Proofpoint-GUID: FxgMvvBZnoNbtJIn1WrpCWSbv6IqDVU2
X-Proofpoint-ORIG-GUID: FxgMvvBZnoNbtJIn1WrpCWSbv6IqDVU2
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

CgpPbiAxMC8xMi8yMDIzIDc6NDkgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gVHVlLCBPY3Qg
MTAsIDIwMjMgYXQgNTowNeKAr1BNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4g
d3JvdGU6Cj4+IERldmljZSBzcGVjaWZpYyBJT01NVSBwYXJlbnQgZHJpdmVyIHdobyB3aXNoZXMg
dG8gc2VlIG1hcHBpbmcgdG8gYmUKPj4gZGVjb3VwbGVkIGZyb20gdmlydGlvIG9yIHZkcGEgZGV2
aWNlIGxpZmUgY3ljbGUgKGRldmljZSByZXNldCkgY2FuIHVzZQo+PiBpdCB0byByZXN0b3JlIG1l
bW9yeSBtYXBwaW5nIGluIHRoZSBkZXZpY2UgSU9NTVUgdG8gdGhlIGluaXRpYWwgb3IKPj4gZGVm
YXVsdCBzdGF0ZS4gVGhlIHJlc2V0IG9mIG1hcHBpbmcgaXMgZG9uZSBwZXIgYWRkcmVzcyBzcGFj
ZSBiYXNpcy4KPj4KPj4gVGhlIHJlYXNvbiB3aHkgYSBzZXBhcmF0ZSAucmVzZXRfbWFwIG9wIGlz
IGludHJvZHVjZWQgaXMgYmVjYXVzZSB0aGlzCj4+IGFsbG93cyBhIHNpbXBsZSBvbi1jaGlwIElP
TU1VIG1vZGVsIHdpdGhvdXQgZXhwb3NpbmcgdG9vIG11Y2ggZGV2aWNlCj4+IGltcGxlbWVudGF0
aW9uIGRldGFpbHMgdG8gdGhlIHVwcGVyIHZkcGEgbGF5ZXIuIFRoZSAuZG1hX21hcC91bm1hcCBv
cgo+PiAuc2V0X21hcCBkcml2ZXIgQVBJIGlzIG1lYW50IHRvIGJlIHVzZWQgdG8gbWFuaXB1bGF0
ZSB0aGUgSU9UTEIgbWFwcGluZ3MsCj4+IGFuZCBoYXMgYmVlbiBhYnN0cmFjdGVkIGluIGEgd2F5
IHNpbWlsYXIgdG8gaG93IGEgcmVhbCBJT01NVSBkZXZpY2UgbWFwcwo+PiBvciB1bm1hcHMgcGFn
ZXMgZm9yIGNlcnRhaW4gbWVtb3J5IHJhbmdlcy4gSG93ZXZlciwgYXBhcnQgZnJvbSB0aGlzIHRo
ZXJlCj4+IGFsc28gZXhpc3RzIG90aGVyIG1hcHBpbmcgbmVlZHMsIGluIHdoaWNoIGNhc2UgMTox
IHBhc3N0aHJvdWdoIG1hcHBpbmcKPj4gaGFzIHRvIGJlIHVzZWQgYnkgb3RoZXIgdXNlcnMgKHJl
YWQgdmlydGlvLXZkcGEpLiBUbyBlYXNlIHBhcmVudC92ZW5kb3IKPj4gZHJpdmVyIGltcGxlbWVu
dGF0aW9uIGFuZCB0byBhdm9pZCBhYnVzaW5nIERNQSBvcHMgaW4gYW4gdW5leHBhY3RlZCB3YXks
Cj4+IHRoZXNlIG9uLWNoaXAgSU9NTVUgZGV2aWNlcyBjYW4gc3RhcnQgd2l0aCAxOjEgcGFzc3Ro
cm91Z2ggbWFwcGluZyBtb2RlCj4+IGluaXRpYWxseSBhdCB0aGUgaGUgdGltZSBvZiBjcmVhdGlv
bi4gVGhlbiB0aGUgLnJlc2V0X21hcCBvcCBjYW4gYmUgdXNlZAo+PiB0byBzd2l0Y2ggaW90bGIg
YmFjayB0byB0aGlzIGluaXRpYWwgc3RhdGUgd2l0aG91dCBoYXZpbmcgdG8gZXhwb3NlIGEKPj4g
Y29tcGxleCB0d28tZGltZW5zaW9uYWwgSU9NTVUgZGV2aWNlIG1vZGVsLgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4+IC0tLQo+PiAgIGlu
Y2x1ZGUvbGludXgvdmRwYS5oIHwgMTAgKysrKysrKysrKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBi
L2luY2x1ZGUvbGludXgvdmRwYS5oCj4+IGluZGV4IGQzNzYzMDkuLjI2YWU2YWUgMTAwNjQ0Cj4+
IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5o
Cj4+IEBAIC0zMjcsNiArMzI3LDE1IEBAIHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKPj4gICAgKiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQGlvdmE6IGlvdmEgdG8gYmUgdW5tYXBwZWQKPj4g
ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHNpemU6IHNpemUgb2YgdGhlIGFyZWEK
Pj4gICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNj
ZXNzICgwKSBvciBlcnJvciAoPCAwKQo+PiArICogQHJlc2V0X21hcDogICAgICAgICAgICAgICAg
IFJlc2V0IGRldmljZSBtZW1vcnkgbWFwcGluZyB0byB0aGUgZGVmYXVsdAo+PiArICogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0YXRlIChvcHRpb25hbCkKPiBJIHRoaW5rIHdlIG5lZWQg
dG8gbWVudGlvbiB0aGF0IHRoaXMgaXMgYSBtdXN0IGZvciBwYXJlbnRzIHRoYXQgdXNlIHNldF9t
YXAoKT8KSXQncyBub3QgYSBtdXN0IElNTywgc29tZSAuc2V0X21hcCgpIHVzZXIgZm9yIGUuZy4g
VkRVU0Ugb3IgdmRwYS1zaW0tYmxrIApjYW4gZGVsaWJlcmF0ZWx5IGNob29zZSB0byBpbXBsZW1l
bnQgLnJlc2V0X21hcCgpIGRlcGVuZGluZyBvbiBpdHMgb3duIApuZWVkLiBUaG9zZSB1c2VyX3Zh
IHNvZnR3YXJlIGRldmljZXMgbW9zdGx5IGRvbid0IGNhcmUgYWJvdXQgbWFwcGluZyAKY29zdCBk
dXJpbmcgcmVzZXQsIGFzIHRoZXkgZG9uJ3QgaGF2ZSB0byBwaW4ga2VybmVsIG1lbW9yeSBpbiBn
ZW5lcmFsLiAKSXQncyBqdXN0IHdoZXRoZXIgb3Igbm90IHRoZXkgY2FyZSBhYm91dCBtYXBwaW5n
IGJlaW5nIGRlY291cGxlZCBmcm9tIApkZXZpY2UgcmVzZXQgYXQgYWxsLgoKQW5kIHRoZSBleGFj
dCBpbXBsZW1lbnRhdGlvbiByZXF1aXJlbWVudCBvZiB0aGlzIGludGVyZmFjZSBoYXMgYmVlbiAK
ZG9jdW1lbnRlZCByaWdodCBiZWxvdy4KCi1TaXdlaQo+Cj4gT3RoZXIgdGhhbiB0aGlzOgo+Cj4g
QWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4KPiBUaGFua3MKPgo+
PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5lZWRlZCBmb3IgZGV2aWNlcyB0aGF0
IGFyZSB1c2luZyBkZXZpY2UKPj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGVj
aWZpYyBETUEgdHJhbnNsYXRpb24gYW5kIHByZWZlciBtYXBwaW5nCj4+ICsgKiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdG8gYmUgZGVjb3VwbGVkIGZyb20gdGhlIHZpcnRpbyBsaWZlIGN5
Y2xlLAo+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGkuZS4gZGV2aWNlIC5yZXNl
dCBvcCBkb2VzIG5vdCByZXNldCBtYXBwaW5nCj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQGFzaWQ6IGFkZHJlc3Mgc3BhY2UgaWRlbnRpZmllcgo+PiArICogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFJldHVybnMgaW50ZWdlcjogc3VjY2VzcyAoMCkgb3IgZXJyb3IgKDwgMCkK
Pj4gICAgKiBAZ2V0X3ZxX2RtYV9kZXY6ICAgICAgICAgICAgR2V0IHRoZSBkbWEgZGV2aWNlIGZv
ciBhIHNwZWNpZmljCj4+ICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1
ZSAob3B0aW9uYWwpCj4+ICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2
ZHBhIGRldmljZQo+PiBAQCAtNDA1LDYgKzQxNCw3IEBAIHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMg
ewo+PiAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgaW92YSwgdTY0IHNpemUsIHU2NCBwYSwg
dTMyIHBlcm0sIHZvaWQgKm9wYXF1ZSk7Cj4+ICAgICAgICAgIGludCAoKmRtYV91bm1hcCkoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCwKPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICB1NjQgaW92YSwgdTY0IHNpemUpOwo+PiArICAgICAgIGludCAoKnJlc2V0
X21hcCkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCk7Cj4+ICAg
ICAgICAgIGludCAoKnNldF9ncm91cF9hc2lkKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVu
c2lnbmVkIGludCBncm91cCwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkIGludCBhc2lkKTsKPj4gICAgICAgICAgc3RydWN0IGRldmljZSAqKCpnZXRfdnFfZG1hX2Rl
dikoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4KTsKPj4gLS0KPj4gMS44LjMuMQo+
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
