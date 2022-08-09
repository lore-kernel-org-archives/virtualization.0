Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A091C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 22:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0909381970;
	Tue,  9 Aug 2022 22:32:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0909381970
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=f7P94IbJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Sk4h+0o5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lBBgqi3Md4WR; Tue,  9 Aug 2022 22:32:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A7EE81926;
	Tue,  9 Aug 2022 22:32:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A7EE81926
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD768C0033;
	Tue,  9 Aug 2022 22:32:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F190DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC85A40923
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:32:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC85A40923
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=f7P94IbJ; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=Sk4h+0o5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vAi_2VWPsHDW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:32:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56A2640921
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56A2640921
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 22:32:39 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279M98ZP028635;
 Tue, 9 Aug 2022 22:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KyB+ynfY2Z8jm9ldrzE17+GMquqvKWnhK4UHK+4yTCI=;
 b=f7P94IbJMGMWWv/aAZUO6DTtUpzAcmP+3CwSaCSRpfFg4cT3lzohMA/uhkuZ/QQkk75b
 /8QajdZDe3Sny8esga8jM9F0AAnYO3uPNV+nq7sYkOEaof2esPy9GXnJNAqKh5+zlxIt
 zFgmS2R+St8LiCU91WrR5pNFrwsAQEQCk2wMARtSOSImvA/dQi8UBc+txnocR5lToZUZ
 +yYkqyCtO9i5UjJSaUKMEzXqNd0St+vjl8XdcqoVmMVC9GQjL6/fz06kOnzt2Cey/LUL
 R2tRitfMhLR11kjzT6lbv61tLJTM+UYwiv+ouoK92H4GIbH5ziHDDSyZbtYnwAZoRc1B kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqj0bk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 22:32:35 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 279Kf3AY019927; Tue, 9 Aug 2022 22:32:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3huwqhm1fv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 22:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBy+vHnCDZ1tDrzxBWCT4SCV+6Bogud4lqXdpOZRh8pwA45UuruJlfZYUpJyB+tdLovt5Lt3fByAiY5eG+ya0/YKe6goqzRMexH5fxNGI0po+m35FgmqfkApZINlSxFs+vLCc9FLLwGqXAq1/CJnLasWQQKVC1MA6x7Q1IL8rsJBPenl/j6L09o0ue8bSr0R7rKBt/VUYGQvJUDEqpeyNofmhWU5Jw/SgSET81EKeXCE9Pg4+J7j9e0v+DCgER7xDUToOjXE6sh6zMVMWKFi3ulG7dVas1PHIAhm/Ouwt7tx9PVESpqXxnvO9GLyL4x8a3ch9Dd3zm8xfvvXwfXctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyB+ynfY2Z8jm9ldrzE17+GMquqvKWnhK4UHK+4yTCI=;
 b=I7n7EtAss0J2KyTgfVX/qhP64PEG9pLQjQLwHD6u5HQK8kR2dgCyYqq/fFXnRLvW1xPxdduKlFksm1ld8TPSxRe8kXpd+1ntt2F2o+4c3veN+XF6kZs2o0SPzdFnVZEWbFvv5CW60YX390XZnBjB7YzfuhaxSKhH/WkvIpnFsNx7mzOkjFxjJp9SKEGjkoWRuoU68ZrICvnYTb4zU3Np54HUg6YEZhdFLoCU+TdDiKPaXtbIVbfT0rdb0gJzRRANTI/gEmyc3jzdx5CoelpYtuzbm9t9k1xkCIARp5lpZvr/LbvJqYB9ekXCDJ4OQUocqtaEYvbSaKax7DA9Om8CJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyB+ynfY2Z8jm9ldrzE17+GMquqvKWnhK4UHK+4yTCI=;
 b=Sk4h+0o5IKfspJ/f9KTnWIajn6i85bGxY7C3wViig6YBhbleWscyGWESyily0hSyw0rly9+IFY25ocUKbAGlrSYtxHw1T2LqD+O4XI0UvFsO5XcW1+78N2Asc+4zy+DpxsWWJ7UsiuVm9rhYW11Jz1BxvkcFxnJsMMjC7xCaXCE=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by PH0PR10MB4648.namprd10.prod.outlook.com (2603:10b6:510:30::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 22:32:33 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 22:32:31 +0000
Message-ID: <19a564f0-d90c-1264-ba20-dcdfec887051@oracle.com>
Date: Tue, 9 Aug 2022 15:32:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220809173542-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA1P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::25) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f71ba72-01bb-4b45-b4ea-08da7a570c72
X-MS-TrafficTypeDiagnostic: PH0PR10MB4648:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXpO8P0+vY7/r5p0tcrexw/9o7iBf418L4CPUwuycl9lvG+GBE4xenY745Hj2qHne7Y8V7c/GOn4+mJGi4c2nIuPPaVrJhil4XvSdKzq6QcaST89nRGNNXTfxbK9lueCfExcV3kDIaCj2VT8ljFVxELb0TcSjCGlMpitLuUIP/GQ+6PVu0HrAUc/uKtw3XdtZlxcsQWSvi2jUbZtcXZ/LFSVInrwuIQ7Q5wSls2gen1p8B2rltsBuVxWFaLMhNTzQ63xj+eSZB37F5ZSBjygL802p2yRa9X1fWhFUb9/Wkz6STG/0x5uzXflOu60R07LK/D7xRKPPO/tLuzisW04XGlomU7+5y+RLFxJeomq7FqF+TlcNIyOVRZ4HzGfNG+FGx2bAbIS5ZcdNbQ4TfZKQaahVtnMoY921lD9ddhxS5mi9KmZXbf4KVVFlOgNqqHw/zyTVLdThcyEaBgOAFLvAegvD/EXaHOMgX15wS2fx1rFqR6E3wsf6hh5s0hjgHrOqgevwccSm6ykN7y8FIG4br8OeG2HkWFZzVdgv81bV37P6X20D1ilYLF8TTLIA1obAPFeAhrhunxqjt3Z0F1O0XhAlVRjLFnrsJGMY0Ddq/mNh2Cjp4vL0wdBSIcslfvbx7S8kyHqxY5wUsqKVSTqnkdfOkvNC/IPf45rhrzKa8Q0/RYiHHLpIPrdmz+ehHioleD//PF9/XpY4wNO3qaKdepFS0GbsfUq+wWmVF/ESqMiF3wNg+7+eIxmv5wGKf7JJKcUtcvrPJ2iVUyVhsto3mtQI7/3vnf3pRHsPtJ/Xr2mPJQ05ZnOqpN2SHbi3Eh0Lz0h9UQElVeKOCWWdD+eRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(346002)(376002)(396003)(136003)(39860400002)(2906002)(38100700002)(6486002)(54906003)(26005)(316002)(31696002)(7416002)(41300700001)(110136005)(8676002)(83380400001)(5660300002)(66946007)(66556008)(8936002)(53546011)(478600001)(6512007)(36916002)(6666004)(6506007)(4326008)(36756003)(2616005)(186003)(66476007)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlkMndqWndCbmllc2p0eWxhVStucU9WQlRBV3drblNaU21Ua1pEOTNiK1k3?=
 =?utf-8?B?bEh6QThGTjhpQk10RlQrWEliVE53L2JWNjhodzlMeEhEMnVDbFN5L3NFUkFn?=
 =?utf-8?B?blBhWmJ0TitLalg5c200c05CVm1IczRROGQwOE9yUnlKSTNsUGRYaFAyS2Ra?=
 =?utf-8?B?TmlhZVZZelVTWHlKV0ZlQ0xsRlo0ZE11TzNuMkpPeFl5VXRieXQxeHJ2TCtr?=
 =?utf-8?B?TE5VTkxtRWk4YWE1RmppN2ZPR2oraHBUZUt3M2JEMndvcmtIY3NtRGxKMkZI?=
 =?utf-8?B?MVVHR0FmMDYvVGphUk1FeHg3WlNpUGhFdTRqczdBdjJvRHlCYWJWOWFxUVRn?=
 =?utf-8?B?NU9UNlZzWU0rRHh3Qlc5VVN2N3VUTEdnZDZxR1poQWtLUGRNNnlsV3Vva3U1?=
 =?utf-8?B?eG9ZeS9sS1ZEbWorOFkrZFNGai8xOXQ4Y2p5M2FkTUsvN3Q3aS9lS21aRzFo?=
 =?utf-8?B?OFAwTWx0UkdtNGQrQU5LR1JJWTNQcnBISFhJR3JKcWNwK2tQS0dtZlhnM2Nq?=
 =?utf-8?B?cFJxVzBzWTFSQUx0WkJrQXAzSmJHRjVCZDVGd01vaU1MakdZTWc3UXNkeWN5?=
 =?utf-8?B?OXp2bFU0T0lpbnRoYXlaTkZQcXBaaG1BcURNYk9hd1ZHb3QrV3NyTkdXaGNu?=
 =?utf-8?B?UWhyQmk0bllqMkgrcjRXUFRzbkF5dGtwZytiWTR4elFFVjVmVi9UQXk1UGh5?=
 =?utf-8?B?TGQ5NFQ1RmEyRURBY2J6b1dpSm13Mkk0YW9xSDMyOG1heHBZZmgxK2cxSVZT?=
 =?utf-8?B?SGl0alc5UTl4VU1RVEdvOHZwM1NwTjgxUE5qZGczU3lYancvWHhHN0hPaVk3?=
 =?utf-8?B?S09xSzA5YzIwMnMzenMwMHVQdTlrMHU2S1NUMVBEamYwZGhRYWNVRTJWdXU2?=
 =?utf-8?B?MFIrN2U2TTcrcG9ROVRZYko1L2Q3eTJCMkRlaWl4WFY4R2t1OXpLbVlTQmRx?=
 =?utf-8?B?OWcwbGFhd2k1NTk0LzYxRTM2Z200cTZWWXRzZ3RMeitNeEJmR3p1bGpCTVZO?=
 =?utf-8?B?V1RGWWszQThOYTNWS0FnK0lhcDYzODZSUS9JZ1ZmQTJ2YitqYUU1TmJwZUVw?=
 =?utf-8?B?Uk5mcHVVbUNOZ3pLUmdXUS9TMTNydCt4SDFNdUR4NU8wWENEWWlETGJiS0lv?=
 =?utf-8?B?MkNnbjQ5cEVnOU51N2pEUnJLdTlsOSsxdGNQUjYvSGJRdVh3ejdkWjkwbVZx?=
 =?utf-8?B?VFBISGZDNjNnQy9hSi9Jd3lNUDJqeFk0SjdEU0k3bml1MnJDN0g1R1A2UFRs?=
 =?utf-8?B?VkNWZ2hGVGxHY2ZrcXdpSUhrODM4RThrTEFOeGFVUmZWNUxZUVIrUWlUS3lv?=
 =?utf-8?B?SFhkaWhPQ1YwRXJGTnFaSG42TWhpRUc4allVWHc2dytOQkQwTVpZZnh4MEpn?=
 =?utf-8?B?VE53NTZVaklvSmRHUnQzOTcvQVo3b2FVWWp0alVSTWRDYnlHRlgwaW9yWEg4?=
 =?utf-8?B?Vi9Ob2R1ejRSSmswRXRneUwwakZlbzNOWCs3Y0RYRUdzUytOMEJkYnVUN1Vj?=
 =?utf-8?B?Tk9yVGgzQ09vbVRzVk1DS2pPM0FIc0pxSnc0eW9FaTAyT2E4emFLVlYzdUdh?=
 =?utf-8?B?QUgwWjRWTlFMRmxFdFExSFlEQmNFK29rdDJXWUtPbGkzVXI0eE9OQjNSSlVv?=
 =?utf-8?B?ekw1RFNsQXEwNWQ5ZVYxS0ZPZzJzQ0QyYVJTQkxsblB4ZVVZYkg2eEo3eExV?=
 =?utf-8?B?YklDTnFVK2hIUDBnbGkzUEFhR3R5aVpvNk1rQWhjZWRhMmhSamtEcmIwMUdD?=
 =?utf-8?B?elltRkJFRDlma3lXK1E4d1JwU3VSS0VoTjM1Q2pLL09tMFF5eCtBTFRWanRz?=
 =?utf-8?B?Z2QzL0s5SWVUcDdwamZpa2lkVythRDBmby92NU5ZbGlzcnN5dnJ4Vnk2RVRr?=
 =?utf-8?B?TnNPUFBYcHN4UjZkMFRFYWJzeG16RUxMV28yWlNtRVk0b1hHdVplOWN0WGFU?=
 =?utf-8?B?UHE5Um5wSEd0eVdTaTJJZ0p0L204SitQUHBmTzQrY2F6NXFvQ2NZWHdEWEpX?=
 =?utf-8?B?S05xMjRCQzc1cHRvckE2NDdraFlZMm4xS3hmdlBMOTRWekkvcytNUkptcVQv?=
 =?utf-8?B?NlFmUUttWUlPRUQrQ2JFR1lRVDhDMTlTNHNQMkh3YkJTcDZENXNpMFRhL2pk?=
 =?utf-8?Q?/CWvgR4WTC6oowGya5WkNDd2Q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f71ba72-01bb-4b45-b4ea-08da7a570c72
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 22:32:31.8277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Rzex55zz11suqSnYB5/daagcWLV0/+ybyL83A6mQFZNf98tFZxQGc2VJXILl01QuCbUZHi7IaE9fkv2qjFcwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090083
X-Proofpoint-ORIG-GUID: KezaSCTce5lvdzn5J4olzKE8XfdqgWH6
X-Proofpoint-GUID: KezaSCTce5lvdzn5J4olzKE8XfdqgWH6
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

CgpPbiA4LzkvMjAyMiAyOjM3IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24gVHVl
LCBBdWcgMDksIDIwMjIgYXQgMDc6MTg6MzBQTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+
Pj4gRnJvbTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+Pj4gU2VudDogVHVl
c2RheSwgQXVndXN0IDksIDIwMjIgMzowOSBQTQo+Pj4+PiBGcm9tOiBTaS1XZWkgTGl1IDxzaS13
ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCA5LCAyMDIyIDI6
MzkgUE0gQ3VycmVudGx5IGl0IGlzIG5vdC4gTm90IGEKPj4+Pj4gc2luZ2xlIHBhdGNoIG5vciB0
aGlzIHBhdGNoLCBidXQgdGhlIGNvbnRleHQgZm9yIHRoZSBldmVudHVhbCBnb2FsIGlzCj4+Pj4+
IHRvIGFsbG93IFhEUCBvbiBhIE1UVT05MDAwIGxpbmsgd2hlbiBndWVzdCB1c2VycyBpbnRlbnRp
b25hbGx5IGxvd2VyCj4+Pj4+IGRvd24gTVRVIHRvIDE1MDAuCj4+Pj4gV2hpY2ggYXBwbGljYXRp
b24gYmVuZWZpdCBieSBoYXZpbmcgYXN5bW1ldHJ5IGJ5IGxvd2VyaW5nIG10dSB0byAxNTAwCj4+
PiB0byBzZW5kIHBhY2tldHMgYnV0IHdhbnQgdG8gcmVjZWl2ZSA5SyBwYWNrZXRzPwo+PiBCZWxv
dyBkZXRhaWxzIGRvZXNu4oCZdCBhbnN3ZXIgdGhlIHF1ZXN0aW9uIG9mIGFzeW1tZXRyeS4gOikK
Pj4KPj4+IEkgdGhpbmsgdmlydGlvLW5ldCBkcml2ZXIgZG9lc24ndCBkaWZmZXJlbnRpYXRlIE1U
VSBhbmQgTVJVLCBpbiB3aGljaCBjYXNlCj4+PiB0aGUgcmVjZWl2ZSBidWZmZXIgd2lsbCBiZSBy
ZWR1Y2VkIHRvIGZpdCB0aGUgMTUwMEIgcGF5bG9hZCBzaXplIHdoZW4gbXR1IGlzCj4+PiBsb3dl
cmVkIGRvd24gdG8gMTUwMCBmcm9tIDkwMDAuCj4+IEhvdz8gRHJpdmVyIHJlZHVjZWQgdGhlIG1Y
dSB0byAxNTAwLCBzYXkgaXQgaXMgaW1wcm92ZWQgdG8gcG9zdCBidWZmZXJzIG9mIDE1MDAgYnl0
ZXMuCj4+Cj4+IERldmljZSBkb2Vzbid0IGtub3cgYWJvdXQgaXQgYmVjYXVzZSBtdHUgaW4gY29u
ZmlnIHNwYWNlIGlzIFJPIGZpZWxkLgo+PiBEZXZpY2Uga2VlcCBkcm9wcGluZyA5SyBwYWNrZXRz
IGJlY2F1c2UgYnVmZmVycyBwb3N0ZWQgYXJlIDE1MDAgYnl0ZXMuCj4+IFRoaXMgaXMgYmVjYXVz
ZSBkZXZpY2UgZm9sbG93cyB0aGUgc3BlYyAiIFRoZSBkZXZpY2UgTVVTVCBOT1QgcGFzcyByZWNl
aXZlZCBwYWNrZXRzIHRoYXQgZXhjZWVkIG10dSIuCj4KPiBUaGUgIm10dSIgaGVyZSBpcyB0aGUg
ZGV2aWNlIGNvbmZpZyBmaWVsZCwgd2hpY2ggaXMKPgo+ICAgICAgICAgIC8qIERlZmF1bHQgbWF4
aW11bSB0cmFuc21pdCB1bml0IGFkdmljZSAqLwo+Cj4gdGhlcmUgaXMgbm8gZ3VhcmFudGVlIGRl
dmljZSB3aWxsIG5vdCBnZXQgYSBiaWdnZXIgcGFja2V0Lgo+IEFuZCB0aGVyZSBpcyBubyBndWFy
YW50ZWUgc3VjaCBhIHBhY2tldCB3aWxsIGJlIGRyb3BwZWQKPiBhcyBvcHBvc2VkIHRvIHdlZGdp
bmcgdGhlIGRldmljZSBpZiB1c2Vyc3BhY2UgaW5zaXN0cyBvbgo+IGFkZGluZyBzbWFsbGVyIGJ1
ZmZlcnMuCkl0J2QgYmUgbmljZSB0byBkb2N1bWVudCB0aGlzIHJlcXVpcmVtZW50IG9yIHN0YXRl
bWVudCB0byB0aGUgc3BlYyBmb3IgCmNsYXJpdHkgcHVycG9zZS4gT3RoZXJ3aXNlIHZhcmlvdXMg
ZGV2aWNlIGltcGxlbWVudGF0aW9ucyBhcmUgaGFyZCB0byAKZm9sbG93LiBUaGUgY2FwdHVyZSBp
cyB0aGF0IHZob3N0LW5ldCBkcm9wcyBiaWdnZXIgcGFja2V0cyB3aGlsZSB0aGUgCmRyaXZlciBv
bmx5IHN1cHBsaWVkIHNtYWxsZXIgYnVmZmVycy4gVGhpcyBpcyB0aGUgc3RhdHVzIHF1bywgYW5k
IHVzZXJzIApzZWVtaW5nbHkgaGF2ZSByZWxpZWQgb24gdGhpcyBiZWhhdmlvciBmb3Igc29tZSB3
aGlsZS4KCi1TaXdlaQo+Cj4KPj4gU28sIEkgYW0gbG9zdCB3aGF0IHZpcnRpbyBuZXQgZGV2aWNl
IHVzZXIgYXBwbGljYXRpb24gaXMgdHJ5aW5nIHRvIGFjaGlldmUgYnkgc2VuZGluZyBzbWFsbGVy
IHBhY2tldHMgYW5kIGRyb3BwaW5nIGFsbCByZWNlaXZlIHBhY2tldHMuCj4+IChpdCBkb2VzbuKA
mXQgaGF2ZSBhbnkgcmVsYXRpb24gdG8gbWVyZ2VhYmxlIG9yIG90aGVyd2lzZSkuCj4KPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPiBUbyB1bnN1YnNjcmliZSwgZS1tYWlsOiB2aXJ0aW8tZGV2LXVuc3Vic2NyaWJl
QGxpc3RzLm9hc2lzLW9wZW4ub3JnCj4gRm9yIGFkZGl0aW9uYWwgY29tbWFuZHMsIGUtbWFpbDog
dmlydGlvLWRldi1oZWxwQGxpc3RzLm9hc2lzLW9wZW4ub3JnCj4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
