Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FACC25B70
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 16:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 184174EC83;
	Tue, 24 Oct 2023 16:25:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 184174EC83
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=2z+ETLb3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=SfQfqlm8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K8UoKIYmMBwL; Tue, 24 Oct 2023 16:25:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 295614853D;
	Tue, 24 Oct 2023 16:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 295614853D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F099DC0039;
	Tue, 24 Oct 2023 16:25:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19593C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 16:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E232742F04
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 16:25:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E232742F04
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=2z+ETLb3; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=SfQfqlm8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EFVyYejSuLLX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 16:25:38 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA7BA433B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 16:25:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA7BA433B7
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39OGON4j007100; Tue, 24 Oct 2023 16:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0+GDV9TlVqHP7qaj5vy2UH+XnClZbZI87/DQw7Z4oM8=;
 b=2z+ETLb3n+pksjjCMn0CM/tJa4DgZuYchTkdMJHgoQpv0FgyuTwwsTdUbjKNbTfAjGE4
 X037egp90vptvfF8TGGXTYsx7jynT8goLnlJ284suCur8LZTS0df0x94f/oRaN3gcOYT
 0n4++SFIkdhGWmQhLV6cPfxcBXpqcGcsoc1+/VfyXM6KWdGaQGrVtXny+B9tG3QTqol8
 yjX+9hOaMKQLr19SWUjA0uRawrsle+AtmMTdwL0yaEZVnDt/mz2VXRgDKCsb0UmagkZj
 ENdl5neys70mss/yfBHIJ54hsBgp7q4UoTHSg5BWCSOs3CI1K26rayMEFsaazo+fp3Bm TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6hanttb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 16:25:37 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39OGKg63031109; Tue, 24 Oct 2023 16:25:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tv53byra9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Oct 2023 16:25:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtYp8x4EDvMPMCsFlpfMwk+cl0rZ7GS3mJoRZuWNjkpch0eFZKaCWMhcQNMBw5V8ie6rI0A6RBIV49D3YLZbPoOs4AToBMav8botNfnRoqIwsTECctuV6aK/VuXL+m9DKy/8oP2l9onoE8PcWgCNp0RNwmJs8VuerddA1hWA7BFw+az5cbsLMXgwiGdB03Bujo6FrfYD4A6bOxYY7ovHL5tmtVAhzBUEMc27yGehfpyTpGBsGB5hPbQNgjpy07Q356dieRYhPmTFxD350TfrqPxJmfduhE/GD1cULFwUu2R/tTvRDuAIh3R6lB+r81ZtIwwEAl9tGP4KEjh0NOkViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+GDV9TlVqHP7qaj5vy2UH+XnClZbZI87/DQw7Z4oM8=;
 b=X80eclngbu4a62+N2xDRNc6IX22BZ1GXVIOdQrIOQJyOSlexarzFjEyMKJfcdOLjtAoA0Uhap9PaBjoCyvO7b9UwnMagq/VA3qvpOI/MNhC3Rbl0KERrF4KH/e1ZbOgrVhsI/T0awOYJ01n5KgtgJNtNdiHGOjYwpKQADJKMgR6JiS3/qN3uVC9f3NWEMWSuF70FmwnGVRg2QI0z7Or26rBVMBeHGvItXkylkcGzDOadkMmn0AntYm7U5RGuSG6vg7kmOJ0b/J6vRndZ/7jfo1KSWuqQRy2TRHkk1P+5oTQ3qtdAqltPur5shL4TISsBtTBS4tNZrCM7ASZHLpTalA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+GDV9TlVqHP7qaj5vy2UH+XnClZbZI87/DQw7Z4oM8=;
 b=SfQfqlm8JC7VXHOoY6k0/gqZfzrc4JAdu7vJNeYcs1UBFhiands7w8JEIQXHxdnKv6m0gmLx+hBUXYdvAzlaNvsPUbSC4pXI5jGtKScSK8N6hBOfWFWwyEWwGo9t9aLbUOatQxQxy5FyfyBQfj27cM4oIRb2TVWiGcKKhgWtWNY=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BY5PR10MB4131.namprd10.prod.outlook.com (2603:10b6:a03:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 16:25:34 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 16:25:34 +0000
Message-ID: <d71dc008-9920-463d-948a-0375c5754810@oracle.com>
Date: Tue, 24 Oct 2023 09:25:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] vhost-vdpa: clean iotlb map during reset for older
 userspace
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: Jason Wang <jasowang@redhat.com>
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEun7pnq5zMBH=_X+H9p_=HK6+5WHRp9A2prRe2Na-qmvQ@mail.gmail.com>
 <0ad99060-119b-4465-b611-868f693aea02@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0ad99060-119b-4465-b611-868f693aea02@oracle.com>
X-ClientProxiedBy: PH8PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:510:23c::8) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BY5PR10MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: ee211348-e545-4042-112f-08dbd4add91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRxdz4pYiNPBasQu2lHZ+TkQwyL0DX+O9QiKp3ON1a/ocBHpQqyJQM8kdto7eSP8EqB8lyhJM0WIllr2qLTG7ZN0Y1hLm5ctbTlacmiPjBEy/eldIo11ebwHQEpq0y1oCiOamGQbJvBP9Sk/2aDX/ek0owAmC5HNAy07USjuU4sOZpTrw+1I2xnU52pWyCCT7enUQUmTNaDIscJek7WnW1FzEgpORrsy1kL54HNPb5z2gG+oMBhPUnQWMXecgK1S7TXVA5i6jZZlZgOyzO+5sT/MIuEmdoQBIvj3gm4zibD3kzMX+LIGQ/8g0i7bOw1aNWr4fL2fbsrSixZHO2xpRfYRAQ8Q+21ETg12ioEuJFaZLYbjNdGkrVjLp/h5WEH68WVXTuLSEyJ0NRGrlGUC9pUbg6eyEgIrJ5oTr3auG6BXMZaZw0ICVG3GJis+zKaDJJXPgrCLq45juFVswdRrf4wdTV2XWdoboiDEDT0TxKGrJ+QCt4akBE/7Ymt58KJcDt7IEuoARVxPv99fxbdToLE4+7XxfpFoymAPh8souA/4FvZosiYk7lnf/di5/o4JHtQuGlOXpw1ag1C7VIth5xQGuxjaYZ2g4vBRAyA+IW/cRxt/3BDkYs+0sqt3JtXq30EyuFeY3vaAO3OpevqCTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(53546011)(36916002)(31696002)(31686004)(41300700001)(5660300002)(6666004)(6512007)(86362001)(6506007)(6916009)(316002)(26005)(478600001)(2616005)(36756003)(66946007)(38100700002)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVkwS3pIdTBLNUVKMnI1VjhRWXZyZlhWL1RONS9HbGNXOWptSHoxYmppSnNL?=
 =?utf-8?B?YzBHQ2VBa1hOVE16d3BTVTlVQ3lXSUdoUFB4Z3Y4UzlMK2gzYXdVbWFaS2RP?=
 =?utf-8?B?a3RRTStpRElYTnR6VXZtQ0VXckNCL0l1V1JJNTFkZ0pWZHpUYzExMFFqLzlv?=
 =?utf-8?B?M1N1ZkdnZHhnb1dlU3ppNC8yRWprRkNwRFB3NWZtWUlZNyt2a0V3SGRvTTky?=
 =?utf-8?B?ekk4NnJxQ1E2dVBybWdnN0NCaCtQUjBPZm9lYkF4SzlVQWVoMlNnajh6cWV3?=
 =?utf-8?B?Yy9GMkgwMVB1ZTIvb2Z0dXhJOGl0UGFMY1ZSQ3gvUlBmT2NvVStNS3Brc2gr?=
 =?utf-8?B?ZGlCRWZvbTFCUkpZZjZpeFVVUTBCM25VdHRMdzZhY2gyc25rbkwyQTdlQnB4?=
 =?utf-8?B?TlMxRVlFeW55UlU0N050TXdJL3d6ZmhBZmVNYml2UEJJN1dsakZ4c2JmU253?=
 =?utf-8?B?Y3Q2c0dQaVdZc3k5TnpVZzRHd2F4bTZIcEVnWUJhMi93Y3h2Z2pzdWZHL3BR?=
 =?utf-8?B?WTB4Sk1ZOXZ5Qml0K1Z3NnROdjRpT2dPeUErUHJ5ZWpjZWxzSTgwU2o1cis5?=
 =?utf-8?B?a3pCbDMvbnlxeWJobjc0bERZTEZhUzdQU3BhTzNtUkZPbWh0K3E2TzhxMnp3?=
 =?utf-8?B?TGM0N1VsT2RJbFBMbHRLVkYrbVNhTExqYURJeTNoa2pFajF5Q0ltOERTRjl2?=
 =?utf-8?B?WlNhSlVyWWFLNWNldkR4RUNURDVCYkJmVXd2Y292ZzcyMmxvMms3amhyNXg1?=
 =?utf-8?B?a0VDMmRhbEZtRm9ITFg3ZVg1dFdZSGRUTWl4ODFWRVArZUlFY0xLeWc3OTYx?=
 =?utf-8?B?QW0yNHZvNDREN0xrOHJhbERJcGxyVktpVWRHK3BqOTVpTHdoQ1pNd0J4NWVj?=
 =?utf-8?B?K0lSVEwxaXIzd2NMd1pBbUYwTXVGVFJQVUk3REErK1ZvYXB6QWkrb2NiSFJL?=
 =?utf-8?B?UVpqWmJ2TTRhc2dWYktGdDFURlRtN2V0dTRDa1NTVy9kMzhjWjVBRjJrN0hI?=
 =?utf-8?B?MXVMNzJ1TEtHWnRKRS9McUQxRDY5cmU0NmkvUTE1eG9IRzZEYVBpSXlyTFYy?=
 =?utf-8?B?TithK0lVVUZTZWV0U3p4UEpRZmlwNExiWWNVdjFmeDU3cGZkT2c4VlE5UGtY?=
 =?utf-8?B?aitlZ0JHaWs3M2xPR1k2cWVhNkQybUlGY2U0UlJKRFBWMzBJVTZFMkVuV05S?=
 =?utf-8?B?WFU0TUxOS2NNMHd2UncwMlRwcGJuYXVSd0taT203WmZuT05VNElqN3ZzUUo1?=
 =?utf-8?B?LzNjVXowUjVTQnZhVHVIQlJ6MVE4WndDRm5VVHErM0ZWVnE3REtCT2pFTVY5?=
 =?utf-8?B?WjUxVmd2Qmw0M0RnV2VZN0hkcGdvQlFUVXdLQTV5b2t6RU5KZEN1YUVnVTJP?=
 =?utf-8?B?TTZ1VmpDQkFkcXFieHFnN25zS2J3bEpCZmNLTWdFcnc3MlNqZkJ5MEFjNmJS?=
 =?utf-8?B?bk1zckx1ZVRGOEllay81TUxBRHJFVDNsQ2JZc01rZ3NNOUpGdFlucmJpTXh5?=
 =?utf-8?B?V25pc0FmcXNrZXJPOTc3Um9YSUE5dTQxNC9xMFNBTnRLcnZVMlU3NkZ6T1Vp?=
 =?utf-8?B?L2c3Ti9BYmF4Sk5mMUdURzhsUGJvbHgvazdsOWo5WDEvQnJIVE5OZHRXTFZ0?=
 =?utf-8?B?T0Y3bnlXK2FYU2VmbElTSmwxUVlZcHo3cmIxbjA0NS9WYS84RllzUkNTU2tr?=
 =?utf-8?B?M3N1R1FvT3M1dWQxdzBrZTdCcWRiRjM0MmhYOHUra0RxdktSZ3RzSHFtZ2R3?=
 =?utf-8?B?SFVPb0wwUFVoY3A0c0ZSWjh2bWdDTEVGeWlkRk1keVF1ZG9oeFJoV0hqY01N?=
 =?utf-8?B?Uy9ic241WG12eE1FaVRrL3hiZ05SZ3B0L1Z1a2t3QjlpQXV6Z0RuVHY0SWZX?=
 =?utf-8?B?V1hRL3QrTjc2OWE4ZVNHRldNWitic09LWGF2K25DeVlLOVYvc2ZFNHBhQTVk?=
 =?utf-8?B?UzFSYU5vSDMycjV0SVY2NXl3byt5K2J1Rkk4Nmx0RTJ0bkU1K0g3eEV6Vll3?=
 =?utf-8?B?bWlQcU5VSGJGVDZ0V1BVVVoyN3RBWlBqckM2Tm5oSUxYZGttVm9kVEdDTkQ3?=
 =?utf-8?B?VzViUTFwRXJsWHpqWEFOaFF6NU0xaWY1L1lNbWJWU04xdFE4RVR2cjFJZGpk?=
 =?utf-8?Q?nKxbH8dWGbcTh1WQzJOp79ioY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ntYO3BBOTv6+AXg7teHKFfFkgaKReXlZLMm89d1/Jl29dVD6YR/P06p+xxifyqQ2S0A54rNlNl/kXfWlVzxAzaXijKqZ0Zcseklpd37G89dHCY1psKKRc5UNHgCYrF+PIPB9FB9PNSPTkyrzmn3MCe9aqYno4Lv1De8X+SXJJ8jHHKOrvpzPwE8EW3k/KFGhA8M/cQqsJy430a7bZZKuGCCnFTD2zT313vCY1RByhY8aPC5E8Ia3qqsnCx/yISMc2vqQAhbwOT6xS5e7UTAo2ykLoltKxNH6wVmUhwQEHfmiqrndvk6rc3nHg8rjnhHAneALIeLlqKk5iUlIiueCzPPvy8eqTzBjwg3N1dXaHZGbocG1AlrJKvEZkgi7cTqWO5r2Zs82BQSe8BPBKYLyHuHvSlCyjKqc9aVAn831phqj1fYEbo5tEwleOWuXn05MWYHj3AJtctmZNe8/MTajRrMWsfPV9qWlBJkmUJ3lRABnwCOOBiFA1Dk8e0vG2W83Mmkl2/B/reDD6OTfYLDeGa5K84bqnHU/nqLuTPxZyhVkrK4+AfgG0NCUx6Ykap5XPVRFZhVyMFoDJsHxFpBkYaJF9V0tnaaRyYF+QBuJRNJH9TdJ+Mk65s6JKr+rVuTQ0VQ3CQ/flAnWBJPSBhl8eKQFi6cza8s0/WmUxqxCnj0Sf5ull+XKUQYMf2h95tdxIMfwZM0BqkzDpi1HCSIVLf1VUb5hVMZr5f7cykw3kS0DrZUCWZrqH3oieK5GMe3pG+ZbkMEXrzkT5tF1o9ZoiHqscr6b3spXxXh5hlz4jHwxEqDiM+f2LAQ6J21P9eZVUWYiM2oFv5ebrE0+51V3rFNPrj6j3q0nBUsqQnv4PB3yfYk0ZjC6X1rA0iuF7lvf1K+MM4UnhMGPOFqz2UdF+w==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee211348-e545-4042-112f-08dbd4add91a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:25:34.1056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZKTxUFtIus4//HVGbbue2ZY2iKxhjvWm+0bmIyMJPoumB/TN5sttmPWDkewqWY/O1CKa8EnmovzXct+fKQLJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240141
X-Proofpoint-GUID: CbyEc0uoFMfuoXClNtvcvj4sYXgJyswZ
X-Proofpoint-ORIG-GUID: CbyEc0uoFMfuoXClNtvcvj4sYXgJyswZ
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
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

CgpPbiAxMC8yNC8yMDIzIDk6MjEgQU0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4KPgo+IE9uIDEwLzIz
LzIwMjMgMTA6NDUgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+IE9uIFNhdCwgT2N0IDIxLCAyMDIz
IGF0IDU6MjjigK9QTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IAo+PiB3cm90
ZToKPj4+IFVzaW5nIC5jb21wYXRfcmVzZXQgb3AgZnJvbSB0aGUgcHJldmlvdXMgcGF0Y2gsIHRo
ZSBidWdneSAucmVzZXQKPj4+IGJlaGF2aW91ciBjYW4gYmUga2VwdCBhcy1pcyBvbiBvbGRlciB1
c2Vyc3BhY2UgYXBwcywgd2hpY2ggZG9uJ3QgYWNrIAo+Pj4gdGhlCj4+PiBJT1RMQl9QRVJTSVNU
IGJhY2tlbmQgZmVhdHVyZS4gQXMgdGhpcyBjb21wYXRpYmlsaXR5IHF1aXJrIGlzIAo+Pj4gbGlt
aXRlZCB0bwo+Pj4gdGhvc2UgZHJpdmVycyB0aGF0IHVzZWQgdG8gYmUgYnVnZ3kgaW4gdGhlIHBh
c3QsIGl0IHdvbid0IGFmZmVjdCBjaGFuZ2UKPj4+IHRoZSBiZWhhdmlvdXIgb3IgYWZmZWN0IEFC
SSBvbiB0aGUgc2V0dXBzIHdpdGggQVBJIGNvbXBsaWFudCBkcml2ZXIuCj4+Pgo+Pj4gVGhlIHNl
cGFyYXRpb24gb2YgLmNvbXBhdF9yZXNldCBmcm9tIHRoZSByZWd1bGFyIC5yZXNldCBhbGxvd3MK
Pj4+IHZob3N0LXZkcGEgYWJsZSB0byBrbm93IHdoaWNoIGRyaXZlciBoYWQgYnJva2VuIGJlaGF2
aW91ciBiZWZvcmUsIHNvIGl0Cj4+PiBjYW4gYXBwbHkgdGhlIGNvcnJlc3BvbmRpbmcgY29tcGF0
aWJpbGl0eSBxdWlyayB0byB0aGUgaW5kaXZpZHVhbCAKPj4+IGRyaXZlcgo+Pj4gd2hlbmV2ZXIg
bmVlZGVkLsKgIENvbXBhcmVkIHRvIG92ZXJsb2FkaW5nIHRoZSBleGlzdGluZyAucmVzZXQgd2l0
aAo+Pj4gZmxhZ3MsIC5jb21wYXRfcmVzZXQgd29uJ3QgY2F1c2UgYW55IGV4dHJhIGJ1cmRlbiB0
byB0aGUgaW1wbGVtZW50YXRpb24KPj4+IG9mIGV2ZXJ5IGNvbXBsaWFudCBkcml2ZXIuCj4+Pgo+
Pj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+Pj4g
LS0tCj4+PiDCoCBkcml2ZXJzL3Zob3N0L3ZkcGEuY8KgwqDCoMKgwqDCoMKgwqAgfCAxNyArKysr
KysrKysrKysrLS0tLQo+Pj4gwqAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8wqAgMiAr
LQo+Pj4gwqAgaW5jbHVkZS9saW51eC92ZHBhLmjCoMKgwqDCoMKgwqDCoMKgIHzCoCA3ICsrKysr
LS0KPj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+Pj4gaW5kZXggYWNjN2M3NGJhN2Q2Li45Y2U0MDAwMzc5M2IgMTAwNjQ0Cj4+
PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBh
LmMKPj4+IEBAIC0yMjcsMTMgKzIyNywyMiBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3Vuc2V0
dXBfdnFfaXJxKHN0cnVjdCAKPj4+IHZob3N0X3ZkcGEgKnYsIHUxNiBxaWQpCj4+PiBpcnFfYnlw
YXNzX3VucmVnaXN0ZXJfcHJvZHVjZXIoJnZxLT5jYWxsX2N0eC5wcm9kdWNlcik7Cj4+PiDCoCB9
Cj4+Pgo+Pj4gLXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZXNldChzdHJ1Y3Qgdmhvc3RfdmRwYSAq
dikKPj4+ICtzdGF0aWMgaW50IF9jb21wYXRfdmRwYV9yZXNldChzdHJ1Y3Qgdmhvc3RfdmRwYSAq
dikKPj4+IMKgIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBh
ID0gdi0+dmRwYTsKPj4+ICvCoMKgwqDCoMKgwqAgdTMyIGZsYWdzID0gMDsKPj4+Cj4+PiAtwqDC
oMKgwqDCoMKgIHYtPmluX2JhdGNoID0gMDsKPj4+ICvCoMKgwqDCoMKgwqAgZmxhZ3MgfD0gIXZo
b3N0X2JhY2tlbmRfaGFzX2ZlYXR1cmUodi0+dmRldi52cXNbMF0sCj4+PiArIFZIT1NUX0JBQ0tF
TkRfRl9JT1RMQl9QRVJTSVNUKSA/Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFZEUEFfUkVTRVRfRl9DTEVBTl9NQVAgOiAwOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoCByZXR1
cm4gdmRwYV9yZXNldCh2ZHBhLCBmbGFncyk7Cj4+PiArfQo+Pj4KPj4+IC3CoMKgwqDCoMKgwqAg
cmV0dXJuIHZkcGFfcmVzZXQodmRwYSk7Cj4+PiArc3RhdGljIGludCB2aG9zdF92ZHBhX3Jlc2V0
KHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+Pj4gK3sKPj4+ICvCoMKgwqDCoMKgwqAgdi0+aW5fYmF0
Y2ggPSAwOwo+Pj4gK8KgwqDCoMKgwqDCoCByZXR1cm4gX2NvbXBhdF92ZHBhX3Jlc2V0KHYpOwo+
Pj4gwqAgfQo+Pj4KPj4+IMKgIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfYmluZF9tbShzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdikKPj4+IEBAIC0zMTIsNyArMzIxLDcgQEAgc3RhdGljIGxvbmcgdmhvc3Rf
dmRwYV9zZXRfc3RhdHVzKHN0cnVjdCAKPj4+IHZob3N0X3ZkcGEgKnYsIHU4IF9fdXNlciAqc3Rh
dHVzcCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB2aG9zdF92ZHBhX3Vuc2V0dXBfdnFfaXJxKHYsIGkpOwo+Pj4KPj4+IMKgwqDCoMKgwqDCoMKg
wqAgaWYgKHN0YXR1cyA9PSAwKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXQgPSB2ZHBhX3Jlc2V0KHZkcGEpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0ID0gX2NvbXBhdF92ZHBhX3Jlc2V0KHYpOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHJldCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2UKPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIAo+Pj4gYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4+PiBpbmRleCAwNmNlNmQ4YzJlMDAuLjhkNjNlNTkyM2Qy
NCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPj4+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPj4+IEBAIC0xMDAsNyArMTAwLDcgQEAgc3Rh
dGljIHZvaWQgdmlydGlvX3ZkcGFfcmVzZXQoc3RydWN0IAo+Pj4gdmlydGlvX2RldmljZSAqdmRl
dikKPj4+IMKgIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBh
ID0gdmRfZ2V0X3ZkcGEodmRldik7Cj4+Pgo+Pj4gLcKgwqDCoMKgwqDCoCB2ZHBhX3Jlc2V0KHZk
cGEpOwo+Pj4gK8KgwqDCoMKgwqDCoCB2ZHBhX3Jlc2V0KHZkcGEsIDApOwo+Pj4gwqAgfQo+Pj4K
Pj4+IMKgIHN0YXRpYyBib29sIHZpcnRpb192ZHBhX25vdGlmeShzdHJ1Y3QgdmlydHF1ZXVlICp2
cSkKPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgv
dmRwYS5oCj4+PiBpbmRleCA2YjhjYmY3NTcxMmQuLmRiMTVhYzA3ZjhhNiAxMDA2NDQKPj4+IC0t
LSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+
Pj4gQEAgLTUxOSwxNCArNTE5LDE3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGRldmljZSAKPj4+
ICp2ZHBhX2dldF9kbWFfZGV2KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPj4+IMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIHZkZXYtPmRtYV9kZXY7Cj4+PiDCoCB9Cj4+Pgo+Pj4gLXN0YXRpYyBp
bmxpbmUgaW50IHZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+Pj4gK3N0YXRp
YyBpbmxpbmUgaW50IHZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MzIgZmxh
Z3MpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZp
Z19vcHMgKm9wcyA9IHZkZXYtPmNvbmZpZzsKPj4+IMKgwqDCoMKgwqDCoMKgwqAgaW50IHJldDsK
Pj4+Cj4+PiDCoMKgwqDCoMKgwqDCoMKgIGRvd25fd3JpdGUoJnZkZXYtPmNmX2xvY2spOwo+Pj4g
wqDCoMKgwqDCoMKgwqDCoCB2ZGV2LT5mZWF0dXJlc192YWxpZCA9IGZhbHNlOwo+Pj4gLcKgwqDC
oMKgwqDCoCByZXQgPSBvcHMtPnJlc2V0KHZkZXYpOwo+Pj4gK8KgwqDCoMKgwqDCoCBpZiAob3Bz
LT5jb21wYXRfcmVzZXQgJiYgZmxhZ3MpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXQgPSBvcHMtPmNvbXBhdF9yZXNldCh2ZGV2LCBmbGFncyk7Cj4+PiArwqDCoMKgwqDCoMKg
IGVsc2UKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IG9wcy0+cmVzZXQo
dmRldik7Cj4+IEluc3RlYWQgb2YgaW52ZW50aW5nIGEgbmV3IEFQSSB0aGF0IGNhcnJpZXMgdGhl
IGZsYWdzLiBUd2VhayB0aGUKPj4gZXhpc3Rpbmcgb25lIHNlZW1zIHRvIGJlIHNpbXBsZXIgYW5k
IGJldHRlcj8KPiBXZWxsLCBhcyBpbmRpY2F0ZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCB0aGlz
IGFsbG93cyB2aG9zdC12ZHBhIGJlIAo+IGFibGUgdG8ga25vdyB3aGljaCBkcml2ZXIgaGFkIGJy
b2tlbiBiZWhhdmlvciBiZWZvcmUsIHNvIGl0Cj4gY2FuIGFwcGx5IHRoZSBjb3JyZXNwb25kaW5n
IGNvbXBhdGliaWxpdHkgcXVpcmsgdG8gdGhlIGluZGl2aWR1YWwgCj4gZHJpdmVyIHdoZW4gaXQn
cyByZWFsbHkgbmVjZXNzYXJ5LiBJZiBzZW5kaW5nIGFsbCBmbGFncyAKPiB1bmNvbmRpdGlvbmFs
bHkgZG93biB0byBldmVyeSBkcml2ZXIsIGl0J3MgaGFyZCBmb3IgZHJpdmVyIHdyaXRlcnMgdG8g
Cj4gZGlzdGluZ3Vpc2ggd2hpY2ggYXJlIGNvbXBhdGliaWxpdHkgcXVpcmtzIHRoYXQgdGhleSBj
YW4gc2FmZWx5IGlnbm9yZSAKPiBhbmQgd2hpY2ggYXJlIGZlYXR1cmUgZmxhZ3MgdGhhdCBhcmUg
ZW5jb3VyYWdlZCB0byBpbXBsZW1lbnQuIEluIHRoYXQgCj4gc2Vuc2UsIGdhdGluZyBmZWF0dXJl
cyBmcm9tIGJlaW5nIHBvbGx1dGVkIGJ5IGNvbXBhdGliaWxpdHkgcXVpcmtzIAo+IHdpdGggYW4g
aW1wbGljaXQgb3AgCnMvaW1wbGljaXQvZXhwbGljaXQvCj4gd291bGQgYmUgYmV0dGVyLgo+Cj4g
UmVnYXJkcywKPiAtU2l3ZWkKPj4KPj4gQXMgY29tcGF0X3Jlc2V0KHZkZXYsIDApID09IHJlc2V0
KHZkZXYpCj4+Cj4+IFRoZW4geW91IGRvbid0IG5lZWQgdGhlIHN3aXRjaCBpbiB0aGUgcGFyZW50
IGFzIHdlbGwKPj4KPj4gK3N0YXRpYyBpbnQgdmRwYXNpbV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkcGEpCj4+ICt7Cj4+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIHZkcGFzaW1fY29tcGF0X3Jl
c2V0KHZkcGEsIDApOwo+PiArfQo+Pgo+PiBUaGFua3MKPj4KPj4KPj4+IHVwX3dyaXRlKCZ2ZGV2
LT5jZl9sb2NrKTsKPj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+IMKgIH0KPj4+
IC0tIAo+Pj4gMi4zOS4zCj4+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
