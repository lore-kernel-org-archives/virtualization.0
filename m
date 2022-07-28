Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F498C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 21:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A858683022;
	Thu, 28 Jul 2022 21:54:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A858683022
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=dF25E73w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=RJ1jQWON
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bvNAF4CXH0h2; Thu, 28 Jul 2022 21:54:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0AA36824EF;
	Thu, 28 Jul 2022 21:54:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AA36824EF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA468C0033;
	Thu, 28 Jul 2022 21:54:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E63DC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 21:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED24660ABB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 21:54:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED24660ABB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=dF25E73w; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=RJ1jQWON
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aDRmmSevEB7r
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 21:54:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B607660671
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B607660671
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 21:54:14 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SKJ3u1011130;
 Thu, 28 Jul 2022 21:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VSBymVTOCk1ck3sKx8nWRMvV+S4tDc9wTmyO5E6BdVM=;
 b=dF25E73wm4CkITkO5T2N566l5JfqHa4sNZNTnuvbhzrbPWt+rPy32lZXgdF5Izuwq03H
 hrW0glfWCjrqsJbwBEI13tCDtuXpJralb9XFe3QthMVLSb69dtENkFk6CEGgwMDoxonb
 xh8sjDb2sD/qXF+Md+FpkfjDhzeoZ7agYK5g6nTZAQPy4+mR4KyFhtelTZgQX7X7fHwu
 6KnxFZLtd1YSNjSqHOSPtf3Q17YDNDSBnT9gP6K8aWwm7kB7RB0WM5N31JjkcPCPgRcR
 kky1tq0LjIhhbyPuxto1CGcHexEi5Z+zHev7YIYm0ge4z05pcTX6mELUO1W+8dAFsVEF mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9ap5b6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 21:54:10 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26SKUt2d006173; Thu, 28 Jul 2022 21:54:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh65eq8k0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 21:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxS6gZPh7GxHo3nlnruaxmd9xW8eTN1pYkTjF5clHGgmnm0V9T1MCrIVgKAVDoV3swzCK1d5a4dQH/UIHX+SYrb7VgkHcwx+KRK9MmuzV3EN45rmR/C84L8aE+8Wr2SmamJKC/HGq0REQLiIPwqYatfr+cbfhiG4ZuicO7n0Yn5lRGSFQvDQUCFHMDLjLW3ADDbMPs8pYuCR1OiGfS6fMpI+37M1oJdEqXHpdaLcy3vk7k2rCo7l2/d+r5v01wJtuXnxrQ5FdeqyxPIA2dhFu5Mui7qUEicwa1RV4dsHw8QgSuWNxKhVXUbgdJJTxK1p3q9yZWW3IjhLwDJ1O6Dy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSBymVTOCk1ck3sKx8nWRMvV+S4tDc9wTmyO5E6BdVM=;
 b=E2I1m1Yo70w8yeT5S9qyueMfafhVylUGvtCFAs+ojFe/YlCmDYWOUBX3LRJeZwLc0y1nVxPhqvQ3kxpoXkvRKimTUl+yDk8zS3+ViqJqhcAtMw5AMCgqqMzJS5YEUOpkp9Zhgh+qpus44wPrnhOpY8UCu0bYQZnmq/TxDjyKfMzuft2geHR5sb57PVyrFvl5vm5CDhO4jm1wJlPF2wqPgh3Rx3Gw/etQhgTOdoJB5yBzV5MUqntOajzPlQtI5RnAsR3WXgOeDh9z2gbgsHFsYcwQ3sDyTKwqlYWQfo5VgZfcBynIpcERp+cZLIdUBxvd85m5cuAXnc7JmOfK0JLw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSBymVTOCk1ck3sKx8nWRMvV+S4tDc9wTmyO5E6BdVM=;
 b=RJ1jQWONK2nAt6ncSDDoLNVpulQhN5bBRiA2w+nhL+FuAgnTJPoscfMLv9sydFaWc2LuVgc/0O/+bUQcuixYvf3Z44XNQ5LwbCD9VW7TMXhNr+5cpM8yhqaW4j5wVNhu1qyXX/pxazYUqIgsguRJFdlmu46F1zsOaynBR4EdDDw=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by DM5PR10MB1644.namprd10.prod.outlook.com (2603:10b6:4:f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Thu, 28 Jul 2022 21:54:07 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.026; Thu, 28 Jul 2022
 21:54:07 +0000
Message-ID: <41ae3d6a-664a-0264-0c60-a6743c233f19@oracle.com>
Date: Thu, 28 Jul 2022 14:54:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Content-Language: en-US
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <c7c8f49c-484f-f5b3-39e6-0d17f396cca7@intel.com>
 <PH0PR12MB5481E65037E0B4F6F583193BDC899@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <66291287-fcb3-be8d-2c1b-dd44533ed8b3@oracle.com>
 <20220727050102-mutt-send-email-mst@kernel.org>
 <6d5b03ee-5362-8534-5881-a34c9ea626f0@oracle.com>
 <939bc589-b3ad-d317-8b1d-6da58e4670c0@intel.com>
 <e546e6c0-37bd-ee3e-76e5-def63a33f432@oracle.com>
 <685241b9-3487-489c-2784-2a2209f660ad@intel.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <685241b9-3487-489c-2784-2a2209f660ad@intel.com>
X-ClientProxiedBy: SJ0PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::21) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1b0a735-86ea-45e4-409a-08da70e3b1f7
X-MS-TrafficTypeDiagnostic: DM5PR10MB1644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bch4R9ey7YrE1EMeImJ0jR0YMVNasi1as8pOKMP00E8YE6kO6+qsiPrEKEtWCetC0f+vWgUBa7Cj/+ugA8+5BjL81aYCgo6RcEfYlLZN2aBc7Rm1uXRGM7zyqtC66PImI6OKZqclbzQzmhIdieU8f3zVJw3Y0yJLCP0BIZnX2mYBXB4yF2h2y8fMta+Uk8cV4WFUPeYvHe07UWlawx9+aly2+Bexx+/2Krx0IG0/Ni2RJJEyWqCMhphtHzEtpI+nIdt6Cs8JKB9cEuyOFYmdIRWKuDl/u9whMDbtU7YHKwwM+LFsFB8a09vcDKmZkOa4E3w6ryeJSGJ7hriF4k9ifCZF/Hl5CwrjdpVscOUCyodwiPpVjD0Z7V5EoJQbu9JHWslzPYYmCfgyCuXy4W789YHoHqwwSNvXG728vZZWnDL+aWLtQeI7rYw4xHh5l+4MmHhx+Xb48jgesSXMcYBJiHU0DqAlzVq9iF2OKpec76EYUUlJSlYbaMDqaaZcVZxT8p/y3vQGMzUrEaAoOeeuVAX3qUlI+UlSIguHxQpB5+dknRFkUzcA6sMBe1pQz7yqDgEWpl/57sTsgiy8Zw1FKYUY5RJJhWVQIDMKM2eztxetUwNby/U5dp86FNWDDpIsnxa3FOyFKzlxz+s9LRRtd81kpiIsCpwHGzsBqvfiw8oFsMkwXpgiKYAuDWykIN5Xpyydh60f6R86BzqLkREFD8sDgfyzdtJ9e+dx6zrTIrQQ4/fltiZDZ9foTnBk5NA8FBOjgDaGCWhOLObf7RH9A5YmJ3YsnXMlXRGf4NKoR1l76+BdKMP9lQwLLPtRa9EoxiMM3YpafwY/PITh7jFE3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(366004)(396003)(136003)(346002)(376002)(39860400002)(6486002)(36916002)(26005)(53546011)(8936002)(6512007)(66946007)(66476007)(6666004)(38100700002)(4326008)(316002)(8676002)(2906002)(5660300002)(186003)(6506007)(478600001)(41300700001)(66556008)(31696002)(86362001)(36756003)(54906003)(83380400001)(110136005)(31686004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THk4NHo0S2xobkJ1Q3M2ZnVicjFFb2ZrelZBdlFkNDRLcjFOQU9ycGxhQjBJ?=
 =?utf-8?B?M2xheVVyZkdkWVUrd1ZydjRmcCtJaDRlbGNralU0V3JvS3dPT2hwSnVhOHAz?=
 =?utf-8?B?cVRoQi9UMHJ6dGw3djJIcTYwS3ZHRCsxSElHMnNxRm4wNzkyQlBRUnpWcEF6?=
 =?utf-8?B?VWdjVWhsekVXc1lHV0VBZDZrdWsxazRpZzdQbFVwRFJhL2hvZ0lsTEpzYTdX?=
 =?utf-8?B?UmRqTDI4M3RTS3VWaC9SWUxSUzJRcm1zTDBXMzFDcnVXSkRZOWxKYjJpOTZQ?=
 =?utf-8?B?cHFBRThqNW9xMzlZVzV2ZE82Q2J3QXRxQ0EyejlSSTJPK05UVVNKakJTbkpU?=
 =?utf-8?B?bDk3OTJXanVPZUpJK0dyaGFzcTRQMU8wcmNaYzFqTDBzSzgraDdmNFgrTEZV?=
 =?utf-8?B?QXpFRSthTStqK2VXaFdpSnU3VlRMSis2MDc5d0FGY0ZlTkYzYndYbU40a0xM?=
 =?utf-8?B?N0toRWhEZnVtREtYeVkyWEc5VGRVY0tGMng1Y05kbkFMTmczV2k0SWtWUlNh?=
 =?utf-8?B?SmdVYlFJd3EwclZFYkM4dlJ6SnBEVVV5aG5sTFBsTEZpRjlXTUh2ajE5MnlN?=
 =?utf-8?B?OGZ0aGZVb3ZCOUxIVmN3Zld4UEJld0RsMDkvdlRiQkFxWWZlZkJVTUt6bFpx?=
 =?utf-8?B?RjdQWVR0TVVwMUNySWJidmZRSzJwZDIvN29sQ0t6MUhhcU91WWxBUnEybnl3?=
 =?utf-8?B?UTh6YWQ0bTZkUGJxTkhFbFhld0VYbkovUVVWeVhVZnpkeUZqVmdNbWR3ekNu?=
 =?utf-8?B?NU9jaDhtRGNZZ3AzeTBIK1FZSFlOL2U5K1dBUzRNcGxxUzBpNXhBWEVRRUVO?=
 =?utf-8?B?R2ZXdVJERThtTURIN1M3VmJvNG5QaDlibXhMYjlKS29iOGpzdUFuRkpnMDl0?=
 =?utf-8?B?MHlYRGtXYlovOXhpZkxpTTF4NlBMNWNUZzB3NFlVQjFabjE4cG5PRDhlYTNB?=
 =?utf-8?B?Q3NXV1J5NlFWbVRBeHpTbi9rSDZHZ3pXanhzNitnUzRBc3FtZTVyQk9TK3l5?=
 =?utf-8?B?WVU3bGFUMExoSHZKR3ByL3k2dUcwK3J0T1VmODNDTDU5eWgyM2ZzRnVTeEhF?=
 =?utf-8?B?amNVNFJ0SVgvODBMbUxOUkx5d0gvSGRWdGdlZkE0OEpNa3ZKeC9LYmZvSGsy?=
 =?utf-8?B?MVIxSFB0b2FPaDFtalFWbFloejBPdXphcDVEMVh3L2szNnROSHVSK0FMWlls?=
 =?utf-8?B?T3FXUFNYaTU5bFpWajlmZTZZazFMbjhPU3IwSTJGZStnWGlneiszam53Y3pD?=
 =?utf-8?B?N2pOSDVyV2ZjMHlDdmU1bTZTc29pVkhrMU1MQVlJV1RJQVJHSnM0L25tY3NQ?=
 =?utf-8?B?Z0ZQRTh1aDJwVi9oUkUvZHl2bkxHd1JKbTB3ZU0rTCs2YU90RTJacXNtVEdQ?=
 =?utf-8?B?UGZTRnFwNEdIdlVmVTFWbzJsTFlFZ1FQdzI5MlpROTdGL2RKNDFLSTBaYmFj?=
 =?utf-8?B?RmYzYUgyZEMrU2p2cmRkS0pkRytjZFV2NlliVGgrd2I2NzUrNWU5SWFSaG9X?=
 =?utf-8?B?cVlhUkhENEJlMG9NcVhUNWhweUdOS0pUMEJPTEphWjYxN3BwMmhLRGFLclJI?=
 =?utf-8?B?cTZxc1cxdmdBbnVQUndEWTczdWRrU0RwT016a3laamV2MkZvVGUzWlZ6N0Mx?=
 =?utf-8?B?VlBzV2pRU21uZXhzT212STBuZGx2TnUwTk94OTgrT2kzMzNvUWpqaFp5Mjd2?=
 =?utf-8?B?cG5Fa2VERDVVVDdWeTFVcTZzd2diMi9PbUNQaWRzZnZZekJ4Ty9oMHZQRlFu?=
 =?utf-8?B?NER0dS8rYXFNWkFkMU1YYjVhazZFZ2w0V3JTcFRQWTlKVWFPazRGOCtId3JH?=
 =?utf-8?B?VHNsUCtCdWpybDBEUFNMRm03T1MrSlpiSnAvdGVBMFpDVWhaMk4xaFBiWktD?=
 =?utf-8?B?eHNIRlErRVA5eWZzSUVBQnNLQ01vSU9Ra1BJcDlqSFJOYVcveTVVb0lZTWJC?=
 =?utf-8?B?bnUzd3lUWG9maStxU3FHK3lDMnJtVTY0VWt4MHVlbFJnYk8zOFAydGZ3bWpE?=
 =?utf-8?B?QUJ2VU5uMkxWRk53NCtjTUlzU05KUmdGeXp4eU00cDN2OFhsSzJnNVVPbWQv?=
 =?utf-8?B?ZDlEb1FtTVc4eC9YajZ0UkZTdmlxYU1jbmFseFZidFRzbGVJb3I5V3o0UzRs?=
 =?utf-8?Q?ERjr4Pf2RtzoGfEiCydW/yYtl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b0a735-86ea-45e4-409a-08da70e3b1f7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 21:54:07.3723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j08XrWWVzMMxaHW/f/XTYgPTFFkEi0pDWaGXBvnLhZBQgvUVgtaIPs6rh4CzV1J5SzUNvbnBFrYbGgJB3CWgKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280098
X-Proofpoint-ORIG-GUID: LW1pPoiSL5nfYPDUQNjFzzftyYp1jVrq
X-Proofpoint-GUID: LW1pPoiSL5nfYPDUQNjFzzftyYp1jVrq
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CgpPbiA3LzI3LzIwMjIgNzo0NCBQTSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24gNy8y
OC8yMDIyIDk6NDEgQU0sIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDcvMjcvMjAyMiA0
OjU0IEFNLCBaaHUsIExpbmdzaGFuIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiA3LzI3LzIwMjIgNjow
OSBQTSwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gNy8yNy8yMDIyIDI6MDEg
QU0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4gT24gV2VkLCBKdWwgMjcsIDIwMjIg
YXQgMTI6NTA6MzNBTSAtMDcwMCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+Cj4+Pj4+PiBPbiA3
LzI2LzIwMjIgMTE6MDEgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+Pj4+PiBPbiBX
ZWQsIEp1bCAyNywgMjAyMiBhdCAwMzo0NzozNUFNICswMDAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6
Cj4+Pj4+Pj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+
Pj4+Pj4+Pj4gU2VudDogVHVlc2RheSwgSnVseSAyNiwgMjAyMiAxMDo1MyBQTQo+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+IE9uIDcvMjcvMjAyMiAxMDoxNyBBTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Pj4+
Pj4+Pj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+
Pj4+Pj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDI2LCAyMDIyIDEwOjE1IFBNCj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+IE9uIDcvMjYvMjAyMiAxMTo1NiBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+
Pj4+Pj4+Pj4+Pj4+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+
Cj4+Pj4+Pj4+Pj4+Pj4gU2VudDogVHVlc2RheSwgSnVseSAxMiwgMjAyMiAxMTo0NiBQTQo+Pj4+
Pj4+Pj4+Pj4+PiBXaGVuIHRoZSB1c2VyIHNwYWNlIHdoaWNoIGludm9rZXMgbmV0bGluayBjb21t
YW5kcywgCj4+Pj4+Pj4+Pj4+Pj4+IGRldGVjdHMgdGhhdAo+Pj4+Pj4+Pj4+PiBfTVEKPj4+Pj4+
Pj4+Pj4+PiBpcyBub3Qgc3VwcG9ydGVkLCBoZW5jZSBpdCB0YWtlcyBtYXhfcXVldWVfcGFpciA9
IDEgYnkgCj4+Pj4+Pj4+Pj4+Pj4gaXRzZWxmLgo+Pj4+Pj4+Pj4+Pj4+IEkgdGhpbmsgdGhlIGtl
cm5lbCBtb2R1bGUgaGF2ZSBhbGwgbmVjZXNzYXJ5IGluZm9ybWF0aW9uIAo+Pj4+Pj4+Pj4+Pj4+
IGFuZCBpdCBpcwo+Pj4+Pj4+Pj4+Pj4+IHRoZSBvbmx5IG9uZSB3aGljaCBoYXZlIHByZWNpc2Ug
aW5mb3JtYXRpb24gb2YgYSBkZXZpY2UsIAo+Pj4+Pj4+Pj4+Pj4+IHNvIGl0Cj4+Pj4+Pj4+Pj4+
Pj4gc2hvdWxkIGFuc3dlciBwcmVjaXNlbHkgdGhhbiBsZXQgdGhlIHVzZXIgc3BhY2UgZ3Vlc3Mu
IFRoZSAKPj4+Pj4+Pj4+Pj4+PiBrZXJuZWwKPj4+Pj4+Pj4+Pj4+PiBtb2R1bGUgc2hvdWxkIGJl
IHJlbGlhYmxlIHRoYW4gc3RheSBzaWxlbnQsIGxlYXZlIHRoZSAKPj4+Pj4+Pj4+Pj4+PiBxdWVz
dGlvbiB0bwo+Pj4+Pj4+Pj4+Pj4+IHRoZSB1c2VyIHNwYWNlCj4+Pj4+Pj4+Pj4+IHRvb2wuCj4+
Pj4+Pj4+Pj4+PiBLZXJuZWwgaXMgcmVsaWFibGUuIEl0IGRvZXNu4oCZdCBleHBvc2UgYSBjb25m
aWcgc3BhY2UgZmllbGQgCj4+Pj4+Pj4+Pj4+PiBpZiB0aGUKPj4+Pj4+Pj4+Pj4+IGZpZWxkIGRv
ZXNu4oCZdAo+Pj4+Pj4+Pj4+PiBleGlzdCByZWdhcmRsZXNzIG9mIGZpZWxkIHNob3VsZCBoYXZl
IGRlZmF1bHQgb3Igbm8gZGVmYXVsdC4KPj4+Pj4+Pj4+Pj4gc28gd2hlbiB5b3Uga25vdyBpdCBp
cyBvbmUgcXVldWUgcGFpciwgeW91IHNob3VsZCBhbnN3ZXIgCj4+Pj4+Pj4+Pj4+IG9uZSwgbm90
IHRyeQo+Pj4+Pj4+Pj4+PiB0byBndWVzcy4KPj4+Pj4+Pj4+Pj4+IFVzZXIgc3BhY2Ugc2hvdWxk
IG5vdCBndWVzcyBlaXRoZXIuIFVzZXIgc3BhY2UgZ2V0cyB0byBzZWUgCj4+Pj4+Pj4+Pj4+PiBp
ZiBfTVEKPj4+Pj4+Pj4+Pj4gcHJlc2VudC9ub3QgcHJlc2VudC4gSWYgX01RIHByZXNlbnQgdGhh
biBnZXQgcmVsaWFibGUgZGF0YSAKPj4+Pj4+Pj4+Pj4gZnJvbSBrZXJuZWwuCj4+Pj4+Pj4+Pj4+
PiBJZiBfTVEgbm90IHByZXNlbnQsIGl0IG1lYW5zIHRoaXMgZGV2aWNlIGhhcyBvbmUgVlEgcGFp
ci4KPj4+Pj4+Pj4+Pj4gaXQgaXMgc3RpbGwgYSBndWVzcywgcmlnaHQ/IEFuZCBhbGwgdXNlciBz
cGFjZSB0b29scyAKPj4+Pj4+Pj4+Pj4gaW1wbGVtZW50ZWQgdGhpcwo+Pj4+Pj4+Pj4+PiBmZWF0
dXJlIG5lZWQgdG8gZ3Vlc3MKPj4+Pj4+Pj4+PiBOby4gaXQgaXMgbm90IGEgZ3Vlc3MuCj4+Pj4+
Pj4+Pj4gSXQgaXMgZXhwbGljaXRseSBjaGVja2luZyB0aGUgX01RIGZlYXR1cmUgYW5kIGRlcml2
aW5nIHRoZSAKPj4+Pj4+Pj4+PiB2YWx1ZS4KPj4+Pj4+Pj4+PiBUaGUgY29kZSB5b3UgcHJvcG9z
ZWQgd2lsbCBiZSBwcmVzZW50IGluIHRoZSB1c2VyIHNwYWNlLgo+Pj4+Pj4+Pj4+IEl0IHdpbGwg
YmUgdW5pZm9ybSBmb3IgX01RIGFuZCAxMCBvdGhlciBmZWF0dXJlcyB0aGF0IGFyZSAKPj4+Pj4+
Pj4+PiBwcmVzZW50IG5vdyBhbmQKPj4+Pj4+Pj4+IGluIHRoZSBmdXR1cmUuCj4+Pj4+Pj4+PiBN
USBhbmQgb3RoZXIgZmVhdHVyZXMgbGlrZSBSU1MgYXJlIGRpZmZlcmVudC4gSWYgdGhlcmUgaXMg
bm8gCj4+Pj4+Pj4+PiBfUlNTX1hYLCB0aGVyZQo+Pj4+Pj4+Pj4gYXJlIG5vIGF0dHJpYnV0ZXMg
bGlrZSBtYXhfcnNzX2tleV9zaXplLCBhbmQgdGhlcmUgaXMgbm90IGEgCj4+Pj4+Pj4+PiBkZWZh
dWx0IHZhbHVlLgo+Pj4+Pj4+Pj4gQnV0IGZvciBNUSwgd2Uga25vdyBpdCBoYXMgdG8gYmUgMSB3
aWh0b3V0IF9NUS4KPj4+Pj4+Pj4gIndlIiA9IHVzZXIgc3BhY2UuCj4+Pj4+Pj4+IFRvIGtlZXAg
dGhlIGNvbnNpc3RlbmN5IGFtb25nIGFsbCB0aGUgY29uZmlnIHNwYWNlIGZpZWxkcy4KPj4+Pj4+
PiBBY3R1YWxseSBJIGxvb2tlZCBhbmQgdGhlIGNvZGUgc29tZSBtb3JlIGFuZCBJJ20gcHV6emxl
ZDoKPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gwqDCoMKgwqBzdHJ1Y3QgdmlydGlvX25ldF9jb25m
aWcgY29uZmlnID0ge307Cj4+Pj4+Pj4gwqDCoMKgwqB1NjQgZmVhdHVyZXM7Cj4+Pj4+Pj4gwqDC
oMKgwqB1MTYgdmFsX3UxNjsKPj4+Pj4+Pgo+Pj4+Pj4+IMKgwqDCoMKgdmRwYV9nZXRfY29uZmln
X3VubG9ja2VkKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25maWcpKTsKPj4+Pj4+Pgo+Pj4+
Pj4+IMKgwqDCoMKgaWYgKG5sYV9wdXQobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFDQURE
UiwgCj4+Pj4+Pj4gc2l6ZW9mKGNvbmZpZy5tYWMpLAo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY29uZmlnLm1hYykpCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0la
RTsKPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gTWFjIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJU
SU9fTkVUX0ZfTUFDCj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IMKgwqDCoMKgdmFsX3UxNiA9IGxl
MTZfdG9fY3B1KGNvbmZpZy5zdGF0dXMpOwo+Pj4+Pj4+IMKgwqDCoMKgaWYgKG5sYV9wdXRfdTE2
KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfU1RBVFVTLCB2YWxfdTE2KSkKPj4+Pj4+PiDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVNU0dTSVpFOwo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBzdGF0dXMg
cmV0dXJuZWQgZXZlbiB3aXRob3V0IFZJUlRJT19ORVRfRl9TVEFUVVMKPj4+Pj4+Pgo+Pj4+Pj4+
IMKgwqDCoMKgdmFsX3UxNiA9IGxlMTZfdG9fY3B1KGNvbmZpZy5tdHUpOwo+Pj4+Pj4+IMKgwqDC
oMKgaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01UVSwgdmFsX3Ux
NikpCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FTVNHU0laRTsKPj4+Pj4+Pgo+Pj4+
Pj4+Cj4+Pj4+Pj4gTVRVIHJldHVybmVkIGV2ZW4gd2l0aG91dCBWSVJUSU9fTkVUX0ZfTVRVCj4+
Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+IFdoYXQncyBnb2luZyBvbiBoZXJlPwo+Pj4+Pj4+Cj4+Pj4+
Pj4KPj4+Pj4+IEkgZ3Vlc3MgdGhpcyBpcyBzcGVjIHRoaW5nIChoaXN0b3JpY2FsIGRlYnQpLCBJ
IHZhZ3VlbHkgcmVjYWxsIAo+Pj4+Pj4gdGhlc2UgZmllbGRzCj4+Pj4+PiBhcmUgYWx3YXlzIHBy
ZXNlbnQgaW4gY29uZmlnIHNwYWNlIHJlZ2FyZGxlc3MgdGhlIGV4aXN0ZW5jZSBvZiAKPj4+Pj4+
IGNvcnJlc3BvbmRpbmcKPj4+Pj4+IGZlYXR1cmUgYml0Lgo+Pj4+Pj4KPj4+Pj4+IC1TaXdlaQo+
Pj4+PiBOb3BlOgo+Pj4+Pgo+Pj4+PiAyLjUuMcKgIERyaXZlciBSZXF1aXJlbWVudHM6IERldmlj
ZSBDb25maWd1cmF0aW9uIFNwYWNlCj4+Pj4+Cj4+Pj4+IC4uLgo+Pj4+Pgo+Pj4+PiBGb3Igb3B0
aW9uYWwgY29uZmlndXJhdGlvbiBzcGFjZSBmaWVsZHMsIHRoZSBkcml2ZXIgTVVTVCBjaGVjayAK
Pj4+Pj4gdGhhdCB0aGUgY29ycmVzcG9uZGluZyBmZWF0dXJlIGlzIG9mZmVyZWQKPj4+Pj4gYmVm
b3JlIGFjY2Vzc2luZyB0aGF0IHBhcnQgb2YgdGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UuCj4+Pj4g
V2VsbCwgdGhpcyBpcyBkcml2ZXIgc2lkZSBvZiByZXF1aXJlbWVudC4gQXMgdGhpcyBpbnRlcmZh
Y2UgaXMgZm9yIAo+Pj4+IGhvc3QgYWRtaW4gdG9vbCB0byBxdWVyeSBvciBjb25maWd1cmUgdmRw
YSBkZXZpY2UsIHdlIGRvbid0IGhhdmUgdG8gCj4+Pj4gd2FpdCB1bnRpbCBmZWF0dXJlIG5lZ290
aWF0aW9uIGlzIGRvbmUgb24gZ3Vlc3QgZHJpdmVyIHRvIGV4dHJhY3QgCj4+Pj4gdmRwYSBhdHRy
aWJ1dGVzL3BhcmFtZXRlcnMsIHNheSBpZiB3ZSB3YW50IHRvIHJlcGxpY2F0ZSBhbm90aGVyIAo+
Pj4+IHZkcGEgZGV2aWNlIHdpdGggdGhlIHNhbWUgY29uZmlnIG9uIG1pZ3JhdGlvbiBkZXN0aW5h
dGlvbi4gSSB0aGluayAKPj4+PiB3aGF0IG1heSBuZWVkIHRvIGJlIGZpeCBpcyB0byBtb3ZlIG9m
ZiBmcm9tIHVzaW5nIAo+Pj4+IC52ZHBhX2dldF9jb25maWdfdW5sb2NrZWQoKSB3aGljaCBkZXBl
bmRzIG9uIGZlYXR1cmUgbmVnb3RpYXRpb24uIAo+Pj4+IEFuZC9vciBleHBvc2UgY29uZmlnIHNw
YWNlIHJlZ2lzdGVyIHZhbHVlcyB0aHJvdWdoIGFub3RoZXIgc2V0IG9mIAo+Pj4+IGF0dHJpYnV0
ZXMuCj4+PiBZZXMsIHdlIGRvbid0IGhhdmUgdG8gd2FpdCBmb3IgRkVBVFVSRVNfT0suIEluIGFu
b3RoZXIgcGF0Y2ggaW4gdGhpcyAKPj4+IHNlcmllcywgSSBoYXZlIGFkZGVkIGEgbmV3IG5ldGxp
bmsgYXR0ciB0byByZXBvcnQgdGhlIGRldmljZSAKPj4+IGZlYXR1cmVzLCBhbmQgcmVtb3ZlZCB0
aGUgYmxvY2tlci4gU28gdGhlIExNIG9yY2hlc3RyYXRpb24gU1cgY2FuIAo+Pj4gcXVlcnkgdGhl
IGRldmljZSBmZWF0dXJlcyBvZiB0aGUgZGV2aWNlcyBhdCB0aGUgZGVzdGluYXRpb24gY2x1c3Rl
ciwgCj4+PiBhbmQgcGljayBhIHByb3BlciBvbmUsIGV2ZW4gbWFzayBvdXQgc29tZSBmZWF0dXJl
cyB0byBtZWV0IHRoZSBMTSAKPj4+IHJlcXVpcmVtZW50cy4KPj4gRm9yIHRoYXQgZW5kLCB5b3Un
ZCBuZWVkIHRvIG1vdmUgb2ZmIGZyb20gdXNpbmcgCj4+IHZkcGFfZ2V0X2NvbmZpZ191bmxvY2tl
ZCgpIHdoaWNoIGRlcGVuZHMgb24gZmVhdHVyZSBuZWdvdGlhdGlvbi4gCj4+IFNpbmNlIHRoaXMg
d291bGQgc2xpZ2h0bHkgY2hhbmdlIHRoZSBvcmlnaW5hbCBzZW1hbnRpY3Mgb2YgZWFjaCBmaWVs
ZCAKPj4gdGhhdCAidmRwYSBkZXYgY29uZmlnIiBzaG93cywgaXQgcHJvYmFibHkgbmVlZCBhbm90
aGVyIG5ldGxpbmsgCj4+IGNvbW1hbmQgYW5kIG5ldyB1QVBJLgo+IHdoeSBub3Qgc2hvdyBib3Ro
IGRldmljZV9mZWF0dXJlcyBhbmQgZHJpdmVyX2ZlYXR1cmVzIGluICJ2ZHBhIGRldiAKPiBjb25m
aWcgc2hvdyI/Cj4KQXMgSSByZXF1ZXN0ZWQgaW4gdGhlIG90aGVyIGVtYWlsLCBJJ2QgbGlrZSB0
byBzZWUgdGhlIHByb3Bvc2VkICd2ZHBhIApkZXYgY29uZmlnIC4uLicgZXhhbXBsZSBvdXRwdXQg
Zm9yIHZhcmlvdXMgcGhhc2VzIGluIGZlYXR1cmUgCm5lZ290aWF0aW9uLCBhbmQgdGhlIHNwZWNp
ZmljIHVzZSBjYXNlIChtb3RpdmF0aW9uKSBmb3IgdGhpcyBwcm9wb3NlZCAKb3V0cHV0LiBJIGFt
IGhhdmluZyBkaWZmaWN1bHR5IHRvIG1hdGNoIHdoYXQgeW91IHdhbnQgdG8gZG8gd2l0aCB0aGUg
CnBhdGNoIHBvc3RlZC4KCi1TaXdlaQoKPj4KPj4gLVNpd2VpCj4+Cj4+Cj4+Pgo+Pj4gVGhhbmtz
LAo+Pj4gWmh1IExpbmdzaGFuCj4+Pj4gLVNpd2VpCj4+Pj4KPj4+Pgo+Pj4+Cj4+Pj4KPj4+Cj4+
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
