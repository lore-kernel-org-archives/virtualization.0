Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA318EA85
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053755; cv=fail; b=OtFLSFF7g1I80/md8revodq9bTbhMbk3QuDPO0xy267OEyq0Zfqf89x8nogVxKW6f/O8sJbHqzNf7IYHbXL7d6VB3xBpqaRJQi8KWxnxTR9U1DOHXlzkruBr8xo0lohRgtsFwtb60kG3Nyq1KKN4MKbdxEUbUiMtLBBvwyKKslE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053755; c=relaxed/simple;
	bh=j6prWY4I82xU264QRfyxgQJA3tL9NzsPTxzOR79zsSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mxwXnhlHUm8HU5cNQ36Jx7/nbTbus2F6r6OZVGzZYzohzO4cNFU8VmGehWS57g3tb7NVxY5tV+4xX7HMu4HlsE3bB6N2w3q5eJRhKKJa47UdoRdj9uz3YtRrt/DDZeTEjwITHMX9MMjdMVtqAWbgjReUEUOuhTgcQWexS3bCku8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MpUTCMLi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R8zdnTx6; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MpUTCMLi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R8zdnTx6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41AD0605C3
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:29:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1E1cOvTwKIH for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 14:29:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 01AA3605BD
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01AA3605BD
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=MpUTCMLi;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=R8zdnTx6
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01AA3605BD
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:29:12 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENq3V022752;
	Mon, 15 Jul 2024 14:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=iwIImHkvkKLJdlp0by2swMVCfVU8VKSPS+KpkDIMlEY=; b=
	MpUTCMLiXgQdt3zBIdwRBSC31Qr5SKLjjxYEGQ93u7L2Z/DgmE5ylLLPAqrQMFGI
	Icd5OvEwC9qYFFvZ8cIDL1ErLsXLxDpRzgkm5EigW6z+1RxIT4kEA6reFm8XRFlK
	oLY3dTs9Wq7tbYfqGznTtQ4A29a5VChqz6oUCAHv2IHIVSpfl8y1EYuTAB0LpA36
	/uhmS4fwbx9ap1sNNPJ1O+T9sMBAQ54Yp3621oz6wv6HPW4EFHKfdCF+4HfBJf8P
	ftkGOvWdGCy0Q75VlWmQgwIRc4NBmSxY+TFBeTaU9vNkWq2DRlxud9nDq0Xu7LAa
	VWrhTu68+cPb/ckUI0RfXg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bj4tk4g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:29:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FDLkaO038921;
	Mon, 15 Jul 2024 14:29:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg17ms35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:29:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCkOSvqe3T7y655S8+dDPy2pwLD8EwFcZgugcIXbYZQNHFSYRvDi1iUsPGO47v4BPQybBilrTUwy/OFPFTPl8lNrmIC/ppJzImIi+06zcM2/G8d7KvQEW7ozHIM/xJjpRLux2SokVIA0Q8+nlIyLL8H6u7Tk0yURh7NZST4Ge807/yyNhXe20Ij87LDlo1cWYKNluVrkEElpO1Ww4stDYiBY/9ySL5w462tQmQ4kofH7MbPruYvLDbZ8HkwOXSXfXcmvwDMCerAkXJbGqQ8HJwyLvzk5GdiPtLGxVlxOItlF+QwEIETdtPSBG7WP/8YiF86FY9oyDimRQ+GDH9pUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwIImHkvkKLJdlp0by2swMVCfVU8VKSPS+KpkDIMlEY=;
 b=XvYPeHXX7/ZljfmfqKREhkMMZ0XGUgQf9H35+7taWX7rZtmtDY+GpAqxfz7qT1qyXxE7NdeXCalIWZMwweBAeghKXMekm+RgD4a6cmpweI3ADRB2eBNET3IgGIapCn3QMiV+GODBajqEYc4JZLVhhW/bPxBtjsO5308tk24MFMPEdQJfUx7DDpfvQtl4h8cuBCnebNLbQUjSZGpO9BzKAUfN6kvhCjV2H5m+oGKEL0QzJsh08/xIiZe3Cnhvth+QsJ0OJb+4BylgUXGaPNUgczmXbCneyhb+AZ/xYBG3baMz1QmxfNZsFeVZhHmBNx4+Hnjm7J90oTwvonUmZ7E0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwIImHkvkKLJdlp0by2swMVCfVU8VKSPS+KpkDIMlEY=;
 b=R8zdnTx6PL7rwT+/7HGpvIRb9SeV+/7HqG4EfesKQzLHuI1Y2hVAAEiazMpjkhHVsvgfwTmWfPzCCJVhHOUN9w7Cc9DakJYoWtXS/5ltEOgx27P83bxLqDEAfCGlCmx66bVM7xgJIJ77W5V74Q0WLvLg1pl6gTZ7AaVndujLmQk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:29:03 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 14:29:03 +0000
Message-ID: <911f018b-c273-4983-90ac-0a8f925ab6e7@oracle.com>
Date: Mon, 15 Jul 2024 10:28:57 -0400
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
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEs9SvtW=Dkg1aU6HuFqTP5eekD1JdR2w377u3iGsOR-Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 4011e6f3-86ee-4caa-6197-08dca4da798c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?S3YzbXdHSkx4ZGYxQUhuSjZFTm5nZFVVeVRrNFdHYkN3UkhWb2pwa3pBVDVD?=
 =?utf-8?B?bC9KcmF3KzFuQjd5bWx4MFBPV0dqVTVNUWovMGVjSmtOK001dUpMY2k0Q0lG?=
 =?utf-8?B?NUtBdG1waW05Y091aDdoNmpqblkyaEJaY3QySVp3dUkydnZtVXNkelE0YVZ2?=
 =?utf-8?B?aHo0ZDNEUE1ZQ0NJWG1mRTlUaExVR3ZuNmFwRHZTOUl6MXpETS85VEJaeEhw?=
 =?utf-8?B?Q0RTQTJHUjJwZHNtUTYrQmloTndodUtMa0dPV002VU44ZWRlOFdzQkhZaDdC?=
 =?utf-8?B?SWRVenN0Tms4aWJ1OElVenJJbnJVUmE3djVFWndLRldDRWFjbVdtOGkrdFNX?=
 =?utf-8?B?RlFpRU05Y3NvTlZEK2VwN3MvZW40N2ZsNUZFSzJuNlZBbk8vM0NHTVhJUnBv?=
 =?utf-8?B?VnNwQ29OR1lmZEVsblRrQWFvY2xnK2F3ZHVlRjF4bC9iRDZkYlA2dm42TG1K?=
 =?utf-8?B?bHF1Q2FaQTRybmhMNTJwNHNIbXRMM2pURU10ajV4YVRqUGd2VnpyWUgydVpx?=
 =?utf-8?B?WmV0RmdseFJTcVBVV0NpYjNNVkNuN0Z1UHNxT1dYZlFwdkxjMmQ5czBPbk1p?=
 =?utf-8?B?cjIyTTVmc0o4MmplZ3EvVlhUTFhlOElRT0dtSDRsZkpJUkt2aXordVpTVG1W?=
 =?utf-8?B?dmpkSnJBZ2pZMFgzSGlyTXJvWVJkT2JIUFI3bzRkZFVSYVk4bmRqS0V1VFpH?=
 =?utf-8?B?VU14dHZRVE1raVNadnQzbWNLOEd1S1Q4SzRXNm5ZYW9UK1lZcXdsNWNFL0Rp?=
 =?utf-8?B?TzBrTlp6cU00U2xiWVdHQUdGczdoMnJtRmVxV1B6U2NORmh6aXViUDhmZDg4?=
 =?utf-8?B?Q1FQeitweU1QeDdaT2U2ckxQNHk4dFVVdTE3VkMxRkhGRExnL3NLS2JiWDhr?=
 =?utf-8?B?aXJ2dWo4Q0E1U3o3Y3ZQN1hQZnhvbFZINjVPQ2I1aU81VEFRaTg2NEZzdWIz?=
 =?utf-8?B?M2F1bFNvUFJPeHJMdXNJT3JVT0Qrcko5dDZnbHhTTXRtT0ZYWGdTVE1tZUFB?=
 =?utf-8?B?NG1Lbk0xeDdia0RuT0lzUnZVam1QaTNQT3UySGpnTlgzeGN0cEpFMlQ5OVFn?=
 =?utf-8?B?MFQxbVAyM1l5c2NDSlBZTE1BU0VVbFNWQUNLSEVNQU11S3JFOXllK3FxMEpO?=
 =?utf-8?B?ZlNZVnBDU2RDOFJOMWgyMzhveHdMeFphUzltejhUVDQwRVJob0JqODRQRUZF?=
 =?utf-8?B?bVF5bXRvczg3cThUeUdVcDdhQkVUZlluL04rVVhMaHcwSEVoM3owZThiOFBn?=
 =?utf-8?B?SVAyaEtZelpPVEV4SExwbHRYZnpWVTRDMU1XNUtXRUdUVHV1UmxWMmtiMWky?=
 =?utf-8?B?V2xtNGdCSng0NTBnMG9jOUJNTG5aK0JpZlZmYTZtaDNqd0V1cmNPTmtYblM5?=
 =?utf-8?B?QkxNYkU1enJTZUVtKzR2eWtvR2k5d09lTFdJcitkTndtZ0VGSWVwcVUzUkhT?=
 =?utf-8?B?WGQ5Ykp0UWlUL1NPbTVULzA5ODl1RG1OdndPaEIzU3laWE1mSU93dW16MFhX?=
 =?utf-8?B?c1JGejl6MmxFYW80RXJnSFFXSlkvdEo1TmdoS0tlRzl4aEN3UjJzU095MjVr?=
 =?utf-8?B?aiszd1M0VStpb1UwZmRFcHZ3U0JjVEZjblJpcFFZS2sxQ2dKb0wyaGQrS1pq?=
 =?utf-8?B?RkJpOFVuUllYb1ZMeFg4V2drbU8xOHZTYjF3aVUyNkJnSWVRdk1Wdm8xNUdO?=
 =?utf-8?B?em9Lc09UejRQVjU4SXBFSmRteXoreVFEb01LZThIWHRUaHJTOUtJTkdPb3kv?=
 =?utf-8?Q?rCVcbPSRenRtKHmYWs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2lSTmtHMzhQMUpYZkxQVXdDR3VWQy9hekdyTkgya3YvSU9LSk9UWGRSTHhL?=
 =?utf-8?B?bXBxZkl4dGhQL3NPNTdFU3VBK2lNTDgyek43S0xVMEpOODBWUk9UU2ZlWTA0?=
 =?utf-8?B?UzJOd0xQcmJaMjRUVjg1cGs1VkdnYnJIakVEcm9XQ29kaEkwdHV2T1N1Mkx4?=
 =?utf-8?B?Wk1EZS9YVUlSR0wzYTN2RXRIZnNXTWNKcCtyVzQxbFpZQ2dPcERBK3V4N0tI?=
 =?utf-8?B?KzVsTVg3RW1tNEo5WWFDT2ZLam5DMnpYcWx2V1ordWliSWtPc3QvZXNDZGFm?=
 =?utf-8?B?REJNNWxSMW1acXlZOTBiMWhqdWZJbWtQWGRlRklvK2tvQ0dmSldvRzhJa0Uw?=
 =?utf-8?B?U3h0L3JaSnF6aEJsUWpPOXpUV2lXcjcxTDJ0aU9DUTA1eis5LzBEVFVPcDJH?=
 =?utf-8?B?Ry9hMkdiak5pZkIrYVF6Z1MzZWZaVTh3OVBUYkQzY3U0UDI1QTdZNDRHN3Zz?=
 =?utf-8?B?TzI1ZEprRHdPOHZNdndFUS9PL0g0MXhDcFluV1p1WjBxM25BY3Q5Z3dOWFA2?=
 =?utf-8?B?N1gyVHpQNGRITjZRUkwxOU5meVBHbmx1RU5OUWNrRkdZQktDSUxvaVRhYnY2?=
 =?utf-8?B?TFdzd2lVeXVxbTdQRmJhUExwZlBZZm1BWWE2UFo4bFNJOFRVK3Z6OW9TcHRq?=
 =?utf-8?B?eFhxMTNUanVlSnhZRHZTQnVreGNlbHZrYjc1UDJQUUEzOXFkQm1oTWhFMDNq?=
 =?utf-8?B?NS9kWms2U3M5MHhsdklDbmg0ZGdkMTB3K2R4QXZ5Um9Jc1ZwNVNJejFicFI0?=
 =?utf-8?B?ZGxPcVhoNTRTakJlNnY2RjQ1MlVOZnY0Y3JZbHltdWl0L250T2hscTJ3MjlI?=
 =?utf-8?B?eEpBSTRkVmtBUkVpNkFIeDU4Z0l0MHJUbTl3a21pQ21RWVQ3djE2Vk9aT1JV?=
 =?utf-8?B?QWQ0MW9XOWRMdGhwTGFXSGtYWEs2Z1NwdEl1K2Nxd3I3TVFGOXBML1FYeXdt?=
 =?utf-8?B?TmxwbTRxVGk3UncrRi9LM1dMZk8rQ3FFRXp3TXZrMmtJZGRWczFMU2FlWVZF?=
 =?utf-8?B?MExibHh6L3ZCOWdmK0wxYXRyM0kzVlJSeGZMYlJNSHhUa2l5c2FNUUdrak9w?=
 =?utf-8?B?QTFIL083NThUaTdoOGRUN1lvL1hMaWJPbjlSOTdoaUVueWNEZ2IyQjhraWlw?=
 =?utf-8?B?ZWEzeEhvYmJpR0xkOVhUaTQvemRHVzE0ZWhlS0p4UzlJR1gyVzV1dlloSmVs?=
 =?utf-8?B?elhYL1pSL2xYYlZPWHl0cm1RbUMvMlZnWVE0TWo4aHoyTXVzdjNMcW1NeEJa?=
 =?utf-8?B?THAvZ0pyL2pLOTBhQnc1d1JPNEQ4WThLK0JoUmFXbnRRT3NxcFRRRmFYZG5E?=
 =?utf-8?B?bzRNRVFEU0N6MUdkT1BoemZwM1hIdDVZOVZMUjJYenhidEcydnIvT3VRNUEx?=
 =?utf-8?B?SHNlR0RxUDNUdC8wQm9RRTJ2NkNRZzJGd1UyNVJQUUhHbVptQ3lOR0pGL3Iy?=
 =?utf-8?B?L0RIUXJJcExOY3BRLytnUlpjSmFIaUF1MWs3dlpic0pyR2F6SlRES0FwQVEz?=
 =?utf-8?B?MkZWcVNmVEFxbEd2YjBtUWd6ODUxVW1XSTVIeWtUWlhFbGpBa1V6VVQycWl1?=
 =?utf-8?B?NjVMcHdaaE8vVU5yTGVSb2xoZ2ZMWnNlNlg5U2l5MGpJYkpoY2ZRMDh1NHhN?=
 =?utf-8?B?eldKc1NKM0tNb2xNcEhnT3d0WG45eUJ2bTlVODN5cGVteWFyZjMzK1NRQk5C?=
 =?utf-8?B?WXBRbVFzRXNpM3ZUSUlBTzFoTnQ5bk9EL29vczlJVUt3Vkd0Sm41MXFlelVv?=
 =?utf-8?B?RHhzczlvUUQxUWdZOVdkU0RIQVhreGU4dEhCVjlOUUo1VExyM296RWpCdnFP?=
 =?utf-8?B?S0ptSFhTcVF3c0pNWXA3c09zRnpDQW05MWhvSTN2RTlFSUd1ZmhDNUpOaUha?=
 =?utf-8?B?SkhjKzhrazJGNnlzaHBTT3FCV3RqbUtJTkozeW10U1ByWlRJQXVITW9meFVN?=
 =?utf-8?B?b2J1bC9kMWx3L1hudTFTTTlxQjR4Tm9CK3Y0ekRORjUzMXZvV2NrMWNtV0Vr?=
 =?utf-8?B?d1krcndGK0RwcUtLck1RZ1FlMFluUGRNWVJZZW5mZzhpdVNHM0dlakpPbFdC?=
 =?utf-8?B?b092b3QzSldoU2JkUTI4WUdnZDFUT1RZMWFYY2QxQ1V3ZHVzT0R0bWJqajE4?=
 =?utf-8?B?NWdkU2hNcGh1KzBuMi8xMFRrK0JkR1pmRHVIemhXbGU0Q2hVb2JzeUltYnJX?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+4LqSRJoufWue8ZV9mmg+wAwz1Ata7s8i72eGX/CP4tSTD/+G/sR4ppeNHJjhSw9+bXU+wV/jaAtElda1lUwCjZeye6sdyU2FltG/P11DLqeb1ElCs7du5/8YeRK9w9zD/lDWuC939B9vzjcV9v55eZo4klbNBXNHY6ctY21Ad73F7l7jqsZgORrvoIPBDHMQ840LmTdeJYjNJfvkf418p2EWAh0bGKPZtteTj8JbxbtIhI2bP+SqyaOE/FXTGZ4FPsD5JZGT9lLdmi/WIupNLAFhD67CXB7HNEhbSsZFcKu2NBLLkuq+Vfk0E+T9F1RO1+rSyvtqD4njGV2p48qEU1qQRNBMSA8a16lyIavnnaZWuZ/R/Ldf9TyYVs9Q/frPzi7tB/o/YagsujfcjCbuvLPSn1zMEdstuSJCzkaMNfVepeppgxw2Z6dysUFzpOeXqw7rNSDHa1eEMHm9qo+SzKe+rO1fBcRCjdWbO5gKLkCfq16aQc5NIooZgMu6eEd8hDP3iM1Ba5FdQH/mudFfNm7KiCVYFZtlQKZyonit6zE18Wvl2OyYEQNPio37Hv8vw/cfRLjAtyDsPu4RT9nUga+dfNAHEyUFJW8ZVnBWec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4011e6f3-86ee-4caa-6197-08dca4da798c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:29:03.0695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPoFlWYjA7FaSE7q+Dp9mz3Jm0O9479UvMCL1i5jRg4nq4EoodLrkDzbPX7PA9Wevr2Kzl9b82VdfiEI1HBSJ3xaN+9fAmKiqNpbbbqfP+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407150114
X-Proofpoint-ORIG-GUID: _nQLrv12pm7qzBenThwQGdHkJSNQusTU
X-Proofpoint-GUID: _nQLrv12pm7qzBenThwQGdHkJSNQusTU

On 7/14/2024 10:14 PM, Jason Wang wrote:
> On Fri, Jul 12, 2024 at 9:19 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> Live update is a technique wherein an application saves its state, exec's
>> to an updated version of itself, and restores its state.  Clients of the
>> application experience a brief suspension of service, on the order of
>> 100's of milliseconds, but are otherwise unaffected.
>>
>> Define and implement interfaces that allow vdpa devices to be preserved
>> across fork or exec, to support live update for applications such as QEMU.
>> The device must be suspended during the update, but its DMA mappings are
>> preserved, so the suspension is brief.
>>
>> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
>> accounting from one process to another.
>>
>> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
>> VHOST_NEW_OWNER is supported.
>>
>> The VHOST_IOTLB_REMAP message type updates a DMA mapping with its userland
>> address in the new process.
>>
>> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
>> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
>> require it, because the userland address of each DMA mapping is discarded
>> after being translated to a physical address.
>>
>> Here is a pseudo-code sequence for performing live update, based on
>> suspend + reset because resume is not yet widely available.  The vdpa device
>> descriptor, fd, remains open across the exec.
>>
>>    ioctl(fd, VHOST_VDPA_SUSPEND)
>>    ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
> 
> I don't understand why we need a reset after suspend, it looks to me
> the previous suspend became meaningless.

The suspend guarantees completion of in-progress DMA.  At least, that is
my interpretation of why that is done for live migration in QEMU, which
also does suspend + reset + re-create.  I am following the live migration
model.

>>    exec
>>
>>    ioctl(fd, VHOST_NEW_OWNER)
>>
>>    issue ioctls to re-create vrings
>>
>>    if VHOST_BACKEND_F_IOTLB_REMAP
> 
> So the idea is for a device that is using a virtual address, it
> doesn't need VHOST_BACKEND_F_IOTLB_REMAP at all?

Actually the reverse: if the device translates virtual to physical when
the mappings are created, and discards the virtual, then VHOST_IOTLB_REMAP
is not needed.

>>        foreach dma mapping
>>            write(fd, {VHOST_IOTLB_REMAP, new_addr})
>>
>>    ioctl(fd, VHOST_VDPA_SET_STATUS,
>>              ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)
> 
>  From API level, this seems to be asymmetric as we have suspending but
> not resuming?

Again, I am just following the path taken by live migration.
I will be happy to use resume when the devices and QEMU support it.
The decision to use reset vs resume should not affect the definition
and use of VHOST_NEW_OWNER and VHOST_IOTLB_REMAP.

- Steve

>> This is faster than VHOST_RESET_OWNER + VHOST_SET_OWNER + VHOST_IOTLB_UPDATE,
>> as that would would unpin and repin physical pages, which would cost multiple
>> seconds for large memories.
>>
>> This is implemented in QEMU by the patch series "Live update: vdpa"
>>    https://lore.kernel.org/qemu-devel/TBD  (reference to be posted shortly)
>>
>> The QEMU implementation leverages the live migration code path, but after
>> CPR exec's new QEMU:
>>    - vhost_vdpa_set_owner() calls VHOST_NEW_OWNER instead of VHOST_SET_OWNER
>>    - vhost_vdpa_dma_map() sets type VHOST_IOTLB_REMAP instead of
>>      VHOST_IOTLB_UPDATE
>>
>> Changes in V2:
>>    - clean up handling of set_map vs dma_map vs platform iommu in remap
>>    - augment and clarify commit messages and comments
>>
>> Steve Sistare (7):
>>    vhost-vdpa: count pinned memory
>>    vhost-vdpa: pass mm to bind
>>    vhost-vdpa: VHOST_NEW_OWNER
>>    vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
>>    vhost-vdpa: VHOST_IOTLB_REMAP
>>    vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
>>    vdpa/mlx5: new owner capability
>>
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c |   3 +-
>>   drivers/vhost/vdpa.c              | 125 ++++++++++++++++++++++++++++--
>>   drivers/vhost/vhost.c             |  15 ++++
>>   drivers/vhost/vhost.h             |   1 +
>>   include/uapi/linux/vhost.h        |  10 +++
>>   include/uapi/linux/vhost_types.h  |  15 +++-
>>   6 files changed, 161 insertions(+), 8 deletions(-)
>>
>> --
>> 2.39.3
>>
> 
> Thanks
> 
