Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763FAC04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 07:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAF81828BA;
	Thu, 28 Jul 2022 07:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAF81828BA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=gYkJbRfa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=lo8q9nyK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mcbm_jnNQvlm; Thu, 28 Jul 2022 07:09:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1CCC382883;
	Thu, 28 Jul 2022 07:09:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CCC382883
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9BC0C0035;
	Thu, 28 Jul 2022 07:09:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A56FDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 78F2F82884
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:09:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78F2F82884
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SAhwzCq4VPOG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:09:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44AAB82883
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44AAB82883
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 07:09:28 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26S64Fmn020314;
 Thu, 28 Jul 2022 07:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xR5gwm8RNMPuzwLkDQv6OnU1Xe8BcB34mQuo57yr89A=;
 b=gYkJbRfaU1gNquNzfInaRM62nN3mm2A35N4L426hXlGtpFk8XmeddCNljd+rl08qkSnw
 jJjA5F44H285+S6FnJTnyRrizufnKsCeVUPG7UBW97wQ0sBoFUcbRJ9geUlWnxwg4m6y
 ID1UuYjNW+T5nCYajAetXVjVJfcCLgp27jcT8/+D97aj45Dasi8fpBdS0z/GXin7cTCP
 cF6FfAr6O6WqnLcXQWNbwtwXN6DRCRwBLMtzHf4rQBNePUFPshvISwaI6aN/CzCd46kY
 xBioMXaxdUPBW9+hgV2N18Vu6UjTYONRBLj7uUJGcVTGIZzapVcSVcDzmLKC188JNC0q Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsv4nn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 07:09:10 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26S6xf5x035300; Thu, 28 Jul 2022 07:09:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh6358fh9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Jul 2022 07:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7YNo2RpfivHc6LcCASSlUDmnqvaJofU2AraP02BITSzBUMJyk+X86g/4DM7Q5Za1ka4v0s3sqPqf1/hi1Oz4e6kVj9wCQ/rz841PjKbWsTZ7mwUr09zo+FQWtxhe4vE8QT/I02yUtvlPNuhRoyj1Rzu1ux+yH4X3g3w01trLUmL7Pd9ftlagOx/ZNc5HkTeTpDI8NgyLzUFC1cawRdF5A6hsU9SYFt1oRsVFHuSDnXxepOjNSlbsDuJmuyQeQrMTdNdpvPG+o/fAzN5FEQDSQSMw79SrN+Ntz5OgvypWrcQokMqKcrtKTCt/EvD/acE+qkfPipCJFQYfY2bQfwUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR5gwm8RNMPuzwLkDQv6OnU1Xe8BcB34mQuo57yr89A=;
 b=OOYSZgrKgAoSnKr41Ml2mNN1xrmC5xWeL/5BrWRxnP9QJnJeHCcMUt8QFKaQ0JoznEHmZwfp/tFuPM/1NLMVWnMeWkDlqA7v6HeNyB1JHSDp4ZSK/e+glCA9KluuW26b3plxqxlM9YYFdbyTlTePs2GqwHanCqsPXgPozSPZQqDc0g2WaVMVEML4WM4fEFOgIWKli+fnJ3KQ7cmCSE8FgVG2BhSBU6/P9sxw0kf/xJadHWCbFiX/MijZ1mbRmzwSxDi9oOcyE577dFWN1eyNvLVpAsKpAy84OEdI88SsyPBHh0uFuNMnJK01oEL1FQ+T61RcxzyKDZGiQxKCPlAexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR5gwm8RNMPuzwLkDQv6OnU1Xe8BcB34mQuo57yr89A=;
 b=lo8q9nyK7bS31CKdsZ+OF3M70UtWoC3cPrEP3fi7L6L6PQ+EfC2kCEVZXVX9xlXNBJZHbSonX+/DzHWNDANWuX7uLBHJE/GDRDVHX7xCvgjUbH0lFIiooZ67flxPBvTnjzlFheYUrVWEXrcjwgDfmHBnz0xhednvVSsEhQOZSd4=
Received: from BYAPR10MB3287.namprd10.prod.outlook.com (2603:10b6:a03:15c::11)
 by CY4PR10MB1672.namprd10.prod.outlook.com (2603:10b6:910:9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 07:08:58 +0000
Received: from BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803]) by BYAPR10MB3287.namprd10.prod.outlook.com
 ([fe80::c846:d8e4:8631:9803%4]) with mapi id 15.20.5458.026; Thu, 28 Jul 2022
 07:08:58 +0000
Message-ID: <f3fd203d-a3ad-4c36-ddbc-01f061f4f99e@oracle.com>
Date: Thu, 28 Jul 2022 00:08:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3 4/6] vDPA: !FEATURES_OK should not block querying
 device config space
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 Eli Cohen <elic@nvidia.com>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-5-lingshan.zhu@intel.com>
 <PH0PR12MB548190DE76CC64E56DA2DF13DCBD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <00889067-50ac-d2cd-675f-748f171e5c83@oracle.com>
 <63242254-ba84-6810-dad8-34f900b97f2f@intel.com>
 <8002554a-a77c-7b25-8f99-8d68248a741d@oracle.com>
 <c8bd5396-84f2-e782-79d7-f493aca95781@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c8bd5396-84f2-e782-79d7-f493aca95781@redhat.com>
X-ClientProxiedBy: DM6PR02CA0096.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::37) To BYAPR10MB3287.namprd10.prod.outlook.com
 (2603:10b6:a03:15c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 572562c7-614f-41e4-fbc9-08da70680a51
X-MS-TrafficTypeDiagnostic: CY4PR10MB1672:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kOoISs3s1nKd0So9fvcvK3aoeD1QhPX9XuEg727VFJOaR+XSnfJJQE/FW2cq9pkRld5THRJvzeHl0BM/xJ+ZII8YqYc9LBukzjjAPdw7CSRfnm4vkeJi6X2GkXQcdJ4Y9fu2tEwJSzZtEi2OhJKNQ404aaCCP9ELrFOhuW4cZ1J7ChYvtjXXopRm/sMBFLA8Q6tSoQ01tdTufwi+oyn8AShEubKbl7cwD+wIFybdVNXfNwZIQWUJxpGSMmXlIbisUrjNhV32VvkRR+kTOMz1zEYpOagrzqF7Q/kENwQv3eF8hH2L5QskNFtfUEyWPZmpvO5TrG8KJjjh5Q+bFgUAhRdH0fdk7TOcvBuaJ6sNs2dMQI+Oqy/gFAq8MgvDsazHlpl3qZBXN7iRXLIUDemrVMkxaW4oE6ceyilDEqi5pzXyz1riK4qe6Ph+pMVSjdmBlJgmMrdqARPkbLTIWwG4ABJsUfbpqiPyf3dIvO4DcViSc8bn5M1JKPUpcNd0UE1eiFr6Y/JyMgxBwl6uGfhkJPx1nAkDwKGnFgg+1ep9mCtcXkomRtSRNSpkQP/Q30aCWSQpQob3uwzSqFlPdsPbVq7XWZYSv3srasVHpB3PlIR5KRrEb/aYiyxR1D+xHvQdZrPit4UgrbelTE/V+IxKnC9DCghx7EQaobYpT3IWJXtOxWVXD47XZR7ZZG9N3gOpC6BZbGwnC45oelo0SuRNVEaw02is4S30SflEPLBvXGGXBEyqMEt2iT3MnYWiWMU3UXPu5l7ji5boCvj+mJ6ij9oXAZqzTzty0HXMHOSJ8+BPxexMnYuIXH1R6sQi2nT84qMlvpQMm93cNwtM6aFANb7NZGTbsKpstTD2pjeQRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3287.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(39860400002)(136003)(366004)(396003)(376002)(346002)(26005)(4326008)(6666004)(8676002)(54906003)(6512007)(110136005)(966005)(53546011)(6506007)(66556008)(66476007)(66946007)(86362001)(186003)(36916002)(83380400001)(8936002)(2616005)(316002)(478600001)(41300700001)(31696002)(5660300002)(31686004)(2906002)(30864003)(38100700002)(36756003)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXRNK0RuMEpJRXJpcGpxb1BiTUpZcUlHYklUcUxyTEtvdVpPaU9XelByWWlF?=
 =?utf-8?B?TXo2RzZnbEhLUU9VNTFzNzBGbUtZMTBwc2tDVFpEVlJWd1UvQmVBL2ltcnZp?=
 =?utf-8?B?RkJSSko4WVFyMEszTXVjUEpnejF1aGdnc1Qyb1Y4aTZUelVqZ0RpZnhINGVE?=
 =?utf-8?B?S0F2QlRnUUxyVXFmbjIxengwQktWK09Fd2p2Tjd1Mm1BQ3ZTVlg3RTByampq?=
 =?utf-8?B?cjUvbURKcHJFVzdENnhrWm5UWWh4TUFTOVZsQlZvdDNDVVFFaGNQV1IreWI5?=
 =?utf-8?B?U0xlaG5pK08vWHhnTDgrR1B2VUlJOExadzlHa2VSVkw2SDgvWTFlTDZlendW?=
 =?utf-8?B?OXQ2cmpaV2s2Uzg5SzlNUjVFMmJWNDZTVUdWQndRUnJxd1d6ZkFpOUZYcDdN?=
 =?utf-8?B?YjQ4RVVsY1dNUTArVkZtOHRRVEZ5cUxzMVNFdUxna2krTHNDcXNwaDNGcm4y?=
 =?utf-8?B?QzJSUUlkcDFncnQrenROTFZYRDh3RE1BWXpLblZkUk9MeDBSTlpQZXEyOVcz?=
 =?utf-8?B?ZUMxTjFzNW1kbmk2VUErWFR1ejZ0U0g5V1BpOGVFT05EaHgvcEh3ZjNBelkr?=
 =?utf-8?B?UGZWOXRGRDA2eVVkbUtVajRoOW5RQUZYTjNWMjlWcGV6N2trblE4aGNMVVph?=
 =?utf-8?B?bkdaVERSbjdnRzVFNDBXVHlnRjhlU2hvS2ZZOU54OCswd1RZejF2QWZZYkxS?=
 =?utf-8?B?eGE2SXlhUFUzdzJFRDdCWkJHcmNxaHBpOVp4WVB5bUV2VnlTZjZZQTZYZ2Rl?=
 =?utf-8?B?cm96SzhZbXEzZmw3VUF3Z2p5OU4yNHY3ZUdFOGd1OEl6RkUyYkN2RWNGR3Uz?=
 =?utf-8?B?eTBvajhtRjdDV09DV1Q0aGNQd2tPR01xZFYrS1FZNW9jdUtKTW9oTjNNcFps?=
 =?utf-8?B?alNNQmpicTF2WnBuNWg3Rkk2S3lvaGxwUXpTdHlNbExRamxSMzQ5U3poZW15?=
 =?utf-8?B?SkplSUxzbUltUWlMekwyT2I0S0psVHlHdXF5ODFOL29QUFp2Q0ZwM1JxQ0RO?=
 =?utf-8?B?THYwZHA5bUFHcXJveWw5WXpiTWtOSzhDdFAzdE1hRUFoa1ZPNzhJVS9hd2JU?=
 =?utf-8?B?TzhnRjlWelN1aU5YbnVPRklobXd2RDJXRmtIRStnVWowc3ppN0I5QkF1U2px?=
 =?utf-8?B?TTBUc3RYS0VlWHJhZUJlL0xNZjN6OHNVRmE4K1Yya3FLcU1Na3JxR0RYZ1cy?=
 =?utf-8?B?eXpzb1FJVy9JNXg1aTljM3dUdGZjQk9WMmhSK0RFWXp6c0NHcEpvZ2V6ZGQw?=
 =?utf-8?B?ek1XZ01qWkFYN2xmbUlZR3dqby8wWlBMM0tLcnZITUFTY2VJd1VjdzlVM3Jj?=
 =?utf-8?B?QmpqK1VtR0w1WFNSOGV2UUpsT2tmejJDMklyTmkwSFlDVmtoSDg3dEhLUXRI?=
 =?utf-8?B?Z3NXNkRxRWhXMVlEd2lCL013VzBGdzFXc3BpUWcvbTZNL0lObWhGSEJybGI2?=
 =?utf-8?B?Z0NHR0hqVVpSaFdKakI2V3RzRExjMUZTbmUxMUtYNnFhVlphWG5iNVZjYnY2?=
 =?utf-8?B?eGZQVmsxckYvNTU3d2FmT05QaHBZKzVlK24vUWJtcVNWRlNsM2psQTRvMFFl?=
 =?utf-8?B?cXJGZHl4Q0xpa1lOMjFiaW5sMmRIMGZuMCtBVnBxREJUR3FpQVJEaUw3MkFx?=
 =?utf-8?B?M2FkRllxRE4wMFg2RmNIQ09GNzNLWmMvUkdkVlNodVE5R1hXdWJUYmRvQjJp?=
 =?utf-8?B?VWVadFBHUnByLzVmMzBpZmRKdHFLZEU0WllXT1RxVmV2QTdHZDRDU3JmeWFa?=
 =?utf-8?B?R1RtOGFqenhiR2pmTjFpU1FKTTZlNUo3Tkp2TjNYOG5sbHo2NkxyWXFJVUhv?=
 =?utf-8?B?ajF3NWp2cjJXUmJZcHhsQVc1S2hBZHRKRUFXcmU2aWxMc2RvZk5idkZrdWx0?=
 =?utf-8?B?T3ZPVmIrdi8rZzBBbVJvTVl1SjBEeE1rb1lnZ3ZiZk5BdncwZXNTVG1NVFBu?=
 =?utf-8?B?UExrczNyNnVkUlBiNUZjMDl2RDFmMWtwdlJLLytoRTFQTlptRWlPakx1N1F3?=
 =?utf-8?B?WCtNOEZDWWY2V3lNK3FzUDQ5WHBIMGEyTUJBb1A3VzZGRTJiSm9BcnNlU3cy?=
 =?utf-8?B?UG94bWlPNExsTXphNUU0cnV5TEtHRGEwR1RORXhwSGI4SGJ0V0I2dDJCRXFV?=
 =?utf-8?Q?kCPjyTGmVt118HeF10BxE2ilq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 572562c7-614f-41e4-fbc9-08da70680a51
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 07:08:58.0276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boRY15vOsNA0g23e5glPJ4D7u8Qxr0fVFZPhsv9EgBd43eH6vyF2J4nkS93uyaNtMuztdde+yPdtdChzN0KK5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_01,2022-07-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207280028
X-Proofpoint-ORIG-GUID: B5mvQxUaWQ0sk5eqFVsKGI_yQKL4hBO8
X-Proofpoint-GUID: B5mvQxUaWQ0sk5eqFVsKGI_yQKL4hBO8
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>
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

CgpPbiA3LzI3LzIwMjIgNzowNiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IOWcqCAyMDIyLzcv
MjggMDg6NTYsIFNpLVdlaSBMaXUg5YaZ6YGTOgo+Pgo+Pgo+PiBPbiA3LzI3LzIwMjIgNDo0NyBB
TSwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gNy8yNy8yMDIyIDU6NDMgUE0s
IFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4gU29ycnkgdG8gY2hpbWUgaW4gbGF0ZSBpbiB0aGUgZ2Ft
ZS4gRm9yIHNvbWUgcmVhc29uIEkgY291bGRuJ3QgZ2V0IAo+Pj4+IHRvIG1vc3QgZW1haWxzIGZv
ciB0aGlzIGRpc2N1c3Npb24gKEkgb25seSBzdWJzY3JpYmVkIHRvIHRoZSAKPj4+PiB2aXJ0dWFs
aXphdGlvbiBsaXN0KSwgd2hpbGUgSSB3YXMgdGFraW5nIG9mZiBhbW9uZ3N0IHRoZSBwYXN0IGZl
dyAKPj4+PiB3ZWVrcy4KPj4+Pgo+Pj4+IEl0IGxvb2tzIHRvIG1lIHRoaXMgcGF0Y2ggaXMgaW5j
b21wbGV0ZS4gTm90ZWQgZG93biB0aGUgd2F5IGluIAo+Pj4+IHZkcGFfZGV2X25ldF9jb25maWdf
ZmlsbCgpLCB3ZSBoYXZlIHRoZSBmb2xsb3dpbmc6Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBmZWF0
dXJlcyA9IHZkZXYtPmNvbmZpZy0+Z2V0X2RyaXZlcl9mZWF0dXJlcyh2ZGV2KTsKPj4+PiDCoMKg
wqDCoMKgwqDCoMKgIGlmIChubGFfcHV0X3U2NF82NGJpdChtc2csIAo+Pj4+IFZEUEFfQVRUUl9E
RVZfTkVHT1RJQVRFRF9GRUFUVVJFUywgZmVhdHVyZXMsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZEUEFfQVRUUl9QQUQp
KQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7
Cj4+Pj4KPj4+PiBNYWtpbmcgY2FsbCB0byAuZ2V0X2RyaXZlcl9mZWF0dXJlcygpIGRvZXNuJ3Qg
bWFrZSBzZW5zZSB3aGVuIAo+Pj4+IGZlYXR1cmUgbmVnb3RpYXRpb24gaXNuJ3QgY29tcGxldGUu
IE5laXRoZXIgc2hvdWxkIHByZXNlbnQgCj4+Pj4gbmVnb3RpYXRlZF9mZWF0dXJlcyB0byB1c2Vy
c3BhY2UgYmVmb3JlIG5lZ290aWF0aW9uIGlzIGRvbmUuCj4+Pj4KPj4+PiBTaW1pbGFybHksIG1h
eF92cXAgdGhyb3VnaCB2ZHBhX2Rldl9uZXRfbXFfY29uZmlnX2ZpbGwoKSBwcm9iYWJseSAKPj4+
PiBzaG91bGQgbm90IHNob3cgYmVmb3JlIG5lZ290aWF0aW9uIGlzIGRvbmUgLSBpdCBkZXBlbmRz
IG9uIGRyaXZlciAKPj4+PiBmZWF0dXJlcyBuZWdvdGlhdGVkLgo+Pj4gSSBoYXZlIGFub3RoZXIg
cGF0Y2ggaW4gdGhpcyBzZXJpZXMgaW50cm9kdWNlcyBkZXZpY2VfZmVhdHVyZXMgYW5kIAo+Pj4g
d2lsbCByZXBvcnQgZGV2aWNlX2ZlYXR1cmVzIHRvIHRoZSB1c2Vyc3BhY2UgZXZlbiBmZWF0dXJl
cyAKPj4+IG5lZ290aWF0aW9uIG5vdCBkb25lLiBCZWNhdXNlIHRoZSBzcGVjIHNheXMgd2Ugc2hv
dWxkIGFsbG93IGRyaXZlciAKPj4+IGFjY2VzcyB0aGUgY29uZmlnIHNwYWNlIGJlZm9yZSBGRUFU
VVJFU19PSy4KPj4gVGhlIGNvbmZpZyBzcGFjZSBjYW4gYmUgYWNjZXNzZWQgYnkgZ3Vlc3QgYmVm
b3JlIGZlYXR1cmVzX29rIGRvZXNuJ3QgCj4+IG5lY2Vzc2FyaWx5IG1lYW4gdGhlIHZhbHVlIGlz
IHZhbGlkLiAKPgo+Cj4gSXQncyB2YWxpZCBhcyBsb25nIGFzIHRoZSBkZXZpY2Ugb2ZmZXJzIHRo
ZSBmZWF0dXJlOgo+Cj4gIlRoZSBkZXZpY2UgTVVTVCBhbGxvdyByZWFkaW5nIG9mIGFueSBkZXZp
Y2Utc3BlY2lmaWMgY29uZmlndXJhdGlvbiAKPiBmaWVsZCBiZWZvcmUgRkVBVFVSRVNfT0sgaXMg
c2V0IGJ5IHRoZSBkcml2ZXIuIFRoaXMgaW5jbHVkZXMgZmllbGRzIAo+IHdoaWNoIGFyZSBjb25k
aXRpb25hbCBvbiBmZWF0dXJlIGJpdHMsIGFzIGxvbmcgYXMgdGhvc2UgZmVhdHVyZSBiaXRzIAo+
IGFyZSBvZmZlcmVkIGJ5IHRoZSBkZXZpY2UuIgpJIGd1ZXNzIHRoaXMgc3RhdGVtZW50IG9ubHkg
Y29udmV5cyB0aGF0IHRoZSBmaWVsZCBpbiBjb25maWcgc3BhY2UgY2FuIApiZSByZWFkIGJlZm9y
ZSBGRUFUVVJFU19PSyBpcyBzZXQsIHRob3VnaCBpdCBkb2VzIG5vdCAqZXhwbGljaXRseSogCnN0
YXRlcyB0aGUgdmFsaWRpdHkgb2YgZmllbGQuCgpBbmQgbG9va2luZyBhdDoKCiJUaGUgbWFjIGFk
ZHJlc3MgZmllbGQgYWx3YXlzIGV4aXN0cyAodGhvdWdoIGlzIG9ubHkgdmFsaWQgaWYgClZJUlRJ
T19ORVRfRl9NQUMgaXMgc2V0KSwgYW5kIHN0YXR1cyBvbmx5IGV4aXN0cyBpZiBWSVJUSU9fTkVU
X0ZfU1RBVFVTIAppcyBzZXQuIgoKSXQgYXBwZWFycyB0byBtZSB0aGVyZSdzIGEgYm9yZGVyIGxp
bmUgc2V0IGJldHdlZW4gImV4aXN0IiBhbmQgInZhbGlkIi4gCklmIEkgdW5kZXJzdGFuZCB0aGUg
c3BlYyB3b3JkaW5nIGNvcnJlY3RseSwgYSBzcGVjLWNvbmZvcm1pbmcgZGV2aWNlIAppbXBsZW1l
bnRhdGlvbiBtYXkgb3IgbWF5IG5vdCBvZmZlciB2YWxpZCBzdGF0dXMgdmFsdWUgaW4gdGhlIGNv
bmZpZyAKc3BhY2Ugd2hlbiBWSVJUSU9fTkVUX0ZfU1RBVFVTIGlzIG9mZmVyZWQsIGJ1dCBiZWZv
cmUgdGhlIGZlYXR1cmUgaXMgCm5lZ290aWF0ZWQuIE9uIHRoZSBvdGhlciBoYW5kLCBjb25maWcg
c3BhY2Ugc2hvdWxkIGNvbnRhaW4gdmFsaWQgbWFjIAphZGRyZXNzIHRoZSBtb21lbnQgVklSVElP
X05FVF9GX01BQyBmZWF0dXJlIGlzIG9mZmVyZWQsIHJlZ2FyZGxlc3MgYmVpbmcgCm5lZ290aWF0
ZWQgb3Igbm90LiBCeSB0aGF0LCB0aGVyZSBzZWVtcyB0byBiZSBsZWV3YXkgZm9yIHRoZSBkZXZp
Y2UgCmltcGxlbWVudGF0aW9uIHRvIGRlY2lkZSB3aGVuIGNvbmZpZyBzcGFjZSBmaWVsZCBtYXkg
YmVjb21lIHZhbGlkLCAKdGhvdWdoIGZvciBtb3N0IG9mIFFFTVUncyBzb2Z0d2FyZSB2aXJ0aW8g
ZGV2aWNlcywgdmFsaWQgdmFsdWUgaXMgCnByZXNlbnQgdG8gY29uZmlnIHNwYWNlIHRoZSB2ZXJ5
IGZpcnN0IG1vbWVudCB3aGVuIGZlYXR1cmUgaXMgb2ZmZXJlZC4KCiJJZiB0aGUgVklSVElPX05F
VF9GX01BQyBmZWF0dXJlIGJpdCBpcyBzZXQsIHRoZSBjb25maWd1cmF0aW9uIHNwYWNlIG1hYyAK
ZW50cnkgaW5kaWNhdGVzIHRoZSDigJxwaHlzaWNhbOKAnSBhZGRyZXNzIG9mIHRoZSBuZXR3b3Jr
IGNhcmQsIG90aGVyd2lzZSAKdGhlIGRyaXZlciB3b3VsZCB0eXBpY2FsbHkgZ2VuZXJhdGUgYSBy
YW5kb20gbG9jYWwgTUFDIGFkZHJlc3MuIgoiSWYgdGhlIFZJUlRJT19ORVRfRl9TVEFUVVMgZmVh
dHVyZSBiaXQgaXMgbmVnb3RpYXRlZCwgdGhlIGxpbmsgc3RhdHVzIApjb21lcyBmcm9tIHRoZSBi
b3R0b20gYml0IG9mIHN0YXR1cy4gT3RoZXJ3aXNlLCB0aGUgZHJpdmVyIGFzc3VtZXMgaXTigJlz
IAphY3RpdmUuIgoKQW5kIGFsc28gdGhlcmUgYXJlIHNwZWNpYWwgY2FzZXMgd2hlcmUgdGhlIHJl
YWQgb2Ygc3BlY2lmaWMgCmNvbmZpZ3VyYXRpb24gc3BhY2UgZmllbGQgTVVTVCBiZSBkZWZlcnJl
ZCB0byB1bnRpbCBGRUFUVVJFU19PSyBpcyBzZXQ6CgoiSWYgdGhlIFZJUlRJT19CTEtfRl9DT05G
SUdfV0NFIGZlYXR1cmUgaXMgbmVnb3RpYXRlZCwgdGhlIGNhY2hlIG1vZGUgCmNhbiBiZSByZWFk
IG9yIHNldCB0aHJvdWdoIHRoZSB3cml0ZWJhY2sgZmllbGQuIDAgY29ycmVzcG9uZHMgdG8gYSAK
d3JpdGV0aHJvdWdoIGNhY2hlLCAxIHRvIGEgd3JpdGViYWNrIGNhY2hlMTEuIFRoZSBjYWNoZSBt
b2RlIGFmdGVyIHJlc2V0IApjYW4gYmUgZWl0aGVyIHdyaXRlYmFjayBvciB3cml0ZXRocm91Z2gu
IFRoZSBhY3R1YWwgbW9kZSBjYW4gYmUgCmRldGVybWluZWQgYnkgcmVhZGluZyB3cml0ZWJhY2sg
YWZ0ZXIgZmVhdHVyZSBuZWdvdGlhdGlvbi4iCiJUaGUgZHJpdmVyIE1VU1QgTk9UIHJlYWQgd3Jp
dGViYWNrIGJlZm9yZSBzZXR0aW5nIHRoZSBGRUFUVVJFU19PSyAKZGV2aWNlIHN0YXR1cyBiaXQu
IgoiSWYgVklSVElPX0JMS19GX0NPTkZJR19XQ0UgaXMgbmVnb3RpYXRlZCBidXQgVklSVElPX0JM
S19GX0ZMVVNIIGlzIG5vdCwgCnRoZSBkZXZpY2UgTVVTVCBpbml0aWFsaXplIHdyaXRlYmFjayB0
byAwLiIKClNpbmNlIHRoZSBzcGVjIGRvZXNuJ3QgZXhwbGljaXRseSBtYW5kYXRlIHRoZSB2YWxp
ZGl0eSBvZiBlYWNoIGNvbmZpZyAKc3BhY2UgZmllbGQgd2hlbiBmZWF0dXJlIG9mIGNvbmNlcm4g
aXMgb2ZmZXJlZCwgdG8gYmUgc2FmZXIgd2UnZCBoYXZlIHRvIApsaXZlIHdpdGggb2RkIGRldmlj
ZSBpbXBsZW1lbnRhdGlvbi4gSSBrbm93IGZvciBzdXJlIFFFTVUgc29mdHdhcmUgCmRldmljZXMg
d29uJ3QgZm9yIDk5JSBvZiB0aGVzZSBjYXNlcywgYnV0IHRoYXQncyBub3Qgd2hhdCBpcyBjdXJy
ZW50bHkgCmRlZmluZWQgaW4gdGhlIHNwZWMuCgo+Cj4KPj4gWW91IG1heSB3YW50IHRvIGRvdWJs
ZSBjaGVjayB3aXRoIE1pY2hhZWwgZm9yIHdoYXQgaGUgcXVvdGVkIGVhcmxpZXI6Cj4+PiBOb3Bl
Ogo+Pj4KPj4+IDIuNS4xwqAgRHJpdmVyIFJlcXVpcmVtZW50czogRGV2aWNlIENvbmZpZ3VyYXRp
b24gU3BhY2UKPj4+Cj4+PiAuLi4KPj4+Cj4+PiBGb3Igb3B0aW9uYWwgY29uZmlndXJhdGlvbiBz
cGFjZSBmaWVsZHMsIHRoZSBkcml2ZXIgTVVTVCBjaGVjayB0aGF0IAo+Pj4gdGhlIGNvcnJlc3Bv
bmRpbmcgZmVhdHVyZSBpcyBvZmZlcmVkCj4+PiBiZWZvcmUgYWNjZXNzaW5nIHRoYXQgcGFydCBv
ZiB0aGUgY29uZmlndXJhdGlvbiBzcGFjZS4KPj4KPj4gYW5kIGhvdyBtYW55IGRyaXZlciBidWdz
IHRha2luZyB3cm9uZyBhc3N1bXB0aW9uIG9mIHRoZSB2YWxpZGl0eSBvZiAKPj4gY29uZmlnIHNw
YWNlIGZpZWxkIHdpdGhvdXQgZmVhdHVyZXNfb2suIEkgYW0gbm90IHN1cmUgd2hhdCB1c2UgY2Fz
ZSAKPj4geW91IHdhbnQgdG8gZXhwb3NlIGNvbmZpZyByZXNpc3RlciB2YWx1ZXMgZm9yIGJlZm9y
ZSBmZWF0dXJlc19vaywgaWYgCj4+IGl0J3MgbW9zdGx5IGZvciBsaXZlIG1pZ3JhdGlvbiBJIGd1
ZXNzIGl0J3MgcHJvYmFibHkgaGVhZGluZyBhIHdyb25nIAo+PiBkaXJlY3Rpb24uCj4KPgo+IEkg
Z3Vlc3MgaXQncyBub3QgZm9yIG1pZ3JhdGlvbi4gClRoZW4gd2hhdCdzIHRoZSBvdGhlciBwb3Nz
aWJsZSB1c2UgY2FzZSB0aGFuIGxpdmUgbWlncmF0aW9uLCB3ZXJlIHRvIApleHBvc2UgY29uZmln
IHNwYWNlIHZhbHVlcz8gVHJvdWJsZXNob290aW5nIGNvbmZpZyBzcGFjZSBkaXNjcmVwYW5jeSAK
YmV0d2VlbiB2RFBBIGFuZCB0aGUgZW11bGF0ZWQgdmlydGlvIGRldmljZSBpbiB1c2Vyc3BhY2U/
IE9yIHRyYWNraW5nIApjaGFuZ2VzIGluIGNvbmZpZyBzcGFjZSBhY3Jvc3MgZmVhdHVyZSBuZWdv
dGlhdGlvbiwgYnV0IGZvciB3aGF0PyBJdCdkIApiZSBiZW5lZmljaWFsIHRvIHRoZSBpbnRlcmZh
Y2UgZGVzaWduIGlmIHRoZSBzcGVjaWZpYyB1c2UgY2FzZSBjYW4gYmUgCmNsZWFybHkgZGVzY3Jp
YmVkLi4uCgoKPiBGb3IgbWlncmF0aW9uLCBhIHByb3Zpc2lvbiB3aXRoIHRoZSBjb3JyZWN0IGZl
YXR1cmVzL2NhcGFiaWxpdHkgd291bGQgCj4gYmUgc3VmZmljaWVudC4KUmlnaHQsIHRoYXQncyB3
aGF0IEkgdGhvdWdodCB0b28uIEl0IGRvZXNuJ3QgbmVlZCB0byBleHBvc2UgY29uZmlnIHNwYWNl
IAp2YWx1ZXMsIHNpbXBseSBleHBvcnRpbmcgYWxsIGF0dHJpYnV0ZXMgZm9yIHZkcGEgZGV2aWNl
IGNyZWF0aW9uIHdpbGwgZG8gCnRoZSB3b3JrLgoKLVNpd2VpCgo+Cj4gVGhhbmtzCj4KPgo+Pgo+
Pgo+Pj4+Cj4+Pj4KPj4+PiBMYXN0IGJ1dCBub3QgdGhlIGxlYXN0LCB0aGlzICJ2ZHBhIGRldiBj
b25maWciIGNvbW1hbmQgd2FzIG5vdCAKPj4+PiBkZXNpZ25lZCB0byBkaXNwbGF5IHRoZSByZWFs
IGNvbmZpZyBzcGFjZSByZWdpc3RlciB2YWx1ZXMgaW4gdGhlIAo+Pj4+IGZpcnN0IHBsYWNlLiBR
dW90aW5nIHRoZSB2ZHBhLWRldig4KSBtYW4gcGFnZToKPj4+Pgo+Pj4+PiB2ZHBhIGRldiBjb25m
aWcgc2hvdyAtIFNob3cgY29uZmlndXJhdGlvbiBvZiBzcGVjaWZpYyBkZXZpY2Ugb3IgCj4+Pj4+
IGFsbCBkZXZpY2VzLgo+Pj4+PiBERVYgLSBzcGVjaWZpZXMgdGhlIHZkcGEgZGV2aWNlIHRvIHNo
b3cgaXRzIGNvbmZpZ3VyYXRpb24uIElmIHRoaXMgCj4+Pj4+IGFyZ3VtZW50IGlzIG9taXR0ZWQg
YWxsIGRldmljZXMgY29uZmlndXJhdGlvbiBpcyBsaXN0ZWQuCj4+Pj4gSXQgZG9lc24ndCBzYXkg
YW55dGhpbmcgYWJvdXQgY29uZmlndXJhdGlvbiBzcGFjZSBvciByZWdpc3RlciAKPj4+PiB2YWx1
ZXMgaW4gY29uZmlnIHNwYWNlLiBBcyBsb25nIGFzIGl0IGNhbiBjb252ZXkgdGhlIGNvbmZpZyAK
Pj4+PiBhdHRyaWJ1dGUgd2hlbiBpbnN0YW50aWF0aW5nIHZEUEEgZGV2aWNlIGluc3RhbmNlLCBh
bmQgbW9yZSAKPj4+PiBpbXBvcnRhbnRseSwgdGhlIGNvbmZpZyBjYW4gYmUgZWFzaWx5IGltcG9y
dGVkIGZyb20gb3IgZXhwb3J0ZWQgdG8gCj4+Pj4gdXNlcnNwYWNlIHRvb2xzIHdoZW4gdHJ5aW5n
IHRvIHJlY29uc3RydWN0IHZkcGEgaW5zdGFuY2UgaW50YWN0IG9uIAo+Pj4+IGRlc3RpbmF0aW9u
IGhvc3QgZm9yIGxpdmUgbWlncmF0aW9uLCBJTUhPIGluIG15IHBlcnNvbmFsIAo+Pj4+IGludGVy
cHJldGF0aW9uIGl0IGRvZXNuJ3QgbWF0dGVyIHdoYXQgdGhlIGNvbmZpZyBzcGFjZSBtYXkgcHJl
c2VudC4gCj4+Pj4gSXQgbWF5IGJlIHdvcnRoIHdoaWxlIGFkZGluZyBhIG5ldyBkZWJ1ZyBjb21t
YW5kIHRvIGV4cG9zZSB0aGUgcmVhbCAKPj4+PiByZWdpc3RlciB2YWx1ZSwgYnV0IHRoYXQncyBh
bm90aGVyIHN0b3J5Lgo+Pj4gSSBhbSBub3Qgc3VyZSBnZXR0aW5nIHlvdXIgcG9pbnRzLiB2RFBB
IG5vdyByZXBvcnRzIGRldmljZSBmZWF0dXJlIAo+Pj4gYml0cyhkZXZpY2VfZmVhdHVyZXMpIGFu
ZCBuZWdvdGlhdGVkIGZlYXR1cmUgYml0cyhkcml2ZXJfZmVhdHVyZXMpLCAKPj4+IGFuZCB5ZXMs
IHRoZSBkcml2ZXJzIGZlYXR1cmVzIGNhbiBiZSBhIHN1YnNldCBvZiB0aGUgZGV2aWNlIAo+Pj4g
ZmVhdHVyZXM7IGFuZCB0aGUgdkRQQSBkZXZpY2UgZmVhdHVyZXMgY2FuIGJlIGEgc3Vic2V0IG9m
IHRoZSAKPj4+IG1hbmFnZW1lbnQgZGV2aWNlIGZlYXR1cmVzLgo+PiBXaGF0IEkgc2FpZCBpcyBh
ZnRlciB1bmJsb2NraW5nIHRoZSBjb25kaXRpb25hbCBjaGVjaywgeW91J2QgaGF2ZSB0byAKPj4g
aGFuZGxlIHRoZSBjYXNlIGZvciBlYWNoIG9mIHRoZSB2ZHBhIGF0dHJpYnV0ZSB3aGVuIGZlYXR1
cmUgCj4+IG5lZ290aWF0aW9uIGlzIG5vdCB5ZXQgZG9uZTogYmFzaWNhbGx5IHRoZSByZWdpc3Rl
ciB2YWx1ZXMgeW91IGdvdCAKPj4gZnJvbSBjb25maWcgc3BhY2UgdmlhIHRoZSB2ZHBhX2dldF9j
b25maWdfdW5sb2NrZWQoKSBjYWxsIGlzIG5vdCAKPj4gY29uc2lkZXJlZCB0byBiZSB2YWxpZCBi
ZWZvcmUgZmVhdHVyZXNfb2sgKHBlci1zcGVjKS4gQWx0aG91Z2ggaW4gCj4+IHNvbWUgY2FzZSB5
b3UgbWF5IGdldCBzYW5lIHZhbHVlLCBzdWNoIGJlaGF2aW9yIGlzIGdlbmVyYWxseSAKPj4gdW5k
ZWZpbmVkLiBJZiB5b3UgZGVzaXJlIHRvIHNob3cganVzdCB0aGUgZGV2aWNlX2ZlYXR1cmVzIGFs
b25lIAo+PiB3aXRob3V0IGFueSBjb25maWcgc3BhY2UgZmllbGQsIHdoaWNoIHRoZSBkZXZpY2Ug
aGFkIGFkdmVydGlzZWQgCj4+ICpiZWZvcmUgZmVhdHVyZSBuZWdvdGlhdGlvbiBpcyBjb21wbGV0
ZSosIHRoYXQnbGwgYmUgZmluZS4gQnV0IGxvb2tzIAo+PiB0byBtZSB0aGlzIGlzIG5vdCBob3cg
cGF0Y2ggaGFzIGJlZW4gaW1wbGVtZW50ZWQuIFByb2JhYmx5IG5lZWQgc29tZSAKPj4gbW9yZSB3
b3JrPwo+Pgo+PiBSZWdhcmRzLAo+PiAtU2l3ZWkKPj4KPj4+Pgo+Pj4+IEhhdmluZyBzYWlkLCBw
bGVhc2UgY29uc2lkZXIgdG8gZHJvcCB0aGUgRml4ZXMgdGFnLCBhcyBhcHBlYXJzIHRvIAo+Pj4+
IG1lIHlvdSdyZSBwcm9wb3NpbmcgYSBuZXcgZmVhdHVyZSByYXRoZXIgdGhhbiBmaXhpbmcgYSBy
ZWFsIGlzc3VlLgo+Pj4gaXQncyBhIG5ldyBmZWF0dXJlIHRvIHJlcG9ydCB0aGUgZGV2aWNlIGZl
YXR1cmUgYml0cyB0aGFuIG9ubHkgCj4+PiBuZWdvdGlhdGVkIGZlYXR1cmVzLCBob3dldmVyIHRo
aXMgcGF0Y2ggaXMgYSBtdXN0LCBvciBpdCB3aWxsIGJsb2NrIAo+Pj4gdGhlIGRldmljZSBmZWF0
dXJlIGJpdHMgcmVwb3J0aW5nLiBidXQgSSBhZ3JlZSwgdGhlIGZpeCB0YWcgaXMgbm90IGEgCj4+
PiBtdXN0Lgo+Pj4+Cj4+Pj4gVGhhbmtzLAo+Pj4+IC1TaXdlaQo+Pj4+Cj4+Pj4gT24gNy8xLzIw
MjIgMzoxMiBQTSwgUGFyYXYgUGFuZGl0IHZpYSBWaXJ0dWFsaXphdGlvbiB3cm90ZToKPj4+Pj4+
IEZyb206IFpodSBMaW5nc2hhbjxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+Pj4gU2VudDog
RnJpZGF5LCBKdWx5IDEsIDIwMjIgOToyOCBBTQo+Pj4+Pj4KPj4+Pj4+IFVzZXJzIG1heSB3YW50
IHRvIHF1ZXJ5IHRoZSBjb25maWcgc3BhY2Ugb2YgYSB2RFBBIGRldmljZSwgdG8gCj4+Pj4+PiBj
aG9vc2UgYQo+Pj4+Pj4gYXBwcm9wcmlhdGUgb25lIGZvciBhIGNlcnRhaW4gZ3Vlc3QuIFRoaXMg
bWVhbnMgdGhlIHVzZXJzIG5lZWQgdG8gCj4+Pj4+PiByZWFkIHRoZQo+Pj4+Pj4gY29uZmlnIHNw
YWNlIGJlZm9yZSBGRUFUVVJFU19PSywgYW5kIHRoZSBleGlzdGVuY2Ugb2YgY29uZmlnIHNwYWNl
Cj4+Pj4+PiBjb250ZW50cyBkb2VzIG5vdCBkZXBlbmQgb24gRkVBVFVSRVNfT0suCj4+Pj4+Pgo+
Pj4+Pj4gVGhlIHNwZWMgc2F5czoKPj4+Pj4+IFRoZSBkZXZpY2UgTVVTVCBhbGxvdyByZWFkaW5n
IG9mIGFueSBkZXZpY2Utc3BlY2lmaWMgCj4+Pj4+PiBjb25maWd1cmF0aW9uIGZpZWxkCj4+Pj4+
PiBiZWZvcmUgRkVBVFVSRVNfT0sgaXMgc2V0IGJ5IHRoZSBkcml2ZXIuIFRoaXMgaW5jbHVkZXMg
ZmllbGRzIAo+Pj4+Pj4gd2hpY2ggYXJlCj4+Pj4+PiBjb25kaXRpb25hbCBvbiBmZWF0dXJlIGJp
dHMsIGFzIGxvbmcgYXMgdGhvc2UgZmVhdHVyZSBiaXRzIGFyZSAKPj4+Pj4+IG9mZmVyZWQgYnkg
dGhlCj4+Pj4+PiBkZXZpY2UuCj4+Pj4+Pgo+Pj4+Pj4gRml4ZXM6IDMwZWY3YThhYzhhMDcgKHZk
cGE6IFJlYWQgZGV2aWNlIGNvbmZpZ3VyYXRpb24gb25seSBpZiAKPj4+Pj4+IEZFQVRVUkVTX09L
KQo+Pj4+PiBGaXggaXMgZmluZSwgYnV0IGZpeGVzIHRhZyBuZWVkcyBjb3JyZWN0aW9uIGRlc2Ny
aWJlZCBiZWxvdy4KPj4+Pj4KPj4+Pj4gQWJvdmUgY29tbWl0IGlkIGlzIDEzIGxldHRlcnMgc2hv
dWxkIGJlIDEyLgo+Pj4+PiBBbmQKPj4+Pj4gSXQgc2hvdWxkIGJlIGluIGZvcm1hdAo+Pj4+PiBG
aXhlczogMzBlZjdhOGFjOGEwICgidmRwYTogUmVhZCBkZXZpY2UgY29uZmlndXJhdGlvbiBvbmx5
IGlmIAo+Pj4+PiBGRUFUVVJFU19PSyIpCj4+Pj4+Cj4+Pj4+IFBsZWFzZSB1c2UgY2hlY2twYXRj
aC5wbCBzY3JpcHQgYmVmb3JlIHBvc3RpbmcgdGhlIHBhdGNoZXMgdG8gCj4+Pj4+IGNhdGNoIHRo
ZXNlIGVycm9ycy4KPj4+Pj4gVGhlcmUgaXMgYSBib3QgdGhhdCBsb29rcyBhdCB0aGUgZml4ZXMg
dGFnIGFuZCBpZGVudGlmaWVzIHRoZSAKPj4+Pj4gcmlnaHQga2VybmVsIHZlcnNpb24gdG8gYXBw
bHkgdGhpcyBmaXguCj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW48bGlu
Z3NoYW4uemh1QGludGVsLmNvbT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gwqAgZHJpdmVycy92ZHBhL3Zk
cGEuYyB8IDggLS0tLS0tLS0KPj4+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygt
KQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIvZHJpdmVy
cy92ZHBhL3ZkcGEuYyBpbmRleAo+Pj4+Pj4gOWIwZTM5YjJmMDIyLi5kNzZiMjJiMmY3YWUgMTAw
NjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+Pj4+PiArKysgYi9kcml2ZXJz
L3ZkcGEvdmRwYS5jCj4+Pj4+PiBAQCAtODUxLDE3ICs4NTEsOSBAQCB2ZHBhX2Rldl9jb25maWdf
ZmlsbChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4+Pj4+PiBzdHJ1Y3Qgc2tfYnVmZiAqbXNn
LCB1MzIgcG9ydGlkLMKgIHsKPj4+Pj4+IMKgwqDCoMKgwqAgdTMyIGRldmljZV9pZDsKPj4+Pj4+
IMKgwqDCoMKgwqAgdm9pZCAqaGRyOwo+Pj4+Pj4gLcKgwqDCoCB1OCBzdGF0dXM7Cj4+Pj4+PiDC
oMKgwqDCoMKgIGludCBlcnI7Cj4+Pj4+Pgo+Pj4+Pj4gwqDCoMKgwqDCoCBkb3duX3JlYWQoJnZk
ZXYtPmNmX2xvY2spOwo+Pj4+Pj4gLcKgwqDCoCBzdGF0dXMgPSB2ZGV2LT5jb25maWctPmdldF9z
dGF0dXModmRldik7Cj4+Pj4+PiAtwqDCoMKgIGlmICghKHN0YXR1cyAmIFZJUlRJT19DT05GSUdf
U19GRUFUVVJFU19PSykpIHsKPj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBOTF9TRVRfRVJSX01TR19N
T0QoZXh0YWNrLCAiRmVhdHVyZXMgbmVnb3RpYXRpb24gbm90Cj4+Pj4+PiBjb21wbGV0ZWQiKTsK
Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBlcnIgPSAtRUFHQUlOOwo+Pj4+Pj4gLcKgwqDCoMKgwqDC
oMKgIGdvdG8gb3V0Owo+Pj4+Pj4gLcKgwqDCoCB9Cj4+Pj4+PiAtCj4+Pj4+PiDCoMKgwqDCoMKg
IGhkciA9IGdlbmxtc2dfcHV0KG1zZywgcG9ydGlkLCBzZXEsICZ2ZHBhX25sX2ZhbWlseSwgZmxh
Z3MsCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVkRQQV9DTURfREVWX0NP
TkZJR19HRVQpOwo+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAoIWhkcikgewo+Pj4+Pj4gLS0gCj4+Pj4+
PiAyLjMxLjEKPj4+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPj4+Pj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4+Pj4+IFZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4+Pj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5j
b20vdjMvX19odHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbl9fOyEhQUNXVjVOOU0yUlY5OWhRIVBrd3ltN09Bam9EdWNVcXMyZkF3
Y2h4cUw4LUJHZDZ3T2wtNTF4Y2dCX3lDTndQSl9jczhBMXktY1ltckxUQjRPQk5zaW1uWnVxSlBj
dlFJbDNnJCAKPj4+Pgo+Pj4+Cj4+Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
