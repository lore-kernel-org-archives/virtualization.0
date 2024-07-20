Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1699F3D551
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Jul 2024 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721511291; cv=fail; b=LwYlWuO+lCPPz18a0y8k6/JNGIg8fqM9OjnMlG21DA9ZBNzasOPAT+LrcywDKPuKxE2bvAL077l7kRhuOFOYEeKWKia9X9/y6yicFRxAkZq4PrSDPv3FPP7RpOydZJZWKywkup+XUI2o+No+h3wbSp0S6SaCaNkwQJoQg79CRV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721511291; c=relaxed/simple;
	bh=ZzqZLb9layO7qN09iYkUohtVe/sXTHDuxTYMxO+AVJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tO1/EysDTRlDa4TBzMl6hxVgMG5v5WhUuq5VUrPc4t4Di6Fk/huHfvi0vD/i6bIIs71GtxajQFLihG8bxHxBw6EDG2/OcvRJZ7fSaaBxFIhMOAON2bn3Jg0aYOaXQu5gMLRZxE9b1Jw1grn8P0kjqFh5nlLUdIUAApAlumxfZE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WeBOpF8k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fGPo854W; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WeBOpF8k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fGPo854W"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D10D81D11
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Jul 2024 21:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 45ZG5jfC8x5l for <virtualization@lists.linux-foundation.org>;
 Sat, 20 Jul 2024 21:34:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7F30B81D0B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F30B81D0B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=WeBOpF8k;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=fGPo854W
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F30B81D0B
	for <virtualization@lists.linux-foundation.org>; Sat, 20 Jul 2024 21:34:48 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KLFWQr023627;
	Sat, 20 Jul 2024 21:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=qS14ykTu7o1hbz98vcABUqZig22VzC7tJdCEL5B8lmk=; b=
	WeBOpF8kT/mhAeaSp5Ix4BNWHwi3oF2H87BxO45hH/Fg2GWgNIm9anJKuHGJ2A1Y
	qZxXhzAr/dLYAs+MMdqAyvV3pwHXJMg/eTLtO4iAvIFTzO20V+djIB7UCeI3UVQ4
	UWp1yKEyK/CATRbjc35Gn9eVCLStniqHD860ZrH2Un2Z+PBCXrBTsFPjzhJq3gvJ
	CyGfnM/2HJREW60aklj+1E4FHz+51PLrrkdALiKO6SKD1giZsSdWEnW1JBqi862R
	M+r/eeXEScX66xuagF9Ptc+QANXPJ4xghXNoJbp66xudOk22dNUs7yDE3Ikq7BFH
	zQA+qddUZZqVE7F2mLEj1A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gn05g0bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 21:34:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46KH1drR015535;
	Sat, 20 Jul 2024 21:34:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40g3p58de7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 21:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJ1PPbd0P2pcNtdiUluuy20xW0mBD3DBPMPh1yQ4lICvhHT1meQA+Cbk5NrbTBGcRUjfFgOca3L4qYCHgNiZZiXbarnlfPGd08w5oEIpRG1RtxCNVgeJGBB0Zb15g2LrEVvK3PbVJMlYA8XbLU8Kgb3XifMa8YoH7v95E+WeKj2T6PA1PliSnzrZUVI7Qnm7t8La5xkrlyKP6/1YjoOcbgOlPid2mKhJMQ454yrb3upJpn1JvPHfHNJmiz6NI372gyNjGca/NDfFN9HegI3XrI7CE/oGYpMAHtcLNb/JiaSsEbZNGoO7h8QIgC+TD06kXAnegIWGuGyv3TMSI+uMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS14ykTu7o1hbz98vcABUqZig22VzC7tJdCEL5B8lmk=;
 b=Ahe1wrixmbN0h4Mi4295oFUpxoMZPQM3Gk9Vfzb65vYZIDo7Ln9jQR2bqCgkMYE6yFeIljPsq2hiPDebsgLKfTKLX0Crw0YKUDdi4JECWXPRlCIjBNkvMuraWctDwh/ymP7lX+zgtTSwzD4nCZSM69vBLnkifIaqyb02Mc5XgiBvLOjlWjJz8ljvybvXBZ4IaxVa08uGj+ZpHUM1mwhTOv6XKmQdqIsx/Aj36wg7/35J2wEWKpLcTgl2yFJpcaOTO4Te1JJ3IV/v/QIVOhERAz+xDcRBxRh3mO3nq3+6+SYweX1mB5i9Q2+ygwowWMoD7XnRkyblQFz5XGrm/NX3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS14ykTu7o1hbz98vcABUqZig22VzC7tJdCEL5B8lmk=;
 b=fGPo854WJwTkwch94BoOmmBkkGsgTp91Cld5dAyzopw07B56mN9A5SFS3oR5Pn1BUxr0qqBnQT2LydZ41AUCZ+gadu854iiNHiD1w0wAGxgLjMWPZy5xKPiyjU5/vYyX6UbublwFbOhE6+dVaZA9i8yeXxQAq0mTQc4xxIhWUY0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM3PR10MB7946.namprd10.prod.outlook.com (2603:10b6:0:4b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Sat, 20 Jul 2024 21:34:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 21:34:39 +0000
Message-ID: <b5f696bf-a0d8-42d4-86bd-075f97cf0209@oracle.com>
Date: Sat, 20 Jul 2024 17:34:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/7] vdpa live update
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEs9SvtW=Dkg1aU6HuFqTP5eekD1JdR2w377u3iGsOR-Aw@mail.gmail.com>
 <911f018b-c273-4983-90ac-0a8f925ab6e7@oracle.com>
 <CACGkMEv_yJ6iwOexGGexVt=EEpr2SXHJSLFcH_7g1yh=L-eDgA@mail.gmail.com>
 <bab464f5-a660-4122-886a-c348be3d95fa@oracle.com>
 <CACGkMEtpVOqsJMF1LLNOdTG+_1JBKy6yNbn12_nP=Tw0DeAZvQ@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtpVOqsJMF1LLNOdTG+_1JBKy6yNbn12_nP=Tw0DeAZvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM3PR10MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aae18f7-17d9-4220-c4a6-08dca903c27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akplT3drYTN5eW52YUdyQThlTXk4MWc0djBNbnZ0cXR5RWF2THc2L0FGRnJX?=
 =?utf-8?B?eWlWUTlIUnF5eHN0OGpUR2NWVkM1bW4rajRvTnFrblQyUkpNZ3l0SWs1YWR1?=
 =?utf-8?B?ZXh4YjlsckdDSm9aOUVvNUN0ZmVkTkhKWHRsYjk0MnFRVGdIQW9XN0pBQ0pQ?=
 =?utf-8?B?dXZCc1R4OU9PaDZRZDM3dEs2KzhWUGkyRkpzcGVoMi95Y3Bud09HQllHWkMr?=
 =?utf-8?B?TzJHcXMya3ZCTmpVdE40MTJNSjQ0cUR3ZFFXYkFMYTZoQ2dEaUJkcFRpVnBJ?=
 =?utf-8?B?S3dRdUNaOG5ZZVIyUXV5dmppdStSR01oTlBQZzBZTEhNS3NvSWk5NS9ZdkVH?=
 =?utf-8?B?OFg1Tk5pZU5UeFNqcUxqNVZUZGFZNldjQksxWkFBalNURGpPTDkrNnJ2ZElV?=
 =?utf-8?B?MzBqQ013b0thc3h2K1A3aVRnLzFMUG1BRkdHS2hxTnpWWTE4b1gvamt0RUlq?=
 =?utf-8?B?Q2IxN09lTkVJR1B6MGpGanM0TERhRUxnZEpPaEp4bVpaVnhnVW8wUFdabEJl?=
 =?utf-8?B?N3ZkenMyL2t3UGkzOTFhMWx2SHdBZWVVZSttUUs1UlhxWFA1TU5wWDNDTUlk?=
 =?utf-8?B?VFhlY0JDTE5CUGMvWVRBRUR5TnllUWtDT2NVc0llYTF0NnBpMzhhQTRiUFdl?=
 =?utf-8?B?b1NWU2dOZG54WDdZWXB5dU1yVVYrNXFTZTYvSFJpbllFa1hzb1Z2cENZNnFD?=
 =?utf-8?B?dWtKN1lIZVliUGxtR1A2V2V1VVkzMGxRSCsyWTdEbGl0Q1A1L1JaaGdaVmdn?=
 =?utf-8?B?SHUveWFWZ0lody9MdmNCdkM5VTQybi9WeGVobFBpR2xNWjI5NTNOYnJQL0wr?=
 =?utf-8?B?NVp6aVBQcERhN3dlOFZiYy8za1dTb1ZZZXRYNDU0T3l0ZU9mOFpBZEkrQWlB?=
 =?utf-8?B?U1l2N2s0OVVhbmZUVDhoVW9GTTIrSEN2MEs5NE42eUNVR1hjZzJxZERKekR4?=
 =?utf-8?B?NmhWRStRZ0Jmci9meEFsR01RRnh2YVFaSGFDQjgvOEp3ZFBQVi9TblIxMk1x?=
 =?utf-8?B?dHoxbTdTL3N4WDdZd3dTbGgvOEZIS1pxWHh6TzRUSGtMczcxUjYxOXVHK09W?=
 =?utf-8?B?dzRrKzh3UXFhMWJFLzZEdm9MRkUwSS9CRXcyTVpXZGxUS2FqNk1ZRXdsUWFt?=
 =?utf-8?B?Vk1ZelRhTXIwd3FGbmtON01BLzFQcEdFclJlTHluSXBIUFYzb0tKQWQyc3lj?=
 =?utf-8?B?Y043MTMyUVk1YytjeGV2cFNuby9vWUxwOWthd0VBaERNYktCSm1lRjAwNmov?=
 =?utf-8?B?RHl5bE9uUkdscENCYml1NVA4bHM3dWhxc0RpVnZGMXZneERHSUdybU1USWsy?=
 =?utf-8?B?N05CMTQyN2daUFEzQ0R2TFZJQVgxVXlyNzBzblVWWk1xY1lLdTNyekFiNWVX?=
 =?utf-8?B?Q281RXBXRHJETTdTUTArYm94enBQbXc0eHlsWnpGcEtYUHNYRU9pZHhaTEdq?=
 =?utf-8?B?U2FuY1JubkYxNGJDSG1ab1BoVGRVTWpycXhGYUFIOUJPSC9tTG1COHdsWDVI?=
 =?utf-8?B?d1hOejNhNWFhNXVDc1ZKL3FENTdlbG94K24vWk5TWDRRM3BYYWZwNGJsMGpx?=
 =?utf-8?B?NnFPTmJaZEJLeEowQkkwc1BuODQ4VUVscUNpQzhwMGNQQXBXdzRiQ3NNc09T?=
 =?utf-8?B?UnpvU0RBVjlaT1I4NVhvVHpQR2hjRU9hSWI4cGFkbVUvTnRFdzNOSmJuVmNw?=
 =?utf-8?B?alc4RXc4L2pmbGlONzA1OTNrWDdlMElycHNsRTNvTWNvanl2SDFmTGRPQzRk?=
 =?utf-8?B?b1F5YjVQbmRRS2NCOFJPOHRIVVlabmdQUkorcHM5bFc2dHlpVDNheGpNSGRG?=
 =?utf-8?B?RDYzMzVyZytoS2d5TUxmUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlNlY0w4S1ZoUUVBb0R0cmlmMkNrUm55dUtscHVPVklzamExRG1jNWFTT0VZ?=
 =?utf-8?B?WE1jUEF6Tm1NWlcxV1ozb1pvTmErSnF3YnJ2M1c3ZGZiSy9WcHQzb1hhZ2gy?=
 =?utf-8?B?bGp3UVFwakhHLzhEcEI4VWl5WlhqUHNscXR0enBDMWkyRVdVeC9XQjBpVVky?=
 =?utf-8?B?azNtUEdZK3hhWXUxYVpJL25ndWw5emdRUldmMytDVmg4dDBrNm80elpmWkZD?=
 =?utf-8?B?b3phNGV4K1UvdmxnYjlHU1hUZzMySUJNdXkxT0hmT1FIMzhyVlU1dVdydFRG?=
 =?utf-8?B?V2oyamJsQ2FpK2RvV3d6eklCczBrTkZQYjRndkhwbGdRMFVRL09zd1NEa1NN?=
 =?utf-8?B?VUExdkwyTXZ5YXhyVkU1R1d2MEd2VEFIemt1UCtZRVJMcTZVY09oZ08xVWtw?=
 =?utf-8?B?TENwV0tlM0ZpbExxbm1RbEU3eC83OGw3OSthNXN3WVN6QnE4QWlrSDZYQXdx?=
 =?utf-8?B?NktlTWxqNmsrdkkzS2c0VzVXcU1lRXdvNEprV0Zla08wMFByK0R5S0hObktU?=
 =?utf-8?B?TkhEelpEOG50Z0VrNmJJeWtGbzZlbTJNRHYzdW5COCtvVm1zTDJiTVo1elNT?=
 =?utf-8?B?NkQ0WWE0TG44S096L1o0OWU1QStaeXlsV2toVkUxYTJVRTg3a2VJRVcyYWRl?=
 =?utf-8?B?MkhGK2plS3o5V1N5dTdHOSt4czRybTFWVmlvUG9hTXVFS0lEQ2FTdTh6U3ht?=
 =?utf-8?B?QkozN0RSb1dpeUFXRTJoUXBrZ0VJTlgrUTIzRkRtSzYxdVFVNUFXVDROVWNy?=
 =?utf-8?B?SlkzY040UC9sQ1g0dHRXRUR0VS81SlJ4OEp4WlgzS2hjUFBSakZ2eTBEYjdB?=
 =?utf-8?B?WnM3SGxMT3pPSzZVTndvNURjRlVuR3hkS3FkWGNWQ2dFdVRiVHBRbFhQQlJX?=
 =?utf-8?B?dWYreUwyY1paMGFqVTI3ZkN0OFM1RzZrQUtDREZIZTdFcDl2bFBMQ0ZTSVZI?=
 =?utf-8?B?LzgzVnMwNGtteHR3aDE5TXhXTzZrMVprc1FlYllWSmtsSFp2bzE3a0M3UmI5?=
 =?utf-8?B?ZWhoRnhrS2Jub09mcGdEdFRxbWVVdnJ6V1NYbkpLS0t5MkN1R3B4OTQ1bitP?=
 =?utf-8?B?M296MzFXSjdZTXV6OG5rdHZrN0V2K2cvM2E2eWVobkhmNTJOdTZmNUQxT2Vq?=
 =?utf-8?B?cHpQZTRmY3NQQkpoai9ZQU1IZ1FkUjRIemNEamxNSGpUY2NDaFFzMFZPbmlK?=
 =?utf-8?B?Z256ZlZDbFdUMzI0WDczWXpEZjZDeHNLeXY3eFRaZDFSekpKUUdsSzRRZDB4?=
 =?utf-8?B?THVVREdJL1M3VXczYlFlU0xDdEJYVGM4Smw1N0VPZDVtbzRab3Z2TjFjVmYz?=
 =?utf-8?B?c1ZsSGMrM1ZmTmkwSE1Rcy9saVBLY1d1VlJZdk9oRGNZQjFxVzA3a05OVFMy?=
 =?utf-8?B?enZGdXMyV1lrVWxWTldpTDRvcnczYjhOYVlwOWJoUVV3ZDJyb0FOVURhZmFs?=
 =?utf-8?B?M3Vna3hjZ01mR202RDcxZG9wZFpZTlp2RmJzSFBUSHlrUW1qcFhhRHZ3azUw?=
 =?utf-8?B?Sy9iNitBcUlBK1I2THRaMG14cXRqMEk5QmNBcTUva0Q3cTdJUFFkZHlnL2pP?=
 =?utf-8?B?VmVSN0RmdnRSWUxXYkZ1aytPWWt0L3BiYStCLzltbWYyakdjQ0tEcElqNHF1?=
 =?utf-8?B?YWl4dVdkTWJkVi9rUHdESG1ocy9SbWJqeEtFbEE0WEJaUVdtOXNqc1hPWldu?=
 =?utf-8?B?SXd0aGEzMTNyY0pUdFZ1cExpbnF1bkEzOFQ5cXZhdlNOUUJSSHJRTGw2ckJT?=
 =?utf-8?B?OFVZamI1VmxDR0NGZENjSHJScU9rMVEvNGw3QXY3M3RPc2FpZG1zUkQvbDNz?=
 =?utf-8?B?aG4rS25FUWJER3JFZHA4Zlk4b3FsSXZBRUN6bmIrSHp1cG0zVURnN0lzT1Y5?=
 =?utf-8?B?SXdHQ3V5YzI1NFVwUGMxNGZHQXJUbnZ1Vmd6NnlVZmhWam5CK3QrMHNQMHBa?=
 =?utf-8?B?ZFZnLytmWnhIb2dyMXYwQjlacGxBeXNUVFNxY2VFQ0Nia0t6ci9tc3VTMFdF?=
 =?utf-8?B?VGlyZlZRSEQ1VDFMM3dEZ2lKUmI5K3Z3OUJXRUNGZjRTdGpEV2IrZk9pdmFr?=
 =?utf-8?B?bmdpRlBNVDRCZ0kwZTNHbDBiUGtEbk1WSldDdTBQNTBBTlNDQnJFdXZHNGtK?=
 =?utf-8?B?dnU2enp0VVlWYzQ1YjRmZittYlkwK1B3UW52WW9GOE12TVVqekVITnNValRD?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kKcwrlz0XUDBS75n7Ch/dRnWBhy2Nwo/wH0dvZUHQNGDhyIZDPFhj7MFBpmU2Kt9Gh1DD7FMN5+UaAkBuOpRee0Jua+XBd5MkKbwdMNW9oiFy0oaG6BRGE76A4JSUqiHuMwwE5am3VCD3EvMI5bxSEwsD/BFoF5hJ69KG/bZOMtGSzP5pt//tZUBY3M0pEsf9pi279ZcE1LciN4K3bpcNV7bHxg/SlWDDbxXxq0A5fyD4C/DLXbML/oDsFcZbjSg1RdC87VV+n/FCTIrHtbgbGnk+jgWHvnrU9UbApVG5+ep1IwAU2b/tA6MSBnO2+Vlmzib2Fbjg1xEbyF35LEBD234in/NER6OcNs2SB/U1rx2gjDgUOzogcpe/hnb83wdnpTpw5OiMzbeEaYBxwAXcMCmvW5deD+sFsb4v/IB5Zd0jTedD6Ar7xTZBCgS/6LlGvx/PbElMH6cDxy/FKWUjfP2VofbY4Icu6CiAzjFY9fFxWaFfB9EyhQ94AFBR20VIhQrCNVI8XSu6LiUq5oibbDMZkpg80Lsi/tgqjYkFqDRZGTBFl7T1GLlojnE1pH+cX4QnWweTM4GQIUW9GVztfmvVH+CR2mLW7sdkAk3uJA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aae18f7-17d9-4220-c4a6-08dca903c27b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 21:34:39.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyw4hvnR2AQkTub3zY2LLJkvwtK3h9Ufxe/z/yowbrDwCCydNtTCMNbhkkHAT/77KfQ36UEDxSG0lpzYR5QEor/WuavCVKzedhs9xQmlxPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_20,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200158
X-Proofpoint-ORIG-GUID: JVe4d3Z0L86ooLmZHt7X8oPTLjK-U-gW
X-Proofpoint-GUID: JVe4d3Z0L86ooLmZHt7X8oPTLjK-U-gW

On 7/17/2024 8:33 PM, Jason Wang wrote:
> On Thu, Jul 18, 2024 at 2:29 AM Steven Sistare
> <steven.sistare@oracle.com> wrote:
>>
>> On 7/16/2024 1:30 AM, Jason Wang wrote:
>>> On Mon, Jul 15, 2024 at 10:29 PM Steven Sistare
>>> <steven.sistare@oracle.com> wrote:
>>>>
>>>> On 7/14/2024 10:14 PM, Jason Wang wrote:
>>>>> On Fri, Jul 12, 2024 at 9:19 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>>>
>>>>>> Live update is a technique wherein an application saves its state, exec's
>>>>>> to an updated version of itself, and restores its state.  Clients of the
>>>>>> application experience a brief suspension of service, on the order of
>>>>>> 100's of milliseconds, but are otherwise unaffected.
>>>>>>
>>>>>> Define and implement interfaces that allow vdpa devices to be preserved
>>>>>> across fork or exec, to support live update for applications such as QEMU.
>>>>>> The device must be suspended during the update, but its DMA mappings are
>>>>>> preserved, so the suspension is brief.
>>>>>>
>>>>>> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
>>>>>> accounting from one process to another.
>>>>>>
>>>>>> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
>>>>>> VHOST_NEW_OWNER is supported.
>>>>>>
>>>>>> The VHOST_IOTLB_REMAP message type updates a DMA mapping with its userland
>>>>>> address in the new process.
>>>>>>
>>>>>> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
>>>>>> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
>>>>>> require it, because the userland address of each DMA mapping is discarded
>>>>>> after being translated to a physical address.
>>>>>>
>>>>>> Here is a pseudo-code sequence for performing live update, based on
>>>>>> suspend + reset because resume is not yet widely available.  The vdpa device
>>>>>> descriptor, fd, remains open across the exec.
>>>>>>
>>>>>>      ioctl(fd, VHOST_VDPA_SUSPEND)
>>>>>>      ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
>>>>>
>>>>> I don't understand why we need a reset after suspend, it looks to me
>>>>> the previous suspend became meaningless.
>>>>
>>>> The suspend guarantees completion of in-progress DMA.  At least, that is
>>>> my interpretation of why that is done for live migration in QEMU, which
>>>> also does suspend + reset + re-create.  I am following the live migration
>>>> model.
>>>
>>> Yes, but any reason we need a reset after the suspension?
>>
>> Probably not.  I found it cleanest to call reset and let new qemu configure the
>> device as it always does during startup, rather than altering those code paths
>> to skip the kernel calls.
> 
> If we care about the downtime, I think avoiding a reset should be faster.

Agreed.  I want to try it some time, but I think what I have now using reset is
decent enough for version 1.

- Steve

>> So, consider this to be just one of several possible
>> userland algorithms.
>>
>> - Steve
> 
> Thanks
> 
>>
>>>>>>      exec
>>>>>>
>>>>>>      ioctl(fd, VHOST_NEW_OWNER)
>>>>>>
>>>>>>      issue ioctls to re-create vrings
>>>>>>
>>>>>>      if VHOST_BACKEND_F_IOTLB_REMAP
>>>>>
>>>>> So the idea is for a device that is using a virtual address, it
>>>>> doesn't need VHOST_BACKEND_F_IOTLB_REMAP at all?
>>>>
>>>> Actually the reverse: if the device translates virtual to physical when
>>>> the mappings are created, and discards the virtual, then VHOST_IOTLB_REMAP
>>>> is not needed.
>>>
>>> Ok.
>>>
>>>>
>>>>>>          foreach dma mapping
>>>>>>              write(fd, {VHOST_IOTLB_REMAP, new_addr})
>>>>>>
>>>>>>      ioctl(fd, VHOST_VDPA_SET_STATUS,
>>>>>>                ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)
>>>>>
>>>>>    From API level, this seems to be asymmetric as we have suspending but
>>>>> not resuming?
>>>>
>>>> Again, I am just following the path taken by live migration.
>>>> I will be happy to use resume when the devices and QEMU support it.
>>>> The decision to use reset vs resume should not affect the definition
>>>> and use of VHOST_NEW_OWNER and VHOST_IOTLB_REMAP.
>>>>
>>>> - Steve
>>>
>>> Thanks
>>>
>>
> 
