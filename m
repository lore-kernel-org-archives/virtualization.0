Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CBBC433EF
	for <virtualization@archiver.kernel.org>; Thu, 23 Dec 2021 21:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67E8F410C5;
	Thu, 23 Dec 2021 21:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4BveBL-lEVJ; Thu, 23 Dec 2021 21:37:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E296B40495;
	Thu, 23 Dec 2021 21:37:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFA32C002F;
	Thu, 23 Dec 2021 21:37:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16D1DC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 21:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E44C681766
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 21:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ROHftBo0";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="aioGblob"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VgN5SU9EQ2c7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 21:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A86D581749
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 21:37:48 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNLQkid032086; 
 Thu, 23 Dec 2021 21:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=A1z7kdYLoYz+yqiY1b9HZOHDfMoVvi/Xshk2o+fuwWQ=;
 b=ROHftBo0QhrRHit22etu7eqUVYwklDu25sMOEneVTehHUQuXvVx/kVNUTBOZvWMT4ynL
 j4DkNHPJ5t2e9fcGISsTOwfc8jmFHWoCCUoTEdQzLIf6Z/cixSM8ZuNcs+2zR9/JpWKm
 5LvZJWVspD4kGbUht+cYL65VqxGXYgckMxG5whCau3qKvErfQ7BEsAqbIBAbT2KcvkjE
 +uYRFDDr6BTRitvDXq0Ek43feWhbV0XVbm7OTZ+wVuyPsgi0rjL7qtlIDUQQEg+5+IBb
 LfMARGoyrHQtsIFCL+UKd+X0Z4Y4IOcL8UXW4Id7uGlFV9Nqo9Sysrp60WGteLjEiXbk 4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d4vn50dn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Dec 2021 21:37:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BNLaxbd061327;
 Thu, 23 Dec 2021 21:37:46 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
 by aserp3020.oracle.com with ESMTP id 3d17f75mu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Dec 2021 21:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLtt8p5AFwNeffxifEMQxro2RjkJVgDKcpQUBsr6Z53dF+3swCjng+F6zGnNS6uXRqvjgilx0Leer2pGaDIC4rxpF3Kx7Ef3ZvByzotV+u8r0ik/ti1SrUIQCgRWbHNQb9lPmHuF2yX1LzgSbcL8ptJ88xS2EQzpXPmkYxrTdJvwVnnZOKoykVZUnLrDdZwZQWf/iryAL//hl0O2+ODxajjy+Lvqsk5Ijb64qPh0JsNPSn+UAP1GssKGLQefZc7FVpjYJTPaNFD8pwTxNRW3KTWQBDEIjby8+EMxoqRaWFl/pPXbTyGEcm3IVfn27L42Mp5TvXzOuB0MWVcHZBIZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1z7kdYLoYz+yqiY1b9HZOHDfMoVvi/Xshk2o+fuwWQ=;
 b=O4N4EuHjsIl7aWiiIrHRwgJkI2aG9WQOlODXMXtfIbU2ppxO8Y+fXhdwsDmv7Cvw765JtzyH4vijn6KC6+mDAJp1eQilzfDrGuy6GZLgf3KHHv/tiDerJ1K61ZXIAoCbbS0axIx8VfvPmn+RIhHB1XJ5FTurlnixQgyY+XATdd4Gk8gyppypM9wsVi6CdCVczumMG+Vk2sLxZukUXFZ7aLFB7hCnCeV5VmTqk3qMaKwtwCegWxQhd7lh+8d3+GQkuuJtTfb23W2eDUQ5aSc5Of7CBCCmWD3ZmY/9HrJWOTPIjqkIlY9jmLWIaIrtkEOGC9wDb3xE2R1Qh9JyvozcvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1z7kdYLoYz+yqiY1b9HZOHDfMoVvi/Xshk2o+fuwWQ=;
 b=aioGblobLl9fd1NzqLT+P7m8rm6Vd6IPPWAEfnHLvn9Tpnrib6LDHaLUmSZKSiyv8UllvZjIHkeVFk1ERww25Vkwcc+lJlMrbFsHrYEENGNuS6tcAf39aXmWs7+RFl4nPpJFGuDk6jx6duqumyhaPZkdoiG5+NJw855Uc7KdkmA=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BYAPR10MB2838.namprd10.prod.outlook.com (2603:10b6:a03:8f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Thu, 23 Dec
 2021 21:37:44 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::7c7e:4a5e:24e0:309d%3]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 21:37:44 +0000
Message-ID: <82f64bc8-22b9-6d71-1430-b9c14c5e9f46@oracle.com>
Date: Thu, 23 Dec 2021 13:37:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 10/13] vdpa: Support reporting max device virtqueues
Content-Language: en-US
To: Eli Cohen <elic@nvidia.com>
References: <e98dfbaf-8a2d-4cd6-c875-b4780137b0f8@oracle.com>
 <PH0PR12MB54816A7E1D045997B797961BDC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222064728.GE210450@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481C33A91EAE3AADABA73E8DC7D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211222071036.GA213382@mtl-vdi-166.wap.labs.mlnx>
 <84292943-b4de-8162-1fde-fcfab479b629@oracle.com>
 <20211222075402.GA214545@mtl-vdi-166.wap.labs.mlnx>
 <8e93cfc4-b71e-adc5-8b35-337523e3a431@oracle.com>
 <CACGkMEvMAS1PspbRdL-0SHfGkkZLp-1AFQAwCkQPAiZeMzxAHw@mail.gmail.com>
 <47ce323e-c2e4-cf13-063e-78067c03a4d4@oracle.com>
 <20211223053912.GA10014@mtl-vdi-166.wap.labs.mlnx>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20211223053912.GA10014@mtl-vdi-166.wap.labs.mlnx>
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f5e134-b96f-4139-33a2-08d9c65c7438
X-MS-TrafficTypeDiagnostic: BYAPR10MB2838:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2838409B57889881E341D626B17E9@BYAPR10MB2838.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /h5mCDQGVc1QPV3Dhzpm/uNvR94J2x89vojIvNYBKc1aU6cbqbxX/IHC5vD1HqudOztqXYlu8Y547btlzgSMZArFdgL+PgQ+CLNPsa4jT70ILin8vPW9GYVWdWYa7HIMxDYkMlBOoQLTomUlIl9q/82AOuR591AjqVgBXlV0c9cH1vBQeSHb6oOVGKFZ7t+cPTdjJ5kmkGqnym7QUti0wUCBBnOUKVrgNop/XwFPlqXi7MqEBb6k5SGKd06+HTVerii109bcEpmuqsDjeHjT/DUuih+0qjNoXZx2t2C1Cdh3UYVyOFmD6c7iaFG4iGv2j0ikQR5aVgC7DfwfURVvUvqwJveNg82NNQMcfa4dhTZZMAf4k/vhPayA/ltRfZsFhPiuwl/BBwI23Ftsj8T8/K3h1Rseyc8W2HXHuklQ9uW59pJhz2TXWG6vYFQ0WQGO4ENshy93p7tPtZQYmHiwODKeLqF0w7J4Mk/sUOlTsI3QseKq5kgtbIQBkxlGmxAvtOOreEOCEXS+Ke5Pd2VOCvbTLz+l40l9DfwVcp069v5gBxDDhCRw2vfL8XZ176V6Txvkk3NNWQhD/K416ly4UaXFkHjl9GMUE2Kwnp+0wE6mcKdw/aDk9lscZMcjNizodqq5U8RSnFZDGR5N7rel8iAXkgBjuTqp9Bno8Ybl9+eag+FiotfcjhX4o1j9wQQbPONjqWIJrGQvfdGlAXj8WToT0WIfbjlNDkusRSGcEsU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(53546011)(2906002)(316002)(36916002)(6506007)(5660300002)(6666004)(66946007)(8676002)(66476007)(66556008)(31686004)(2616005)(31696002)(38100700002)(6512007)(508600001)(6916009)(186003)(26005)(36756003)(83380400001)(8936002)(54906003)(6486002)(4326008)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9IQmNyQWo2dGhjTDAxZDQ2ODFzYkw4a29XYWxIL0VCRjdEZDhCY3hmd0V0?=
 =?utf-8?B?R2xVWE1ERFV2L1dKWGJBN0wrUGZsOWRiNVh6c2x1OUxyczdWejU0SWRtdUVQ?=
 =?utf-8?B?U092ZDhPc3JVTXJlaWthTlZLMEMwWmRRSEF3RlJvTG1CaTBkZTE4emNuVnpl?=
 =?utf-8?B?WHhOTzFUa2tPaWhUZVZpWjM2N2ttdEU0TmZIcWtDTi95R3F2NVREQy9zQWp4?=
 =?utf-8?B?bVhET0JaYWRXWk9USmpFVHZKZWx5TkRKeVUwR25LNEtaTkhBSWh1OHBMYURB?=
 =?utf-8?B?OThOejlsNzFqTTJ4ZVNvSkoxSkY5NWYyK082YVNSUnVRbGtrNlptdGVEUDFL?=
 =?utf-8?B?MnNwb05QVkhHTGltc1hJOFZzZ3F0dTc2bytpQ2s4UllBTnN5eGEwb2dqMk1p?=
 =?utf-8?B?UDNtTVZ6WWpMU01MQ0svQW1FQ2VwMkkyc1FFWnVxR0pZQlBrSVpvd1RlWjhm?=
 =?utf-8?B?c1IzRlBXOENFd1o5TUxHZDdFQXRDRnh6ampuemNVeDZrVWZPUzRKOGYybUho?=
 =?utf-8?B?czRpamJldTB4bWpvWjlvWUdvYTlrajJTUEx6amZ6RlMwQnFndkVXTnRlWjIw?=
 =?utf-8?B?VUxTb0VLcG9rTU9IZ3haT1pjdEtxdit4ZGo0OUozUEF4UjRMc3g1dVV4NCtL?=
 =?utf-8?B?ME95VjFxdGxsNlBNZG1HVy9DL1dGL0orTHVHRWlqV2tLZ1FGWm05TzRMZUVZ?=
 =?utf-8?B?TzNkSFpRV2syQnlFbEg2cXd6Q0tNUUM2Y2lMdTBXT2J1eHZ3bHFhV1FBcHQ4?=
 =?utf-8?B?aWNlaEVSN3pLRkdnRzRqb1ZuYUw2Wm9Sd0huS0QvQkRmQ285dW45UVZnU05u?=
 =?utf-8?B?SFNLejgvSmg1Zk1XQ3R6TlNKUTV6bUsvSlNnTGFOZlo2eGlWUjVUcmJGVjhi?=
 =?utf-8?B?aldIR1JpUjVJeGlkcmVXbEpUNzlRYWorZTNDRHM3djhRdlBjb3VqK210VGpu?=
 =?utf-8?B?OGJYd1BBbmg5YzdMR29aVjBhZ2Z1UHFPWXpVZmlBQXVielI5UExITUc5Nmp4?=
 =?utf-8?B?ajdmVHlZakNzbjE2cnB3cVlMVERxWW9Ta2ZiL0c5V1RsTzZXSUo5eFlhNEdl?=
 =?utf-8?B?YVIycEtWV2IvQXJLWHBEZ251TEJSdnV5VEo4Z01FUWhja0ZPUC9NTERQdG1v?=
 =?utf-8?B?dU5TdFhGYllqZlZHN1VLNDl2cENCcnJORTQ4Qzhicml5elNlUjUrTHpDTHly?=
 =?utf-8?B?d0xrbGttc1V0SUpFbHdLTHJ1ZEI3UmRJRjFsU055K2hTRXRpZWEwR2hFT0sz?=
 =?utf-8?B?SkZkbmVGU0NSNDltcFZXSlNWL3VMT2wrazB4ZVFPeitMYVd6aWNaUFUydmE0?=
 =?utf-8?B?UXAvc0YzVldrcjVyNEdpYVdiOHpSdFdaWjBZRGRaRm9vak1CU3hyVndDR2p1?=
 =?utf-8?B?WmtPaVdpbGo3TTBEY0NzZCt4YkJ6TXFYNUwxZHE0TnlXTFUwT3JJd2xRRlJw?=
 =?utf-8?B?TDhpeGFvcGYycy9VRWY4SzMzWEdsN2tnS3FLVzREY2FqWEI4NXllZW14ZUZU?=
 =?utf-8?B?UDNqWXpXMEZkUG1JVEpncGY0ckF1cFkxTlovdGZORTM2dzY5MFZ0aVV2Y3dP?=
 =?utf-8?B?TXVkWGhSTXZqcEYraVExK1g2WXVvOUtzdjMwZ1NuaURHUzM2bnpLVXMxYWlT?=
 =?utf-8?B?YmVLQ2V1K3d6SnlJdXczUVlmMnhWbXlnVkN0TU9GaXdkcktOSTUySDFJWVhq?=
 =?utf-8?B?UjlZb1h0WUNGUy9BY0F6Zk5YYllzQUJlVkVaU0pxZUpabklqY3RCeXlFN0Vv?=
 =?utf-8?B?TmZmc2VxT1V6VCtGSmRiSmxFbGRZbFZTREJoSG9sL1VRSkZ0cUluQzhXT3lh?=
 =?utf-8?B?ajdFMDM2K0hZOVNWMXdNZUE2SzE4a2VLVTRueTdGNVE2YmhtbFY0R2NLS0Z6?=
 =?utf-8?B?S1h2azUxVm1yS3pxUHluVFQxaTRzZm1qSWZDU01YcEZYSDl1OE1rM0pNdk1z?=
 =?utf-8?B?Wk5qVVlyMk5SQXNOajQ3YTYrUHoyb2YwSWttdU82dWpkQmxialArL2xSc2Mz?=
 =?utf-8?B?by82QnFRYmV0NEZWTTROR2JkTEtFWFZ0cWpTVVFPeVVSNlVmNFNlMlY0ZGgy?=
 =?utf-8?B?VGNadnBoUmtRbkQ2U1NzSkVLLzBoeTYreDVPckxkV0JOQnRvdlduZHM0Vkx3?=
 =?utf-8?B?dTBmQTBSUEhBSFMxMW50QTdsakdmUUhmTWs1c3pId1FQOHdWdWNObFl5R1Nu?=
 =?utf-8?Q?vP2qsu7n4q7Tw0DjxDwCkuk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f5e134-b96f-4139-33a2-08d9c65c7438
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 21:37:44.0485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibD3UTkiPsSsVI54xCCYmqoZ8bfj+j/Qdzh5KFg4ehQkT4YasUQtdKN77qkThokImrrpmg8FkzUB+WEC6AV4Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2838
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10207
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230109
X-Proofpoint-GUID: XqxgD48C8xbsbRRATtJgTyJhQTBCBznB
X-Proofpoint-ORIG-GUID: XqxgD48C8xbsbRRATtJgTyJhQTBCBznB
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 12/22/2021 9:39 PM, Eli Cohen wrote:
> On Wed, Dec 22, 2021 at 06:43:38PM -0800, Si-Wei Liu wrote:
>>
>> On 12/22/2021 6:27 PM, Jason Wang wrote:
>>> On Thu, Dec 23, 2021 at 3:25 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 12/21/2021 11:54 PM, Eli Cohen wrote:
>>>>> On Tue, Dec 21, 2021 at 11:29:36PM -0800, Si-Wei Liu wrote:
>>>>>> On 12/21/2021 11:10 PM, Eli Cohen wrote:
>>>>>>> On Wed, Dec 22, 2021 at 09:03:37AM +0200, Parav Pandit wrote:
>>>>>>>>> From: Eli Cohen <elic@nvidia.com>
>>>>>>>>> Sent: Wednesday, December 22, 2021 12:17 PM
>>>>>>>>>
>>>>>>>>>>>> --- a/drivers/vdpa/vdpa.c
>>>>>>>>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>>>>>>>>> @@ -507,6 +507,9 @@ static int vdpa_mgmtdev_fill(const struct
>>>>>>>>>>> vdpa_mgmt_dev *mdev, struct sk_buff *m
>>>>>>>>>>>>                  err = -EMSGSIZE;
>>>>>>>>>>>>                  goto msg_err;
>>>>>>>>>>>>          }
>>>>>>>>>>>> +      if (nla_put_u16(msg, VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,
>>>>>>>>>>>> +                      mdev->max_supported_vqs))
>>>>>>>>>>> It still needs a default value when the field is not explicitly
>>>>>>>>>>> filled in by the driver.
>>>>>>>>>>>
>>>>>>>>>> Unlikely. This can be optional field to help user decide device max limit.
>>>>>>>>>> When max_supported_vqs is set to zero. Vdpa should omit exposing it to user
>>>>>>>>> space.
>>>>>>>>> This is not about what you expose to userspace. It's about the number of VQs
>>>>>>>>> you want to create for a specific instance of vdpa.
>>>>>>>> This value on mgmtdev indicates that a given mgmt device supports creating a vdpa device who can have maximum VQs of N.
>>>>>>>> User will choose to create VQ with VQs <= N depending on its vcpu and other factors.
>>>>>>> You're right.
>>>>>>> So each vendor needs to put there their value.
>>>>>> If I understand Parav correctly, he was suggesting not to expose
>>>>>> VDPA_ATTR_DEV_MGMTDEV_MAX_VQS to userspace if seeing (max_supported_vqs ==
>>>>>> 0) from the driver.
>>>>> I can see the reasoning, but maybe we should leave it as zero which
>>>>> means it was not reported. The user will then need to guess. I believe
>>>>> other vendors will follow with an update so this to a real value.
>>>> Unless you place a check in the vdpa core to enforce it on vdpa
>>>> creation, otherwise it's very likely to get ignored by other vendors.
>>>>
>>>>>> But meanwhile, I do wonder how users tell apart multiqueue supporting parent
>>>>>> from the single queue mgmtdev without getting the aid from this field. I
>>>>>> hope the answer won't be to create a vdpa instance to try.
>>>>>>
>>>>> Do you see a scenario that an admin decides to not instantiate vdpa just
>>>>> because it does not support MQ?
>>>> Yes, there is. If the hardware doesn't support MQ, the provisioning tool
>>>> in the mgmt software will need to fallback to software vhost backend
>>>> with mq=on. At the time the tool is checking out, it doesn't run with
>>>> root privilege.
>>>>
>>>>> And it the management device reports it does support, there's still no
>>>>> guarantee you'll end up with a MQ net device.
>>>> I'm not sure I follow. Do you mean it may be up to the guest feature
>>>> negotiation? But the device itself is still MQ capable, isn't it?
>>> I think we need to clarify the "device" here.
>>>
>>> For compatibility reasons, there could be a case that mgmt doesn't
>>> expect a mq capable vdpa device. So in this case, even if the parent
>>> is MQ capable, the vdpa isn't.
>> Right. The mgmt software is not necessarily libvirt. Perhaps I should be
>> explicit to say the mgmt software we're building would definitely create MQ
>> vdpa device in case on a MQ capable parent.
> OK, to recap:
>
> 1. I think waht you're asking for is to see what the parent device (e.g.
> mlx5_vdpa) is going to report to the virtio driver in the features, at
> the management device.
> So how about I add a features field to struct vdpa_mgmt_dev and return
> it in netlink. Userspace will present it as shown in patch 0008 in v6.
Yes, that's exactly what I want.

>
> 2. Si-Wei, you mentioned you want this information to be available to
> non privileged user. This is the case today.
Yep. As long as it doesn't need to involve creating a vdpa to check out....

Thanks!
-Siwei

>
>> -Siwei
>>
>>> Thanks
>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>>> -Siwei
>>>>>>
>>>>>>>> This is what is exposed to the user to decide the upper bound.
>>>>>>>>>> There has been some talk/patches of rdma virtio device.
>>>>>>>>>> I anticipate such device to support more than 64K queues by nature of rdma.
>>>>>>>>>> It is better to keep max_supported_vqs as u32.
>>>>>>>>> Why not add it when we have it?
>>>>>>>> Sure, with that approach we will end up adding two fields (current u16 and later another u32) due to smaller bit width of current one.
>>>>>>>> Either way is fine. Michael was suggesting similar higher bit-width in other patches, so bringing up here for this field on how he sees it.
>>>>>>> I can use u32 then.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
