Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BFDC25B08
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 23:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E8D060F47;
	Tue,  9 Aug 2022 23:24:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6E8D060F47
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=g3FGZ/Pr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=bfiX00a/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mk715hneuSi0; Tue,  9 Aug 2022 23:24:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE1E360DA0;
	Tue,  9 Aug 2022 23:24:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE1E360DA0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70A61C0032;
	Tue,  9 Aug 2022 23:24:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80A7EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:24:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4419840939
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:24:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4419840939
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=g3FGZ/Pr; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=bfiX00a/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Km63ASttxhdc
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:24:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCDE640907
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCDE640907
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:24:36 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279M8n8V021997;
 Tue, 9 Aug 2022 23:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vMzbCOKmEydS1U8yRtzHv7jOTK1HQbAZohJ67l6sZbU=;
 b=g3FGZ/PrST3Vz9vTV5o1z3hhLr1INkbJBKe7XL9AjUMrnuM5kMSvfmvpekhk82cUyMMr
 w5cWTXN5NTIF/pGTOfliKDmtx7HcspWEfuof1uc8SHgkbIq78He02OnrZA1zUvh8rjrH
 0c62vCSo/83cs8HCQwdmHRozLIh2SUlr/InYIWZVlC9xlY+LOJVUZdJuwIvFYxXryM6H
 vZ6DrT1so6lkkNhgWmRSgBWu0uiNHNoENTS3k2rzp2Vo0EN0CEab778E/akrdsCor485
 O3tbGYFusRQkuD2Ng7nFCSWDQXptYvzTRlIHnGqdAruy7dlyJ9UBZov6irOYsN2L4KEE nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqbgeq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 23:24:31 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 279Keu7j036587; Tue, 9 Aug 2022 23:24:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3huwqfcxpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Aug 2022 23:24:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEJcdO65JyOjjayNm7PfnCiYOV6kOiSvHIH+haYAQpdPp9UImUsUzesn+ck5OQm9AEEIlMG6Pvw53RhPmIUYe0ZBqdYDAk8oPhOiVHpj3jQpXP9I/1fiwbKF9yLGPNmNLLJr/VMoG41T6z6JYYsSkibfxGlGFv/dWjTM7Rpe6QP911yxLFnk167YvvvRfej/SR4dALBAnFjgYC5MsxCSsF9nnxTLJvgFIiMlSxlLThsFbASWP1fBXy8mHE5EwWlMDJXYXXKw2tJAKdPLsfCJ6H+6Apb/+PwgWRbBdQgezexop3JjtbDy5TA5gT/CgNUvBRpKa3bkBPi6JJ64vVlIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMzbCOKmEydS1U8yRtzHv7jOTK1HQbAZohJ67l6sZbU=;
 b=IfL9egLxIJSOoKk/oloJ3BjY2+/VpQFpLEjPPAmZNSUaP3j+OApCioYtG55Y+LA/hKCRskkAfEAILsGHyLOmn7qh0mZImFQordt9BmhPta6aV/uGPAcQZv7C71pKNWgihi51RtYNJkUpPYM+1Lb5RyNGRCba0xU0RhbP0uK1iMzQ1G9GLtnBUs12/h64XZ1uebfQ+TsoUHx3V+mSdj6U4h551QAXbfqf3kBnl8xNoBs4Rg4nNzJ/mlLz4fFGhv7dXmZAqb/VkoYjBuocyBH41BHSmx2+RpVm6JY2u7OaGumNnnj34ahB1sWMlp7ubCWqWjJ7ErTkpnzvbrvCpAhNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMzbCOKmEydS1U8yRtzHv7jOTK1HQbAZohJ67l6sZbU=;
 b=bfiX00a/8DCApdLeBQHVDNw83j30w3yLnm7rLWgPp+iPVKVw1zJl4tHZcP0KVRnP1QCJEHqa0IwpfuaGz4LueH42GyPckLKnRESb0SvJyLzCJ1ISM3WbPkww1BnobnE2SdWBa17VS8tsWfcOxokJfsXIexl9UCDOfxpvtSlvYr0=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BN7PR10MB2644.namprd10.prod.outlook.com (2603:10b6:406:c5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 23:24:27 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 23:24:27 +0000
Message-ID: <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
Date: Tue, 9 Aug 2022 16:24:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: DS7PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::15) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46c90215-d080-49d5-c8ec-08da7a5e4da0
X-MS-TrafficTypeDiagnostic: BN7PR10MB2644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqJd1FIrVRbPsZzbzkjdvMK7Q1JQ93Mk9en4qUGLmm3LY/FWF4ntQfCoh73qT0Q4Ow5JCV5CNWq2DNc5UMmQ/R/pbkbCMh7BkBojEfgSp2S9sYY7lT32yqq4+CAB1aq+olV4H91vhjN+yZOVmO3/S2qFwt8EbNruLsFaOQSwiNIcwxwpdCfJDQahMfBzdblbCipZZwn2vYnEW6WME4mzZfyWVB3nsTRuQliQevrNOqp89dm6rmWi3TfLKeoEIjc912E6r8iuypX94stsFH80Lv4o4SQi8N+MtRt2172O41Fx44m55S6DqP9fO/rEH7wSjnnG5J9OMthKkdIbAakJfbnrF0nnn2V2hgFe1/YLHxuXCmqaN0lppZlr48JBh8h8QZkblev73Q+3daADi09UhBO3Nu7IQgb95LHdVbjg2L77MTRtSdS6Uchsyx53OQvAJEEIMjtoNHYcqFMYmV7OWSji5yYZo+SETl9RPA/Y3PXxto/W2qhP9T6s0I1yMJxTjcuErrdbzT/PzcgRCj1GkmWhDPnv0TPjOTm9uj7gxED3aM7L1a+HZa5UaoMQfbTCAP0eujAvSxnJfIhW/cIymOIvVXcrP6c8JeLCdye5NqhGhhp2AFK1yVMekkM5kREGK8uUZyJO/ESLs0YPxq/mJxMNCMIfUnZb08Yp9OEl6oCQuUQdwgZ6HNwWNmRukIDWVJa+v6QbR1cGiKIRSuiByAD3obtfOK42dIR1X9Q2KeZwnoVpRNFxKctLyQkVGZBs2PLp5m8X9cHSXK7ufVZmVtSY2ov4CcgthpRbB9uf4AOb7ooqX0F+q8xpQynufR7fvoeqzrfHgLELveV/m+lUXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(366004)(136003)(396003)(376002)(346002)(66476007)(6486002)(38100700002)(7416002)(66946007)(478600001)(66556008)(31696002)(8936002)(5660300002)(54906003)(316002)(86362001)(8676002)(4326008)(6512007)(2616005)(83380400001)(26005)(31686004)(36756003)(110136005)(186003)(53546011)(6666004)(2906002)(41300700001)(6506007)(36916002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUVLajdlTTVSNHRDaTR1Y1FUWnVFa3NNeU9xNGpSOTVQTjZSQ1BmVjhOQVc4?=
 =?utf-8?B?dXlyQ3MvK0t3VE1Oa25hYzFRc1dPTFJISnNmVGw5NHJqVXFxMVdYVDc4SGJt?=
 =?utf-8?B?aStIancvbnpabldZSC9SOW1pR3JFUTFUNmJMdEZRTzg0azdNUldhTEVldUww?=
 =?utf-8?B?dDZJc2NkeWJlcXd3YmRzT3p6dzI3UG5NU0lOUXdCV01FSjZmZVI5NEtWU1c2?=
 =?utf-8?B?Z0gyVjhNZ3ZpK1RFcnY3RENOSGhQNDdYTHJrcm1kRlB1bVVzUE03eTl4ZzV6?=
 =?utf-8?B?RVpEeGFDK2oxK3lSNEhmb2xEaXdMZWtud1VtaE9vakljWUNTVDhPNFNwVFJs?=
 =?utf-8?B?RDBhR3BmQXBlT3k5ekZRUDBleFBsUktERHA2UjdtTjh3cko3enl2b2VNaVli?=
 =?utf-8?B?ZXdJaUcyLzRhYXVIVWFnTFVtd1hBZnpWRC80SWRTd3RYSHJsQzFMUnFDcHhC?=
 =?utf-8?B?VkxBNHExdUIrbHVVMEJ1b01yWWptbUM3dXVpUWp0d1c0OFNmUDRKZmM4YWZR?=
 =?utf-8?B?TjJ0Uktyc29DV3UyS2NuM3JrK0RhTjFoWkc4YmJ6Nmh3NVltN1NJUlF5QkRI?=
 =?utf-8?B?ZVhzbzVWLzVLNGJqV3RNT3JCdnMreTFTWlBwRlNST1FYL2ozVklOT1psaDYw?=
 =?utf-8?B?QTJ5T3NTQTNWbGdOM2NXdk9ZdG9hcUwrTlRQRXI1K1lGU2M4RjJMV1NVR2l6?=
 =?utf-8?B?SXBZKzZtVVBweStVektMb3JpWmVVK3FRTnZ1YWRjTTd0SEU0YVNUcDhCUGJ4?=
 =?utf-8?B?NHJWUC9HZS9SSGNBc2FHWW1YNVd4WHkvVjZBVkVLMU16OHRmNGxqc3J4KzlW?=
 =?utf-8?B?aUN3OXFQekhWM3FLMlFpckRpOFZUajNPSlpJYncyanE2b2xybFBCMWViR3Ev?=
 =?utf-8?B?eldMUlVHZWpYQ1A3cmhJS2F2VTNoUE1tM09yd2cyNWcyYkJtTzA4ZUhjUG5W?=
 =?utf-8?B?aVUvbEZzb1BIZFpuTUhzbFFSbks3TVNQZHZOQ3dwUTc4bGx2OFU1cHVmK2NQ?=
 =?utf-8?B?aXM3Q2k1b0JXc0hpVlBxTFVaL1NmL1RHTm1ZRCtTRzEzT20vdC9OVXI0eDF6?=
 =?utf-8?B?VFFQNUEycEIzV2prcVREQjlRMEY3MytyOHBCMENaSFgrL1g5aVQrMEJ0V1di?=
 =?utf-8?B?VGsraFJpNzRrRTZGRnI4RlIrSThzNFJJZWlJZDhDZ09ucUcxR0w1WEhOQUhl?=
 =?utf-8?B?N1ZVOS9MRytJWENSQVo5YjZxV3pTMDFUQlRHMHJqMFNPdGFGTHk1QVBEMk50?=
 =?utf-8?B?SU9RK0cyOG5jcWlCMDI0WDF6eTV4dWk5MmcvOGw2R3h2bm9McTVid21kTkFp?=
 =?utf-8?B?RFc2a2paQ3hTcThrUHdMNTQwVWFxSVowa0NDYTFLZ25IOXNaWGZHM25OeXY3?=
 =?utf-8?B?YnRTa3YrYytlTStoaE9oY3JDRDZyVFh0WjNITDluZ1U1Uy9wOTI2a2t5U0dz?=
 =?utf-8?B?Qk5GdmFxMjlPVXR5dUNVdDBUa3lBckhpR2JBK0FXUFc0VUFRTmdXdXJ1VW1v?=
 =?utf-8?B?aXZqeDJpMEptMnlpbjZuRGJKTFRYR3pTUktnRy84L053SmFMY3pIWlRaNVJV?=
 =?utf-8?B?MmpSMTdCZXdGSG5pbzVoZ1ZiTVJIRUpXVXlZbmJxVkpidWFUcEQ1Wmx1TUVK?=
 =?utf-8?B?ZFlmQkp6VGhyc0RSREgrWVROTTRkZmhSK0dUTGFLZ0ZPMmlmL0J0cUFpVFln?=
 =?utf-8?B?WVdsVlZ0Y2VscVB0ZmxwSkpGVHNBTWtXY2RsRGJNZ1Avb0k4K2ZpK2V4amtR?=
 =?utf-8?B?OEJwc0k0RWQ2bXUrdDRRdlhQcDJETGhZcmRMZHZFbW9WTDFRbEJJMFBlQW9h?=
 =?utf-8?B?bHJqd0pQQ0RraTVDcVVvSFNQUHVGK2dyWlQxV1hwUnFGNktNVUVibTdleVJt?=
 =?utf-8?B?dkl1ODZYTEM5RGJpVkFKcUdOcHk2dTUvN0FHVThxM0VudmF5WmhHK2Z0WU1y?=
 =?utf-8?B?Njk5WHRlMEJSQ0gxWldFMWVEL3hYZHArb1RySGpLMXp0MUlkNWxLZnFRRzlT?=
 =?utf-8?B?UDVQdm5PNngxUGc5dGlhYlZWY1BCd3dFOXpVSXhNakZhVTRvUXFsU1ZyVHBR?=
 =?utf-8?B?Y0ZrMnE0Q1QybUwrWTVhcEFBU3lSUC8zZ01HbW5YTmxlMnJIUjZEVER3dDZw?=
 =?utf-8?Q?IJWflywi3KUwAaaP9N2cvHtJD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c90215-d080-49d5-c8ec-08da7a5e4da0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 23:24:27.6274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nnCy1ygEgesgpkEhE+ukC1uX1fowawLdpxzG7Sp3PLu6COwwSTcyq++Va3o3B0Isfxo7Waroh8s3DaeBHCjgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208090086
X-Proofpoint-GUID: 0U1QDzZqym1E_7DqkfQS58Duvsy7VUOM
X-Proofpoint-ORIG-GUID: 0U1QDzZqym1E_7DqkfQS58Duvsy7VUOM
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 8/9/2022 3:49 PM, Parav Pandit wrote:
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Tuesday, August 9, 2022 6:26 PM
>> To: Parav Pandit <parav@nvidia.com>
>> Cc: Si-Wei Liu <si-wei.liu@oracle.com>; Jason Wang
>> <jasowang@redhat.com>; Gavin Li <gavinl@nvidia.com>; Hemminger,
>> Stephen <stephen@networkplumber.org>; davem
>> <davem@davemloft.net>; virtualization <virtualization@lists.linux-
>> foundation.org>; Virtio-Dev <virtio-dev@lists.oasis-open.org>;
>> jesse.brandeburg@intel.com; alexander.h.duyck@intel.com;
>> kubakici@wp.pl; sridhar.samudrala@intel.com; loseweigh@gmail.com; Gavi
>> Teitz <gavi@nvidia.com>
>> Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length for
>> big packets
>>
>> On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>> Sent: Tuesday, August 9, 2022 5:38 PM
>>> [..]
>>>>>> I think virtio-net driver doesn't differentiate MTU and MRU, in
>>>>>> which case the receive buffer will be reduced to fit the 1500B
>>>>>> payload size when mtu is lowered down to 1500 from 9000.
>>>>> How? Driver reduced the mXu to 1500, say it is improved to post
>>>>> buffers of
>>>> 1500 bytes.
>>>>> Device doesn't know about it because mtu in config space is RO field.
>>>>> Device keep dropping 9K packets because buffers posted are 1500
>> bytes.
>>>>> This is because device follows the spec " The device MUST NOT pass
>>>> received packets that exceed mtu".
>>>>
>>>>
>>>> The "mtu" here is the device config field, which is
>>>>
>>>>          /* Default maximum transmit unit advice */
>>>>
>>> It is the field from struct virtio_net_config.mtu. right?
>>> This is RO field for driver.
>>>
>>>> there is no guarantee device will not get a bigger packet.
>>> Right. That is what I also hinted.
>>> Hence, allocating buffers worth upto mtu is safer.
>> yes
>>
>>> When user overrides it, driver can be further optimized to honor such new
>> value on rx buffer posting.
>>
>> no, not without a feature bit promising device won't get wedged.
>>
> I mean to say as_it_stands today, driver can decide to post smaller buffers with larger mtu.
> Why device should be affected with it?
> ( I am not proposing such weird configuration but asking for sake of correctness).
I am also confused how the device can be wedged in this case.

>
>>>> And there is no guarantee such a packet will be dropped as opposed
>>>> to wedging the device if userspace insists on adding smaller buffers.
>>>>
>>> If user space insists on small buffers, so be it.
>> If previously things worked, the "so be it" is a regression and blaming users
>> won't help us.
>>
> I am not suggesting above.
> This was Si-Wei's suggestion that somehow driver wants to post smaller buffers than the mtu because user knows what peer is doing.
> So may be driver can be extended to give more weight on user config.
It's not me, it's from our customers with real use cases. Some of which 
have very dedicate network setup, and it's not at odd they know virtio 
internals quite well. At one point they even customized the driver to 
disable mergeable buffer ahead of us offering them the opt-out from 
device level. And their appliance indeed has assumption of 1460 mtu 
everywhere.

-Siwei

>
>>> It only works when user exactly know what user is doing in the whole
>> network.
>>
>> If you want to claim this you need a new feature bit.
>>
> Why is a new bit needed to tell device?
> User is doing something its own config mismatching the buffers and mtu.
> A solid use case hasn't emerged for this yet.
>
> If user wants to modify the mtu, we should just make virtio_net_config.mtu as RW field using new feature bit.
> Is that what you mean?
> If so, yes, it makes things very neat where driver and device are aligned to each other, the way they are today.
> Only limitation is that its one-way. = device tells to driver.
>
>>> When user prefers to override the device RO field, device is in the dark and
>> things work on best effort basis.
>>
>> Dropping packets is best effort. Getting stuck forever isn't, that's a quality of
>> implementation issue.
>>
> Not sure, why things get stuck for ever. Maybe you have example to explain.
> I am mostly missing something.
>   
>>> This must be a reasonably advance user who has good knowledge of its
>> network topology etc.
>>> For such case, may be yes, driver should be further optimized.
>>>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
