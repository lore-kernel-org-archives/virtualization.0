Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF46C28B2B
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 23:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3BD4840C7;
	Thu, 18 Aug 2022 23:20:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3BD4840C7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=3cUJVpLE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=n9nbuQGB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YemmIoa3ON80; Thu, 18 Aug 2022 23:20:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3655283E6D;
	Thu, 18 Aug 2022 23:20:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3655283E6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E632C0033;
	Thu, 18 Aug 2022 23:20:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF608C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 23:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D01A541BC0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 23:20:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D01A541BC0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=3cUJVpLE; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=n9nbuQGB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 60_exzrtegKe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 23:20:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D05C41BBB
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D05C41BBB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 23:20:43 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27INAG8m024262;
 Thu, 18 Aug 2022 23:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1Ywc5CP7SDwiMOkzJ+Sqrsgez4/sYYHE8MA0xPl2sg8=;
 b=3cUJVpLEaLETRXWGAVUHEwQCw5TjYrB401SDUZCLeTa84ifaCH6usOA6PARnf/b4bk+q
 G49a7Xmn6MEbvHo58IM0EiaOKuqPG+BJ8Hedncnz1WJ3J+2an0PXF3kVc9t8xGzrN/B3
 NO1EP/xT8kCaPauiL/cD7+TuXB/XjPqz/N/J5lQUej+S4xA2ClEnKEie0iHBmHLj4soQ
 wtAwaSAL4/9PHuLb8M6jOqjs4pA6cLHPOywlTe1CmnN+/hpTJCvbNIdnf7MpJK0P3SUc
 7Oh6D3nSjzxXX0yq0who4T0m4E50jtkcwXL/71gXOv7AuzpEDVPywHNq29xRWdPxzJ/K aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1xut00c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Aug 2022 23:20:39 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27IM06CT020799; Thu, 18 Aug 2022 23:20:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3j0c499m9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Aug 2022 23:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyisOTTtPyEykXSYjDZXGi2QAFN4q7oWEcI1wLbqNUlJXYyOOPw8x6CsXmeFuYHsLvFhPodZFV+e2kNFyeaMdGJ2t+JJ24ptVBBwWqRRBXKFPRls4cCoewQAwPej8afgJ9vOnobJ0hns2LdvGdACZli7wd5qtlqHrmTrbh/+7r3dQaprvK/M86m8OliBgEm6oqn/+U3UZDWTw/LWKcDQexpDyeRWh8L3EQdFEjIr0AvzGoz2y+xa2NghjAwJ5eScP8GW01gOY5b5wAwwCmO+U/C2/31RVrte158R8cQFFx4S1Ym93RrurTP7Vt4rN5DSbtNTLVvAIzVgdllM9OChVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ywc5CP7SDwiMOkzJ+Sqrsgez4/sYYHE8MA0xPl2sg8=;
 b=dRrQOY8w3BAGnQl4TIzHJ7RVg7GSpbv7RlXA2UIH2tcVeg4BGvDTkg9lRAkKPqbZpH7zOprQvNngq3YS8CTScI/fOWG2/HihdWDX11P90cxWR/J7K7vAyP9XB/dp3TDfaEpfu1coF7S0L/F2IEmXSLBZw0M+UwVqwVdLXc7yOZtCOBK5F2+Pc7HnJEw/9g2Z+F6FQNLbskbLHsyDXOcrbqIm5pKrVZIlXKG8aUtPAFeBQsihnzy7p3EnempVJsjkN07cNh0LMbUARhzorVh/UvaffjZxoIWtGQ4j10Ag5SKf/GdLONFsBFpqLcSZpcQVe8d+cxsaToDZcQOXJ6ngPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ywc5CP7SDwiMOkzJ+Sqrsgez4/sYYHE8MA0xPl2sg8=;
 b=n9nbuQGBcHFgMjR4fAvttPprSv/FkGw8gMq8O5VVxql+NY5OVpHGjeeeVUAiG6ATJXajuN649VmhxpWKw12U5jyEg7oNk+N7swxk9KvUUndMHKpWRyjKqry46CKN83eBBgsInFrtHO1Ye0kq7ZOngHel9Mn3fOcU9USNuSvvM5o=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by CY4PR1001MB2183.namprd10.prod.outlook.com (2603:10b6:910:42::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 18 Aug
 2022 23:20:35 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Thu, 18 Aug 2022
 23:20:35 +0000
Message-ID: <f0b6ea5c-1783-96d2-2d9f-e5cf726b0fc0@oracle.com>
Date: Thu, 18 Aug 2022 16:20:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] vDPA: conditionally read fields in virtio-net dev
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Zhu, Lingshan" <lingshan.zhu@intel.com>
References: <c5075d3d-9d2c-2716-1cbf-cede49e2d66f@oracle.com>
 <20e92551-a639-ec13-3d9c-13bb215422e1@intel.com>
 <9b6292f3-9bd5-ecd8-5e42-cd5d12f036e7@oracle.com>
 <22e0236f-b556-c6a8-0043-b39b02928fd6@intel.com>
 <892b39d6-85f8-bff5-030d-e21288975572@oracle.com>
 <52a47bc7-bf26-b8f9-257f-7dc5cea66d23@intel.com>
 <20220817045406-mutt-send-email-mst@kernel.org>
 <a91fa479-d1cc-a2d6-0821-93386069a2c1@intel.com>
 <20220817053821-mutt-send-email-mst@kernel.org>
 <449c2fb2-3920-7bf9-8c5c-a68456dfea76@intel.com>
 <20220817063450-mutt-send-email-mst@kernel.org>
 <54aa5a5c-69e2-d372-3e0c-b87f595d213c@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <54aa5a5c-69e2-d372-3e0c-b87f595d213c@redhat.com>
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f02456a-82a3-4650-c9fa-08da817040f3
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2183:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xt7FGrNHC2nldznkiRRHm6lw0HpJCpa7v910VQwBhD7gJSD/gv2cvC/8hnCiLL6XZdsAAyDGwPVULpVc9OVARzluKUSYOfHH/uHZ3OCqxOPifHIR0tClRRseRqS/YX9HQp3udIY9p46c2xTfATI8vch7kFZZvfgFvMBGwLtcYtseTk/6uCDi56xj+B6kung74wmi/RO07DQ+97WhsCfJaGrq3vjLo3xhKySGs4au1LIUR0ZXyTCoxltP0xWTTioqd1s9Ztsisaw89JrQTU1cY1jFKuJFPUN+4L6RuHOTrYciVP9lXsfgyPwrYC2eGrNZoufIT9yACL8D0aOnGmU365JwwBCnp7JvLpCIk0R73z46Eye5qhB3/8/K4c2g9vgD0+0WhMjJytS41HnMg6xmIuFbaCBd1I356kcugFEE0mcI+SBp+zfXnEu/gzbmlzKd8cISVrS3QbVK3j+9DajYeglF5KvEsX88+T6hjSi1vHGwEFN9lgdXoTFPiug+MiUwhHTrXX1rsDtpFd2Wyxe00gd8hcnlFq6GRhov2IE2BLB5S4seZD32gauuWENO/AR0dWwQlniDJvuPc0NNu0TUDs6UEUbINReyjF6maEZwMknmGqD9nZj/xxLj5lv7pi4StDAhQR0GXYeMmXw994yid1z3JTdeI0nyY/15PNbivbucyxMErl4RvsH1hHVktvQJitssMNkXAOLjbbfc2spKWwnW2yM/Jtnd1vWKnDGSonVpmtusIeScr1DWhUR0M/Ol5QIlsSp5sQnvXS/OP/gGUd0Q4TYW5N5lVKnCOpw8Db8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(346002)(366004)(376002)(39860400002)(136003)(38100700002)(36756003)(110136005)(31686004)(316002)(26005)(6506007)(5660300002)(36916002)(8936002)(2906002)(83380400001)(8676002)(66946007)(66556008)(6666004)(66476007)(6512007)(41300700001)(4326008)(478600001)(2616005)(6486002)(186003)(53546011)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlNTSlhnbFBYVFpYNThRTXBKUUR2Y1FDYUVaMFpRWDhCZ2JzZmZaWDR0dElH?=
 =?utf-8?B?dGNieFdkK1YwbHAxSkNxVmJrNWJDTDVNOUVGSlVNZC9IVVJKams4S2dmYlk4?=
 =?utf-8?B?bkZncnd3S2tvam1pelBTcTZvcEdmbTNObWVzUWg4MG1MeTNLQkFpVTE5NkFZ?=
 =?utf-8?B?ZERlZ0hIQjB3bFRmaFZCY1pBVkFlanRlUE1nSWRpVXpkam0yZWxWaUw4V21n?=
 =?utf-8?B?KytMUml4Sm93YksvWVJBTVBRWjUxdU9jK25KNnIyWW1Xck10SVQvSk5OVXlP?=
 =?utf-8?B?cW90Zzd5bk9pei9wQUZNVVJabG5uWGlJV0Y3blFDSVF4SURCb0IxTWFMWmVj?=
 =?utf-8?B?U0ovYWEvOGNaMllWUS9SVHVMUjN1RWNoTGpsNzN6MUxNdERQQ1ljVFBEcmFa?=
 =?utf-8?B?TlRjWWI0Q1FadVF5c1BvcTgvK2s5WndkcG9uY0hjRkRhSDViajN6MzE3c245?=
 =?utf-8?B?NXl3ZVZkS2k2d2tHYjZ6MnhhRzJBR25xY2ZqcjkveCszQ0RWaGVLeE9aUkZ5?=
 =?utf-8?B?MFYrZ1E1bVBpOEViMWZZbFBUb1ZpN0xkd2ZLdUJIUmxsSXNXbTNtRzZYMGNq?=
 =?utf-8?B?UTFXbkwyMVZRRDd5N1p4UkkzSHI4WmordGdZWVBJNjVTREdGdzJTTmFoSFFD?=
 =?utf-8?B?U1htODVzdjJlcThxU25vVU5vOGMxQ090R2Y1R09LVHM4S2xqMGFoTXd6M1hu?=
 =?utf-8?B?YXpZWFJmK1VMQ2xHMGg5aHFvdDZoaEtrOUdjYzJnc3FUSGplcVFEQWNMWGZu?=
 =?utf-8?B?SlIwVXFUbmp3TTdndHpad0lBeWFIZXdQSGNQMUpPMER1czRuVmJsK3V0OTJk?=
 =?utf-8?B?L0VMS0tDcUlQSjRlMEpYbWJYa0pJZWxlZS9zTktXclE0SHV4UE5VSUR0Q0pq?=
 =?utf-8?B?dERvMG9LZVlyQm4ycG44Z0E2NDlmbEVyNjNBK1pUY0pCaGNaRlVIdjFoQVZU?=
 =?utf-8?B?aFlndVIzNTlZd3ZZQ01lblpkK0NLRWVCc3U1Z0ZSOTBWNUZBeUJURm9aNnJa?=
 =?utf-8?B?bUl3UEcwWXZpVUU4MVZJRG9id05NREUrV0hLOEs4OEtJL3cxTjVtdUxDUEFk?=
 =?utf-8?B?ZU1BMWFybGxkSkNlVkh6bGJ5TGxuNHdJSlhKWEJEWXYrV0NrZUZLNk1zWjhZ?=
 =?utf-8?B?MHp1NU9hZlRxZjgyMS80WkZlUlBNeGNLcWljL0VKbk9JNlVPa0NuVjdXMEF5?=
 =?utf-8?B?K3JoaWl4cG1KQmRNQm14NThpOUlNbVJGU0xxaXBPNCtxNTRUTERGNjVwcFZl?=
 =?utf-8?B?Y1dGaU1CNTd2U3FTcHpSSHR2S3JGR0U3WjFsSjNLWlR6L1U2Z3liOXpEa2p3?=
 =?utf-8?B?aFh4clJHVmRDaHBMaUYrTnJJQjZYSGRjQU9LL25YMmJzZVByTEo1YkFncEhC?=
 =?utf-8?B?ZDlPOVZ5T25kNmY1UlpKQjJNK25sUmlxL3c1OEFxNjgwV0hjb2RacjE4dXZN?=
 =?utf-8?B?OURpa2JYUjBIRDc5Y25XdHV3Q1ZaTnYwTHVML3l0bVdsb1JVbFVsRXpKZ0d6?=
 =?utf-8?B?QndZM0NjTlNteUJycmpJV1lnRXRpMmdNNWlIRFBLdXd5VWlMb2xmQ25RUkVh?=
 =?utf-8?B?OUpURUJFTlc2VVhmSmtJYm92TnBCV2xlU2FGbUViaytqOXVMR2hGNmx0UjFK?=
 =?utf-8?B?Rjl4TnV0YTR1VWNsaGs4aThwNERJb1EvSS9KRG80a2l0MTFGQlNBSHdxdEsv?=
 =?utf-8?B?L0RjUGJSRHBUTGZ4N2UyakNzTmV3SXpQZ2NLa29hMEhuT3JhSDBqa0hMRC9K?=
 =?utf-8?B?Y29aN01Nd2ZzTjY5V2FSOVB4NWtMWkI2Z3JiSVdzeFBnMDJ5cGxzT3JubGNh?=
 =?utf-8?B?UGZ5QzR5REkzMWRDL2ZhMzdFRStHR0tqRmY4VzhWYnYwYXh6K2FydUFrcEky?=
 =?utf-8?B?bXZ5eHlheHVISHhOWnRjSkY5UnNVckxaMVVZcCtLLzFGQ0drTWgwN0xlKzdZ?=
 =?utf-8?B?ZTFpTEkyTFUzNFRvd2l2V0UwamFaTUY1VEJaR2RKSU5LME5kdGZkSWJ2ZFUw?=
 =?utf-8?B?dTY5Nm9IOU5BMGtGMElOMllpckV6TFh3UkhGa2NCRXRBaGQrbURsb1duL0NH?=
 =?utf-8?B?SzF2NW1Mc1RJUXJJOENkMXQwclJPcUFMaG9UeDhLTlZOMDRsUmtHdnFhaTlV?=
 =?utf-8?Q?hwYv9PLqNxphlxYXHlshCf/Ns?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M2h0ZzdFVGpTbkM2SDNpUklTSmNjU3lGbjB4b3M0SnI4eGFkRkZWYmRlNUw4?=
 =?utf-8?B?SFZkSkl0VlhQM3hXcW0xNnlyakJuUEM4RllJOXBnZW45YmNucS9DWjhoWHdB?=
 =?utf-8?B?YjBUMGs5THNGL0hHK0hZN3k3QTgvTGFwMytlMEorL0VBdzZpZVUzUldScHhs?=
 =?utf-8?B?Z1ZuVStsZkE3WXdqUEFGL0FQNkRxd2xZRkhGSjg2S1VBdUlxNnNKR1lpZFVx?=
 =?utf-8?B?NzNHTk9aRG94MnBBZ05VbHU4a1ByWFE5L1lvU0EyNWRmSTRjNEh2SFEyTjZu?=
 =?utf-8?B?dTVPc24wSkR4Z29JVnRpODBlTXJSY3NBTmRPWkxPVnZsb3VoV3JxdHl5aDR6?=
 =?utf-8?B?K3prRVAxU0w1R21mbEdISzl3SlJIc2I5R2lrNjE5TTVpQzliaTFxTnZvb3pK?=
 =?utf-8?B?OVhiQ04vemN0M3NFc0hjOEZ1aG0ydFpocVF5YUpPK3pQdmQxNkhYV1BPdHJn?=
 =?utf-8?B?Uk1RZk5yRlJCeUVVM2JGeUsrNUtrcS9kd0pnZDdrL1poTG1xZHZSeWhJNGpx?=
 =?utf-8?B?eVljbDVERHQzdTRPVTNQeUlhNEJ3VmVJb3ZGUjJnaEJacmlRZFFEYUwxcStX?=
 =?utf-8?B?SmhWaFRpSnFaNGp5dU0rd1dROWNIV1ZIbFNHU0dyRUtscUx5ZzZpTkNXUVFz?=
 =?utf-8?B?WENxc3gzL3QveldtdnN0dThoWUJwK1JVQ3Q3RlZ1MlZhMjVOUnhCQ256VGgx?=
 =?utf-8?B?SnZpUXBmM3JSeU5sRjBRY0p0Y1dnMGk2TDlTTzJFa1llQUFUNlg0KzhtbHln?=
 =?utf-8?B?UXQvSUhPM3c4SFFBR00xUE1ZSE5pbytPaVRVaTI5MkZLdDJpOVg3ZER3ZnRK?=
 =?utf-8?B?VjVka1lKdzVvL2FCQWJsWG44QTc4SkR2cmw5MEV5STdIVWxlaUI0S2Q0OS96?=
 =?utf-8?B?UzFrK1ZNTVBzSEpQT2VKampXQ3JBQ25nSE54aU1oNWkzc0dpUDRHZmwyTjk3?=
 =?utf-8?B?cUdYOUJTRDNqazZLZzNoYXJXK2ZSNW0wYXc2RXdMYTFsODdqWklBdi9vem5M?=
 =?utf-8?B?VlpuL2N5UWFYR3ROQmFncytqcngzNm1KaUdYR2FqRXF3WWVXUmJ6cGg1M1JE?=
 =?utf-8?B?RFE1SDVodU4wWmxLSmE5UGJqMW9jRHRCMDhwN3dJQWV6MUthOUk4VS9kNDJQ?=
 =?utf-8?B?SjVLOHVyb3NRcXZxZkNTbzlEUmk5NU1DN2ZLVlUvRGpxanliS1NuNTNJY0FO?=
 =?utf-8?B?UHZUclYwYzVPRk1ha2g0RGZqQUg4dzRzeE8wNDcrVjNyenVLdHgvUFNVa2pK?=
 =?utf-8?B?eHluYWpHNzluVzJsQVcrdmNQaWpIajk0RFpOd0F1eUpXWTVrYzhpaVFTbnJU?=
 =?utf-8?B?R2F0LzVqeWdCL1pjRHpIVnphWkJjaG1GQUN3emJCOWhiNmdTcWgvZnpqanBB?=
 =?utf-8?B?UVdLLzVnb3hHWjN0alZLdmQ5bzhsM21YRUIveFY3VWNjcFZsYm83Z29nak5p?=
 =?utf-8?B?dHBNOCtWaXZSNFg3dEpId0xJMmtES1lFd2R4RS9iZDlCTTNNNTdYeEFLNWtr?=
 =?utf-8?B?dFNKYlY1M1JMQmJtK0V0a3pGQXBWNHRVVmpPVlhiTm1TKzcydVhidmROMHRK?=
 =?utf-8?Q?MUHROg9/g1yr1WEgweGahp0RLTCZcLRZeXLukdyhZ5JR43?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f02456a-82a3-4650-c9fa-08da817040f3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 23:20:35.3947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dEExckZk1IweTUlgQ4oV4ZV1fze2Qs69PAj3qH4CRZKaYjAN/x4P2AKqdAh9ZGnZt9DEJkr4v/2m+9jciEHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_16,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180085
X-Proofpoint-ORIG-GUID: bC9786wraePRAQ6JbIVuoa_lV9r7arYn
X-Proofpoint-GUID: bC9786wraePRAQ6JbIVuoa_lV9r7arYn
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@amd.com
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

CgpPbiA4LzE3LzIwMjIgOToxNSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IOWcqCAyMDIyLzgv
MTcgMTg6MzcsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4+IE9uIFdlZCwgQXVnIDE3LCAy
MDIyIGF0IDA1OjQzOjIyUE0gKzA4MDAsIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4+Pgo+Pj4gT24g
OC8xNy8yMDIyIDU6MzkgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+PiBPbiBXZWQs
IEF1ZyAxNywgMjAyMiBhdCAwNToxMzo1OVBNICswODAwLCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+
Pj4+PiBPbiA4LzE3LzIwMjIgNDo1NSBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+
Pj4gT24gV2VkLCBBdWcgMTcsIDIwMjIgYXQgMTA6MTQ6MjZBTSArMDgwMCwgWmh1LCBMaW5nc2hh
biB3cm90ZToKPj4+Pj4+PiBZZXMgaXQgaXMgYSBsaXR0bGUgbWVzc3ksIGFuZCB3ZSBjYW4gbm90
IGNoZWNrIF9GX1ZFUlNJT05fMSAKPj4+Pj4+PiBiZWNhdXNlIG9mCj4+Pj4+Pj4gdHJhbnNpdGlv
bmFsIGRldmljZXMsIHNvIG1heWJlIHRoaXMgaXMgdGhlIGJlc3Qgd2UgY2FuIGRvIGZvciBub3cK
Pj4+Pj4+IEkgdGhpbmsgdmhvc3QgZ2VuZXJhbGx5IG5lZWRzIGFuIEFQSSB0byBkZWNsYXJlIGNv
bmZpZyBzcGFjZSAKPj4+Pj4+IGVuZGlhbi1uZXNzCj4+Pj4+PiB0byBrZXJuZWwuIHZkcGEgY2Fu
IHJldXNlIHRoYXQgdG9vIHRoZW4uCj4+Pj4+IFllcywgSSByZW1lbWJlciB5b3UgaGF2ZSBtZW50
aW9uZWQgc29tZSBJT0NUTCB0byBzZXQgdGhlIGVuZGlhbi1uZXNzLAo+Pj4+PiBmb3IgdkRQQSwg
SSB0aGluayBvbmx5IHRoZSB2ZW5kb3IgZHJpdmVyIGtub3dzIHRoZSBlbmRpYW4sCj4+Pj4+IHNv
IHdlIG1heSBuZWVkIGEgbmV3IGZ1bmN0aW9uIHZkcGFfb3BzLT5nZXRfZW5kaWFuKCkuCj4+Pj4+
IEluIHRoZSBsYXN0IHRocmVhZCwgd2Ugc2F5IG1heWJlIGl0J3MgYmV0dGVyIHRvIGFkZCBhIGNv
bW1lbnQgZm9yIAo+Pj4+PiBub3cuCj4+Pj4+IEJ1dCBpZiB5b3UgdGhpbmsgd2Ugc2hvdWxkIGFk
ZCBhIHZkcGFfb3BzLT5nZXRfZW5kaWFuKCksIEkgY2FuIHdvcmsKPj4+Pj4gb24gaXQgZm9yIHN1
cmUhCj4+Pj4+Cj4+Pj4+IFRoYW5rcwo+Pj4+PiBaaHUgTGluZ3NoYW4KPj4+PiBJIHRoaW5rIFFF
TVUgaGFzIHRvIHNldCBlbmRpYW4tbmVzcy4gTm8gb25lIGVsc2Uga25vd3MuCj4+PiBZZXMsIGZv
ciBTVyBiYXNlZCB2aG9zdCBpdCBpcyB0cnVlLiBCdXQgZm9yIEhXIHZEUEEsIG9ubHkKPj4+IHRo
ZSBkZXZpY2UgJiBkcml2ZXIga25vd3MgdGhlIGVuZGlhbiwgSSB0aGluayB3ZSBjYW4gbm90Cj4+
PiAic2V0IiBhIGhhcmR3YXJlJ3MgZW5kaWFuLgo+PiBRRU1VIGtub3dzIHRoZSBndWVzdCBlbmRp
YW4tbmVzcyBhbmQgaXQga25vd3MgdGhhdAo+PiBkZXZpY2UgaXMgYWNjZXNzZWQgdGhyb3VnaCB0
aGUgbGVnYWN5IGludGVyZmFjZS4KPj4gSXQgY2FuIGFjY29yZGluZ2x5IHNlbmQgZW5kaWFuLW5l
c3MgdG8gdGhlIGtlcm5lbCBhbmQKPj4ga2VybmVsIGNhbiBwcm9wYWdhdGUgaXQgdG8gdGhlIGRy
aXZlci4KPgo+Cj4gSSB3b25kZXIgaWYgd2UgY2FuIHNpbXBseSBmb3JjZSBMRSBhbmQgdGhlbiBR
ZW11IGNhbiBkbyB0aGUgZW5kaWFuIAo+IGNvbnZlcnNpb24/CmNvbnZlcnQgZnJvbSBMRSBmb3Ig
Y29uZmlnIHNwYWNlIGZpZWxkcyBvbmx5LCBvciBRRU1VIGhhcyB0byBmb3JjZWZ1bGx5IAptZWRp
YXRlIGFuZCBjb3ZlcnQgZW5kaWFubmVzcyBmb3IgYWxsIGRldmljZSBtZW1vcnkgYWNjZXNzIGlu
Y2x1ZGluZyAKZXZlbiB0aGUgZGF0YXBhdGggKGZpZWxkcyBpbiBkZXNjcmlwdG9yIGFuZCBhdmFp
bC91c2VkIHJpbmdzKT8gSSBob3BlIAppdCdzIG5vdCB0aGUgbGF0dGVyLCBvdGhlcndpc2UgaXQg
bG9zZXMgdGhlIHBvaW50IHRvIHVzZSB2RFBBIGZvciAKZGF0YXBhdGggYWNjZWxlcmF0aW9uLgoK
RXZlbiBpZiBpdHMgdGhlIGZvcm1lciwgaXQncyBhIGxpdHRsZSB3ZWlyZCBmb3IgdmVuZG9yIGRl
dmljZSB0byAKaW1wbGVtZW50IGEgTEUgY29uZmlnIHNwYWNlIHdpdGggQkUgcmluZyBsYXlvdXQs
IGFsdGhvdWdoIHN0aWxsIHBvc3NpYmxlLi4uCgotU2l3ZWkKPgo+IFRoYW5rcwo+Cj4KPj4KPj4+
IFNvIGlmIHlvdSB0aGluayB3ZSBzaG91bGQgYWRkIGEgdmRwYV9vcHMtPmdldF9lbmRpYW4oKSwK
Pj4+IEkgd2lsbCBkcm9wIHRoZXNlIGNvbW1lbnRzIGluIHRoZSBuZXh0IHZlcnNpb24gb2YKPj4+
IHNlcmllcywgYW5kIHdvcmsgb24gYSBuZXcgcGF0Y2ggZm9yIGdldF9lbmRpYW4oKS4KPj4+Cj4+
PiBUaGFua3MsCj4+PiBaaHUgTGluZ3NoYW4KPj4gR3Vlc3RzIGRvbid0IGdldCBlbmRpYW4tbmVz
cyBmcm9tIGRldmljZXMgc28gdGhpcyBzZWVtcyBwb2ludGxlc3MuCj4+Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
