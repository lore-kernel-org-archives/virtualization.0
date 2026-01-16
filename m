Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFEE393419
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589332; cv=fail; b=Ier0iyCiBvsbDYiCX+QLibmLVdktpQ4wYWD1fDyBfeoy8kNrnvAa1bcU6rQfdENTVIQKtdRU4cUYlI5ZhZt7hNWcJqnQY1y6hst+PWSq8mtHeQI8p/EWDhYn6OnOTjf/OsFIH4gx1WB1IdeGjW3hqOppiyLX+lnuy+zgg2CAomU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589332; c=relaxed/simple;
	bh=KUa+z+3DjWjR/5RTLEZBCnhvfNb04KtT9U9igGV9080=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oRni0bYJiPO1izO09X+z00RSEyD1lbU6wNeyjLa16geIgLt9zRWjQhgXviF/PE5pQIAjEkGQT6OYzsv7OmNTchXmgB4isMO/m/oP7ZLt6UhQsYW231p23jxK41LKoSE6+sNOuLY3OuTcFce+7G79q1AJIybEtYv764sQ+ErSLcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nui61axG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TryAX78e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nui61axG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TryAX78e"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GDRdc31656281;
	Fri, 16 Jan 2026 18:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=P1ediuAG/YYMgEr2zVPQiXdf3kUq3g1o3pZPsTx7HDQ=; b=
	nui61axGW6Nn9zX5OKJiyGg6DUD/vIdOh3UlOsxKsxvOi1UUIxuCJ84TglnaBru8
	qS5gKECD39d3XLM6qDCUDyLEVsYO6mBDIFU7fjOe7hi8mgDPb+Y3p0/8C6m5io2g
	zaDwKbmRw72pdqhONfuq8lljPRCPs55FZcgVqU/L0sOvrsbssN+bcEIKJVRmkhgb
	iXPQfOpxz7Cg+rzbzpCr6SGMkRnro7VyEZAe8pI04zNNAS+feDUHMwNGuN8NmjFO
	8tl+HbiEX1AQh7FD0uyT45xlQpWF6ZtHLMIxXrQPNI55lJRkaCJ69RhN7SaUvNyX
	I/cGYhsuTN1Tr4lacJjI2g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5tc5st8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 18:48:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GHaujC004253;
	Fri, 16 Jan 2026 18:48:35 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7q1k1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 18:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTLVWd82r8dBaOZuhCItMno5IKrO7+KnhXLkXglVeAuXcdE8t8dhgH0Khf0pEhx3l8PeWU8YKIkd/ZWb3K3a0dZUTroxHhfeV1F6zw+eDrIagvPPv1+AyAwj2KA+cNsJgwiCq9Xesou1Uy3Rm4C1OLOvKFFDxON7MfwIFS1AQTbI1EcLij7uynLFlOx2/LfhAD7lH90g9sK07+LXAsXovhzv+m1d8SqliS/Ct9nK5kr4B4rm7DRU/uAv+EU3ohxheJXuouXHD59xOpgp99uFdFAFIaDlqphiNol+sJJiCEfO+CQSpqZxgdfOO/kLhlXprrRGV59iU3XyhvkbGpFamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1ediuAG/YYMgEr2zVPQiXdf3kUq3g1o3pZPsTx7HDQ=;
 b=A+01VSbLjoUMaOl4CVc9oxFnwWHXzAkzpmYSy6J8Cb4a7UUDyMKrr6fD2oUOAWnuH/wbMdi5RN4B65ixL3lT+4REkerSDrSxqjpBGip+1XjgwCbUgIeCMWw/gR69Aq3IUYpp+JpkECFAOeYXXetRxr2c40tiz+tyFafVHDF8BY7chE10K9sd1QaKukroEZ1NohdNK42ZK/CMf/+V5snNMz6wiXAA8VTvZ2f0q0N+bQU2nxAwEbUOigF4F3gsDLRjz5OQT+AHOOgz2ziz7APR3BPLPJgsaMlxo873VPeyfSRwbTBhlBBCwBcuIT3vp3iQG7HvQ2AAIAnQ5IgkOsuxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1ediuAG/YYMgEr2zVPQiXdf3kUq3g1o3pZPsTx7HDQ=;
 b=TryAX78e52UrL6/a2ImLAd008GjYq9b1dMtuXhEwxjaXUuPRSqRluINUqJmDJgnBeqcbNpMRMc6ZziNGDLieJQ1j/2ZsgsiABZ5Ywl1vo6FxvwRCGhROz1MMTZwmbb+rQy97blUwZ0FqxR3lQ/E565u8wX5pKcReoGVHrkWyHr4=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CO6PR10MB5603.namprd10.prod.outlook.com (2603:10b6:303:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 18:48:30 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 18:48:30 +0000
Message-ID: <a9d2b05d-8c94-4767-b4c2-a2d3c36e1ff1@oracle.com>
Date: Sat, 17 Jan 2026 00:18:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/13] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
        jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>,
        virtualization@lists.linux.dev, Yongji Xie <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <20260116140455.1560491-1-eperezma@redhat.com>
 <20260116140455.1560491-12-eperezma@redhat.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260116140455.1560491-12-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CO6PR10MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa61dfb-6b4b-4fda-66f1-08de552fd7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUZyeERNLzY1N1FFeHZUWVVSWEFzR0hDNEZ3Nld5cnJnUUI5a3NKM0tUbkdG?=
 =?utf-8?B?QmViYWRNT1NQQjBBdytWQTZ2NXFHZEV4eE9aNDhucHVJNXczdExBN1RCUVRq?=
 =?utf-8?B?c3IyMWJ2S3I3NWpjSVpZNGVnVlpiTGtLd2VzOUZRMlpPZURTNjZSb0xIbkZm?=
 =?utf-8?B?M0dHaFBvSDRLbmRyVkV5MkFkNU5DNW11WUpqYTE3alQzajhWb25TMWlYdnR1?=
 =?utf-8?B?dGtYVHNMOUtqRUJvK0hVMWs4TDBXYko0VGEwQlk0YlRId1BrQkJJdExwdmtp?=
 =?utf-8?B?SkdGa1NVTllaN3UrUTBHOU5TQjI2bE1XVG0ybmZwNWJMS0d3cDRha2hIbHRV?=
 =?utf-8?B?Zk5MYjJCVlA3eFR4WXQrY0VpK2RPdDU2RHltQmg2VFBTSFM0ZkpFMmU5Tkgw?=
 =?utf-8?B?ZEszN0pEUkcyYTRHVlRyaHUxREtxT3dqSmllWCtyc3dLSThEOHhDazFNOGdH?=
 =?utf-8?B?ZHBNY2hwWHNER25hbmRGV05pU0dRT0hzTWRSUlZlQmV5WmtYRjRhZHd3RnZ3?=
 =?utf-8?B?RDFFL3VrSEkvU0lITzhYRU1yL2kzbDZXVFBQQ2lVbTZJbEtzelFkSDBtalFM?=
 =?utf-8?B?WEUxS2dpWEVBRW5neklLUlBEc3laY2JpQ0JIdTZ2V3haZS85VERwRjUrTkwx?=
 =?utf-8?B?LytIbUhWUnpodG5JaWlBekIxYTVDV2N1bThYNTYrWUp4ci9LMVBzb0VpSWlL?=
 =?utf-8?B?SnZJaVV4YVYzSnV4Q2R0WnhxRWgrSVRHSmtqZUtQZWl1cm16b240dTZUVWV6?=
 =?utf-8?B?WTh3Yks2V0g0ZDYrY2RodEw3SDlpWTExNmZ4L0QzdzBpRGJOT3FsUWVsNUVx?=
 =?utf-8?B?eXdUUzNDb0lMNlBwVHM3c2hkZmZoTThIbExWUWx2YXdQWVVkR0hrK1I4aHRB?=
 =?utf-8?B?dS9pR3YwTk91NFZZN3l2WUhPZUZ4NnFsdmVZc296YVIxOFJiRHJVVmNPcjc3?=
 =?utf-8?B?SEx5VythV2R4THB2eDBIKzBTby9LOFdyQ2oyV1ZzYTNkUmZzaFBSNDd4WnpL?=
 =?utf-8?B?WnRzdWpSbWNwZ2x2ZGpUMnBXU1hIS2c0azdQbGxtcjR6OU95WGxoTjY2U2Zx?=
 =?utf-8?B?QTRoN3RtVlRNT1ZkaDZCNXducTN4cUpTNDNDUWdhZlRZVDFCRzAzU1dZMUhJ?=
 =?utf-8?B?WjNuSmRvK2hyM0YzbWFRR3hHSEFYcmxuRkRNbFI2eWl6ZmdoVUtPblI2SmQy?=
 =?utf-8?B?MXBXdmVsOUxUM3k4WmF0S0twMUdHRURZc1Y4SkRtaVBtQm1Sdm5jbmM3a0Jq?=
 =?utf-8?B?VE5JTTJJM1ZmckdBVFQzOE4zNEFtUjZXWmQxdCsyUlpJS2RReTFGWm5VdUt1?=
 =?utf-8?B?OUNLZnFXQXNOeGRtSFBiYjdFRlg3TkVEWkwwcnRCK2VpUDVOTXkrZjUzRWlO?=
 =?utf-8?B?c25VcWZRd2V5ZlhzZkZTcjVJV1hianlyanNuNzZBTVJ1V3RtcmtUV2tvbFBp?=
 =?utf-8?B?Zi9TZk9WdHo3NE9BQVlLTnNVTkRJUlhPU1Z5WlVadVhDTDhPdytCZGhyQm9s?=
 =?utf-8?B?Szl4ay9ZZDhOV1U5S1pSb0hYQlJzVFFvY0tPcHFlWkMvSElqRzFIdHNxVUg3?=
 =?utf-8?B?SjRLLy9USm92V21PalVCMVloTnhyeXh0TmREUHBRNnUvWGZkVTNXUVo4WjhH?=
 =?utf-8?B?KzRFb2tMVDA2V0cxN0ZoU1FIVS9YSG9mK2Q0NGQwK3hLZW55UW53ekd4NGRn?=
 =?utf-8?B?cGthUlRnYnhFOUw4TWUrdGNXYThUQ2h1RzZRWGNuWnJjMjIxR2h0ajY1Z2JW?=
 =?utf-8?B?Ui9JaTdqanRleGpXMWlMK00wWFBDUVhTRkZLV29zckVBV2V6ZVV6M2EraUo1?=
 =?utf-8?B?TDdPaUw2ZGsydGNDNzVJNllXdnFlZi93L2R0RWNXejk5Ryt1RW5OK2NnYkR3?=
 =?utf-8?B?b3JqbmZBTkV0RjZmTFQ2L1RibkI0WnZoK21aeDhxQmdXaVRmS0doRUVoSmc5?=
 =?utf-8?B?NFgxcHl0b1JYUlJHSUpFbUU3UkdJY3p2ZWxOY080Mng3SVZ2T3VmRFNFTjYv?=
 =?utf-8?B?bTM5U1BESHRkaE5yQnM2MTZaTXlnRFo4ZXZtWXVHY3VsSGFvOHR4SG5ZYUJS?=
 =?utf-8?B?VXhVVUc2aHhtRmJpRFBDSzBtQXdJdVY5d3hpQWdSMm5wQ3N4a0dWQ0JzNnBt?=
 =?utf-8?Q?xQgQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0xwTGJUYXVtZHU5S3g4NjRBdnltN1JNazd2cm52UDd0S3B5M0g2QXZFSjhx?=
 =?utf-8?B?blFEMGp0SDEvSmcvWDg2aDhtc0Y1ODUwZEhXK1FHWnVjZCsyc21EeUwvY2Rw?=
 =?utf-8?B?SUsxUHdUc0VNaUFkOFlsVFNZWStoSk1DcUpEQllhUTRvRUNhZm93RWJKbHFO?=
 =?utf-8?B?eW1paWlWOFVWSkwxNW5tUW5NTzJ4RytSVzU0bjE2L1BmWmVia2toeTRmYW8x?=
 =?utf-8?B?OHJ2d0JENTZGKzhqdHlNWUY2eXBCSmt4UmphK0FpNi9FYk1PL0Q3VEZxd2Zp?=
 =?utf-8?B?N0ZDcUVKUUY2OTVsR1QwejhjZmxyWmlDYnIvSDJab2pBSmRwSkRtazhqTzVL?=
 =?utf-8?B?MXJuYkJpMjFpc0pOb3N5Q09FS1FqNDZjZmpkYVk4ZHV2anl0ZmtRdHF3Y0cz?=
 =?utf-8?B?bDFNYjR0S1RhSkF5YlUwS3l3WEpIaVpFSlhJUjVnMHNjY2tObmZ3SzRDczRE?=
 =?utf-8?B?ZVI4dWpjWHJyQUFVejd1U2p6alhCVVJnejdwZUNjazFtNmNzdTNFQjJaeXdX?=
 =?utf-8?B?TzZBQ3BDQSs0L1hlTkN0VlFNYlZiRWd5TDV6WnV3dTZuamo0eWg4UWxPSEx6?=
 =?utf-8?B?T2VDY3R1YVBvczZ5V1VZcElUdmxGeldBSU5LaWdJM2NmUm9NWnEzZFdqTkdJ?=
 =?utf-8?B?dHJzRzY1M2NlRzF0UTl4TzNVOFkwZldTNjJVa1NNVlRnUndyYXVUdi9BY3J6?=
 =?utf-8?B?N2k1R1pobHRrdTVHQ203TExRTUxpT2ZKZ3FGY3l0SGF1TjBKMmpwZWZDd1JE?=
 =?utf-8?B?K1VYdWhQbUo3V0IvOGtPYWdHTkJVVmlHTlljaVkzb2xxMWdWa3owZjRlOXVS?=
 =?utf-8?B?NUpvU0NmREl6OGZmbEVqRmI5ajNYODRNdjJRNnU3aVFpbXhBNk5zVkZhdkpC?=
 =?utf-8?B?ZmtSblVPL1dtb211MlpkdEZneGVWMEtoaGVXeVJrZTN2UjRZUlZRL01mQkFF?=
 =?utf-8?B?WkR1c1M5S3B4Mzd1bDVwTUdyOG9FSEtlRGdpN1RlRmFvTmxXY0xwS0U0UktZ?=
 =?utf-8?B?SUJIWmc1Qjd3U0ZiUFhsOG4rZ2RUb3duc3dHTDlINjY1dmwyNVNkdnJ4aHVZ?=
 =?utf-8?B?UzgwUytkSFBGVFBYdldOMDhFZmFiUEkya0ZkSjBNQnVJR2kvNVRwaUkvTFZL?=
 =?utf-8?B?Y2JveUpGLzhZL2FvS3hrVFJZUVg3c0lYR0t4bzA4MDNzcDYwR3JLblNDOXN1?=
 =?utf-8?B?VWJCN2RkcFZKbmc2MUFyOS9VNVEreWROVzJ2STkrZ1Y4L1JwRk1TUmNReXdr?=
 =?utf-8?B?VmFXWXRHN0NveVRSajJTWXlrSHRGRWFTcXZjWGwyZ0prUEtjMjhzYWhpRHc4?=
 =?utf-8?B?dnR0RndVVkZ6YTUwTzF3TDRNZW1rUHlSeUlGOEVpVWJYb3Z1d2FRbFhlMDRo?=
 =?utf-8?B?Q2F3dVVETHhNVWUwK21RVkVJNFRpUHFYeE94QVlwRnMxNERGOHJpV3FycHBY?=
 =?utf-8?B?TVRCQ2xTbFdqejRYQ1kvekJwdHN0eXFPSFdZQVluWWFQbFJvU2RkZE9kVk9Z?=
 =?utf-8?B?RGREZ0dxWUlxeEdJZmRTck1iQUJnSnMwQUdWWHVRTlpZaEtnYzJQTXpML21H?=
 =?utf-8?B?dk45QWxtVzlTRGp6bGcwSkNPTkgzRGVQSFJFc1JoQ3dyZzIwQnA2Ly8rNzBW?=
 =?utf-8?B?WE9iYWgwWHNIMEtXMmQzQzA3NlNTMktTMGlMdksvZ2Z1UjQxTEZlWmJPb1Fy?=
 =?utf-8?B?UDM2bWhWTGxURWt4b3ZGb01IeE9qRGM4ZlRML0RQWWRBOVNWK2VsTS96Y0tB?=
 =?utf-8?B?QXorUkxqUDJTT3laQytRNXJ0ZTFkS0Q5MFRWR2V3U01YMTBiMFlqekltYTdj?=
 =?utf-8?B?eThob3dDOUlXZjFRYUkzTmdIUm9aeGNJVDNhZkJjUTVGVkpESWlDYTFRMDY0?=
 =?utf-8?B?Ynh5UmtiRjVZTTltVUd0VGpRNzJocVFsRmVTdkpMR1p0cmtoTW5ObnkyVmUx?=
 =?utf-8?B?RkJUZ05TWTRpbEMyV3J3Qk00ZG1SQWhpZEV0Y2lNRVlxUnIyeVZYUnlUSDhh?=
 =?utf-8?B?SkUvSG14LzZqRGtYY2RoWmpwbnc2cUVCb3RuZld1SGFIVURhOTdaaHF0ek1x?=
 =?utf-8?B?eDF1VkVyMHd0WWJ0MnFKNHpaYnNKNVJyWXdHK0V4cUovdUY5YlN2NWhrMDRq?=
 =?utf-8?B?NVE2QUNMdC96L0J0VnNRNG1vU0gyaThRWHZ2aTVlNWpzdFlPUFpRdDdMOUQv?=
 =?utf-8?B?dnNOYWtCQ2prNW9ORkhFVHd2OWhnd1Y1aE5OcythZXo3Q094a0thNVBOR3FF?=
 =?utf-8?B?aDlHRDRnNmg3ZHhVazV0MWgyYUVhUDdPYi9mRDBBTjU4TzZYbWlIM0kyL1pr?=
 =?utf-8?B?aW50R1FiblgvSUZ0YUVQdHoraHJIMytQWmh0YlZaandkWHpuQmtSS1ZOd04z?=
 =?utf-8?Q?Pq+Pxy0dqFlvhEgQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xtu6XrEUTGaKNTMB7deC1HYkBo3nBRmLVTOsza4OJdEY6b3zw8Yducue2zz7ECQIN/gHJ/qAv2qn8zBZeZX1u89dfBBMCJ7WXrZxh+68InEe8HIjeTHS5caMK1RSvs2zjUn41sCJO0XKen2jsVwdLVRJ437jJ+bgvEyHk7Qx33WHZ01ePPHWnvS4jIYc/nVKPJ8R7BERRkZyGnvsJENh6Z96lmDxqyL8t3nZnVIAKgEzz2+WgXQBKz3AnIj/O/T0o8G+AoR1u6YTjZd6WegSTk8TNOUXL/E+rrtQjHIbrBISx7iSkG+fEP3n+Cv8TfO3Ws2YUuywIP7Sob73OnNeA6xfqi/64ygPRgBO8ofxxLB0Qq7vE4lPbgAsBNQxEy2njIQAvqen9SB+UQrR5BgDlCQkWfM73lpvPtl/J3CNxfPAtdmeJuqIHXSKxOtuwt5EmUnN80FDQA/FOupwxkshLkrn8rLIk80rvoUCQ9T2sJ1Mjl32zFAzPx//VOSA/9Bo8szVH6EwdPl6xG9uCJysIdpBkiJsfV0RvI2j2j8Os/vdkGeirRmvnR9ZpzW8KwOJqrjIuvYoGTpcfi3yN8XJSPvaFfgG72FwfZelfCz3f6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa61dfb-6b4b-4fda-66f1-08de552fd7c2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 18:48:30.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu6PnP2K8HsljQYoKb4m/grwve98Qocgq4SI8X5Vler7ULY7PtMWMgrJqCA8WqT3NBYJhaZmOrLnvAuRpbKgbMwQGYOrWX//M89/RnTD+kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601160139
X-Authority-Analysis: v=2.4 cv=XP09iAhE c=1 sm=1 tr=0 ts=696a8805 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=K8g-fUs1_QCnL5mkQAUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12110
X-Proofpoint-GUID: NjiY0Dkcb9qO4T23nT5nbDqzCSo3Gws3
X-Proofpoint-ORIG-GUID: NjiY0Dkcb9qO4T23nT5nbDqzCSo3Gws3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEzOSBTYWx0ZWRfX+vUzZ/SkNyUw
 fL+KrAvmtIMFk/4Qd7LtrYorRV8qt41eMSoYd2HV8Jc1RJteLUnEyrVtMQLf4siSZMDLLK906Rk
 CW3nqckr0RJ6y6FU6ua7/8u3G01mFSUf35DjaxPO6sZBtErcXVhTAEuUbX/N7wTN2myjM532I3i
 E77L3wwMoDo7eutvOFw6FHfivwo+P3PJld4GZ/fbWA11uvXvD7g/1phEAcbS+ROIQ9CaWzhAbHr
 A4koMC3SHJmOItY+XKmMsC75OMDKj0VbEVlVgIgtw4TzdhC6fky2f0VrrqigC6q4xjoH4dtQ0SU
 oCBA2joW6K5zJOWEqJEzLoCDmZMhqAEwW8MLsK2E4polNvG2GBHv8xYE8EV1H9DMkdprGQB6KDh
 ootzP/9qGujZIPX1CtI6uIbG/bivV/8t88fmvTASAYhBlNcCTDVtOLzON4/uWluyPwRv/Zf5EIJ
 Yt7NILlRuRj0eBLF5xzXWJzCHpzh3LXrh8vFBGVI=



On 1/16/2026 7:34 PM, Eugenio Pérez wrote:
> +/**
> + * struct vduse_iotlb_entry_v2 - entry of IOTLB to describe one IOVA region
> + *
> + * @v1: the original vduse_iotlb_entry
> + * @asid: address space ID of the IOVA region
> + * @reserver: for future use, needs to be initialized to zero

reserver -> reserved

> + *
> + * Structure used by VDUSE_IOTLB_GET_FD2 ioctl to find an overlapped IOVA region.
> + */
> +struct vduse_iotlb_entry_v2 {
> +	struct vduse_iotlb_entry v1;
> +	__u32 asid;
> +	__u32 reserved[12];
> +};


Thanks,
Alok
