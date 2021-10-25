Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F0C4332F
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 16:09:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AAB60ED4
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 16:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D5AAB60ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 992E080C7C;
	Mon, 25 Oct 2021 16:09:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hg_O41OBJRw7; Mon, 25 Oct 2021 16:09:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2F81780C62;
	Mon, 25 Oct 2021 16:09:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01A85C0019;
	Mon, 25 Oct 2021 16:09:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 341D5C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 16:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22B7660653
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 16:09:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="09lsZzDm";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="BSQy6qbr"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q2u4AewIhGqi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 16:09:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 336D76062E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 16:09:21 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PFat6n027182; 
 Mon, 25 Oct 2021 16:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uRnvcFBimxz1jasSBXF4SjQY9M3JpeHXVTulMNQzXGk=;
 b=09lsZzDm7kbY7k8/75PJTEiIc0TanS01ebtN9UAGzLt34xh3XeimXzeRceePRGvMYKCT
 p9awKLWa/6awl6WFGN0ipr2qClrsiyhIa797RgSDEfWr26ncjGZBiN6qz3Rr2Wl2phU9
 9AgO+gXeimRjlPa6k2MiO2K22FbaWdM2al4b7kY6rg+47GLHe9D2DYzd1Pl0RyByiffu
 YlDnzaJCwq+D5aeCVKbl5xFx1zLdEXjj9C4uo9YZ3Z7JCbMIHIdG4CkM6o0yBc2yF9WF
 czk2eFtJ0CR1emgTWK/ra5L0dinBFOF20sEJSUEDFbDHI6Qs9hP9ghjeVMULieD1xhig Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bwx970kxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Oct 2021 16:09:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19PG5rJu022396;
 Mon, 25 Oct 2021 16:09:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by userp3020.oracle.com with ESMTP id 3bvv5s8p36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Oct 2021 16:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZUywN51OfPo38llkWZR10Bk+KLwPOj90LGPgyWVH1pXlSY/rPtrxy5zeG0Zdp5jiK6GtYC5vNXGzKIsU3UeaBpyEzhE4GUIYNexG9jLWA7NGhB1jmeFyQLwyM5rEoSLK51rbfhl0CvMMYlo1eGPJhJBIHhSjX/EGk/qSwyFYMZ9BvVOn00mKXZs/uZyjbjoU+ShGSRrJ5f8cTc4aQgVImDWiI2EL0tQ/mzIaYa/aB0M7fUQVwvXHw5yGirVYTlI+b+kFydl+YZIohtPhVQSi3FMCF3jVIxFLjOjXZANrG164SuJ7vVSfKz52Z9zqfM/sy1NP3y5w46Rdwts32RPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRnvcFBimxz1jasSBXF4SjQY9M3JpeHXVTulMNQzXGk=;
 b=H8QN3oGCUpD6KxViFSKL6KiEboGbQv07WP+OC621UVV4LFLfgirlBATz8ce0PzRnbVIWlpJNJprkla6Pk2T9wm+gYwP7b1+x6e6xvquHwbf462CNDAhujeXNqqsmVclFiKyetPSzVT8/xs+g8GPhT3xLiXUzJ49LKF73wwXED9MkEl633QziErTXqIqigeNXjKPLtjze1P0M8Y/gXGmkBhCHokwktU+hGLd8orjqcPr6Yji9/uMfcmozhTia1I6un4lpcoSpVf4s0tzo1xIiNOnJkKGlXU6LEhtbNe+TztIm1S4lRpUWAMUa3RcG4fC/pgEkp1YX7BKykKkBJMkiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRnvcFBimxz1jasSBXF4SjQY9M3JpeHXVTulMNQzXGk=;
 b=BSQy6qbrxPw+9+EvEaID4PbBkOhRqze3Ab8/eOwriqWRfgkXKm1S5sRMeayETtU3nWaqG62qs1KaazeNWq9b9ykXUDVIiGv6OJkSQ1ZtElODWinTou3xeOhFQ0WxBeSZjfW8dCH5ybOgj7VsUCiBxq/AqdV6PjaPdyNXMIjcRUs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1689.namprd10.prod.outlook.com (2603:10b6:4:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Mon, 25 Oct 2021 16:09:16 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::195:7e6b:efcc:f531%5]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 16:09:16 +0000
Message-ID: <5798a2f1-df67-6bd1-522b-6173aa839e78@oracle.com>
Date: Mon, 25 Oct 2021 11:09:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH V3 06/11] vhost-sock: convert to vq helpers
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-8-michael.christie@oracle.com>
 <20211025090852.4kbqf3gieednw6ie@steredhat>
From: michael.christie@oracle.com
In-Reply-To: <20211025090852.4kbqf3gieednw6ie@steredhat>
X-ClientProxiedBy: DM6PR08CA0044.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from [20.15.0.19] (73.88.28.6) by
 DM6PR08CA0044.namprd08.prod.outlook.com (2603:10b6:5:1e0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.22 via Frontend Transport; Mon, 25 Oct 2021 16:09:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04e0dd75-c585-439c-69d1-08d997d1cb25
X-MS-TrafficTypeDiagnostic: DM5PR10MB1689:
X-Microsoft-Antispam-PRVS: <DM5PR10MB16893B5DA7A574ADB8146DB7F1839@DM5PR10MB1689.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdktG1Z5xGYAWzNVbjjDZHxbP0yCYWN2P5iMq8Z8uGA2zgStvahS6tvccusqw5TwJuBz/1ol6w909HvFPW0j/Om126zEaotrWppQWnuZkZJXDFjZeFruOM8a22xjVeYctSEp4GayTqzMmt7NtSc7cvy+6i9AMlD+L45PNHVqCO59xrG/HqV9Jg+kmrFgD+Aze8TEWfRMVF53yjUWujjuo9qm5OsEKT6A7xr9bB3rYgjJZm+ZOSsLmff27tPciHFvEB4J91kGiLGCWZ3gXWHrt7WxXxNB+7XNBMJWJSu/odu6lGMY0cU3hVVwho3tI+fvt43seeT8GmPxbRYYWTuqXGkiw/ax2pxSQ6Q1pNT92z0kYLCdGTjSRvq9WVF8lpFHIAsKxf8pnOO9JXVzEaJ63XenyGfP4OeWekP9ZwGrenKewWwXxICOtqN1ieOGB/F/wldI8cVSZXMq1GfvPcnUFKLK0I2m/HPcfRQN81E4tyNiZ7TqIrmOr4PI7M+Q7qhkTR3RrkM+OJCFutbq/v6S41x8kq9bZniQvcGjHVYLpIjTQZBOeE1A1P4dZoLMzRI3mHEeL6b1WJQfKXmhCuFesDTPDOImfvIC426M54eU5GkvjihSF1YLWlkDxBO634Ps/N4UBPEhpdD49T0S7cVaBoJQ8AtKUEk+gQvLYASCB/z0jyrYaQ/ZTy+HscPbKFXKBQQbD+oH+uHr1AYnYXjw8TgmhrX0Nrfm6Dybw1EDDhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66946007)(6486002)(2906002)(66476007)(66556008)(4326008)(8936002)(6666004)(8676002)(16576012)(186003)(5660300002)(316002)(6706004)(6916009)(53546011)(9686003)(2616005)(956004)(26005)(508600001)(31686004)(31696002)(83380400001)(38100700002)(86362001)(36756003)(78286007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZytSMjVOL0IxWHhyWG9NNVJvaTNIZ3A5Y0NJUGxUdnNRUXJ0T3kyMWxyWW9t?=
 =?utf-8?B?dG9rNEpBaWpRZmNEQmllNVF6bW5IWHlnQ3huajQwY09jekV5VmFzMGNhUGZC?=
 =?utf-8?B?b2hqL1g0MU5GOUc2NUVHcU5YaXJub21ML2VEWlVQRkR0L3ZVZ3RZam44OEFP?=
 =?utf-8?B?cy9laEJRNXBLY1dTOE10V2JVR0R2dWpuK1lNakZvYkV1YS9mNXU5VzF6aURh?=
 =?utf-8?B?N0l3c2VQUGg1d1U0S3ZPVTJBT092OUZsZmFiS2xxQVdNc2NuSU8wc3VzamxT?=
 =?utf-8?B?S2ZCVllNUkJxWWRuaHhMMUdBVUN2MmNUTEkrZW9jNkhBMHZmelFZVjhDUTFS?=
 =?utf-8?B?amppQ0oxTmIrVE1HVmo4WHRaM0E4cm9VcDdMYVUyKzRXZ2Y4cHp4S0lObENF?=
 =?utf-8?B?SmZYMmJKUEcrUHBUTUt3akJlL0FkMHlBQ3UrQkpUWG12alk2MzZMc2V1cFpM?=
 =?utf-8?B?UDF4Z2pCZ2RwOHpNaTZxZ1I5QVovMnZFVHlGajVNN2dUdkF0b3ZIRE9LTVha?=
 =?utf-8?B?UnNhYWtNSG14R0Y3K09WNG5uc0dkczFYUFI3dm1KUzhoT0ZZcWdKVS9ZZDVa?=
 =?utf-8?B?akJjS1IyTlIydmFkR2hKNjhOb29reHN5Y2FDbVd6bUhWSjZRQmNHVEQvbURD?=
 =?utf-8?B?bHRkcVIyMm9OMGF3cUJiT2xYdnUzQ1RFaC9PakFHT2NJTThzMDh0citvQjBt?=
 =?utf-8?B?RWo0cW50aW0zTHAza3dkODdMODlRaFdkV0RFcWhRajBEK0MyREVGd2lFUnNF?=
 =?utf-8?B?Ty9SelBaMHpLUXc2QVJIT3J0dFBOU2dNV3N2N3JaeHdrcUhwL1kwVjRla3li?=
 =?utf-8?B?SW9kMDBONC84d0dnOTZQMnJ4T2VnMzNOY2dBTVNWTFowSXhCc1BmYTY3eGpp?=
 =?utf-8?B?dWNRY2tPSVUzMUlXaHBhYmtzVGpHeHkxSWZubE1EcWxPSzlINDNnK250V3hE?=
 =?utf-8?B?UnZ2Umk1MFZCS2dxMXNiR2pkK1ZEeHZpYTBUYm5zNzd4Si9oVThuVWtjSXFX?=
 =?utf-8?B?cS9jL3VTQlBrYXdkR0pOY1V1Z1ArU0kyb2VSOFJaaldJUUEzc3BqS1dZR1hi?=
 =?utf-8?B?MmpIQmpTc1NVRFF2N0Z1VE9PVUZnMjZNY2tvRFhlOWhuUWs3VFRMVlVucXNo?=
 =?utf-8?B?WmZ1NSsrdGo1VmF4RDZ0dldBTjJvSldpVmUrWTM0TENDN29tZm9DcHI4QlFL?=
 =?utf-8?B?d3pTcFRWRGF3RVRKZHlHamlNdUlwSWUvN1B0dXJndzBxcXJiVUNDUHhoM205?=
 =?utf-8?B?dDNia0ZNS0tuSUNJMDNURVcveGRnU2l6dXlrdVRpSkRiQWUzcFltTUJGait5?=
 =?utf-8?B?ekN3Vm9NaVVjNFJUcFVDMjFzN3BoVE1VR3hsVXpyeXN6a1BtZjYrOUI0TFdi?=
 =?utf-8?B?TTY2dmVYYjVqYnVzNy9URUw2a1Rsa0t4eURjNTcya29ZUm5lZWdPQWRHaHBB?=
 =?utf-8?B?eFlFRWlkQisyVVRzVkR3TG5FZDRKUlY1eWVuYXRjMFJFY0JLKzFXdDA4aTY4?=
 =?utf-8?B?MSs1cUlWSmRrVVRKR3NTMGRYVnBOdXkxeS8zbjhMc3U5c1VLeHJSTXI1VW9J?=
 =?utf-8?B?MjJjS2RGWUtLUDdtZ1NTcS9HK0QvYlZYeEt2SUJHNW5LTWJHRkpzYy85dXZ3?=
 =?utf-8?B?cG0zaFR2akNrcW94MWlGRHlPMERVMDdyQXk4NndaYkhKbVBJS1dzcmYrSTRN?=
 =?utf-8?B?RXU0TG5JV21wRCs3YklIMlVBem43eGFvcEo1cDZsSXM2K2lQaWNaRmtKUDd1?=
 =?utf-8?B?Z1B1OUdNZ3NnZEVWSkRkeVRWaUFRdXFHM20yZlR3OWZ6WVUrUTFlMnpmL3l0?=
 =?utf-8?B?SVdWUUpqa04rYmdIblJJSG51YzRJWFcxUFZmaUthSHN0d05ieEd0Zk02NUJU?=
 =?utf-8?B?SjV5M0F6eU0xcGM0ZXptUmhUaHhBTk9TbVl6M0dBS0N0SVljT3FlYUNKNjVX?=
 =?utf-8?B?cm1BQkp3aFVhamFNc2NGeFJGNEMySDg1U1pHemN6MlFaT0wvd2NDbXN5d3lP?=
 =?utf-8?B?OGJ3bVRvam80OHlIT0dmSW0rdG9uQUFWbk03N3doVVFyeWdmYm0xY21PZkk1?=
 =?utf-8?B?Y3J0T25EUlN5b2NjMEx2UnFlSHlJd01BdVE2N2NvTXU1c0MxN1laeE00UE1v?=
 =?utf-8?B?dTY2QU54WUpKamFDWWtQVmdHNjBDSnRKMFJ0aldwRVp4SjBPRFlOdkFQcWlq?=
 =?utf-8?B?dy9oaHhsRERWNVdCUm5EZTR1V09HbzYvbi9zVkhCbzNibWcxUUdrVlNTRVJp?=
 =?utf-8?B?eTRXbDVxYnEzYlhLaXlNaGVHbG5BPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e0dd75-c585-439c-69d1-08d997d1cb25
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 16:09:16.2551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiW+2UdoFhOdv24sg3W8I3tQo+AOHW/07a8RzPPjF2r69ctKsbDCrIdLuO+Nf/SFpHfS+2L1gQXw7/wk2bLQ9MR+OTn8wLBLVw6EylvkCSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10148
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110250095
X-Proofpoint-GUID: B8l6sKigf1TMPCPmqBaaLCxpzTH3zrcJ
X-Proofpoint-ORIG-GUID: B8l6sKigf1TMPCPmqBaaLCxpzTH3zrcJ
Cc: linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMTAvMjUvMjEgNDowOCBBTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9uIEZyaSwg
T2N0IDIyLCAyMDIxIGF0IDEyOjE5OjA2QU0gLTA1MDAsIE1pa2UgQ2hyaXN0aWUgd3JvdGU6Cj4+
IENvbnZlcnQgZnJvbSB2aG9zdCBkZXYgYmFzZWQgaGVscGVycyB0byB2cSBvbmVzLgo+Pgo+PiBT
aWduZWQtb2ZmLWJ5OiBNaWtlIENocmlzdGllIDxtaWNoYWVsLmNocmlzdGllQG9yYWNsZS5jb20+
Cj4+IC0tLQo+PiBkcml2ZXJzL3Zob3N0L3Zzb2NrLmMgfCA4ICsrKysrLS0tCj4+IDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMgYi9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMKPj4gaW5kZXgg
OTM4YWVmYmM3NWVjLi5jNTBjNjBkMDk1NWUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmhvc3Qv
dnNvY2suYwo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3Zzb2NrLmMKPj4gQEAgLTMwMCw3ICszMDAs
NyBAQCB2aG9zdF90cmFuc3BvcnRfc2VuZF9wa3Qoc3RydWN0IHZpcnRpb192c29ja19wa3QgKnBr
dCkKPj4gwqDCoMKgwqBsaXN0X2FkZF90YWlsKCZwa3QtPmxpc3QsICZ2c29jay0+c2VuZF9wa3Rf
bGlzdCk7Cj4+IMKgwqDCoMKgc3Bpbl91bmxvY2tfYmgoJnZzb2NrLT5zZW5kX3BrdF9saXN0X2xv
Y2spOwo+Pgo+PiAtwqDCoMKgIHZob3N0X3dvcmtfcXVldWUoJnZzb2NrLT5kZXYsICZ2c29jay0+
c2VuZF9wa3Rfd29yayk7Cj4+ICvCoMKgwqAgdmhvc3RfdnFfd29ya19xdWV1ZSgmdnNvY2stPnZx
c1tWU09DS19WUV9UWF0sICZ2c29jay0+c2VuZF9wa3Rfd29yayk7Cj4gCj4gSSB0aGluayB3ZSBz
aG91bGQgdXNlIFZTT0NLX1ZRX1JYLiBJIGtub3csIHRoZSBub21lbmNsYXR1cmUgaXMgd2VpcmQs
IGJ1dCBpdCdzIGZyb20gdGhlIGd1ZXN0J3MgcG9pbnQgb2Ygdmlldywgc28gdGhlIGhvc3Qgd2hl
biBzZW5kaW5nIHBhY2tldHMgdXNlcyB0aGUgVlNPQ0tfVlFfUlgsIHNlZSB2aG9zdF90cmFuc3Bv
cnRfc2VuZF9wa3Rfd29yaygpLgo+IAo+IAo+Pgo+PiDCoMKgwqDCoHJjdV9yZWFkX3VubG9jaygp
Owo+PiDCoMKgwqDCoHJldHVybiBsZW47Cj4+IEBAIC02MTIsNyArNjEyLDcgQEAgc3RhdGljIGlu
dCB2aG9zdF92c29ja19zdGFydChzdHJ1Y3Qgdmhvc3RfdnNvY2sgKnZzb2NrKQo+PiDCoMKgwqDC
oC8qIFNvbWUgcGFja2V0cyBtYXkgaGF2ZSBiZWVuIHF1ZXVlZCBiZWZvcmUgdGhlIGRldmljZSB3
YXMgc3RhcnRlZCwKPj4gwqDCoMKgwqAgKiBsZXQncyBraWNrIHRoZSBzZW5kIHdvcmtlciB0byBz
ZW5kIHRoZW0uCj4+IMKgwqDCoMKgICovCj4+IC3CoMKgwqAgdmhvc3Rfd29ya19xdWV1ZSgmdnNv
Y2stPmRldiwgJnZzb2NrLT5zZW5kX3BrdF93b3JrKTsKPj4gK8KgwqDCoCB2aG9zdF92cV93b3Jr
X3F1ZXVlKCZ2c29jay0+dnFzW1ZTT0NLX1ZRX1RYXSwgJnZzb2NrLT5zZW5kX3BrdF93b3JrKTsK
PiAKPiBEaXR0by4KPiAKCllvdSdyZSByaWdodC4gSSdsbCBmaXguIFRoYW5rcy4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
