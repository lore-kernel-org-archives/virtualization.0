Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812131494CC
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Oct 2025 05:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760073549; cv=fail; b=ojXPrU1A9JYHVqbC4dJsH/Xkl3mL6easdedHbVcqOM4aiID7/XMsWgO/YEZ2aKrragoU+MYaIPloVZ24jX6xyCNDzDowQHT54lsv/tuQb8LzvRmceYM9nZ6jQEdqRi2D+mw1UNg2VeU66ip03qWxur4n8uEurvkhWuCMQc5CGhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760073549; c=relaxed/simple;
	bh=VwyjPPyik9hoULS/Q9ToY3/nHO8UYVOYAHngVreW+OI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a2yEdKahZuEj6ru/z1H26n//fi4mm4C8fvNWoYTpyaMlxaog9Ub1t1IxcS5yeJ8akSS7xJVDrpOgTcILnCXx0WBZjLwYFcSf0t3Ah7c93WUcbJ20hn37u6099qJczwicrJbRVV+03fY4+8fkyE01LqY3EzYiPndDFawWJcDWVLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XcKh4+Uf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C6UvVavT; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XcKh4+Uf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C6UvVavT"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F12C60F0E
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Oct 2025 05:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAIY39gvDD-P for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Oct 2025 05:19:04 +0000 (UTC)
X-Greylist: delayed 2091 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 10 Oct 2025 05:19:03 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D6B8760DE6
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6B8760DE6
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=XcKh4+Uf;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=C6UvVavT
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=si-wei.liu@oracle.com; receiver=<UNKNOWN> 
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D6B8760DE6
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Oct 2025 05:19:03 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A1Nth1027801;
	Fri, 10 Oct 2025 04:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7KmNe8+DgQM/V2lYCFZeWDXtOdFqVnS+s36094Uyrq4=; b=
	XcKh4+Uf77prHnEKjsob4S6AEb12N8k1I/rcQU5j8WB6lLCfmfxmq6WbprZu1TS1
	nfkjXKBviCGhbbrhvXHHPfGK8P/Op/mb7jLL/PiKtuplsYlruR6VbF0L/mrEBzy0
	PaiQR0YjxdFi/lXZo5RvFaLIbbd9jZueqN5WcX/LpO3tDxvE1lroEMwK/UrMlGcH
	XK/0X25gFfTlFRb/a32r18srjpvJy9FjEXO0Xfj1f4XKOy5EaxN6myvkVaqGvXpp
	VGmGrDGq4sO1KjVwdPs7IZtBgapdnH+iDeXxUbnXdI39ecJRyup2SJ81Z+ITFlio
	xMlRJcFGDgzdlf/fwBi59A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8ptx6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 04:44:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59A2mkHE014814;
	Fri, 10 Oct 2025 04:44:11 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49nv688q0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 04:44:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNu52AeW84Kh9UfabfMsADTZ1HZNxnFvtE6BPobiGfFe8xjSHvggbrUZ7uTAmatcyVVCd6jfr6FgKnxKaf++yc6RvUshqocY5CDtInjyAS2WTBtnEtbVoDek4MMWOyKl0hgeXc4ObOR4qIH3PFacwA10vdYdycUdDhE5gIOh2b7nJJB9AWZQInlCE1oD7385m0rijicsPvCKIOtBZF7mGzhYUBMr6y52DG987hTE95WCkB31qpPgJXmKqMtFNh6cKwcfKEUC6zFEp1A/M2dVD0IXWNtuGJtGpRCY+Ll+fARCMZyvlqXy1TU93i4eR3h5HiAvuzmhB48wPg7YP2ftjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KmNe8+DgQM/V2lYCFZeWDXtOdFqVnS+s36094Uyrq4=;
 b=w9oXzziFtqgs/bTGlTkviQW+Z86rrGVCMBlGHZblFHc/VC+rB/d84g6VbLXaJdQpzphDFb5iRQ79PCuoZrI7lgiRcC81KDWWojaY4qngD198lHs0BFGsUEyPykTMbD0f2IJNpd0R+m9oGxEunL3jUXGtkBsvwWG9pPqVJqCBOk7X2lVJE+8aLEQMqHwEcZjrAfIxFyZR0bNiKJYnemlEJGBZCx3uLpqEFazL3UH16YbFLMOjIx6ZGk8/b3qmGNanRpAqf1a9n1yrDegKKFc/pwOfKkpEXJkk7duOF/oM/ipQ0uvbtMb7nUAhMM98PkZcCp0VJlsjkkHyI49Zj2MNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KmNe8+DgQM/V2lYCFZeWDXtOdFqVnS+s36094Uyrq4=;
 b=C6UvVavT3Su/gfalKiC+uIIa3haR9U2ZMvBdwbiuKCEQW73VwJpguS1mooKrJFsUXAFe8QRpLRpnVh434s3B2kv/W3akOg0XNpoc5VE4/S/rlKfzCu3fTsAJx5rFcKL8iAokV4jerUETAFIByOkM52WP0A+m15OIPr7J33he6gY=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by BN0PR10MB4870.namprd10.prod.outlook.com
 (2603:10b6:408:12a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 04:44:09 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::2eba:a565:3a1:571d]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::2eba:a565:3a1:571d%6]) with mapi id 15.20.9094.021; Fri, 10 Oct 2025
 04:44:09 +0000
Message-ID: <eb3e016a-8b65-4547-9755-3ec03e248462@oracle.com>
Date: Thu, 9 Oct 2025 21:44:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESENT v4 4/6] vdpa: validate device feature provisioning
 against supported class
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Dragos Tatulea DE <dtatulea@nvidia.com>,
        Maxime Coquelin <mcoqueli@redhat.com>
References: <1675725124-7375-1-git-send-email-si-wei.liu@oracle.com>
 <1675725124-7375-5-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWdEZbURGZtmobrED_jBq34DnQEuC8kUoPMH5=p2K7NE0w@mail.gmail.com>
 <f5897b60-8e4f-4a3c-a88d-f85be0bc7705@oracle.com>
 <CAJaqyWd2sRSMeR294sQGxyEFg3dPbd5AgUmG+C85oCCZXqCEBQ@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWd2sRSMeR294sQGxyEFg3dPbd5AgUmG+C85oCCZXqCEBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0094.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::30) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|BN0PR10MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d95e142-2f7d-4687-ada1-08de07b7a68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|42112799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bytZd09nekFnWlZsc3BUeEFqWEVhYWxYNENMMndPakdHb1lOelgvYVAxWHk4?=
 =?utf-8?B?dEVsUWlTN21sQmo4ekhRV0p6NnB0YWZXd3FxYk9tY2lHV0xPUndiMTMxRlR3?=
 =?utf-8?B?eHd3R3NIVTFxRm43UDY0Rkk4RHZZcm5scWdsbWcyT3AyYk1mSnpFeS91WVlM?=
 =?utf-8?B?ejFCUXoxalRIVXFUYjBwUTRlSTYwOWtPK1l2aUZsQnpsajlqaUFSQnR5QUhs?=
 =?utf-8?B?bnpwL01MUWUrbkhmSnFPOWsvdzZkcUZqNHJjSHIvb0oyZVFxelR3bmxBUlNJ?=
 =?utf-8?B?QXN6N2hVZWx6RDlpNVA5eUNKbFF5SVRSN2FPazg0cm9NR0d1YmphRkdacDFC?=
 =?utf-8?B?dFAwUnE4cEI4TUtQcEZGb25nT1c2UnpqSEJQa0xHUk5Ebk10OFRMOU5NZmpJ?=
 =?utf-8?B?MmFURytnM0RheDdQUTVQMXNsZHdVdlRBTXEyNWh5bytRb0h4OHBPVFBQQnFt?=
 =?utf-8?B?WjNOU29HcmVpVE44NGFCTS9FMEhQNXprRi94MEVSWW4rWDN1WG1OZTVienVZ?=
 =?utf-8?B?clN6VkpEdTJJL3BWUUtYbzNRd29Jbk0yU3RkY254Z0FsaUhpWW9BNzZpaXA1?=
 =?utf-8?B?RDJvaWRrMUgvRHdsTXI2QlE0L3dITDQwU0VxanRJWitlMTNJNHdZRlQzcEpP?=
 =?utf-8?B?em12VEJwSjMyM0JYK2cvOFAzY1JmUVBsVVZYR0VTaWxZbEVvczZGTlNvdTN0?=
 =?utf-8?B?QlpJWk1KR20xQXZudkJYbjFoOGZQNHUvdmxMMURhclhSczh1OEo0MFZzMjMy?=
 =?utf-8?B?UldjZ0cwKytGK0Z5OE1WNTBDVGxZVWtBc2RZeXhoZ2ZWcHhkNXNVbVJab1dq?=
 =?utf-8?B?NVdLdGZoRXROSjVLdmJsOGtiK20vYlVLTXl3U2h6aWRiamMvVjAreWRFZFM5?=
 =?utf-8?B?dHpybGZJdWRuQm1PVEh3aFNFSkNiUTJrbE5hYnZydWZRZjdkRVBJWGxoR0ww?=
 =?utf-8?B?T1N2Vk42WkZ0aGdEY3JlamdvQ0krWk0xdHJmMTNlblhXcGFGKzFBK2NJd2Q3?=
 =?utf-8?B?Qkx0S0liM0pMMnJZbEdWOTBOYWpGZjQrbWFvZG5GZEhzRnRudG5BU3NSNGY1?=
 =?utf-8?B?SEY4aVo3a2Q4Y01oNUQ4R01CaXBuNXl6NkcrR1lxQm0zbE8zNlZ2Tk9YRkZO?=
 =?utf-8?B?YitJcVJ2dDJRcWtib2kyTmxVaDJmK2J4dWRDVWJ4bUE4eVB5QXluemthT0c4?=
 =?utf-8?B?d3M5WFM2cjJJOFlrNlVWV0xJRVF0eWg1VXdpeW5Yd0VVbDc4THFBQXlBd29C?=
 =?utf-8?B?ZHJYYjFlVnpyMldRT25YV29ObkoxSnhBTTNCbVkxc21YUXlMY0hFejMzbzRq?=
 =?utf-8?B?STIyRXpMZlQwZ2VBNkMvMUhMdlpZNWM5UWJIa3A5MFZhZHM5SVc4Z2VtSUtW?=
 =?utf-8?B?Y1ZXMEhkZnJrRXpJTERoS1NnQzEwS0hwbWY1WGFZTjdhaEtGR2pWQ3E5dUJZ?=
 =?utf-8?B?ME9HMjBYN3NDdE9meHZQbVo2UlVjQmREZnY5VGpwTGxwdm1CcURPRWhSWUJl?=
 =?utf-8?B?cWhPMEoveUJKSlJuK0cxcWhOSGlmeFgrUG1QY2hlcEtXQmZUQmsrVWlnc1Jh?=
 =?utf-8?B?aExaTnYzemY3bmQ1dGIzZzFvVXZyYVlweVFZcDk3L3U0TllTSExYTk85aU1v?=
 =?utf-8?B?UzhFUG1PSlA1QzJkbXA1MTZ5ZVhwaklKbG9xYkJBTVUwSVVPbWVJeWV4bFdB?=
 =?utf-8?B?LzU3MDZBbE9aVjN0Q3JCQlBHcDFJVnlPYnVoOTRyeEdrWG5LU1pnQTB0K1c5?=
 =?utf-8?B?MmJJTnRRc1o4YWlnZXBaN2wvekNWVUVqU1pZM2hGV2ZLMjVMMEY0MFBHTlIx?=
 =?utf-8?B?TmZ4VWdkRnJDYnJjcE5jMlJkRHlSemZHZGxTK250NU9aTmZackdNam90eEh2?=
 =?utf-8?B?NUJzVHJDNEhNU1J3T2xUYnJmL0JjeVBrOUErR2h5SmVvYzZzbFUzRHRSSzhC?=
 =?utf-8?Q?Rt7v1sx12WmkO5fTETnjhmBFCsNrKcWF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF18D5A7206.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(42112799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTgwMmtNVmkzMUQ0NUR4UWpEMTR6cUxQYTdLWHEwMXppOTFhUG40b1dyd2hG?=
 =?utf-8?B?L1FJWXlBSFQ2b1lMMUtneWxQK29kbm1qUm1Bck1FWXJ4WG9CNTZKMDVIZ2tM?=
 =?utf-8?B?TTBteVpUMk5LNlN5YlFaV1hrRnZFUGJQaHpxTk5PY1l3K2F4Qk5lTkVBVUNN?=
 =?utf-8?B?UUVGQng4KzZyUEQ0TWhxY0NtdmRucXZFbnNZUWJnalVsTmNyVXAyNGcyNjJN?=
 =?utf-8?B?LzRKd3EwdWFpYUtYM3RjT0ZmcEx1WWlVRndLN0piRms2MXdYTWd1eEpKR0la?=
 =?utf-8?B?VTQ3WXNrbmlpbGlpV3hZdlFSU3hyZDg5YXlmTWM3QWpmdkp3bElUbzg3Qi9o?=
 =?utf-8?B?ZnVDeE1tWVFtRXRlSlRNK3c2MkkrUkhpYWpJMW45VksxQ3RKKzVKMlRLb1Vy?=
 =?utf-8?B?TXM2NXMwTitaWEwyWTZEd1o5Wnl4TDRSMTcxQ2d4a0p4QjRjWFE5T0RsR2M3?=
 =?utf-8?B?MHlTVG9wY0I3SE1BUXlBaHVQK3hDamdWa2swM0FkZWsvaDl1M2FHell4UWZD?=
 =?utf-8?B?OG9aY1VhNW1HRzlpL3BHN0JYQjhXaGJlRWVUNFIrSmRFcWJiZVk1VlBZaUhO?=
 =?utf-8?B?eHFJRkV1TlVRdDJ6bFc0TE5taTN0RUZNbVF0cEV3dWh2WGlONERDMFRjMWU4?=
 =?utf-8?B?cmRtLzZveExtNmxaUXF4LzFyQlNjcDlVd1dVaDdBaTRxcEJUakVxeWJQZTM2?=
 =?utf-8?B?dHBpcFh1dXhGZjdHOUp1bXBWY21LUWRjK3dRNmJzSXN3enNET0tRdlg1QS85?=
 =?utf-8?B?SDZxakZhcW44Y0gyRGJkODR0aVk5Q3RXN0c1eGprS3dXa05OUXg0VmtueEtJ?=
 =?utf-8?B?c0g1eG5hL3RyMlc3MCsrS0oveVVTYStGY0tEZFNYU1BPN3phei9Kc2JiTFJt?=
 =?utf-8?B?V3lveTZFM0o1alZHR2xzVlltOHg5R25uMHBIZGZYTWkvYlE3RTNpY1hwNlZw?=
 =?utf-8?B?TWE0Wnd2Rmt1Q1dCVVBMUkllRXFiNDk3WXpYVzVMRnI0WENnbDluVHp5b3F5?=
 =?utf-8?B?T3A4NlJyRzBSaTk5dVVXZklrUDVwbEZkd3M2bmJ2TFRYV3BNQ0VyVkF0S3Qy?=
 =?utf-8?B?UnpiRHBqYkpMb3lhR0ZReUpDL29ocTlWTHBWeTZpY21vTDZRNTNheXZ3MjVY?=
 =?utf-8?B?N0VLYnMyeEFrcUlqTnIzZk9JQ0FmUzdFN2xBYzFKNXpISkJPczc3VFVTMzdq?=
 =?utf-8?B?bXFVcVlIRjducE9XcGpMYk1jT1FWT1JtK08wMyt5MW1ibTQ1ZEMyUThZWko0?=
 =?utf-8?B?bHZwR0FHemVsbnBUNG1RTUY0VEVRaTExa1djbDhsMWV6NkNOTGhydHlPVVND?=
 =?utf-8?B?RWpNTEluMkdPd2EwUjhjcEFURUxuS0RpUTh2YzRkeUVmT3RZQ2s5Um1Sanhp?=
 =?utf-8?B?aDRsck01N0I1UzZzNGg0MHJ2a1ZBM0FZL3VhL0Y3SU1ScXBKdlJLUWo0OUto?=
 =?utf-8?B?U01kR1BpNWs3bWpDUEFsUEYyaEZndzFXeW5sWktzSXkwaDB0bGpDbGhwMHdp?=
 =?utf-8?B?akVYOFZ4NWg0bUVzOHVoNTlGWC9QMGs5Wk9lRVRqSnRpZ2U2dEtsV2F2cU1o?=
 =?utf-8?B?VmtUUUQzejlDNkhSbkdRUTN2ejNiMlBKWWh3U2h6bWdKcStRR083Tm9QQ2VP?=
 =?utf-8?B?ZFFjd0p0b2tvNVkrYzd2RjNsNXNKNXAxaG1lR0dZaTZkcWRsYktVRWM1N2NU?=
 =?utf-8?B?YXJpNG9ucFl4OFpObnNlak9lbHBLbVFGQWxMVjRJNDJXakx0TEtUcHplZDMw?=
 =?utf-8?B?NGp6N2pXY0c4MkNFMXNwbEhMelNTa1pOWWI0SXpHR2t4clREMVlwWkJEODJk?=
 =?utf-8?B?RHZzdnhsSXNnZnNEbXVVWkpYMEJHZzlwZVhWbS90aGVxY2ZvdG13TTVQamtS?=
 =?utf-8?B?RWtERWJ2ZEVKQ0w2V3gzaWRaYlVZdlVpU3RNOTlZc2JaTkVIb0l2RERVTnlE?=
 =?utf-8?B?QjdVQytzbnl4RFA1V0FUVWp6TGV3YWZzVTNiME1zZnhxUFF4aEdUNXVqSENL?=
 =?utf-8?B?NGN3NU1JVnhEcVVxa2dPdFNNU3NtcWtnL0VPR015YTErVWxoaDV1RWNYSS9i?=
 =?utf-8?B?Q0s2RlFadHByWUxPMWIvZjdqS2xpNGt1NjBhNmcrUjNsbWRXVmVTVVBtSGhx?=
 =?utf-8?Q?MzUyI2upJSyK+iblBoVzQr1Vi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+sSGJ+G6Fa5NET0K7vdYQa8QjVzfR6WNghPAY25ErYYLgqnotZBcKUox7xrD7T9LTWby1MaWH1fkhwga4X1QHkZCQ9DV1IQprp5Bh4rOIpMz6eC+8S6T3aHfKkC3y3ZxMxBkDMH66vPOZ5pI9Dnb2wzCWFObPROHoX1WxCmB/ULaMeW+EeqiGWpAvqMLSchauCFQGGAYO9w3rv2qT9NL4ci/gVq/K0CLMAypVU2EiJ4x/SDpzkvpulh0Lf89isVj4PPTid7wm0tsIzVNVscnMdFL1a61PMr8Zb9hImWNFR8R1La4ADIFeQ8cZnh7g1pJ6+MJO5m2prBhuDLco9JkAWAj4XSBpxeKmXfEFpOmPzkbKl2LG4tZTuYwMC0lAhLmd1tanSjceQhcxTPH6FkQbtMbgxWnehiAzM4RUYRI6pjo0FWL2ngu8rz6Vz9e1Vgx3GB2wkXz+EREwCssDh3n4z2DzA0U+oFX9TN+ug226B0D8WZDLmNuhS3m7eKxtlHYBb3EIHRt8T43wFeILglqCy6FX2WNNLYvxiotvMIzuk7EMWsinL87RbPG3tyyqEjkRylOhQ9cKAHFuskxbL+7cTexPuohMxaQoTjBjPeroC0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d95e142-2f7d-4687-ada1-08de07b7a68e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:44:08.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34vWryK5mwmyX7fsyoVlDYGNTi9e0YZixKblyqtw/otf7Q2O4PiM2C5G3lm8FUvC6qG4iRXLxl+qxT1cOsd54A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100024
X-Proofpoint-GUID: WTQgXGwpH7NBpytvwurtIKTzjMJ94ROB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX1lFG670bt71r
 rMJgcx+1pZgShiR0de5IaUtldg1KoQCypblo4Zn/Lp4pNcHwq+djWexTsTmeG0/M92ieScjsNz0
 UCUFFA+xwrctvU3E9Q/2BJjojYhHbnb4Sq7zS8Nu1Ufpjazq1AbOjk7flR9/JeZsAdBIPDtWIla
 eiWzh6cKOUV6HQq3UjvaLmNPRmZd5SOzHCK5x/l1zRoe7ZdZ7Bo6Q97Tp2yLDb3438+WZUvLDab
 QrSVxuUyI/wo4QNqAHemBVxpz8qjlrq7cKNvSfn6Im1Aznh3WLcwlDIiEZAQ6rpGirMzuIqKddt
 XIZ+kRJvE47bnmg15ZCFmDMCMK9/LupGxSTJOLhleN1pho8bi/MSXbV0Bi5EAJsIkxsqvwspi8N
 gGZS4oqhiUZ08znxkiN2h+hF6gU7gQ==
X-Proofpoint-ORIG-GUID: WTQgXGwpH7NBpytvwurtIKTzjMJ94ROB
X-Authority-Analysis: v=2.4 cv=U6SfzOru c=1 sm=1 tr=0 ts=68e88f1b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TnsD2spFoe9SlE_7TosA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22



On 10/2/2025 12:27 AM, Eugenio Perez Martin wrote:
> On Thu, Oct 2, 2025 at 1:27 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Hi Eugenio,
>>
>> On 10/1/2025 6:26 AM, Eugenio Perez Martin wrote:
>>> On Tue, Feb 7, 2023 at 12:15 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> Today when device features are explicitly provisioned, the features
>>>> user supplied may contain device class specific features that are
>>>> not supported by the parent management device. On the other hand,
>>>> when parent management device supports more than one class, the
>>>> device features to provision may be ambiguous if none of the class
>>>> specific attributes is provided at the same time. Validate these
>>>> cases and prompt appropriate user errors accordingly.
>>>>
>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>> ---
>>>>    drivers/vdpa/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++++++--------
>>>>    1 file changed, 50 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>> index 1eba978..8da5120 100644
>>>> --- a/drivers/vdpa/vdpa.c
>>>> +++ b/drivers/vdpa/vdpa.c
>>>> @@ -460,12 +460,28 @@ static int vdpa_nl_mgmtdev_handle_fill(struct sk_buff *msg, const struct vdpa_mg
>>>>           return 0;
>>>>    }
>>>>
>>>> +static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mdev,
>>>> +                                   unsigned int *nclasses)
>>>> +{
>>>> +       u64 supported_classes = 0;
>>>> +       unsigned int n = 0;
>>>> +
>>>> +       for (int i = 0; mdev->id_table[i].device; i++) {
>>>> +               if (mdev->id_table[i].device > 63)
>>>> +                       continue;
>>>> +               supported_classes |= BIT_ULL(mdev->id_table[i].device);
>>>> +               n++;
>>>> +       }
>>>> +       if (nclasses)
>>>> +               *nclasses = n;
>>>> +
>>>> +       return supported_classes;
>>>> +}
>>>> +
>>>>    static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
>>>>                                u32 portid, u32 seq, int flags)
>>>>    {
>>>> -       u64 supported_classes = 0;
>>>>           void *hdr;
>>>> -       int i = 0;
>>>>           int err;
>>>>
>>>>           hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_MGMTDEV_NEW);
>>>> @@ -475,14 +491,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>>>>           if (err)
>>>>                   goto msg_err;
>>>>
>>>> -       while (mdev->id_table[i].device) {
>>>> -               if (mdev->id_table[i].device <= 63)
>>>> -                       supported_classes |= BIT_ULL(mdev->id_table[i].device);
>>>> -               i++;
>>>> -       }
>>>> -
>>>>           if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
>>>> -                             supported_classes, VDPA_ATTR_UNSPEC)) {
>>>> +                             vdpa_mgmtdev_get_classes(mdev, NULL),
>>>> +                             VDPA_ATTR_UNSPEC)) {
>>>>                   err = -EMSGSIZE;
>>>>                   goto msg_err;
>>>>           }
>>>> @@ -566,13 +577,25 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct sk_buff *skb, struct genl_info *i
>>>>                                    BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
>>>>                                    BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>>>>
>>>> +/*
>>>> + * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
>>>> + * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
>>>> + * all 64bit features. If the features are extended beyond 64 bits, or new
>>>> + * "holes" are reserved for other type of features than per-device, this
>>>> + * macro would have to be updated.
>>>> + */
>>>> +#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
>>>> +                             ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
>>>> +
>>>>    static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>>>>    {
>>>>           struct vdpa_dev_set_config config = {};
>>>>           struct nlattr **nl_attrs = info->attrs;
>>>>           struct vdpa_mgmt_dev *mdev;
>>>> +       unsigned int ncls = 0;
>>>>           const u8 *macaddr;
>>>>           const char *name;
>>>> +       u64 classes;
>>>>           int err = 0;
>>>>
>>>>           if (!info->attrs[VDPA_ATTR_DEV_NAME])
>>>> @@ -649,6 +672,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>>>>                   goto err;
>>>>           }
>>>>
>>>> +       classes = vdpa_mgmtdev_get_classes(mdev, &ncls);
>>>> +       if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
>>>> +           !(classes & BIT_ULL(VIRTIO_ID_NET))) {
>>>> +               NL_SET_ERR_MSG_MOD(info->extack,
>>>> +                                  "Network class attributes provided on unsupported management device");
>>>> +               err = -EINVAL;
>>>> +               goto err;
>>>> +       }
>>>> +       if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
>>>> +           config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
>>>> +           classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
>>>> +           config.device_features & VIRTIO_DEVICE_F_MASK) {
>>>> +               NL_SET_ERR_MSG_MOD(info->extack,
>>>> +                                  "Management device supports multi-class while device features specified are ambiguous");
>>>> +               err = -EINVAL;
>>>> +               goto err;
>>>> +       }
>>> Hi! I need to question this last if() :). What's the point of error
>>> when we specify features device-specific, from net or blk?
>> Because device specific features belong to different feature space, for
>> instance, VIRTIO_BLK_F_SIZE_MAX (1) on block device and
>> VIRTIO_NET_F_GUEST_CSUM (1) on network device both use same feature bit
>> value of (1<<1)ULL, but they belong to different type of devices.
>>
>>> In the VDUSE case both blk and net are supported. I want to use
>>> device_features to limit the net features that the VDUSE device
>>> exports.
>> Then we have to extend to the vdpa CLI to add "class ..." attribute to
>> explicitly indicate which type of device the creation has to be, so
>> eliminate the ambiguity entirely.
>>
>>> Also, why is this limited to only net devices?
>> Actually, this is not limited to only net I think, we can even remove the
>>
>> classes & BIT_ULL(VIRTIO_ID_NET)
>>
>> conditional if mgmtdev and vdpa dev instance is 1:1 bound. But at the
>> point when this code was written, it's not clear to me how multi-class
>> can be supported - such that does it limit to one vdpa instance
>> supporting one single class 1:1, or it is even possible to support both
>> or multiple classes (multi-facets) per vdpa instance i.e. 1:N.
>>
>>>    does this part:
>>>
>>> classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1
>>>
>>> Means that it is ok to specify more than one class as long as the set
>>> does not contain net?
>> Exactly, that's why it is coded in that odd way. For instance, if a
>> multi-facet vdpa instance needs to be provisioned with respective
>> feature bits for both block and iSCSI device types at the same time, we
>> may have to extend the CLI usage to support that.
>>
> Right I get the algorithm, but I still don't get what this is trying
> to solve :).
Well the code was written at a time before any vdpa block device was 
added to vdpa, and it was anticipated to expand the same to other type 
of devices. The feature bit provisioning at this mgmtdev layer is 
expected to be only meaningful when you know which type of device you 
want to create, or it may have to defer to the device specific way to 
provision features. vduse is the latter example where it has the freedom 
to defer device class binding and have its client drive the feature 
provisioning.

Thanks,
-Siwei

>
> Let me give some examples: I've got a mgmt device that supports blk
> and net. Now two operators want to create one vdpa device of each
> kind.
>
> Let's say it is VDUSE. The userland device is able to set its own
> name, and their creation is atomic, so there is no way to set the
> features to the wrong one. Let's say one VDUSE device is called
> vduse_net0 and the other one is vduse_blk0, so we can tell which one
> is which with "vdpa dev add name vduse_net0 device_features ...". We
> cannot set the device features to the wrong one.
>
> In the case of mlx the mgmtdev is already a net device, so we cannot
> create two different devices of a different kind. We could provide a
> different feature set depending on who is creating the device if we
> don't want live migration, and that's possible with the current code
> as long as we can tell them apart by the name.
>
> Other devices already have more ids than NET, but not standard VIRTIO.
> Others could have only one ID, being that VIRTIO_DEV_ANY_ID, and I
> think that would pass the test and allow you to set device_features.
> Then we have vp_vdpa, which blindly passes the one single device id of
> the PCI device and I think it would allow to set device_features. All
> of these are hypothetical as they don't offer the
> VDPA_ATTR_DEV_FEATURES to the vdpa core, but I think they should be
> able to do it.
>
> So I'm not sure if that ambiguity is just solved otherwise? If not,
> could we move that to the specific backend?
>
> Thanks!
>

