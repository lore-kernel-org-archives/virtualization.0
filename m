Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39B29AAF3
	for <virtualization@lists.linux.dev>; Fri,  5 Jun 2026 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685459; cv=fail; b=MKx//hnA6ObvN0IKNjBqHc0Ac7+fnyZJ8sYoWufZWEfyMBlSzPoMdJrivyXxl6WAW+iXMQmN43BY2yriew4oYVlPjsLbkLo7tB7LDKRXeaFPqwyASbYUCGrCuOppTAEgVNOqHKh45zw/3Euw9zxuzXJZeYEFXpdsJlo0CreElzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685459; c=relaxed/simple;
	bh=D5qh4TCSZWANumjLrLhIsg5smYlHp67rnH/yW4ptbrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A1Ihyyh3D4qiCaMSdMYqjJxvrr1zbBZ9ZbU5A+pQVmM8XIGw9teUTSa0tv3u0igZMOc5v4waeKbx5W1Fvgt2KFsIsK/2xBo4JEuOugDfZIDjtCt5Xd16c5q2TnHTb9VOjrwnk1Qeh63bC3lyvIkjdFcKdn7gcgFPQkZu6A9z5R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CKwrooL/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qlCu3HzV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CKwrooL/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qlCu3HzV"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655IXd792705114;
	Fri, 5 Jun 2026 18:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WoKpBSdLftdSvuYGwE1Ig/nmVqEceoHJixoohKwIYAc=; b=
	CKwrooL/dK3fT2XrlNFuVkDTVKylmc08lBlmhuiiFCuh6gQhWPcQY/GKvVqpzPoV
	5V+TPFPdSc0jw9mpBgCWhXXgUCDeJUqBIoeH/71YlJ4gX2aUT2cBchUlZWDu74X6
	4JbgwHXn1U1vX1icE0byk4zmN6P0b6jNOSoKMpGGtovndOlr4PHQxgDggJ9KB2j3
	aeosW4d1F+Ps+T/6w0fRovjKLrHQdavOG/YP8nPMBPvhUFKNz7aJZ8etf6+YuF8V
	smQsRqu3nUZ/7EKpdczcI3kP0to1fzz3rGJJyueB8DvnUdHWvt6U54FmfHzwPdMm
	k1Gsa6lcpNI+CWWWRugr0w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efpp22qr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jun 2026 18:50:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 655IoPsB031109;
	Fri, 5 Jun 2026 18:50:43 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4efpbvne9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jun 2026 18:50:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1WpFpLLHbL166Vx07VqZkV57ywbHpMBCE8qt/+fu2N3z2+ZTcKg6wcqnzqh5hs0SFi67x6nr9IeDSJ+mHbEXm1NLIO84aypiIh2J9Fr8Rs+xuVGlOS0x00IGH1LL8K6TwAJlPUuvdezTTC5fIsJisiGZmR0SzEZCPbzYHiJ5fpD0meyEwRQLDzxHvjDEoHgdqmc/BXAIas53yIP6P3tPUjVoOlHIafQ85hDs9zaazufHDAIfc/cDbCGhoY8WsS3PyBXQaKlcSVOk3cOesRwGR5MtwwN+KaCI1ZW+1Ug7hUffdnNgAtgIumL1tGNvAatoL+ZEqpCRsvx1Im1zryWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoKpBSdLftdSvuYGwE1Ig/nmVqEceoHJixoohKwIYAc=;
 b=NVU/7UypDxkiAZv7Y4PyRiIfLoFQ9FNjZvwgOsu7aXcIkOo1+8Wccn7U4Z3jx7R/qPoZ6cuJ6XEEgPqIkjJ1dw7uNhjRDQzFxdCYtUnA1pdPY/HsfhNs9JFuTiE/YsMmPwgY5DJvqJFDbI13Y9T5vQyCrHzXEa3Sv8AmAVA6bAMjmO7JWC2m7/69AGr5KbJyeoVdxpGI+xBmGM//trSO+vi5jIlu1+e/AMNrrMSu5I8s7dexlTJ77Lz836rqmjILGHUKKGgoW7XOwNSuMVNfFrsSNxD2HCusWbNtfQxzJWsd7sPx5Qn3DyvliU1AV5yJHE044lzfhKcUhknywa3KDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoKpBSdLftdSvuYGwE1Ig/nmVqEceoHJixoohKwIYAc=;
 b=qlCu3HzVSIN3mYMpXDY7Fmy+o9ccDzwtzjcfaw+ePvWgKmsCq+wlbrZYGdoxlQ+VIPCnKDEXitWYOCwFxBOEgZEKSYsZBJJPJFETyc9CJjn1QMFxCiLNFecOz3qC1bz1/llUvGM9heoF5n6DFdc6dcCgmKhx8/OQIXNi5xVwMQw=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by MW4PR10MB6557.namprd10.prod.outlook.com
 (2603:10b6:303:22a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:50:39 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::1708:e053:84f:d75f]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::1708:e053:84f:d75f%7]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:50:39 +0000
Message-ID: <5e1a10bd-2783-42ba-b443-853f12159756@oracle.com>
Date: Fri, 5 Jun 2026 11:50:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
        yangjiale <yangjiale133@163.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, Andrew.Boyer@amd.com
References: <20260602043123.10207-1-yangjiale133@163.com>
 <CAJaqyWfugEttrQuR5_LrbQaivAqCaixsprUOjEVtdiz_sexFpA@mail.gmail.com>
 <6035a8f3-e225-45b0-9f48-55de953bff15@oracle.com>
 <20260605134252-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260605134252-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::9) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|MW4PR10MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: eaea92f9-0f58-45ee-3411-08dec3335689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|42112799006|366016|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QX2UCba+pFAv/bNG2IOJTHJLg63hqwMLjXHSRlKOgAxU60+VyodfJqDuknO3JH/06jGWakFHCfYw8Fam1vIMsLHEB+AYou0dceg7rV/s++snfBXtq6FfFOPjjWrm+8meH6ZocIOhWtOqNF6tMJ6keobCOtu2lPwfBKeCooOqgHzZw7vHajJSsVtWwxxkUAwuFNTezVNdtKVHuxhRETgXyoCA6TkjL/rEVchSrBtKXyhV8OBFaHTmfl4+nN+dQBZF/RnRpfV8Bo8J7hpCVUDSa5uELznAC0zNuJEZbGjpPRXXUIib85L0q2ji5766yHNLCWYDOZjACJbJonEattr1N74RKoknxa+AtaDVGL947YTNExQRDORfIofm1ky8NcQB5NQ02qfE+hTznGWuJ1JUzJBqSz2Xfr8C/C8RSyu6+urHBZT0Gb0V7sVm18JPwlFSlNeqqf+ACNWmcT7y46GJpQrF7aHY6J9KRFtJRie+7YtGRizqNgJqYu+LTpk2iOabga4bYlV2rbav8wzLUtMTfMRDayCkROAQh3OWYm2KlGUjdGdzQv/BmnLTINJVNWNxoGkR/vj6EPuDRZmg4jUdll2rFpSCLvGHavLjEhek3yAbxT7pedmtCWCdc48P8vS/wh6uzeSaCu63GVqQzPADRdMWhv6cQ6sRIgaZgyVsYQ8Shjr6KHYl1bc9zLH9bMgA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF18D5A7206.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(42112799006)(366016)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjh5UjJXUmpSdEhkdDFna3ZDREhsSDN6eFY1Lzd1SFF1a25NYWVIUi9BVndG?=
 =?utf-8?B?UGcreGljd1JuVkFMNlZMbDNZRjJlUWJQOGExZkJyT1BYV29JeG1qZFYvWE9w?=
 =?utf-8?B?SGw4Y3hHbEt6UlREeFlaYWkyNTZIQjhkSWdCZWtmb0Z3S0FHa2ZnME9wdUhp?=
 =?utf-8?B?bXR2eExVNStmdHVLQmRFcmR2V2NRaElJS0llSXRIZDB5TThYTS9sb3R3cU9p?=
 =?utf-8?B?dUJIZkdsbXgybDNoek45Y0F0OWZBTU9YR2xWMXRVUmhUc2RXT1I0WTd2eG9x?=
 =?utf-8?B?akt5elRFWWVEcTVTTFdrMUlrZ05BblZPc3llaW5mU2hlUWFQYVZGVS9Yd2dO?=
 =?utf-8?B?L0ovZnE5RmJYWVErRUsreUpoOTdHVlNkUEJhMmhlM1NBaHdTcEc2bHVQTzY1?=
 =?utf-8?B?TFpSa1ZXY3duMkRjWXZ6R3BENTBRb25ZMGFkcmxWb2prOWw4M2hDSUhpVmNj?=
 =?utf-8?B?U1FyN3RzTWV0TDZUSzN2TUNnQWZxVmRiNFBsMTJJRXloeVFpU3NMTno5L3li?=
 =?utf-8?B?b0pzOTl4MnkrWGVQQUtkWFh3eXZyODJYVjNIeUJ6TXBuSm9wUmVmOTRKSytS?=
 =?utf-8?B?bWlZeFJIYnNzVzVtMEtMR0VGKzlWZTNFWHpFd2F0S25JTlpUK1JhRy90R0xa?=
 =?utf-8?B?eUdBOHNDT1BJRXgvdFFMRzByeGxxNUlrcklCOXVZczZCSGE1eEFWa29TY003?=
 =?utf-8?B?ZklRaFpEdnl2d0g5aFdEelkyKzhUVk1TMnJBaWdXMWRadWtYOGVIbTA1SDBH?=
 =?utf-8?B?SSs0YnNNUEFxRFhTYXJ0Q0s5R2hOUkxPMDljSEhKc21WL05xanNoMThQTHhX?=
 =?utf-8?B?U1pUWCs0eE1UUlZDNm44dE4wQVYyYWs3bmdkVTBvVVlOT2gxckhkZmRJWWk4?=
 =?utf-8?B?a3o4Z1VSY3YxS3JReTVDWk1ESGpGNGljVXYvNzlYOGR2UExkT1ZHMDdJa1Y0?=
 =?utf-8?B?a0g2UE5kUDB0Tm9ZSjlQdDZRNm9VNzBQKy9qY1l4Q0hwZmdEM25MbXBOcDUv?=
 =?utf-8?B?YVFTT1hMbDZmSnRBNlVMaU9jRHhZYVJBZzliU0owc3hJVXl3K1lGdFpDT1BY?=
 =?utf-8?B?bVVEZUFySnE1S25xL3YwSkVKcFZOam4yeWpyRXVBa0Q1V2s0TGZTZ2JOS0U0?=
 =?utf-8?B?Vk5qYXpzdzUvZlZDOC9PSkFtK0szOGtYdUNyRjlaT2Z5N04yT1I1QzJUMTRt?=
 =?utf-8?B?eU53VUxFRVR6MWl3SEZpNVZtYW83YmNoY2F3R2wxMjVHY0NwaHVaZ2Y0UE4x?=
 =?utf-8?B?cFk5TVczd3BWLzl6L0FxMU5aeFRDaE81V1h3QkJEdnE1NWEzWDJINVJobEpR?=
 =?utf-8?B?akorK0JpS1pYTW1xSEl1Mkg5NVNYekFsbFRhajdKME03UjVMWTBlZFRtUCtI?=
 =?utf-8?B?Wko0MHJLVjA1L1oyQWFCN0k0OHVjbTNCUG94dlNqcktFWFNHbFhYcnpjaVdm?=
 =?utf-8?B?c05Cdzh3MFZURFNpSWJpeUlSeUFHWWV5V3FheDM0c3d3UFVZQmY1eG45ZEdD?=
 =?utf-8?B?cWR0SWI0WjZiYXRBWjZmQmE3aWJCVTh4ZVRremk3TWtkcEpBeE9vQllPSXRu?=
 =?utf-8?B?N1VhdmQ4cmRBWWM5c0xVa05jcU9DNFdabnA0c2RLZldNNUp5RmhZM09RSllV?=
 =?utf-8?B?WEFFTEZwMFpCU0IxTXdnSDZQSmhxaVpNN0FhUmQrdDZTQ2lmODB5NkhUOGtl?=
 =?utf-8?B?NTZRMzFXeHlNWlU1TkRLSk9LQjJpS245dkJselNxQk9ucmtMVC9qZTBMV29H?=
 =?utf-8?B?Z3NOWGIvUFY2Z3QxcFVIWHA4SXBtQkV0YWJnS3FCd3RDN1FUTThyb3RMUld5?=
 =?utf-8?B?b1pXQzVBSmtMeUFHNVU1RVE0VjlzL0toQndTclE3cnJRaW9ScmNRWEtSMzVK?=
 =?utf-8?B?aE1PcW5BU3ZiSjFvVWY0UkZpMnNGNTV3ZGFrbmhWWFdqOEorOFg1aVlqRGhB?=
 =?utf-8?B?OVlIdmw1R05DQ29SMDlWNld5ZzVDZFdscGdudVRPdWFHVk50Tk90eXdPWnB1?=
 =?utf-8?B?Yys2TnFDZDJIVXpIVGdPeEdrSUFPZ3dxNVF1MitRcEE4dk9mTHBOeTQ5TDh1?=
 =?utf-8?B?T0MxY1dnVFV0cjFodGtOTnRWenFGL3RHV2ttZXd0R2lObm9MN0J4SkF6ZWVh?=
 =?utf-8?B?L2kzNXVBUHVRc09BNDRCTDBha2hiUG5INGFscGlib1Q5UkZaWUlwUnc5UEZx?=
 =?utf-8?B?SVNpN1ZUc215aVVVWGc3ZCtDd3hwVEpjdzFWOUEvWXJhUmFBSncwZm02eE5J?=
 =?utf-8?B?T0VhclBOK0ZzWE9YaE4zZ1d3eEZpOERXSjFNdHQ4d0EyL2RrOXE2VWVRUU5r?=
 =?utf-8?B?M2JyUkxydUlGNjZlN3F0MkJDbWtEaGxqUldxTzFkVmoydnZhRGFpQT09?=
X-Exchange-RoutingPolicyChecked:
	S2CF3gPz9WVc5Lh1tLvM36C+jdM742+DJFFaEmNO8qHpPteyfaZLnfXWbCfTRFNhRRBmrZvkiblzfMaeuv3XmEKpp6PMarZ1wCtklErClVcGRygA632cVCkbdZ9YyFWrG44qKgMjXqYDdZjyk/gmXeaiKRemUboM1p12H0qb5bj3WkTgZ7jFiew94QHWDbhnf+0FlV4XHAbZYciHrhp5PYKs3SGs28u5QYN0LEvPMYXPYjyAIfLLeSGf0WEq7P0rvBwVd3TVX63DJDSdaM8fHhtrn+7C73EcUtgZvrtr6ggrwwR8zV+AT8OmtzuUy0J1JLxo3YD/AGmDOouCMUkYeA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UEeTBG8xTAn+zL/OB25ywArZe2e6gJ3BnD+gp6pR1/2WR4GlGhezEuJUM6OsbBqiP6vq5HJUYxn73YKcR/mRan5bvnDsfyhXU+Zb9+CW01R/8ya/wpx107xEcdzF659WF1MJWefBRAAu5p9VbphuxdF4bMl0bDgSCLcPA/e1J2kAOGPqhXlPX2+t5yJgFWUzXDhpyCyGt8UxF0LMDk5mZLxfYygMHisLFtD9r5v0cMH2gluLGwUxctuwZmQcMhtwLBHuXlWfmG2HLPYzeLBQMwUxpGEK9TKUqb2mLdfVFoy3K7l4TZeLTZVGd1OgXNsGb9uD8RTK0sB3pw1XVNjLhMWx0EOXCjXZZU9oFQXPrDcT3HM8w3b+uwuFTmZH1gw5+DSRLZna1b/6QFXgzgzYdGOqxF/TZgFVk+Nqywtiw/MNxlbA466zWtsQqahmVEtVgGwpgn53XSCQcIFDUuz4GcYxQ1VRAc3jmrEbDm1D2Iy9g8RRrze5+bPlfOu1y0KCGTKnpBNpEK+9BMGVwEB0JhXOB01wx+PJXSBNWTlVeBEPb9CT2URXM2FCHJ3+a5OX8A2sLh0jxDlic7VgVjIEDBgVZb/Nis6TwFZCc2brFbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaea92f9-0f58-45ee-3411-08dec3335689
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:50:39.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egXeXPttoK+0PUDc7+VNxFCowpB9HT4t3i5ak37CtAcpTOksfJLFUKNnb4Yflg5uJDkrMWfy3if5+hG7hNRPQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606050185
X-Proofpoint-GUID: nHTfOn-ihRJgH8QlurmGVn6X-xGMSo9C
X-Authority-Analysis: v=2.4 cv=BMWDalQG c=1 sm=1 tr=0 ts=6a231a84 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=Byx-y9mGAAAA:8
 a=nmL4neZ7lCmpGjCWfMIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
X-Proofpoint-ORIG-GUID: nHTfOn-ihRJgH8QlurmGVn6X-xGMSo9C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE4NSBTYWx0ZWRfX2Wjxgbrlaar6
 c04YekPdylY3ykPNSs7zs+TM1K2ez65YvQijMozbiwXxL+1xU5Tjz7osac9oCwJAZ7RIZTL3YqF
 XSMasscYcJpAGP2wXEf4yto0mVsxudSlvq6K6US7tzUvklpRRw85nUxggZK0pneZgyekhxTZzHw
 10WM80PR1Ce5u8l+hVguUGaM71rfHLqd6aLPHpAW0sUjCluEuwSJ5+fSNOv/xwmfIKdc+fU+64D
 I1k4UJU0bXFGKz3hNa8QdpHUxkxFo8GaXb4RnOdCkjWpF2gvxjYCz0WfYfek6PnET991llOMhSe
 1QjlEvRsQHPORKPyFidB1mUM3phVegxsznxsdJsxG2x+nRZHYOt/Bs7NcHalAjOXkgLNyO2d3YU
 oWQmkyMAuHrn8g1HTnxwfe1VNWGDUkkezfk5a5WpvSB59PleWCgjxmA0F7FVZGDbxRxFdOnX2S9
 wLLaLT6Xvv9d10XGBA9sobA9li3JyXFCwLAgpglM=



On 6/5/2026 10:43 AM, Michael S. Tsirkin wrote:
> On Fri, Jun 05, 2026 at 09:03:36AM -0700, Si-Wei Liu wrote:
>>
>> On 6/1/2026 11:04 PM, Eugenio Perez Martin wrote:
>>> On Tue, Jun 2, 2026 at 6:34 AM yangjiale <yangjiale133@163.com> wrote:
>>>> When a descriptor list spans across cache lines,
>>>> updating the flag first can lead to a scenario where the device side
>>>> perceives the flag as valid, yet the corresponding address and length
>>>> fields remain unupdated—resulting in invalid values.
>>>> Therefore, the flag field must be updated last.
>>>>
>>>> Signed-off-by: yangjiale <yangjiale133@163.com>
>>>> ---
>>>>    drivers/virtio/virtio_ring.c | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>>> index fbca7ce1c6bf..036b4f90d30f 100644
>>>> --- a/drivers/virtio/virtio_ring.c
>>>> +++ b/drivers/virtio/virtio_ring.c
>>>> @@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>>>>                                                &addr, &len, premapped, attr))
>>>>                                   goto unmap_release;
>>>>
>>>> +                       desc[i].addr = cpu_to_le64(addr);
>>>> +                       desc[i].len = cpu_to_le32(len);
>>>> +                       desc[i].id = cpu_to_le16(id);
>>>> +
>>>>                           flags = cpu_to_le16(vq->packed.avail_used_flags |
>>>>                                       (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
>>>>                                       (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
>>>> @@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>>>>                           else
>>>>                                   desc[i].flags = flags;
>>>>
>>>> -                       desc[i].addr = cpu_to_le64(addr);
>>>> -                       desc[i].len = cpu_to_le32(len);
>>>> -                       desc[i].id = cpu_to_le16(id);
>>>> -
>>>>                           if (unlikely(vq->use_map_api)) {
>>>>                                   vq->packed.desc_extra[curr].addr = premapped ?
>>>>                                           DMA_MAPPING_ERROR : addr;
>>> These flags are updated before the flags of the head descriptor at the
>>> end of the function, at "vq->packed.vring.desc[head].flags =
>>> head_flags", so the device should not see these. Because of that, the
>>> relative order between the rest of the fields of the same descriptor
>>> or other descriptors' fields, except for the head descriptor's flags,
>>> should not matter. There is a write memory barrier just before
>>> updating the head's flags.
>> The above analysis is absolutely correct. Though one hardware vendor told me
>> that this driver implementation kinda stops them from reading ahead of
>> descriptors already posted beyond the available index., ending up with
>> suboptimal performance that is hard to make up by other means. Would it be a
>> bad idea to go with this change and add write barrier in a gentle way for a
>> small flit in the batch, e.g. commit to memory after every cache line size
>> worth of descriptors are posted? Would the memory barrier have negative
>> performance overhead to other backend implementation variants than real
>> hardware PCI device?
>>
>> -Siwei
> this would need a new feature bit, won't it?
Probably. This is to capture the device's expectation and behavior 
right? the driver change itself is not spec violating...

>
>>> Also, I don't get why the cache line matters here. Can you expand? Am
>>> I missing something?
> me too.
>
Just to avoid extra delay due to excessive coherency messages and 
frequent cache thrashing, device read over pci bus contends with host 
write/update on the descriptors in a same cache line..

-Siwei
