Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C68C433EF
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 16:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17E5B40C2C;
	Tue, 17 May 2022 16:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RRNK9t-I8pEl; Tue, 17 May 2022 16:54:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BAB3E40C14;
	Tue, 17 May 2022 16:54:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90977C0039;
	Tue, 17 May 2022 16:54:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4C3EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 16:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEB0481766
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 16:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="qPGVml7x";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="cL+0rlOO"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G12o6F6PEsRm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 16:54:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B09888175B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 16:54:20 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HFw98x027116;
 Tue, 17 May 2022 16:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=XQYgiaExBWJHZW0TjuB2BQELZTTeXvCLNnn0gt1fJcg=;
 b=qPGVml7xzEfMbePUcGexZWlMSrp9Rv225u/y+B0u8sWoAVoKmBqgHZhovKm5xexfexG0
 uB0grZPGvmHcCTbsvuVIGVak+wptTnRa9DigxkyJvupxZvH3OgR6oHMheMoOVBm87yBh
 qjfilS7HVZWltPHHX0iNeP24JubUx4F9gpnhO2kz+ryYRuNfij6Z7rnc/UQ9aW2M5sjI
 EeqEB/g8rDTgc+pE5RAkXRS9J/8IpB0v9+LrRyOtIITpkUu6gI7X6KTxtGcpie4NunLB
 CPL1BS98ivQLfnBlcLvr46dr6uqjuhFl4Mq9AAJ28gMnf07Dl3zzQ0R89s7cs+ZSaBfP jA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g2310q055-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 16:54:19 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24HGnlsH036881; Tue, 17 May 2022 16:54:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3g22v3cfyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 May 2022 16:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCgCyGxMNnBzfPA6VPXqlBKiGAjM5LDU3xztNn384RUiZa9oCaXZvZixaD7bVoRhKyw1D5Yo8824NcG9Js6kMHOFQwSzJ/mQwBz5IUi7FdBluWDJXwTTDtj9QZ6zEjdw95V4O5ge8n9WKmO08pL1UOuErxCLOdiusBvEht0HYIng+DSrhU8bzm35AmI7G/g4d1mUMb05GWiV/ixBdZpFsd7ex7TCksavjNkVEvl8AWe3FogpxCkVPl98KX/iQyebPq+5JUBeIZCAPPFcke69BohPnpCuTUo6sQwJvT+qfzENqSWJZPb/WT28LTNUbM7KDFF59ybc7qlGUPSSb20Hlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQYgiaExBWJHZW0TjuB2BQELZTTeXvCLNnn0gt1fJcg=;
 b=OUeMWXY2wUxYFtDTnof1C980KvxR6rMfugB/Mjl7OF1gcP/TZn/Wd13L7czZ5ZAB0CIYN8jYQPJ2GVOUTxj8htCFHMssa6MBYfowc9EPNjvNiih4CCK5x5EdGbqBEriDfVFmDFL/+za10TNsiqd9GjNXIU0S4pj7XRl54G7BrkK9+yzw4HwMJNWBmNIuvxADYXNB84c4nO7Yy9vMZyr8ssarsY7nUAq4+nVNarVsf0dwGfEW83COZAcNlPe7n8ExaG+4FYjsFfZ1MhUQqFNnhHi3wFQI4Q1i7IRuHwZrTPoM27HbKtQyEZu2MySj1j9dIm+yN8F6owzbkYuvJssaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQYgiaExBWJHZW0TjuB2BQELZTTeXvCLNnn0gt1fJcg=;
 b=cL+0rlOO19IJecuuHgbiKP2A1nKBdx59Eaa45quT4+cjxbssAE7MYm+b0zH4TTDbvY5yAx81rQ3AInwWoYAFQwXYWmwd4EN4fXgxGKvwzdmTwF1lqVEBCLA6EYIKlbYkQlr/ELIuJ9DXfjg5hfcub0X9guk5aZZRdztQ1llkEi0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 16:54:17 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 16:54:17 +0000
Message-ID: <c89e0f16-1f0e-82e6-7789-6649ac4efe3e@oracle.com>
Date: Tue, 17 May 2022 11:54:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V2 4/8] vhost_test: remove vhost_test_flush_vq()
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20220515202922.174066-1-michael.christie@oracle.com>
 <20220515202922.174066-5-michael.christie@oracle.com>
 <20220517141109.ycngu2unpi4rdzqg@sgarzare-redhat>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220517141109.ycngu2unpi4rdzqg@sgarzare-redhat>
X-ClientProxiedBy: CH0PR04CA0039.namprd04.prod.outlook.com
 (2603:10b6:610:77::14) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4994521f-3a5b-4d04-e4f3-08da3825e160
X-MS-TrafficTypeDiagnostic: PH7PR10MB6275:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB62751B6B78E43F1AA29EFA54F1CE9@PH7PR10MB6275.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhqnatLuE3z4pjut0MW5Yv5pDIGhRefF4TZXCdJX0LrRDBA8mu+x7c4m26OGs6WaIhCu045BQUt+bWpxCmwy6FBeAA6MBuNTx0RioaZ0Tyn/69+NUX0e/eoUe87W97mt8WwjBcj2M2tjVtbUjIYm8NYUh15bqY5u3RzwqWEkn5lFR9NRWHg6zWLWV1LUy8su5ipdO6R2sBylPU1Y3bAM73TOf8BxAgM5fz52qC3MiGAuKdRvbHv+Pxjkuz0H3HOWUg5+5SG0RLvdH+2PfpmH4dwuhNM2QBSj4VBcaUVmmAwUihGSNeBOXzeXYPU6nbCB+WVB3IEYLvCTUrSGpxxvSyFb4mbxPsUWvVO0B8BDlQq4BTgnpsK9pgTGgTRdBOB9ae1vxZagYPTxLN4YQ2egTpOreBDXNqmI6OOkkpxs585F9qRddXRucZFbM45F8ZxMuqA7kPce1/GusgexOEE3IMcHRBE7WLWWlXtB1cZaT46m6lUvy0v6uRCiAM/JX2V0566P1fIlY/wdub34Kpy5gf85ZaE34h1LUezmbpQ1ze4+38Hx8WPRYAHiy5N5jLoQRJwguWaGBCa23DrbNNM+2x1eBT2rJFzP6AKRUbDkpGXyq2koJLNnIOy+JKEeVIC/Xyt0s6/MthgJrWUEafqRX8sJPDYP8Lmtm9TNHNIFOKLHUARYKflsb/6YbsGWNFZKbO4TQah6TLu/qAda54gGriUy8FH9Fo1py1DAniHwvF8FhUGlk2jmZAmFp/ZTVXO8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR10MB1466.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(6486002)(5660300002)(2616005)(31696002)(8676002)(4326008)(6512007)(86362001)(26005)(4744005)(66476007)(66946007)(66556008)(6916009)(6506007)(53546011)(508600001)(316002)(38100700002)(36756003)(31686004)(2906002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZGczRsNmZHQ2F1VjJYaHd5MGpOeU5LeFMrU2VEYXVWZnNSUUc1akltSlR1?=
 =?utf-8?B?cmVMeTAyT0ZicDM2bkZ6TmsrUXRyZmE2a3hMbmhXaHB5TGFPNXRiK2J3YjFn?=
 =?utf-8?B?M0xuWU50czJwUXd4VVdJOEJjbzN2NzNNaVNyNFY5Y2hrR2hCZWcveWhFWTFE?=
 =?utf-8?B?aWZhNnNnNG9uV0Z6YXJOeDhsZTFuL1RBOFdYOVJjZlRMMkZibkp5UE1uOUF2?=
 =?utf-8?B?ejV2eDVoNk8zQ3dnWVNIdVJ2RHIzUXZQWDFkYzlXdnZVS2trZ0p4S1p2OWEv?=
 =?utf-8?B?ZzlIaHd3MlJjTUpYZDAxZGNDRHJ1VHdCWmd0WlN5WnRZMFZ2UVBNYWJZQjNK?=
 =?utf-8?B?SDJtbXVJTDVpTDkrc2tBSVowT2IwUS9kTDNHeWNRWjFFRG03WnBLaHZxT1dj?=
 =?utf-8?B?aFhOMDlPUW1FakJ1TjhJdTc0Rjg5NG1IQ0xPR08zekZKV0FUMStMcHpLbmNN?=
 =?utf-8?B?K2RXUnpKLzkvVTBwaWVGRHV6VmxsdnJiUmlvS2dRS01CczQ4RE03Rk9FNmdy?=
 =?utf-8?B?SnFuMFJNcW9mOU5Ib1RCMlNKb21vT0pnTCtPdG52RUVEeFVmeXhrTzdBQzlr?=
 =?utf-8?B?aFlvSWJneHRvd2xySmtNTXFnOHpsaisxODRjNit6NVo4NC83Y0taTFhEVzN3?=
 =?utf-8?B?Rzdwc3ZXZEZxWjhXc1ZWcmg2UVBCRHp3NUtMSTBBY2FuazVNdGsxQ2djeU9t?=
 =?utf-8?B?b3JuSG5Jd3JzOTltMnF5Ym03alNsKzFQaE9SRGRBdVpIWGhpenlObk9YK2Jt?=
 =?utf-8?B?eW5kVmJvbVVVdnVJSXByS2IzNkQ2SCtTNXovMndaWXkyQmlKNU1wK2lEM1pl?=
 =?utf-8?B?UlpjaFVhVGlHYmZVSyttcU16R1gzNVlTOHRKMTZ6WjZiM1krT0N2WUN2bUFD?=
 =?utf-8?B?QWhTUU5MNUJST0NIWWFzVjJhRmYwN3FpRHB6R2k4SjRlSVQ1TStEN1hxcDEr?=
 =?utf-8?B?OVc0M1pSU1NINjVkeTIwSXFMQUFDTW0zMUtNSXJWekJ6bU1DV3lONnhHMnFm?=
 =?utf-8?B?K0N1TUFmMzY5RlVXNExHRXNxajBXK3Z4YUtjOERBOW8zNGVHR1hSaDUvK1FQ?=
 =?utf-8?B?RmhuaDM0b3F0a1pvQ2lpbEZsS3pHc1g0Vm1aTCtTakJta0c0ZGdaSVQzM2hM?=
 =?utf-8?B?cG9FYU5OR01rMFZqQXFGU2Y4L21ENzRFaHMrNjlta29BbWpmVXR6T2xDMGlu?=
 =?utf-8?B?anUvTk1sQmUrYkhDYk9hVy9wUDhWZDd2c01sWnhIekEwUzFzZWNMZ2N4MVdx?=
 =?utf-8?B?ZHQ1a0t0dWtZRERrTTZLcE5sbVQwcUtHU0l0VHRFQXp2Wmk3bVVTczZPb1k0?=
 =?utf-8?B?cldFcU90RGxpRnQ2QWxQeGozRm5EbmpSWURyRkc4K2E1TE5SdHVPQ01KNERL?=
 =?utf-8?B?VUttM0ZjN3NCeE05NjBWWnQ1T1lGajQ4dElDVjEzSVR3MWp3K0kvdDZIVkNh?=
 =?utf-8?B?VTFjUnFPem43NTB2ek1aWE5wdHhyTjdkYnNFS1NoYXZTTnRCTy9HdGd1R2di?=
 =?utf-8?B?K0FObTVPNStwL0lnUUZwN0hrNEZoUGJOV1NFVlFpU2hiZnF2MGRaUUVUN2xT?=
 =?utf-8?B?Um9RMWxzcy9aVnVuSzMvbk9KUm8xM0c4bVliMDV3Ni9OR0V2V1VxQVZCc2kx?=
 =?utf-8?B?d0p5MXhLRWZ1WFJpRDZEREpXMTRYY3E4L3ZYVTFmMmtHdzNDbHpUYlM1SUlV?=
 =?utf-8?B?MjZ4WHZQUzVrZG9KRGZYRVJiOVJvemJJTUIyT3dCSkVZVGluK2VzeUYrbVp0?=
 =?utf-8?B?elV1SG0vWFJqZVZnSzFMZjk1S1NyRTgrZVhaQzBRN3JhcXJpUHdRb0RDeVBl?=
 =?utf-8?B?M0RkSlZxc3dVbjFUc0IwU3pxb3lHRjhWQnhiK3ZJMlcvYVlqTmgxQ3FkRUV1?=
 =?utf-8?B?dDJOVTNUSCs1bExpUFFtNmpyUDZsRVRMZXpPeHN0d1pQZE84VkVlSGU4QmJ2?=
 =?utf-8?B?ZFZYdFlCY2I0OXh5c1FGcmREVW01ZE1LdFdPa0c1QXRwNnBnYzJzVVZQQUxK?=
 =?utf-8?B?aktxS0NyczVCWkFRdlI1bGFtY1ZtdkhrZUFyM1c5SEVSc05qVUlRRFBveVhk?=
 =?utf-8?B?VHRvTEhqOHpvODZkQmN2N0kyZE9tT1AvNE1XckI5WFFVNkp5ZklCdzNqNGtJ?=
 =?utf-8?B?OEpTaEVDa1NIYUhjemovRnJGQjNBTHQrdzRVYys5S3FnNWFtTU5WS25aVENX?=
 =?utf-8?B?RXVLQnNqc3VVdDY0S1RXc2hVb004SWo1U1RhcFoyZWFLUmx3ZlpacEdSN1Fj?=
 =?utf-8?B?MCtGcE03end0RjA1Z0d3Y2JzeVFBc01YVGxiVUwzaGRleGZpWjZHZlJ5Qk8w?=
 =?utf-8?B?a1lYVENSTG9EQWo0anNiekg4Qm5WYzV1ZDNoNVJBNTdYeDBhTnZTOEpYU1Zu?=
 =?utf-8?Q?sGssV0KebToBzz/k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4994521f-3a5b-4d04-e4f3-08da3825e160
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 16:54:17.4077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XzIO8o0hyGYurHOY4gUAE9Kyz4C5XxYMv5Z77UDdXQtEs6SEsm8yHJxatPM6TzpKnzvbxc5uY2GYCfgfQAEZDbfzUdbebbFi0S0fSgBsr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-17_03:2022-05-17,
 2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170103
X-Proofpoint-ORIG-GUID: ev2CUGaAEGUEJsZ_K6GQoZdqvL9oDDI7
X-Proofpoint-GUID: ev2CUGaAEGUEJsZ_K6GQoZdqvL9oDDI7
Cc: virtualization@lists.linux-foundation.org, arbn@yandex-team.com,
 stefanha@redhat.com, mst@redhat.com
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

T24gNS8xNy8yMiA5OjExIEFNLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4+Cj4+IHN0YXRp
YyBpbnQgdmhvc3RfdGVzdF9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxl
ICpmKQo+PiBAQCAtMjEwLDcgKzIwNSw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3Rlc3RfcnVuKHN0
cnVjdCB2aG9zdF90ZXN0ICpuLCBpbnQgdGVzdCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBn
b3RvIGVycjsKPj4KPj4gwqDCoMKgwqDCoMKgwqAgaWYgKG9sZHByaXYpIHsKPj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdmhvc3RfdGVzdF9mbHVzaF92cShuLCBpbmRleCk7Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHZob3N0X3Rlc3RfZmx1c2gobiwgaW5kZXgpOwo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF4KPiBTaG91bGQgd2UgcmVtb3ZlIHRoZSBgaW5kZXhgIHBhcmFt
ZXRlcj8KCllvdSBhcmUgcmlnaHQuIEknbGwgZml4IHVwIGFuZCByZXBvc3QuIFRoYW5rcy4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
