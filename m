Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF436B
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 04:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760071207; cv=fail; b=Nk7ODo5bdswvb4GJ3SqswASLPijYR/3UNII1BjgVmHXRe7GezTVxlgS+RkgwoG3y+cI+Hw7yhmVLUC4YIrc9Fj8wJnfnsfqsnNsXqGMfFZP6wjbzyg+99tDIJEHOk74YqYTMrd6YE0Xlz3Ne4G2yBQDtB31WF+Rh0cgKaWfGD6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760071207; c=relaxed/simple;
	bh=6aLh9SdZ27V9vud2xp78VdFjQQeM6BWIZX7dsQuuyrA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ob8wxUJSqxNGMHpoVsd+DTPpWG+JfLsuqNAWuZMrSmx2q203HM5R1DN3ahqTJvWrAVgwoRlXF2LEeUJCXs4VKNSiiFXf0hgUIN/8ruZKvs64x4J4mqV9pO5Zi/R0PH32sndkTapaBkh3m1x3vfAXExfk6GusBrf63vfUvZzWo4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n2ebZnm9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BvH32reR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n2ebZnm9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BvH32reR"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A1Oua6026243;
	Fri, 10 Oct 2025 04:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hcT5ehns9DgByfBlwJBs+rJdBjnmG0Fu3n5nrZpVyzI=; b=
	n2ebZnm9bh4QiDiNbVb6SElOpSJVeeQNpdyZs33UlnP/uf6sivfrMA0wXs9SzvNV
	cCZU2QIThty80y6c3NqYUTsHQnsDGk8YVXEdVTZgzv05jj4Djxn5m8igbaLfsLR6
	L7wEtt0ZbXYu7S8Lm3hTac/+5PUQl0ORnp1wtgUmBy6CxZFgJN3wXt3EufgKkOUj
	1xlTqDi+C/+a1SZ44mky020RxsyNA4KJjdCjTJDgaHKiqOO00aMaoTPOd04M+5+C
	kHkHrvi71ThxLmIfcSY/ndLDjhArPZQnVusRiXRCXpjdp9omispoEZleNR4758Ic
	y0bBIByQqBTYAMeFgcXzwg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6btw14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 04:39:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59A0xrnV029170;
	Fri, 10 Oct 2025 04:39:00 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv68rrdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Oct 2025 04:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPtprbiKQ9WQ8sS3FBn/18EnqPL+FlerTtytZgcvogsQ+N2OckuR8BdlSpxX2me5yfrIZQxyk2giGhodFgwQIEckjoa8kWE4egvfVnWBcqBtSXv0H9KnSDWcYz6z16v0FEfQF2CEWzDl7+xNfU+rlJKlduelli3yy5A447W286nti07P59KjNnTcraT/RLeNMXGhoJs0QKXPZsIPeZbr6nIEeZ3j9IzpKCipZ07gM/9JL8+tESaKAmXtRcaVqzEjd5dc3/wDsW2vIsNYo3ItNUjHJTCX08Bo8P+/1iGJVmjYaxkq7JcjQpFKDIuV5dG2vbBSjBp5zFTyXAp1ovt/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcT5ehns9DgByfBlwJBs+rJdBjnmG0Fu3n5nrZpVyzI=;
 b=X2GDixBZBILNOKN0l7cM7KiHIqd98BIFsAiVmuFOAC+SQ2br7V9yM3WV4mvdDVy6WTL5kSVZbxWCLzTUw6oALXecNthHqqBGEE8kQfe490W2WJAMpFqJoC/bT6fhk0ygdOSHEHSxk7lnTUKu1K/CjHh1RdRY3XUhgt7CAlTIgi7AWeDl5Wf7hwFmluvCLC0yaRJ/f8ZPYbfdEFTJgxcJJtSQXYDi0Q8X6PmmMC1eJiA+iJwCcxd6aNnJMI3oP39PSKOxxwBRxgV+io4DB1ywUph6flIUk6NE1opTy3+Wg4vtcUJk0tYcf5PbHX7BOJ9kyRXz7ZM/EWbvmcJi02ZRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcT5ehns9DgByfBlwJBs+rJdBjnmG0Fu3n5nrZpVyzI=;
 b=BvH32reRTG5XEw5NPgP6XIq1V7yrM4YYzvZHiogPaimZv+r1OryO3+QLD9L2955NwCbSrRbviKOUAjvrv4q3yhn+m7H75ogmmwlCdf06hGc2Wdc5jq8IyIEG7/zAVuXZwTTUMaWcOO+b1hn2AY71G/XN50nBJH4kcyzW7MZ0oVU=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by BN0PR10MB4870.namprd10.prod.outlook.com
 (2603:10b6:408:12a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 04:38:57 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::2eba:a565:3a1:571d]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::2eba:a565:3a1:571d%6]) with mapi id 15.20.9094.021; Fri, 10 Oct 2025
 04:38:56 +0000
Message-ID: <59eb64f1-7019-450d-96bb-a9398d2af602@oracle.com>
Date: Thu, 9 Oct 2025 21:38:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] vduse: support feature provisioning
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, mst@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Dragos Tatulea DE <dtatulea@nvidia.com>, Cindy Lu <lulu@redhat.com>,
        Maxime Coquelin <mcoqueli@redhat.com>,
        Yongji Xie <xieyongji@bytedance.com>, jasowang@redhat.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
        Jonah Palmer <jonah.palmer@oracle.com>, virtualization@lists.linux.dev,
        =?UTF-8?Q?Be=C3=B1at_Gartzia_Arruabarrena?= <bgartzia@redhat.com>
References: <20251002103537.308717-1-eperezma@redhat.com>
 <20251002103537.308717-2-eperezma@redhat.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251002103537.308717-2-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:510:174::23) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|BN0PR10MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f09135-55d7-49ca-578a-08de07b6ec3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|42112799006|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjcxL2lOOHlQeGNkYVByNGRZWkgvbm90Mnhtc2pYZGsxOEtqc0ZGU09zS1Q1?=
 =?utf-8?B?TlAyZTdUak9rV2o0QndsSkh0WFR1SzVUTGZzWTNUam1od0tkUHZZclFLTnFm?=
 =?utf-8?B?dXBuZzN2blo3OHB6UklVWVpuU3NVcFMxUHVEdGw4ZjBScVJaYUQybWphMGdM?=
 =?utf-8?B?SGk5L0VNVFNMbStFdEhsajdZUVRjWXVQSnlTckJqMWhtK21OTEIxdGJrL0VT?=
 =?utf-8?B?UFRlNkhBK1Ivd0ZWQXdWcEU2TG5zYlQwQXp1d0RCeW5VZnRWcDhRTU5vdDc5?=
 =?utf-8?B?WnhrUkNkVkUyUkJUQVp3TzR4Q2pkOGFQaU4vSnpHQUVBeEwzeVZqLzhsLzhq?=
 =?utf-8?B?S0xBeDhURjJ4UERlZGJEQTk3K01BL3B4U1dDaDFyeVAvSzJEbDRudmtQRFR5?=
 =?utf-8?B?Yyt6cUt0WEloRmQ4aThmQktzN3NGa3FSQmZtQ2dySWtEVnptZ29PSmM4Zmlt?=
 =?utf-8?B?U1JRNVhjRGVZM1VrV2kwd0k5eFBVVllZUlRJd1VzbjRwamNvTDlPMFVWRjlC?=
 =?utf-8?B?SktlN2FkeUxSd2YzRFl2K1JmMDhOQlN4VlNPaWVXRDhsa05ieWpFVEFQZjBP?=
 =?utf-8?B?RGZTbEdERnE4Nys3VnlVTE9seFFmV3RSbXZLbElDYXhPWTJzOTVCbVd0a2RS?=
 =?utf-8?B?UXlIZ3JIcWlSQkhGWkYrZ3FmQklQMUxDcCtndVlSM0Rvck9mUFh0YUh5UC9n?=
 =?utf-8?B?VFF2MGQ4ZUZwT3JRd1pIeXBKb01sL2gxZC90ZUlwTTZlZi9Tcnd6azVKMHYy?=
 =?utf-8?B?QjBwRGhLU2xKc0Z2WG4vSlFkekZYU1hmWjFGNHlzY20ycVk2R0l2ME02R2x2?=
 =?utf-8?B?MTkxYjMrc0dRb3ZGbnpDMGE2SXZBVExSQm83d21XME01T3V0OHFHWjFnYkJ2?=
 =?utf-8?B?dVJZZUlScXV6R3F2anUyK0R3N2FiempmKytoQ002bzBLT3Jyc1NBdi9EM0x4?=
 =?utf-8?B?bnFJcitXMEVpTVRuTUtUaFhZN1g3UWUrN1hwUFU1Y0lKaTZXeG5LNEg1OXBJ?=
 =?utf-8?B?VW1UUkdPbzZrMUtIb2U4SUpPYzhmbnFQN2E0dHJ1a2hQYkVFREZhUXAzcFhi?=
 =?utf-8?B?c0F0LzJuODhsbnd0S1lzVW1mUm8zUERpdWNwYzJQbS9nZXFlYnpRdjIwSVVK?=
 =?utf-8?B?dGZVMlRsN2xsemlhWnFMR2YxbDdIMWRqeGljN3lUdStZTzRUUERsV1RDSit2?=
 =?utf-8?B?Vld6R2NpRzVkeElCcm5mclZyQU9INFZwcXZJWjdZcDNOZm5Ua3lFdll4TnpD?=
 =?utf-8?B?a280b0I1UEQwaEd0T24zYlZLMVEyQjd2WjVOdE4yWlFRZHZnc0lBaXpvcllZ?=
 =?utf-8?B?TkNUaHFEWHkyY2JPVFJvYlJPWVg4VlI2WG9sQ2JwTWxoTDNIT2tLV2N0S0ZM?=
 =?utf-8?B?Y3VsREZlTkNLUzE1Y0hlL0lMcXl5U2xTKzVNcGllMXd0d1NSTHJWMXg0V3dl?=
 =?utf-8?B?NU00QWJQa09TUlZrNnhHSWhmQzg1LytBa2NGRzU5MlZubThZQXFSOERTZWJV?=
 =?utf-8?B?NHFoblRXMGVpZ1ZiUmFFZE4xdjQ2S2JJVmR3T0hRRnBwWVcvQUduaWJMM2Jx?=
 =?utf-8?B?KzZrcDF5ODZBeE1iVEh0QTV6U3dtTk9STjFaRDBUaHpjZkVmNGNqYU5BQTJl?=
 =?utf-8?B?M2FIVmFqOS9pa1VLWVJwVmZQSFlMZ0Y5YmtvMWZXUmpRQkJWWXJ1NlVSeTVL?=
 =?utf-8?B?RGovMWwyV1BvUm9CWENWRjNFaWExY0hYdjQwa2JWc2lyWkNETzJVOUFzQzVv?=
 =?utf-8?B?akx6UE5PVnhTdStPdHo2L0ZJNEZMOExRMkw5c08wRGp5ZWNNd1Q2Q2w0VmV2?=
 =?utf-8?B?d05VenFaZnBVamxMZXZJK0t6ZitjTHA0RFplRDZyWXpWR0VPdDBCWGluejJD?=
 =?utf-8?B?R2pQc3E5UUFEQm55TjVGS0UvTWNlTG10N0NRMHBvR1lUdUlZcWpZNFdwU0Mr?=
 =?utf-8?Q?mBhicIz63yw501vmslZXvSoDfWiZFwSq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF18D5A7206.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(42112799006)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QktqUWFNMm42LzN6cGRFSmt5TnNGMTdtcUZRWk9Gb005TGZVQlQwQTF2YzNo?=
 =?utf-8?B?Qi8yV3BxdkxCS0RnQTFDeEU0VHNHWHBsZFUrTWdyNThFeFhQd1JjMTZZRTY2?=
 =?utf-8?B?Qk1yc05qcWlxRmJwaWxKQkFBS2dEU2ZWUVFVMitlaThiYTBDMUZBNHFBd0JP?=
 =?utf-8?B?Y2o4TFVGbFNqQ3YydTZiQjNFakhFUUtJMENwSEd0VnRJU0twejVSY2c4NnFL?=
 =?utf-8?B?Nktzb0czNGhoQzNBaWZDNVNFUXBYc1A0MmtWMGVqbmcvYWs1WVpQU2l2Rjg0?=
 =?utf-8?B?cFE0YnlObVBuRkhNcHRTNEpWRnR4S0lpYVFkTnFHV01PZm92RnFydHR6dHk3?=
 =?utf-8?B?VCt5dENZZ1ZVWk1oTllTU2xnZDdBMHJCQXp6NmRIakx2V2dWQnJSNERKWTZM?=
 =?utf-8?B?U05sVUs3cmV0bjlmNG1ENTlCSkkxS1Z5b09ueS91dmY5Q21KUjJjVWtPbWIw?=
 =?utf-8?B?VFlMc3o0ZWpnQ0p6ay9haU5TelZxOUZtZW9ZdDd6TUprSjFZYUlidHJQblpq?=
 =?utf-8?B?cDA5NXoycFJseXIzR1ZTYW40NjVhdFd4emY5bDU1QnYrd1VJYU9PMnZ5dmt0?=
 =?utf-8?B?V2FPSWg5WEJBNDF5ckNRNVFGRXc4ZFJFRVZsR3lRWlRSRVBla3BvOS96Mmgw?=
 =?utf-8?B?VVdzQ0VpdFRuV0M0ZlB4QnRqUU1JdkUyUVpZRU9sRGNJZ2dEYjlPemNQNGNR?=
 =?utf-8?B?bWorOTd5cmtZMlhmYlBnTmVnd1NDbXBFREhTRHJ5VjdiRFJmc1FhYTNXdXZ2?=
 =?utf-8?B?dU9sMEpwZG0zMUdEYkxaUDZLYmtZYzRQdXl0Y1FFY1ZnSlZrTEtWREdzS3Z4?=
 =?utf-8?B?U1NBM2tGSkYxMTlTOHhsbC81K1VCK0JBYUg0TXI4VVgveVRpcXkyWHhadG9M?=
 =?utf-8?B?S2FWL1J2QlRsTGlldFN6YWduK0VQVmYxdzArYm9TVDlDYkNzT2huWXBtVUNE?=
 =?utf-8?B?SXF4eEV6bE1nWDViSndVWENqdzJjbEhpdTRKbk5vK3BERjdVRXRyTWV6VkI3?=
 =?utf-8?B?Wm9CdFM0cWJjQWh5MTBIZWhnb25Dc24zWkw4ZVczY05NcEd4RlF3QjY0TFNT?=
 =?utf-8?B?NmliZVJzaTIrWG85VENvWjBiVEs2ZkJobVNsRUxPRjc0T3JTWk9tVFFmUUN4?=
 =?utf-8?B?YTlKYWZ4dTJsSUxzOUViMGJMUGh5Y0dnWjk4ZTZIVDB1S0VzTmwxQ0N3cUZQ?=
 =?utf-8?B?WVNRYVExUmJaTXozOXkvT0ZtYUl4SWMwRStOY3pOdm1IUjFPYzEwcjNLeTlv?=
 =?utf-8?B?STAxNUwzNE5aQVNLcTZwcWVtOVpKK2JKeXl5RzRlMCtyY2hRVGtKYzNoWDQ0?=
 =?utf-8?B?OWFGaWs4aCtYdGdIbVVoVXF0aHVPaUtVSUQ1R0tadGZiczdIek5md0hzNWtt?=
 =?utf-8?B?RFhWdkIwYUhzUk5hNlZpcVRPYVBLRHBoYURTNmtmMFloRTB5bndFL1AyRk4v?=
 =?utf-8?B?ZUwrdGU0TlNXUEJ1eC9Va3JnbWY1VGtUdStXL3ZRWGxvZDNjKzA1WENkZ1N6?=
 =?utf-8?B?b0FqNjN0Ym0waUxtS0IwK1ZDekR0WmxzbnFpdUI0VGkyNzM0K01XTThlMEFT?=
 =?utf-8?B?OXVpbWdVN2dPa0NnTWNpOWk3aEVUc3J3OFRSaEtaTFJsNms4c2h4bnE2R2px?=
 =?utf-8?B?WThTN0c2a0V5MnpYL2FrYjc1U0U1UmxQNHE4M1RSRit0ODVMWU96UUN1RDk3?=
 =?utf-8?B?WGNOQW9QMFoyeXBlczYzM0NPWXV5YUd0ZUNQRjVmMW9RajdYOVR5NmpZRU5T?=
 =?utf-8?B?M052U1hIM0ROdVR4Sm9FSkRrbUZuUkVtV1VkcEVZSEVrY1ZEMnA3UGdBSERC?=
 =?utf-8?B?Mmhpbk5SYTlVVmhzTHo0LzNkK092V25xMGQzMDNaVWlyb0NmWFhWK1NmeCs1?=
 =?utf-8?B?bVBjMy9BSFdKOGZNcXlMakU2M1IwSUFMczU1Nm0yeHkzL0hPbXd5TUtDWE15?=
 =?utf-8?B?cWFQVFlJQi9HOUhna0p5dHNXUFI1dGRjeTJ2YjZra3QweG00VE80cGV0UkR0?=
 =?utf-8?B?WlY2TUlISXh5eXhRa3pwTUFlck5wUU9LSHlOWmd0U3VTWEYxWmVMVFFtOFJU?=
 =?utf-8?B?cVpvZ3V2UGdsNnhHS3dhcGRpNE9mZzZjMCtwK29wMWZoc1VWWHF6c01GMVo0?=
 =?utf-8?Q?OOickY3D070sKHSEl+WOaBNiG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JrAUcdgT5LxVeK+RH+F7wIFxWbiJPhDZCLo2winoxbjH+76An+uhUF5wzQboradvs8B0/5A3MmjUx6bnSv1pEiq2FNuo1Ch8Wq7JgY6W39Ldpvxcni17YROuXYPHsjv8zgApOC4AI+Nu/hdUkUBx4KXYoFxDfV5cDBLoXFmZPdcjFxOccY68fRdi6laqJBmZRENKS4mYyEX/tN+gR8aAfDyBoMwRPeJzLLtZWFXDSgyQYz+9FFkcpw+QoN8FVeXbEwRyn6UOEDYi5Nm+CLA7EAN+aFbJ9f8DD8JStqUPUfQ6UI7tLK4xvJIn05+FdbgFEwlj6HcVt5Yxwr0yF5tksUGP5hRZR4VefaeSDtvPfp1zOiKxoMk4a+MO6H0oKEPWpjvM/fZb3cEkR4wcc5SMuvqo3eH80XFFNQIXnBOGiYN1t1q3cbifre60+Kb6OckQufU47NyEbFa8Ju3E9u5M9X0WcnhSAAwieL10qsOfAuN3tHCp/Z8goMPq4shhzw8BV1OOBBm0NhjbvQduMhzm7TiEXPs4J2QMkcIvZc/ol4hFz0worURQFDrAUOGB/XYsHoXTS3wsfFzj/nn1VZaeywPKihxLMa5R6wMP4gwUjlY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f09135-55d7-49ca-578a-08de07b6ec3e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 04:38:56.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmb4DdgWepax17gphLzIWwjnLcp+jd+sD5GNDEZ1ly8aJw3V6KET/5c3HJ2clgn+rTws6mEjrUiTHFGoKSa7/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100024
X-Authority-Analysis: v=2.4 cv=BLO+bVQG c=1 sm=1 tr=0 ts=68e88e19 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=TfWbfv-lHxuzzKQs8_kA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12092
X-Proofpoint-ORIG-GUID: vUqlyHYj4wsaYluZsf5banVaM9vBjs7G
X-Proofpoint-GUID: vUqlyHYj4wsaYluZsf5banVaM9vBjs7G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+3Z0NvDSEgZh
 UDdaxYzoxOEhUcaRDh/49Emsr2oa9i6RpSE1CWZH4IcYa8jdoffL50BWX0erFrFt8W8XAgcyM87
 QFyOvRuKuneVWgOLRGCJzwgBVJDz+YrAUwFAUndLwoz+h0nEOxvJHzsvVRgBKcBqZtWCgzhCu8y
 86LcDDtrRTLjVjocAvnScj3vxIrk8buxNc6Ka6I7GrVeW6IW2lfdbiq1CZywEAmMA1axRwzQjw0
 c0olK2GHmLIUyh46662IjrqQmQsuE7PA87Y2KCP1pO7DLPW9Jb60tp9ptALZXaN5zXl0y1hy0OO
 nxb/9+H/fm9e/aGnIWPEucXtk3NKU3hNXRKkNt+yzoD/WZC23slLtET/9xJZFzWNPvnl3D0wuGS
 6WSq177NfqelQMOZCYrt10ZmS2BSdlRMkK0RjPQhJm0xn0vaiPo=



On 10/2/2025 3:35 AM, Eugenio Pérez wrote:
> This patch implements features provisioning for vduse devices.  This
> allows the device provisioner to clear the features exposed by the
> userland device, so the driver never see them.  The intended use case is
> to provision more than one different device with the same feature set,
> allowing live migration between them.
>
> The device addition validates the provisioned features to be a subset of
> the parent features, as the rest of the backends.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 6c74282d5721..ef8fc795cfeb 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -121,6 +121,7 @@ struct vduse_dev {
>   	bool connected;
>   	u64 api_version;
>   	u64 device_features;
> +	u64 supported_features;
>   	u64 driver_features;
>   	u32 device_id;
>   	u32 vendor_id;
> @@ -698,7 +699,7 @@ static u64 vduse_vdpa_get_device_features(struct vdpa_device *vdpa)
>   {
>   	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>   
> -	return dev->device_features;
> +	return dev->supported_features;
>   }
>   
>   static int vduse_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
> @@ -2256,13 +2257,22 @@ struct vduse_mgmt_dev {
>   
>   static struct vduse_mgmt_dev *vduse_mgmt;
>   
> -static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
> +static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name,
> +			       const struct vdpa_dev_set_config *config)
>   {
>   	struct vduse_vdpa *vdev;
>   
>   	if (dev->vdev)
>   		return -EEXIST;
>   
> +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> +		if (config->device_features & ~dev->device_features)
> +			return -EINVAL;
> +		dev->supported_features = config->device_features;
> +	} else {
> +		dev->supported_features = dev->device_features;
> +	}
> +
Why this feature filter can't be done in the client (library) of vduse 
itself, similar to other device specific features of the existing vduse 
client? I thought those vduse clients are never managed by vdpa tool, 
while the device class can't be bound until client had registered with 
vduse. What is the point to define the feature bit in one place, but the 
value of the feature (for e.g. mac, mtu) is still or has to be provided 
by the client itself? Is it the right behavior to filter features in a 
separate layer rather than contain all relevant feature bits and 
attributes in one central location?

Regards,
-Siwei

>   	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
>   				 &vduse_vdpa_config_ops, &vduse_map_ops,
>   				 dev->ngroups, dev->nas, name, true);
> @@ -2289,7 +2299,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>   		mutex_unlock(&vduse_lock);
>   		return -EINVAL;
>   	}
> -	ret = vduse_dev_init_vdpa(dev, name);
> +	ret = vduse_dev_init_vdpa(dev, name, config);
>   	mutex_unlock(&vduse_lock);
>   	if (ret)
>   		return ret;
> @@ -2376,6 +2386,7 @@ static int vduse_mgmtdev_init(void)
>   	vduse_mgmt->mgmt_dev.id_table = id_table;
>   	vduse_mgmt->mgmt_dev.ops = &vdpa_dev_mgmtdev_ops;
>   	vduse_mgmt->mgmt_dev.device = &vduse_mgmt->dev;
> +	vduse_mgmt->mgmt_dev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_FEATURES);
>   	ret = vdpa_mgmtdev_register(&vduse_mgmt->mgmt_dev);
>   	if (ret)
>   		device_unregister(&vduse_mgmt->dev);

