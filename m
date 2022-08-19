Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7007EC00140
	for <virtualization@archiver.kernel.org>; Fri, 19 Aug 2022 00:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E627A41926;
	Fri, 19 Aug 2022 00:05:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E627A41926
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=p/RjDidL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=iNEvHotB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E1S5u92_8xT8; Fri, 19 Aug 2022 00:05:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7495F4190E;
	Fri, 19 Aug 2022 00:05:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7495F4190E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FE19C0033;
	Fri, 19 Aug 2022 00:05:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB6C2C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3D9B4031F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:05:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3D9B4031F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=p/RjDidL; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=iNEvHotB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ep5MuSAGT55N
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:05:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CCC940129
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CCC940129
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Aug 2022 00:05:07 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ILxQB7032377;
 Fri, 19 Aug 2022 00:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=aGLiz279rRErvhq63eNPH9CdjQj+/SzmgtSwdf+X014=;
 b=p/RjDidL0oEqJKM1sB/EhIpoDpNNWjh4h5J3CaoxcK8PEZ1oOSIXR31Vbof4etZPPxhl
 jcb91yApgBzDI10DnR33p/w0sLAmMEl1QKZdmC5m4X1E9sQwzwy9V0rq5UMu+3ipTxeL
 vqiYtYLhwGKF0wTlkcxLU/zMEbyUGaUBs1M+74N/6E7Yfb7DVtr/Nn0FYDJ1EvIn00Jx
 GmiRWx3/GyyrngwKOkPBEpTGRspj8I6lw5IVZzwCMgK0s1/tx0QhWM+uVcTFphD5wJgx
 oG3soqMAAhEEXwETVr0nR1JBMAVY+SACypCire7VYlRVC+O2t9TxZkxKB2gxon3yvM0b fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j1wtsg5dd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Aug 2022 00:05:01 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27ILLrW2009922; Fri, 19 Aug 2022 00:05:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3j0c2chvgd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Aug 2022 00:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7KuNggBJDTiSHNYOlcay2kOPe1axQya0m+vDB4aIxGgecwkJQFCGj/Gqk/MmXDk+J7UES2hmDd60tkvAu1iCJSPVkQTLPOOvcrtamn8r8j/hqf0Odkvzx6SWeNWL9+B8ubL9MqX1Xo7k7i0yxdb2yZVJYUD6f5aNpFU3z9HliBf5FYVYhOzGYRiS6wRGvKAYjufDiHqx4oXhO+cma0X76Yx3q29EKnzbcLM6HHAFLhfhJMBEqAvrBsQNUVlMXG1cbjpC7ejeSBgwoU7BvCcd76zl3iMJwqEScHlC//WqBH2JRw6QS6HW2LvTNqsGtYTebEjFnx/ldp8qYbu93Nl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGLiz279rRErvhq63eNPH9CdjQj+/SzmgtSwdf+X014=;
 b=cwzPLeJeGChXFA+JHBn4WcSzGIyKIm81AHU4PXKj7ChBUZVBm0tIzw8jpIoQaFgRE8+9QLYwudQJwb7e64cqTCb6E21zDCUmWNRluR+AuQjQBe6ikDwHbrX8W6+CU0r6Hu1y3LOjYFkvcMX8Ba3O/t2Bj/35p+GU4qu2sO1IwR+RNbZ7IJlgTI4wDF6eDfRa1ZuBQO2339ggcV0Gt6Xya4lPr/0UMwnUxyO157VjXiYabB10ioGC38qrwQk0gVV+UYYldU0S5rOEcBRgQpNRLLRYpcQFJ+7PoQKJoYrb8HSmQcPdpulEgk+mJJbwne3ex9CoIPccgvYPxyQPv8yooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGLiz279rRErvhq63eNPH9CdjQj+/SzmgtSwdf+X014=;
 b=iNEvHotBV8WOhig14qQ4xICyVVXaKp8zk/plPUINfTphClJ/0R8V1eyHRXiOXafYCokyG0eCrDQJEjDgvmAYCIF6/FwzRB8fibrHH6kLScBVV4h4cYppgVpkej8AnKsP6vLwXSACNJECm0jlelc3PurzJX+weT5xJtDAG2olmGg=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by BN7PR10MB2756.namprd10.prod.outlook.com (2603:10b6:406:c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 00:04:57 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::dcf7:95c3:9991:e649%7]) with mapi id 15.20.5525.010; Fri, 19 Aug 2022
 00:04:57 +0000
Message-ID: <5fe9d595-f073-5709-edf6-386bda8a55fd@oracle.com>
Date: Thu, 18 Aug 2022 17:04:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V5 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20220812104500.163625-1-lingshan.zhu@intel.com>
 <20220812104500.163625-5-lingshan.zhu@intel.com>
 <e99e6d81-d7d5-e1ff-08e0-c22581c1329a@oracle.com>
 <f2864c96-cddd-129e-7dd8-a3743fe7e0d0@intel.com>
 <2cbec85b-58f6-626f-df4a-cb1bb418fec1@oracle.com>
 <a488a17a-b716-52aa-cc31-2e51f8f972d2@intel.com>
 <20220817021324-mutt-send-email-mst@kernel.org>
 <b489413e-e933-e9b6-a719-45090a4e922c@intel.com>
 <6325f067-3744-8952-e724-f22de35c8496@oracle.com>
 <b2430d3b-4ca2-a19c-da39-da91da732c02@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b2430d3b-4ca2-a19c-da39-da91da732c02@intel.com>
X-ClientProxiedBy: SA1PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::22) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3959159a-930c-4faa-eecb-08da81767362
X-MS-TrafficTypeDiagnostic: BN7PR10MB2756:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gbGid1thjBLneLogne8sMWc2dpre7+yWMuUsoIQzR56SfyVjIs0y/fxsWp1vLKyh4dpZkdnjv8ZZ3iOzCCgPyGj6lVSZsyMKGvIXo1LnEw9Hgzgegc3y9OoaAFxjp0CXDT8Es1ezb2HsFQN1wSA2NUXzEDLodeZ5GRZt7lsSbh9KBGKyxVbvOC1YZRP78XreaT4N4IDoBwbMaXASMlbyfSvGrY3dTLuXZOJveR3WkkfdHVwATaXCbDsX65t0RxC4AynTX0Mm1+kam6ZNpNyp9D+jVgoF+5sWh2o6ppY7U3/TG0oL1uxIqfzNGUubflmbbzNEYu5j24dJrlzcA1oqi61bZ21fKdR4WUklKDmaGgE1kEOyI7D2RfxujfNkUMbAjkaRJkfpMS+Bew/8ScNyKGvFN3O1AemW3SoWW4JBg05jKYWVsR0cXFWQjyUY5nTZL0ZXq+THa/jINkexQ+APFJPnebkPsZmxwQoKFqWRYlm2Kl/lsw0o1LqSlKEDBsFs6usmxS3acYqlP5VKjP3JHoGQ5MtnyJI7EVKMdZqVEJwo5KKGnvgXT6nSaBFgnwrMuaVjTqmnMtTcNiLs/evkJvGcmvF11A6Xz4n5Agt/b2QuSTx6RQT4MmTHSI/Ro//zkRLnibQePLKMxVgBsAwEi4EKLaGYhJ+h+JtwXXm3vvvnS+1Lf5dFP28580nE9zAxXS5Q2ox9LjYTeGrghJFGlhsCYV+Fu3OCMerY+S57+oYqlqD7JYhnvvfdrJbmoSW4ni+BbC5rBRXksXLKjHWqMATLW7tMoWcb4a9ldKvpFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(376002)(396003)(346002)(366004)(39860400002)(83380400001)(66946007)(66476007)(8676002)(41300700001)(66556008)(6666004)(2906002)(110136005)(36756003)(4326008)(2616005)(186003)(31686004)(316002)(30864003)(38100700002)(53546011)(31696002)(478600001)(6512007)(8936002)(33964004)(86362001)(6486002)(36916002)(5660300002)(6506007)(26005)(43740500002)(45980500001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCtTN1lvQTl3SlNqMk5QdUVsNmZoQVorVWVZbUxML3NQTHFzK2JidkJKM0pJ?=
 =?utf-8?B?UGNqbkdLRTZaSFFjeEtJU1VBVHFGNDRFWm9nWEhBM0RMY1lBZlVyZU5DU0M5?=
 =?utf-8?B?bytwZVN1eitTWU1zdEY1Y3VUOUQ1Z0NadWg1SmRocWk4eXNneW5zaHprb2M1?=
 =?utf-8?B?djJ4UXhkVnpGc3dWRkg3a25DaGpLTmxKQkZBVkltNERuRmR4SE9ocHlhQjVX?=
 =?utf-8?B?dE8vRjhyZFNkMFBnMFBhSkRZSmtVam1hTWxqZEJuZTVvL1Q5VWhua29EanhJ?=
 =?utf-8?B?RFB0UkxnSFkyUUphdmF3TmlXNUVDVnF2UW1ONXpvcjVnVnk3dzJxZjU3MVlo?=
 =?utf-8?B?M1djcDlQNGRydDRUNGhNaVVnZzZGejZjV1p3RVFJVDd3bk4xaFBXTEJHNUlZ?=
 =?utf-8?B?clZINW9SaXAvOW9odk8zb0NhbUZOVUxnakNrcVlIemx4SjJhVVV1UGkvM3lS?=
 =?utf-8?B?RVZLdlRkR0EyRXdBQ1pmOFdDcjZ5VVBhWWNvazEzZjdXejcwdDl4amYvRFgr?=
 =?utf-8?B?SG16U3dWYmthYUlUUUdKLzAwM2dGTldoTFVMNW9HelcrMm5YZ1FqM3hhaExG?=
 =?utf-8?B?eGozUjBHREowQk9mcWcyTFA4bkEzNkhxaDBpeHhWNGZxTHlyTmo4K2t5dExr?=
 =?utf-8?B?QzVLYkRZQ08vay9wMGNzbXkrbnBmK3JRNzhFbUdJNWJPSWhobjdvZWtSazdy?=
 =?utf-8?B?MFEzVkdXK0Q2Ym1UWlo1NjY0cWlNcVRzbWtSNERjQUdsbzduSTQwUFZhczAz?=
 =?utf-8?B?Y0tQV2ZFQVZlZ29lSjhVOCt0bE4wd3pJQWNvWFdGdUlOWG9wbkowK2lLSzFB?=
 =?utf-8?B?OEVra0RVSHRZeGdza24wY1dEaURHZS82S3VaT3Vhd3Exek1UTEh3T0ttdFFn?=
 =?utf-8?B?Qk44cUhRMEZJcnJreHhiV3NJMmZKc0E1ekVycjJmTkxMVUI4eVVsWFVUZkhl?=
 =?utf-8?B?WFdqNUdTdWdZMU9PTjROdzNRdWVFanVtOWRnOHVvaDBLYWVFMnV6K0Y0dmFm?=
 =?utf-8?B?QzgrZlR6enlCNDkyUEFRbzB6K280a0VZMEdWM0RrUGtMdU16ZG5zcjlyc0NK?=
 =?utf-8?B?Y0RDdFgyNEh5bEY3Z0syTmQwWXRiTUp1NHduNmV0enJuSkN4MUVWM2pRNUwx?=
 =?utf-8?B?Y2hYYjZSUlZnRGFyVEYreFYrQ3NFNmRrSElKSE1yT2IrUktPWE5zcGQzcDc2?=
 =?utf-8?B?dW1MNXVyYXRRaHFkWEtia0s5SGlxeDd2Z3R6TlkrNE1xU3Q1NlRUTm84WmZm?=
 =?utf-8?B?VUp6UGcwazFwZW55YVB6WGxJbFNHb0ttM1RCYkFNb0ZNN3B1aUU0cTdUZ3VY?=
 =?utf-8?B?QmhGaE9vUlEwNFdtckRHWWwwUjhiOE9kZHYyTlJlYzg0cWdOalNCNllMaHF0?=
 =?utf-8?B?RVhjNFEvMG1PVEFOdGJ5SEh0QVl0N0VjU2EyMHlSZWtiZVhpVWRJTzB2eGxH?=
 =?utf-8?B?aGF1SFhkQ0ZQSEF3QWhtcVhlMHpBUU93K1BvdG15NU4xMFRkZkw4WTNvaTBQ?=
 =?utf-8?B?MWxCUVNPa1dHTWMwK2Q4YUdhTWMwTi9iWmppUDF1MWJub1FMVzdvSnQyZ01E?=
 =?utf-8?B?RVo2czJVbEphY016a0hnYmdnb294VFVtZVRYaWtKYjdBNm9hTUM2cW5VR3A0?=
 =?utf-8?B?VTdSb0lPb0xIRnRhdnhZQlZxS0VYSmJjSFRQbzJzUVhTZXZGK3FaTW9CdEJp?=
 =?utf-8?B?SXJmdUJ2SDRORDJMenhWc2ZlR0pOK2pPR2xaY282SndtWksxV1VUOERhLzIv?=
 =?utf-8?B?dUs0d3ljdzhORVBVVHMrTGxmNUlja2V3TXR0U2hvRHE1VWl1WHpsSlBCM2dq?=
 =?utf-8?B?RldvM2ZMRG1oNzFzU0hTRUxiT2p5ckwwMUpyT0RVdzlBUXIwNGJHV2o0Mm1T?=
 =?utf-8?B?czBQSnRXaktFTlpOdE83YVUzUFMvbnVobjJYWWdEU3lrZGYyRGRGdGl0Snpi?=
 =?utf-8?B?MXlOVEV4WGgvM015L1ViOWlJREY3bk1aQ3VuQXpQcXRIeGNlUHRZdnVGRUVL?=
 =?utf-8?B?NndLaXhKY2UvL1FqSzNJYWxQYzV1dGRRTGtBSk1peDNqRmdSMHhmUVVBUFI5?=
 =?utf-8?B?TUx3TThWVWlza0E4VjZrVlZtbVN4SnMzSVY2cmxQT1NXZ1pKUWdNcVFtSU1n?=
 =?utf-8?Q?KNad2BLpBui/YPljMIpPKDyyq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?anJKRytkeTJidDdYVWlwaDE4alY3S1JqQ2xYYllIZ2RjOXVwcDg2TzNyZkN1?=
 =?utf-8?B?c3U0ZW9ZWkl1SGkzblQ4bkxoZEZ0THBoRlcvN2tQTlYvQ2pobXdVM0hTVmU2?=
 =?utf-8?B?MWFQTzN3a3ludTFVTCtVZzNIMURoeFJqV2VrWGROL1pWbFBCbzZiaG5KU25p?=
 =?utf-8?B?NEt2ZkZYSVJYOVNCaGdSc1M2SWIyVnFaYWk4cmV4UGdqcWdHUFRZdDFoc1o0?=
 =?utf-8?B?azhWZDIxejh6VmUwYUFTQ05MU2FneTJndDcvNVFHL010MXlpTG84OWY4MVpT?=
 =?utf-8?B?V0dMVUxkRzAwVWJLMWgvQVlrbnF3OUpxMG5jTGdPSVJtM0JVUjdBL3o1ZElG?=
 =?utf-8?B?OHZqQlo1aEx1bXZ6NHc4dTF2Smo2RGtGdjBGS3NjSEJqTHJzS2dJRmhSYncz?=
 =?utf-8?B?ZkhYc3ZiUVlvMktwZ2xaNE9tSHg2TWJQMmxvczk5bkNxaWU1N1dIME11WmJx?=
 =?utf-8?B?aWcxZmNBc1kxVjVFNmhqbnhYclUyVml3ZkRGN3NqN0J6djZzZ2t2YmhuL04y?=
 =?utf-8?B?OGl5ZzAwdHp5bG83Rjd6Sm4wekdaRUJ1eFpwdkJkbDRJckRyK1ZpeHNEVGs4?=
 =?utf-8?B?T0RQS2cxVTRJR2Fna1pDdlVhb3hucG9nNUNDajhDU04wT2NZQU1DUDZTWmcw?=
 =?utf-8?B?eU1RRnhNaEdmN1dFYzh1dHpJSVBERDVTdWNCM3FMNVdta2hnRmJTdElWcERY?=
 =?utf-8?B?YXVqNkJYNWwzQ01QTU9mQ2piWUlMaElTbVV5QVBsVWw5dUpJUWJkd29YUWZP?=
 =?utf-8?B?UzlvMTY4cjJPc2M5QkdKOU5SUGNObWVndU0xdG16Z1lwS3ZpZ2pOTitQT2c3?=
 =?utf-8?B?ajVZcGhwdE9WSWI4VHN4dURxSm5uWE1HWnAraThqVXdtVlRpMTlkY0JxN3pU?=
 =?utf-8?B?Q1ZwUVdFZmt1eGhoOWV1a1Vtc3NKTER0cVh0UnlIQ0RsZXg5aUhkaEhyd0Ry?=
 =?utf-8?B?cEg4NUkxU0NKNXF1b1EvTkt6WFJPZXpiR1JpcEhSN3BJbmRTTGRhV09RTlI0?=
 =?utf-8?B?R1I2dmZpWGdob2s0STZuNE5ydmhheTlXOTMrV3BrcmhlTW9vZllKdVA2NTVT?=
 =?utf-8?B?Q013SXFDS3g0SlBMenV3YnRzYTVSRktjQlF4T3o3akFYYWtYZ1JBMXFVR3NX?=
 =?utf-8?B?L0FuVkVkTUdoNHVhMjZJU0hEVkpqVDc3NGRiQ1dMbjhtYktsU2hZSkhVenRU?=
 =?utf-8?B?L1V3dm9ic2RBb2ZHSUx2NmROZEY5cGUydzFPeHlGZndxNVNtVVp0SzVhbGZD?=
 =?utf-8?B?bmt4SXNpVEtRTm1nTXV6VHhYSzVCbFY2WXNPckNVc1E5YXZMNHlZb2I1c2NC?=
 =?utf-8?B?VTQ0eVhUTmdMYk1XM2RwLzJZYnZrQ1Z0YXovRHoyc3UvV3JBOEQ3aElBVEhB?=
 =?utf-8?B?S3JtU1QvcEUySDVzNS9MampmNncrUllIQzB6b2hBL1hjanp6dVFqTlhuRzdY?=
 =?utf-8?B?d2MrLzU3Q1M2MTljTnBIVC9YaTlMZUppTjdkWWFpakFtbzZGbWZBS3pkN08x?=
 =?utf-8?B?TERQRmZFdGxPWHVYczhFaDBKREpVNG1BWUxxeVdUd0tTeGRwVk1NN2pUNUpo?=
 =?utf-8?Q?6R2PEdxWtAw2I1Y1XiA7QTlkuZLvHKvyV4xPwqbtorzGB1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3959159a-930c-4faa-eecb-08da81767362
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 00:04:57.0677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4ZMfNEwl2K1uV8I7q/clwbvE2/oc1bwgti9k2fZulHHfSKghAVvzK0KsJJOgrutgQu+o1kxIVnqEc9SFUfpvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_18,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180088
X-Proofpoint-ORIG-GUID: F59CMnJmr1rvCoQM-MRFjZFAKbQD9_H1
X-Proofpoint-GUID: F59CMnJmr1rvCoQM-MRFjZFAKbQD9_H1
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
Content-Type: multipart/mixed; boundary="===============7926325904099350171=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7926325904099350171==
Content-Type: multipart/alternative;
 boundary="------------cbQzYe40Iv1UQhK8ggGwIhYr"
Content-Language: en-US

--------------cbQzYe40Iv1UQhK8ggGwIhYr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/17/2022 11:52 PM, Zhu, Lingshan wrote:
>
>
> On 8/18/2022 2:48 AM, Si-Wei Liu wrote:
>>
>>
>> On 8/16/2022 11:23 PM, Zhu, Lingshan wrote:
>>>
>>>
>>> On 8/17/2022 2:14 PM, Michael S. Tsirkin wrote:
>>>> On Wed, Aug 17, 2022 at 10:11:36AM +0800, Zhu, Lingshan wrote:
>>>>>
>>>>> On 8/17/2022 6:48 AM, Si-Wei Liu wrote:
>>>>>
>>>>>
>>>>>
>>>>>      On 8/16/2022 1:29 AM, Zhu, Lingshan wrote:
>>>>>
>>>>>
>>>>>
>>>>>          On 8/16/2022 3:41 PM, Si-Wei Liu wrote:
>>>>>
>>>>>              Hi Michael,
>>>>>
>>>>>              I just noticed this patch got pulled to linux-next 
>>>>> prematurely
>>>>>              without getting consensus on code review, am not sure 
>>>>> why. Hope it
>>>>>              was just an oversight.
>>>>>
>>>>>              Unfortunately this introduced functionality 
>>>>> regression to at least
>>>>>              two cases so far as I see:
>>>>>
>>>>>              1. (bogus) VDPA_ATTR_DEV_NEGOTIATED_FEATURES are 
>>>>> inadvertently
>>>>>              exposed and displayed in "vdpa dev config show" 
>>>>> before feature
>>>>>              negotiation is done. Noted the corresponding features 
>>>>> name shown in
>>>>>              vdpa tool is called "negotiated_features" rather than
>>>>>              "driver_features". I see in no way the intended 
>>>>> change of the patch
>>>>>              should break this user level expectation regardless 
>>>>> of any spec
>>>>>              requirement. Do you agree on this point?
>>>>>
>>>>>          I will post a patch for iptour2, doing:
>>>>>          1) if iprout2 does not get driver_features from the 
>>>>> kernel, then don't
>>>>>          show negotiated features in the command output
>>>>>
>>>>>      This won't work as the vdpa userspace tool won't know *when* 
>>>>> features are
>>>>>      negotiated. There's no guarantee in the kernel to assume 0 
>>>>> will be returned
>>>>>      from vendor driver during negotiation. On the other hand, 
>>>>> with the supposed
>>>>>      change, userspace can't tell if there's really none of 
>>>>> features negotiated,
>>>>>      or the feature negotiation is over. Before the change the 
>>>>> userspace either
>>>>>      gets all the attributes when feature negotiation is over, or 
>>>>> it gets
>>>>>      nothing when it's ongoing, so there was a distinction.This 
>>>>> expectation of
>>>>>      what "negotiated_features" represents is established from day 
>>>>> one, I see no
>>>>>      reason the intended kernel change to show other attributes 
>>>>> should break
>>>>>      userspace behavior and user's expectation.
>>>>>
>>>>> User space can only read valid *driver_features* after the 
>>>>> features negotiation
>>>>> is done, *device_features* does not require the negotiation.
>>>>>
>>>>> If you want to prevent random values read from driver_features, 
>>>>> here I propose
>>>>> a fix: only read driver_features when the negotiation is done, 
>>>>> this means to
>>>>> check (status & VIRTIO_CONFIG_S_FEATURES_OK) before reading the
>>>>> driver_features.
>>>>> Sounds good?
>>>>>
>>>>> @MST, if this is OK, I can include this change in my next version 
>>>>> patch series.
>>>>>
>>>>> Thanks,
>>>>> Zhu Lingshan
>>>> Sorry I don't get it. Is there going to be a new version? Do you 
>>>> want me
>>>> to revert this one and then apply a new one? It's ok if yes.
>>> Not a new version, it is a new patch, though I still didn't get the 
>>> race condition, but I believe it
>>> is reasonable to block reading the *driver_features* before 
>>> FEATURES_OK.
>>>
>>> So, I added code to check whether _FEATURES_OK is set:
>>>
>>>  861         /* only read driver features after the feature 
>>> negotiation is done */
>>>  862         status = vdev->config->get_status(vdev);
>>>  863         if (status & VIRTIO_CONFIG_S_FEATURES_OK) {
>>>  864                 features_driver = 
>>> vdev->config->get_driver_features(vdev);
>>>  865                 if (nla_put_u64_64bit(msg, 
>>> VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
>>>  866                                       VDPA_ATTR_PAD))
>>>  867                 return -EMSGSIZE;
>>>  868         }
>>>
>>> If this solution looks good, I will add this patch in my V2 series.
>> This solves the 1st issue in my report, but without a fix for the 2nd 
>> issue ( vdpa_dev_net_config_fill and vdpa_set_features race) 
>> addressed I don't think it covers all incurred regressions.
>>
>> I've replied the way to reproduce the race. For me it's very obvious 
>> to see in my setup.
> Though I still did not see any errors in my run, but I guess you mean 
> the race condition in set_features(), right?
Yes.
>
> The spec says: The device MUST allow reading of any device-specific 
> configuration field before FEATURES_OK is set by the driver.
>
> So there is no need to check whether driver_features is set in 
> vdpa_get_config_unlocked(). We should remove the code checks
> feature_valid and the code set_features to zero. This conflicts with 
> the spec. And so no race conditions.
I don't disagree with the removal, you can try once more. This proposal 
had been attempted but rejected.

-Siwei



>
> Thanks,
> Zhu Lingshan
>>>
>>> > So what is the race?
>>> You'll see the race if you keep 'vdpa dev config show ...' running 
>>> in a tight loop while launching a VM with the vDPA device under query.
>>>
>> -Siwei
>>
>>>
>>> Thanks
>>> Zhu Lingshan
>>>
>>>>
>>>>
>>>>>          2) process and decoding the device features.
>>>>>
>>>>>
>>>>>              2. There was also another implicit assumption that is 
>>>>> broken by
>>>>>              this patch. There could be a vdpa tool query of 
>>>>> config via
>>>>> vdpa_dev_net_config_fill()->vdpa_get_config_unlocked() that races
>>>>>              with the first vdpa_set_features() call from VMM e.g. 
>>>>> QEMU. Since
>>>>>              the S_FEATURES_OK blocking condition is removed, if 
>>>>> the vdpa tool
>>>>>              query occurs earlier than the first 
>>>>> set_driver_features() call from
>>>>>              VMM, the following code will treat the guest as 
>>>>> legacy and then
>>>>>              trigger an erroneous vdpa_set_features_unlocked(... , 
>>>>> 0) call to
>>>>>              the vdpa driver:
>>>>>
>>>>>               374         /*
>>>>>               375          * Config accesses aren't supposed to 
>>>>> trigger before
>>>>>              features are set.
>>>>>               376          * If it does happen we assume a legacy 
>>>>> guest.
>>>>>               377          */
>>>>>               378         if (!vdev->features_valid)
>>>>>               379 vdpa_set_features_unlocked(vdev, 0);
>>>>>               380         ops->get_config(vdev, offset, buf, len);
>>>>>
>>>>>              Depending on vendor driver's implementation, L380 may 
>>>>> either return
>>>>>              invalid config data (or invalid endianness if on BE) 
>>>>> or only config
>>>>>              fields that are valid in legacy layout. What's more 
>>>>> severe is that,
>>>>>              vdpa tool query in theory shouldn't affect feature 
>>>>> negotiation at
>>>>>              all by making confusing calls to the device, but now 
>>>>> it is possible
>>>>>              with the patch. Fixing this would require more 
>>>>> delicate work on the
>>>>>              other paths involving the cf_lock reader/write 
>>>>> semaphore.
>>>>>
>>>>>              Not sure what you plan to do next, post the fixes for 
>>>>> both issues
>>>>>              and get the community review? Or simply revert the 
>>>>> patch in
>>>>>              question? Let us know.
>>>>>
>>>>>          The spec says:
>>>>>          The device MUST allow reading of any device-specific 
>>>>> configuration
>>>>>          field before FEATURES_OK is set by
>>>>>          the driver. This includes fields which are conditional on 
>>>>> feature bits,
>>>>>          as long as those feature bits are offered
>>>>>          by the device.
>>>>>
>>>>>          so whether FEATURES_OK should not block reading the 
>>>>> device config
>>>>>          space. vdpa_get_config_unlocked() will read the features, 
>>>>> I don't know
>>>>>          why it has a comment:
>>>>>                  /*
>>>>>                   * Config accesses aren't supposed to trigger 
>>>>> before features
>>>>>          are set.
>>>>>                   * If it does happen we assume a legacy guest.
>>>>>                   */
>>>>>
>>>>>          This conflicts with the spec.
>>>>>
>>>>>          vdpa_get_config_unlocked() checks vdev->features_valid, 
>>>>> if not valid,
>>>>>          it will set the drivers_features 0, I think this intends 
>>>>> to prevent
>>>>>          reading random driver_features. This function does not 
>>>>> hold any locks,
>>>>>          and didn't change anything.
>>>>>
>>>>>          So what is the race?
>>>>>          You'll see the race if you keep 'vdpa dev config show 
>>>>> ...' running in a
>>>>>      tight loop while launching a VM with the vDPA device under 
>>>>> query.
>>>>>
>>>>>      -Siwei
>>>>>
>>>>>
>>>>>
>>>>>                  Thanks
>>>>>
>>>>>
>>>>>              Thanks,
>>>>>              -Siwei
>>>>>
>>>>>
>>>>>              On 8/12/2022 3:44 AM, Zhu Lingshan wrote:
>>>>>
>>>>>                  Users may want to query the config space of a 
>>>>> vDPA device,
>>>>>                  to choose a appropriate one for a certain guest. 
>>>>> This means the
>>>>>                  users need to read the config space before 
>>>>> FEATURES_OK, and
>>>>>                  the existence of config space contents does not 
>>>>> depend on
>>>>>                  FEATURES_OK.
>>>>>
>>>>>                  The spec says:
>>>>>                  The device MUST allow reading of any device-specific
>>>>>                  configuration
>>>>>                  field before FEATURES_OK is set by the driver. 
>>>>> This includes
>>>>>                  fields which are conditional on feature bits, as 
>>>>> long as those
>>>>>                  feature bits are offered by the device.
>>>>>
>>>>>                  Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>>>                  ---
>>>>>                    drivers/vdpa/vdpa.c | 8 --------
>>>>>                    1 file changed, 8 deletions(-)
>>>>>
>>>>>                  diff --git a/drivers/vdpa/vdpa.c 
>>>>> b/drivers/vdpa/vdpa.c
>>>>>                  index 6eb3d972d802..bf312d9c59ab 100644
>>>>>                  --- a/drivers/vdpa/vdpa.c
>>>>>                  +++ b/drivers/vdpa/vdpa.c
>>>>>                  @@ -855,17 +855,9 @@ vdpa_dev_config_fill(struct 
>>>>> vdpa_device
>>>>>                  *vdev, struct sk_buff *msg, u32 portid,
>>>>>                    {
>>>>>                        u32 device_id;
>>>>>                        void *hdr;
>>>>>                  -    u8 status;
>>>>>                        int err;
>>>>> down_read(&vdev->cf_lock);
>>>>>                  -    status = vdev->config->get_status(vdev);
>>>>>                  -    if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
>>>>>                  -        NL_SET_ERR_MSG_MOD(extack, "Features 
>>>>> negotiation not
>>>>>                  completed");
>>>>>                  -        err = -EAGAIN;
>>>>>                  -        goto out;
>>>>>                  -    }
>>>>>                  -
>>>>>                        hdr = genlmsg_put(msg, portid, seq, 
>>>>> &vdpa_nl_family,
>>>>>                  flags,
>>>>> VDPA_CMD_DEV_CONFIG_GET);
>>>>>                        if (!hdr) {
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>
>>
>

--------------cbQzYe40Iv1UQhK8ggGwIhYr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 8/17/2022 11:52 PM, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b2430d3b-4ca2-a19c-da39-da91da732c02@intel.com">
      
      <font face="monospace"><br>
        <br>
      </font>
      <div class="moz-cite-prefix"><font face="monospace">On 8/18/2022
          2:48 AM, Si-Wei Liu wrote:<br>
        </font></div>
      <blockquote type="cite" cite="mid:6325f067-3744-8952-e724-f22de35c8496@oracle.com"> <font face="monospace"> <br>
        </font> <font face="monospace"><br>
        </font>
        <div class="moz-cite-prefix"><font face="monospace">On 8/16/2022
            11:23 PM, Zhu, Lingshan wrote:<br>
          </font> </div>
        <blockquote type="cite" cite="mid:b489413e-e933-e9b6-a719-45090a4e922c@intel.com"> <font face="monospace"><br>
          </font> <font face="monospace"><br>
            On 8/17/2022 2:14 PM, Michael S. Tsirkin wrote: <br>
          </font>
          <blockquote type="cite"><font face="monospace">On Wed, Aug 17,
              2022 at 10:11:36AM +0800, Zhu, Lingshan wrote: <br>
            </font>
            <blockquote type="cite"> <font face="monospace"><br>
                On 8/17/2022 6:48 AM, Si-Wei Liu wrote: <br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp; On 8/16/2022 1:29 AM, Zhu, Lingshan wrote: <br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On 8/16/2022 3:41 PM, Si-Wei Liu wrote: <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Hi Michael, <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I just noticed this patch got pulled to
                linux-next prematurely <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; without getting consensus on code review,
                am not sure why. Hope it <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; was just an oversight. <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Unfortunately this introduced functionality
                regression to at least <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; two cases so far as I see: <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. (bogus)
                VDPA_ATTR_DEV_NEGOTIATED_FEATURES are inadvertently <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exposed and displayed in &quot;vdpa dev config
                show&quot; before feature <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; negotiation is done. Noted the
                corresponding features name shown in <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vdpa tool is called &quot;negotiated_features&quot;
                rather than <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;driver_features&quot;. I see in no way the
                intended change of the patch <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; should break this user level expectation
                regardless of any spec <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; requirement. Do you agree on this point? <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I will post a patch for iptour2, doing: <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1) if iprout2 does not get driver_features from
                the kernel, then don't <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; show negotiated features in the command output
                <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp; This won't work as the vdpa userspace tool won't
                know *when* features are <br>
                &nbsp;&nbsp;&nbsp;&nbsp; negotiated. There's no guarantee in the kernel to
                assume 0 will be returned <br>
                &nbsp;&nbsp;&nbsp;&nbsp; from vendor driver during negotiation. On the other
                hand, with the supposed <br>
                &nbsp;&nbsp;&nbsp;&nbsp; change, userspace can't tell if there's really none
                of features negotiated, <br>
                &nbsp;&nbsp;&nbsp;&nbsp; or the feature negotiation is over. Before the
                change the userspace either <br>
                &nbsp;&nbsp;&nbsp;&nbsp; gets all the attributes when feature negotiation is
                over, or it gets <br>
                &nbsp;&nbsp;&nbsp;&nbsp; nothing when it's ongoing, so there was a
                distinction.This expectation of <br>
                &nbsp;&nbsp;&nbsp;&nbsp; what &quot;negotiated_features&quot; represents is
                established from day one, I see no <br>
                &nbsp;&nbsp;&nbsp;&nbsp; reason the intended kernel change to show other
                attributes should break <br>
                &nbsp;&nbsp;&nbsp;&nbsp; userspace behavior and user's expectation. <br>
              </font> <font face="monospace"><br>
                User space can only read valid *driver_features* after
                the features negotiation <br>
                is done, *device_features* does not require the
                negotiation. <br>
              </font> <font face="monospace"><br>
                If you want to prevent random values read from
                driver_features, here I propose <br>
                a fix: only read driver_features when the negotiation is
                done, this means to <br>
                check (status &amp; VIRTIO_CONFIG_S_FEATURES_OK) before
                reading the <br>
                driver_features. <br>
                Sounds good? <br>
              </font> <font face="monospace"><br>
                @MST, if this is OK, I can include this change in my
                next version patch series. <br>
              </font> <font face="monospace"><br>
                Thanks, <br>
                Zhu Lingshan <br>
              </font> </blockquote>
            <font face="monospace"> Sorry I don't get it. Is there going
              to be a new version? Do you want me <br>
              to revert this one and then apply a new one? It's ok if
              yes. <br>
            </font> </blockquote>
          <font face="monospace"> Not a new version, it is a new patch,
            though I still didn't get the race condition, but I believe
            it <br>
            is reasonable to block reading the *driver_features* before
            FEATURES_OK. <br>
          </font> <font face="monospace"><br>
            So, I added code to check whether _FEATURES_OK is set: <br>
          </font> <font face="monospace"><br>
            &nbsp;861&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only read driver features after the feature
            negotiation is done */ <br>
            &nbsp;862&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = vdev-&gt;config-&gt;get_status(vdev);
            <br>
            &nbsp;863&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status &amp; VIRTIO_CONFIG_S_FEATURES_OK) {
            <br>
            &nbsp;864&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features_driver =
            vdev-&gt;config-&gt;get_driver_features(vdev); <br>
            &nbsp;865&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (nla_put_u64_64bit(msg,
            VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver, <br>
            &nbsp;866&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VDPA_ATTR_PAD)) <br>
            &nbsp;867&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EMSGSIZE; <br>
            &nbsp;868&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
          </font> <font face="monospace"><br>
            If this solution looks good, I will add this patch in my V2
            series. <br>
          </font> </blockquote>
        <font face="monospace"> This solves the 1st issue in my report,
          but without a fix for the 2nd issue ( vdpa_dev_net_config_fill
          and vdpa_set_features race) addressed I don't think it covers
          all incurred regressions.<br>
        </font> <font face="monospace"><br>
          I've replied the way to reproduce the race. For me it's very
          obvious to see in my setup.<br>
        </font></blockquote>
      <font face="monospace">Though I still did not see any errors in my
        run, but I guess you mean the race condition in set_features(),
        right?<br>
      </font></blockquote>
    <font face="monospace">Yes. </font><br>
    <blockquote type="cite" cite="mid:b2430d3b-4ca2-a19c-da39-da91da732c02@intel.com"><font face="monospace"> <br>
        The spec says: The device MUST allow reading of any
        device-specific configuration field before FEATURES_OK is set by
        the driver.<br>
        <br>
        So there is no need to check whether driver_features is set in
        vdpa_get_config_unlocked(). We should remove the code checks<br>
        feature_valid and the code set_features to zero. This conflicts
        with the spec. And so no race conditions.<br>
      </font></blockquote>
    I don't disagree with the removal, you can try once more. This
    proposal had been attempted but rejected.<br>
    <br>
    -Siwei<br>
    <br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:b2430d3b-4ca2-a19c-da39-da91da732c02@intel.com"><font face="monospace"> <br>
        Thanks,<br>
        Zhu Lingshan<br>
      </font>
      <blockquote type="cite" cite="mid:6325f067-3744-8952-e724-f22de35c8496@oracle.com">
        <blockquote type="cite"><font face="monospace"><span class="fontstyle0"><br>
              &gt; So what is the race?<br>
            </span></font> <font face="monospace">You'll see the race
            if you keep 'vdpa dev config show ...' running in a tight
            loop while launching a VM with the vDPA device under query.<br>
          </font> <font face="monospace"><br>
          </font> </blockquote>
        <font face="monospace"> -Siwei<br>
        </font> <font face="monospace"><br>
        </font>
        <blockquote type="cite" cite="mid:b489413e-e933-e9b6-a719-45090a4e922c@intel.com"> <font face="monospace"><br>
            Thanks <br>
            Zhu Lingshan <br>
          </font> <font face="monospace"><br>
          </font>
          <blockquote type="cite"> <font face="monospace"><br>
            </font> <font face="monospace"><br>
            </font>
            <blockquote type="cite"><font face="monospace">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2)
                process and decoding the device features. <br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. There was also another implicit
                assumption that is broken by <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; this patch. There could be a vdpa tool
                query of config via <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                vdpa_dev_net_config_fill()-&gt;vdpa_get_config_unlocked()
                that races <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with the first vdpa_set_features() call
                from VMM e.g. QEMU. Since <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the S_FEATURES_OK blocking condition is
                removed, if the vdpa tool <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query occurs earlier than the first
                set_driver_features() call from <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMM, the following code will treat the
                guest as legacy and then <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trigger an erroneous
                vdpa_set_features_unlocked(... , 0) call to <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the vdpa driver: <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;374&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;375&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Config accesses aren't
                supposed to trigger before <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features are set. <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;376&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If it does happen we assume
                a legacy guest. <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;377&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;378&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vdev-&gt;features_valid)
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;379&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                vdpa_set_features_unlocked(vdev, 0); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;380&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops-&gt;get_config(vdev,
                offset, buf, len); <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Depending on vendor driver's
                implementation, L380 may either return <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; invalid config data (or invalid endianness
                if on BE) or only config <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fields that are valid in legacy layout.
                What's more severe is that, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vdpa tool query in theory shouldn't affect
                feature negotiation at <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; all by making confusing calls to the
                device, but now it is possible <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with the patch. Fixing this would require
                more delicate work on the <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; other paths involving the cf_lock
                reader/write semaphore. <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not sure what you plan to do next, post the
                fixes for both issues <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and get the community review? Or simply
                revert the patch in <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; question? Let us know. <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The spec says: <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The device MUST allow reading of any
                device-specific configuration <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; field before FEATURES_OK is set by <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the driver. This includes fields which are
                conditional on feature bits, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; as long as those feature bits are offered <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; by the device. <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; so whether FEATURES_OK should not block reading
                the device config <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; space. vdpa_get_config_unlocked() will read the
                features, I don't know <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; why it has a comment: <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Config accesses aren't supposed to
                trigger before features <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; are set. <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If it does happen we assume a legacy
                guest. <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This conflicts with the spec. <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vdpa_get_config_unlocked() checks
                vdev-&gt;features_valid, if not valid, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; it will set the drivers_features 0, I think
                this intends to prevent <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reading random driver_features. This function
                does not hold any locks, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and didn't change anything. <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; So what is the race? <br>
                &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; You'll see the race if you keep 'vdpa dev
                config show ...' running in a <br>
                &nbsp;&nbsp;&nbsp;&nbsp; tight loop while launching a VM with the vDPA
                device under query. <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp; -Siwei <br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -Siwei <br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; On 8/12/2022 3:44 AM, Zhu Lingshan wrote: <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Users may want to query the config
                space of a vDPA device, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to choose a appropriate one for a
                certain guest. This means the <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; users need to read the config space
                before FEATURES_OK, and <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the existence of config space contents
                does not depend on <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEATURES_OK. <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The spec says: <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The device MUST allow reading of any
                device-specific <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; configuration <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; field before FEATURES_OK is set by the
                driver. This includes <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fields which are conditional on feature
                bits, as long as those <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature bits are offered by the device.
                <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com" moz-do-not-send="true">&lt;lingshan.zhu@intel.com&gt;</a>
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --- <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; drivers/vdpa/vdpa.c | 8 -------- <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 1 file changed, 8 deletions(-) <br>
              </font> <font face="monospace"><br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; diff --git a/drivers/vdpa/vdpa.c
                b/drivers/vdpa/vdpa.c <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index 6eb3d972d802..bf312d9c59ab 100644
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --- a/drivers/vdpa/vdpa.c <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +++ b/drivers/vdpa/vdpa.c <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @@ -855,17 +855,9 @@
                vdpa_dev_config_fill(struct vdpa_device <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vdev, struct sk_buff *msg, u32 portid,
                <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; { <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 device_id; <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *hdr; <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; u8 status; <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err; <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                down_read(&amp;vdev-&gt;cf_lock); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; status =
                vdev-&gt;config-&gt;get_status(vdev); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; if (!(status &amp;
                VIRTIO_CONFIG_S_FEATURES_OK)) { <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NL_SET_ERR_MSG_MOD(extack,
                &quot;Features negotiation not <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; completed&quot;); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err = -EAGAIN; <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out; <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp; } <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr = genlmsg_put(msg, portid,
                seq, &amp;vdpa_nl_family, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags, <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                VDPA_CMD_DEV_CONFIG_GET); <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hdr) { <br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
              </font> <font face="monospace"><br>
              </font> </blockquote>
          </blockquote>
          <font face="monospace"><br>
          </font> </blockquote>
        <font face="monospace"><br>
        </font> </blockquote>
      <font face="monospace"><br>
      </font> </blockquote>
    <br>
  </body>
</html>

--------------cbQzYe40Iv1UQhK8ggGwIhYr--

--===============7926325904099350171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7926325904099350171==--
