Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6080BC3F6B0
	for <virtualization@archiver.kernel.org>; Wed,  3 Aug 2022 23:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF48581C2F;
	Wed,  3 Aug 2022 23:09:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF48581C2F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=nkovEJ95;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=H/wuJHis
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JFznSVHmIyAq; Wed,  3 Aug 2022 23:09:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 97F71813F6;
	Wed,  3 Aug 2022 23:09:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97F71813F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57E3EC0033;
	Wed,  3 Aug 2022 23:09:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24027C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 23:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DDF8281437
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 23:09:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDF8281437
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7W7IEAEYnNrO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 23:09:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7427813F6
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7427813F6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 23:09:36 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273Mw6Nh028788;
 Wed, 3 Aug 2022 23:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jZHsXrjZLfkioqyWIuFCQPHm98h1eKrfqXQbJze4UGI=;
 b=nkovEJ95d2UkKsKVUySxjOaFgMKUmfHlBoV9Dx0rRwVkEMKCSWCE9jglqK8Vh2WBASse
 RiMBaX9K4tJHS2nOISDV327ThG+cOwVqO0eQUDC0ZtsvHNJA4lB8do+z3zt0U2rqxoqW
 dLvbk8IWkOdumsdhNlZlvuYmUvFVVzQtGz4zSkpyODjner1Twy2qg4uMaGCdpkF7d0uO
 JzKeHTYcf8Mk2uZ7ixYoljNfTr3PPed9iR2nSD9wTlOmzdeMvUhWrZAGDf6xP/AjDf1D
 vZCng61+ouFNjP9gbjc9a75fWUj9hOggdDiXcAi1Rv86BiUarZFxz8oSDIgtnhCG+CbP 9w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2uhnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Aug 2022 23:09:32 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 273M25TO010784; Wed, 3 Aug 2022 23:09:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hmu33psrg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Aug 2022 23:09:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgoAubL21Ofbey9gy2DqoE/LFmN53UGbTrvvlnACh1+HNbw9yyc0yv68PpA6Rh8S6kNkmR/TWlaImY11CCrwjCUILAGDmHrqi1yoYi7SVJD2hFoRsE7R61s6SjOSfhMqdwEvpx1IQZt2NSprE7GICfE+UVab1Dq32ApCXBQqwU2Q+EEZtgKgid8Q0NcqD/aSuM3HmtF4JXadD9bCFN+KKVDDyYkAGuTmLs9afwpJf11KwpO8UrD05bO1Ar5RVsSp7fbWzLLk314UyuZxQAcvIsSlGP4QpcrSoJRASxDnEUnuBh+8VPRZJmyDhiRwz55HkVHHZNlFUzKEN4nbmSDBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZHsXrjZLfkioqyWIuFCQPHm98h1eKrfqXQbJze4UGI=;
 b=k6y21IiIqiWPugFloaP58sHkqy4YpLw8i55ZY5LU+Xij6EUrEacc29hZVvyQfxgt26VlWoUzjTzb5+HnlnWQ4YU73kWXo5P4neO2VqWrhhcuyUGrMdyp7uhRzVLQdmBo/iD61lpmqmRqb9807q8nXFfsndn9TCvUAx+GqH7Ynb5DF1SsH1PnK/wXY/irB5BG15k0dIoJ+62oFuSWyrNQTeo9+ZwvPmmOjZbjt0nXpnx6M+9GWXfby1WPBW4qkRWzWZwVFUWcrPpKM5mw9XJRiITF8jyRqoQcUC83NdBRNIDDMuIt7FHmQfhs1OtrJIuUvr8T67Zbbc0c6OkmPuiQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZHsXrjZLfkioqyWIuFCQPHm98h1eKrfqXQbJze4UGI=;
 b=H/wuJHis8x61yyRSC8s7XyIkXSP5ZfQauCR7yx4mbC6yCKvYeIi3E9KpFJWJDeoVx02pB1RLH2YieoB7lxoPZNMdHGk183eYt6N82v+8MOBXK3XQwwaJknrNQ8E4Qert7d+Ac7t4ho+ML9lmlpxxOjbLdCnzHCdLkIijFHLsaVA=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by PH0PR10MB5705.namprd10.prod.outlook.com (2603:10b6:510:146::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 23:09:28 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 23:09:28 +0000
Message-ID: <73b17906-fb89-5d92-ca31-ca21652b8335@oracle.com>
Date: Wed, 3 Aug 2022 16:09:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
 <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
 <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
 <00e2e07e-1a2e-7af8-a060-cc9034e0d33f@intel.com>
 <b58dba25-3258-d600-ea06-879094639852@oracle.com>
 <c143e2da-208e-b046-9b8f-1780f75ed3e6@intel.com>
 <454bdf1b-daa1-aa67-2b8c-bc15351c1851@oracle.com>
 <f1c56fd6-7fa1-c2b8-83f4-4f0d68de86f4@redhat.com>
 <ec302cd4-3791-d648-aa00-28b1e97d75e7@oracle.com>
 <c77aa133-54ad-1578-aae3-031432cc9b36@oracle.com>
 <CACGkMEuUVicQX87PDCO87pckAg5EMQ9OGura2J35DaR0T=COfw@mail.gmail.com>
 <a2b2fe74-4633-2911-b953-25fcb8e81665@oracle.com>
 <213dec42-bd3d-2b5c-9003-276bc2a9f649@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <213dec42-bd3d-2b5c-9003-276bc2a9f649@intel.com>
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87cec100-d1b0-423d-bbcf-08da75a536f8
X-MS-TrafficTypeDiagnostic: PH0PR10MB5705:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4n9VTSr7wrLMKYWS8DIGvcjKrbcR20m6SK7CBRxpExXF/ODTOD/8RA62th1bcTV21GIMwfQb3n/1pXhtib3DS55H+XigF0trsqqqzuBirriBZdB+VI9CFOrExu0nkUb18vR4T1KhEjv/COz+pQc4yC2+m0LC5o5PjP4qGqvFqWtjwi5FBc5cuM8BRJOQlL1SD5Y9qhCgQeI6Q7ho7caprXwl3+bQiCHIFf2TVk665E4AjNaZJFD1f4PrsXVefQvwsfbariMbOkzkJmOyC2+7OtbcPN8R6ouB4ZoEsxoXpL5XfxnpHefQxWnpgU8g5aCfssiM4zNeSUGOTcAGSZm4Nx2vpS3sP5A7SJZ2ocHSbN48AJrT7gaQEj/rPSvVpOQr5TRDXL4G6QKb/RFGOaEwl2K/upolMIs7LrVseNoD7p8tlIpBEY70yA5GKWB5H0uIQfKZxzcN885JE5trlR9j1B9EgjDzeOzkfDp7FH+FMSx9amlUMyCxdY1KKiEYMMEe/23U3tT5PSrmgYM3EMrFp3KOolmKBTcVYrFVU9z/9CS67DHGQnPjXUT0H6yI0Psfp3X0bSEOM9Yf3e7JMuAbgG0CHswZ6jJXPTnEb87esifSqAbEsCCGljuwmzYIp2roa2U0Xal2C08D+1T+1n5bzUztDWEVcTkGG1hgUGKMHixYZ7zlFgjxRlOEcHf4b//ELXAIzDHS7uU4H6GnqMHlpjDhOeW2IDe/Rw+LQskaZ48P2TsdMCAUE27qnVGPLydg0grr8eAMWCAHRGyZEtYMoLG/ktmyYyw2JdMp/rxV8YAIgo2JWjCpGrqtcMb8t+umNhox2tVadU8KaRYfOGwCUcZt/C98fTkFT6RSuXRUKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(376002)(39860400002)(366004)(396003)(136003)(86362001)(31686004)(36756003)(30864003)(83380400001)(478600001)(31696002)(41300700001)(6666004)(6486002)(110136005)(966005)(8936002)(2906002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(316002)(2616005)(5660300002)(6506007)(36916002)(6512007)(53546011)(38100700002)(186003)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnpheGpiQ2YwMnJlbjNMRks3bzEzMURjZDFsQ242NHhIUGxFMmw0UDgydTc4?=
 =?utf-8?B?akR3dTdIaHRKQVZCWEI3ZXRaQmV2Slh5T2kvRWlsNWhZSlRxaDkyMDlpTWxw?=
 =?utf-8?B?bkEyL21FMTZxOEdHVjhLeS9Mc3Q1TlZkUGFxclY4a3lhK2Q4cFJBQzBhTVhz?=
 =?utf-8?B?Rmh3RzVIUndlTDF4bDc1NHRYbnpqYmVuZjUzRDVULzBlY1lKRWR4Ky9Db1Np?=
 =?utf-8?B?UzV0ZythR0t1QVViSUpYM2NZajYyWFVGYVlJZDVHYmordStQWWFIY0kyUDVz?=
 =?utf-8?B?N3RWVm9aZzR4L2RwWGNhRVg2aDNxaGlWUGRwTkp0ZGx3SHQ5aWpQRDAyejFi?=
 =?utf-8?B?ajVJcEo3MHlmVTE0U0d0ME94Y1drcVlxdGZqZXlBSFZsQ0JuVUt4c01Ja3pP?=
 =?utf-8?B?OU9mUzJ2cVlRQTBSQmhaYmkybHZ0MldGRkJSbkxLbWwxSndhQ2IyV2w2MmZn?=
 =?utf-8?B?WmZxMVBYN0pyNmswRVFnT1BLYVNVenRsZi9LNHRBU1ZqQzhkcElUK0ZiVUcr?=
 =?utf-8?B?cmdGemEzNTNwRkNJb2JQRTRCSGhCbDVXbm1GUFlQMWhUc0VadGwxS3lRQ2Fl?=
 =?utf-8?B?S29nV3ZtK1JnU1UrY2h6V2JMSGM2akFZdnpUZGxRK2tUckQxeWRtTE82RnMz?=
 =?utf-8?B?NUZPVnBzSlVva1F3MEIvMTlIa29MT0E1NDBTOVh5YnFFV1NVR3d5UkFzaVZT?=
 =?utf-8?B?M0hqQ245WlJLd2d1Smk0enlxaW5CdWt5dlBpa0Zhblk5T3V6TG40VHBMaXhX?=
 =?utf-8?B?Z2YzQ0QyZUJrMkFwNlllWFpwcEVHdzJWSW9xeVgvYVZzcDVZRDdnK2NMdzlu?=
 =?utf-8?B?SkZWRU00VlFHSGJTSFJhQlM4NDRVak9ROUVmQTZCVmJ3QXYrV3BKQkljWHVW?=
 =?utf-8?B?YTI1WTh4YWtQUnlsV2Z4WWVFVFE3NUVaT09Gb0lVQ2pNVHlQandzbElaWjI1?=
 =?utf-8?B?T2xnQ1N3QmUwNS8yZ29scTd0aGV5VnQzaFpVTkM3Mk9DYUNYZExJVE5DV3hp?=
 =?utf-8?B?eklFYjA0ZStMaFRjOWt0ZnhJbUpWem5GeDhWZkVkbzRGUENWdWdWbmI3T09j?=
 =?utf-8?B?ZTJwK3dZelFvdVgzV3UvaElEOUNJZDQrRnNMcHdTbXY0cXphZDBWa04vMVMz?=
 =?utf-8?B?NmplbGR5Sjk2eFhPbXdDY3Q0a09DWmxHclRHWWlZL3pOaXBDN1BNYWg4WUJR?=
 =?utf-8?B?MGdYZmloRGlybEFXUldibytqR250MGFrRnhGTEpUdTFKL1pTVGhlQTRGcVMz?=
 =?utf-8?B?S1c5bm9EVVFrY0tWa2tVRFJGU3ZRM0pwZUVJQlQ3WUFxU0pFSElqTVFPV0F2?=
 =?utf-8?B?dThPeTkrdzlVbExQYTIzNFZUc3NNRHpIaVhWd2o5WU9EUzVyREdhS2NnSVZQ?=
 =?utf-8?B?VkpxZDR1VEVHZGV6czU0RVNzTFFUdDFEcEZuS0dhRnozUjdPUkMwZ3B2bzFB?=
 =?utf-8?B?eS80c01rQi83NnlzOGlOMXN3U1ZIUm8xMVQzVjdqcUs0RDhCVVBxS2dZayty?=
 =?utf-8?B?WXozS1JDYjUvVWVmbXZTdEtPWnplMkRJczR2eUl0QVJhUXIxR05PYTNNMnF0?=
 =?utf-8?B?aFU2dEVpbEkyVFdlczIyTm4yRytDbWZNSzEyY3V0OHhrZWsxUjUvUlBmSmZO?=
 =?utf-8?B?Ulp5N3ZWbEhsLzQxb1JqdGRJblJiRXlSaWFpQ2xGaitOR0txWHdVbkQxSTRO?=
 =?utf-8?B?YnNRTlB0RlpiK1ZNalVmMzRLZmNXYnBjdEhQakhTcGJTRnVReks5MmlHa3JS?=
 =?utf-8?B?amVoNlJlbDdKMktxVXp5SVhneUZwR25yV2U4anI3Nkx5bms1dlRpck1wZjFW?=
 =?utf-8?B?WS9iejJTSWc5S2JIQVBhRUdsK296Rzd1NTZiS01VRnFLc0tJSUoyc0VRREdp?=
 =?utf-8?B?RHFJZkVTK3JFeU9waTBtTUdiVU1rTzIyYmpMWFhYOXFmS2c2R1FIelpxRys0?=
 =?utf-8?B?UThQTjZxVzBKVmg5b1FvWFpCODRoUWhjcjlsMmRrV3Zvd1RoWXVwTkV0eUZ1?=
 =?utf-8?B?UUJlZVNaL2VtSDNGRDRhck9uVkFiQ0p3OGwzb2FNbVJGS3hvdlQ1M21FWDhr?=
 =?utf-8?B?QjFSSCtBb1RSZ3hDRFJLTk15WFlkTkM4eEY4TkNZdGpmRjFWd0U0K2Njd2VH?=
 =?utf-8?Q?/m+JFUUTUwIUzJASYkCTLillM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cec100-d1b0-423d-bbcf-08da75a536f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 23:09:28.0545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEsfISeSgSADrGpUE/N5g5aZiDazSCiJ87eutvT7YhguZ/WbQLPnXIUfQ6+wlJPt8MVCA2eUOOYrTiFdLx5Ycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_06,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030097
X-Proofpoint-ORIG-GUID: BWRNT1MOggW_SVgBWBWm8iWpVKdOrsPm
X-Proofpoint-GUID: BWRNT1MOggW_SVgBWBWm8iWpVKdOrsPm
Cc: "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>, Eli Cohen <elic@nvidia.com>
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

CgpPbiA4LzIvMjAyMiA3OjMwIFBNLCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+Cj4KPiBPbiA4LzMv
MjAyMiA5OjI2IEFNLCBTaS1XZWkgTGl1IHdyb3RlOgo+Pgo+Pgo+PiBPbiA4LzEvMjAyMiAxMToz
MyBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+IE9uIFR1ZSwgQXVnIDIsIDIwMjIgYXQgNjo1OCBB
TSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IAo+Pj4gd3JvdGU6Cj4+Pj4KPj4+
Pgo+Pj4+IE9uIDgvMS8yMDIyIDM6NTMgUE0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+Cj4+Pj4+
IE9uIDcvMzEvMjAyMiA5OjQ0IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4g5ZyoIDIwMjIv
Ny8zMCAwNDo1NSwgU2ktV2VpIExpdSDlhpnpgZM6Cj4+Pj4+Pj4KPj4+Pj4+PiBPbiA3LzI4LzIw
MjIgNzowNCBQTSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPj4+Pj4+Pj4KPj4+Pj4+Pj4gT24gNy8y
OS8yMDIyIDU6NDggQU0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gT24g
Ny8yNy8yMDIyIDc6NDMgUE0sIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+PiBPbiA3LzI4LzIwMjIgODo1NiBBTSwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4gT24gNy8yNy8yMDIyIDQ6NDcgQU0sIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gT24gNy8yNy8yMDIyIDU6NDMgUE0sIFNpLVdlaSBMaXUg
d3JvdGU6Cj4+Pj4+Pj4+Pj4+Pj4gU29ycnkgdG8gY2hpbWUgaW4gbGF0ZSBpbiB0aGUgZ2FtZS4g
Rm9yIHNvbWUgcmVhc29uIEkgCj4+Pj4+Pj4+Pj4+Pj4gY291bGRuJ3QKPj4+Pj4+Pj4+Pj4+PiBn
ZXQgdG8gbW9zdCBlbWFpbHMgZm9yIHRoaXMgZGlzY3Vzc2lvbiAoSSBvbmx5IHN1YnNjcmliZWQg
dG8KPj4+Pj4+Pj4+Pj4+PiB0aGUgdmlydHVhbGl6YXRpb24gbGlzdCksIHdoaWxlIEkgd2FzIHRh
a2luZyBvZmYgYW1vbmdzdCB0aGUKPj4+Pj4+Pj4+Pj4+PiBwYXN0IGZldyB3ZWVrcy4KPj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IEl0IGxvb2tzIHRvIG1lIHRoaXMgcGF0Y2ggaXMgaW5jb21w
bGV0ZS4gTm90ZWQgZG93biB0aGUgCj4+Pj4+Pj4+Pj4+Pj4gd2F5IGluCj4+Pj4+Pj4+Pj4+Pj4g
dmRwYV9kZXZfbmV0X2NvbmZpZ19maWxsKCksIHdlIGhhdmUgdGhlIGZvbGxvd2luZzoKPj4+Pj4+
Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZmVhdHVyZXMgPSB2ZGV2LT5jb25maWctPmdldF9k
cml2ZXJfZmVhdHVyZXModmRldik7Cj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChubGFfcHV0X3U2NF82NGJpdChtc2csCj4+Pj4+Pj4+Pj4+Pj4gVkRQQV9BVFRSX0RFVl9ORUdP
VElBVEVEX0ZFQVRVUkVTLCBmZWF0dXJlcywKPj4+Pj4+Pj4+Pj4+PiBWRFBBX0FUVFJfUEFEKSkK
Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAt
RU1TR1NJWkU7Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBNYWtpbmcgY2FsbCB0byAuZ2V0
X2RyaXZlcl9mZWF0dXJlcygpIGRvZXNuJ3QgbWFrZSBzZW5zZSB3aGVuCj4+Pj4+Pj4+Pj4+Pj4g
ZmVhdHVyZSBuZWdvdGlhdGlvbiBpc24ndCBjb21wbGV0ZS4gTmVpdGhlciBzaG91bGQgcHJlc2Vu
dAo+Pj4+Pj4+Pj4+Pj4+IG5lZ290aWF0ZWRfZmVhdHVyZXMgdG8gdXNlcnNwYWNlIGJlZm9yZSBu
ZWdvdGlhdGlvbiBpcyBkb25lLgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gU2ltaWxhcmx5
LCBtYXhfdnFwIHRocm91Z2ggdmRwYV9kZXZfbmV0X21xX2NvbmZpZ19maWxsKCkKPj4+Pj4+Pj4+
Pj4+PiBwcm9iYWJseSBzaG91bGQgbm90IHNob3cgYmVmb3JlIG5lZ290aWF0aW9uIGlzIGRvbmUg
LSBpdAo+Pj4+Pj4+Pj4+Pj4+IGRlcGVuZHMgb24gZHJpdmVyIGZlYXR1cmVzIG5lZ290aWF0ZWQu
Cj4+Pj4+Pj4+Pj4+PiBJIGhhdmUgYW5vdGhlciBwYXRjaCBpbiB0aGlzIHNlcmllcyBpbnRyb2R1
Y2VzIGRldmljZV9mZWF0dXJlcwo+Pj4+Pj4+Pj4+Pj4gYW5kIHdpbGwgcmVwb3J0IGRldmljZV9m
ZWF0dXJlcyB0byB0aGUgdXNlcnNwYWNlIGV2ZW4gZmVhdHVyZXMKPj4+Pj4+Pj4+Pj4+IG5lZ290
aWF0aW9uIG5vdCBkb25lLiBCZWNhdXNlIHRoZSBzcGVjIHNheXMgd2Ugc2hvdWxkIGFsbG93Cj4+
Pj4+Pj4+Pj4+PiBkcml2ZXIgYWNjZXNzIHRoZSBjb25maWcgc3BhY2UgYmVmb3JlIEZFQVRVUkVT
X09LLgo+Pj4+Pj4+Pj4+PiBUaGUgY29uZmlnIHNwYWNlIGNhbiBiZSBhY2Nlc3NlZCBieSBndWVz
dCBiZWZvcmUgZmVhdHVyZXNfb2sKPj4+Pj4+Pj4+Pj4gZG9lc24ndCBuZWNlc3NhcmlseSBtZWFu
IHRoZSB2YWx1ZSBpcyB2YWxpZC4gWW91IG1heSB3YW50IHRvCj4+Pj4+Pj4+Pj4+IGRvdWJsZSBj
aGVjayB3aXRoIE1pY2hhZWwgZm9yIHdoYXQgaGUgcXVvdGVkIGVhcmxpZXI6Cj4+Pj4+Pj4+Pj4g
dGhhdCdzIHdoeSBJIHByb3Bvc2VkIHRvIGZpeCB0aGVzZSBpc3N1ZXMsIGUuZy4sIGlmIG5vIF9G
X01BQywKPj4+Pj4+Pj4+PiB2RFBBIGtlcm5lbCBzaG91bGQgbm90IHJldHVybiBhIG1hYyB0byB0
aGUgdXNlcnNwYWNlLCB0aGVyZSBpcwo+Pj4+Pj4+Pj4+IG5vdCBhIGRlZmF1bHQgdmFsdWUgZm9y
IG1hYy4KPj4+Pj4+Pj4+IFRoZW4gcGxlYXNlIHNob3cgdXMgdGhlIGNvZGUsIGFzIEkgY2FuIG9u
bHkgY29tbWVudCBiYXNlZCBvbiB5b3VyCj4+Pj4+Pj4+PiBsYXRlc3QgKHY0KSBwYXRjaCBhbmQg
aXQgd2FzIG5vdCB0aGVyZS4uIFRvIGJlIGhvbmVzdCwgSSBkb24ndAo+Pj4+Pj4+Pj4gdW5kZXJz
dGFuZCB0aGUgbW90aXZhdGlvbiBhbmQgdGhlIHVzZSBjYXNlcyB5b3UgaGF2ZSwgaXMgaXQgZm9y
Cj4+Pj4+Pj4+PiBkZWJ1Z2dpbmcvbW9uaXRvcmluZyBvciB0aGVyZSdzIHJlYWxseSBhIHVzZSBj
YXNlIGZvciBsaXZlCj4+Pj4+Pj4+PiBtaWdyYXRpb24/IEZvciB0aGUgZm9ybWVyLCB5b3UgY2Fu
IGRvIGEgZGlyZWN0IGR1bXAgb24gYWxsIGNvbmZpZwo+Pj4+Pj4+Pj4gc3BhY2UgZmllbGRzIHJl
Z2FyZGxlc3Mgb2YgZW5kaWFuZXNzIGFuZCBmZWF0dXJlIG5lZ290aWF0aW9uCj4+Pj4+Pj4+PiB3
aXRob3V0IGhhdmluZyB0byB3b3JyeSBhYm91dCB2YWxpZGl0eSAobWVhbmluZ2Z1bCB0byBwcmVz
ZW50IHRvCj4+Pj4+Pj4+PiBhZG1pbiB1c2VyKS4gVG8gbWUgdGhlc2UgYXJlIGNvbmZsaWN0IGFz
a3MgdGhhdCBpcyBpbXBvc3NpYmxlIHRvCj4+Pj4+Pj4+PiBtaXggaW4gZXhhY3Qgb25lIGNvbW1h
bmQuCj4+Pj4+Pj4+IFRoaXMgYnVnIGp1c3QgaGFzIGJlZW4gcmV2ZWFsZWQgdHdvIGRheXMsIGFu
ZCB5b3Ugd2lsbCBzZWUgdGhlCj4+Pj4+Pj4+IHBhdGNoIHNvb24uCj4+Pj4+Pj4+Cj4+Pj4+Pj4+
IFRoZXJlIGFyZSBzb21ldGhpbmcgdG8gY2xhcmlmeToKPj4+Pj4+Pj4gMSkgd2UgbmVlZCB0byBy
ZWFkIHRoZSBkZXZpY2UgZmVhdHVyZXMsIG9yIGhvdyBjYW4geW91IHBpY2sgYQo+Pj4+Pj4+PiBw
cm9wZXIgTE0gZGVzdGluYXRpb24KPj4+Pj4+Cj4+Pj4+PiBTbyBpdCdzIHByb2JhYmx5IG5vdCB2
ZXJ5IGVmZmljaWVudCB0byB1c2UgdGhpcywgdGhlIG1hbmFnZXIgbGF5ZXIKPj4+Pj4+IHNob3Vs
ZCBoYXZlIHRoZSBrbm93bGVkZ2UgYWJvdXQgdGhlIGNvbXBhdGliaWxpdHkgYmVmb3JlIGRvaW5n
Cj4+Pj4+PiBtaWdyYXRpb24gb3RoZXIgdGhhbiB0cnktYW5kLWZhaWwuCj4+Pj4+Pgo+Pj4+Pj4g
QW5kIGl0J3MgdGhlIHRhc2sgb2YgdGhlIG1hbmFnZW1lbnQgdG8gZ2F0aGVyIHRoZSBub2RlcyB3
aG9zZSAKPj4+Pj4+IGRldmljZXMKPj4+Pj4+IGNvdWxkIGJlIGxpdmUgbWlncmF0ZWQgdG8gZWFj
aCBvdGhlciBhcyBzb21ldGhpbmcgbGlrZSAiY2x1c3RlciIKPj4+Pj4+IHdoaWNoIHdlJ3ZlIGFs
cmVhZHkgdXNlZCBpbiB0aGUgY2FzZSBvZiBjcHVmbGFncy4KPj4+Pj4+Cj4+Pj4+PiAxKSBkdXJp
bmcgbm9kZSBib290c3RyYXAsIHRoZSBjYXBhYmlsaXR5IG9mIGVhY2ggbm9kZSBhbmQgZGV2aWNl
cyAKPj4+Pj4+IHdhcwo+Pj4+Pj4gcmVwb3J0ZWQgdG8gbWFuYWdlbWVudCBsYXllcgo+Pj4+Pj4g
MikgbWFuYWdlbWVudCBsYXllciBkZWNpZGUgdGhlIGNsdXN0ZXIgYW5kIG1ha2Ugc3VyZSB0aGUg
bWlncmF0aW9uCj4+Pj4+PiBjYW4gb25seSBkb25lIGFtb25nIHRoZSBub2RlcyBpbnNpZGVzIHRo
ZSBjbHVzdGVyCj4+Pj4+PiAzKSBiZWZvcmUgbWlncmF0aW9uLCB0aGUgdkRQQSBuZWVkcyB0byBi
ZSBwcm92aXNpb25lZCBvbiB0aGUgCj4+Pj4+PiBkZXN0aW5hdGlvbgo+Pj4+Pj4KPj4+Pj4+Cj4+
Pj4+Pj4+IDIpIHZkcGEgZGV2IGNvbmZpZyBzaG93IGNhbiBzaG93IGJvdGggZGV2aWNlIGZlYXR1
cmVzIGFuZCBkcml2ZXIKPj4+Pj4+Pj4gZmVhdHVyZXMsIHRoZXJlIGp1c3QgbmVlZCBhIHBhdGNo
IGZvciBpcHJvdXRlMgo+Pj4+Pj4+PiAzKSBUbyBwcm9jZXNzIGluZm9ybWF0aW9uIGxpa2UgTVEs
IHdlIGRvbid0IGp1c3QgZHVtcCB0aGUgY29uZmlnCj4+Pj4+Pj4+IHNwYWNlLCBNU1QgaGFzIGV4
cGxhaW5lZCBiZWZvcmUKPj4+Pj4+PiBTbywgaXQncyBmb3IgbGl2ZSBtaWdyYXRpb24uLi4gVGhl
biB3aHkgbm90IGV4cG9ydCB0aG9zZSBjb25maWcKPj4+Pj4+PiBwYXJhbWV0ZXJzIHNwZWNpZmll
ZCBmb3IgdmRwYSBjcmVhdGlvbiAoYXMgd2VsbCBhcyBkZXZpY2UgZmVhdHVyZQo+Pj4+Pj4+IGJp
dHMpIHRvIHRoZSBvdXRwdXQgb2YgInZkcGEgZGV2IHNob3ciIGNvbW1hbmQ/IFRoYXQncyB3aGVy
ZSBkZXZpY2UKPj4+Pj4+PiBzaWRlIGNvbmZpZyBsaXZlcyBhbmQgaXMgc3RhdGljIGFjcm9zcyB2
ZHBhJ3MgbGlmZSBjeWNsZS4gInZkcGEgZGV2Cj4+Pj4+Pj4gY29uZmlnIHNob3ciIGlzIG1vc3Rs
eSBmb3IgZHluYW1pYyBkcml2ZXIgc2lkZSBjb25maWcsIGFuZCB0aGUKPj4+Pj4+PiB2YWxpZGl0
eSBpcyBzdWJqZWN0IHRvIGZlYXR1cmUgbmVnb3RpYXRpb24uIEkgc3VwcG9zZSB0aGlzIHNob3Vs
ZAo+Pj4+Pj4+IHN1aXQgeW91ciBuZWVkIG9mIExNLCBlLmcuCj4+Pj4+Pgo+Pj4+Pj4gSSB0aGlu
ayBzby4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4+ICQgdmRwYSBkZXYgYWRkIG5hbWUgdmRwYTEgbWdt
dGRldiBwY2kvMDAwMDo0MTowNC4yIG1heF92cXAgNyBtdHUgCj4+Pj4+Pj4gMjAwMAo+Pj4+Pj4+
ICQgdmRwYSBkZXYgc2hvdyB2ZHBhMQo+Pj4+Pj4+IHZkcGExOiB0eXBlIG5ldHdvcmsgbWdtdGRl
diBwY2kvMDAwMDo0MTowNC4yIHZlbmRvcl9pZCA1NTU1IG1heF92cXMKPj4+Pj4+PiAxNSBtYXhf
dnFfc2l6ZSAyNTYKPj4+Pj4+PiDCoMKgIG1heF92cXAgNyBtdHUgMjAwMAo+Pj4+Pj4+IMKgwqAg
ZGV2X2ZlYXR1cmVzIENTVU0gR1VFU1RfQ1NVTSBNVFUgSE9TVF9UU080IEhPU1RfVFNPNiBTVEFU
VVMKPj4+Pj4+PiBDVFJMX1ZRIE1RIENUUkxfTUFDX0FERFIgVkVSU0lPTl8xIFJJTkdfUEFDS0VE
Cj4+Pj4+Pgo+Pj4+Pj4gTm90ZSB0aGF0IHRoZSBtZ210IHNob3VsZCBrbm93IHRoaXMgZGVzdGlu
YXRpb24gaGF2ZSB0aG9zZQo+Pj4+Pj4gY2FwYWJpbGl0eS9mZWF0dXJlcyBiZWZvcmUgdGhlIHBy
b3Zpc2lvbmluZy4KPj4+Pj4gWWVzLCBtZ210IHNvZnR3YXJlIHNob3VsZCBoYXZlIHRvIGNoZWNr
IHRoZSBhYm92ZSBmcm9tIHNvdXJjZS4KPj4+PiBPbiBkZXN0aW5hdGlvbiBtZ210IHNvZnR3YXJl
IGNhbiBydW4gYmVsb3cgdG8gY2hlY2sgdmRwYSBtZ210ZGV2J3MKPj4+PiBjYXBhYmlsaXR5L2Zl
YXR1cmVzOgo+Pj4+Cj4+Pj4gJCB2ZHBhIG1nbXRkZXYgc2hvdyBwY2kvMDAwMDo0MTowNC4zCj4+
Pj4gcGNpLzAwMDA6NDE6MDQuMzoKPj4+PiDCoMKgwqAgc3VwcG9ydGVkX2NsYXNzZXMgbmV0Cj4+
Pj4gwqDCoMKgIG1heF9zdXBwb3J0ZWRfdnFzIDI1Nwo+Pj4+IMKgwqDCoCBkZXZfZmVhdHVyZXMg
Q1NVTSBHVUVTVF9DU1VNIE1UVSBIT1NUX1RTTzQgSE9TVF9UU082IFNUQVRVUyAKPj4+PiBDVFJM
X1ZRCj4+Pj4gTVEgQ1RSTF9NQUNfQUREUiBWRVJTSU9OXzEgUklOR19QQUNLRUQKPj4+IFJpZ2h0
IGFuZCB0aGlzIGlzIHByb2JhYmx5IGJldHRlciB0byBiZSBkb25lIGF0IG5vZGUgYm9vdHN0cmFw
cGluZyBmb3IKPj4+IHRoZSBtYW5hZ2VtZW50IHRvIGtub3cgYWJvdXQgdGhlIGNsdXN0ZXIuCj4+
IEV4YWN0bHkuIFRoYXQncyB3aGF0IG1nbXQgc29mdHdhcmUgaXMgc3VwcG9zZWQgdG8gZG8gdHlw
aWNhbGx5Lgo+IEkgdGhpbmsgdGhpcyBjb3VsZCBhcHBseSB0byBib3RoIG1nbXQgZGV2aWNlcyBh
bmQgdkRQQSBkZXZpY2VzOgo+IDEpbWdtdCBkZXZpY2UsIHNlZSB3aGV0aGVyIHRoZSBtZ210IGRl
dmljZSBpcyBjYXBhYmxlIHRvIGNyZWF0ZSBhIHZEUEEgCj4gZGV2aWNlIHdpdGggYSBjZXJ0YWlu
IGZlYXR1cmUgYml0cywgdGhpcyBpcyBmb3IgTE0KPiAyKXZEUEEgZGV2aWNlLCByZXBvcnQgdGhl
IGRldmljZSBmZWF0dXJlcywgaXQgaXMgZm9yIG5vcm1hbCBvcGVyYXRpb24KQ2FuIHlvdSBlbGFi
b3JhdGUgdGhlIHVzZSBjYXNlICJmb3Igbm9ybWFsIG9wZXJhdGlvbnMiPyBUaGVuIGl0IGhhcyAK
bm90aGluZyB0byBkbyB3aXRoIExNIGZvciBzdXJlLCBjb3JyZWN0PwoKTm90ZWQgZm9yIHRoZSBM
TSBjYXNlLCBqdXN0IGFzIEphc29uIGluZGljYXRlZCwgaXQncyBub3QgZXZlbiAqcmVxdWlyZWQq
IApmb3IgdGhlIG1nbXQgc29mdHdhcmUgdG8gZ2F0aGVyIHRoZSBkZXZpY2UgZmVhdHVyZXMgdGhy
b3VnaCAidmRwYSBkZXYgCnNob3ciIG9uIHNvdXJjZSBob3N0ICphbGl2ZSogcmlnaHQgYmVmb3Jl
IGxpdmUgbWlncmF0aW9uIGlzIHN0YXJ0ZWQuIApEZXBlbmRpbmcgb24gdGhlIHdheSBob3cgaXQg
aXMgaW1wbGVtZW50ZWQsIHRoZSBtZ210IHNvZnR3YXJlIGNhbiB3ZWxsIApjb2xsZWN0IGRldmlj
ZSBjYXBhYmlsaXR5IG9uIGJvb3Qgc3RyYXAgdGltZSwgb3IgbWF5IHdlbGwgc2F2ZSB0aGUgdmRw
YSAKZGV2aWNlIGNhcGFiaWxpdHkvY29uZmlnIGluIHBlcnNpc3RlbnQgc3RvcmUgYWhlYWQgb2Yg
dGltZSwgc2F5IGJlZm9yZSAKYW55IFZNIGlzIHRvIGJlIGxhdW5jaGVkLiBUaGVuIHdpdGggYWxs
IHN1Y2ggaW5mbyBjb2xsZWN0ZWQgZm9yIGVhY2ggCmNsdXN0ZXIgbm9kZSwgbWdtdCBzb2Z0d2Fy
ZSBpcyBhYmxlIHRvIGdldCBpdHMgb3duIHdheSB0byBpbmZlciBhbmQgc29ydCAKb3V0IHRoZSBs
aXZlIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5IGJldHdlZW4gbm9kZXMuIEknbSBub3Qgc3VyZSB3
aGljaCAKY2FzZSB5b3Ugd291bGQgbmVlZCB0byBjaGVjayB0aGUgZGV2aWNlIGZlYXR1cmVzLCBi
dXQgaW4gY2FzZSB5b3UgbmVlZCAKaXQsIGl0J2QgYmUgYmV0dGVyIGxpdmUgaW4gInZkcGEgZGV2
IHNob3ciIHRoYW4gInZkcGEgZGV2IGNvbmZpZyBzaG93Ii4KClRoYW5rcywKLVNpd2VpCgo+Cj4g
VGhhbmtzLAo+IFpodSBMaW5nc2hhbgo+Pgo+PiBUaGFua3MsCj4+IC1TaXdlaQo+Pgo+Pj4KPj4+
IFRoYW5rcwo+Pj4KPj4+Pj4+Cj4+Pj4+Pj4gRm9yIGl0IHRvIHdvcmssIHlvdSdkIHdhbnQgdG8g
cGFzcyAic3RydWN0IHZkcGFfZGV2X3NldF9jb25maWciIHRvCj4+Pj4+Pj4gX3ZkcGFfcmVnaXN0
ZXJfZGV2aWNlKCkgZHVyaW5nIHJlZ2lzdHJhdGlvbiwgYW5kIGdldCBpdCBzYXZlZCB0aGVyZQo+
Pj4+Pj4+IGluICJzdHJ1Y3QgdmRwYV9kZXZpY2UiLiBUaGVuIGluIHZkcGFfZGV2X2ZpbGwoKSBz
aG93IGVhY2ggZmllbGQKPj4+Pj4+PiBjb25kaXRpb25hbGx5IHN1YmplY3QgdG8gInN0cnVjdCB2
ZHBhX2Rldl9zZXRfY29uZmlnLm1hc2siLgo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhhbmtzLAo+Pj4+Pj4+
IC1TaXdlaQo+Pj4+Pj4KPj4+Pj4+IFRoYW5rcwo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4+IFRoYW5r
cwo+Pj4+Pj4+PiBaaHUgTGluZ3NoYW4KPj4+Pj4+Pj4+Pj4+IE5vcGU6Cj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4gMi41LjHCoCBEcml2ZXIgUmVxdWlyZW1lbnRzOiBEZXZpY2UgQ29uZmlndXJh
dGlvbiBTcGFjZQo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+IC4uLgo+Pj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4+IEZvciBvcHRpb25hbCBjb25maWd1cmF0aW9uIHNwYWNlIGZpZWxkcywgdGhlIGRy
aXZlciBNVVNUIGNoZWNrCj4+Pj4+Pj4+Pj4+PiB0aGF0IHRoZSBjb3JyZXNwb25kaW5nIGZlYXR1
cmUgaXMgb2ZmZXJlZAo+Pj4+Pj4+Pj4+Pj4gYmVmb3JlIGFjY2Vzc2luZyB0aGF0IHBhcnQgb2Yg
dGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UuCj4+Pj4+Pj4+Pj4+IGFuZCBob3cgbWFueSBkcml2ZXIg
YnVncyB0YWtpbmcgd3JvbmcgYXNzdW1wdGlvbiBvZiB0aGUgCj4+Pj4+Pj4+Pj4+IHZhbGlkaXR5
Cj4+Pj4+Pj4+Pj4+IG9mIGNvbmZpZyBzcGFjZSBmaWVsZCB3aXRob3V0IGZlYXR1cmVzX29rLiBJ
IGFtIG5vdCBzdXJlIHdoYXQKPj4+Pj4+Pj4+Pj4gdXNlIGNhc2UgeW91IHdhbnQgdG8gZXhwb3Nl
IGNvbmZpZyByZXNpc3RlciB2YWx1ZXMgZm9yIGJlZm9yZQo+Pj4+Pj4+Pj4+PiBmZWF0dXJlc19v
aywgaWYgaXQncyBtb3N0bHkgZm9yIGxpdmUgbWlncmF0aW9uIEkgZ3Vlc3MgaXQncwo+Pj4+Pj4+
Pj4+PiBwcm9iYWJseSBoZWFkaW5nIGEgd3JvbmcgZGlyZWN0aW9uLgo+Pj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gTGFzdCBidXQgbm90IHRoZSBsZWFz
dCwgdGhpcyAidmRwYSBkZXYgY29uZmlnIiBjb21tYW5kIHdhcyAKPj4+Pj4+Pj4+Pj4+PiBub3QK
Pj4+Pj4+Pj4+Pj4+PiBkZXNpZ25lZCB0byBkaXNwbGF5IHRoZSByZWFsIGNvbmZpZyBzcGFjZSBy
ZWdpc3RlciB2YWx1ZXMgaW4KPj4+Pj4+Pj4+Pj4+PiB0aGUgZmlyc3QgcGxhY2UuIFF1b3Rpbmcg
dGhlIHZkcGEtZGV2KDgpIG1hbiBwYWdlOgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IHZk
cGEgZGV2IGNvbmZpZyBzaG93IC0gU2hvdyBjb25maWd1cmF0aW9uIG9mIHNwZWNpZmljIGRldmlj
ZQo+Pj4+Pj4+Pj4+Pj4+PiBvciBhbGwgZGV2aWNlcy4KPj4+Pj4+Pj4+Pj4+Pj4gREVWIC0gc3Bl
Y2lmaWVzIHRoZSB2ZHBhIGRldmljZSB0byBzaG93IGl0cyAKPj4+Pj4+Pj4+Pj4+Pj4gY29uZmln
dXJhdGlvbi4gSWYKPj4+Pj4+Pj4+Pj4+Pj4gdGhpcyBhcmd1bWVudCBpcyBvbWl0dGVkIGFsbCBk
ZXZpY2VzIGNvbmZpZ3VyYXRpb24gaXMgCj4+Pj4+Pj4+Pj4+Pj4+IGxpc3RlZC4KPj4+Pj4+Pj4+
Pj4+PiBJdCBkb2Vzbid0IHNheSBhbnl0aGluZyBhYm91dCBjb25maWd1cmF0aW9uIHNwYWNlIG9y
IHJlZ2lzdGVyCj4+Pj4+Pj4+Pj4+Pj4gdmFsdWVzIGluIGNvbmZpZyBzcGFjZS4gQXMgbG9uZyBh
cyBpdCBjYW4gY29udmV5IHRoZSBjb25maWcKPj4+Pj4+Pj4+Pj4+PiBhdHRyaWJ1dGUgd2hlbiBp
bnN0YW50aWF0aW5nIHZEUEEgZGV2aWNlIGluc3RhbmNlLCBhbmQgbW9yZQo+Pj4+Pj4+Pj4+Pj4+
IGltcG9ydGFudGx5LCB0aGUgY29uZmlnIGNhbiBiZSBlYXNpbHkgaW1wb3J0ZWQgZnJvbSBvcgo+
Pj4+Pj4+Pj4+Pj4+IGV4cG9ydGVkIHRvIHVzZXJzcGFjZSB0b29scyB3aGVuIHRyeWluZyB0byBy
ZWNvbnN0cnVjdCB2ZHBhCj4+Pj4+Pj4+Pj4+Pj4gaW5zdGFuY2UgaW50YWN0IG9uIGRlc3RpbmF0
aW9uIGhvc3QgZm9yIGxpdmUgbWlncmF0aW9uLCBJTUhPCj4+Pj4+Pj4+Pj4+Pj4gaW4gbXkgcGVy
c29uYWwgaW50ZXJwcmV0YXRpb24gaXQgZG9lc24ndCBtYXR0ZXIgd2hhdCB0aGUKPj4+Pj4+Pj4+
Pj4+PiBjb25maWcgc3BhY2UgbWF5IHByZXNlbnQuIEl0IG1heSBiZSB3b3J0aCB3aGlsZSBhZGRp
bmcgYSBuZXcKPj4+Pj4+Pj4+Pj4+PiBkZWJ1ZyBjb21tYW5kIHRvIGV4cG9zZSB0aGUgcmVhbCBy
ZWdpc3RlciB2YWx1ZSwgYnV0IHRoYXQncwo+Pj4+Pj4+Pj4+Pj4+IGFub3RoZXIgc3RvcnkuCj4+
Pj4+Pj4+Pj4+PiBJIGFtIG5vdCBzdXJlIGdldHRpbmcgeW91ciBwb2ludHMuIHZEUEEgbm93IHJl
cG9ydHMgZGV2aWNlCj4+Pj4+Pj4+Pj4+PiBmZWF0dXJlIGJpdHMoZGV2aWNlX2ZlYXR1cmVzKSBh
bmQgbmVnb3RpYXRlZCBmZWF0dXJlCj4+Pj4+Pj4+Pj4+PiBiaXRzKGRyaXZlcl9mZWF0dXJlcyks
IGFuZCB5ZXMsIHRoZSBkcml2ZXJzIGZlYXR1cmVzIGNhbiBiZSBhCj4+Pj4+Pj4+Pj4+PiBzdWJz
ZXQgb2YgdGhlIGRldmljZSBmZWF0dXJlczsgYW5kIHRoZSB2RFBBIGRldmljZSBmZWF0dXJlcyAK
Pj4+Pj4+Pj4+Pj4+IGNhbgo+Pj4+Pj4+Pj4+Pj4gYmUgYSBzdWJzZXQgb2YgdGhlIG1hbmFnZW1l
bnQgZGV2aWNlIGZlYXR1cmVzLgo+Pj4+Pj4+Pj4+PiBXaGF0IEkgc2FpZCBpcyBhZnRlciB1bmJs
b2NraW5nIHRoZSBjb25kaXRpb25hbCBjaGVjaywgeW91J2QKPj4+Pj4+Pj4+Pj4gaGF2ZSB0byBo
YW5kbGUgdGhlIGNhc2UgZm9yIGVhY2ggb2YgdGhlIHZkcGEgYXR0cmlidXRlIHdoZW4KPj4+Pj4+
Pj4+Pj4gZmVhdHVyZSBuZWdvdGlhdGlvbiBpcyBub3QgeWV0IGRvbmU6IGJhc2ljYWxseSB0aGUg
cmVnaXN0ZXIKPj4+Pj4+Pj4+Pj4gdmFsdWVzIHlvdSBnb3QgZnJvbSBjb25maWcgc3BhY2Ugdmlh
IHRoZQo+Pj4+Pj4+Pj4+PiB2ZHBhX2dldF9jb25maWdfdW5sb2NrZWQoKSBjYWxsIGlzIG5vdCBj
b25zaWRlcmVkIHRvIGJlIHZhbGlkCj4+Pj4+Pj4+Pj4+IGJlZm9yZSBmZWF0dXJlc19vayAocGVy
LXNwZWMpLiBBbHRob3VnaCBpbiBzb21lIGNhc2UgeW91IG1heSAKPj4+Pj4+Pj4+Pj4gZ2V0Cj4+
Pj4+Pj4+Pj4+IHNhbmUgdmFsdWUsIHN1Y2ggYmVoYXZpb3IgaXMgZ2VuZXJhbGx5IHVuZGVmaW5l
ZC4gSWYgeW91IGRlc2lyZQo+Pj4+Pj4+Pj4+PiB0byBzaG93IGp1c3QgdGhlIGRldmljZV9mZWF0
dXJlcyBhbG9uZSB3aXRob3V0IGFueSBjb25maWcgc3BhY2UKPj4+Pj4+Pj4+Pj4gZmllbGQsIHdo
aWNoIHRoZSBkZXZpY2UgaGFkIGFkdmVydGlzZWQgKmJlZm9yZSBmZWF0dXJlCj4+Pj4+Pj4+Pj4+
IG5lZ290aWF0aW9uIGlzIGNvbXBsZXRlKiwgdGhhdCdsbCBiZSBmaW5lLiBCdXQgbG9va3MgdG8g
bWUgdGhpcwo+Pj4+Pj4+Pj4+PiBpcyBub3QgaG93IHBhdGNoIGhhcyBiZWVuIGltcGxlbWVudGVk
LiBQcm9iYWJseSBuZWVkIHNvbWUgbW9yZQo+Pj4+Pj4+Pj4+PiB3b3JrPwo+Pj4+Pj4+Pj4+IFRo
ZXkgYXJlIGRyaXZlcl9mZWF0dXJlcyhuZWdvdGlhdGVkKSBhbmQgdGhlCj4+Pj4+Pj4+Pj4gZGV2
aWNlX2ZlYXR1cmVzKHdoaWNoIGNvbWVzIHdpdGggdGhlIGRldmljZSksIGFuZCB0aGUgY29uZmln
Cj4+Pj4+Pj4+Pj4gc3BhY2UgZmllbGRzIHRoYXQgZGVwZW5kIG9uIHRoZW0uIEluIHRoaXMgc2Vy
aWVzLCB3ZSByZXBvcnQgYm90aAo+Pj4+Pj4+Pj4+IHRvIHRoZSB1c2Vyc3BhY2UuCj4+Pj4+Pj4+
PiBJIGZhaWwgdG8gdW5kZXJzdGFuZCB3aGF0IHlvdSB3YW50IHRvIHByZXNlbnQgZnJvbSB5b3Vy
Cj4+Pj4+Pj4+PiBkZXNjcmlwdGlvbi4gTWF5IGJlIHdvcnRoIHNob3dpbmcgc29tZSBleGFtcGxl
IG91dHB1dHMgdGhhdCBhdAo+Pj4+Pj4+Pj4gbGVhc3QgaW5jbHVkZSB0aGUgZm9sbG93aW5nIGNh
c2VzOiAxKSB3aGVuIGRldmljZSBvZmZlcnMgZmVhdHVyZXMKPj4+Pj4+Pj4+IGJ1dCBub3QgeWV0
IGFja25vd2xlZGdlIGJ5IGd1ZXN0IDIpIHdoZW4gZ3Vlc3QgYWNrbm93bGVkZ2VkCj4+Pj4+Pj4+
PiBmZWF0dXJlcyBhbmQgZGV2aWNlIGlzIHlldCB0byBhY2NlcHQgMykgYWZ0ZXIgZ3Vlc3QgZmVh
dHVyZQo+Pj4+Pj4+Pj4gbmVnb3RpYXRpb24gaXMgY29tcGxldGVkIChhZ3JlZWQgdXBvbiBiZXR3
ZWVuIGd1ZXN0IGFuZCBkZXZpY2UpLgo+Pj4+Pj4+PiBPbmx5IHR3byBmZWF0dXJlIHNldHM6IDEp
IHdoYXQgdGhlIGRldmljZSBoYXMuICgyKSB3aGF0IGlzIAo+Pj4+Pj4+PiBuZWdvdGlhdGVkCj4+
Pj4+Pj4+PiBUaGFua3MsCj4+Pj4+Pj4+PiAtU2l3ZWkKPj4+Pj4+Pj4+Pj4gUmVnYXJkcywKPj4+
Pj4+Pj4+Pj4gLVNpd2VpCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gSGF2aW5nIHNhaWQsIHBs
ZWFzZSBjb25zaWRlciB0byBkcm9wIHRoZSBGaXhlcyB0YWcsIGFzIAo+Pj4+Pj4+Pj4+Pj4+IGFw
cGVhcnMKPj4+Pj4+Pj4+Pj4+PiB0byBtZSB5b3UncmUgcHJvcG9zaW5nIGEgbmV3IGZlYXR1cmUg
cmF0aGVyIHRoYW4gZml4aW5nIGEgCj4+Pj4+Pj4+Pj4+Pj4gcmVhbAo+Pj4+Pj4+Pj4+Pj4+IGlz
c3VlLgo+Pj4+Pj4+Pj4+Pj4gaXQncyBhIG5ldyBmZWF0dXJlIHRvIHJlcG9ydCB0aGUgZGV2aWNl
IGZlYXR1cmUgYml0cyB0aGFuIG9ubHkKPj4+Pj4+Pj4+Pj4+IG5lZ290aWF0ZWQgZmVhdHVyZXMs
IGhvd2V2ZXIgdGhpcyBwYXRjaCBpcyBhIG11c3QsIG9yIGl0IHdpbGwKPj4+Pj4+Pj4+Pj4+IGJs
b2NrIHRoZSBkZXZpY2UgZmVhdHVyZSBiaXRzIHJlcG9ydGluZy4gYnV0IEkgYWdyZWUsIHRoZSBm
aXgKPj4+Pj4+Pj4+Pj4+IHRhZyBpcyBub3QgYSBtdXN0Lgo+Pj4+Pj4+Pj4+Pj4+IFRoYW5rcywK
Pj4+Pj4+Pj4+Pj4+PiAtU2l3ZWkKPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IE9uIDcvMS8y
MDIyIDM6MTIgUE0sIFBhcmF2IFBhbmRpdCB2aWEgVmlydHVhbGl6YXRpb24gd3JvdGU6Cj4+Pj4+
Pj4+Pj4+Pj4+PiBGcm9tOiBaaHUgTGluZ3NoYW48bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4+
Pj4+Pj4+Pj4+Pj4+IFNlbnQ6IEZyaWRheSwgSnVseSAxLCAyMDIyIDk6MjggQU0KPj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiBVc2VycyBtYXkgd2FudCB0byBxdWVyeSB0aGUgY29uZmln
IHNwYWNlIG9mIGEgdkRQQSBkZXZpY2UsCj4+Pj4+Pj4+Pj4+Pj4+PiB0byBjaG9vc2UgYQo+Pj4+
Pj4+Pj4+Pj4+Pj4gYXBwcm9wcmlhdGUgb25lIGZvciBhIGNlcnRhaW4gZ3Vlc3QuIFRoaXMgbWVh
bnMgdGhlIHVzZXJzCj4+Pj4+Pj4+Pj4+Pj4+PiBuZWVkIHRvIHJlYWQgdGhlCj4+Pj4+Pj4+Pj4+
Pj4+PiBjb25maWcgc3BhY2UgYmVmb3JlIEZFQVRVUkVTX09LLCBhbmQgdGhlIGV4aXN0ZW5jZSBv
ZiAKPj4+Pj4+Pj4+Pj4+Pj4+IGNvbmZpZwo+Pj4+Pj4+Pj4+Pj4+Pj4gc3BhY2UKPj4+Pj4+Pj4+
Pj4+Pj4+IGNvbnRlbnRzIGRvZXMgbm90IGRlcGVuZCBvbiBGRUFUVVJFU19PSy4KPj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiBUaGUgc3BlYyBzYXlzOgo+Pj4+Pj4+Pj4+Pj4+Pj4gVGhl
IGRldmljZSBNVVNUIGFsbG93IHJlYWRpbmcgb2YgYW55IGRldmljZS1zcGVjaWZpYwo+Pj4+Pj4+
Pj4+Pj4+Pj4gY29uZmlndXJhdGlvbiBmaWVsZAo+Pj4+Pj4+Pj4+Pj4+Pj4gYmVmb3JlIEZFQVRV
UkVTX09LIGlzIHNldCBieSB0aGUgZHJpdmVyLiBUaGlzIGluY2x1ZGVzCj4+Pj4+Pj4+Pj4+Pj4+
PiBmaWVsZHMgd2hpY2ggYXJlCj4+Pj4+Pj4+Pj4+Pj4+PiBjb25kaXRpb25hbCBvbiBmZWF0dXJl
IGJpdHMsIGFzIGxvbmcgYXMgdGhvc2UgZmVhdHVyZSBiaXRzCj4+Pj4+Pj4+Pj4+Pj4+PiBhcmUg
b2ZmZXJlZCBieSB0aGUKPj4+Pj4+Pj4+Pj4+Pj4+IGRldmljZS4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+Pj4+PiBGaXhlczogMzBlZjdhOGFjOGEwNyAodmRwYTogUmVhZCBkZXZpY2UgY29u
ZmlndXJhdGlvbiBvbmx5Cj4+Pj4+Pj4+Pj4+Pj4+PiBpZiBGRUFUVVJFU19PSykKPj4+Pj4+Pj4+
Pj4+Pj4gRml4IGlzIGZpbmUsIGJ1dCBmaXhlcyB0YWcgbmVlZHMgY29ycmVjdGlvbiBkZXNjcmli
ZWQgYmVsb3cuCj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IEFib3ZlIGNvbW1pdCBpZCBp
cyAxMyBsZXR0ZXJzIHNob3VsZCBiZSAxMi4KPj4+Pj4+Pj4+Pj4+Pj4gQW5kCj4+Pj4+Pj4+Pj4+
Pj4+IEl0IHNob3VsZCBiZSBpbiBmb3JtYXQKPj4+Pj4+Pj4+Pj4+Pj4gRml4ZXM6IDMwZWY3YThh
YzhhMCAoInZkcGE6IFJlYWQgZGV2aWNlIGNvbmZpZ3VyYXRpb24gCj4+Pj4+Pj4+Pj4+Pj4+IG9u
bHkgaWYKPj4+Pj4+Pj4+Pj4+Pj4gRkVBVFVSRVNfT0siKQo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+PiBQbGVhc2UgdXNlIGNoZWNrcGF0Y2gucGwgc2NyaXB0IGJlZm9yZSBwb3N0aW5nIHRo
ZSAKPj4+Pj4+Pj4+Pj4+Pj4gcGF0Y2hlcyB0bwo+Pj4+Pj4+Pj4+Pj4+PiBjYXRjaCB0aGVzZSBl
cnJvcnMuCj4+Pj4+Pj4+Pj4+Pj4+IFRoZXJlIGlzIGEgYm90IHRoYXQgbG9va3MgYXQgdGhlIGZp
eGVzIHRhZyBhbmQgaWRlbnRpZmllcyAKPj4+Pj4+Pj4+Pj4+Pj4gdGhlCj4+Pj4+Pj4+Pj4+Pj4+
IHJpZ2h0IGtlcm5lbCB2ZXJzaW9uIHRvIGFwcGx5IHRoaXMgZml4Lgo+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuPGxpbmdzaGFuLnpodUBp
bnRlbC5jb20+Cj4+Pj4+Pj4+Pj4+Pj4+PiAtLS0KPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgZHJpdmVy
cy92ZHBhL3ZkcGEuYyB8IDggLS0tLS0tLS0KPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqAgMSBmaWxlIGNo
YW5nZWQsIDggZGVsZXRpb25zKC0pCj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jIAo+Pj4+
Pj4+Pj4+Pj4+Pj4gaW5kZXgKPj4+Pj4+Pj4+Pj4+Pj4+IDliMGUzOWIyZjAyMi4uZDc2YjIyYjJm
N2FlIDEwMDY0NAo+Pj4+Pj4+Pj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+
Pj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+Pj4+Pj4+Pj4+Pj4+Pj4gQEAg
LTg1MSwxNyArODUxLDkgQEAgdmRwYV9kZXZfY29uZmlnX2ZpbGwoc3RydWN0IAo+Pj4+Pj4+Pj4+
Pj4+Pj4gdmRwYV9kZXZpY2UKPj4+Pj4+Pj4+Pj4+Pj4+ICp2ZGV2LAo+Pj4+Pj4+Pj4+Pj4+Pj4g
c3RydWN0IHNrX2J1ZmYgKm1zZywgdTMyIHBvcnRpZCzCoCB7Cj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKg
wqDCoMKgwqAgdTMyIGRldmljZV9pZDsKPj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgwqDCoCB2b2lk
ICpoZHI7Cj4+Pj4+Pj4+Pj4+Pj4+PiAtwqDCoMKgIHU4IHN0YXR1czsKPj4+Pj4+Pj4+Pj4+Pj4+
IMKgwqDCoMKgwqDCoCBpbnQgZXJyOwo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IGRv
d25fcmVhZCgmdmRldi0+Y2ZfbG9jayk7Cj4+Pj4+Pj4+Pj4+Pj4+PiAtwqDCoMKgIHN0YXR1cyA9
IHZkZXYtPmNvbmZpZy0+Z2V0X3N0YXR1cyh2ZGV2KTsKPj4+Pj4+Pj4+Pj4+Pj4+IC3CoMKgwqAg
aWYgKCEoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0ZFQVRVUkVTX09LKSkgewo+Pj4+Pj4+Pj4+
Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIE5MX1NFVF9FUlJfTVNHX01PRChleHRhY2ssICJGZWF0dXJl
cyAKPj4+Pj4+Pj4+Pj4+Pj4+IG5lZ290aWF0aW9uIG5vdAo+Pj4+Pj4+Pj4+Pj4+Pj4gY29tcGxl
dGVkIik7Cj4+Pj4+Pj4+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgZXJyID0gLUVBR0FJTjsKPj4+
Pj4+Pj4+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4+Pj4+Pj4+Pj4+Pj4+IC3C
oMKgwqAgfQo+Pj4+Pj4+Pj4+Pj4+Pj4gLQo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgIGhk
ciA9IGdlbmxtc2dfcHV0KG1zZywgcG9ydGlkLCBzZXEsICZ2ZHBhX25sX2ZhbWlseSwKPj4+Pj4+
Pj4+Pj4+Pj4+IGZsYWdzLAo+Pj4+Pj4+Pj4+Pj4+Pj4gVkRQQV9DTURfREVWX0NPTkZJR19HRVQp
Owo+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgwqDCoMKgIGlmICghaGRyKSB7Cj4+Pj4+Pj4+Pj4+Pj4+
PiAtLSAKPj4+Pj4+Pj4+Pj4+Pj4+IDIuMzEuMQo+Pj4+Pj4+Pj4+Pj4+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+Pj4+Pj4+Pj4+PiBWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKPj4+Pj4+Pj4+Pj4+Pj4gVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKPj4+Pj4+Pj4+Pj4+Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9uX187ISFBQ1dWNU45TTJSVjk5aFEhTnpPdjVFd19aMkNQLXpIeUQ3UnNV
b1N0TFo1NEtwQjIxUXl1WjhMNjNZVlBMRUdERXd2Y09TRGxJR3hRUEhZLURNa09hOXNLS1pkQlNh
TmtuTVUkIAo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4KPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
