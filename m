Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FC0C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 07:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6388D40095;
	Thu, 28 Jul 2022 07:23:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6388D40095
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=OvP+xePI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Oi8xt7tI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LJGfwKsbJxcD; Thu, 28 Jul 2022 07:23:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0052D419B7;
	Thu, 28 Jul 2022 07:23:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0052D419B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C711AC0033;
	Thu, 28 Jul 2022 07:23:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89501C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56831832D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:23:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56831832D1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=OvP+xePI; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=Oi8xt7tI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MKqtfMVOfjJv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:23:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F289483299
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F289483299
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:22:59 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26S5vu6n009662;
 Thu, 28 Jul 2022 07:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=21XNGYZkSraMmOQEGzNsFoMfhtKisyM+GvCZkxkA278=;
 b=OvP+xePIXmjs9Y8gywGeJG/YD0BLwe4jeHFX74HzL8TGG3fxYAdfnWyCGCA2Sv7QvZAB
 /IsStri+TJ+7sPk7rU6qpV1Q4ei3YJGprWh74n4Nq7IxE5pJMEnN5gqV4F3dXzpbcZem
 dqnwhkLn55NQPCO/FfpOAh/tQNf/avUy9uDwMQf8emqKeMnSrb8JiTPoa3vGRsoINqcA
 q/NZKvj5O/+9DCCjefN1WRno13RC8rDTsoVczrOyFN+zPdw5BuwOgXE0tOzF48Hzdmwu
 cEv7B80nuq64dtQUSd7Mr77FRRcc4SGe6CV3gJGB8I8Ox3UG4UqDGUOP9R11RLC9KbqD Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a4uv8p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 07:22:47 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26S4JfHb034538; Thu, 28 Jul 2022 07:22:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh6358rx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 07:22:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUmLRMJwjPIbvnwOesvN8u9LY/wlPFFcSITMgSfiH7mJAWp7I87X34chUkDWNh8/ige07UYzjDcJRAhECbrGwTNv7Wqyx90l0Ua1/VhONAcKiW9VmKyUohU7o4OJFEItD3opY9PQA9c/v33bmDc7cyho79NWJOH7h63dOANethMNOytfXrGaMXj/y4psqgRwCqC51dxnJh8UD4Vvae/N2eTE4tdGbwWj4RwEzKpF5bMmPn8UD8YOefmf75v+wKYJLEXcPPmNWXGJBSbSXoECt5FLFTS9DDpk55S6pGa5ar/9pcRZ56YEjzOhQPPIc9bACvce74CLEvgWBCJoCcSpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21XNGYZkSraMmOQEGzNsFoMfhtKisyM+GvCZkxkA278=;
 b=BOy+rgYnZ+zbLVkoBXukKtdFlyZ2rdvJDwHFJ+k96BA8w4Xe7NJA/knn+cYuJG6wqxe4ZGLvE7nxjlisGygvm6qiT4J8q/xYPFEFqcpv6+ZRR7VfCZL0e9WfU/njIYpbOQTRI4056aTHAo10JS/bR4ge6BXgNlScyxViH4bkJtoR8Y4cxxXr8Jwt0MZeilXH/KbB32o8i3uHJplF8OSrbbY2FDcurXMwwrYmHGfeBSELSPZhXgWkVYfSefZC7yDpr/oEP8WRtn7qz5k2MPgq2wQOxSHzdz1TUbY23UMExONtA9XSvO6GenSupAkWb7yBku4CNskb0SneXcWTIIjTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21XNGYZkSraMmOQEGzNsFoMfhtKisyM+GvCZkxkA278=;
 b=Oi8xt7tIv/+DE5qfwrTxEbNBGljZfYGY9mlYnpXz+lFbFj1HKxXDHUUtAmalB1ZU8PIosyy9zdULp/arPZQU8+el5e6r9pwbj5fOxmIWEDmrpOxN2TpfsfC+g+Op/rFhlc81m9Nl6r4aDMIYiLlaJpEMx1oc4KTFhzNIj2FfXQc=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by CY4PR10MB1462.namprd10.prod.outlook.com (2603:10b6:903:28::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 07:22:44 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.026; Thu, 28 Jul 2022
 07:22:44 +0000
Message-ID: <535306b8-b33e-b65e-af50-5b1c562aec63@oracle.com>
Date: Thu, 28 Jul 2022 00:22:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1246d2f1-2822-0edb-cd57-efc4015f05a2@intel.com>
 <PH0PR12MB54815985C202E81122459DFFDC949@PH0PR12MB5481.namprd12.prod.outlook.com>
 <19681358-fc81-be5b-c20b-7394a549f0be@intel.com>
 <PH0PR12MB54818158D4F7F9F556022857DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e98fc062-021b-848b-5cf4-15bd63a11c5c@intel.com>
 <PH0PR12MB54815AD7D0674FEB1D63EB61DC979@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220727015626-mutt-send-email-mst@kernel.org>
 <66291287-fcb3-be8d-2c1b-dd44533ed8b3@oracle.com>
 <20220727050102-mutt-send-email-mst@kernel.org>
 <6d5b03ee-5362-8534-5881-a34c9ea626f0@oracle.com>
 <20220727114602-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20220727114602-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: SA9PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:806:22::12) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dd03e47-9e7b-4c17-6053-08da7069f6ca
X-MS-TrafficTypeDiagnostic: CY4PR10MB1462:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fbTIAHB4nSxKbTaO4w3hYABLl7y3oYw9uZIag+DMYXHKHFhBLqUFvpLbDsPbue4A38WwZHO4xlAJW3vfEsw85lYUZWaXP3MkEa12PiBmSb9B3WJ44ijgsbDl06Oehyv27Bld3tCYXFZUamXGVo2Yb4l/FbocCrSwDFk+GKag87EUreoGD3vu2gzYnDmOeWUnh3pjQblSq93IfV2Uz0P95P9/7ZBYEg9utsmVgY49ekKFY1SvvR8ed7yJZx5MSlUz3h6JPOPpme0jdRCDccm4qTeiAR0Lu2vV7PE9gpQmNlUWT80T2UAj/IbgPBZAMHSBkUuPeDp1na9r0yQJic3Glv4NAUoK04qMVPagd1ZgK2+48qzjw1p/IH1h545FiGJqhOTzFSLfaQ5yHW2qKjAjDyy+1/sF79V+aCPMLF+ht1Rh3IQpftnemwriz2pcMyh6omurPjhcl/EOQyjmejRAVD4iX93lhOtR2utFWK1AQIUy68jKfNReQ24+BMDLDTf63fbNN7fivr9/l5YYvYddjRmdkYTg8IAZ4r2VodaWmCmGx8jG3g6wG2FGs/5ajUD+5GTbZMWHFTR2wy/keemYn7uzJXSlHeTshTvUvySwH8lVyW1ZdAhMBcOQ0s2nG4OHpIy0SnPnUqwBfjd3/0dyeOnZ8aikZ0HcW4oTiABVMFN8Rcw29p9RylTvFbj5hw8J79oKJvb3ktRzXv5EyADvsuNgjV1rrH/JG0ZOnfA2z8NoOKX9McUbOIzmUuGQBZADCx9YEoVx1tZt00C9siG4GIba7bz9FjnTsfoL9X6sKwQYZzPmEjTEadFgM3Ra2q6VdVa1+4vo+TxAhJPxadaniA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(366004)(346002)(39860400002)(136003)(376002)(2616005)(316002)(86362001)(38100700002)(8936002)(6486002)(31686004)(41300700001)(36756003)(2906002)(478600001)(31696002)(5660300002)(83380400001)(6916009)(33964004)(26005)(6512007)(54906003)(6666004)(4326008)(66946007)(66476007)(186003)(53546011)(36916002)(8676002)(66556008)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1EMEREV2h5ZjVucGdGOTFPU0tvVWJZZGdCejIzYm9YY0xQaXdPMjFtVW1m?=
 =?utf-8?B?dkNjRVBuK2xpNytDc3M2eTRwUWQxUnV4dlRvaHNIa2JwR1F5NmJWVEZyWVA5?=
 =?utf-8?B?Q3BsdGtDaGtuT254SkRzUHg1Sk4zSUNMYWUra0ZTbk1LRTJ4YXM0Skd3SSs3?=
 =?utf-8?B?QjhOVGE4S0NmUVYzWldhNWxybEFDSmxKTjJFbGJJRDZCc0oyRy94djNlalBi?=
 =?utf-8?B?S1Y1WURCd1VJdnhUczRlNjkzRjErbEtTeWpLSmVEcWFGNjZSdURjSFBKMXMv?=
 =?utf-8?B?b3ozemJqZ0ZxWDErOUFweEwyZnlya1hicDVramFZRUY5NXFybmw1WjMrbDJB?=
 =?utf-8?B?U0tlZU5CSUJvUnMwNS9NR04vTVdyUmZxbFlXS0ZWSmtGNVh6dU5zcGxyQTJT?=
 =?utf-8?B?aGxHUHc2YW1ocWFDQ2hsSENIbVkrN2ZzMEVWTExMR1Erdmx2R1dhZWZkNVFt?=
 =?utf-8?B?ZXVZZU5ZY3JrcjVmbGUycDM2aFA3RmpWYWcxUGd1M2lCdGpkSkg3TWxPQlp3?=
 =?utf-8?B?S0hpTE85K0FXUXQ1RDNCcXd5U2l6M3prUVBOcjVaYzlGVldjUGN1bGEwRU1v?=
 =?utf-8?B?cSt1bmY3NUNZM2svRkRobkd1T2JlWHhTQndzekw3emxuYmFFeW91a2NSWGdt?=
 =?utf-8?B?cjNZVU9iRVQxUlNtMFp6T29FdWowVXgrV3F2WHpwQ1VQNG1jK1NwNGo3UjJG?=
 =?utf-8?B?ckxQU0tvOExUZnlXSGU5YXVIRXZLMkpBOWhITFduU0dWYkg0V2liOGZDeEhI?=
 =?utf-8?B?RTRCSDZ1V3Vxd2RtNnNsQmVWcVdhWStLNWhDYzFiUE4xQlV1RmgxZG4rOVlN?=
 =?utf-8?B?dXk5NW9GQ1JuT1pjUXIvQ05Bcm9Pb0ZrSHM5enN6Vi9NcjJWK1JwZGJQLzVZ?=
 =?utf-8?B?bnhIa0taMFpHZTlEKzVPdmEwb2c5YVVFSEFEUDF3SFRlVVkwbzh4K2dLa3BW?=
 =?utf-8?B?YmlNL3NNWnNMUTd5MVA3ZGMvVlF2eGJJaysyc0d3R2Q0Ym1hajVHSmVzUGoy?=
 =?utf-8?B?djU3c2MyTTdIRXNaU2ZtZW91UTRQTEpvdmVEQzk2aTI0THViTmlZOXlzeXNF?=
 =?utf-8?B?NGRFREVSMEpidWFuRWNGYVZaTWZER0dRYmh1Zk9OajV1ZVBlR3RGUVpKT1NW?=
 =?utf-8?B?Qm9jdDQ1QnZYSno0THQ0aUtQNDc5T3BKYXhDRHp2K1dhUVVtMi81Z1NhbGJN?=
 =?utf-8?B?QmRSU3hmU1c2VmNkcnF4bUJRS2piSHArSXZwU3hja0FtcVIzRStiK24yMDFh?=
 =?utf-8?B?cHpjR0xHVlJGNHk3U2VLdnpoNWlRTkoxRlk1WjNhNFJoWnEvOGdSaVFiazU2?=
 =?utf-8?B?N3ZYdXB3YWF5UTFxSWhseUludWpSUG10S202S1ZCdUhhNDQzbFRNdno5ZGZG?=
 =?utf-8?B?R2kvdzloc1NyWjRVK0hZQ0ZCMkhxYWtRM2FLZ0tWVnJUbks2bVE5emZhWGxI?=
 =?utf-8?B?QkRjK0JyTW5Lamd1amFXbjkra2J5Y1ZxMDF2MTRhanJleGpxUkZBWEMxMVli?=
 =?utf-8?B?QXFDdEYwNFBYbzA3QnVwS0JRd3ZaUHlmd2prOTBaTlJWUVkvRkpZWXdneGly?=
 =?utf-8?B?OEZFRUx6RjJwYXJjU2dqRW0zWW5OdFFpQXRWSnEreHl4RkZPRzVzdE80Q3hk?=
 =?utf-8?B?SWlVRlBUcnN5VERWRnJFSERPQ1lvK1pCVTdqZDhzYXhlYW9oY0VONDBkZFNP?=
 =?utf-8?B?TkJveG5hUE9tS05rTDMwSVJOVzFpSmVNK3JsL0lRQ3I5N2gwN0EvVy8ybFkv?=
 =?utf-8?B?M3B4ZmM5aVpqUlZpb2xUVmhYcGt0elRFN1cwanJHajN1SmphamxoMVBqZEI2?=
 =?utf-8?B?S08rWW0zNXZMUXAydTIwYkFVeGN1ZUsrK281NVpzOU9MVnJDV0JpNG9DeTA0?=
 =?utf-8?B?ZkdvSTZkUGdSc2ZlTmhOWHA5K3lJRUk1eU5FSVRTV1BkR2RFeVM5VWdXbnFB?=
 =?utf-8?B?WHJLRzhDQ0hrQXhGcXVWNTZMRDl6eGtvcWZmRTgvWVVZWVZPcEt5d0h0SitC?=
 =?utf-8?B?Zld4M2ZsMFRXTnNJenhVL0VndlZTM1lhYUVRbmx2eW1hYk5UZUhWZnF0bjhn?=
 =?utf-8?B?WGdCcG1BTFl3L0dSTStXRDFWeUticDJsZHJIcmdTRTNoQ3lZU0tCOU81Z0Mx?=
 =?utf-8?B?S0QrL1JhQVE3UlVtYVJMYno3SWZTc2RCNFUzVVUybmEyMTVHU29qNjUyeXB2?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd03e47-9e7b-4c17-6053-08da7069f6ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 07:22:44.2400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9JOd3++QT+NQ92N40G7hHKEARTb4iL3JoS1Hbl3zGuRwtd7YJIlNC2VF8SprsLcyOiLI0YGZzWzPKlirzt0KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_01,2022-07-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280029
X-Proofpoint-ORIG-GUID: J37dbAgAfnUYJ4XZocx6DJlmcGPEu1xi
X-Proofpoint-GUID: J37dbAgAfnUYJ4XZocx6DJlmcGPEu1xi
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============8147000425820472179=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============8147000425820472179==
Content-Type: multipart/alternative;
 boundary="------------VKm9Wwb7oxdrUsJ69c6ObYFi"
Content-Language: en-US

--------------VKm9Wwb7oxdrUsJ69c6ObYFi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/27/2022 8:48 AM, Michael S. Tsirkin wrote:
> On Wed, Jul 27, 2022 at 03:09:43AM -0700, Si-Wei Liu wrote:
>>
>> On 7/27/2022 2:01 AM, Michael S. Tsirkin wrote:
>>> On Wed, Jul 27, 2022 at 12:50:33AM -0700, Si-Wei Liu wrote:
>>>> On 7/26/2022 11:01 PM, Michael S. Tsirkin wrote:
>>>>> On Wed, Jul 27, 2022 at 03:47:35AM +0000, Parav Pandit wrote:
>>>>>>> From: Zhu, Lingshan<lingshan.zhu@intel.com>
>>>>>>> Sent: Tuesday, July 26, 2022 10:53 PM
>>>>>>>
>>>>>>> On 7/27/2022 10:17 AM, Parav Pandit wrote:
>>>>>>>>> From: Zhu, Lingshan<lingshan.zhu@intel.com>
>>>>>>>>> Sent: Tuesday, July 26, 2022 10:15 PM
>>>>>>>>>
>>>>>>>>> On 7/26/2022 11:56 PM, Parav Pandit wrote:
>>>>>>>>>>> From: Zhu, Lingshan<lingshan.zhu@intel.com>
>>>>>>>>>>> Sent: Tuesday, July 12, 2022 11:46 PM
>>>>>>>>>>>> When the user space which invokes netlink commands, detects that
>>>>>>>>> _MQ
>>>>>>>>>>> is not supported, hence it takes max_queue_pair = 1 by itself.
>>>>>>>>>>> I think the kernel module have all necessary information and it is
>>>>>>>>>>> the only one which have precise information of a device, so it
>>>>>>>>>>> should answer precisely than let the user space guess. The kernel
>>>>>>>>>>> module should be reliable than stay silent, leave the question to
>>>>>>>>>>> the user space
>>>>>>>>> tool.
>>>>>>>>>> Kernel is reliable. It doesn’t expose a config space field if the
>>>>>>>>>> field doesn’t
>>>>>>>>> exist regardless of field should have default or no default.
>>>>>>>>> so when you know it is one queue pair, you should answer one, not try
>>>>>>>>> to guess.
>>>>>>>>>> User space should not guess either. User space gets to see if _MQ
>>>>>>>>> present/not present. If _MQ present than get reliable data from kernel.
>>>>>>>>>> If _MQ not present, it means this device has one VQ pair.
>>>>>>>>> it is still a guess, right? And all user space tools implemented this
>>>>>>>>> feature need to guess
>>>>>>>> No. it is not a guess.
>>>>>>>> It is explicitly checking the _MQ feature and deriving the value.
>>>>>>>> The code you proposed will be present in the user space.
>>>>>>>> It will be uniform for _MQ and 10 other features that are present now and
>>>>>>> in the future.
>>>>>>> MQ and other features like RSS are different. If there is no _RSS_XX, there
>>>>>>> are no attributes like max_rss_key_size, and there is not a default value.
>>>>>>> But for MQ, we know it has to be 1 wihtout _MQ.
>>>>>> "we" = user space.
>>>>>> To keep the consistency among all the config space fields.
>>>>> Actually I looked and the code some more and I'm puzzled:
>>>>>
>>>>>
>>>>> 	struct virtio_net_config config = {};
>>>>> 	u64 features;
>>>>> 	u16 val_u16;
>>>>>
>>>>> 	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
>>>>>
>>>>> 	if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR, sizeof(config.mac),
>>>>> 		    config.mac))
>>>>> 		return -EMSGSIZE;
>>>>>
>>>>>
>>>>> Mac returned even without VIRTIO_NET_F_MAC
>>>>>
>>>>>
>>>>> 	val_u16 = le16_to_cpu(config.status);
>>>>> 	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
>>>>> 		return -EMSGSIZE;
>>>>>
>>>>>
>>>>> status returned even without VIRTIO_NET_F_STATUS
>>>>>
>>>>> 	val_u16 = le16_to_cpu(config.mtu);
>>>>> 	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>>>>> 		return -EMSGSIZE;
>>>>>
>>>>>
>>>>> MTU returned even without VIRTIO_NET_F_MTU
>>>>>
>>>>>
>>>>> What's going on here?
>>>>>
>>>>>
>>>> I guess this is spec thing (historical debt), I vaguely recall these fields
>>>> are always present in config space regardless the existence of corresponding
>>>> feature bit.
>>>>
>>>> -Siwei
>>> Nope:
>>>
>>> 2.5.1  Driver Requirements: Device Configuration Space
>>>
>>> ...
>>>
>>> For optional configuration space fields, the driver MUST check that the corresponding feature is offered
>>> before accessing that part of the configuration space.
>> Well, this is driver side of requirement.
>
> Well driver and device are the only two entities in the spec.
We should mostly concern with device side requirement as this is what 
the vdpa admin tool is targeted for. Please refer to my earlier 
email//addressed to Jason.

>
>> As this interface is for host
>> admin tool to query or configure vdpa device, we don't have to wait until
>> feature negotiation is done on guest driver to extract vdpa
>> attributes/parameters, say if we want to replicate another vdpa device with
>> the same config on migration destination. I think what may need to be fix is
>> to move off from using .vdpa_get_config_unlocked() which depends on feature
>> negotiation. And/or expose config space register values through another set
>> of attributes.
>>
>> -Siwei
>>
>>
> Sounds like something that might use the proposed admin queue maybe.
> Hope that makes progress ...
Well it doesn't need to be that complex. Depending on need we may 
extract device configs pre-negotiation from vendor's vdpa device via 
some other op, but I doubt worth doing so. I don't quite understand the 
use case why we need to expose those values.

-Siwei


--------------VKm9Wwb7oxdrUsJ69c6ObYFi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 7/27/2022 8:48 AM, Michael S.
      Tsirkin wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220727114602-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">On Wed, Jul 27, 2022 at 03:09:43AM -0700, Si-Wei Liu wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 7/27/2022 2:01 AM, Michael S. Tsirkin wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Wed, Jul 27, 2022 at 12:50:33AM -0700, Si-Wei Liu wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
On 7/26/2022 11:01 PM, Michael S. Tsirkin wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">On Wed, Jul 27, 2022 at 03:47:35AM +0000, Parav Pandit wrote:
</pre>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
Sent: Tuesday, July 26, 2022 10:53 PM

On 7/27/2022 10:17 AM, Parav Pandit wrote:
</pre>
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <pre class="moz-quote-pre" wrap="">From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
Sent: Tuesday, July 26, 2022 10:15 PM

On 7/26/2022 11:56 PM, Parav Pandit wrote:
</pre>
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre class="moz-quote-pre" wrap="">From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
Sent: Tuesday, July 12, 2022 11:46 PM
</pre>
                          <blockquote type="cite">
                            <pre class="moz-quote-pre" wrap="">When the user space which invokes netlink commands, detects that
</pre>
                          </blockquote>
                        </blockquote>
                      </blockquote>
                      <pre class="moz-quote-pre" wrap="">_MQ
</pre>
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <pre class="moz-quote-pre" wrap="">is not supported, hence it takes max_queue_pair = 1 by itself.
I think the kernel module have all necessary information and it is
the only one which have precise information of a device, so it
should answer precisely than let the user space guess. The kernel
module should be reliable than stay silent, leave the question to
the user space
</pre>
                        </blockquote>
                      </blockquote>
                      <pre class="moz-quote-pre" wrap="">tool.
</pre>
                      <blockquote type="cite">
                        <pre class="moz-quote-pre" wrap="">Kernel is reliable. It doesn’t expose a config space field if the
field doesn’t
</pre>
                      </blockquote>
                      <pre class="moz-quote-pre" wrap="">exist regardless of field should have default or no default.
so when you know it is one queue pair, you should answer one, not try
to guess.
</pre>
                      <blockquote type="cite">
                        <pre class="moz-quote-pre" wrap="">User space should not guess either. User space gets to see if _MQ
</pre>
                      </blockquote>
                      <pre class="moz-quote-pre" wrap="">present/not present. If _MQ present than get reliable data from kernel.
</pre>
                      <blockquote type="cite">
                        <pre class="moz-quote-pre" wrap="">If _MQ not present, it means this device has one VQ pair.
</pre>
                      </blockquote>
                      <pre class="moz-quote-pre" wrap="">it is still a guess, right? And all user space tools implemented this
feature need to guess
</pre>
                    </blockquote>
                    <pre class="moz-quote-pre" wrap="">No. it is not a guess.
It is explicitly checking the _MQ feature and deriving the value.
The code you proposed will be present in the user space.
It will be uniform for _MQ and 10 other features that are present now and
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">in the future.
MQ and other features like RSS are different. If there is no _RSS_XX, there
are no attributes like max_rss_key_size, and there is not a default value.
But for MQ, we know it has to be 1 wihtout _MQ.
</pre>
                </blockquote>
                <pre class="moz-quote-pre" wrap="">&quot;we&quot; = user space.
To keep the consistency among all the config space fields.
</pre>
              </blockquote>
              <pre class="moz-quote-pre" wrap="">Actually I looked and the code some more and I'm puzzled:


	struct virtio_net_config config = {};
	u64 features;
	u16 val_u16;

	vdpa_get_config_unlocked(vdev, 0, &amp;config, sizeof(config));

	if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR, sizeof(config.mac),
		    config.mac))
		return -EMSGSIZE;


Mac returned even without VIRTIO_NET_F_MAC


	val_u16 = le16_to_cpu(config.status);
	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
		return -EMSGSIZE;


status returned even without VIRTIO_NET_F_STATUS

	val_u16 = le16_to_cpu(config.mtu);
	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
		return -EMSGSIZE;


MTU returned even without VIRTIO_NET_F_MTU


What's going on here?


</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">I guess this is spec thing (historical debt), I vaguely recall these fields
are always present in config space regardless the existence of corresponding
feature bit.

-Siwei
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Nope:

2.5.1  Driver Requirements: Device Configuration Space

...

For optional configuration space fields, the driver MUST check that the corresponding feature is offered
before accessing that part of the configuration space.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Well, this is driver side of requirement.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

Well driver and device are the only two entities in the spec.</pre>
    </blockquote>
    We should mostly concern with device side requirement as this is
    what the vdpa admin tool is targeted for. Please refer to my earlier
    email<i> </i>addressed to Jason.<br>
    <br>
    <blockquote type="cite" cite="mid:20220727114602-mutt-send-email-mst@kernel.org">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">As this interface is for host
admin tool to query or configure vdpa device, we don't have to wait until
feature negotiation is done on guest driver to extract vdpa
attributes/parameters, say if we want to replicate another vdpa device with
the same config on migration destination. I think what may need to be fix is
to move off from using .vdpa_get_config_unlocked() which depends on feature
negotiation. And/or expose config space register values through another set
of attributes.

-Siwei


</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Sounds like something that might use the proposed admin queue maybe.
Hope that makes progress ...
</pre>
    </blockquote>
    Well it doesn't need to be that complex. Depending on need we may
    extract device configs pre-negotiation from vendor's vdpa device via
    some other op, but I doubt worth doing so. I don't quite understand
    the use case why we need to expose those values.<br>
    <br>
    -Siwei<br>
    <br>
    <br>
  </body>
</html>

--------------VKm9Wwb7oxdrUsJ69c6ObYFi--

--===============8147000425820472179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8147000425820472179==--
