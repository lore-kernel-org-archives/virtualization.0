Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A93CDB474
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 20:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70E0740A73;
	Mon, 16 Oct 2023 20:30:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70E0740A73
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=pEcsshLI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=f1dDog24
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S6hQcMKGQqUI; Mon, 16 Oct 2023 20:30:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 187DE400F9;
	Mon, 16 Oct 2023 20:30:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 187DE400F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E69BEC0039;
	Mon, 16 Oct 2023 20:30:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB7B5C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 20:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8834181338
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 20:30:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8834181338
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=pEcsshLI; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=f1dDog24
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eYYkw2dfWDGl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 20:30:40 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D40A0812D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 20:30:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D40A0812D3
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GKOMsF014467; Mon, 16 Oct 2023 20:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=J6MYFzkag2TURtzsulr5U83rWjLmHkjG/TaB6FdCRfs=;
 b=pEcsshLIuJTG6cFcuMmwU0xnl8h4xG0RX5t37dSgu5byR9zUqZmnRNDMOB1JQ0iVOvOH
 LsjvE9UHbMFu4cJN7cY6dq2USaIx4B8IsueMxR+TNPmJ9I3guHea0zckJldd7a9rND4r
 xdDSo7YRGu9RshTNvg1tCXSORZm5yQch5tkxyXs1dZGrASPb/S/UFR5GJWuLZ3lirl9K
 vLBU9Lf2uXZp5Jm2NT2oxu/l0G8Mb1V61e89yiNx8igP438XdFb6zLSi4+dj4uwQDiUn
 bx/MOCiWICwoOpa8ufbH3qOonTD2NyzbgafQYJ7hWzUDk56Flo3qrvP8qjBfNK2ebn9W wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu3qj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 20:30:37 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39GKCiAe040423; Mon, 16 Oct 2023 20:30:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfykd92q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 20:30:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNkJx8qLgodNn7TG1q2Seu2Eahhu1Gmi3/luBfUvivSob3O3tEYi1hr60x2TuCTZVzsQ4QFR6ncDYvNNz9BG02b9VMEuJPAyE9JqcdxsKfifk3gKY6yteQ4P49Qg3FRG6Q7/ICgfDDDPct2HE0ajhJsPlgwbgcjj4ZY6drf4z92i3Kx3y/LxgbE0Qo4rluFVLCk0da5KTt3QaANgf7+3heajf8WZclXaKmh+X3riR9qR6P0amEhu0rwmc3rjOu880QxwZtr+ocxYQBEJppWlmBo/FYmEJ9fW4sT5Z+ikeHnBZmPmUcwD7RE2JKKu8gwHRYqRgsYJmRIWoap4DtCcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6MYFzkag2TURtzsulr5U83rWjLmHkjG/TaB6FdCRfs=;
 b=hTRVABcL3TmqYqToBVInIluW9MAdZWIG2wGnwjLE/FcfyeKmKO+STXkRQkEOUWMaLZKQOHJsy5PvOmolCO7M6vctYovNVvPsHGNuJ09kCkBAEkj5pzvYDfHxcpfFAT094tMAdOppR1hNxu31HSr5Vz7X4lPBqOpsetZQSZyCrA+XkuZaMBN+Qmels8xiTPf6BcElsIVhII6HaPsN6uj7JDeP0ZT8i1jiEwJw+sDWpfUlMSRpT36m3mfrG5wXcuVBOIRJ8V0qvfz1Yiv7FOxjTb4MjfEFyIfcbpLH5xb1rvgzr0DOlTWH9vHS5JdDNzbJuTvW4K9rS6UcIlEIfVINMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6MYFzkag2TURtzsulr5U83rWjLmHkjG/TaB6FdCRfs=;
 b=f1dDog24w2fJIXKrExH46IyJ5owaLwjmb8/ho+JmRtQzw48dmeKvYQhfzQgDWdlU0V2ANhHzu33WPxUK+5Km8YaxeiOlf/NONg3Wtsmqbn1xVUyfe/OfPHA6NiyvCAp+G3YQSEvUFjTIL+6Xzf1neyc0aZIuESxqLnuxrIkKQFw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SJ0PR10MB7689.namprd10.prod.outlook.com (2603:10b6:a03:51a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 20:30:33 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 20:30:33 +0000
Message-ID: <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
Date: Mon, 16 Oct 2023 13:30:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
X-ClientProxiedBy: DM6PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:5:40::15) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SJ0PR10MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3fffb7-43be-45f9-da9c-08dbce86bf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+yndMnFcZT70jLAL7U3mIpMVxwWfqr0ZqJw9d6oUiGVFmVNHruTelho07G1kR+ismws6t6/ikX09uihg/x/qzPUv2RHZiiUpeWjPogXohgBKM0UCgITk08fG51Qmz1Z8P5jUVFEV41mkqCRRQ3R+ejzUrRv9bW0ys+JfPJdFGZVhp6NDOLA374QLqp/KfzVdjKAoyD2jRoZBt2ldk8fs36fgJNXtdDMNKiizOkfepkx4IxWUMsYHhvClFW4d/uK5od7FP/Se+zqeRB6LK3CsH1KoJkDVG6zbnFUoyBYTAnDiy6DZK30nXXT7Ris5bpfipQMvrcIL17r7ChPsI9Ftcpl8ec0evJt0ZWlM6fGYhc5l0SL42BgcdjH9UTC5JiNAE4a8LotOWUzCa5tCO6r3WzJQpUtzMwTRcMY0buq7gB2I2+y/27P9sDvS0XkNikjriQYxKCzUFwv27oE8u7WmX7xb2l9Wgmw0Cy48pqauD3r4WUeH2pyU0bgUFO4IrVJDcxmWYSwAci8oSWlct9ZV6NCrhTvXi9/c6ZEoT5UWyLhv01yif8Lp+LQk9IdIMjOvoDzGX6sct+WgiNaMZRDGP/G6l5h5jdp36nfJ3r6s0P+jAuyCXjtTbGSSgwhgivmGpCjPZM1esrpTwUYz9XEn+I3XKfVnCRwyC5XVXkZgbqkCSRnyYcSlBa475yYeBfOf9ZwUv71XKhvZJ7jBHnGKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6506007)(36916002)(6666004)(53546011)(83380400001)(31686004)(26005)(6512007)(2616005)(66899024)(38100700002)(86362001)(31696002)(2906002)(5660300002)(6486002)(4326008)(8936002)(8676002)(66946007)(110136005)(41300700001)(36756003)(66476007)(316002)(66556008)(966005)(478600001)(142923001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXMwbTFHWkxROVRBNU1kRi9YQ1Nva1JxWEtwNks0UFFHK1ZIcDE0R3g3WWZE?=
 =?utf-8?B?MTE5NmF3a0lSNEZqRy8zNHVndmFWY2lrSHk0ZE9pdW9vZ3A2NGV1ZW1Eb1Ny?=
 =?utf-8?B?Q2o0bGVyTWdMQmNPWG90RWtiZmgvVktlNU40UzJjbWUwWlp0ZWN1a2szbVVj?=
 =?utf-8?B?ZExGd0xXL0xLbFVNcDVzRFR3K2NRb0JMOENXNXN4dko4aWxFd0dkdTl5cGVu?=
 =?utf-8?B?c3VBZ3BpMC9pVDZxMkd4dW4wdjJFdEcxb1VrWHVNZlJJblViUjN3U1dQSXNs?=
 =?utf-8?B?clE0RlFzME1TTzhEL3llNERtZllLSC9mYlRuQXNubUlaNlZpZWs1SUJIS2F5?=
 =?utf-8?B?Y0RDSEZaRTdLYmlZTFRiL1pvalFRcCtmL1VpMVZjS0dxNmthSk5IYkVaMkpO?=
 =?utf-8?B?WCsrT3NYWkh0dnV0bExTU0FFVC9jbVBNV2xaRzRrVlRRelFCZVJ1OWg0OE55?=
 =?utf-8?B?QUVUVlloVHZPUEhnejEwenlONlNIZmcra1lzekpHbEptbkVoRHRrZFNGYW91?=
 =?utf-8?B?eG9tczJKVzVqWmZwNVRNZ0MvMWJBWCtzcjAwMlJpVmt1aGsxcjlRK1ArblFr?=
 =?utf-8?B?OFVxbmNNeW1UbUhzdnNXSy9Jd0tPYzhtcFRvcnQzcXNUZ1ZzdHJkKzUxL0JQ?=
 =?utf-8?B?STQzbW80M2FPMlVjbjhSc3k4YWVPdy9LYWUzUjNVaG1GKy9hcjRtNlZpWTVD?=
 =?utf-8?B?QktFaE8wZm9iMEtBV2dtQTdhRUR0dFdEdzN1alVCT3pmTFRrWWdGbnlDbWdL?=
 =?utf-8?B?WWxmTkhDeHQ3VjJ2VW5VNUpHN2dyRytTU1Z0aUVtdW4xYVNFbkRCWkcwdkcv?=
 =?utf-8?B?SVFMazRDbzZaWTlCY2R0azFOUHIwWTFyNjE4bWg5S29SVnpjZzdwT3lvamw0?=
 =?utf-8?B?K01oUEl0Z1M3Z3dUZ3FJTXdPSllqOXQzT1ltUmJ1M01JdHkxSERlNTBXMnJV?=
 =?utf-8?B?enVKdnJkQjRpUUg1dWNhOW5JVnd2M0Vzc01UUms5Rk5nTGdla1hKQnFicFhs?=
 =?utf-8?B?dWxYWlNTQnIwZ1NJMW9tSHJqVzNpNDZmaGhHcVVBdHFCN1Y3NlR5THk3bHRP?=
 =?utf-8?B?K3liUktiV3pJZkc1UlhzdzQ5a2Q5WW9BY3pjWC9OdHdjSnU5THhmeFpFTlNk?=
 =?utf-8?B?ZG1STkd1azdKUzVjQmFHeVBFWUNyU21TdkFCWXpTRmQ1MjA1TDJDOWwwOUxz?=
 =?utf-8?B?RVIwODR0SjM1OXBmVEhaWmpPRU05N29vTHBUS0RFQmowT0tOUHBQbkJ1OFIv?=
 =?utf-8?B?SU93YmUvUzVLQ3NGdlZzWVlQNSt3WlgwUGs3YnpTWXd3NGYrbjUzV3Q1aWRk?=
 =?utf-8?B?Vk9WTWxCM3BWSXFVZjZwbFhKTy9hWmM2RWhHcEFwMXhPZDR2TWpRdG9SNXNk?=
 =?utf-8?B?Z1djQm1wTG5TWTFQckl3U3JiaDQvdC9YM1FkSzRkU1lCWGh5K1VZc1R6VXVr?=
 =?utf-8?B?cDhabUd5UWNNUzFzRVg2VkNTUFFYOUM1WjJkUmdUUk1ycUxmV2lTaFdDVlZE?=
 =?utf-8?B?eHVlM0d6VkFvZFBkdFVKdlZ3WGhTMzVMdjRPZlZVdUt5aHZTVXgxa0I1aEVP?=
 =?utf-8?B?bGEwYjNxY3grT1RQS2NjQ0VoWXBpSm1FRk16UGFTd3BxTTd4VGIvL1g2MHBT?=
 =?utf-8?B?RDg2YndlbURERmNoQkFvckgxMWlXcmpST3ZhR29hWjNsR0tVM243bHlIellK?=
 =?utf-8?B?OTczNVJKbTM2U2tmYkg4VG5pQXZ6T0ZSVmVrcEJaWUN4UWNyRHZuUTh5b215?=
 =?utf-8?B?dWNpQzhibkgydFEvWEJXakdUOFd1bkYweEVxQWRsK0ZXOHNIb0FIUElkVENZ?=
 =?utf-8?B?WmtSaGVkZDBwcUQ5QlVqa2hFR2xSQkowaldxbFVEVlFUKzJEM0pYRFRIV1Fa?=
 =?utf-8?B?NWpjZWJFTkZ6QkJmZC9KWG5qSjFGU2xvOHNIam82WVhuQXhWL3RFZ1hFVGp6?=
 =?utf-8?B?dENCNjZIRHV4UWJ2VnFrdzFxWGgvWUdnNm9xTEZzNGxaU1F6VTlCeWFnZC91?=
 =?utf-8?B?TnRvUy9VcVYvMEhuSUo2TVZaS1diRDM3OFg4dE4wRDRMVXU5ekFPdUhHOExU?=
 =?utf-8?B?K295TGhINkVWVkdZSk96T2hnMzFldkNkdG9PQ2RzOWZCam1zb3dPclpyWmRP?=
 =?utf-8?Q?TZMJ6EqT/z5WNSpGSB0S78Haj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aDR0aEI0cGpxc2d4QWgvTTRrbmF2UjlPaTFqSFluU3ozL082WE4xOXR0V3E5?=
 =?utf-8?B?MDFTd2duSnVFUjBRd1U0LzYrODFvOHM0azc3Y2l5RVk2M3VlRmNsbnRKVVVp?=
 =?utf-8?B?UWEydTlhVkVDQnU4c0I4eGJBSXVPWm4yaW9vRGZTSmZNZTdCbXpGYnRFNmps?=
 =?utf-8?B?di9BeEtWa0tpbmVYbGN5OSsrcG92WU55dk9Wb2I0WmY2TFB2WGwxYWZCWHFD?=
 =?utf-8?B?ZkJjelB6Sm80aXBIZlU5Yi95ZzFjMGpKVlZwMzFJVktIUTF3b01VeTQ0Vzdq?=
 =?utf-8?B?aHhMcjdsbWJLQXBrMS84R2NvTEtSSGoyampFa054MkEzVlV5cjdaZ0tISkND?=
 =?utf-8?B?MHdodkRFbjdwQjRzTHIvZVlaOHpmVDZTRmMxcFZEVFpsZFIzUFRRaEE5QTNZ?=
 =?utf-8?B?WjRzdWlNVDc2QjVJSCtQeGY4WTBuN2lSZDRXcTJzMnAwUlhJeWVQMElnbi9I?=
 =?utf-8?B?Rk9GN3Zxd1VwZVErRHRzZ3RvWmhiaW4yYlNaQkhCMUduYlIxY0VLajcrZDZ2?=
 =?utf-8?B?RDlXVVpYVlFiN0pJc2NqZVNmQVdyQklTS3hZYVIxWnhuai9VSE4vTkFCcFJi?=
 =?utf-8?B?SERkV29yOFk1QjFPanV1eGJEWFF6VkMwemxYUmo2SU9TVUlTR0hxcVFYWHJS?=
 =?utf-8?B?aWhQVnM3R05IMGlDaWM1ZVBxWlM3SmViUUh5SXo3bFNvdU1iM21NSGZzVmlU?=
 =?utf-8?B?eHVZL0E0Q1hOamIrem9Cc0tXTE00QXF4cExYTnUxNnVpbldCMkdMOVJuYnZV?=
 =?utf-8?B?QnFWL01ub2hYVFJ6Wkt3a21RYmFDaE8wUGZmd3poWGUzenNMZFBpc2Z2RlpW?=
 =?utf-8?B?VlRSeGxtZFFwS2orMGFHMHNZcXNoKzdyUXN4V2hDVld4WHRITVdteXQ2RHYz?=
 =?utf-8?B?cjdlT3RJa1J0bGFmd3JzWlRlQ2hUb1pDZXp4MWphZ1NnRTR2UEFzaDRLZFpR?=
 =?utf-8?B?NHA0N0N5U0duMlZ3cE9nZFpTZkVoNVEvRWJUc1dRdjBndXhpYU9CVkNQNzVL?=
 =?utf-8?B?dXRzOGFyMDk2a0hFc1ZBejdDZzloTFlRK3A1aGhvQWFkcHIxSHI4NmUzVHI1?=
 =?utf-8?B?RkdGVXRDTVpsU0xmbGd0bGx4S3ZRdTZla25mWWNOU1FqT3dOYWxZamdMeUNX?=
 =?utf-8?B?UG5iWjVSUGlCVWsvVlBoZDVQSzNmdGhMeDNVWENocTFkaEFseDdBeUp4QmJI?=
 =?utf-8?B?MEtma3RwOWQ2SE9MbGtmUXRoeFdxSDVyNEt6dGxSbDYxSHJMc0xOcHk2RkdV?=
 =?utf-8?Q?aiJ2laJ0xO1jWVt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3fffb7-43be-45f9-da9c-08dbce86bf30
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 20:30:33.3125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnXfAOYj7dje0kebpc1dTQlS8uAzF7c9VUsEVNIzZy028qbMJMMbsjgvA9d0RR9tFhIBTWkrRX3fHP+hnsYpNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160178
X-Proofpoint-GUID: 1Voe6IQ2JjRuABDwQ7TxCa7ed3vB5pDJ
X-Proofpoint-ORIG-GUID: 1Voe6IQ2JjRuABDwQ7TxCa7ed3vB5pDJ
Cc: xuanzhuo@linux.alibaba.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

CgpPbiAxMC8xNi8yMDIzIDQ6MjggQU0sIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+IE9u
IE1vbiwgT2N0IDE2LCAyMDIzIGF0IDg6MzPigK9BTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4gT24gRnJpLCBPY3QgMTMsIDIwMjMgYXQgMzozNuKAr1BNIFNpLVdl
aSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDEwLzEy
LzIwMjMgODowMSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+PiBPbiBUdWUsIE9jdCAxMCwgMjAy
MyBhdCA1OjA14oCvUE0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90ZToK
Pj4+Pj4gRGV2aWNlcyB3aXRoIG9uLWNoaXAgSU9NTVUgb3IgdmVuZG9yIHNwZWNpZmljIElPVExC
IGltcGxlbWVudGF0aW9uCj4+Pj4+IG1heSBuZWVkIHRvIHJlc3RvcmUgaW90bGIgbWFwcGluZyB0
byB0aGUgaW5pdGlhbCBvciBkZWZhdWx0IHN0YXRlCj4+Pj4+IHVzaW5nIHRoZSAucmVzZXRfbWFw
IG9wLCBhcyBpdCdzIGRlc2lyYWJsZSBmb3Igc29tZSBwYXJlbnQgZGV2aWNlcwo+Pj4+PiB0byBz
b2xlbHkgbWFuaXB1bGF0ZSBtYXBwaW5ncyBieSBpdHMgb3duLCBpbmRlcGVuZGVudCBvZiB2aXJ0
aW8gZGV2aWNlCj4+Pj4+IHN0YXRlLiBGb3IgaW5zdGFuY2UsIGRldmljZSByZXNldCBkb2VzIG5v
dCBjYXVzZSBtYXBwaW5nIGdvIGF3YXkgb24KPj4+Pj4gc3VjaCBJT1RMQiBtb2RlbCBpbiBuZWVk
IG9mIHBlcnNpc3RlbnQgbWFwcGluZy4gQmVmb3JlIHZob3N0LXZkcGEKPj4+Pj4gaXMgZ29pbmcg
YXdheSwgZ2l2ZSB0aGVtIGEgY2hhbmNlIHRvIHJlc2V0IGlvdGxiIGJhY2sgdG8gdGhlIGluaXRp
YWwKPj4+Pj4gc3RhdGUgaW4gdmhvc3RfdmRwYV9jbGVhbnVwKCkuCj4+Pj4+Cj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KPj4+Pj4gLS0tCj4+
Pj4+ICAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMTYgKysrKysrKysrKysrKysrKwo+Pj4+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+PiBpbmRl
eCA4NTE1MzVmLi5hM2Y4MTYwIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEu
Ywo+Pj4+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+PiBAQCAtMTMxLDYgKzEzMSwx
NSBAQCBzdGF0aWMgc3RydWN0IHZob3N0X3ZkcGFfYXMgKnZob3N0X3ZkcGFfZmluZF9hbGxvY19h
cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+Pj4gICAgICAgICAgIHJldHVybiB2aG9zdF92ZHBh
X2FsbG9jX2FzKHYsIGFzaWQpOwo+Pj4+PiAgICB9Cj4+Pj4+Cj4+Pj4+ICtzdGF0aWMgdm9pZCB2
aG9zdF92ZHBhX3Jlc2V0X21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTMyIGFzaWQpCj4+Pj4+
ICt7Cj4+Pj4+ICsgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPj4+
Pj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25m
aWc7Cj4+Pj4+ICsKPj4+Pj4gKyAgICAgICBpZiAob3BzLT5yZXNldF9tYXApCj4+Pj4+ICsgICAg
ICAgICAgICAgICBvcHMtPnJlc2V0X21hcCh2ZHBhLCBhc2lkKTsKPj4+Pj4gK30KPj4+Pj4gKwo+
Pj4+PiAgICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVtb3ZlX2FzKHN0cnVjdCB2aG9zdF92ZHBh
ICp2LCB1MzIgYXNpZCkKPj4+Pj4gICAgewo+Pj4+PiAgICAgICAgICAgc3RydWN0IHZob3N0X3Zk
cGFfYXMgKmFzID0gYXNpZF90b19hcyh2LCBhc2lkKTsKPj4+Pj4gQEAgLTE0MCw2ICsxNDksMTMg
QEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3JlbW92ZV9hcyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwg
dTMyIGFzaWQpCj4+Pj4+Cj4+Pj4+ICAgICAgICAgICBobGlzdF9kZWwoJmFzLT5oYXNoX2xpbmsp
Owo+Pj4+PiAgICAgICAgICAgdmhvc3RfdmRwYV9pb3RsYl91bm1hcCh2LCAmYXMtPmlvdGxiLCAw
VUxMLCAwVUxMIC0gMSwgYXNpZCk7Cj4+Pj4+ICsgICAgICAgLyoKPj4+Pj4gKyAgICAgICAgKiBE
ZXZpY2VzIHdpdGggdmVuZG9yIHNwZWNpZmljIElPTU1VIG1heSBuZWVkIHRvIHJlc3RvcmUKPj4+
Pj4gKyAgICAgICAgKiBpb3RsYiB0byB0aGUgaW5pdGlhbCBvciBkZWZhdWx0IHN0YXRlIHdoaWNo
IGlzIG5vdCBkb25lCj4+Pj4+ICsgICAgICAgICogdGhyb3VnaCBkZXZpY2UgcmVzZXQsIGFzIHRo
ZSBJT1RMQiBtYXBwaW5nIG1hbmlwdWxhdGlvbgo+Pj4+PiArICAgICAgICAqIGNvdWxkIGJlIGRl
Y291cGxlZCBmcm9tIHRoZSB2aXJ0aW8gZGV2aWNlIGxpZmUgY3ljbGUuCj4+Pj4+ICsgICAgICAg
ICovCj4+Pj4gU2hvdWxkIHdlIGRvIHRoaXMgYWNjb3JkaW5nIHRvIHdoZXRoZXIgSU9UTEJfUFJF
U0lTVCBpcyBzZXQ/Cj4+PiBXZWxsLCBpbiB0aGVvcnkgdGhpcyBzZWVtcyBsaWtlIHNvIGJ1dCBp
dCdzIHVubmVjZXNzYXJ5IGNvZGUgY2hhbmdlCj4+PiBhY3R1YWxseSwgYXMgdGhhdCBpcyB0aGUg
d2F5IGhvdyB2RFBBIHBhcmVudCBiZWhpbmQgcGxhdGZvcm0gSU9NTVUgd29ya3MKPj4+IHRvZGF5
LCBhbmQgdXNlcnNwYWNlIGRvZXNuJ3QgYnJlYWsgYXMgb2YgdG9kYXkuIDopCj4+IFdlbGwsIHRo
aXMgaXMgb25lIHF1ZXN0aW9uIEkndmUgZXZlciBhc2tlZCBiZWZvcmUuIFlvdSBoYXZlIGV4cGxh
aW5lZAo+PiB0aGF0IG9uZSBvZiB0aGUgcmVhc29uIHRoYXQgd2UgZG9uJ3QgYnJlYWsgdXNlcnNw
YWNlIGlzIHRoYXQgdGhleSBtYXkKPj4gY291cGxlIElPVExCIHJlc2V0IHdpdGggdkRQQSByZXNl
dCBhcyB3ZWxsLiBPbmUgZXhhbXBsZSBpcyB0aGUgUWVtdS4KPj4KPj4+IEFzIGV4cGxhaW5lZCBp
biBwcmV2aW91cyB0aHJlYWRzIFsxXVsyXSwgd2hlbiBJT1RMQl9QRVJTSVNUIGlzIG5vdCBzZXQK
Pj4+IGl0IGRvZXNuJ3QgbmVjZXNzYXJpbHkgbWVhbiB0aGUgaW90bGIgd2lsbCBkZWZpbml0ZWx5
IGJlIGRlc3Ryb3llZAo+Pj4gYWNyb3NzIHJlc2V0ICh0aGluayBhYm91dCB0aGUgcGxhdGZvcm0g
SU9NTVUgY2FzZSksIHNvIHVzZXJzcGFjZSB0b2RheQo+Pj4gaXMgYWxyZWFkeSB0b2xlcmF0aW5n
IGVub3VnaCB3aXRoIGVpdGhlciBnb29kIG9yIGJhZCBJT01NVS4gVGhpcyBjb2RlIG9mCj4+PiBu
b3QgY2hlY2tpbmcgSU9UTEJfUEVSU0lTVCBiZWluZyBzZXQgaXMgaW50ZW50aW9uYWwsIHRoZXJl
J3Mgbm8gcG9pbnQgdG8KPj4+IGVtdWxhdGUgYmFkIElPTU1VIGJlaGF2aW9yIGV2ZW4gZm9yIG9s
ZGVyIHVzZXJzcGFjZSAod2l0aCBpbXByb3Blcgo+Pj4gZW11bGF0aW9uIHRvIGJlIGRvbmUgaXQg
d291bGQgcmVzdWx0IGluIGV2ZW4gd29yc2UgcGVyZm9ybWFuY2UpLgo+PiBGb3IgdHdvIHJlYXNv
bnM6Cj4+Cj4+IDEpIGJhY2tlbmQgZmVhdHVyZXMgbmVlZCBhY2tlZCBieSB1c2Vyc3BhY2UgdGhp
cyBpcyBieSBkZXNpZ24KPj4gMikga2VlcCB0aGUgb2RkIGJlaGF2aW91ciBzZWVtcyB0byBiZSBt
b3JlIHNhZmUgYXMgd2UgY2FuJ3QgYXVkaXQKPj4gZXZlcnkgdXNlcnNwYWNlIHByb2dyYW0KPj4K
PiBUaGUgb2xkIGJlaGF2aW9yICh3aXRob3V0IGZsYWcgYWNrKSBjYW5ub3QgYmUgdHJ1c3RlZCBh
bHJlYWR5LCBhczoKPiAqIERldmljZXMgdXNpbmcgcGxhdGZvcm0gSU9NTVUgKGluIG90aGVyIHdv
cmRzLCBub3QgaW1wbGVtZW50aW5nCj4gbmVpdGhlciAuc2V0X21hcCBub3IgLmRtYV9tYXApIGRv
ZXMgbm90IHVubWFwIG1lbW9yeSBhdCB2aXJ0aW8gcmVzZXQuCj4gKiBEZXZpY2VzIHRoYXQgaW1w
bGVtZW50IC5zZXRfbWFwIG9yIC5kbWFfbWFwICh2ZHBhX3NpbSwgbWx4NSkgZG8KPiByZXNldCBJ
T1RMQiwgYnV0IGluIHRoZWlyIHBhcmVudCBvcHMgKHZkcGFzaW1fZG9fcmVzZXQsIHBydW5lX2lv
dGxiCj4gY2FsbGVkIGZyb20gbWx4NV92ZHBhX3Jlc2V0KS4gV2l0aCB2ZHBhX3NpbSBwYXRjaCBy
ZW1vdmluZyB0aGUgcmVzZXQsCj4gbm93IGFsbCBiYWNrZW5kcyB3b3JrIHRoZSBzYW1lIGFzIGZh
ciBhcyBJIGtub3cuLCB3aGljaCB3YXMgKGFuZCBpcykKPiB0aGUgd2F5IGRldmljZXMgdXNpbmcg
dGhlIHBsYXRmb3JtIElPTU1VIHdvcmtzLgo+Cj4gVGhlIGRpZmZlcmVuY2UgaW4gYmVoYXZpb3Ig
ZGlkIG5vdCBtYXR0ZXIgYXMgUUVNVSB1bm1hcHMgYWxsIHRoZQo+IG1lbW9yeSB1bnJlZ2lzdGVy
aW5nIHRoZSBtZW1vcnkgbGlzdGVuZXIgYXQgdmhvc3RfdmRwYV9kZXZfc3RhcnQoLi4uLAo+IHN0
YXJ0ZWQgPSBmYWxzZSksCkV4YWN0bHkuIEl0J3Mgbm90IGp1c3QgUUVNVSwgYnV0IGFueSAob2xk
ZXIpIHVzZXJzcGFjZSBtYW5pcHVsYXRlcyAKbWFwcGluZ3MgdGhyb3VnaCB0aGUgdmhvc3QtdmRw
YSBpb3RsYiBpbnRlcmZhY2UgaGFzIHRvIHVubWFwIGFsbCAKbWFwcGluZ3MgdG8gd29ya2Fyb3Vu
ZCB0aGUgdmRwYSBwYXJlbnQgZHJpdmVyIGJ1Zy4gSWYgdGhleSBkb24ndCBkbyAKZXhwbGljaXQg
dW5tYXAsIGl0IHdvdWxkIGNhdXNlIHN0YXRlIGluY29uc2lzdGVuY3kgYmV0d2VlbiB2aG9zdC12
ZHBhIAphbmQgcGFyZW50IGRyaXZlciwgdGhlbiBvbGQgbWFwcGluZ3MgY2FuJ3QgYmUgcmVzdG9y
ZWQsIGFuZCBuZXcgbWFwcGluZyAKY2FuIGJlIGFkZGVkIHRvIGlvdGxiIGFmdGVyIHZEUEEgcmVz
ZXQuIFRoZXJlJ3Mgbm8gcG9pbnQgdG8gcHJlc2VydmUgCnRoaXMgYnJva2VuIGFuZCBpbmNvbnNp
c3RlbnQgYmVoYXZpb3IgYmV0d2VlbiB2aG9zdC12ZHBhIGFuZCBwYXJlbnQgCmRyaXZlciwgYXMg
dXNlcnNwYWNlIGRvZXNuJ3QgY2FyZSBhdCBhbGwhCgo+IGJ1dCB0aGUgYmFja2VuZCBhY2tub3ds
ZWRnaW5nIHRoaXMgZmVhdHVyZSBmbGFnCj4gYWxsb3dzIFFFTVUgdG8gbWFrZSBzdXJlIGl0IGlz
IHNhZmUgdG8gc2tpcCB0aGlzIHVubWFwICYgbWFwIGluIHRoZQo+IGNhc2Ugb2Ygdmhvc3Qgc3Rv
cCAmIHN0YXJ0IGN5Y2xlLgo+Cj4gSW4gdGhhdCBzZW5zZSwgdGhpcyBmZWF0dXJlIGZsYWcgaXMg
YWN0dWFsbHkgYSBzaWduYWwgZm9yIHVzZXJzcGFjZSB0bwo+IGtub3cgdGhhdCB0aGUgYnVnIGhh
cyBiZWVuIHNvbHZlZC4KUmlnaHQsIEkgY291bGRuJ3Qgc2F5IGl0IGJldHRlciB0aGFuIHlvdSBk
bywgdGhhbmtzISBUaGUgZmVhdHVyZSBmbGFnIGlzIAptb3JlIG9mIGFuIHVudXN1YWwgbWVhbnMg
dG8gaW5kaWNhdGluZyBrZXJuZWwgYnVnIGhhdmluZyBiZWVuIGZpeGVkLCAKcmF0aGVyIHRoYW4g
aW50cm9kdWNlIGEgbmV3IGZlYXR1cmUgb3IgbmV3IGtlcm5lbCBiZWhhdmlvciBlbmRpbmcgdXAg
aW4gCmNoYW5nZSBvZiB1c2Vyc3BhY2UncyBleHBlY3RhdGlvbi4KCj4gTm90IG9mZmVyaW5nIGl0
IGluZGljYXRlcyB0aGF0Cj4gdXNlcnNwYWNlIGNhbm5vdCB0cnVzdCB0aGUga2VybmVsIHdpbGwg
cmV0YWluIHRoZSBtYXBzLgo+Cj4gU2ktV2VpIG9yIERyYWdvcywgcGxlYXNlIGNvcnJlY3QgbWUg
aWYgSSd2ZSBtaXNzZWQgc29tZXRoaW5nLiBGZWVsCj4gZnJlZSB0byB1c2UgdGhlIHRleHQgaW4g
Y2FzZSB5b3UgZmluZCBtb3JlIGNsZWFyIGluIGRvYyBvciBwYXRjaCBsb2cuClN1cmUsIHdpbGwg
ZG8sIHRoYW5rIHlvdSEgV2lsbCBwb3N0IHYyIGFkZGluZyB0aGVzZSB0byB0aGUgbG9nLgoKVGhh
bmtzLAotU2l3ZWkKCgoKPgo+IFRoYW5rcyEKPgo+PiBUaGFua3MKPj4KPj4+IEkgdGhpbmsKPj4+
IHRoZSBwdXJwb3NlIG9mIHRoZSBJT1RMQl9QRVJTSVNUIGZsYWcgaXMganVzdCB0byBnaXZlIHVz
ZXJzcGFjZSAxMDAlCj4+PiBjZXJ0YWludHkgb2YgcGVyc2lzdGVudCBpb3RsYiBtYXBwaW5nIG5v
dCBnZXR0aW5nIGxvc3QgYWNyb3NzIHZkcGEgcmVzZXQuCj4+Pgo+Pj4gVGhhbmtzLAo+Pj4gLVNp
d2VpCj4+Pgo+Pj4gWzFdCj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy92aXJ0dWFsaXphdGlv
bi85ZjExOGZjOS00ZjZmLWRkNjctYTI5MS1iZTc4MTUyZTQ3ZmRAb3JhY2xlLmNvbS8KPj4+IFsy
XQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydHVhbGl6YXRpb24vMzM2NGFkZmQtMWVi
Ny04YmNlLTQxZjktYmZlNTQ3M2YxZjJlQG9yYWNsZS5jb20vCj4+Pj4gICAgT3RoZXJ3aXNlCj4+
Pj4gd2UgbWF5IGJyZWFrIG9sZCB1c2Vyc3BhY2UuCj4+Pj4KPj4+PiBUaGFua3MKPj4+Pgo+Pj4+
PiArICAgICAgIHZob3N0X3ZkcGFfcmVzZXRfbWFwKHYsIGFzaWQpOwo+Pj4+PiAgICAgICAgICAg
a2ZyZWUoYXMpOwo+Pj4+Pgo+Pj4+PiAgICAgICAgICAgcmV0dXJuIDA7Cj4+Pj4+IC0tCj4+Pj4+
IDEuOC4zLjEKPj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
