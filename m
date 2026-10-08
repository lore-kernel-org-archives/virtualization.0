Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3D33122A
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791503549; cv=fail; b=u4B1OQtmpoUhEb+mQZihkv0Jszrsq8qy+Tn1bHvQw7TUK4AAKvYr7ybhbgMZ6XM4aBHyCVNl0x62hyEVgbDTMIVQ9rrMCr0xHr9+5K/BjwtQ17jighHcDf3xs2pa8hksUnxdyTi3uf1TXCr72MiYuHSXK/2QwaUxu+5eW2zMRqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791503549; c=relaxed/simple;
	bh=U3LAeUoa/jrkabmdDGMr63T8nKSFGfkCAhThNgpgCFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ffaLRTb1oghLXqY1CbrHOj6YPDGwOGahmR48hV6ozjpFgMXkmNbBz3RWS4WYVJNmVKpogDQ8iN5/MZoG0//GvJwbP3ypu5MASSCowWjWdA/azTaIL4E3eOTKfTrOF8yiAVvAinQlCWEW+yEr+IubWRoS68JsnStVqP/2DGQ/KxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hu94xc14; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0SkJmsYd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hu94xc14";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0SkJmsYd"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698K9weM1664742;
	Thu, 8 Oct 2026 23:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VmS8GTJ0HxjOAXi/ZxKW1m/5tyChtGFD6PHTe3YAxoM=; b=
	Hu94xc14HHuPQsRGW+4BlS/ekV6Aq2fF/OV2Ds/ld7szEoQe57tuQeXoQ2srx5Vh
	5kjvgTer6983bfSHUKRddHmm/NQo2AGkj5uv67/8BPfT1MJd5AAyoEOeybWV/qqV
	ZhJSCkwsNKV4HGImytpjPHmMGeJX5WEaGWHD2EtkktdOaq/Wu1CgTjGbNTjJ7+Ky
	c+jIFkzYSt/yIl42SJDprWhlvX5etIfuU1fTQ1fMpVgANA9eI1GqvM3HDaJWt9bx
	cj+VAXGZHOFO3gt/aPlN1K+AraIVyz/Q9wQALP39JCyl6TF0z4NfZTwSFhwrXfWd
	6ULf+Q4nsUU6fG+Ln3/ITg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xehjbk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Oct 2026 23:52:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 698Nk85O021754;
	Thu, 8 Oct 2026 23:52:25 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xewsyjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 08 Oct 2026 23:52:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot/k0Fx3CKi8gpSKuwJkNcn3fmLztmaRXy1sSyGJBka3Tr2RkmHjoBimo+G4BJQ2KyO6uc0D0ik2wXxQBjfcTMMmmCyxpA3D+w3fZNA3os0AB5X21jTpY5oT9OZgGj2fApzhHLK1QlUpx/Q8heEP5pdBStU/Q5zVroXZJk8SLKE534HNq9crwsvnMqkeBMFs892HdI2JBm+SUrNbLDwKnH9Vn6omq4CweuuRS4Q0TXPsC8yAeHSPdnN0+ukLFOxUlIgN/4tuWdY8zOIAQ4QBKV5HExXPJFPoi6cAlYLeeQqYhepTJMeFBtRyTyke7BoWYSDUVC1doRL0X7JV4gxJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmS8GTJ0HxjOAXi/ZxKW1m/5tyChtGFD6PHTe3YAxoM=;
 b=fiOiMYhGrAh2zhWtphLKN1doIqP4yVon/NQXJGfk2RtTxqIgagwNIkD92xaje6NF4Na6+UdrSjy+fw9HaixsmOpOepEmZvV0PyRlD7bc1bdJhxREfoLm+DelepGAZKnqhqZmRchRGDurCN5+MXfsKbmjm9P7tUu4iyuwsWDZItqw03P23MD1A4j828XmGDjPwgSWSRAOLa2594TqMHg5X+rfqxyAEWJq75KVOSmiFACd0t8idad/cC0D0IBZXl1SfgwWkglgpt09HO6pXz7wmTNXhGd14AamgzI+ehclefapD8I//NVyiklizXRwJnHsEJc0/2PFcYFoumDuop4WSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmS8GTJ0HxjOAXi/ZxKW1m/5tyChtGFD6PHTe3YAxoM=;
 b=0SkJmsYdEWr6fXFP69irgistH3wnwy+G8SytsxD/R1/iq6neW3OdGXCoKOb+oYXNHrLMyUPRYT66KtW07SqN7uMmpq7ulo1mfvtTjaQx+7f40iKfzQSYN9UGUK9vEPXEjIGYaxlBrFzAMUmIPkSiXrJfWx6Mz5z7E3c23H6cDnk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by SA1PR10MB7754.namprd10.prod.outlook.com
 (2603:10b6:806:3a7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Thu, 8 Oct 2026
 23:52:22 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::d1ce:85e9:74e4:3120]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::d1ce:85e9:74e4:3120%8]) with mapi id 15.21.0522.002; Thu, 8 Oct 2026
 23:52:21 +0000
Message-ID: <08e68e3e-172e-4349-825e-13bafda8c365@oracle.com>
Date: Thu, 8 Oct 2026 18:52:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-scsi: do not count PI bytes in the data length
To: Jia Jia <physicalmtea@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261006082102.27085-1-physicalmtea@gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20261006082102.27085-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::26) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|SA1PR10MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f9b0be-39d6-48e5-5042-08df25973192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|56012099006|22082099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	smcpPJTO4jy6M8PBC8bHAamgojLGIIZXXFaZpHYK2xsO60qQ0HwtfQH48d1E1l7jJ4NNWf58Z82ZfTGwxB2IlJg3QAUi49cPfrn99UYJyNonAQHAVXwL32yOiOmhYG+vC4zkolDzFJSRp1iMX3us4sEP/NjylhxTZfHvPA1Y1Yv4LReqDBdxK7DSrzI8YVDrc1VkT4FOjThRa56Um6pqkbBTU1z34mnp8Xe9UWo94eQaxEqtc2uppYdhT7nLT8ytyYrVjG5ZgZXxqzz4mavavDYhduXa63wCwoSIyFIISg43L4LJvu/e8oW8S9jcc1xAI9aLd8DrtNTBnA++I3UCuIqjl5hEs24CveGljvbEofrnDfyDYZEvipyybaHQ+26dq00rAUn41+4d0qrCubnYV/8vqIzNos1HUGPBv+q19HixT+6dTTWepovE+IWsVcGBRaTOfgaatppNeVjIn2OqrDQG/WmXh2k8qwtnV6UPOK0VMefiFxebfsfe8XoNpHFKQ4NqbJs0iJeJq3J1hTByH8I/zZETG1CQ4hE7R6TprC6pRNOZB9A5CRD0KpZoQu2OWOQtFWxSqiUvXlninnte4RWxhh+cdk25IfMYiUopkINV2y98vrJezCG2sVBABFw0nJJtAB30frZ8Sa7M2BGiMQfgMXGsKzYczN2+YB9iNWc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(56012099006)(22082099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWlYQkdDOFI0VHhIQWRMeWN3WUQ1ZU5USGZvZS9tUko2SVNjN2ZEVU91ZllR?=
 =?utf-8?B?NDVhaFBMOVBqK0Y0UHlQQ0RvUFZWWHBtZk93cGYrTzFlUDQwMUg2RncvWUxv?=
 =?utf-8?B?UWE0V0lkNnZySThPMmFqMXl0TURGMy8zUnNtMndxcFR3SlVMSStyRUk0VDEr?=
 =?utf-8?B?WThSYlNWUHdrdmNsbzNaeHFEbGd2ZXhXanVmQi9FRTMrZXloTFJpNkppdGxp?=
 =?utf-8?B?UUl4ZldVcmpOVFBuLzJYNmI4UjdSeTU0U2VzRCt0anRXS056OWlYV29PclJW?=
 =?utf-8?B?Qk81QWJSdTZ5eW1VbzRLTkE5bWJ2czZpVHJobitYa1B2L1dyUFNDMFdCVWRJ?=
 =?utf-8?B?MERwTFVyNU1iaGZqbXE4aWVhT3JySmlIQUViNU1scEI1V2QvaG1MbFliQWJI?=
 =?utf-8?B?WThjeElqZGRmQ2JpSE9FaXh2dmNkOVd2MVBNa3VPdk1YRUdPVGJ6bkJMdzN4?=
 =?utf-8?B?VTgzdUdwMDNjWUlnVlMwMDZiV3VhSFAyR1E3VWV0U1ZuZTQxcldLY0hnNnJM?=
 =?utf-8?B?RkVQY1FvVUlqc011Q0VpRVF3Qk9wemVhM0QzZEtZbDN5Mk1PQ3pTNmZ5NHdE?=
 =?utf-8?B?WmZsVlZiQzRnckFUM2EyMWwrTjVSTk93SnJMVFJCRkNGVU1UdjVlZVRkKy9Q?=
 =?utf-8?B?S2hsbWZMRE9rMXJMQXptMkYrYkMyL3ZrRVd1aDNhd2U2aFBlUGpRK3RRNzAz?=
 =?utf-8?B?U2lLOUdwbjVvS2oxYjIwdmo2MzA2c0ZtcnJOWGRCTlkyT0xEc1hJTG5wNXZG?=
 =?utf-8?B?Mkt4YkdLcFlZZC9yT3BvTnlUNndCbVQyRWZCVXlKVzRUT0F2LzNJM3NYaFVK?=
 =?utf-8?B?RWZBTVJyZENlQzFFQUdManBKOVZFQUdHMDNuT3I4WU04RVFWWVZVb1N0Rktl?=
 =?utf-8?B?M3lDMWVjZUZTSHNYVFpRSS83TW9MN2JiayswOEZYQW5GTlRDK0pxNHM5aGQv?=
 =?utf-8?B?NnVPemtDOFhYckd1d0Q4dUZ4S2VHNzRwdHVpbkw0R1o0Y0g4LzF0UHNZMGtD?=
 =?utf-8?B?YVk0S1RJQXVmd2JTN0NvVHFTejV5dENBaGhvcUFTWWJrZkwySk92djUxOFlT?=
 =?utf-8?B?bTZqWDJLWExpRHZoY25ZN3pqbVlJNnNtRXd1NG5CbnJYMTBqMkFKUUJOQ1py?=
 =?utf-8?B?NS8vaWRnM092MmNQL1NIcVJVVzRBKzdIU2lReVB0MXlQOVdNVlU3YXBCQUFI?=
 =?utf-8?B?azNyU3dkRHRIODNNT3phN0JJejRBSFprYmtCckdITVZ6QlZEUjdkdERjU2lp?=
 =?utf-8?B?MVdQa3NsNStYdmRtNG1lUUZ3b1JRazU1SHZLbzk1dEtHSkNlaHE0VjNTVjZW?=
 =?utf-8?B?TGN1SUpGWHZaSkhscXVZSXppWXB5YU5hZGZQUFk4NFZTUURvSVV2blR6eC9z?=
 =?utf-8?B?MWt6RU9wbTFOVmdMUTBxelJocCtzMUF4M1NpOXBsMVFGelU3L3lmY2xsZHVs?=
 =?utf-8?B?QS9oWExidkROcG9nWWszYXZxMVVab3doV0hpNUNqTVdiOC9TOFZHdGs2VFR3?=
 =?utf-8?B?OWVoOWg4c0kzdFdkUHJSTVNkOVpFZnh1SkwxRWViTFVpT2FUYXJTMGd6QjlW?=
 =?utf-8?B?VjJ3a0JLb0RWOU94VlMvdEdFMGxQeU9POC9wQ0pIUWJEdzFkVjhUSk5IMTc3?=
 =?utf-8?B?OTBGcHc4aHh5Sk1ONDZhRmtJNHhHTFA0azVvdUxDdysrSm0xL0lucWljSzdy?=
 =?utf-8?B?clBLcmlvSndmMFR1dFdvRmFkNXJyV0FlYkxUWmNmaGluK21wT0pOY0ZmWGpv?=
 =?utf-8?B?YWFSM2VZSlBRakpYVGdpK3VSaFhUL0NUSk1pMmlKbHhtYXU2OUd5VTlvbWtU?=
 =?utf-8?B?SjNmaGNqUUhKQXlmNEQvN2g1ZzBMYW1UK3MwQXN6RTRmdm9LcEJTZzlYcEhq?=
 =?utf-8?B?Y0NrY2FtSTBuQVZWM2ZNSExwcTJjSm9QVW16eUdxRU8vcDVzVEk1U09sdTZR?=
 =?utf-8?B?NjFmTG5EbTFEWDVkQzduMnBmbzlHMVdHR1ZLdSttaVBTQmRKTjNrZ0VrVm04?=
 =?utf-8?B?RTE1ci9BbE1sSXRKUC9rVEtkS2hYTVp6WmxQSi9USFFNck1sc3QwMlJKdGk2?=
 =?utf-8?B?N0pWNUlNZWVyZEJhVGNCREFUeE9iaExaVlQ0bTFSaWhmSUxhM29PcHdkWjho?=
 =?utf-8?B?U3RjU05nVGtBVldzZVVDcXZYR2l0b3dmRVBkQ3pxdTVlWERxTlBYaTJCdVNR?=
 =?utf-8?B?REhqR1RjaG12OGxWUWQ0TGVCVlJjWDhodUJuM0JtSjBsMTBNRDZ2V0wzVXo3?=
 =?utf-8?B?RkVORnJ2OVlSalhvRUhTRHdvTTk0TGhPWWRzamwyYk1aWW0vVG1JTUQwVElK?=
 =?utf-8?B?VkZPZmhBSUVHU1EzLzVoVG9sZEU4clRvNXdITlFYNUZDMGptZ2xwUEpOdUFF?=
 =?utf-8?Q?JGuy6O8byADvsg08=3D?=
X-Exchange-RoutingPolicyChecked:
	W1Asgp+xHpdslyZMvfBUnkrTA6JKo4Fdf5oanEqa/eyMM2ypu78W9u+JNtTelX/5BzCOchOzo7l0U/Bm+VCkk+4AMwBe/3LgSblsRrCHNWnZK+A8sJDv6r5+AoOP6gF4NwvRRkslPyr93c/ImdH5LhcWKR+fNFjd+OhPE9tIPvhfEa0fKENDFWJ8Z9t9k0ziYGsE93Gss+hRt7QPlRMAIIEVPxI40r50mvO4Y0/9c36XoqJRKbUS7DFiD2+sTNcgLkd7CKv37/gicilV3Ybr+NSJ5zJ0oFI7ltI0fqC9fhBtMRQVEBFhLSqDx6ygRRSHNkv5/lh3nRRuUAwk9P6phA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PJ04IyqytFxdTRWNbXM7P0WcIHxRghBI4dBac0uciiGReWF5o2wyGQdR8eCWllxXEDkp58FKbmfM3reR+Gd2RWQM1K2jv3CzJtj7LcpnBzz1ITzkJlxMWy33eNYETwpwqHsZyw4Kcer5JVik4EfTghHeVYLW/33RBQYxj6YjQygMVP8cIcGN3k/jsAd42tjdHEFLGRphjZ0yUAjVetP0/F9/+xAZ87u1Mk2lPY5uKqZHD9/SX7TrqLHSTht7VW4lAWE+9JylUErVRUiOXWUUFmA7zUxB2On5p0yVAFqUS3XGsbrfRYEMertrw23ZC2cz/CNO504e7yJpYZSUMb6khiWePZx0OoEbnDuus7MZC2TdjxNwRMs6OQdWs66D4+8QkvA8shaQ2z7gNlOWG2icoSy6QtUFXN9hw0KLB7q8NdfcMgxXyDMt9v0/T/KF2Rho6YpdQY71JyWhr+lGPzZVIdiGx/f2mhLa+z/tHfx5hicWkW8zKi2NCKqz+8yy+Cp6kmAGWpKgfMt3eSUwd6pi/d9tTBuMFYm7OljYpBC6MMB08fKJfUvIbQXRKxWbwmX/PBW8jUK72rw3uqK5zXT2yPqgQ2b1IJX3BEadSs7C//M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f9b0be-39d6-48e5-5042-08df25973192
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 23:52:21.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFpBRgTer2tKzEQJX/rhgJin4ZI3i7dTvUKAYuQC/0NFwtjdBY4JboMENzAmYtzqPWHUGjgHVZ9q/KGoipd1ano7zA9WG6EiMRBxnlk1JrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=634
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610080094
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA5NCBTYWx0ZWRfXzAfTUFIrv0Hr
 aQEsGHKvJ9Shm86GLc2JZB7Y3sEpU8Q8RRWT3DAsgJ8pc2H+RWaTkv1W4O7RqauodxI7jjPgvz7
 4uuOhJLk5kiu2d3rbnSvK0x4gzf31KY+jJm9lnXitbl9GGtAJE6L
X-Authority-Analysis: v=2.4 cv=dfkVTnXe c=1 sm=1 tr=0 ts=6ac82cba b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=T9uEdZtcuy3REEd8:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22
 a=EzmVwL52lzPS3ErpwIwA:9 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: ycNZzzsTwWXNCO5xKDU8lGR8Gj6oTcpo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA5NCBTYWx0ZWRfX2nnsb9kjgH8u
 agTF2885hqIc3ix9EbpUNWicAZWwz4pnbpdIUmUzr+11O2lsy86TBG+KjYB+gXhDbT3fwOWmTNc
 DNBg0eH56Arc2FCAjvfLXwvOUJZfRuVpug8rO0DmhfbQcrQuB3ta+XqQ3WhXL2LOlRpOzQ8cgUQ
 9MT2OtxuJ3y/6/alAxG+roQpNOSMJrUOdyRvw+kU4Buc9PwGpaRmVFcfUGPTofYxeLKdQLnqMF+
 lHWCJXI5dsQFJQCE4OiXJfQ2IGopgiKQ08R4vudW+jCOxl0jwRWYW+qi9NOU6i5aevZlxro+OgR
 tdyjLRmkfeCVyzSK3rbGl8xQMsO2U/bEVzfpPsEs+j87T9Hvusg+P34jmvqfrdUTyJHAxHZK3mV
 zgxyQXF/PVT8U4Pi2CdrYwyFfHx5Tsrz5Gb4EERAokCJWtRjRNeEmhtVSYPtKsqRbUjYf6fuwRH
 /F+OVQkbFjH7TJpT1pA==
X-Proofpoint-ORIG-GUID: ycNZzzsTwWXNCO5xKDU8lGR8Gj6oTcpo

On 10/6/26 3:21 AM, Jia Jia wrote:
> vhost_scsi_handle_vq() moves pi_bytesout and pi_bytesin into the
> protection sgl and subtracts them from exp_data_len.  The length passed
> to TCM is still exp_data_len + prot_bytes.
> 
> That sum matched an older target path which subtracted prot_length
> again.  sbc_check_prot() now replaces data_length from the CDB only

What patch changed this? Did all the drivers except vhost-scsi get fixed?

> when the protect field is non-zero, and only for READ and WRITE.
> target_cmd_size_check() leaves a write's data_length unchanged when the
> CDB size is smaller.
> 
> MODE SELECT, SET TARGET PORT GROUPS and UNMAP then use data_length as
> the size of t_data_sg.  The PI bytes are not in that sgl.  A parameter

Can you have prot_bytes > 0 with those commands?
