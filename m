Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E3DC0015E
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 00:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C69A60C07;
	Thu, 10 Aug 2023 00:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C69A60C07
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=nIPYkjpf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=EeJYQCpX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j1GdKzoCpWvn; Thu, 10 Aug 2023 00:40:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3B50E60AB7;
	Thu, 10 Aug 2023 00:40:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B50E60AB7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 191E8C0071;
	Thu, 10 Aug 2023 00:40:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A377AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 00:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AA9D418BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 00:40:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7AA9D418BF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=nIPYkjpf; 
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.i=@oracle.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-oracle-onmicrosoft-com header.b=EeJYQCpX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4tcwpbFtmbkM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 00:40:21 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BC4F418BE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 00:40:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BC4F418BE
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 379IiRI2024562; Thu, 10 Aug 2023 00:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tKhyY0/g6/tlQ1uPwK1hpRzhLcAKbSR2LX53dHfb8A0=;
 b=nIPYkjpf4V7ty7blOs5azHr6zUz1bYVmIKs8pMtr7Rci9cUgRk+DJAAKXD8fLtGAcN9q
 wwM1Co1T4eH1sMAMK5Ses6m+rOV/YzGgObt9sfdK1GvzT0s/5gGTmvnUTkJcDUhxWsRa
 +n9unnRmehwDeYiSWse2DtN06Z9SK9Fd7msJ/xZVQgbDOk794X1Wgw1le7rIsZL1NLxw
 oDuRpqC5J2ZNK35kDRaxY77Tya7yXVfQ1XU4OH5ObuB6Rw/f7uBEWMxf4LNtrbvUSk2n
 /2Ki6ugD+/jLOSzQP9a5SzDl4zbcRXxQGfCzhvrGVeXpZf0lpwreMS+3PotutYvvRB44 Lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbca25n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 00:40:13 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 379NoDaE018751; Thu, 10 Aug 2023 00:40:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3s9cve9k5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 00:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWqAvB8o3FcBaP5pCglwhIWb8oTbIpoho62tK1qZWoPDK/CpsiWSqVJGQVnb4JinH3g8EranDjaSGYMTITa2XF9qyp0cZ16O6ihZY38Jwy00kRsBJrF0aEaI4stQ+ti2xeqT98J9Vn/4rHVy/IFpfIDOSzMBOigxiFfVmyVkicMsPZSxVA8gt/mMESO2dRHwDdmfveV6341qWIq2I+mmcKeiiXdZgm6FXOcB49oBZ3w3Qb6UAUER08sIsjPDR3MaX8qsAHg9y8Twzr2K3aL5X3aupyaisHsZCyOnv9NB2fukDMHO/EmRwL31S6i0YbLDT+DoW09CdSWsPVDIESd71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKhyY0/g6/tlQ1uPwK1hpRzhLcAKbSR2LX53dHfb8A0=;
 b=PqAl1Ygfj908kQ0a+shLjUYWqGp1+l1AWyaK96ayZH/a3WP/NLbaCDanPKVFDphPOQMQuHlp45ahRs2nKjILNFrsWKnJA/Ouk0Qy2NFW83QZMX/Pdeb3l7nZiBSVQZ4pb3eLTal2iDPZYrEYXRhienMUF5i+V4o/zrUqZ19ncWTWr2Jp3xl/952d1rcS7bSknMm+piDpxC2V3HghYQy3DxqaM8zc3UlZHAnGfhyU+6I1adxs0ZzpDbhEf+mIn3n3gEBLzVQLpQ8t22lkZebEZ0GCvMkaI+LiFavA2v4xvnqyzmvq+v/0UILUleaDJO7/au2E/6h8VaPv3GvY7wlmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKhyY0/g6/tlQ1uPwK1hpRzhLcAKbSR2LX53dHfb8A0=;
 b=EeJYQCpXNYeNsk9gwuSjUSlqPBRpMTtS8DHovbFEtJ7RRSbCToTg4nyeaN7Qd+IUPmN2c78N7naiTq+/oEV4nQ3VBg2UG9obslCdKfxPWYlX65EQobFaGfZuoa1ckwJ8WMn4YIASB/k4doSCJkJBRdzaFkE41YFyoaCv8JgEV1c=
Received: from SA1PR10MB6519.namprd10.prod.outlook.com (2603:10b6:806:2b1::8)
 by CY5PR10MB5913.namprd10.prod.outlook.com (2603:10b6:930:2f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 00:40:09 +0000
Received: from SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::7f3d:6dd4:15da:d3a0]) by SA1PR10MB6519.namprd10.prod.outlook.com
 ([fe80::7f3d:6dd4:15da:d3a0%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 00:40:02 +0000
Message-ID: <e5a853f1-d83b-ffe5-b96a-b3c0d9c6f528@oracle.com>
Date: Wed, 9 Aug 2023 17:40:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
 <20230802171231.11001-3-dtatulea@nvidia.com>
 <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
 <741645a0-c576-e504-8ebc-6b716099d730@oracle.com>
 <CACGkMEuAUBa=ZWi2Y48KDABsyAsQFNc4AAPmkHZyXHCQ8Vv89A@mail.gmail.com>
 <3472a482-dc1d-1994-e2d7-c2bd740bbd27@oracle.com>
 <CACGkMEsj=Bg3GvsErWQqe0Ov8CqT9un0nTFeDYW6EzzowJm9rQ@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEsj=Bg3GvsErWQqe0Ov8CqT9un0nTFeDYW6EzzowJm9rQ@mail.gmail.com>
X-ClientProxiedBy: SA9PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:806:27::21) To SA1PR10MB6519.namprd10.prod.outlook.com
 (2603:10b6:806:2b1::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6519:EE_|CY5PR10MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 9486a0c2-9b2f-441d-d1ce-08db993a55a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oiLZ0Rz28B4hTOIiOb5aCl13qptJNwGoamoICs2dKoB5m/DY5NpirI3r+ZOdZrwzqqXlBr+WbCIavq4KHr3+UowVL7HuxbJW86TKTnQOIMFLPdiGWWZsKRFT2gcIHRiZV+59kjdQNJ+HcBqWJ2RK4o1Ma6mY9HUIxRLQfBrp6iaDEFzPSU0d4naZdRbbYh8AX91uj0+k+T4zReFm2WMjp4kC6GrNTmQc6BRv9xd0j4JroTSvEU/ZMMSs5Efgr+LEuxFwwBVQKQ9XRXL+XQ8o+4fEqQegDH41oWUVtTTguUSSbTnhI3865AkXFFywh3Y0XPCrM6+sgaqCS+D04RW1RX7l589aCd24AefMi6PKbKuukM4gSHt3j8hvb0+AfeE/J6y13OVbMSY9OeSY7b9LwqwGpSEvcJlaFwc6tQF2Uprtgm3/L9vNGI+FRLxa2XXwbjE79mt3WXtSPklWVsf9RSAxc8hXZgQ2BfpJeW/71epPWjAXdQfhC+RtXjMJzLkOY14CsFxLC1CFQBQVjkDctqF0sAqcQBODCcCdzX2529dKIeert8jzddRUxSJWeph9YCA+aOhLOaXb9UiDONTI4KA777NMDAOPiImXCeZJ60Whxd6bZPbKQTVDJsKbf119WhoRjJiw4FUI0+Phvpd0BQJB6RzjHK01bNhCRImiWjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB6519.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199021)(1800799006)(186006)(2616005)(6486002)(6512007)(83380400001)(66574015)(31686004)(478600001)(6506007)(26005)(53546011)(36916002)(966005)(54906003)(38100700002)(41300700001)(316002)(5660300002)(8676002)(8936002)(66476007)(4326008)(6916009)(66556008)(66946007)(30864003)(2906002)(31696002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFSWGpHWnNCMGxXSUtNY0VCZFVjV3NZai80YkU5MU56Vmd0dXJCNWtpTmRN?=
 =?utf-8?B?V1V3Y3BMZ1dGSXFWc3BsVmZ2UmhENUtoekVrb1lEcnJkUk1VdU1oL0xNWFVV?=
 =?utf-8?B?RHRTM2NpbUZGNWRGWXpXTWlmVENsempzeGI4cDZiazdGb2N0b3Z5SEE5dnpI?=
 =?utf-8?B?VTRDeW1LVEpIdFhOMUtOZ0VqYWtrRkpEa1JwRXczODBDckxNR2FPYUV4OWtI?=
 =?utf-8?B?cmYvNXRacHVBK01vNGlSTWpkaUxLSXVPekpmdEhaNVUvUGtuT3lJNkw0M01D?=
 =?utf-8?B?OEw3d1ZnQ1pPOFVqa0pEM0VQMlBQbmNkNkRSVHJJdS9hQlRLdk1JVWNQLys2?=
 =?utf-8?B?Nys4a09nazdsRDMxSWs1Wm9LY0xJYWMrMUo2ZWFYeW1Zd3dJOFUrSkdhQnNP?=
 =?utf-8?B?ZG5KWUdwbEZJNUJjcjJZQkNuWko3bG4vQU9tZ3kvUU45b3Y1dVMvRFVwOHhJ?=
 =?utf-8?B?VEg0TFhpZWZjcnJGSk52REhGUzlFaVdYcEtJRW9jbFZSbmNnNEx2dGxyRUkr?=
 =?utf-8?B?bVIzS0F2REo4eWFvcXhKZEZZVnA0L1l2bXVXVGhpalUwbnB2WU1JNzQ3UGFP?=
 =?utf-8?B?bFNVNWIzUU1qUEhnbjhsZXBad2JPeldHeWh5MmZIaWlMZ0hBNUFTOG82YXBK?=
 =?utf-8?B?NVR2ajVsaGY0a09QUGM2Q2szVE1POVpRUDJsR3VNTk5mMlBzbGlrZkpBUHVJ?=
 =?utf-8?B?L3VabW9jemh5WVc2b2VUU1FwY1pxZG8xcFZwOTlJUWtDQ3dXSHE5bTUweUY0?=
 =?utf-8?B?QmJPYTArVnd1cXY1RS9sYTkyMzlXUGZJZ0phNE1VQ0JGcE83dHVBWnF2cWRF?=
 =?utf-8?B?TjZnTWEvTWUyNW54YVBwTEdRWTBmV216NVh2UmduNDM0emRETGI4VXJXc05p?=
 =?utf-8?B?c282RnY3TklLNjIrTDQwQUw3MS90NjJ5RHROdlZpSEVLdVh1OVpzMTlSZ2hi?=
 =?utf-8?B?STg0cTNFV3hRanYyeGJ2RXhEQmJiY090RGk5NlpJNTVBdTYrS2FKSnFRbnAw?=
 =?utf-8?B?S1FSUHdwd3BLV3AxOXdYYnZ1di81M2tZNlNoNHdLdVFCM05XVlhJZS92ZEhm?=
 =?utf-8?B?Q3R1ZjI5UEV1eGF3c3FLT2hJeTVCQkdVakpjOGU4QXdPY0xlWTc0bFd6L0Uw?=
 =?utf-8?B?VEk4YXNBRGFzY1JrcjNReEtFQXF1QzRmLzJEc3Urc2VKcGdvSTlTV0V1a0Qx?=
 =?utf-8?B?SWRxRUd3MmE0NEx5a2twVE00Yi9heUp6V0IwRTNIbFNvVjBQS0RmNDArdlRS?=
 =?utf-8?B?amhZVDlVczV4VFVvOTd2NkhZOGlWS3YvWHQyVUc2ZncvaDZXSk9BZWhjZzNw?=
 =?utf-8?B?MVU4ZDE5cjhWb3hZZHZCTGp1bk1GUHRHb1cwWGJXU0xEZjBtbTh1SS9CcEZC?=
 =?utf-8?B?UXNyOVJESytnUm1wVmhuWXY3ZVUwaG5YbWdZSjN0a2FJN2lCbWF3MGdaT3l0?=
 =?utf-8?B?Rks0aWR6aHkrbzJNdkxHVkIyNWxKL0N4UEE5TS9iVjJ6dFlyUTJ5VlRaOEZ1?=
 =?utf-8?B?QVBtK01oR3cvMk1VQXZrZVEvYlV5b2V2MzdtZ3NKSEk4YnpOYnRYbkhCYThE?=
 =?utf-8?B?QUNkS2h2Q1ZxOUErMDYzMUYzQlhKbjdienpZNVR1TmRlcy85QnExVnp2RWg1?=
 =?utf-8?B?eGgzcXFUU05kZXMyaVJTK3pPa2xrM3Jzclh6dnlqd2ZGM29iZDRpTTg2SnJj?=
 =?utf-8?B?U0kxUGZIaXRsTmFDUkZ1elBiV1NnWkVPNUFXUVAzTjZkb3JoZVdXZ1NsQm1L?=
 =?utf-8?B?NysvVjRDUS9tcnN2KzVQTitrV0NtZXBSeW1yNU0zSTI4NkZrZVFNNDErYVI5?=
 =?utf-8?B?VE1BQy9qNE5QTmd0NTR4V1RiTDJlbkRVUW5lQnh5ZEFWVnJxQUlvaGVicXZC?=
 =?utf-8?B?YVU2ODFrM2VYSk91ZG1jSERUTjhJeFJpRmxvck9VUWhUQjB2QXd3UElYS21j?=
 =?utf-8?B?RUJNTy9UTXM3aE5yK0N6Q3BOSmloZnJBc014T2dkSUk2eFlJdi90b0YrR3hJ?=
 =?utf-8?B?aXFURWM2VDJ0NXBUZXc0TmxkckhzbGl4T25tYlJRc1hwQlUrWEUrbTFwZXow?=
 =?utf-8?B?ZmNmVDZKTUVTTm4wdlJpRDVmaUdXMm81MEdPaWt1VFZmT3F6OUlqbWtPVTBU?=
 =?utf-8?Q?x6KuzjdurqVkHA6pNYecqXbp+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eFhTazB1OEJWVjZZWURsZ0xzZzhoZzlhVXVCbnhYZy9MeGRHWnpReGJ6S3ZZ?=
 =?utf-8?B?bTR0R0VBNTlVWjZqYjZGZzB4dUpZNlhnMmV0dElscmJ1SnVDZTB5NnRsZzlr?=
 =?utf-8?B?aXJ3c1RUL3U4a2lIcEZrTEhGclkzOGJ3R1FJaXh6U2N0RWJWcDIya0ZpcThi?=
 =?utf-8?B?ZkFJWlFUZHJFOStXZURveHZwMjhxbjMxM0lQYitKRThneENyZUtNekQwekt0?=
 =?utf-8?B?M1dZSWhiRWhHOHRCYytBdjgwV0JVbnZ1L2dLVVg2SXlmVlczb01Bay8zb1ha?=
 =?utf-8?B?U00vSy9uclY2SEJEdkJsZVZrN0M3RjdIV3NtUVJRUE5TOHl6YkwzMUtSNE9S?=
 =?utf-8?B?YUE5RkprdjNCTGh0SFROSzV4UTlrb3lGRjNrVmQ5RnlGRDdaYktzdGR3VnRl?=
 =?utf-8?B?ZG5HU1AwNGhrelMzYUhSOEZBZ1loOWFTWFZwenJPUnI2SGh6VndOZUpIdXln?=
 =?utf-8?B?dUluTVFQZ1dENlZ4bGJLdmRyanoyUHN6SkhVOUVZQURCOVI4dHI0dmwwOGNw?=
 =?utf-8?B?bVp1cXU5c1JPYWd4Tk5BSUFkOGh1TnExODFhUHhvS3llTElDMFZnRDRzUCtP?=
 =?utf-8?B?d1Vubk9zdE9ZS3FuL0cyU2ZaWTNJUTg1dU1kYXQ3L3hhZjlKaUtUQmowdm00?=
 =?utf-8?B?YTFPLytiY0ZMbkd4S0h1VTBzSytJNEpqVTIzRVBZYXIyUVg5cS9JYU9NSk9w?=
 =?utf-8?B?U3VSMjZHaVpPOFUvaExZdTR5dkRueG1oWWo5MU51Q1F6UzJTdTQ0MG5kUDFo?=
 =?utf-8?B?M0h2aGprSHlPcXplbk5ncGxzb1RiYXVrVWtjR295clptU2U5RGI4cHVSbHlq?=
 =?utf-8?B?Y3FJVmhGMzZkR0lLZkRoZXJhR2ZHN1BVaXRMcWtBWDZaR3B3WkZLNXVkblV3?=
 =?utf-8?B?RjdIUjNPdGZuWU1NdUU5SkpwTHJSM0ZrY1pzenJUbUlxUWxXQlBsRXI1bGtC?=
 =?utf-8?B?OE8vZHByekNhSHJ1alM5VHM0UURDaHNDck90dlQ3TmpmTG15WTc4S25hL1pC?=
 =?utf-8?B?c2lmalp4QTI1TkxOQkltTlhnTkFRTkNGMTBPUUVGeER5N1Y2aE5hMWlkSU9j?=
 =?utf-8?B?eVpaQUtzakFqU0dwcURZWlovSG1acEhYeHZuN1BKVGdFaVlHL0NmaW5TWHBI?=
 =?utf-8?B?elgva3E2REFZYVYyR1lQT2tIQzAvaW9ydVlRYlF6TStqSWdQakdtbkJobDIy?=
 =?utf-8?B?UnprcERHdEFsSmdOd01mMUZ3T0JwcVNkcms0SG1uRGZIZEVyaWNCdWlwdENT?=
 =?utf-8?Q?C0G30dTcF4wOTsy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9486a0c2-9b2f-441d-d1ce-08db993a55a2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6519.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 00:40:02.8201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 638+1QaJ8KQLR6cC69vgq4fzBamHAKnMUJbyR6kT9y37g4PUoH6M41kn9Xgig7Rh4zG3lH9lFu6kB0pzVX8Xhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_20,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100003
X-Proofpoint-ORIG-GUID: bU2LF3ehltgtBONJRoxoKiqqx2wxfAFf
X-Proofpoint-GUID: bU2LF3ehltgtBONJRoxoKiqqx2wxfAFf
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, virtualization@lists.linux-foundation.org,
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

CgpPbiA4LzgvMjAyMyAxMTo1MiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBXZWQsIEF1ZyA5
LCAyMDIzIGF0IDY6NTjigK9BTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IHdy
b3RlOgo+Pgo+Pgo+PiBPbiA4LzcvMjAyMyA4OjAwIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4g
T24gRnJpLCBBdWcgNCwgMjAyMyBhdCAxOjU44oCvQU0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBv
cmFjbGUuY29tPiB3cm90ZToKPj4+Pgo+Pj4+IE9uIDgvMy8yMDIzIDE6MDMgQU0sIEphc29uIFdh
bmcgd3JvdGU6Cj4+Pj4+IE9uIFRodSwgQXVnIDMsIDIwMjMgYXQgMToxM+KAr0FNIERyYWdvcyBU
YXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPiB3cm90ZToKPj4+Pj4+IFRoZSBtci0+aW5pdGlh
bGl6ZWQgZmxhZyBpcyBzaGFyZWQgYmV0d2VlbiB0aGUgY29udHJvbCB2cSBhbmQgZGF0YSB2cQo+
Pj4+Pj4gcGFydCBvZiB0aGUgbXIgaW5pdC91bmluaXQuIEJ1dCBpZiB0aGUgY29udHJvbCB2cSBh
bmQgZGF0YSB2cSBnZXQgcGxhY2VkCj4+Pj4+PiBpbiBkaWZmZXJlbnQgQVNJRHMsIGl0IGNhbiBo
YXBwZW4gdGhhdCBpbml0aWFsaXppbmcgdGhlIGNvbnRyb2wgdnEgd2lsbAo+Pj4+Pj4gcHJldmVu
dCB0aGUgZGF0YSB2cSBtciBmcm9tIGJlaW5nIGluaXRpYWxpemVkLgo+Pj4+Pj4KPj4+Pj4+IFRo
aXMgcGF0Y2ggY29uc29saWRhdGVzIHRoZSBjb250cm9sIGFuZCBkYXRhIHZxIGluaXQgcGFydHMg
aW50byB0aGVpcgo+Pj4+Pj4gb3duIGluaXQgZnVuY3Rpb25zLiBUaGUgbXItPmluaXRpYWxpemVk
IHdpbGwgbm93IGJlIHVzZWQgZm9yIHRoZSBkYXRhIHZxCj4+Pj4+PiBvbmx5LiBUaGUgY29udHJv
bCB2cSBjdXJyZW50bHkgZG9lc24ndCBuZWVkIGEgZmxhZy4KPj4+Pj4+Cj4+Pj4+PiBUaGUgdW5p
bml0aWFsaXppbmcgcGFydCBpcyBhbHNvIHRha2VuIGNhcmUgb2Y6IG1seDVfdmRwYV9kZXN0cm95
X21yIGdvdAo+Pj4+Pj4gc3BsaXQgaW50byBkYXRhIGFuZCBjb250cm9sIHZxIGZ1bmN0aW9ucyB3
aGljaCBhcmUgbm93IGFsc28gQVNJRCBhd2FyZS4KPj4+Pj4+Cj4+Pj4+PiBGaXhlczogOGZjZDIw
YzMwNzA0ICgidmRwYS9tbHg1OiBTdXBwb3J0IGRpZmZlcmVudCBhZGRyZXNzIHNwYWNlcyBmb3Ig
Y29udHJvbCBhbmQgZGF0YSIpCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBEcmFnb3MgVGF0dWxlYSA8
ZHRhdHVsZWFAbnZpZGlhLmNvbT4KPj4+Pj4+IFJldmlld2VkLWJ5OiBFdWdlbmlvIFDDqXJleiA8
ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPj4+Pj4+IFJldmlld2VkLWJ5OiBHYWwgUHJlc3NtYW4gPGdh
bEBudmlkaWEuY29tPgo+Pj4+Pj4gLS0tCj4+Pj4+PiAgICAgZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaCB8ICAxICsKPj4+Pj4+ICAgICBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21y
LmMgICAgICAgIHwgOTcgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tCj4+Pj4+PiAgICAg
MiBmaWxlcyBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkKPj4+Pj4+
Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaCBi
L2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPj4+Pj4+IGluZGV4IDI1ZmM0MTIw
YjYxOC4uYTA0MjBiZTUwNTlmIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUv
Y29yZS9tbHg1X3ZkcGEuaAo+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1
X3ZkcGEuaAo+Pj4+Pj4gQEAgLTMxLDYgKzMxLDcgQEAgc3RydWN0IG1seDVfdmRwYV9tciB7Cj4+
Pj4+PiAgICAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgaGVhZDsKPj4+Pj4+ICAgICAgICAgICAg
dW5zaWduZWQgbG9uZyBudW1fZGlyZWN0czsKPj4+Pj4+ICAgICAgICAgICAgdW5zaWduZWQgbG9u
ZyBudW1fa2xtczsKPj4+Pj4+ICsgICAgICAgLyogc3RhdGUgb2YgZHZxIG1yICovCj4+Pj4+PiAg
ICAgICAgICAgIGJvb2wgaW5pdGlhbGl6ZWQ7Cj4+Pj4+Pgo+Pj4+Pj4gICAgICAgICAgICAvKiBz
ZXJpYWxpemUgbWtleSBjcmVhdGlvbiBhbmQgZGVzdHJ1Y3Rpb24gKi8KPj4+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21yLmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3Jl
L21yLmMKPj4+Pj4+IGluZGV4IDAzZTU0MzIyOTc5MS4uNGFlMTRhMjQ4YTRiIDEwMDY0NAo+Pj4+
Pj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jCj4+Pj4+PiArKysgYi9kcml2ZXJz
L3ZkcGEvbWx4NS9jb3JlL21yLmMKPj4+Pj4+IEBAIC00ODksNjAgKzQ4OSwxMDMgQEAgc3RhdGlj
IHZvaWQgZGVzdHJveV91c2VyX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0
IG1seDVfdmRwYV9tciAqbXIKPj4+Pj4+ICAgICAgICAgICAgfQo+Pj4+Pj4gICAgIH0KPj4+Pj4+
Cj4+Pj4+PiAtdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAq
bXZkZXYpCj4+Pj4+PiArc3RhdGljIHZvaWQgX21seDVfdmRwYV9kZXN0cm95X2N2cV9tcihzdHJ1
Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHVuc2lnbmVkIGludCBhc2lkKQo+Pj4+Pj4gK3sKPj4+
Pj4+ICsgICAgICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JPVVBdICE9
IGFzaWQpCj4+Pj4+PiArICAgICAgICAgICAgICAgcmV0dXJuOwo+Pj4+Pj4gKwo+Pj4+Pj4gKyAg
ICAgICBwcnVuZV9pb3RsYihtdmRldik7Cj4+Pj4+PiArfQo+Pj4+Pj4gKwo+Pj4+Pj4gK3N0YXRp
YyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12
ZGV2LCB1bnNpZ25lZCBpbnQgYXNpZCkKPj4+Pj4+ICAgICB7Cj4+Pj4+PiAgICAgICAgICAgIHN0
cnVjdCBtbHg1X3ZkcGFfbXIgKm1yID0gJm12ZGV2LT5tcjsKPj4+Pj4+Cj4+Pj4+PiAtICAgICAg
IG11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7Cj4+Pj4+PiArICAgICAgIGlmIChtdmRldi0+Z3Jv
dXAyYXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dST1VQXSAhPSBhc2lkKQo+Pj4+Pj4gKyAgICAgICAg
ICAgICAgIHJldHVybjsKPj4+Pj4+ICsKPj4+Pj4+ICAgICAgICAgICAgaWYgKCFtci0+aW5pdGlh
bGl6ZWQpCj4+Pj4+PiAtICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4+Pj4+PiArICAgICAgICAg
ICAgICAgcmV0dXJuOwo+Pj4+Pj4KPj4+Pj4+IC0gICAgICAgcHJ1bmVfaW90bGIobXZkZXYpOwo+
Pj4+Pj4gICAgICAgICAgICBpZiAobXItPnVzZXJfbXIpCj4+Pj4+PiAgICAgICAgICAgICAgICAg
ICAgZGVzdHJveV91c2VyX21yKG12ZGV2LCBtcik7Cj4+Pj4+PiAgICAgICAgICAgIGVsc2UKPj4+
Pj4+ICAgICAgICAgICAgICAgICAgICBkZXN0cm95X2RtYV9tcihtdmRldiwgbXIpOwo+Pj4+Pj4K
Pj4+Pj4+ICAgICAgICAgICAgbXItPmluaXRpYWxpemVkID0gZmFsc2U7Cj4+Pj4+PiAtb3V0Ogo+
Pj4+Pj4gK30KPj4+Pj4+ICsKPj4+Pj4+ICtzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfZGVzdHJveV9t
cl9hc2lkKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdW5zaWduZWQgaW50IGFzaWQpCj4+
Pj4+PiArewo+Pj4+Pj4gKyAgICAgICBzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRldi0+
bXI7Cj4+Pj4+PiArCj4+Pj4+PiArICAgICAgIG11dGV4X2xvY2soJm1yLT5ta2V5X210eCk7Cj4+
Pj4+PiArCj4+Pj4+PiArICAgICAgIF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIobXZkZXYsIGFz
aWQpOwo+Pj4+Pj4gKyAgICAgICBfbWx4NV92ZHBhX2Rlc3Ryb3lfY3ZxX21yKG12ZGV2LCBhc2lk
KTsKPj4+Pj4+ICsKPj4+Pj4+ICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZtci0+bWtleV9tdHgp
Owo+Pj4+Pj4gICAgIH0KPj4+Pj4+Cj4+Pj4+PiAtc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0
ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsCj4+Pj4+PiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsIHVuc2lnbmVkIGludCBh
c2lkKQo+Pj4+Pj4gK3ZvaWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2KQo+Pj4+Pj4gK3sKPj4+Pj4+ICsgICAgICAgbWx4NV92ZHBhX2Rlc3Ryb3lfbXJf
YXNpZChtdmRldiwgbXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0pOwo+Pj4+
Pj4gKyAgICAgICBtbHg1X3ZkcGFfZGVzdHJveV9tcl9hc2lkKG12ZGV2LCBtdmRldi0+Z3JvdXAy
YXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dST1VQXSk7Cj4+Pj4+PiArfQo+Pj4+Pj4gKwo+Pj4+Pj4g
K3N0YXRpYyBpbnQgX21seDVfdmRwYV9jcmVhdGVfY3ZxX21yKHN0cnVjdCBtbHg1X3ZkcGFfZGV2
ICptdmRldiwKPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCB2aG9zdF9pb3RsYiAqaW90bGIsCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBpbnQgYXNpZCkKPj4+Pj4+ICt7Cj4+Pj4+PiArICAgICAgIGlmICht
dmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFfQ1ZRX0dST1VQXSAhPSBhc2lkKQo+Pj4+Pj4gKyAg
ICAgICAgICAgICAgIHJldHVybiAwOwo+Pj4+Pj4gKwo+Pj4+Pj4gKyAgICAgICByZXR1cm4gZHVw
X2lvdGxiKG12ZGV2LCBpb3RsYik7Cj4+Pj4+IFRoaXMgd29ycmllcyBtZSBhcyBjb25jZXB0dWFs
bHksIHRoZXJlIHNob3VsZCBiZSBubyBkaWZmZXJlbmNlIGJldHdlZW4KPj4+Pj4gZHZxIG1yIGFu
ZCBjdnEgbXIuIFRoZSB2aXJ0cXVldWUgc2hvdWxkIGJlIGxvb3NlbHkgY291cGxlZCB3aXRoIG1y
Lgo+Pj4+Pgo+Pj4+PiBPbmUgZXhhbXBsZSBpcyB0aGF0LCBpZiB3ZSBvbmx5IGRvIGR1cF9pb3Rs
YigpIGJ1dCBub3QgdHJ5IHRvIGNyZWF0ZQo+Pj4+PiBkbWEgbXIgaGVyZSwgd2Ugd2lsbCBicmVh
ayB2aXJ0aW8tdmRwYToKPj4+PiBGb3IgdGhpcyBjYXNlLCBJIGd1ZXNzIHdlIG1heSBuZWVkIGFu
b3RoZXIgd2F5IHRvIHN1cHBvcnQgdmlydGlvLXZkcGEKPj4+PiAxOjEgbWFwcGluZyByYXRoZXIg
dGhhbiBvdmVybG9hZGluZyB2aXJ0aW8gZGV2aWNlIHJlc2V0IHNlbWFudGljcywgc2VlOgo+Pj4+
Cj4+Pj4gaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9xZW11LWRldmVsQG5vbmdudS5vcmcv
bXNnOTUzNzU1Lmh0bWwKPj4+Pgo+Pj4+ICAgID4gQ29uY2VwdHVhbGx5LCB0aGUgYWRkcmVzcyBt
YXBwaW5nIGlzIG5vdCBhIHBhcnQgb2YgdGhlIGFic3RyYWN0aW9uIGZvcgo+Pj4+ICAgID4gYSB2
aXJ0aW8gZGV2aWNlIG5vdy4gU28gcmVzZXR0aW5nIHRoZSBtZW1vcnkgbWFwcGluZyBkdXJpbmcg
dmlydGlvCj4+Pj4gICAgPiBkZXZpY2UgcmVzZXQgc2VlbXMgd3JvbmcuCj4+Pj4KPj4+PiB3aGVy
ZSB3ZSB3YW50IHRvIGtlZXAgbWVtb3J5IG1hcHBpbmcgaW50YWN0IGFjcm9zcyB2aXJ0aW8gZGV2
aWNlIHJlc2V0Cj4+Pj4gZm9yIGJlc3QgbGl2ZSBtaWdyYXRpb24gbGF0ZW5jeS9kb3dudGltZS4g
SSB3b25kZXIgd291bGQgaXQgd29yayB0bwo+Pj4+IHJlc2V0IHRoZSBtYXBwaW5nIGluIHZob3N0
LXZkcGEgbGlmZSBjeWNsZSBvdXQgb2YgdmlydGlvIHJlc2V0LCBzYXkKPj4+PiBpbnRyb2R1Y2Ug
YSAucmVzZXRfbWFwKCkgb3AgdG8gcmVzdG9yZSAxOjEgbWFwcGluZyB3aXRoaW4KPj4+PiB2aG9z
dF92ZHBhX3JlbW92ZV9hcygpIHJpZ2h0IGFmdGVyIHZob3N0X3ZkcGFfaW90bGJfdW5tYXAoKT8g
VGhlbiB3ZSBjYW4KPj4+PiBtb3ZlIHRoZSBpb3RsYiByZXNldCBsb2dpYyB0byB0aGVyZSB3aXRo
b3V0IHdvcnJ5IGJyZWFraW5nIHZpcnRpby12ZHBhLgo+Pj4gSXQgbG9va3MgdG8gbWUgd2UgZG9u
J3QgbmVlZCBhIG5ldyBvcHMuIFdlIGNhbiBzaW1wbHkgZG8gc2V0X21hcCgpCj4+PiB0d2ljZQo+
PiBXaGF0IGRvZXMgaXQgbWVhbiwgZmlyc3Qgc2V0X21hcCgwLCAtMVVMTCkgd2l0aCB6ZXJvIGlv
dGxiIGVudHJ5IHBhc3NlZAo+PiBpbiB0byBkZXN0cm95IGFsbCBpb3RsYiBtYXBwaW5ncyBwcmV2
aW91c2x5IGFkZGVkLCBhbmQgc2Vjb25kIHNldF9tYXAoMCwKPj4gLTFVTEwpIHRvIHJlc3RvcmUg
MToxIERNQSBNUj8gQnV0IHVzZXJzcGFjZSAobWF5YmUgYSBidWdneSBvbmUgYnV0Cj4+IGRvZXNu
J3QgZG8gaGFybSkgYXBhcnQgZnJvbSB2aG9zdC12ZHBhIGl0c2VsZiBjYW4gZG8gdW5tYXAgdHdp
Y2UgYW55d2F5LAo+PiB0aGlzIGlzIHN1cHBvcnRlZCB0b2RheSBJIHRoaW5rLiBXaHkgdGhlcmUn
bGwgYmUgc3VjaCBvYnNjdXJlCj4+IGRpc3RpbmN0aW9uLCBvciB3aGF0J3MgdGhlIGJlbmVmaXQg
dG8gdHJlYXQgc2Vjb25kIC5zZXRfbWFwKCkgYXMKPj4gcmVjcmVhdGluZyAxOjEgbWFwcGluZz8K
PiBPaywgSSB0aGluayBJIG1pc3Mgc29tZSBjb250ZXh0LiBJIGFncmVlIHRoYXQgaXQncyBiZXR0
ZXIgdG8gZGVjb3VwbGUKPiBtZW1vcnkgbWFwcGluZ3MgZnJvbSB0aGUgdmlydGlvIHJlc2V0LiBJ
dCBoZWxwcyB0byByZWR1Y2UgdGhlCj4gdW5uZWNlc3NhcnkgbWVtb3J5IHRyYW5zYWN0aW9ucy4g
SXQgbWlnaHQgcmVxdWlyZSBhIG5ldyBmZWF0dXJlIGZsYWcuClRoaXMgSSBhZ3JlZWQuIEFGQUlD
VCBRRU1VIHdvdWxkIG5lZWQgdG8gY2hlY2sgdGhpcyBuZXcgZmVhdHVyZSBmbGFnIHRvIAptYWtl
IHN1cmUgbWVtb3J5IG1hcHBpbmdzIGFyZSBrZXB0IGludGFjdCBhY3Jvc3MgcmVzZXQsIG90aGVy
d2lzZSBmb3IgCnRoZSBzYWtlIG9mIGF2b2lkIGJyZWFraW5nIG9sZGVyIGtlcm5lbHMgaXQgaGFz
IHRvIHJlY3JlYXRlIGFsbCB0aGUgCm1hcHBpbmdzIGFmdGVyIHJlc2V0IGxpa2UgaG93IGl0IGlz
IGRvbmUgdG9kYXkuCgo+IFJlZ2FyZGluZyB0aGUgbWV0aG9kIG9mIHJlc3RvcmluZyB0byAxOjEg
RE1BIE1SLCBpdCBtaWdodCBiZSBkYW5nZXJvdXMKPiBmb3IgKGJ1Z2d5KSB2aG9zdC12RFBBIGRl
dmljZXMuIFNpbmNlIGl0cyB1c2Vyc3BhY2UgZG9lc24ndCBzZXQgdXAgYW55Cj4gbWFwcGluZyBp
dCBjYW4gZXhwbG9yZSB0aGUga2VybmVsIHdpdGggdGhhdCB2aWEgQ1ZRPwpOb3Qgc3VyZSBJIHVu
ZGVyc3RhbmQgdGhpcyBwcm9wb3NhbC4gVGhlIDE6MSBETUEgTVIgaXMgZmlyc3QgY3JlYXRlZCBh
dCAKdmRwYSBkZXZpY2UgYWRkLCBhbmQgZ2V0cyBkZXN0cm95ZWQgaW1wbGljaXRseSB3aGVuIHRo
ZSBmaXJzdCAuc2V0X21hcCAKb3IgLmRtYV9tYXAgY2FsbCBpcyBtYWRlLCB3aGljaCBpcyBvbmx5
IHBvc3NpYmxlIGFmdGVyIHRoZSB2aG9zdC12ZHBhIAptb2R1bGUgaXMgbG9hZGVkIGFuZCBib3Vu
ZCB0byB2ZHBhIGRldmljZXMuIE5hdHVyYWxseSB0aGUgRE1BIE1SIHNob3VsZCAKYmUgcmVzdG9y
ZWQgdG8gaG93IGl0IHdhcyBiZWZvcmUgd2hlbiB2aG9zdC12ZHBhIG1vZHVsZSBpcyB1bmxvYWRl
ZCwgb3IgCmlmIGFueXRoaW5nIHRoZSAxOjEgRE1BIE1SIGNyZWF0aW9uIGNhbiBiZSBkZWZlcnJl
ZCB0byB1bnRpbCB2aXJ0aW8tdmRwYSAKaXMgcHJvYmVkIGFuZCBib3VuZCB0byBkZXZpY2VzLiBU
b2RheSB2aG9zdF92ZHBhX3JlbW92ZV9hcygpIGFzIHBhcnQgb2YgCnRoZSB2aG9zdC12ZHBhIHVu
bG9hZCBjb2RlIHBhdGggYWxyZWFkeSBnZXRzIGFsbCBtYXBwaW5ncyBwdXJnZWQgdGhyb3VnaCAK
dmhvc3RfdmRwYV9pb3RsYl91bm1hcCgwLCAtMVVMTCksIGFuZCBpdCBzaG91bGQgYmUgcHJldHR5
IHNhZmUgdG8gCnJlc3RvcmUgRE1BIE1SIHZpYSAucmVzZXRfbWFwKCkgcmlnaHQgYWZ0ZXIuIE5v
dCBzdXJlIHdoYXQncyB0aGUgY29uY2VybiAKaGVyZSB3aXRoIGJ1Z2d5IHZob3N0LXZkcGEgZGV2
aWNlPwoKTm90ZWQgd2hlbiB2aG9zdC12ZHBhIGlzIGJlaW5nIHVubG9hZGVkIHRoZXJlJ3MgZXZl
biBubyBjaGFuY2UgdG8gcHJvYmUgCmtlcm5lbCB0aHJvdWdoIENWUSwgYXMgdGhlIHZpcnRpbyBm
ZWF0dXJlIGlzIG5vdCBldmVuIG5lZ290aWF0ZWQgYXQgdGhhdCAKcG9pbnQuIEFuZCBpdCBpcyBl
dmVuIHRyaWNraWVyIHRvIHdhaXQgZm9yIENWUSByZXNwb25zZSBmcm9tIGRldmljZSAKaW5kZWZp
bml0ZWx5IHdoZW4gdHJ5aW5nIHRvIHVubG9hZCBhIG1vZHVsZS4KClJlZ2FyZHMsCi1TaXdlaQo+
Cj4gVGhhbmtzCj4KPj4+ICAgIG9yIGRvIHlvdSBtZWFuIGl0IHdvdWxkIGJlIGZhc3Rlcj8KPj4g
SSB0aGluayB3aXRoIC5yZXNldF9tYXAoKSB3ZSBhdCBsZWFzdCBjYW4gYXZvaWQgaW5kZWZpbml0
ZSBsYXRlbmN5Cj4+IGhpY2N1cCBmcm9tIGRlc3Ryb3lpbmcgYW5kIHJlY3JlYXRpbmcgMToxIG1h
cHBpbmcgd2l0aCB0aGUgdW53YXJyYW50ZWQKPj4gMnJkIHVubWFwIGNhbGwuIEFuZCAucmVzZXRf
bWFwKCkgc2hvdWxkIHdvcmsgd2l0aCBib3RoIC5kbWFfbWFwKCkgYW5kCj4+IC5zZXRfbWFwKCkg
QVBJcyB3aXRoIGNsZWFyIHNlbWFudGljcy4KPj4KPj4gUmVnYXJkcywKPj4gLVNpd2VpCj4+PiBU
aGFua3MKPj4+Cj4+Pj4gVGhhbmtzLAo+Pj4+IC1TaXdlaQo+Pj4+Cj4+Pj4+IGNvbW1pdCA2ZjUz
MTJmODAxODM2ZTZhZjliY2JiMGJkYjQ0ZGM0MjNlMTI5MjA2Cj4+Pj4+IEF1dGhvcjogRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+Cj4+Pj4+IERhdGU6ICAgV2VkIEp1biAyIDExOjU4OjU0IDIw
MjEgKzAzMDAKPj4+Pj4KPj4+Pj4gICAgICAgIHZkcGEvbWx4NTogQWRkIHN1cHBvcnQgZm9yIHJ1
bm5pbmcgd2l0aCB2aXJ0aW9fdmRwYQo+Pj4+Pgo+Pj4+PiAgICAgICAgSW4gb3JkZXIgdG8gc3Vw
cG9ydCBydW5uaW5nIHZkcGEgdXNpbmcgdnJpdGlvX3ZkcGEgZHJpdmVyLCB3ZSBuZWVkICB0bwo+
Pj4+PiAgICAgICAgY3JlYXRlIGEgZGlmZmVyZW50IGtpbmQgb2YgTVIsIG9uZSB0aGF0IGhhcyAx
OjEgbWFwcGluZywgc2luY2UgdGhlCj4+Pj4+ICAgICAgICBhZGRyZXNzZXMgcmVmZXJyaW5nIHRv
IHZpcnRxdWV1ZXMgYXJlIGRtYSBhZGRyZXNzZXMuCj4+Pj4+Cj4+Pj4+ICAgICAgICBXZSBjcmVh
dGUgdGhlIDE6MSBNUiBpbiBtbHg1X3ZkcGFfZGV2X2FkZCgpIG9ubHkgaW4gY2FzZSBmaXJtd2Fy
ZQo+Pj4+PiAgICAgICAgc3VwcG9ydHMgdGhlIGdlbmVyYWwgY2FwYWJpbGl0eSB1bWVtX3VpZF8w
LiBUaGUgcmVhc29uIGZvciB0aGF0IGlzIHRoYXQKPj4+Pj4gICAgICAgIDE6MSBNUnMgbXVzdCBi
ZSBjcmVhdGVkIHdpdGggdWlkID09IDAgd2hpbGUgdmlydHF1ZXVlIG9iamVjdHMgY2FuIGJlCj4+
Pj4+ICAgICAgICBjcmVhdGVkIHdpdGggdWlkID09IDAgb25seSB3aGVuIHRoZSBmaXJtd2FyZSBj
YXBhYmlsaXR5IGlzIG9uLgo+Pj4+Pgo+Pj4+PiAgICAgICAgSWYgdGhlIHNldF9tYXAoKSBjYWxs
YmFjayBpcyBjYWxsZWQgd2l0aCBuZXcgdHJhbnNsYXRpb25zIHByb3ZpZGVkCj4+Pj4+ICAgICAg
ICB0aHJvdWdoIGlvdGxiLCB0aGUgZHJpdmVyIHdpbGwgZGVzdHJveSB0aGUgMToxIE1SIGFuZCBj
cmVhdGUgYSByZWd1bGFyCj4+Pj4+ICAgICAgICBvbmUuCj4+Pj4+Cj4+Pj4+ICAgICAgICBTaWdu
ZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+Pj4gICAgICAgIExpbms6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMTA2MDIwODU4NTQuNjI2OTAtMS1lbGljQG52
aWRpYS5jb20KPj4+Pj4gICAgICAgIFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+Cj4+Pj4+ICAgICAgICBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KPj4+Pj4KPj4+Pj4gVGhhbmtzCj4+Pj4+Cj4+Pj4+Cj4+Pj4+PiArfQo+
Pj4+Pj4gKwo+Pj4+Pj4gK3N0YXRpYyBpbnQgX21seDVfdmRwYV9jcmVhdGVfZHZxX21yKHN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiwKPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsCj4+Pj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgYXNpZCkKPj4+Pj4+ICAgICB7Cj4+
Pj4+PiAgICAgICAgICAgIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yID0gJm12ZGV2LT5tcjsKPj4+
Pj4+ICAgICAgICAgICAgaW50IGVycjsKPj4+Pj4+Cj4+Pj4+PiAtICAgICAgIGlmIChtci0+aW5p
dGlhbGl6ZWQpCj4+Pj4+PiArICAgICAgIGlmIChtdmRldi0+Z3JvdXAyYXNpZFtNTFg1X1ZEUEFf
REFUQVZRX0dST1VQXSAhPSBhc2lkKQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgIHJldHVybiAw
Owo+Pj4+Pj4KPj4+Pj4+IC0gICAgICAgaWYgKG12ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9E
QVRBVlFfR1JPVVBdID09IGFzaWQpIHsKPj4+Pj4+IC0gICAgICAgICAgICAgICBpZiAoaW90bGIp
Cj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSBjcmVhdGVfdXNlcl9tcihtdmRl
diwgaW90bGIpOwo+Pj4+Pj4gLSAgICAgICAgICAgICAgIGVsc2UKPj4+Pj4+IC0gICAgICAgICAg
ICAgICAgICAgICAgIGVyciA9IGNyZWF0ZV9kbWFfbXIobXZkZXYsIG1yKTsKPj4+Pj4+ICsgICAg
ICAgaWYgKG1yLT5pbml0aWFsaXplZCkKPj4+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsK
Pj4+Pj4+Cj4+Pj4+PiAtICAgICAgICAgICAgICAgaWYgKGVycikKPj4+Pj4+IC0gICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4+Pj4+PiAtICAgICAgIH0KPj4+Pj4+ICsgICAgICAg
aWYgKGlvdGxiKQo+Pj4+Pj4gKyAgICAgICAgICAgICAgIGVyciA9IGNyZWF0ZV91c2VyX21yKG12
ZGV2LCBpb3RsYik7Cj4+Pj4+PiArICAgICAgIGVsc2UKPj4+Pj4+ICsgICAgICAgICAgICAgICBl
cnIgPSBjcmVhdGVfZG1hX21yKG12ZGV2LCBtcik7Cj4+Pj4+Pgo+Pj4+Pj4gLSAgICAgICBpZiAo
bXZkZXYtPmdyb3VwMmFzaWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0gPT0gYXNpZCkgewo+Pj4+Pj4g
LSAgICAgICAgICAgICAgIGVyciA9IGR1cF9pb3RsYihtdmRldiwgaW90bGIpOwo+Pj4+Pj4gLSAg
ICAgICAgICAgICAgIGlmIChlcnIpCj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IG91dF9lcnI7Cj4+Pj4+PiAtICAgICAgIH0KPj4+Pj4+ICsgICAgICAgaWYgKGVycikKPj4+Pj4+
ICsgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+Pj4+Pj4KPj4+Pj4+ICAgICAgICAgICAgbXIt
PmluaXRpYWxpemVkID0gdHJ1ZTsKPj4+Pj4+ICsKPj4+Pj4+ICsgICAgICAgcmV0dXJuIDA7Cj4+
Pj4+PiArfQo+Pj4+Pj4gKwo+Pj4+Pj4gK3N0YXRpYyBpbnQgX21seDVfdmRwYV9jcmVhdGVfbXIo
c3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LAo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfaW90bGIgKmlvdGxiLCB1bnNpZ25lZCBpbnQgYXNpZCkK
Pj4+Pj4+ICt7Cj4+Pj4+PiArICAgICAgIGludCBlcnI7Cj4+Pj4+PiArCj4+Pj4+PiArICAgICAg
IGVyciA9IF9tbHg1X3ZkcGFfY3JlYXRlX2R2cV9tcihtdmRldiwgaW90bGIsIGFzaWQpOwo+Pj4+
Pj4gKyAgICAgICBpZiAoZXJyKQo+Pj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4+
Pj4+PiArCj4+Pj4+PiArICAgICAgIGVyciA9IF9tbHg1X3ZkcGFfY3JlYXRlX2N2cV9tcihtdmRl
diwgaW90bGIsIGFzaWQpOwo+Pj4+Pj4gKyAgICAgICBpZiAoZXJyKQo+Pj4+Pj4gKyAgICAgICAg
ICAgICAgIGdvdG8gb3V0X2VycjsKPj4+Pj4+ICsKPj4+Pj4+ICAgICAgICAgICAgcmV0dXJuIDA7
Cj4+Pj4+Pgo+Pj4+Pj4gICAgIG91dF9lcnI6Cj4+Pj4+PiAtICAgICAgIGlmIChtdmRldi0+Z3Jv
dXAyYXNpZFtNTFg1X1ZEUEFfREFUQVZRX0dST1VQXSA9PSBhc2lkKSB7Cj4+Pj4+PiAtICAgICAg
ICAgICAgICAgaWYgKGlvdGxiKQo+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGVzdHJv
eV91c2VyX21yKG12ZGV2LCBtcik7Cj4+Pj4+PiAtICAgICAgICAgICAgICAgZWxzZQo+Pj4+Pj4g
LSAgICAgICAgICAgICAgICAgICAgICAgZGVzdHJveV9kbWFfbXIobXZkZXYsIG1yKTsKPj4+Pj4+
IC0gICAgICAgfQo+Pj4+Pj4gKyAgICAgICBfbWx4NV92ZHBhX2Rlc3Ryb3lfZHZxX21yKG12ZGV2
LCBhc2lkKTsKPj4+Pj4+Cj4+Pj4+PiAgICAgICAgICAgIHJldHVybiBlcnI7Cj4+Pj4+PiAgICAg
fQo+Pj4+Pj4gLS0KPj4+Pj4+IDIuNDEuMAo+Pj4+Pj4KPj4+Pj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+Pj4gVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0Cj4+Pj4+IFZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4+
Pj4+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
