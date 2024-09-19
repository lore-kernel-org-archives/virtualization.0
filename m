Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020088.outbound.protection.outlook.com [40.93.198.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448F219D8B8
	for <virtualization@lists.linux.dev>; Thu, 19 Sep 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748806; cv=fail; b=mWL3SllIS9xw0nO5miu1hSFPd1VlnM6cJiyHTls76QptY1ep+J3a1z6Enwczq84BvpXWXRA140mzpnI3Q4QcYRI5KpZwhcb5/+dhL+PDB3ILxjY7JaIXdfxoE+FM97TSXqT7Ad0r3JYcjbbqweUahx+O/t/V3HQQ6QI57OxaUnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748806; c=relaxed/simple;
	bh=S0V7mlzriMTD9e8u/w2A45urO7L0/XKAw9eGBTfQu2M=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=h/ffEZJo+faEwpsLlnOi/1I9gOTZFu0SqUX2o/jeiKe7FipzEfA62Q1om/ob4kLr9YrDR/mXfmwHN61TsssvSDTcxZ6uvnEuX9eJIxZ1onnoXPeq9ELyF4mrwvafQu42X+8R4nhAvo2tmuSUslK5L8Fe2UWRo1Hvppyw4qS4QVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=cjE1Ai6L; arc=fail smtp.client-ip=40.93.198.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="cjE1Ai6L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xriuoFsx5wDCl+gUAclYDJvyeXdP2AsSVTL3hldiwxhKkWllD30KmEtnNV9a7a0JTX21cN6gghEAYD+8GzdZEotUV2neO/0DWN/bWyzAE4JSU+vbJDv//u7ogd/uL3fW2oKquF9QCRISx/o+OZ48QqroReSenW8dIc6m4NdBZGa2f0gkma6e99xC+l8b7Po25JusyLhPfB8GufD4Z5QLMy4LjfInflvjCK8cWMfwyJtxMxxqlw83MN/rVR9ZmImwHcUPgglKAjhnRgvobyECC7mzPt4d7wGncmfiwcWDtXAKDkNJhKro5u2E+zO93YiVrWCrEKHa6oth9rpaGs24kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0V7mlzriMTD9e8u/w2A45urO7L0/XKAw9eGBTfQu2M=;
 b=uJB7BmEy+gM5uDtlKd0KQgohTXW8BExruf5qR8RTA5HSAxmA0nig0EyKr5//DtsRJpAP3B/XgfDtZ9cwauefj/DZLDmlwxPRlEKePZn9CdjmuCTHEiBrjflgnS2hNtXPxx7sqX0+cjY8O09Kctj+bFwjlfwGrUANoeASbBRN5Eaqj/tRedxwhmuNNYanwsSoGg02PqkmtBiSx4kO3YIfYxMKsU9/R+phUqCNEXiL2isVUuU1Xu7p1frm0IQ3nvMfHh8zMrXzBJ0oxNZs+l74H7VcukSqqb8OEuS+9REK6CTjigt3becPb5EOcPFebtlXXqEnM3fMFcZPWenBjhwobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0V7mlzriMTD9e8u/w2A45urO7L0/XKAw9eGBTfQu2M=;
 b=cjE1Ai6LEmUL79bW2UdZUrseJttkobdkYDAZGFNvKhJs+CUJb0yxBPZikO9k1OaChriFdrHV5qzTcMHZDVSEaaZnvxWxHmyQU/AAmfWZb/Df1rm8eXrV4cQqxpsOa0ZeZkgzyKBpFRYHWkCA9UPE3YehhiqUaO9URlyP8JhonsKzGvoY9YZSdFk0z+0mhdAy9T4OpCpm/ziGXR9M6ZCBEuysWj4OTqqh3s+J4+M09NNEtUie4r/aGhFhkTRVJF0TsdGyN8kmhDOYRbOPxQ1mgrC0+Mf/0wadSXKgOZcJmP/8MUYers9+3n3fflsIo/JtnOC8TbtbKWU267vzbTJ9Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CH0PR01MB7091.prod.exchangelabs.com (2603:10b6:610:f1::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.22; Thu, 19 Sep 2024 12:26:37 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 12:26:36 +0000
Message-ID: <8da76a79-444b-46f4-96db-309d03689220@cornelisnetworks.com>
Date: Thu, 19 Sep 2024 07:26:33 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
From: Doug Miller <doug.miller@cornelisnetworks.com>
Subject: Looking for help and advice on using RPMSG-over-VIRTIO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:610:33::22) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|CH0PR01MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: e44552d3-de39-433e-f357-08dcd8a64df7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHlCd29VZ0VpNEY4OEdJZUhaRE10dWxPajI5OFNyK29SY3hTRHRsRkNGMCt2?=
 =?utf-8?B?aVprczBUbXNLdFZCY2I1NkF2ZW5UUEtmNW9uYjlaSEFpcmhOalJuTFFSemxn?=
 =?utf-8?B?WFMxdmppVW1UL0ZFVGg4bVJOeGV5SFg4djkrbjdyYzc0dkthK0dyNm10RllN?=
 =?utf-8?B?VStPQ1FtQndwUTFodGhNVC9xUFpJcGlHOHFYT0M5cGNuazdmNm8xbFQ5b0di?=
 =?utf-8?B?cWJjZUJGSkJrYUNXWUNrR29ZOUplK2c2UXdpRy80dmVKRjkrWFFZL21UcWVx?=
 =?utf-8?B?RVlRU0k0enFOREwrODk3QVI2YmlFUVNyRDcxM2NtYlJvaGZYOU5qV2tVU2hq?=
 =?utf-8?B?aXFsdW1zT3J5QjB0QWdibEdxY0NkanhZcUNZMkhxQXIxd1VuTmFDdTI0RTc4?=
 =?utf-8?B?THRRT21NWjhZdzE4bVJ1dTBLcllRNHBnTTJjR1E3TzVDRFFTcTVCWEo0SXJY?=
 =?utf-8?B?aEhrb1FTdCtNVU43aHFsNlFNL1AxRGdJWFlCODllWm1GUldGbCtwOXh3NkZM?=
 =?utf-8?B?K2hNRVNHOTdVRDJyVGdrVUh2K1ZacnRHRFlPODBzRVBFWEZJb0hBZnR5YXJ3?=
 =?utf-8?B?RnhnWlgrZHNwa05BbGdOSExua2hqVG5CSkszMTdFV21MSzBYWXZKVVlYRm15?=
 =?utf-8?B?eDZ4cnlXVWxFY29qTDVrcGpZME1BbW56Y2ZCWldyQ3RpcGdMeGVHbjBMYW0v?=
 =?utf-8?B?T2hiVHBxeUhsKzMwMWFUZ1BwZDVURnZ6bkJocjlUeHlBK0RWbnJyWUF4dkxW?=
 =?utf-8?B?Z3NWcW9GZ1cwTUhoNUs3TGVkNFZqWmZlSVppeDVhdk0yMFdtVU5OeEtLWWFs?=
 =?utf-8?B?aVBER3RhbGdGZDNZWkxOeTJMVFN6OUJ4Y2xnZHRrVDdFR25mU0V4Vjc4cWx4?=
 =?utf-8?B?R1A1VUFJYUhxc2JjY3kvMGVudnV3dHd5ZHlzc1FnTkV5TitHWkYwekFmTURN?=
 =?utf-8?B?T2JJUUlOK0pjU3FiaXYyOG1keTR4US9XNjZkNnJ5MlkreTh3TWFkY0kyUFNE?=
 =?utf-8?B?NzRlYUxqZmZNayt6bERMWDkyc3dLWUsrcUNEb00xa25IeU5KSDkzbCtGSnFr?=
 =?utf-8?B?VUxKOE9PQjIvWk5nYklBeDMrVTk0TlhEYlVyQi9SRDRHelU4aW80cTd3TE15?=
 =?utf-8?B?ZVdocGhqWmdFWFBUL0pIS2d1M0ptTHFxOGlkQzN3cUpsSzVhQTBMN3pqMlZl?=
 =?utf-8?B?U2VzUk0vU0VDSXVnMG5McUNaWnRobjFDWWR2Ym4xMGR1SEhRdjRUdVdLYktt?=
 =?utf-8?B?VGNUQW1QbnNUekZYWitpOHBrZGwyR2RSeGppQUdvTjVDRDFUdmFNZndqQS9B?=
 =?utf-8?B?NkxTaVRVOGpsOTZtenJxemY1YThONTJXbHJBZWxvSHBjZERJc3MzTVNWTEhP?=
 =?utf-8?B?b3ZUUlhjS3FRdHlMcVNJVDdXbkZwZzluY0QyZE8ralVDZHcwMlZVdi9NMlpr?=
 =?utf-8?B?REVnWXJlZkRSTUJ2SExtQmxnbFI1Z215VWdIOHR5em5mNTBia2t4TGYyQW1P?=
 =?utf-8?B?d0JaTVprVXlOQTRVaVdRQm0zQ2VQcDYxQUZKRWZkME9pTHlXdUF0Nlg5ZUxm?=
 =?utf-8?B?ZjUxeHpoOUl0c041cnZkbkhZZFFNSmZ6bkh1d0lhNXBMN2tXZDcwRTAvcHA3?=
 =?utf-8?B?TnRFU3NxbVAydGRSMEJWNnEybXErckdLQXhidWRWZ2pVbENJMXlkeVI5ZS9z?=
 =?utf-8?B?Wkh3azZQY201SWw3T1NJUXNydkwxcnhlN1dhVzJxL2tmaWhHeDExOUcvVDdl?=
 =?utf-8?B?bzVSNWt3TWpuZUx3NG5iaVJWc0p4Q0FHczFweXZ5KzBTUUNDVkhMeUVVVGZE?=
 =?utf-8?B?Wi9XZ2hhMk5wS2k5Q3ZxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHpZckFDOVZ5Mk12LzBpMmc2bXZDN0ovbGQ1TmovK2p1VHlIYVZVWFlNY1or?=
 =?utf-8?B?TjFrMXNHckx1aC9lZGRYQlR2dElzUStKeVZkN1lzNDE2YkQzQjBEdFBJUzZI?=
 =?utf-8?B?dkFCdlNNei83ZkYwLzNrUXhQRXhVcjErQkVnbFFLMkYvV0k4YjFhR3dGU3ZK?=
 =?utf-8?B?ckZVaGlEdFFRNUJCUFgvMzVDTFB0eVJyVlA0TWlnZjBOaVYwdGNwKzkvbWs5?=
 =?utf-8?B?ZytDMlhLV0JlK1NJMFFHUCt1QU5qQVJ6TlVUSmwvZmRGdnpYREZsVWkvNnBu?=
 =?utf-8?B?dEFMV24xU0RhOUpMWWlLUlBkT0xYaHZyZUgvcUZoVERpMVg3aGdLbit6WFNI?=
 =?utf-8?B?TitUL2pXY2Rody8rM2ZRcHpyOUk2V3ZjOWNwQitXcGZMSmxSRytvR0JFNHJ5?=
 =?utf-8?B?anZzRmJUMkhZa0JlWlVaSmdGZnpSK2pTL013Mks1TWhmdlZPV2tXa2hHb2NX?=
 =?utf-8?B?QUhOcEpiY3c1Slcxb3RTM2hxY095SDNCVVIxQ0NxbnoyWDJ4RVQwOGxiaUpT?=
 =?utf-8?B?UkNJeWQ3bytiQXdnaWZpSkc0R3hkc3lKbHE1UnhBVDFsWjBOWXp4bHJGaEFD?=
 =?utf-8?B?MjZCU0M4YmkwcnF1b1J5ZlVrVUhEZFpyd1FSaFNEZG5yQUF3b0FpRVNxbzF4?=
 =?utf-8?B?a2NyZlNhRTB4UzRkbGhmUUJudXJJY1B0VUZDUDJrVENEb0piZ0VES2JNMm5V?=
 =?utf-8?B?bjZBQ0VmSzBCRC8rMk5mb1NmZ1AwZ1FabHliNytMWnlUbUJhOGxjb0FPZ2xK?=
 =?utf-8?B?dXZEV1ZHQjNYSENMcHYyVHJvTzd5U1hxLzVRTHo1cEhWT1YzMEl3dy96TzRB?=
 =?utf-8?B?MTBwVi9uQXN4QTgvdVA0cCtOOTlrU0hOM0d6MWNjTlBoTi92a043RmVqZTVD?=
 =?utf-8?B?Q0hpM00zcWJnakUzV2dGYU5RUEt5dTVIcVJ0Nkp0R0ZTaTBsbVBLaDNDV2F6?=
 =?utf-8?B?TW1hVjZoSWxBZlc2Y3UrTlAxUzBFNDA4aWNwYlZDRjR1bFpWVkFxVXVLNWdW?=
 =?utf-8?B?THJ3eG9qS1NwZGNreXZOdXZOYXFjZDAzTm1RYzVRUHBTL3IvczVwcFZNUm85?=
 =?utf-8?B?VUw5bG9wcmhVUHIxM0NhK25qVkhLS2V2TG9aUzNTeDg2UjhBblk4M0hCRHZQ?=
 =?utf-8?B?MlVqbzZadXNidGovQXhQc1NES1FZNE9RV2trdnc3emZpdWV6SUpRMFdRSEtB?=
 =?utf-8?B?Y2FNZ1pSMGVlNGFpa3dJS09KS3B2UEtzTmZHZE12TWZEaFhNa0NTVzVZNWha?=
 =?utf-8?B?emdFenlFaUhiSUxuc2JXdkJyVGgyWk9hempBcHc5alZ1N3kxNmZGOFJBOG5M?=
 =?utf-8?B?MEVJV0NHYkNmUUs5K2toOHh1SzJXM2FsYjVQekN6dlN5Y1poS2lnc0I2L3NF?=
 =?utf-8?B?Rng0bk4zbnhUUHp2L3V1TVVsckJVUmtPR1F3RDZOWkRyc3h5ZGVoSFpmUHpq?=
 =?utf-8?B?SHd0bFBCTWxiaWVxM0F5SFpPaGRIWG8wc2NXZHBuZ2ZlOTV5OTlRNm9JQTlE?=
 =?utf-8?B?TGw3LzhLMkV6Rk45MVBCd1VtS2NuNVZKVjhyVzVGU045Z1NGOUVXZmxtY2dZ?=
 =?utf-8?B?ZGJ5V3VsVWYrWk13cFRwdkw2d3R6WWNVWDUwWE1YREVEaTdVNWU5VzV5SzBY?=
 =?utf-8?B?cENRc3dKY2kzaktDNWpkR0FCcExJL3UxU0lSVGhIQlpuWFkxVHJIRVdNdU1P?=
 =?utf-8?B?WU5LbmdZQjVFem9BejYrd3Uxaks2UFVycUFPSVJwTzYrazlBN0xFRTJVMVNo?=
 =?utf-8?B?KzlsNlJuUzdQVlRYVkhmZTVNNnJ3enY1YkdKUFAxQkNiblJKMWE4S1lucDkx?=
 =?utf-8?B?QTJaVzhBdFhmZkw2Wkp6d2FHZi9uY0owMUdONXFRYTNVbTdjZi8xbEhjclk2?=
 =?utf-8?B?bkxBalVITm5JTmw0Nnd1OXgvRkROMldUMWtudFQ0dlF5cFRjTzkycjZVeVVi?=
 =?utf-8?B?c2hhWVJCVi9PLzNKcW9JbXQwSEg3blRGMms2ZnhJVHRPQWdKKzBPZ2tkZG1X?=
 =?utf-8?B?dU9FMFQ5N0J5eHNJNzhKc25LT29XNkFOMXRNQ1FaMURrZkE1TWNreXVvYjRD?=
 =?utf-8?B?RlJGNExNUjk1WWNQTENxZHFsREozeE9XZEVoS05aeXRLTzY3UmJpVGFJR1Nh?=
 =?utf-8?B?T1N4NStlM2NrS2J0VXp0Q3k2ekV1N1JZSXZGUy90eE9VQ1VPRTB3RWIwQ0RZ?=
 =?utf-8?Q?Dzdu9tG/7T40XzaLKWGTQPw=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44552d3-de39-433e-f357-08dcd8a64df7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 12:26:36.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkdwetDwcEcayQC7YL28z7CHgiyN3ZTz76Zg4Ozomp4TYIYWf5bPC+H9xwtzoyKBYFvEXT+cBlTHI0PYRhmpvYH066D5mMfuFZOCO6woId3+6CIBGeyEKolKDD7Sng1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7091

I am working on adding SR-IOV for a new adapter and need to find a way
to communicate between guest and host drivers without using the adapter
hardware. I have been looking at RPMSG-over-VIRTIO as a way to this, but
have not been able to figure out how the host would setup the RPMSG
device needed for this.

I have seen at least one bug in virtio_rpmsg_bus that was discovered and
fixed by qemu developers, and so am hoping there may be some experience
with rpmsg here that can help.

I see an example in the Linux kernel for using rpmsg from the guest
(client) side, in samples/rpmsg/rpmsg_client_sample.c. What I'm having
difficulty with is finding examples or documentation on how to do the
host side. I have heard that the VMMs may also play a role in setting
this up, or are doing something similar, but so far I am not able to
find code examples in qemu or libvert.

Any help would be appreciated,
Doug

External recipient
