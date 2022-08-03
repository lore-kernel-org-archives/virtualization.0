Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B46C19F2B
	for <virtualization@archiver.kernel.org>; Wed,  3 Aug 2022 01:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89C64410A4;
	Wed,  3 Aug 2022 01:27:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89C64410A4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=1nRT+JbR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=gKUjRwfH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jce_TNPZfolw; Wed,  3 Aug 2022 01:27:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E422B409FC;
	Wed,  3 Aug 2022 01:27:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E422B409FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1EAAC0032;
	Wed,  3 Aug 2022 01:27:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01365C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 01:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC910410A4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 01:27:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC910410A4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E4xEexjJq-Io
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 01:27:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A34F1409FC
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A34F1409FC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Aug 2022 01:27:02 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2730i7WN015726;
 Wed, 3 Aug 2022 01:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HXf0EFRR3QaJlvp5veO7yUtGiMYlQ/lrv+h86OJq7bY=;
 b=1nRT+JbRdytQNaoUEKvXsYEt1IPn/bF4vEnn7TP4bPhZt6SGO/6QyHM3yGMvicgSYjUZ
 +RTumnZ6n2bJpUAMcYAeCpMCXBDFlsDKqGU/MJ0ESrl0bB2OUU5rsi8zwiR8+iq6c0pM
 O2EhSl/wpucNXA+rrHlF7PrAnsyT0zCbdu5gwTbifsWN2usc2uthJ5MkBjBRcrA+8r1C
 tWzhxnxUjtSsHALfYOlh/k95wioMj66qvF4y2HeonHx9AGWmPw+S/3XkFAmko7Z+I4Jv
 52D8vftHE3iJ0DOj7+RNZDy9oPAxhOlkXCfCvBPLMFl97FjeVbmqgEm1DRbnyFld16oR WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu810hy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Aug 2022 01:26:58 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 272NZD7K014202; Wed, 3 Aug 2022 01:26:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hmu32wetp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Aug 2022 01:26:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOspsPJ2xKdqQt9y7IsXYpuFYjBjOLQqn3hiVOGl25FT3VD6tRwoLul5KC3C2bfDew5UL79wQAM4h/mhwnNlIuLrk6EVYVvPedcdEGD0urLlGnm7savo9YIfVoqpFSX0mAzDRYHBXCnCbiBlyRyFBBVjGG3arWBS9hRSqrjwtt70NriC3VXEwos0C1vFEdMc2K/BDKwuJ6AOf7eLHJkOcgoQSSd50sG7/CZ3e3zyDFYMIkovr8HX1eYPA2c+11IX5Lj6d/+27mlTGvSKVSFofUXbW33WbNQjfGB7/tJSezIr0G5UMSTLhIY+BljOzAps8F5UV4wFMyUa58yYvgMjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXf0EFRR3QaJlvp5veO7yUtGiMYlQ/lrv+h86OJq7bY=;
 b=ebQ6+Ln1peFN4KSZeEL8/Kw/4Yvda077VniwMGy9JMFEq69ZtjIaKgvfKprolWu7n4MgxC7tykOxXrYHRRIjpsifjWEoK7gzuhu47VD8i//BN6H1iSESL/9LWomd+ybj8Ce+AoOVE/N/i/3qutf56+6vINlfNtzOZlC2GaZ7991XiYHWedwUXPpY1/95qFdqx6S2cRwifc9op2pm2nHxcROtGd2wrltq5ikL7uAYzVsXjTKKwPc5DyqQ2x8gTJfrn33B3Of+mK+AyZshCU5k4gZLf6+du737vv2Hi0kkpC2xtQZAmcIuXHuvjDGe8WWP63x+QVPO4YHSlmxg6uysgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXf0EFRR3QaJlvp5veO7yUtGiMYlQ/lrv+h86OJq7bY=;
 b=gKUjRwfHlMREmZHBHWGWmz88OIB0aC6q8F1aL8kHetveXEgouZTKKpvSIxzJ1BT3pPi3kim6MP9406TZfe2ZgwUS7aZdAxcBfG2jUPz0hFdU/yFprBo52lrQ/XBTHXtIb1tvre7QJp6fWFPu6eKtL4rpTVGlAjBa8/utc50CtXY=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 3 Aug
 2022 01:26:54 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 01:26:54 +0000
Message-ID: <a2b2fe74-4633-2911-b953-25fcb8e81665@oracle.com>
Date: Tue, 2 Aug 2022 18:26:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
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
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEuUVicQX87PDCO87pckAg5EMQ9OGura2J35DaR0T=COfw@mail.gmail.com>
X-ClientProxiedBy: SA1PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::11) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c13a2059-3218-4925-9272-08da74ef3fb6
X-MS-TrafficTypeDiagnostic: SA1PR10MB6318:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gxMTxPEbfKAXBRJQ8E0CTaUgzvTih0OL9zRcvUTfotnud7wz+DEXZDYXT64eETY4GJJ4Avv27l+bsCKZ0i9Rq9Zo96CeZBtiyLu6htZLbSlBCMTkqzGVZIcB693b6sJJWanMhR9dCBsC14g8g/uAWS+/V0UHbei/ZU2s/22Y0DVPNt2o6WMG+uDAeCOpO3e/lLMwNccc7IThYpv9BBZb40E5PXrhRg/dBUs6sHJTLJoseLvcsHFpMB4yip9OTbyzg56eu43jeAl1vP+ZxZz3KfJQFfVpXFMTVOkOmiugPaFYF0fDQP1JTm98Hou28jcTTGc84yXdnA+MGU+aXkn1mWroKe8lEN6VrHHbWFzeq+uxLfx2jCYrjVZ/yMmnvdEcMSYUSO081NSzMuJfZLt9KHSqlXlVxbdLP15X3UKKCly1vmtu0/sNGCQu37yAhCr5J3fb4XUcF04fOH9z73KWKIsb71J06iGnudkJXFG/6Anr+aaUCZysxegudgavKmA6ovgmpTaXMtiSLdoSdAtkPhjA5eFHW5FIbg+oSNhtA7vesNEwfh5WORZ9/fISjI55bSO0KRdEXeW4+nWdVY5hhCBa91216QIpt3jvsGTn4LWvW2tWLMZyTFIpNKcW6MTcgd3tBOIbELOPOURylqJMU1AmOY3Jk36hcoEBhlH8cnj6KDb5RkGcfhr0nP5u9/25NxpsweqQrz3M6CSLIWzWlX3mY9SXXtckmmsjH4fgqwP1BcDsZ/PxtgDMrBsvyPWmTCHR1EQEQ3lbWFSZGGGhZUVtp8oLIRvGtP4Mv3J95ebxYd65KivA7kSc2RQtGyxmHdgdQEc3a3glMBEoD0N+EN+V70Ljk8+T5HMkaTlufg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(376002)(136003)(396003)(39860400002)(346002)(366004)(83380400001)(31696002)(38100700002)(186003)(4326008)(36756003)(8676002)(66556008)(66476007)(8936002)(30864003)(5660300002)(31686004)(2906002)(66946007)(6486002)(966005)(6916009)(478600001)(6506007)(316002)(41300700001)(6512007)(26005)(6666004)(53546011)(86362001)(36916002)(2616005)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUdLemFSYkF5cEhYYzZsdTc0QlgxNE1QUGE3L3lscjFveU5JQ0NOOG90dzFB?=
 =?utf-8?B?UHF0bnllMGlLa1lyOE5uN0tzQ1U0bEtaSHNPOWhteUp2UUI0a2FqU2hxR294?=
 =?utf-8?B?WFB3ZnQ2RER4eS9SbS9wbEZ3MHc0akF0bmpWN2x3MVNNSHhib3RaVlFmQ0Ns?=
 =?utf-8?B?WDlVSXJodE1PSUZ2UTlXRERyS0kvMW9BOTVKbk5zSzA5eHNnU3NSZ0hydEg3?=
 =?utf-8?B?Qkw0eDlzQ3BpQlpoU0w2cjgvZWZyZHZOY0ZLTXk1a1AxQ0hVcVRENTdheG84?=
 =?utf-8?B?TUx1RmN2S2daYm1WVEF4RXBiTnZ1R1lNZllEOTAyQVVMZlpaYTB0TFZRRm1F?=
 =?utf-8?B?QkxlR3F6UDRxalRiTVVUNEx1VTF0eHV2SUhUbklpNExiWkxGS2ZBbkRXb25M?=
 =?utf-8?B?c2FkMVdwUzVicC9CZGlGSTRIa2U3eVFOVlF4OGdCdlRJSEZJUU9zbTFsakNG?=
 =?utf-8?B?N1RHbGg2dUxNd2phUE9yYXlxWDRvVG5PTzZjb0pvNlJUYUdjRzRZSE9tT1hj?=
 =?utf-8?B?TmxiWUpXbkxaY0xvVGZsT2JVQUhmakttMCtHdGJDaVVYWmF2STMyK3NEamd4?=
 =?utf-8?B?R0YxaW15TmF1bVR1NGRBTWVZcHBGcjVPWkx2UU82Q3M0VE9XeW91OTFCWVI1?=
 =?utf-8?B?MTBWdXNKYllqYU8zbFNycG1Mbk9VSW5pUFZLVDR1b1Yra083OTRDN2xvb1RY?=
 =?utf-8?B?K0w5dkVzTktGZ0NDSktzMjROdnBrQk9obnRzeVJUZHNGekVsOUN2UjNQNHdW?=
 =?utf-8?B?NlgxZzlVZzJ6cFJTVlFlbEk5NDVhY1MxelVBcEhDVHMvRXNrdE9ZQ2wzZGtR?=
 =?utf-8?B?QmlVYzhEdlFCS3JRcEJVYVNkOUNQcnh6TmZLb1lyMGIwcktidnBTOVZkbnBn?=
 =?utf-8?B?MElqZmFBRTR1dmF6WUFsbnVxZGpiWGpES3pjSElLT2FnNE9aNjZ5ekVYUldx?=
 =?utf-8?B?WmFMZHVybnNaOU1XTXk2VVVKd2dObWV0emxNRXNQNXRJZ01HdFlCK1Z5ckph?=
 =?utf-8?B?UkMvdjlrNXBwMGRWSm5IWEFHK3UrS1VESFNVVzYrRVpjK2lWQm9CN3FOaENN?=
 =?utf-8?B?UTZTM0FmaWsrMnV1cmNaOVFteHNjRy9BbVQ2UUdkK0pHWHZQZkFUNUJOSko5?=
 =?utf-8?B?aDVkVVRYdTh2Y1ZpOXE2SE9aUUdkMXVkS0FTM1RlcUpNNDJWYkl5bXhnemhp?=
 =?utf-8?B?KzdVKzhzZ1BENmM5b3AwZzNtbWpFR29DSGtKc3BMSFpyVHpLTmtuOWpxTFJw?=
 =?utf-8?B?NFNmOFpwN3JKL2F3Zkttb1BCMEdxQW8wdTYwWERTOUlaeEJxMGRhQ1lmVW5R?=
 =?utf-8?B?UDlaK2tRV1Y4YTZzNTVlR1RKeWhMSk44eGUxdkw4QjMyN2duU1ltazZObUtX?=
 =?utf-8?B?OGxjMHdBdHBQSHdwc1hPU2Voc3NLT3A2TW1TenFJbFUzdS94enZ6djhtOEE4?=
 =?utf-8?B?UnJQTmkwYkx5cXMzSW1sejRTdEE0aHN0aHBlc3dzbUZkYWpveDF3UzZhZ0d6?=
 =?utf-8?B?NiszNnkzelBYL1VMamJxUTh0T3FSV1BkRm0rb21aUFBSOXM5U2tObHlNVk1l?=
 =?utf-8?B?N1R4aWdmeXBielQ3a3dBVU9uTVVDNDA5VllnOTNIcEh2WWlWZHpUak9xdXNS?=
 =?utf-8?B?c2YyM05IemZJOGtsOXhVZVVHbHV5ZXZHcGJoSWdPZUU4VzkxNjJ0dmlwN0JX?=
 =?utf-8?B?Q3R4NEV2Yy84ZDBDUVphUVlqUUExa1AwcmUwbU1XNWZqS2FWZWRjYnhING5N?=
 =?utf-8?B?Qk9VWjVEbEo3dFpmMndjVWlNOTg5bGo3cS94aXRURk5CRW4yNVB3S0k4MFpF?=
 =?utf-8?B?NmxRMmkzTm83R0ZONWw1WEgzM3hUVTc1cW5zbnY0TVk0eGJ2TGRyaHlwQmdL?=
 =?utf-8?B?SzEyMUM5TjE1VzUrSU9xNFY3T2I5S2VIdTBrQXh6cDVnVjBPSGxIcVh0N0pH?=
 =?utf-8?B?ZHJrUll1YzRDYUw0dXNLSHpRR3NoQW0zOTFYMi92bEM4WnZxZ2ptQUNDVzlK?=
 =?utf-8?B?UGJWTEhyUm9yaXFsa3ZOOVgwbHdFb1RjcEF1Q0JOVUdkbWZYMUd0Qkt0b2F5?=
 =?utf-8?B?YS9XSVgvV2RuZkszN0k5Q2xsUWhrUlpjWDlKbkRVd1lWUlZzZVp5YnJqY1ow?=
 =?utf-8?Q?TRXY/WxFBH58iMNfWOUWptdep?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c13a2059-3218-4925-9272-08da74ef3fb6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 01:26:54.3625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EitbRWHKVcx3F+GJjHLcIkKVWKgyYZ628fTarOd2vTGnnfAPeQ7GGYW4qS3P/eoW166s2mKOGrS9nzkHR8GKHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_15,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030005
X-Proofpoint-ORIG-GUID: UNmC3wKekjR6rW08pYKFdCk4V1leFW71
X-Proofpoint-GUID: UNmC3wKekjR6rW08pYKFdCk4V1leFW71
Cc: "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, Eli Cohen <elic@nvidia.com>
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

CgpPbiA4LzEvMjAyMiAxMTozMyBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBUdWUsIEF1ZyAy
LCAyMDIyIGF0IDY6NTggQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90
ZToKPj4KPj4KPj4gT24gOC8xLzIwMjIgMzo1MyBQTSwgU2ktV2VpIExpdSB3cm90ZToKPj4+Cj4+
PiBPbiA3LzMxLzIwMjIgOTo0NCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+PiDlnKggMjAyMi83
LzMwIDA0OjU1LCBTaS1XZWkgTGl1IOWGmemBkzoKPj4+Pj4KPj4+Pj4gT24gNy8yOC8yMDIyIDc6
MDQgUE0sIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4+Pj4+Pgo+Pj4+Pj4gT24gNy8yOS8yMDIyIDU6
NDggQU0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+Pj4KPj4+Pj4+PiBPbiA3LzI3LzIwMjIgNzo0
MyBQTSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPj4+Pj4+Pj4KPj4+Pj4+Pj4gT24gNy8yOC8yMDIy
IDg6NTYgQU0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gT24gNy8yNy8y
MDIyIDQ6NDcgQU0sIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBP
biA3LzI3LzIwMjIgNTo0MyBQTSwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+Pj4+Pj4gU29ycnkg
dG8gY2hpbWUgaW4gbGF0ZSBpbiB0aGUgZ2FtZS4gRm9yIHNvbWUgcmVhc29uIEkgY291bGRuJ3QK
Pj4+Pj4+Pj4+Pj4gZ2V0IHRvIG1vc3QgZW1haWxzIGZvciB0aGlzIGRpc2N1c3Npb24gKEkgb25s
eSBzdWJzY3JpYmVkIHRvCj4+Pj4+Pj4+Pj4+IHRoZSB2aXJ0dWFsaXphdGlvbiBsaXN0KSwgd2hp
bGUgSSB3YXMgdGFraW5nIG9mZiBhbW9uZ3N0IHRoZQo+Pj4+Pj4+Pj4+PiBwYXN0IGZldyB3ZWVr
cy4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gSXQgbG9va3MgdG8gbWUgdGhpcyBwYXRjaCBpcyBp
bmNvbXBsZXRlLiBOb3RlZCBkb3duIHRoZSB3YXkgaW4KPj4+Pj4+Pj4+Pj4gdmRwYV9kZXZfbmV0
X2NvbmZpZ19maWxsKCksIHdlIGhhdmUgdGhlIGZvbGxvd2luZzoKPj4+Pj4+Pj4+Pj4gICAgICAg
ICAgIGZlYXR1cmVzID0gdmRldi0+Y29uZmlnLT5nZXRfZHJpdmVyX2ZlYXR1cmVzKHZkZXYpOwo+
Pj4+Pj4+Pj4+PiAgICAgICAgICAgaWYgKG5sYV9wdXRfdTY0XzY0Yml0KG1zZywKPj4+Pj4+Pj4+
Pj4gVkRQQV9BVFRSX0RFVl9ORUdPVElBVEVEX0ZFQVRVUkVTLCBmZWF0dXJlcywKPj4+Pj4+Pj4+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWRFBBX0FUVFJfUEFEKSkKPj4+Pj4+
Pj4+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTVNHU0laRTsKPj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4gTWFraW5nIGNhbGwgdG8gLmdldF9kcml2ZXJfZmVhdHVyZXMoKSBkb2Vzbid0IG1h
a2Ugc2Vuc2Ugd2hlbgo+Pj4+Pj4+Pj4+PiBmZWF0dXJlIG5lZ290aWF0aW9uIGlzbid0IGNvbXBs
ZXRlLiBOZWl0aGVyIHNob3VsZCBwcmVzZW50Cj4+Pj4+Pj4+Pj4+IG5lZ290aWF0ZWRfZmVhdHVy
ZXMgdG8gdXNlcnNwYWNlIGJlZm9yZSBuZWdvdGlhdGlvbiBpcyBkb25lLgo+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+PiBTaW1pbGFybHksIG1heF92cXAgdGhyb3VnaCB2ZHBhX2Rldl9uZXRfbXFfY29u
ZmlnX2ZpbGwoKQo+Pj4+Pj4+Pj4+PiBwcm9iYWJseSBzaG91bGQgbm90IHNob3cgYmVmb3JlIG5l
Z290aWF0aW9uIGlzIGRvbmUgLSBpdAo+Pj4+Pj4+Pj4+PiBkZXBlbmRzIG9uIGRyaXZlciBmZWF0
dXJlcyBuZWdvdGlhdGVkLgo+Pj4+Pj4+Pj4+IEkgaGF2ZSBhbm90aGVyIHBhdGNoIGluIHRoaXMg
c2VyaWVzIGludHJvZHVjZXMgZGV2aWNlX2ZlYXR1cmVzCj4+Pj4+Pj4+Pj4gYW5kIHdpbGwgcmVw
b3J0IGRldmljZV9mZWF0dXJlcyB0byB0aGUgdXNlcnNwYWNlIGV2ZW4gZmVhdHVyZXMKPj4+Pj4+
Pj4+PiBuZWdvdGlhdGlvbiBub3QgZG9uZS4gQmVjYXVzZSB0aGUgc3BlYyBzYXlzIHdlIHNob3Vs
ZCBhbGxvdwo+Pj4+Pj4+Pj4+IGRyaXZlciBhY2Nlc3MgdGhlIGNvbmZpZyBzcGFjZSBiZWZvcmUg
RkVBVFVSRVNfT0suCj4+Pj4+Pj4+PiBUaGUgY29uZmlnIHNwYWNlIGNhbiBiZSBhY2Nlc3NlZCBi
eSBndWVzdCBiZWZvcmUgZmVhdHVyZXNfb2sKPj4+Pj4+Pj4+IGRvZXNuJ3QgbmVjZXNzYXJpbHkg
bWVhbiB0aGUgdmFsdWUgaXMgdmFsaWQuIFlvdSBtYXkgd2FudCB0bwo+Pj4+Pj4+Pj4gZG91Ymxl
IGNoZWNrIHdpdGggTWljaGFlbCBmb3Igd2hhdCBoZSBxdW90ZWQgZWFybGllcjoKPj4+Pj4+Pj4g
dGhhdCdzIHdoeSBJIHByb3Bvc2VkIHRvIGZpeCB0aGVzZSBpc3N1ZXMsIGUuZy4sIGlmIG5vIF9G
X01BQywKPj4+Pj4+Pj4gdkRQQSBrZXJuZWwgc2hvdWxkIG5vdCByZXR1cm4gYSBtYWMgdG8gdGhl
IHVzZXJzcGFjZSwgdGhlcmUgaXMKPj4+Pj4+Pj4gbm90IGEgZGVmYXVsdCB2YWx1ZSBmb3IgbWFj
Lgo+Pj4+Pj4+IFRoZW4gcGxlYXNlIHNob3cgdXMgdGhlIGNvZGUsIGFzIEkgY2FuIG9ubHkgY29t
bWVudCBiYXNlZCBvbiB5b3VyCj4+Pj4+Pj4gbGF0ZXN0ICh2NCkgcGF0Y2ggYW5kIGl0IHdhcyBu
b3QgdGhlcmUuLiBUbyBiZSBob25lc3QsIEkgZG9uJ3QKPj4+Pj4+PiB1bmRlcnN0YW5kIHRoZSBt
b3RpdmF0aW9uIGFuZCB0aGUgdXNlIGNhc2VzIHlvdSBoYXZlLCBpcyBpdCBmb3IKPj4+Pj4+PiBk
ZWJ1Z2dpbmcvbW9uaXRvcmluZyBvciB0aGVyZSdzIHJlYWxseSBhIHVzZSBjYXNlIGZvciBsaXZl
Cj4+Pj4+Pj4gbWlncmF0aW9uPyBGb3IgdGhlIGZvcm1lciwgeW91IGNhbiBkbyBhIGRpcmVjdCBk
dW1wIG9uIGFsbCBjb25maWcKPj4+Pj4+PiBzcGFjZSBmaWVsZHMgcmVnYXJkbGVzcyBvZiBlbmRp
YW5lc3MgYW5kIGZlYXR1cmUgbmVnb3RpYXRpb24KPj4+Pj4+PiB3aXRob3V0IGhhdmluZyB0byB3
b3JyeSBhYm91dCB2YWxpZGl0eSAobWVhbmluZ2Z1bCB0byBwcmVzZW50IHRvCj4+Pj4+Pj4gYWRt
aW4gdXNlcikuIFRvIG1lIHRoZXNlIGFyZSBjb25mbGljdCBhc2tzIHRoYXQgaXMgaW1wb3NzaWJs
ZSB0bwo+Pj4+Pj4+IG1peCBpbiBleGFjdCBvbmUgY29tbWFuZC4KPj4+Pj4+IFRoaXMgYnVnIGp1
c3QgaGFzIGJlZW4gcmV2ZWFsZWQgdHdvIGRheXMsIGFuZCB5b3Ugd2lsbCBzZWUgdGhlCj4+Pj4+
PiBwYXRjaCBzb29uLgo+Pj4+Pj4KPj4+Pj4+IFRoZXJlIGFyZSBzb21ldGhpbmcgdG8gY2xhcmlm
eToKPj4+Pj4+IDEpIHdlIG5lZWQgdG8gcmVhZCB0aGUgZGV2aWNlIGZlYXR1cmVzLCBvciBob3cg
Y2FuIHlvdSBwaWNrIGEKPj4+Pj4+IHByb3BlciBMTSBkZXN0aW5hdGlvbgo+Pj4+Cj4+Pj4gU28g
aXQncyBwcm9iYWJseSBub3QgdmVyeSBlZmZpY2llbnQgdG8gdXNlIHRoaXMsIHRoZSBtYW5hZ2Vy
IGxheWVyCj4+Pj4gc2hvdWxkIGhhdmUgdGhlIGtub3dsZWRnZSBhYm91dCB0aGUgY29tcGF0aWJp
bGl0eSBiZWZvcmUgZG9pbmcKPj4+PiBtaWdyYXRpb24gb3RoZXIgdGhhbiB0cnktYW5kLWZhaWwu
Cj4+Pj4KPj4+PiBBbmQgaXQncyB0aGUgdGFzayBvZiB0aGUgbWFuYWdlbWVudCB0byBnYXRoZXIg
dGhlIG5vZGVzIHdob3NlIGRldmljZXMKPj4+PiBjb3VsZCBiZSBsaXZlIG1pZ3JhdGVkIHRvIGVh
Y2ggb3RoZXIgYXMgc29tZXRoaW5nIGxpa2UgImNsdXN0ZXIiCj4+Pj4gd2hpY2ggd2UndmUgYWxy
ZWFkeSB1c2VkIGluIHRoZSBjYXNlIG9mIGNwdWZsYWdzLgo+Pj4+Cj4+Pj4gMSkgZHVyaW5nIG5v
ZGUgYm9vdHN0cmFwLCB0aGUgY2FwYWJpbGl0eSBvZiBlYWNoIG5vZGUgYW5kIGRldmljZXMgd2Fz
Cj4+Pj4gcmVwb3J0ZWQgdG8gbWFuYWdlbWVudCBsYXllcgo+Pj4+IDIpIG1hbmFnZW1lbnQgbGF5
ZXIgZGVjaWRlIHRoZSBjbHVzdGVyIGFuZCBtYWtlIHN1cmUgdGhlIG1pZ3JhdGlvbgo+Pj4+IGNh
biBvbmx5IGRvbmUgYW1vbmcgdGhlIG5vZGVzIGluc2lkZXMgdGhlIGNsdXN0ZXIKPj4+PiAzKSBi
ZWZvcmUgbWlncmF0aW9uLCB0aGUgdkRQQSBuZWVkcyB0byBiZSBwcm92aXNpb25lZCBvbiB0aGUg
ZGVzdGluYXRpb24KPj4+Pgo+Pj4+Cj4+Pj4+PiAyKSB2ZHBhIGRldiBjb25maWcgc2hvdyBjYW4g
c2hvdyBib3RoIGRldmljZSBmZWF0dXJlcyBhbmQgZHJpdmVyCj4+Pj4+PiBmZWF0dXJlcywgdGhl
cmUganVzdCBuZWVkIGEgcGF0Y2ggZm9yIGlwcm91dGUyCj4+Pj4+PiAzKSBUbyBwcm9jZXNzIGlu
Zm9ybWF0aW9uIGxpa2UgTVEsIHdlIGRvbid0IGp1c3QgZHVtcCB0aGUgY29uZmlnCj4+Pj4+PiBz
cGFjZSwgTVNUIGhhcyBleHBsYWluZWQgYmVmb3JlCj4+Pj4+IFNvLCBpdCdzIGZvciBsaXZlIG1p
Z3JhdGlvbi4uLiBUaGVuIHdoeSBub3QgZXhwb3J0IHRob3NlIGNvbmZpZwo+Pj4+PiBwYXJhbWV0
ZXJzIHNwZWNpZmllZCBmb3IgdmRwYSBjcmVhdGlvbiAoYXMgd2VsbCBhcyBkZXZpY2UgZmVhdHVy
ZQo+Pj4+PiBiaXRzKSB0byB0aGUgb3V0cHV0IG9mICJ2ZHBhIGRldiBzaG93IiBjb21tYW5kPyBU
aGF0J3Mgd2hlcmUgZGV2aWNlCj4+Pj4+IHNpZGUgY29uZmlnIGxpdmVzIGFuZCBpcyBzdGF0aWMg
YWNyb3NzIHZkcGEncyBsaWZlIGN5Y2xlLiAidmRwYSBkZXYKPj4+Pj4gY29uZmlnIHNob3ciIGlz
IG1vc3RseSBmb3IgZHluYW1pYyBkcml2ZXIgc2lkZSBjb25maWcsIGFuZCB0aGUKPj4+Pj4gdmFs
aWRpdHkgaXMgc3ViamVjdCB0byBmZWF0dXJlIG5lZ290aWF0aW9uLiBJIHN1cHBvc2UgdGhpcyBz
aG91bGQKPj4+Pj4gc3VpdCB5b3VyIG5lZWQgb2YgTE0sIGUuZy4KPj4+Pgo+Pj4+IEkgdGhpbmsg
c28uCj4+Pj4KPj4+Pgo+Pj4+PiAkIHZkcGEgZGV2IGFkZCBuYW1lIHZkcGExIG1nbXRkZXYgcGNp
LzAwMDA6NDE6MDQuMiBtYXhfdnFwIDcgbXR1IDIwMDAKPj4+Pj4gJCB2ZHBhIGRldiBzaG93IHZk
cGExCj4+Pj4+IHZkcGExOiB0eXBlIG5ldHdvcmsgbWdtdGRldiBwY2kvMDAwMDo0MTowNC4yIHZl
bmRvcl9pZCA1NTU1IG1heF92cXMKPj4+Pj4gMTUgbWF4X3ZxX3NpemUgMjU2Cj4+Pj4+ICAgIG1h
eF92cXAgNyBtdHUgMjAwMAo+Pj4+PiAgICBkZXZfZmVhdHVyZXMgQ1NVTSBHVUVTVF9DU1VNIE1U
VSBIT1NUX1RTTzQgSE9TVF9UU082IFNUQVRVUwo+Pj4+PiBDVFJMX1ZRIE1RIENUUkxfTUFDX0FE
RFIgVkVSU0lPTl8xIFJJTkdfUEFDS0VECj4+Pj4KPj4+PiBOb3RlIHRoYXQgdGhlIG1nbXQgc2hv
dWxkIGtub3cgdGhpcyBkZXN0aW5hdGlvbiBoYXZlIHRob3NlCj4+Pj4gY2FwYWJpbGl0eS9mZWF0
dXJlcyBiZWZvcmUgdGhlIHByb3Zpc2lvbmluZy4KPj4+IFllcywgbWdtdCBzb2Z0d2FyZSBzaG91
bGQgaGF2ZSB0byBjaGVjayB0aGUgYWJvdmUgZnJvbSBzb3VyY2UuCj4+IE9uIGRlc3RpbmF0aW9u
IG1nbXQgc29mdHdhcmUgY2FuIHJ1biBiZWxvdyB0byBjaGVjayB2ZHBhIG1nbXRkZXYncwo+PiBj
YXBhYmlsaXR5L2ZlYXR1cmVzOgo+Pgo+PiAkIHZkcGEgbWdtdGRldiBzaG93IHBjaS8wMDAwOjQx
OjA0LjMKPj4gcGNpLzAwMDA6NDE6MDQuMzoKPj4gICAgIHN1cHBvcnRlZF9jbGFzc2VzIG5ldAo+
PiAgICAgbWF4X3N1cHBvcnRlZF92cXMgMjU3Cj4+ICAgICBkZXZfZmVhdHVyZXMgQ1NVTSBHVUVT
VF9DU1VNIE1UVSBIT1NUX1RTTzQgSE9TVF9UU082IFNUQVRVUyBDVFJMX1ZRCj4+IE1RIENUUkxf
TUFDX0FERFIgVkVSU0lPTl8xIFJJTkdfUEFDS0VECj4gUmlnaHQgYW5kIHRoaXMgaXMgcHJvYmFi
bHkgYmV0dGVyIHRvIGJlIGRvbmUgYXQgbm9kZSBib290c3RyYXBwaW5nIGZvcgo+IHRoZSBtYW5h
Z2VtZW50IHRvIGtub3cgYWJvdXQgdGhlIGNsdXN0ZXIuCkV4YWN0bHkuIFRoYXQncyB3aGF0IG1n
bXQgc29mdHdhcmUgaXMgc3VwcG9zZWQgdG8gZG8gdHlwaWNhbGx5LgoKVGhhbmtzLAotU2l3ZWkK
Cj4KPiBUaGFua3MKPgo+Pj4+Cj4+Pj4+IEZvciBpdCB0byB3b3JrLCB5b3UnZCB3YW50IHRvIHBh
c3MgInN0cnVjdCB2ZHBhX2Rldl9zZXRfY29uZmlnIiB0bwo+Pj4+PiBfdmRwYV9yZWdpc3Rlcl9k
ZXZpY2UoKSBkdXJpbmcgcmVnaXN0cmF0aW9uLCBhbmQgZ2V0IGl0IHNhdmVkIHRoZXJlCj4+Pj4+
IGluICJzdHJ1Y3QgdmRwYV9kZXZpY2UiLiBUaGVuIGluIHZkcGFfZGV2X2ZpbGwoKSBzaG93IGVh
Y2ggZmllbGQKPj4+Pj4gY29uZGl0aW9uYWxseSBzdWJqZWN0IHRvICJzdHJ1Y3QgdmRwYV9kZXZf
c2V0X2NvbmZpZy5tYXNrIi4KPj4+Pj4KPj4+Pj4gVGhhbmtzLAo+Pj4+PiAtU2l3ZWkKPj4+Pgo+
Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4+IFRoYW5rcwo+Pj4+Pj4gWmh1IExpbmdzaGFuCj4+
Pj4+Pj4+Pj4gTm9wZToKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IDIuNS4xICBEcml2ZXIgUmVxdWly
ZW1lbnRzOiBEZXZpY2UgQ29uZmlndXJhdGlvbiBTcGFjZQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4g
Li4uCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBGb3Igb3B0aW9uYWwgY29uZmlndXJhdGlvbiBzcGFj
ZSBmaWVsZHMsIHRoZSBkcml2ZXIgTVVTVCBjaGVjawo+Pj4+Pj4+Pj4+IHRoYXQgdGhlIGNvcnJl
c3BvbmRpbmcgZmVhdHVyZSBpcyBvZmZlcmVkCj4+Pj4+Pj4+Pj4gYmVmb3JlIGFjY2Vzc2luZyB0
aGF0IHBhcnQgb2YgdGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UuCj4+Pj4+Pj4+PiBhbmQgaG93IG1h
bnkgZHJpdmVyIGJ1Z3MgdGFraW5nIHdyb25nIGFzc3VtcHRpb24gb2YgdGhlIHZhbGlkaXR5Cj4+
Pj4+Pj4+PiBvZiBjb25maWcgc3BhY2UgZmllbGQgd2l0aG91dCBmZWF0dXJlc19vay4gSSBhbSBu
b3Qgc3VyZSB3aGF0Cj4+Pj4+Pj4+PiB1c2UgY2FzZSB5b3Ugd2FudCB0byBleHBvc2UgY29uZmln
IHJlc2lzdGVyIHZhbHVlcyBmb3IgYmVmb3JlCj4+Pj4+Pj4+PiBmZWF0dXJlc19vaywgaWYgaXQn
cyBtb3N0bHkgZm9yIGxpdmUgbWlncmF0aW9uIEkgZ3Vlc3MgaXQncwo+Pj4+Pj4+Pj4gcHJvYmFi
bHkgaGVhZGluZyBhIHdyb25nIGRpcmVjdGlvbi4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+PiBMYXN0IGJ1dCBub3QgdGhlIGxlYXN0LCB0aGlzICJ2ZHBhIGRldiBj
b25maWciIGNvbW1hbmQgd2FzIG5vdAo+Pj4+Pj4+Pj4+PiBkZXNpZ25lZCB0byBkaXNwbGF5IHRo
ZSByZWFsIGNvbmZpZyBzcGFjZSByZWdpc3RlciB2YWx1ZXMgaW4KPj4+Pj4+Pj4+Pj4gdGhlIGZp
cnN0IHBsYWNlLiBRdW90aW5nIHRoZSB2ZHBhLWRldig4KSBtYW4gcGFnZToKPj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+IHZkcGEgZGV2IGNvbmZpZyBzaG93IC0gU2hvdyBjb25maWd1cmF0aW9uIG9m
IHNwZWNpZmljIGRldmljZQo+Pj4+Pj4+Pj4+Pj4gb3IgYWxsIGRldmljZXMuCj4+Pj4+Pj4+Pj4+
PiBERVYgLSBzcGVjaWZpZXMgdGhlIHZkcGEgZGV2aWNlIHRvIHNob3cgaXRzIGNvbmZpZ3VyYXRp
b24uIElmCj4+Pj4+Pj4+Pj4+PiB0aGlzIGFyZ3VtZW50IGlzIG9taXR0ZWQgYWxsIGRldmljZXMg
Y29uZmlndXJhdGlvbiBpcyBsaXN0ZWQuCj4+Pj4+Pj4+Pj4+IEl0IGRvZXNuJ3Qgc2F5IGFueXRo
aW5nIGFib3V0IGNvbmZpZ3VyYXRpb24gc3BhY2Ugb3IgcmVnaXN0ZXIKPj4+Pj4+Pj4+Pj4gdmFs
dWVzIGluIGNvbmZpZyBzcGFjZS4gQXMgbG9uZyBhcyBpdCBjYW4gY29udmV5IHRoZSBjb25maWcK
Pj4+Pj4+Pj4+Pj4gYXR0cmlidXRlIHdoZW4gaW5zdGFudGlhdGluZyB2RFBBIGRldmljZSBpbnN0
YW5jZSwgYW5kIG1vcmUKPj4+Pj4+Pj4+Pj4gaW1wb3J0YW50bHksIHRoZSBjb25maWcgY2FuIGJl
IGVhc2lseSBpbXBvcnRlZCBmcm9tIG9yCj4+Pj4+Pj4+Pj4+IGV4cG9ydGVkIHRvIHVzZXJzcGFj
ZSB0b29scyB3aGVuIHRyeWluZyB0byByZWNvbnN0cnVjdCB2ZHBhCj4+Pj4+Pj4+Pj4+IGluc3Rh
bmNlIGludGFjdCBvbiBkZXN0aW5hdGlvbiBob3N0IGZvciBsaXZlIG1pZ3JhdGlvbiwgSU1ITwo+
Pj4+Pj4+Pj4+PiBpbiBteSBwZXJzb25hbCBpbnRlcnByZXRhdGlvbiBpdCBkb2Vzbid0IG1hdHRl
ciB3aGF0IHRoZQo+Pj4+Pj4+Pj4+PiBjb25maWcgc3BhY2UgbWF5IHByZXNlbnQuIEl0IG1heSBi
ZSB3b3J0aCB3aGlsZSBhZGRpbmcgYSBuZXcKPj4+Pj4+Pj4+Pj4gZGVidWcgY29tbWFuZCB0byBl
eHBvc2UgdGhlIHJlYWwgcmVnaXN0ZXIgdmFsdWUsIGJ1dCB0aGF0J3MKPj4+Pj4+Pj4+Pj4gYW5v
dGhlciBzdG9yeS4KPj4+Pj4+Pj4+PiBJIGFtIG5vdCBzdXJlIGdldHRpbmcgeW91ciBwb2ludHMu
IHZEUEEgbm93IHJlcG9ydHMgZGV2aWNlCj4+Pj4+Pj4+Pj4gZmVhdHVyZSBiaXRzKGRldmljZV9m
ZWF0dXJlcykgYW5kIG5lZ290aWF0ZWQgZmVhdHVyZQo+Pj4+Pj4+Pj4+IGJpdHMoZHJpdmVyX2Zl
YXR1cmVzKSwgYW5kIHllcywgdGhlIGRyaXZlcnMgZmVhdHVyZXMgY2FuIGJlIGEKPj4+Pj4+Pj4+
PiBzdWJzZXQgb2YgdGhlIGRldmljZSBmZWF0dXJlczsgYW5kIHRoZSB2RFBBIGRldmljZSBmZWF0
dXJlcyBjYW4KPj4+Pj4+Pj4+PiBiZSBhIHN1YnNldCBvZiB0aGUgbWFuYWdlbWVudCBkZXZpY2Ug
ZmVhdHVyZXMuCj4+Pj4+Pj4+PiBXaGF0IEkgc2FpZCBpcyBhZnRlciB1bmJsb2NraW5nIHRoZSBj
b25kaXRpb25hbCBjaGVjaywgeW91J2QKPj4+Pj4+Pj4+IGhhdmUgdG8gaGFuZGxlIHRoZSBjYXNl
IGZvciBlYWNoIG9mIHRoZSB2ZHBhIGF0dHJpYnV0ZSB3aGVuCj4+Pj4+Pj4+PiBmZWF0dXJlIG5l
Z290aWF0aW9uIGlzIG5vdCB5ZXQgZG9uZTogYmFzaWNhbGx5IHRoZSByZWdpc3Rlcgo+Pj4+Pj4+
Pj4gdmFsdWVzIHlvdSBnb3QgZnJvbSBjb25maWcgc3BhY2UgdmlhIHRoZQo+Pj4+Pj4+Pj4gdmRw
YV9nZXRfY29uZmlnX3VubG9ja2VkKCkgY2FsbCBpcyBub3QgY29uc2lkZXJlZCB0byBiZSB2YWxp
ZAo+Pj4+Pj4+Pj4gYmVmb3JlIGZlYXR1cmVzX29rIChwZXItc3BlYykuIEFsdGhvdWdoIGluIHNv
bWUgY2FzZSB5b3UgbWF5IGdldAo+Pj4+Pj4+Pj4gc2FuZSB2YWx1ZSwgc3VjaCBiZWhhdmlvciBp
cyBnZW5lcmFsbHkgdW5kZWZpbmVkLiBJZiB5b3UgZGVzaXJlCj4+Pj4+Pj4+PiB0byBzaG93IGp1
c3QgdGhlIGRldmljZV9mZWF0dXJlcyBhbG9uZSB3aXRob3V0IGFueSBjb25maWcgc3BhY2UKPj4+
Pj4+Pj4+IGZpZWxkLCB3aGljaCB0aGUgZGV2aWNlIGhhZCBhZHZlcnRpc2VkICpiZWZvcmUgZmVh
dHVyZQo+Pj4+Pj4+Pj4gbmVnb3RpYXRpb24gaXMgY29tcGxldGUqLCB0aGF0J2xsIGJlIGZpbmUu
IEJ1dCBsb29rcyB0byBtZSB0aGlzCj4+Pj4+Pj4+PiBpcyBub3QgaG93IHBhdGNoIGhhcyBiZWVu
IGltcGxlbWVudGVkLiBQcm9iYWJseSBuZWVkIHNvbWUgbW9yZQo+Pj4+Pj4+Pj4gd29yaz8KPj4+
Pj4+Pj4gVGhleSBhcmUgZHJpdmVyX2ZlYXR1cmVzKG5lZ290aWF0ZWQpIGFuZCB0aGUKPj4+Pj4+
Pj4gZGV2aWNlX2ZlYXR1cmVzKHdoaWNoIGNvbWVzIHdpdGggdGhlIGRldmljZSksIGFuZCB0aGUg
Y29uZmlnCj4+Pj4+Pj4+IHNwYWNlIGZpZWxkcyB0aGF0IGRlcGVuZCBvbiB0aGVtLiBJbiB0aGlz
IHNlcmllcywgd2UgcmVwb3J0IGJvdGgKPj4+Pj4+Pj4gdG8gdGhlIHVzZXJzcGFjZS4KPj4+Pj4+
PiBJIGZhaWwgdG8gdW5kZXJzdGFuZCB3aGF0IHlvdSB3YW50IHRvIHByZXNlbnQgZnJvbSB5b3Vy
Cj4+Pj4+Pj4gZGVzY3JpcHRpb24uIE1heSBiZSB3b3J0aCBzaG93aW5nIHNvbWUgZXhhbXBsZSBv
dXRwdXRzIHRoYXQgYXQKPj4+Pj4+PiBsZWFzdCBpbmNsdWRlIHRoZSBmb2xsb3dpbmcgY2FzZXM6
IDEpIHdoZW4gZGV2aWNlIG9mZmVycyBmZWF0dXJlcwo+Pj4+Pj4+IGJ1dCBub3QgeWV0IGFja25v
d2xlZGdlIGJ5IGd1ZXN0IDIpIHdoZW4gZ3Vlc3QgYWNrbm93bGVkZ2VkCj4+Pj4+Pj4gZmVhdHVy
ZXMgYW5kIGRldmljZSBpcyB5ZXQgdG8gYWNjZXB0IDMpIGFmdGVyIGd1ZXN0IGZlYXR1cmUKPj4+
Pj4+PiBuZWdvdGlhdGlvbiBpcyBjb21wbGV0ZWQgKGFncmVlZCB1cG9uIGJldHdlZW4gZ3Vlc3Qg
YW5kIGRldmljZSkuCj4+Pj4+PiBPbmx5IHR3byBmZWF0dXJlIHNldHM6IDEpIHdoYXQgdGhlIGRl
dmljZSBoYXMuICgyKSB3aGF0IGlzIG5lZ290aWF0ZWQKPj4+Pj4+PiBUaGFua3MsCj4+Pj4+Pj4g
LVNpd2VpCj4+Pj4+Pj4+PiBSZWdhcmRzLAo+Pj4+Pj4+Pj4gLVNpd2VpCj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+PiBIYXZpbmcgc2FpZCwgcGxlYXNlIGNvbnNpZGVyIHRvIGRyb3AgdGhlIEZpeGVzIHRh
ZywgYXMgYXBwZWFycwo+Pj4+Pj4+Pj4+PiB0byBtZSB5b3UncmUgcHJvcG9zaW5nIGEgbmV3IGZl
YXR1cmUgcmF0aGVyIHRoYW4gZml4aW5nIGEgcmVhbAo+Pj4+Pj4+Pj4+PiBpc3N1ZS4KPj4+Pj4+
Pj4+PiBpdCdzIGEgbmV3IGZlYXR1cmUgdG8gcmVwb3J0IHRoZSBkZXZpY2UgZmVhdHVyZSBiaXRz
IHRoYW4gb25seQo+Pj4+Pj4+Pj4+IG5lZ290aWF0ZWQgZmVhdHVyZXMsIGhvd2V2ZXIgdGhpcyBw
YXRjaCBpcyBhIG11c3QsIG9yIGl0IHdpbGwKPj4+Pj4+Pj4+PiBibG9jayB0aGUgZGV2aWNlIGZl
YXR1cmUgYml0cyByZXBvcnRpbmcuIGJ1dCBJIGFncmVlLCB0aGUgZml4Cj4+Pj4+Pj4+Pj4gdGFn
IGlzIG5vdCBhIG11c3QuCj4+Pj4+Pj4+Pj4+IFRoYW5rcywKPj4+Pj4+Pj4+Pj4gLVNpd2VpCj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IE9uIDcvMS8yMDIyIDM6MTIgUE0sIFBhcmF2IFBhbmRpdCB2
aWEgVmlydHVhbGl6YXRpb24gd3JvdGU6Cj4+Pj4+Pj4+Pj4+Pj4gRnJvbTogWmh1IExpbmdzaGFu
PGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4+Pj4+Pj4+Pj4gU2VudDogRnJpZGF5LCBKdWx5
IDEsIDIwMjIgOToyOCBBTQo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gVXNlcnMgbWF5IHdh
bnQgdG8gcXVlcnkgdGhlIGNvbmZpZyBzcGFjZSBvZiBhIHZEUEEgZGV2aWNlLAo+Pj4+Pj4+Pj4+
Pj4+IHRvIGNob29zZSBhCj4+Pj4+Pj4+Pj4+Pj4gYXBwcm9wcmlhdGUgb25lIGZvciBhIGNlcnRh
aW4gZ3Vlc3QuIFRoaXMgbWVhbnMgdGhlIHVzZXJzCj4+Pj4+Pj4+Pj4+Pj4gbmVlZCB0byByZWFk
IHRoZQo+Pj4+Pj4+Pj4+Pj4+IGNvbmZpZyBzcGFjZSBiZWZvcmUgRkVBVFVSRVNfT0ssIGFuZCB0
aGUgZXhpc3RlbmNlIG9mIGNvbmZpZwo+Pj4+Pj4+Pj4+Pj4+IHNwYWNlCj4+Pj4+Pj4+Pj4+Pj4g
Y29udGVudHMgZG9lcyBub3QgZGVwZW5kIG9uIEZFQVRVUkVTX09LLgo+Pj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+Pj4gVGhlIHNwZWMgc2F5czoKPj4+Pj4+Pj4+Pj4+PiBUaGUgZGV2aWNlIE1VU1Qg
YWxsb3cgcmVhZGluZyBvZiBhbnkgZGV2aWNlLXNwZWNpZmljCj4+Pj4+Pj4+Pj4+Pj4gY29uZmln
dXJhdGlvbiBmaWVsZAo+Pj4+Pj4+Pj4+Pj4+IGJlZm9yZSBGRUFUVVJFU19PSyBpcyBzZXQgYnkg
dGhlIGRyaXZlci4gVGhpcyBpbmNsdWRlcwo+Pj4+Pj4+Pj4+Pj4+IGZpZWxkcyB3aGljaCBhcmUK
Pj4+Pj4+Pj4+Pj4+PiBjb25kaXRpb25hbCBvbiBmZWF0dXJlIGJpdHMsIGFzIGxvbmcgYXMgdGhv
c2UgZmVhdHVyZSBiaXRzCj4+Pj4+Pj4+Pj4+Pj4gYXJlIG9mZmVyZWQgYnkgdGhlCj4+Pj4+Pj4+
Pj4+Pj4gZGV2aWNlLgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gRml4ZXM6IDMwZWY3YThh
YzhhMDcgKHZkcGE6IFJlYWQgZGV2aWNlIGNvbmZpZ3VyYXRpb24gb25seQo+Pj4+Pj4+Pj4+Pj4+
IGlmIEZFQVRVUkVTX09LKQo+Pj4+Pj4+Pj4+Pj4gRml4IGlzIGZpbmUsIGJ1dCBmaXhlcyB0YWcg
bmVlZHMgY29ycmVjdGlvbiBkZXNjcmliZWQgYmVsb3cuCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4gQWJvdmUgY29tbWl0IGlkIGlzIDEzIGxldHRlcnMgc2hvdWxkIGJlIDEyLgo+Pj4+Pj4+Pj4+
Pj4gQW5kCj4+Pj4+Pj4+Pj4+PiBJdCBzaG91bGQgYmUgaW4gZm9ybWF0Cj4+Pj4+Pj4+Pj4+PiBG
aXhlczogMzBlZjdhOGFjOGEwICgidmRwYTogUmVhZCBkZXZpY2UgY29uZmlndXJhdGlvbiBvbmx5
IGlmCj4+Pj4+Pj4+Pj4+PiBGRUFUVVJFU19PSyIpCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4g
UGxlYXNlIHVzZSBjaGVja3BhdGNoLnBsIHNjcmlwdCBiZWZvcmUgcG9zdGluZyB0aGUgcGF0Y2hl
cyB0bwo+Pj4+Pj4+Pj4+Pj4gY2F0Y2ggdGhlc2UgZXJyb3JzLgo+Pj4+Pj4+Pj4+Pj4gVGhlcmUg
aXMgYSBib3QgdGhhdCBsb29rcyBhdCB0aGUgZml4ZXMgdGFnIGFuZCBpZGVudGlmaWVzIHRoZQo+
Pj4+Pj4+Pj4+Pj4gcmlnaHQga2VybmVsIHZlcnNpb24gdG8gYXBwbHkgdGhpcyBmaXguCj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbjxsaW5nc2hh
bi56aHVAaW50ZWwuY29tPgo+Pj4+Pj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+Pj4+Pj4+ICAgIGRyaXZl
cnMvdmRwYS92ZHBhLmMgfCA4IC0tLS0tLS0tCj4+Pj4+Pj4+Pj4+Pj4gICAgMSBmaWxlIGNoYW5n
ZWQsIDggZGVsZXRpb25zKC0pCj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL3ZkcGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMgaW5kZXgKPj4+Pj4+
Pj4+Pj4+PiA5YjBlMzliMmYwMjIuLmQ3NmIyMmIyZjdhZSAxMDA2NDQKPj4+Pj4+Pj4+Pj4+PiAt
LS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+Pj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBh
L3ZkcGEuYwo+Pj4+Pj4+Pj4+Pj4+IEBAIC04NTEsMTcgKzg1MSw5IEBAIHZkcGFfZGV2X2NvbmZp
Z19maWxsKHN0cnVjdCB2ZHBhX2RldmljZQo+Pj4+Pj4+Pj4+Pj4+ICp2ZGV2LAo+Pj4+Pj4+Pj4+
Pj4+IHN0cnVjdCBza19idWZmICptc2csIHUzMiBwb3J0aWQsICB7Cj4+Pj4+Pj4+Pj4+Pj4gICAg
ICAgIHUzMiBkZXZpY2VfaWQ7Cj4+Pj4+Pj4+Pj4+Pj4gICAgICAgIHZvaWQgKmhkcjsKPj4+Pj4+
Pj4+Pj4+PiAtICAgIHU4IHN0YXR1czsKPj4+Pj4+Pj4+Pj4+PiAgICAgICAgaW50IGVycjsKPj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICBkb3duX3JlYWQoJnZkZXYtPmNmX2xvY2sp
Owo+Pj4+Pj4+Pj4+Pj4+IC0gICAgc3RhdHVzID0gdmRldi0+Y29uZmlnLT5nZXRfc3RhdHVzKHZk
ZXYpOwo+Pj4+Pj4+Pj4+Pj4+IC0gICAgaWYgKCEoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0ZF
QVRVUkVTX09LKSkgewo+Pj4+Pj4+Pj4+Pj4+IC0gICAgICAgIE5MX1NFVF9FUlJfTVNHX01PRChl
eHRhY2ssICJGZWF0dXJlcyBuZWdvdGlhdGlvbiBub3QKPj4+Pj4+Pj4+Pj4+PiBjb21wbGV0ZWQi
KTsKPj4+Pj4+Pj4+Pj4+PiAtICAgICAgICBlcnIgPSAtRUFHQUlOOwo+Pj4+Pj4+Pj4+Pj4+IC0g
ICAgICAgIGdvdG8gb3V0Owo+Pj4+Pj4+Pj4+Pj4+IC0gICAgfQo+Pj4+Pj4+Pj4+Pj4+IC0KPj4+
Pj4+Pj4+Pj4+PiAgICAgICAgaGRyID0gZ2VubG1zZ19wdXQobXNnLCBwb3J0aWQsIHNlcSwgJnZk
cGFfbmxfZmFtaWx5LAo+Pj4+Pj4+Pj4+Pj4+IGZsYWdzLAo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAg
ICAgICAgICAgVkRQQV9DTURfREVWX0NPTkZJR19HRVQpOwo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICBp
ZiAoIWhkcikgewo+Pj4+Pj4+Pj4+Pj4+IC0tCj4+Pj4+Pj4+Pj4+Pj4gMi4zMS4xCj4+Pj4+Pj4+
Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+
Pj4+Pj4+Pj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4+Pj4+Pj4+Pj4+PiBWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+Pj4+Pj4+Pj4+Pj4gaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9uX187ISFBQ1dWNU45TTJSVjk5aFEhTnpPdjVFd19a
MkNQLXpIeUQ3UnNVb1N0TFo1NEtwQjIxUXl1WjhMNjNZVlBMRUdERXd2Y09TRGxJR3hRUEhZLURN
a09hOXNLS1pkQlNhTmtuTVUkCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
