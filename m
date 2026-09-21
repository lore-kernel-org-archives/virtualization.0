Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7268850B8A2
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017896; cv=fail; b=EajMLuZSmibSl1T2oN8RIJM2fuLkkpMxF+t7W+26z/NnVVikOoshQ1OJi/6NJYlHgR6XjUJ6u8TWEYRCOfgJhuPw71JNrqAd8/6CQXpWbjBv9aKf2G45O3J2IJT2+4YNEUAqjoOt3hxxcmhbQmZUfP02z30N6pe91Pfm3RdQnbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017896; c=relaxed/simple;
	bh=D9bTFWXpVlLNkFAqNf/WhsloSzZvoVMErQSP1yASTUA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=GP4VHqknw0hZQcCcfvtnRxJMfyNJ2w7vJ6lPul/FSzXnqRqaXeYsYvOAKVHbVnZ8wh6WrYIvAu9rTXzimQsx0tZW7DHfxAcAD8egik07j4m9wMI3tqxDZqPkeqa8PfI2ZghQrHWFAQfGsJWMmctZ5XiT/gAy6uj3LDIBuzq3xIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GIeMJMEV; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xtVDlX+g reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GIeMJMEV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xtVDlX+g"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LDtoNx2444317;
	Mon, 21 Sep 2026 19:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MqG0Vy2tpTp5WGkxGAi79atxSuRISAiwtS8vDe4Y5Pw=; b=
	GIeMJMEVi6Jr3A2+TecAsEI+DMO86PUAkdyqO5hHcNcp/m8sKvg1/GQ/aFgDSmK5
	jwuyYXvXiB4YQ7dereQ6wZhIpM2epEQs7sbFKgwiHLFHQ/9SGCZo2rnPfWTjyCM/
	/Oi5cIpVVQwaEZfSPjtcz67uylEMWLCWbx+7Bq8doPdYQGgB0RfadB0JHDtkl7gZ
	oFeGhXa1Z9EDlUncOtWWsEjMTkKatBsUi5JzjLUkN86iQFyH0pDD+YW6+jIfaLZ/
	UOIWelCM0/Xjyf3cyR6llMthrYKev2KdCq8j5m0mYZnW4sDfoasKGuD4Y+NHemXQ
	gbP4aqGGCdvYQine5P7rJg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1qawcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 19:11:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68LJA2wJ021483;
	Mon, 21 Sep 2026 19:11:31 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gtegnc8ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Sep 2026 19:11:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTTJpAGd8lFfjP4CRGTrRTlpE9Y6hJ2TSJr/3Gx9krfjIjsWbCaRMo/5H8h9zNjlqHaPP6xc0tWwJ98xaT4vZTGexUyr+1L/D6e+tUTQKkJ3dpgHFX9qN+4N9G80yGObcjYNoUsWurDAw5MAJGbLmQRyk5f0o6WByWgUJTXsfrWri14jYwdMKesuce7LLMJ/jv6LmG4wX/gD212l3xBISpIMbzEIXjla8Ui+HClOD3hw8gZJC41whK27CcYlmkDQi1rK3HRvN1Konwam1JRTfXtRAxnf+RltXF2ECRb9fVDUTPTx4UIv6xDiTrDx0/8HBc9JWIRZm3cam6NWBQ4d/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azMunAJGpFc7DnA7xq9yRzemCKTAlggY+EY5y17JBoo=;
 b=MOhd65hw9oWKcBK4oSOYVufCujqbiZUQSaQnY9d73IcXDzp9bfFtcxYyqsNPFEjBtgPCXNsEkaV9IAikmXyM8IFCU7wxMfDJWQsFEYoob9+iqKsjL0kcoKnfxkCODeDoXJ47/jXFuMiKShi64sJAi++gLpiwnlD2C06+UNn8tuEAdNCo3Q39h5fMljVpTTapPZoZsHoe//tfQfNu75aVfHJPNimz/KswRxJSDYLZwQiprYL+/CNy5Vho95pfEgmoLjhCl7v22GK0WhlsJLn4EovPjaUilOPBEPjkZq11bxD8VrIW37TsB5rBg1NqINDYyVrxBtmJmX5seknmq960uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azMunAJGpFc7DnA7xq9yRzemCKTAlggY+EY5y17JBoo=;
 b=xtVDlX+g3kNFYK+8sVjH2A3/Eu76OoZJJWcyxo6YkOA5poEkNs1bUPFJBoQFTJ/whfQV5pMr2w0W7UqnS3Lu0S0uyjqVpjdNWQJtqe79l2WtBzmMIRvqS6HmbKZQYLCvsjsUNsYEDJq4lEaI11Lx1m24tU8/amIqA/fpak0CPXI=
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by PH0PR10MB998142.namprd10.prod.outlook.com
 (2603:10b6:510:3bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Mon, 21 Sep
 2026 19:11:29 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f%6]) with mapi id 15.21.0451.012; Mon, 21 Sep 2026
 19:11:28 +0000
Message-ID: <eb6904f4-d37f-42cb-9319-f3704dc48082@oracle.com>
Date: Mon, 21 Sep 2026 14:11:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-scsi: initialize command pools for late I/O
 virtqueues
To: Linfeng Sun <linfeng.sun.dev@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260908-fix-warning-in-sbitmap_get-v1-1-767c2c211a2b@gmail.com>
 <7a2ed1bc-bf7a-4744-84e2-72c79bd36f2a@oracle.com>
 <CA+kkGbsOD15psKucuvm2JEjHhjQdd3p+9439wK77JHkhqAvGYQ@mail.gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <CA+kkGbsOD15psKucuvm2JEjHhjQdd3p+9439wK77JHkhqAvGYQ@mail.gmail.com>
X-ClientProxiedBy: CH5PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::9) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|PH0PR10MB998142:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab757d2-4f7d-46f5-dcd9-08df18142385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4133799003|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QAkoPaQ8cQqjK+w+m3lScOunkCpM7EWsKjlTeim9py3XjaaxSCZqTSBLkPFev57HaHdCNKGa2BQNQ3nIYlxZhdrg+Z6e5AT5AEHfz9BsM66QqWS6+WUMy9sFCKJ/p6Zh/YGIA0AS5hwjW24pis7rtV7tPZkNHoEJssSd7Ih0dIAsO/IbDvLynoetj2ur5vGtEnggxgNEV5iS6Zc12MaR8rMxGlUr9H+VeUtmunwaI2wIxWDqSQgfNxSXTFaP/zMzQnyyRzTyTO3PjrBrIjQsgZxjECKDAcP8Jhc1p1ZPrGgrq3+DkSTjVHqIqJ7UbaXCHCw4ulkysGXdjL2vrhBSBSvSA/fYszYa2d7DRU2fExhHqlFdoXwnfghqnytXLCi3X5nbis6TXEVu9GwP9GabbuZ9CWz31ny8AL/I53l5uV0yaQ0ORMd3cxMhLLG13L/GeUE5dsSwKjePxzBYXdvTlIm0mR/BelWAOm0CPFRte8y4IpK3olQGIwx4S1DquIN8RCSDgXoeecxaNv90efDoKM6VuiZ7E+pueZChtHHoOBspXf1AZdWyfrwcj5XHfPdBqwUh88Z84ZLugyRUz01fG25SUqRN9j81C3X3skRL8Btl0pre7lX1NX7XsKjZmRji
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4133799003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlBFWlFvVml6VzZoa0xZWlVEKzZ1NmlBbVpDZ3lVVnFKaVJER0JvTGNvMit2?=
 =?utf-8?B?azhUbHdKNmtyYWlLZUgyOHVDRjcyWExGUEFtd2RqcHl1Y2lqc1JXMmpQaWgy?=
 =?utf-8?B?ekg4bUoxc0JYWTd0WnhmZis2WGp0SjFPV01WanNiL0RkMnRXRmp5RWZlZFlL?=
 =?utf-8?B?QnBxMEFjcmxpMllEUDI1cU9jT3hWWDVOVWJSS3R3a0tDRU03TUhwM0xZdXpJ?=
 =?utf-8?B?eTNJVjNyUlRUaWIvOSs5eVV1R3JuQzBDR3VLanhxVEx5Nm9ZeVBxQUVEOXN4?=
 =?utf-8?B?M1Z2YmZTTjVCeUdEQzNlcHVPRVliOVdMTndnZEJiWlNzMjIvQ29TU3NLTklm?=
 =?utf-8?B?eDlMUmdnTFg2VTNQRkFNU2Q1dU5OQjVhVTViRXFxRHROaVpmbEs3VjFiNFlV?=
 =?utf-8?B?Yi9DVlNhWjAzekNsM29xemF3b2RYL3BRNjNsTmFmQXFVYlUrb0NFeXBCT3ZH?=
 =?utf-8?B?S04wSDU2dEdxZnJYMis5MDJDQXNDLzNNVlhsUWJ5NFdMUTVrRHU1WHhySUg2?=
 =?utf-8?B?VUZRZzVESWxSbFpmTWY5d1AyZDRnOUcyVGZabVhCOXVDU1loM01JOTRTWFBx?=
 =?utf-8?B?ZW5mRlUvcFlEVDhsZGNXYml1QXVMeURyRFBQcFJTT1pxckFtdVJNQ2VUUC8x?=
 =?utf-8?B?T2NwcmlidXl3bTNmOWtmT3g0NlFCY095dkZobGpTdXgzNUJQcHVCKzBOY0JC?=
 =?utf-8?B?ZlZoMUpMWDRtYU54Q1ViVzF5Z2lHLzRwT0dPWGdEL2kvbk9rQjFMeFZybnNX?=
 =?utf-8?B?ZWNsdHJMcUJ3a05CQis1eVhURERjRCs3TUs4clBWa3B5dFVjdVJBWlpqbGcy?=
 =?utf-8?B?QW52QVE2QnE3YTZaSDFOWERuNFhkR0libmhsTUtyTy9nNGdaNm5iYmJ3bm1y?=
 =?utf-8?B?SUUxV3QzVEdTa2ZibDIvOGZxc01URkJ4czd5MjFXL3FhTTkyUEhzcGJ3aFcv?=
 =?utf-8?B?KzRNanBRbVVRVFRNYjBlbUlkelRhM1h1M1V6cHBFRTdWOVFsVXJnTDdLQVdK?=
 =?utf-8?B?ci9vbHRjbnJFYXQxck9RTG8rTk1WZUF2ZkIvTEZQN3NjeXhHRkNteWR5T2d1?=
 =?utf-8?B?a00rckRKczYwNUR6TFFZY3ZHdkNIV3BXVWg0VXJWZzBpOTUrZ0FvZDhOYm94?=
 =?utf-8?B?eU4xTC9nTGVocE1halZoZ0xBTnpnZ1FuYVl5d3cvYjEwclhLM2ljTkc1VlF4?=
 =?utf-8?B?dDZLajV4QzVGTldQR3AzREtIdnZ1WUJ5N2ZSVEhMZUpiM1c5Wm9RM3hIdzRK?=
 =?utf-8?B?NUFodzlkWGhvVFBpRkVHZDhaWng0WjRUUkNKQmcxWk8zSTZlQmFiQ0JmU3h1?=
 =?utf-8?B?S09LV1JsTVM1MWV0QXYwUXJDWGxoZ3hURzZBamZvSWROeXZxRDA5N25yVFlK?=
 =?utf-8?B?ZVZKTHRHeERLQkVOTDRhbzFPb0RqK0NDTE5XMSt5N1dVeGlIaHNsaFVNbkFt?=
 =?utf-8?B?RjJFT0tWK0JqbWx5WlkvSXR3NDlrMit3cWxSKzBvUlErTlZvalpLNFM0TXZp?=
 =?utf-8?B?cXBQMDJ4aUtwTDZhYjE2aFBsU1dCdzE4TzRub1haa2JVUFBldlAxbkF5YzNw?=
 =?utf-8?B?MWd5cWtwUXhRMURqVldyR0diQnFyTW56K00zUGNabHJGbUdKUk5XUzdzQlZK?=
 =?utf-8?B?b1F6SVU0UE95MTRWRC9qaS9EbW1ZMVlHZVlxYTFsQ0JvbTRhaTdScEtMVS92?=
 =?utf-8?B?WHdobTFIT0lqNW44em5LSTFWU1hES3U0TE92ZWxyRTg4WEYzYWFLSkhoM3U0?=
 =?utf-8?B?R05mQmpRNWdLejI2eTc3TlB4dzRQdEFpbjNaRFdnWnZwYm1rbndWeStwWHR2?=
 =?utf-8?B?NzF6ZkE0OE1sc2ZGSW1YZUxEVndjblgzUjdwNkxRNk1PNVFKZUZtdERka01k?=
 =?utf-8?B?Z21leW4rRVpBY2x6RGVKZkJzNnJNTGN6ZWZsTkNSQ0NEK2lYRDhjVU9YcXAr?=
 =?utf-8?B?UkxBSERWbHg3WktjRU5kZVpLdklNK2l3eThuVkt4T1pyZjhwbG5EeFUwQys5?=
 =?utf-8?B?Yzlnd3lWbFNFVTdmRDlvZHRIRmlFd3ZvbEhRMC9IMU1qYk0wSUpTV3pVL01G?=
 =?utf-8?B?bm5IWDd2ZlE0aDVNVVlkeWw2ZjZzd01KU01WZmtjS1RWOTIvN3ZneUtwelNQ?=
 =?utf-8?B?R1libFBucWJuaXRmTkNLQ1d1MzdmUlRRYWJZOFpoMUg4TWdLVXFtbnR2cUtN?=
 =?utf-8?B?WHdkUW54WGsyMjloQ294TmpqY2tBUFlQUnV5R3MxTVhOUm1hdkZVbEhPcGZR?=
 =?utf-8?B?M2lIZm9XRFhvUWdtY3hza20rTGNXYXZDWVdVRVZIZExBOEl4WGpYb1JTSzJx?=
 =?utf-8?B?cDNGVnBFUWwyOVVmMTJJd2hBTnBGVUE3ZFNyRy9JbWRzUWF0QUxuY0t6Q0Yv?=
 =?utf-8?Q?24f+ajDhmNcu/838=3D?=
X-Exchange-RoutingPolicyChecked:
	Gpdjelo7ybUJ9JfluDV3FTcz19PxPSPObxC5tvHM8/E6fQsLOT07XQ3VnXh1TVnip8iYgN/rZ5A4cBj/283XUl531l0X+i/VRvMKLVmd5+6o1JZG1VnrQ8/opEhol5SB9/UTWhXDetm6x/mtxgBmK1G9xgsIfRKwIFi7QWsIxrw5Jw5NGAdH/0Cfy1/NRlcVeZL+hRlXtq3hICADNW3hEqNaVa887K0PGVG/UJxOyZIh7163+5XEIw74KPQjGj2seh0TWbFOvxz1XjDU+uuV6zrdVxpT0YcENVgu9Uosrqls1lm6aJ2PmvSvfvjly2dbOI41AiOvAn4DR9u4xvO6ow==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zggMtqrnNf/7WFhuDQCd+MrS2w/FSSCI5LXK5YsHAgUdJdRjr0j2L46z1W6fSXrm4cgNBbpW9s5HUpnkJ7yzR0kEKO3kX1bc1YenL+LXPLPA9V08UVNWcgis+ciaKgRGvGeYJz8sGQzM+3uq/uwmkspkKywtxPPQiRcwdI83jPqNujhS3nR/N1mhoxUpOaoTZZso/54xV2ep2vZtwpUnQA0ekURSe07pq86vJexXfRM6EiGa+mlik3bbUXuw/Rl4dAimBu8CTsf8aAZCvDvNgVNOEgj25X+CLC+1254wwzRz2VkSNXC8k5Jjwo2KIgddWrDmvV6M+EawG7bDSYvS4CIy04p9yF2D5+sqZ3NDvS1kJPZ0FLw/5iJBKyeAwBHjSFWeGWcMs6pH2/mfUUkmRMh80Fowzsd815seYYIUQOTcZ4tnkQKIgOADjYyV6ZwSPQl6W+Fm3kTKwFFsS+2e8OS68yOk0zmb0kJBEXq+My9AFaGDc5v7bEY/hHac0ygmq7K0/cnNIOszJ7aNBrhWDU9ukANtyzvq08JAhf4V1MKFHWuEJP8XDE2QXbCZGXZDtmJWEpOtKphV8fKsb6wBZ5YUdRX4n0vY0YzM1TLzmyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab757d2-4f7d-46f5-dcd9-08df18142385
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:11:28.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ld0PAfpmOsG7hyHbGDd4lvieDx27R1BKAZtyKWWU4w/L022AaDhf9qheuLFdjGRZ7Z99bVQENe9epqbVoBasrkrcqZCYeO5ukAnT6mPzld8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB998142
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609210280
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI4MSBTYWx0ZWRfXySXnLzbQpEiW
 VQdlhjWOH+DV7e/i+nGiFDJt0V44XKRXfOXjKOo+sgh9n1PjW1PIT8Jz20VcZERT+HLxb/2eyMr
 qmJeBGLEND7XpX3wP+1QpM4nJaYuCVA55IimknJZn5vd6gKkD5LB
X-Proofpoint-ORIG-GUID: 2FB1vYNVTF2hj-RDK0G2KUWJeH__-jKX
X-Proofpoint-GUID: 2FB1vYNVTF2hj-RDK0G2KUWJeH__-jKX
X-Authority-Analysis: v=2.4 cv=LIzz05W9 c=1 sm=1 tr=0 ts=6ab18164 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=RpNjiQI2AAAA:8
 a=pGLkceISAAAA:8 a=g0wLuT5Fpul9m1KLVGwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI4MSBTYWx0ZWRfX4aE7TTYTL8Ke
 4KUnq9S42IzeY9HfndWVQPuLk/AT4SZPYlgYDLBkgea6hEBO70VhTFaS9816FiGloXHYencTL5U
 kM/1QbZKJ6o5/2rrvi6xs90nt3L2i7IDPvUDbA8npNgyFZ6SXSaGJEzhK+AA5MZ/QlWgs+pn+J0
 98eToxT7R6INpP8WGomWi6aG1OQvHW+5kyhWviLkof+uicURkec6TcO4bAC7Cb1UL29Rwtqo3TL
 lIIqVGSAXznnWxPdsJoJ4PGzTsdBw5KrTm9E4tKxLuDTD47dGjstRxJLQBW+8F/nwQjx0wf9W2C
 actODFXN726gFX6AOf1y9gn1vI5xE/oGbkIxypuHBrVrgNIQeGWOlvpnCfwVW2SbziN21ZRxX/s
 YEXypd3FobKzcz19yy7jMtncTvieq5eOKbEpHpTHW0V5txyDghETbI98Q9ECJ1U30WBnxBqFA8u
 DUOXcK+ZdQ92BzzEx/Q==

On 9/16/26 1:46 AM, Linfeng Sun wrote:
> On Tue, Sep 15, 2026 at 04:=E2=80=8A38:=E2=80=8A38PM -0500, Mike Christie=
 wrote: > On 9/8/26 9:=E2=80=8A30 AM, Linfeng Sun wrote: > > vhost_scsi_set=
_endpoint() allocates command pools only for I/O virtqueues that > > are al=
ready set up, but publishes the
>=20
>=20
> On Tue, Sep 15, 2026 at 04:38:38PM -0500, Mike Christie wrote:
>> On 9/8/26 9:30 AM, Linfeng Sun wrote:
>> > vhost_scsi_set_endpoint() allocates command pools only for I/O virtque=
ues that
>> > are already set up, but publishes the backend for every virtqueue. If =
userspace
>> > finishes configuring a skipped queue later, a kick reaches vhost_scsi_=
get_cmd() with
>> >
>> >
>> > vhost_scsi_set_endpoint() allocates command pools only for I/O virtque=
ues
>> > that are already set up, but publishes the backend for every virtqueue=
. If
>> > userspace finishes configuring a skipped queue later, a kick reaches
>> > vhost_scsi_get_cmd() with scsi_tags uninitialized and triggers the
>> > !sb->alloc_hint warning in sbitmap_get().
>> >
>> > Leave skipped I/O virtqueues inactive at SET_ENDPOINT. When SET_VRING_=
ADDR
>> > later completes their setup, allocate the command pools and activate t=
he
>> > queues. Roll back both if access initialization fails.
>> >
>> > Fixes: 25b98b64e284 ("vhost scsi: alloc cmds per vq instead of session=
")
>> > Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>
>> > ---
>> > I checked QEMU and found no evidence it's affected. I haven't checked
>> > VirtualBox because I am not familiar with it. However, the virtio spec
>> > doesn't require a specific operation order, so a new VMM could still
>> > trigger this issue.
>> >
>> > Crash log:
>> > [   34.698961] ------------[ cut here ]------------
>> > [   34.699385] WARNING: lib/sbitmap.c:286 at sbitmap_get+0x227/0x270, =
CPU#0: vhost-82/88
>> > [   34.700542] Modules linked in:
>> > [   34.701309] CPU: 0 UID: 0 PID: 88 Comm: vhost-82 Not tainted 7.3.0-=
rc2+ #14 PREEMPT(full)
>> > [   34.701958] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, =
arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> > [   34.702717] RIP: 0010:sbitmap_get+0x227/0x270
>> > [   34.703247] Code: 41 8d 5d 01 89 df 44 89 fe e8 f5 3a 46 ff 31 c0 4=
4 39 fb 0f 43 d8 e8 38 46 46 ff 65 41 89 1c 24 e9 25 ff ff ff e8 29 46 46 f=
f <0f> 0b eb ba e8 20 46 46 ff 44 89 fe 31 ff 45 31 e4 e8 c3 3b 46 ff
>> > [   34.704234] RSP: 0018:ffffc90000ec3bb0 EFLAGS: 00000246
>> > [   34.704677] RAX: 0000000000000000 RBX: ffff88800500dee8 RCX: 000000=
0000000000
>> > [   34.705166] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88=
800500dee8
>> > [   34.705584] RBP: ffffc90000ec3be0 R08: 0000000000000000 R09: 000000=
0000000000
>> > [   34.705988] R10: 0000000000000000 R11: 0000000000000000 R12: 000000=
0000000006
>> > [   34.706477] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88=
80050094d0
>> > [   34.706955] FS:  0000000014d05380(0000) GS:ffff888099c36000(0000) k=
nlGS:0000000000000000
>> > [   34.707463] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [   34.707854] CR2: 00007c0c3c20e000 CR3: 0000000008e47000 CR4: 000000=
00000006f0
>> > [   34.708592] Call Trace:
>> > [   34.709259]  <TASK>
>> > [   34.709822]  vhost_scsi_handle_vq+0x4a9/0x1b20
>> > [   34.710437]  ? update_cfs_rq_load_avg+0x2e/0x230
>> > [   34.710874]  vhost_scsi_handle_kick+0x2c/0x40
>> > [   34.711292]  vhost_run_work_list+0xa6/0xf0
>> > [   34.711673]  vhost_task_fn+0x76/0x1b0
>> > [   34.712003]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x30
>> > [   34.712506]  ? recalc_sigpending+0xe1/0x130
>> > [   34.712890]  ? __pfx_vhost_task_fn+0x10/0x10
>> > [   34.713325]  ret_from_fork+0x37a/0x630
>> > [   34.713673]  ? __pfx_vhost_task_fn+0x10/0x10
>> > [   34.714031]  ret_from_fork_asm+0x1a/0x30
>> > [   34.714535] RIP: 0033:0x0
>> > [   34.715201] Code: Unable to access opcode bytes at 0xffffffffffffff=
d6.
>> > [   34.715587] RSP: 002b:0000000000000000 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000010
>> > [   34.716158] RAX: 0000000000000000 RBX: 000000000048bb20 RCX: 000000=
000041ca3d
>> > [   34.716571] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000003
>> > [   34.716957] RBP: 00007ffcac47c4e0 R08: 00000000ffffffff R09: 000000=
0000000000
>> > [   34.717418] R10: 0000000000000000 R11: 0000000000000246 R12: 000000=
0000000004
>> > [   34.717826] R13: 00007ffcac47c778 R14: 00000000004af868 R15: 000000=
0000000001
>> > [   34.718363]  </TASK>
>> > ---
>> >   drivers/vhost/scsi.c | 44 ++++++++++++++++++++++++++++++++++++++++++=
--
>> >   1 file changed, 42 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>> > index 4f8c0260bc9e..069a6ff4dd40 100644
>> > --- a/drivers/vhost/scsi.c
>> > +++ b/drivers/vhost/scsi.c
>> > @@ -2008,6 +2008,40 @@ static int vhost_scsi_setup_vq_cmds(struct vhos=
t_virtqueue *vq, int max_cmds)
>> >     return -ENOMEM;
>> >   }
>> >
>> > +/* Callers must hold dev mutex. */
>> > +static int vhost_scsi_activate_vqs(struct vhost_scsi *vs)
>> > +{
>> > +   struct vhost_virtqueue *vq;
>> > +   int i, ret =3D 0;
>> > +
>> > +   if (!vs->vs_tpg)
>> > +           return 0;
>> > +
>> > +   for (i =3D VHOST_SCSI_VQ_IO; i < vs->dev.nvqs; i++) {
>> > +           vq =3D &vs->vqs[i].vq;
>> > +           mutex_lock(&vq->mutex);
>> > +           if (vhost_vq_get_backend(vq) || !vhost_vq_is_setup(vq))
>> > +                   goto unlock;
>> > +
>> > +           ret =3D vhost_scsi_setup_vq_cmds(vq, vq->num);
>> > +           if (ret)
>> > +                   goto unlock;
>> > +
>> > +           vhost_vq_set_backend(vq, vs->vs_tpg);
>> > +           ret =3D vhost_vq_init_access(vq);
>> > +           if (ret) {
>> > +                   vhost_vq_set_backend(vq, NULL);
>> > +                   vhost_scsi_destroy_vq_cmds(vq);
>> > +           }
>> > +unlock:
>> > +           mutex_unlock(&vq->mutex);
>> > +           if (ret)
>> > +                   break;
>> > +   }
>> > +
>> > +   return ret;
>> > +}
>> > +
>> >   /*
>> >    * Called from vhost_scsi_ioctl() context to walk the list of availa=
ble
>> >    * vhost_scsi_tpg with an active struct vhost_scsi_nexus
>> > @@ -2105,6 +2139,9 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
>> >
>> >             for (i =3D 0; i < vs->dev.nvqs; i++) {
>> >                     vq =3D &vs->vqs[i].vq;
>> > +                   if (i >=3D VHOST_SCSI_VQ_IO && !vs->vqs[i].scsi_cm=
ds)
>> > +                           continue;
>> > +
>> >                     mutex_lock(&vq->mutex);>                        vh=
ost_vq_set_backend(vq, vs_tpg);
>> >                     vhost_vq_init_access(vq);
>> > @@ -2466,10 +2503,13 @@ vhost_scsi_ioctl(struct file *f,
>> >     default:
>> >             mutex_lock(&vs->dev.mutex);
>> >             r =3D vhost_dev_ioctl(&vs->dev, ioctl, argp);
>> > -           if (r =3D=3D -ENOIOCTLCMD)
>> > +           if (r =3D=3D -ENOIOCTLCMD) {
>> >                     r =3D vhost_vring_ioctl(&vs->dev, ioctl, argp);
>> > -           else
>> > +                   if (!r && ioctl =3D=3D VHOST_SET_VRING_ADDR)
>> > +                           r =3D vhost_scsi_activate_vqs(vs);
>> Is it ok to just not support the delayed setup? So just do the
>> fix in vhost_scsi_set_endpoint?
>>
> A later SET_VRING_ADDR would still succeed while leaving the queue
> inactive. If we donot support it, I think it should fail explicitly
> instead of causing a silent I/O stall.
>=20
>> Is this a useful feature?
>>
> No current VMM appears to rely on it, but the UAPI does not specify this
> ordering. A new VMM could reasonably use it.

For the current code, I'm not sure what the use case would be. If are
are just saying we want to support the ioctls in any old order then
I don't think it's worth the trouble. I would just return a failure
like you mentioned above.

However, if you are saying we could do something like have a running
vhost-scsi device then dynamically add queues to the running device
to increase perf then that could be useful. I think you would want to
also fix the guest to be able to support remapping queues on the fly.
In vhost-scsi you then also probably want to make the vhost_virtqueue
allocation more dynamic as well. You would want to start with nvqs =3D 3,
add queues are more are created then limit it to vhost_scsi_max_io_vqs.



>=20
>> I don't think net supports it. When it does the vhost_net_set_backend
>> call it does vhost_vq_access_ok. If it's not ready to go then it
>> returns failure.
>>
> Right, net returns an error for that VQ. Simply skipping a scsi VQ would
> make the later ioctl succeed without activating it.
>=20
