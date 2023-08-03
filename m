Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DB7C001DB
	for <virtualization@archiver.kernel.org>; Thu,  3 Aug 2023 17:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B10C409E2;
	Thu,  3 Aug 2023 17:58:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B10C409E2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=CblwxWmj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=kXyR8D0h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QR5l4ESavbGm; Thu,  3 Aug 2023 17:58:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E6E7A408AE;
	Thu,  3 Aug 2023 17:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6E7A408AE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA5E0C0072;
	Thu,  3 Aug 2023 17:58:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DF32C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 17:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 770C960769
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 17:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 770C960769
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=CblwxWmj; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=kXyR8D0h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ctyKbW9P_KTB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 17:58:03 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77B3960B91
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 17:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77B3960B91
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 373CgOr9006891; Thu, 3 Aug 2023 17:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=btFbOXjCbCOxRuxFb3SLZcLY/AfLTzi3z9q9XQ4tLCQ=;
 b=CblwxWmj6hYwY25OrNbny5Vcwyo0HWS9PAbm+yEVE85wKh0liIrF0Kl+QXf+r8y/h5OV
 hihe11r9ZO5sdvWXPz4QCkdynzLJCTzBd46zK2LjWeqOqp+4hZ1q84xr3w4ar94325F1
 hrvBGTOUcAosXkiEsqkDInUl2apYkYYeA+fwoEQebC0m+YBzzhNihzP20hILkehjUy6H
 R2amFV5NQC8Y/kB4THRfhAtGOYdYFO2I98Vkz34e5Ue2jYnQ7OX8wRMtppFctARTYp0T
 3+4xY4LzVa22tHscxHnrdyLsjOaV/AmHLQgOSwnSnqI0Uz6rjwMcGnUDg+xwzjWTIMip aw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uav26qh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Aug 2023 17:57:58 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 373GQAoV006687; Thu, 3 Aug 2023 17:57:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3s4s79tjej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Aug 2023 17:57:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKGIM3HJXc7OKzCyfAqhvteKdfyV3NxOZO2GAv1LmPITYDCALCJJkNJchIFsGLJkoPi33nO+Xx+SRJMUOhpj0YlPrBYtOfaB9rW8DSSaYOYynmhudb+3q0kF6fc4mzuFu8+knTnxs6EQA/YDap1ZCvWYoN+fnH/FiMkGGFblDoJBJYm2LIsvC/lUTvlUQHNmkBc6WgPzXYtn4zSzCZpdOyznJEflCwkhx4gcq2LjoFqAByyMKRaVzFEjSAS3jxFfIr/IhOcJZPJVaI4o2YN6AAbFD4v92MkyLwfebFWwofR20VoJcbsqt6D73v6/soadadre5ay38RyFAusgwSgWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btFbOXjCbCOxRuxFb3SLZcLY/AfLTzi3z9q9XQ4tLCQ=;
 b=lFGbs6pUFsK6MM/trB+QiAbHhWqC1xBxtO4Fse3uwpK0ymv/uNOISX7N6RGaPq+tUEG01KRm/p+B6RF1lyDQz3HmSGCTC5KONNYYUIkqXb2BVyyu1d2pm5qIofqOTMMNq0vwhocG69REsik9TiCK4kdvq3hV3iRu1MLEiLsM6/FKiycsiSfq1NcOYLy/CTSHSHHZbbxrj/UQGUvrJA089NzKx4ydpqUX8pPGaCpTYYVZ+vqhYYRolhE5TN0lGlsIxDc5dvahoRvrpwrhHq8TZ92at5wQECp9+tZTPwdRVOJHSkAApOVykiVnE5gprHnBzCcQRY9PIR2N/k/etwCD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btFbOXjCbCOxRuxFb3SLZcLY/AfLTzi3z9q9XQ4tLCQ=;
 b=kXyR8D0hozaHgf2fGdR+0JHjZudnuC8HZ39ttQWQcIBhg0D4THrUpMjP39neyMxPasAyN0SycijpvwhSgWYswNFqmCkI3jPdXarWb0fBsYi5hX5746D8/hF5juO19mhE4JZpV+5ciVU3fnFvzvogVbCu43sMwEdwAFidxRRD0WA=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 17:57:55 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::2ae3:b57e:171f:789]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::2ae3:b57e:171f:789%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 17:57:55 +0000
Message-ID: <741645a0-c576-e504-8ebc-6b716099d730@oracle.com>
Date: Thu, 3 Aug 2023 10:57:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
To: Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
X-ClientProxiedBy: DS7PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::10) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|BY5PR10MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa81e52-84dc-4824-4ff3-08db944b2967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ud+d1cwkt7OboxTxNx60E/HpYC+c8TcpZniihg3d+zomDjfCVaxo4z0+hDUMdqzn/CD/DtFrY5OdksZzqbwlQlHmn+8rhJaIopEp330qoCGY2cdeZSR+Qtolz6rqA95+wOTwdF6h74/23Q67ea8HrKQ462hJMvpCKSo7hBqGzhwp/RpoU7KjUCUuvbMcYuXwxtim51VjU7IqX5Dz63/Bp2Sf0lvTB5NWMG6MbpE92KDxNUDMA9B39x2j7pwQGA7h7IyV8THCMpbrOdkcQZRbJHem+Al1ZacqwSRlKN6Wsr4JmLN1I+yM59i3faaODONHRbNCL1HvK/Ba7Rek+gNRYaBZmLrJSn4KkKvrrymIihYxLzioBEbURnE0pkWXhOpVm72j9fkVLCcwcGLmRfQ+5X7dtVvNGvBw50j0Q7AYw+ViswB5IpTaPzhxZcf6P/iroHF6cnEaTW3UccF3BadABpWj1Z0AakzZ4Ei6zMQJHuXoEaQKgBBHVlMuzF53e4LZtfChwSEy0/wmwQn2JFcBAsu5BCM5ZBX18yRccNbYPCpFYjqAZJVpaloVxHLxPDrYb7ZiiAYUbktAYyroSW5yfxRfYVr4qJLPLtQhaLa04LB179eMkZGQxXr82qwc0NN5zwdLCuHhJY35RteS4zTylodPDv/6tFXS0s3X/HZbRgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(66574015)(2616005)(53546011)(6506007)(83380400001)(186003)(26005)(8676002)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(66476007)(41300700001)(8936002)(6486002)(6666004)(966005)(6512007)(54906003)(110136005)(478600001)(36916002)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUxTTElBeWltU0xPQUM3WDcwcGFlcGozQUd4V1QxdVhpQU5oUFpnMXhHdnVS?=
 =?utf-8?B?Yk1za2NQemFNR1JLTDFmaGF0L2M1Zld6dVdncm1tazdZR2g3dVpCS3crRkZL?=
 =?utf-8?B?WUxUcWQ5aVRlNWZIRXFGbUI2ZGZNZGhlNFdwSTFIVWo1TW40ajN6ZG5KdVNX?=
 =?utf-8?B?aE8rZTRTUmdkRzlvbU5taE5TRE9xTTJyY1FqRGExZ1E4OEhUY1Z0WHVuU0wv?=
 =?utf-8?B?cmVXTUtpY0tOMUxnQm4wcGc4djQzb2ZBYUh2a3hmeW15U09wQ0VEamQwYlBp?=
 =?utf-8?B?OGtodVU5SmFvbEZVQTJSYkFuTTBOQTVQYU1VVTVIeklXSit5RzBWbndaQm9G?=
 =?utf-8?B?M3UxK2JsaUdzOFNnclp4Q01Sczc1N0tXUXUxVkNKUms3Q0lPVkE5Y3F4b2ZB?=
 =?utf-8?B?SGs0WUwrUHhpZEpZUWVKMElCclY4QjFoTVVaOXk0SEtEdjAvSzZQMEtvQ0N2?=
 =?utf-8?B?dHlnQWlMc0VoYjc1S3JYcGJLT1Vyb3hrTzlObGp0UGFJNWlyVkorWGxNOSs2?=
 =?utf-8?B?eUtna1l2VDc4cmwzSndJb1UwTTVUeS9vRmpKQkVUWEIrckE3NXQyNUNwQUdC?=
 =?utf-8?B?UDN5Q0FldlN3MGhoRFUzTlRONkRsd1BqZ1ZLNS9LeVRkUHpOeWZieFk3WUtk?=
 =?utf-8?B?ak0vNjdZV0p5L09MNjM0dWUxaWpTU1IxRko5eHBKSEpGTVBGUmFTcUFEVFRm?=
 =?utf-8?B?elRldUtGdUpFbDBSMkVmR3UzcmhDbVRaR3ZPclBEc055Y3YzUkZaL3dmQnBk?=
 =?utf-8?B?ZlB1M2pSeldjY0pWNWQ5cU1WVnA2TUp6dmtKZmppYmM2a2NxNis1Z1lCL0g1?=
 =?utf-8?B?S1pXcXlVcTFNZTdqNzA1L3VOaUtHUEpibWlWenBRMm1lV3FHNHRza0Q1SVpE?=
 =?utf-8?B?SzBHVkhKa1N1MVdmdi9aRU5OcXFxcFNDVHpTR3FMQlYxbzRLSU1BUytYdlk2?=
 =?utf-8?B?ZmY1LzVqQndUUHVma3VRd0Z1Q2laV2xHOENMbnd2dHVJNm03dlNwWVllU1VU?=
 =?utf-8?B?K3J3ZWlJT0hadWFWaVhpRmlySVhPSCtjd1pRYzFNdytnUDdHdFdYTDRTTjFG?=
 =?utf-8?B?WVg2NXQrS0EvdkorNTQya3pHeWYyUFYvb1FudzM2TzF6L2dybFFpWWg5SzVR?=
 =?utf-8?B?T2wwQmZwbE5OU0VYT2dKcGJhR0R1azd3MDB0NlBVNFovZ3RzdjRjdGh1aktk?=
 =?utf-8?B?L1k2RFRLeXVvQ2hoNkNuQTRWaG9IQ2JFZWVLUFBHM2RyT3AxTkRhc2w0OFFQ?=
 =?utf-8?B?Snd3bElNNFFIcnY4blY4T0kyc3BFcHhYV0Q0M0RIL0pHRTFlSE5UN3c1UzBl?=
 =?utf-8?B?TVQ2N2xPcld1SGRFOFFQbU5SRytETDhiYzk3b2FKMHk3U0kydDk3V01jZ1NE?=
 =?utf-8?B?OElWb1dGcE1kQTlaOWtmSURsRU5pYVBBdzFwU1d5V1I1cHBkUnloaThvVUlv?=
 =?utf-8?B?ZHFXR3hsY3NzNlpJd1FhR0ZhR25ySld6QWJ3MnArVVBaSlJINEFoVTB1QzdX?=
 =?utf-8?B?ZzduUVZsenZWam5Cc2hFZHpQcjhLaW5QL0ZIeUYrWVJSTFREMGx4aEd1cG1k?=
 =?utf-8?B?ZEZWOFBDR1dsRTB3aWNsRitCL2RyYm1KUzN1WFNET3RhUFAwbTdUV2YveWdM?=
 =?utf-8?B?SWlQaHN2SWg5TVNtUExjN25wZ3g3OTIzbStVYzY1T0tNMlVJYUthYnJ0SnlX?=
 =?utf-8?B?Z3BEVXdYUHowaFNRcStreWhaRHdleXdwSUpsTWNvZUpYVVJMNkNCbFg2Rmhq?=
 =?utf-8?B?aUFrRGNSTjJlZlV5MEY3OStvZFhiT0xUckc1WFAweWsrZm5wU0pIVGdXZmJH?=
 =?utf-8?B?dVdYWXU0REFncVhtN05SZVpPVDc1L0VSRUVGUnhlcmVOVml3eTlOZGZTRUhu?=
 =?utf-8?B?S2hPY3pSSXE0WnVyN2ZVK1lGOXpzc052eDNJN1ZXOGNzNnJmL0pWUUx4SVZN?=
 =?utf-8?B?aHVWMFpFaHVLUllORGJ3VnlocVFVdUI5UVB4RjNxcGEzcXRMenhXTFFlT2lB?=
 =?utf-8?B?dUZNQkxFUnRnSzlRbXVKYTBuUXhOQ1hsY0x3dlRPZTZVQ0VwSWVmMDZDZ2h3?=
 =?utf-8?B?aE5UeWVsaXZpUjNTSG1mc0lLYzYzME13WnliN285cHVuM1g1Z0JlWTZOcVl4?=
 =?utf-8?Q?3f+j4U+Q4mQhMYby4B4S/efOI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ui9qaXNlRm96enl6ZFB6YmJoYXFyUllsSkk1YXpSSlhtTEhUcXlBcC85Qmgy?=
 =?utf-8?B?Rk5rS1Y3VHl0U0pFNEVON2Q2N1Vvc25McVVweHhzdk1jU3pLSG9Vc05TK1lM?=
 =?utf-8?B?ZXd5a01ERkxNdjBONWFFSzlZRXRURk43QmZjSDcxVmRjV01WaUZXOEo3a0Zu?=
 =?utf-8?B?ZngwR21xL3UvTE9aTElIQzZKTDMrQ1VGYnFFUWdqS2kwT1RGMEJlMGFWa1VC?=
 =?utf-8?B?eEdkejVhdDhLN09DMVliSVF1bVpZeVovY0hDYnJuNk14ZVRIcU91RzE1azNI?=
 =?utf-8?B?VWRaRENyK0lDeFJBU3M3dUlMc3A4bUE0QkwzdThYcWhEQkpUc1VLSXdpb1Rs?=
 =?utf-8?B?SU1yZ1VISm16T0JBSWtnbUpldmZpeGJIdWVGMmh0MnZ2RWpteHpWb2Q4OHN4?=
 =?utf-8?B?NThReXRHTEkwc0tkVXlCZFQ4ZnZoMXM2Zlg1VnV3aFJ3NTBYYmZ2U2lzV1U0?=
 =?utf-8?B?VUhDMHBhZ1Evb2MwZEtaVE5ZZUZkOGxGME9BVHg5bjRkV3J1LzFwNkViazgv?=
 =?utf-8?B?MkVXclhZSVUrMlVKbkFQOG5PakQxdElnNVltdFhKeHpqYlcrQVdlYXFNOEpD?=
 =?utf-8?B?MFRVNmpaa1V4c25Nc3oxRmlmVmFJNldFZ1pqVjFkdTcrZC9tbDlZZnhMOUZO?=
 =?utf-8?B?bzdQVzAxcXl2ejdnN2ptVkdqM2xseHNUWEgyODlCSDVQUTdwYndvcyswclRE?=
 =?utf-8?B?UGIraDViMG5TZHpIeEdySlFoYkFmazBHWDdaVGx6VlV4Qk11eUZ1d2p0RzYy?=
 =?utf-8?B?U1JBUmJPVFRwUGF0MG12aUEvdUt3R0JlbmVhSVlJNVVMRy9EM3l5VWNFTS9L?=
 =?utf-8?B?bzlHMXQ0N1NBY0l1cHRDajBGdlVoNnJXbFBiL1oyYXl1NGNsSGlhbHpmT3A0?=
 =?utf-8?B?MjhsSDAwV0x6Q0FNT3U5bzNvdTJOMGozTEwwSU42V1ppMVJwWFRxU0tzNUl3?=
 =?utf-8?B?NnlKS0t4cU94aGxuZG5QZ2JwL25sZXJibktoVVNnUEo5Q1A3K21IcUREajQ1?=
 =?utf-8?B?QkttbkpKL2FobFVoZk5nUXZta1RnYSt1VlRReTZHSlRxdzR6Y0FndXlIMlh0?=
 =?utf-8?B?Tk5LTzZ6K2Ztdk9BWjhVd0xoTEFtUWF4Rk5jZGdMb3BEREo0OHIxNUp3d3RT?=
 =?utf-8?B?Wk05QTFFU0FzYlVzbHByVm81bWZmSnJkd1FUaDhlTWNsSmxaeFRDZHBCNnFr?=
 =?utf-8?B?UHdRNGM1Z1FMVjUxRDZzMnpkU1J6RXE1VWxubmg2c1RqMHZMZ3pjdThQYmwy?=
 =?utf-8?Q?qGFmq45v5zA1FS0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa81e52-84dc-4824-4ff3-08db944b2967
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 17:57:54.9863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR1RehG4avLSGBnDbvF2Txrteft2JJqBzbHcdl4TWZaTSaGETuYR0pce/bn7PekaDIXu7rwmPpGkFMFmIuoEjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_19,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030161
X-Proofpoint-ORIG-GUID: Q5SkywYJSud-9TR17M_lPbkTtSnihClJ
X-Proofpoint-GUID: Q5SkywYJSud-9TR17M_lPbkTtSnihClJ
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gal Pressman <gal@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>
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

CgpPbiA4LzMvMjAyMyAxOjAzIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIFRodSwgQXVnIDMs
IDIwMjMgYXQgMToxM+KAr0FNIERyYWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPiB3
cm90ZToKPj4gVGhlIG1yLT5pbml0aWFsaXplZCBmbGFnIGlzIHNoYXJlZCBiZXR3ZWVuIHRoZSBj
b250cm9sIHZxIGFuZCBkYXRhIHZxCj4+IHBhcnQgb2YgdGhlIG1yIGluaXQvdW5pbml0LiBCdXQg
aWYgdGhlIGNvbnRyb2wgdnEgYW5kIGRhdGEgdnEgZ2V0IHBsYWNlZAo+PiBpbiBkaWZmZXJlbnQg
QVNJRHMsIGl0IGNhbiBoYXBwZW4gdGhhdCBpbml0aWFsaXppbmcgdGhlIGNvbnRyb2wgdnEgd2ls
bAo+PiBwcmV2ZW50IHRoZSBkYXRhIHZxIG1yIGZyb20gYmVpbmcgaW5pdGlhbGl6ZWQuCj4+Cj4+
IFRoaXMgcGF0Y2ggY29uc29saWRhdGVzIHRoZSBjb250cm9sIGFuZCBkYXRhIHZxIGluaXQgcGFy
dHMgaW50byB0aGVpcgo+PiBvd24gaW5pdCBmdW5jdGlvbnMuIFRoZSBtci0+aW5pdGlhbGl6ZWQg
d2lsbCBub3cgYmUgdXNlZCBmb3IgdGhlIGRhdGEgdnEKPj4gb25seS4gVGhlIGNvbnRyb2wgdnEg
Y3VycmVudGx5IGRvZXNuJ3QgbmVlZCBhIGZsYWcuCj4+Cj4+IFRoZSB1bmluaXRpYWxpemluZyBw
YXJ0IGlzIGFsc28gdGFrZW4gY2FyZSBvZjogbWx4NV92ZHBhX2Rlc3Ryb3lfbXIgZ290Cj4+IHNw
bGl0IGludG8gZGF0YSBhbmQgY29udHJvbCB2cSBmdW5jdGlvbnMgd2hpY2ggYXJlIG5vdyBhbHNv
IEFTSUQgYXdhcmUuCj4+Cj4+IEZpeGVzOiA4ZmNkMjBjMzA3MDQgKCJ2ZHBhL21seDU6IFN1cHBv
cnQgZGlmZmVyZW50IGFkZHJlc3Mgc3BhY2VzIGZvciBjb250cm9sIGFuZCBkYXRhIikKPj4gU2ln
bmVkLW9mZi1ieTogRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+Cj4+IFJldmll
d2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPj4gUmV2aWV3ZWQt
Ynk6IEdhbCBQcmVzc21hbiA8Z2FsQG52aWRpYS5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmRw
YS9tbHg1L2NvcmUvbWx4NV92ZHBhLmggfCAgMSArCj4+ICAgZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tci5jICAgICAgICB8IDk3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQo+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIGIvZHJpdmVycy92
ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+PiBpbmRleCAyNWZjNDEyMGI2MTguLmEwNDIwYmU1
MDU5ZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+
PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4+IEBAIC0zMSw2ICsz
MSw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFfbXIgewo+PiAgICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFk
IGhlYWQ7Cj4+ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgbnVtX2RpcmVjdHM7Cj4+ICAgICAgICAg
IHVuc2lnbmVkIGxvbmcgbnVtX2tsbXM7Cj4+ICsgICAgICAgLyogc3RhdGUgb2YgZHZxIG1yICov
Cj4+ICAgICAgICAgIGJvb2wgaW5pdGlhbGl6ZWQ7Cj4+Cj4+ICAgICAgICAgIC8qIHNlcmlhbGl6
ZSBta2V5IGNyZWF0aW9uIGFuZCBkZXN0cnVjdGlvbiAqLwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL21seDUvY29yZS9tci5jIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4+IGlu
ZGV4IDAzZTU0MzIyOTc5MS4uNGFlMTRhMjQ4YTRiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3Zk
cGEvbWx4NS9jb3JlL21yLmMKPj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4+
IEBAIC00ODksNjAgKzQ4OSwxMDMgQEAgc3RhdGljIHZvaWQgZGVzdHJveV91c2VyX21yKHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IG1seDVfdmRwYV9tciAqbXIKPj4gICAgICAg
ICAgfQo+PiAgIH0KPj4KPj4gLXZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2KQo+PiArc3RhdGljIHZvaWQgX21seDVfdmRwYV9kZXN0cm95X2N2cV9t
cihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQo+PiArewo+
PiArICAgICAgIGlmIChtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfQ1ZRX0dST1VQXSAhPSBh
c2lkKQo+PiArICAgICAgICAgICAgICAgcmV0dXJuOwo+PiArCj4+ICsgICAgICAgcHJ1bmVfaW90
bGIobXZkZXYpOwo+PiArfQo+PiArCj4+ICtzdGF0aWMgdm9pZCBfbWx4NV92ZHBhX2Rlc3Ryb3lf
ZHZxX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50IGFzaWQpCj4+
ICAgewo+PiAgICAgICAgICBzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+bXI7Cj4+
Cj4+IC0gICAgICAgbXV0ZXhfbG9jaygmbXItPm1rZXlfbXR4KTsKPj4gKyAgICAgICBpZiAobXZk
ZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9VUF0gIT0gYXNpZCkKPj4gKyAgICAg
ICAgICAgICAgIHJldHVybjsKPj4gKwo+PiAgICAgICAgICBpZiAoIW1yLT5pbml0aWFsaXplZCkK
Pj4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+PiArICAgICAgICAgICAgICAgcmV0dXJuOwo+
Pgo+PiAtICAgICAgIHBydW5lX2lvdGxiKG12ZGV2KTsKPj4gICAgICAgICAgaWYgKG1yLT51c2Vy
X21yKQo+PiAgICAgICAgICAgICAgICAgIGRlc3Ryb3lfdXNlcl9tcihtdmRldiwgbXIpOwo+PiAg
ICAgICAgICBlbHNlCj4+ICAgICAgICAgICAgICAgICAgZGVzdHJveV9kbWFfbXIobXZkZXYsIG1y
KTsKPj4KPj4gICAgICAgICAgbXItPmluaXRpYWxpemVkID0gZmFsc2U7Cj4+IC1vdXQ6Cj4+ICt9
Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIG1seDVfdmRwYV9kZXN0cm95X21yX2FzaWQoc3RydWN0IG1s
eDVfdmRwYV9kZXYgKm12ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKPj4gK3sKPj4gKyAgICAgICBz
dHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+bXI7Cj4+ICsKPj4gKyAgICAgICBtdXRl
eF9sb2NrKCZtci0+bWtleV9tdHgpOwo+PiArCj4+ICsgICAgICAgX21seDVfdmRwYV9kZXN0cm95
X2R2cV9tcihtdmRldiwgYXNpZCk7Cj4+ICsgICAgICAgX21seDVfdmRwYV9kZXN0cm95X2N2cV9t
cihtdmRldiwgYXNpZCk7Cj4+ICsKPj4gICAgICAgICAgbXV0ZXhfdW5sb2NrKCZtci0+bWtleV9t
dHgpOwo+PiAgIH0KPj4KPj4gLXN0YXRpYyBpbnQgX21seDVfdmRwYV9jcmVhdGVfbXIoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsIHVuc2lnbmVkIGludCBhc2lkKQo+PiArdm9pZCBt
bHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4+ICt7Cj4+
ICsgICAgICAgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChtdmRldiwgbXZkZXYtPmdyb3VwMmFz
aWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0pOwo+PiArICAgICAgIG1seDVfdmRwYV9kZXN0cm95X21y
X2FzaWQobXZkZXYsIG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBdKTsK
Pj4gK30KPj4gKwo+PiArc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9jdnFfbXIoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLAo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgYXNpZCkKPj4gK3sKPj4gKyAgICAgICBpZiAobXZk
ZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0gIT0gYXNpZCkKPj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAwOwo+PiArCj4+ICsgICAgICAgcmV0dXJuIGR1cF9pb3RsYihtdmRldiwg
aW90bGIpOwo+IFRoaXMgd29ycmllcyBtZSBhcyBjb25jZXB0dWFsbHksIHRoZXJlIHNob3VsZCBi
ZSBubyBkaWZmZXJlbmNlIGJldHdlZW4KPiBkdnEgbXIgYW5kIGN2cSBtci4gVGhlIHZpcnRxdWV1
ZSBzaG91bGQgYmUgbG9vc2VseSBjb3VwbGVkIHdpdGggbXIuCj4KPiBPbmUgZXhhbXBsZSBpcyB0
aGF0LCBpZiB3ZSBvbmx5IGRvIGR1cF9pb3RsYigpIGJ1dCBub3QgdHJ5IHRvIGNyZWF0ZQo+IGRt
YSBtciBoZXJlLCB3ZSB3aWxsIGJyZWFrIHZpcnRpby12ZHBhOgpGb3IgdGhpcyBjYXNlLCBJIGd1
ZXNzIHdlIG1heSBuZWVkIGFub3RoZXIgd2F5IHRvIHN1cHBvcnQgdmlydGlvLXZkcGEgCjE6MSBt
YXBwaW5nIHJhdGhlciB0aGFuIG92ZXJsb2FkaW5nIHZpcnRpbyBkZXZpY2UgcmVzZXQgc2VtYW50
aWNzLCBzZWU6CgpodHRwczovL3d3dy5tYWlsLWFyY2hpdmUuY29tL3FlbXUtZGV2ZWxAbm9uZ251
Lm9yZy9tc2c5NTM3NTUuaHRtbAoKID4gQ29uY2VwdHVhbGx5LCB0aGUgYWRkcmVzcyBtYXBwaW5n
IGlzIG5vdCBhIHBhcnQgb2YgdGhlIGFic3RyYWN0aW9uIGZvcgogPiBhIHZpcnRpbyBkZXZpY2Ug
bm93LiBTbyByZXNldHRpbmcgdGhlIG1lbW9yeSBtYXBwaW5nIGR1cmluZyB2aXJ0aW8KID4gZGV2
aWNlIHJlc2V0IHNlZW1zIHdyb25nLgoKd2hlcmUgd2Ugd2FudCB0byBrZWVwIG1lbW9yeSBtYXBw
aW5nIGludGFjdCBhY3Jvc3MgdmlydGlvIGRldmljZSByZXNldCAKZm9yIGJlc3QgbGl2ZSBtaWdy
YXRpb24gbGF0ZW5jeS9kb3dudGltZS4gSSB3b25kZXIgd291bGQgaXQgd29yayB0byAKcmVzZXQg
dGhlIG1hcHBpbmcgaW4gdmhvc3QtdmRwYSBsaWZlIGN5Y2xlIG91dCBvZiB2aXJ0aW8gcmVzZXQs
IHNheSAKaW50cm9kdWNlIGEgLnJlc2V0X21hcCgpIG9wIHRvIHJlc3RvcmUgMToxIG1hcHBpbmcg
d2l0aGluIAp2aG9zdF92ZHBhX3JlbW92ZV9hcygpIHJpZ2h0IGFmdGVyIHZob3N0X3ZkcGFfaW90
bGJfdW5tYXAoKT8gVGhlbiB3ZSBjYW4gCm1vdmUgdGhlIGlvdGxiIHJlc2V0IGxvZ2ljIHRvIHRo
ZXJlIHdpdGhvdXQgd29ycnkgYnJlYWtpbmcgdmlydGlvLXZkcGEuCgpUaGFua3MsCi1TaXdlaQoK
Pgo+IGNvbW1pdCA2ZjUzMTJmODAxODM2ZTZhZjliY2JiMGJkYjQ0ZGM0MjNlMTI5MjA2Cj4gQXV0
aG9yOiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiBEYXRlOiAgIFdlZCBKdW4gMiAxMTo1
ODo1NCAyMDIxICswMzAwCj4KPiAgICAgIHZkcGEvbWx4NTogQWRkIHN1cHBvcnQgZm9yIHJ1bm5p
bmcgd2l0aCB2aXJ0aW9fdmRwYQo+Cj4gICAgICBJbiBvcmRlciB0byBzdXBwb3J0IHJ1bm5pbmcg
dmRwYSB1c2luZyB2cml0aW9fdmRwYSBkcml2ZXIsIHdlIG5lZWQgIHRvCj4gICAgICBjcmVhdGUg
YSBkaWZmZXJlbnQga2luZCBvZiBNUiwgb25lIHRoYXQgaGFzIDE6MSBtYXBwaW5nLCBzaW5jZSB0
aGUKPiAgICAgIGFkZHJlc3NlcyByZWZlcnJpbmcgdG8gdmlydHF1ZXVlcyBhcmUgZG1hIGFkZHJl
c3Nlcy4KPgo+ICAgICAgV2UgY3JlYXRlIHRoZSAxOjEgTVIgaW4gbWx4NV92ZHBhX2Rldl9hZGQo
KSBvbmx5IGluIGNhc2UgZmlybXdhcmUKPiAgICAgIHN1cHBvcnRzIHRoZSBnZW5lcmFsIGNhcGFi
aWxpdHkgdW1lbV91aWRfMC4gVGhlIHJlYXNvbiBmb3IgdGhhdCBpcyB0aGF0Cj4gICAgICAxOjEg
TVJzIG11c3QgYmUgY3JlYXRlZCB3aXRoIHVpZCA9PSAwIHdoaWxlIHZpcnRxdWV1ZSBvYmplY3Rz
IGNhbiBiZQo+ICAgICAgY3JlYXRlZCB3aXRoIHVpZCA9PSAwIG9ubHkgd2hlbiB0aGUgZmlybXdh
cmUgY2FwYWJpbGl0eSBpcyBvbi4KPgo+ICAgICAgSWYgdGhlIHNldF9tYXAoKSBjYWxsYmFjayBp
cyBjYWxsZWQgd2l0aCBuZXcgdHJhbnNsYXRpb25zIHByb3ZpZGVkCj4gICAgICB0aHJvdWdoIGlv
dGxiLCB0aGUgZHJpdmVyIHdpbGwgZGVzdHJveSB0aGUgMToxIE1SIGFuZCBjcmVhdGUgYSByZWd1
bGFyCj4gICAgICBvbmUuCj4KPiAgICAgIFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0Bu
dmlkaWEuY29tPgo+ICAgICAgTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIxMDYw
MjA4NTg1NC42MjY5MC0xLWVsaWNAbnZpZGlhLmNvbQo+ICAgICAgU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiAgICAgIEFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Cj4gVGhhbmtzCj4KPgo+PiArfQo+PiArCj4+ICtz
dGF0aWMgaW50IF9tbHg1X3ZkcGFfY3JlYXRlX2R2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYsCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9z
dF9pb3RsYiAqaW90bGIsCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVu
c2lnbmVkIGludCBhc2lkKQo+PiAgIHsKPj4gICAgICAgICAgc3RydWN0IG1seDVfdmRwYV9tciAq
bXIgPSAmbXZkZXYtPm1yOwo+PiAgICAgICAgICBpbnQgZXJyOwo+Pgo+PiAtICAgICAgIGlmICht
ci0+aW5pdGlhbGl6ZWQpCj4+ICsgICAgICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQ
QV9EQVRBVlFfR1JPVVBdICE9IGFzaWQpCj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4+
Cj4+IC0gICAgICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9EQVRBVlFfR1JPVVBd
ID09IGFzaWQpIHsKPj4gLSAgICAgICAgICAgICAgIGlmIChpb3RsYikKPj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgZXJyID0gY3JlYXRlX3VzZXJfbXIobXZkZXYsIGlvdGxiKTsKPj4gLSAgICAg
ICAgICAgICAgIGVsc2UKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgZXJyID0gY3JlYXRlX2Rt
YV9tcihtdmRldiwgbXIpOwo+PiArICAgICAgIGlmIChtci0+aW5pdGlhbGl6ZWQpCj4+ICsgICAg
ICAgICAgICAgICByZXR1cm4gMDsKPj4KPj4gLSAgICAgICAgICAgICAgIGlmIChlcnIpCj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4+IC0gICAgICAgfQo+PiArICAgICAg
IGlmIChpb3RsYikKPj4gKyAgICAgICAgICAgICAgIGVyciA9IGNyZWF0ZV91c2VyX21yKG12ZGV2
LCBpb3RsYik7Cj4+ICsgICAgICAgZWxzZQo+PiArICAgICAgICAgICAgICAgZXJyID0gY3JlYXRl
X2RtYV9tcihtdmRldiwgbXIpOwo+Pgo+PiAtICAgICAgIGlmIChtdmRldi0+Z3JvdXAyYXNpZFtN
TFg1X1ZEUEFfQ1ZRX0dST1VQXSA9PSBhc2lkKSB7Cj4+IC0gICAgICAgICAgICAgICBlcnIgPSBk
dXBfaW90bGIobXZkZXYsIGlvdGxiKTsKPj4gLSAgICAgICAgICAgICAgIGlmIChlcnIpCj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X2VycjsKPj4gLSAgICAgICB9Cj4+ICsgICAg
ICAgaWYgKGVycikKPj4gKyAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4+Cj4+ICAgICAgICAg
IG1yLT5pbml0aWFsaXplZCA9IHRydWU7Cj4+ICsKPj4gKyAgICAgICByZXR1cm4gMDsKPj4gK30K
Pj4gKwo+PiArc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYsCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZo
b3N0X2lvdGxiICppb3RsYiwgdW5zaWduZWQgaW50IGFzaWQpCj4+ICt7Cj4+ICsgICAgICAgaW50
IGVycjsKPj4gKwo+PiArICAgICAgIGVyciA9IF9tbHg1X3ZkcGFfY3JlYXRlX2R2cV9tcihtdmRl
diwgaW90bGIsIGFzaWQpOwo+PiArICAgICAgIGlmIChlcnIpCj4+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gZXJyOwo+PiArCj4+ICsgICAgICAgZXJyID0gX21seDVfdmRwYV9jcmVhdGVfY3ZxX21y
KG12ZGV2LCBpb3RsYiwgYXNpZCk7Cj4+ICsgICAgICAgaWYgKGVycikKPj4gKyAgICAgICAgICAg
ICAgIGdvdG8gb3V0X2VycjsKPj4gKwo+PiAgICAgICAgICByZXR1cm4gMDsKPj4KPj4gICBvdXRf
ZXJyOgo+PiAtICAgICAgIGlmIChtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dS
T1VQXSA9PSBhc2lkKSB7Cj4+IC0gICAgICAgICAgICAgICBpZiAoaW90bGIpCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgIGRlc3Ryb3lfdXNlcl9tcihtdmRldiwgbXIpOwo+PiAtICAgICAgICAg
ICAgICAgZWxzZQo+PiAtICAgICAgICAgICAgICAgICAgICAgICBkZXN0cm95X2RtYV9tcihtdmRl
diwgbXIpOwo+PiAtICAgICAgIH0KPj4gKyAgICAgICBfbWx4NV92ZHBhX2Rlc3Ryb3lfZHZxX21y
KG12ZGV2LCBhc2lkKTsKPj4KPj4gICAgICAgICAgcmV0dXJuIGVycjsKPj4gICB9Cj4+IC0tCj4+
IDIuNDEuMAo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4gVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
