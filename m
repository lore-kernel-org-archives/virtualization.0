Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC71891DA
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053670; cv=fail; b=gbSFP2fO4TRVyfYFfWRAortsPlCQ0ZRwTLBs95NyJBurr3jRvQiA/KFfbqv2g6xRqi+Xw+OrkAJ5Zzy5/836Ns3R7ZFFCXWsFTlbxPV5G0d6KecUq6J10yafvvza1yV7WI2UnRykb3VVhRLp9bulmp4o8nimwLzwxLfGRXaX38c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053670; c=relaxed/simple;
	bh=mqX0VOfeGScdPZObDUmDyQrVn5FTDD++ZdKmLzp90M4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B9PZBkNtFr09dcKvpjARda9TdpCs5Sb/hXwq4a76wzRIOGPT4wHOmYgw5Cr/RLnJcdXUvM8eBbD3EbTwZ+n6aZv8BIkis7nLjMnF84I5TpYac77p2SSCKM2s7i6dK4K1/O0ClPJKebXb0+IfwqwDnL4Vyffhb0H0a5Ys3Ya3Xts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ijYdICLK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nIcyySdQ; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ijYdICLK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nIcyySdQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D703460747
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:27:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2omhS6eNFCJL for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 14:27:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C4B9F60727
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4B9F60727
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=ijYdICLK;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=nIcyySdQ
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C4B9F60727
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:27:47 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENa8X005743;
	Mon, 15 Jul 2024 14:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=4K4Ldx6nVLAyZc0Z5L41bxVBn7A85z0+YFSs6SAQPKs=; b=
	ijYdICLKkU9i0CE9N2Pxmd/qBc4T7USiRLCjihxRDt7jN1Idf8ZGmncmVFxB+A0O
	spgvvGdFuTHo/NJzrwH7fg5sM5TdBKkxxxk25kfcugcSZeJBnVSD47k88yCJlpFV
	kATTB/rm3BIckwReXh5cd6uTp4Iad5zz15WnLjNT5Ya1tEp9RUHuQo25k8QkzxUE
	R1I3i/vw5Are3k8h5faZ+s4a/KZV36vr6T9V1mTfYL8xh0Ey1/fYLcbbNrTLRhDK
	bwhviafWtwn1xzp6zIo1rIcR30Kou4VVWUYv5p3k/xXqpSAI/2RGkyQVgY1VzsLz
	oFFxEx4PcTMTDn+aj6qmnA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bgc2bm90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:27:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FDTbQf040618;
	Mon, 15 Jul 2024 14:27:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40bg17hn56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:27:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaml2GJFuqlxAfgC7xzXUtbX9Lsz9c+vNVfJ1/INhJa/M8XUizqo/b345EivAX2A32UWTyrxdK6K9Nfi4nosz19nf83e93feL5f03sCz9F8pLpxIL5509ltGHawuTdUabDgxyqhrWXcC2soshO24d2dLKrKlKZ6mveJWWD81YZa2lUT6qIUfJJAtTt2SBoL2WeLPQVOYiIAsjjHawbFIcPYG/COAMTFw1N1PppOPv7gtEfQ3hXFyBaaNQQoNj4oNBvOmAYDdOvMmd1aL2omfJ2ntWXF0OfTW1OFTSMRNv3B1kbdpWADB/X/t/ghz+/VR14r9UpWh5cbfbF7iMtCmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K4Ldx6nVLAyZc0Z5L41bxVBn7A85z0+YFSs6SAQPKs=;
 b=xNzHIBaqYRVgEn8mvcwQwhKFoDmJA3qmh5OcZ+2PoBS1FwRo232+dSTktmqTF8fXRM0gY15aoPoS8e36xHQhVko8oFGUPjcEfCepa11yjJfzstmZMPh3a7Q99Y4iBv/47Ogg24fD5F5YyFvtsTsC1t08gHMLrxwXifRHbNUs02V5TPy7tC6E7l8bJ8gmR99ylcysSNb+KbQwrn02zVYO5aljW3CwPtfd8HlgGF3NCg/Z6S2wJ7M7yyaXAvjGaPyl6eY//OBrZCfJKFEjgSPb/jYleVvsatvELJgp+U22LkhUePsOQVHS4RyarNNrZyrMhGY5Q8u876rbB0RlJ5UFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K4Ldx6nVLAyZc0Z5L41bxVBn7A85z0+YFSs6SAQPKs=;
 b=nIcyySdQNeodmTzc92aLCXP4RwckHlmeanYGpEMKT1O/d5r2r8c/WZCm4ELZbEtV5b/AfCY21IVamE05AOiNzd7YKysB68LOzd7Bq4PGJfXdDN6gfEoX1nHi74fAwAGyjh8Utxg/4/ieWxawPnRvgO37+1Tq4WUBMmPfUv5KNUA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4545.namprd10.prod.outlook.com (2603:10b6:303:9a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:27:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 14:27:34 +0000
Message-ID: <acfccf72-2883-407d-977a-9c2566cf8cb3@oracle.com>
Date: Mon, 15 Jul 2024 10:27:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
 <CACGkMEu0sNx=saZOaVRbuV7Gz7+_GD-v42i+Bdk-NCp6syABbw@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEu0sNx=saZOaVRbuV7Gz7+_GD-v42i+Bdk-NCp6syABbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28)
 To IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4545:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fa7b7e-61c0-48b1-aa03-08dca4da4496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cENEQWRiM09UTzdNSjRpN3pkOWY3b3ptd2gwVzZVditTUGlHQWMvcGVpcjZq?=
 =?utf-8?B?V08zS1I2UElic2xCUDJDZlVyaUFMNEZqK0hDei9YeVNsMENaTmZLN0RVZ00w?=
 =?utf-8?B?LzR4M2ZOUVhadlo5M1BNLzZaTDhJZGpkNlVxR2pLOHNZVlNMdHRvRXdnSWY3?=
 =?utf-8?B?ZHBxNjRBRmNCQkh4dFVnd0NSSVp2TVlDSUNzNmxRYmE3R2N3VE9LTU84c05X?=
 =?utf-8?B?c25TY296R3Q4Q0Q5ZnZBMVlqd0JZVENaMEdoMnMvQXJYS2N1TlIvL1Q2QXNp?=
 =?utf-8?B?WWw4WTMwMFNzcEZ2Q3NPZlljWVN0N0krUm0xTmRKaUtaSytNQitDc1Y2NG1s?=
 =?utf-8?B?d0E2VldYZUVKMk5ralpOSFVzWnQxWWVMVWhSbTZhQ1kvY2RjQmw1eDM2T1gw?=
 =?utf-8?B?ZkNSeHdFTTUyV254alF5R3RkWXRQdWxiMnBUMjFoQUtmYVd4VlJXa3E4WFlo?=
 =?utf-8?B?RzV0dm9WdmtUSEVlTTJ3MUpYNVlhcXJSaENwRUZaV005VWdQOTNXU0s3aUd0?=
 =?utf-8?B?QVFyVUVDcVQzcCtTTS9XNC8rTEVVNlNhMlB5bFZ1cVJDQm13c2E4WHZoVnpx?=
 =?utf-8?B?Sys5T2lWbjI5c3FuVGE1RlJpVjRMTlljNktzU3gzM0xFN1ByUHF4ZGZ6L2d5?=
 =?utf-8?B?OXZGTkkyaGs3UmJxQkcyK0dsUDNmTjlYNjdCMFc5bTJvVytrM2dKNklzVEJm?=
 =?utf-8?B?SlRJKzBhWllsTUcwQ1ZBb0toQmh5bEY0V0pFRWJnckliVzA2bkIrZnRSeVRa?=
 =?utf-8?B?UXBNZFN0eUFPb1FmeHJCcGZreC84UVU3R04rQWxTa2dLTGtlTHFPZ2t3YTl6?=
 =?utf-8?B?SnplcUhNSWM3MjhoTnNTMDl6ckhyckVMMW8vTWM4YjdaNmhmQUxyVWx3WXAx?=
 =?utf-8?B?NCtRVjBncCs3Z1Yya1BDa3pUaWl5bDBFUzN5aFBuUHdvckY4ejc1OWJocm14?=
 =?utf-8?B?SEU5ZVNBengxek9oTlloeXZ1M04xbEdtcmxPd3pPQ284bnY3WFkxME5wUGEx?=
 =?utf-8?B?UTVDckF1NWZoSFFkMGZMeUIwUm82VGtmbkdwdXJtREYrckwyQitCSGg1U2xX?=
 =?utf-8?B?K3dSWlV1UlpVSC9xTzZYV3NNeEN1MlhWOWp3L3VyTG9TUFJtc21qRlZwT2l1?=
 =?utf-8?B?dWUycmVoeTI3SDJKcTVXMXg4YVBCTlZQdmZYS1JTN2N5eFcrdDdrOTdPZUxC?=
 =?utf-8?B?dExrZTdYSmJtTnEvTWpMcDVxTER6UmdHVHJHNTU4UzROWVNmbjBVUzQyRWZ6?=
 =?utf-8?B?Z1AzcGtIampUY3RTVGVhWFRLLytRZ2hoa1puR2d1YjNZNVFieHVKaTVMaFpK?=
 =?utf-8?B?WGw0STRkQTQ4SzE4YThESXNLaG1ac3M1OUhBbUtJYnNmZEdOYnNoWVg4QUl1?=
 =?utf-8?B?NGJJM2xORkhZZGo0cGJlTUs0VUNoU2Q0azZ0dVBRNXBQNlpWcllELzBtaWFy?=
 =?utf-8?B?M1pYbXFqMDRLS3FIZVNnbUljMlh4czBBaXRkSjFhRG5KcDlKbUx6SEUxL2JO?=
 =?utf-8?B?WGk3UW9aMnFiUU9QWCtPZlMvZ0poaWFBUDVvU2N0alNsY1FleERqeEhrNCt6?=
 =?utf-8?B?YkZadVFTazQ3S1RnUko2U0FaR013dDZ4eVltanBlOVJLSnlBSlBaejMvOE1O?=
 =?utf-8?B?WlBYTFBwb0hwMlM0V1pXblJpYzM5d01VM3F3NCtuWHQ3NHZaMjJ0VlB1Q0do?=
 =?utf-8?B?RGZ3eXoraFRNUEhROVpjeUV3RjBTaEplZW4zNkQzcVl4RjhnVWExUlY4d1Er?=
 =?utf-8?B?ZjlQR2pXcElldElOc1ZlZnFBQllVaUtqL0NZbFFhWko5bWVvYVl2azBob2dX?=
 =?utf-8?B?SjFyalBoVWhEQ2YxT2ZMZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmF4WkhIYkFnVWEyY3ZpNlg0anFFNXJZbDNleVZwUEdZRGlwa1kxa2hZVjVZ?=
 =?utf-8?B?ak1YRFQ2NjZvRDMvMlJzc0VLMWZBbkI1TnNnQXFmZWNuWUFZS3dpZG12Nmhz?=
 =?utf-8?B?VDFPc091ZTFSb3JOa1duZ0h3OGJIaFVjQmdxTUw0SUpRZHR4NktIY3VBR1BG?=
 =?utf-8?B?bzJudjgyMkNLNDRrMC9pTkoxTDA0SG9DdUtzVXhPZFo5RGp2akpENEtlZ3J2?=
 =?utf-8?B?UHZOS1VkNDNFcGFIOWJpU0lNeEVWa0VzSUhXaHAyUEZ0cERRZUpVNlprem9m?=
 =?utf-8?B?SFU2dXFYcnNzcUc5bDZRSUJ1RzFqT000VnBUVE9oMU5PV3M5UHJVOFN1Z1VJ?=
 =?utf-8?B?enI2WUl4MkE2NzcwcGptbEtkV2FjUmpSamZvUmwyOXVud2NrMUxrd2NzKzZH?=
 =?utf-8?B?UzZlSCsvbHZrZndsck96QlhFUlFnR2tYV0pPa2FYTUVXNXBUdk5pdG5kQjla?=
 =?utf-8?B?YUFWbTZibm1YbGR4bHp3U3VHM0h2TVlqL1I4SEhLdnI0c1pjaTVjT2h4clpq?=
 =?utf-8?B?ak1oUHMxVmg5L3FvS3FRTTBlNlVLVVh1NG90ZUFkN0xDWWsyMmdpYktOdDNQ?=
 =?utf-8?B?L3BHcDFKT2ZLeEJncUFjMUpFc1RzK0IyaUpzK1N5U1NYSkFHVUkrUmJpczhj?=
 =?utf-8?B?Q2ZZb214N1ZYajUrVnpZWmw2N2tmQXpNNzFaM1BNT1JrQW1uNXBnanh4S2tQ?=
 =?utf-8?B?V3B2YXpnd05uY2h3Z3ZOWXVNNFhORlZDL05LT3gyRjVwZm4zT2dkeGZHazdp?=
 =?utf-8?B?RFE1TXB2U0dTa0pTelVnYlA0ZXFjeVYzbStacmxZWmJNVWpZR1k4OUNJNGpq?=
 =?utf-8?B?SmxCMVd3UE02TWd3NStVaXMrMmhILzJra0lCelVpV0xhaWVIbVlsVWRTNlBH?=
 =?utf-8?B?emhpdDJQUDk0WEN1YnNqWGEyN29DV043U083UTlWckw1RHRSTks3Y2lDWmZN?=
 =?utf-8?B?cVE0MEpXM3hhN05RY2ErVlBJQVZOWXhTdC8vd29BMTl5dEZ1bE9qdktHVUJ5?=
 =?utf-8?B?Smt3bFVPZjFRTXZZMVovQ2VQaGE3TTNFdVNvbC9jVTh5Mk9CMlBMSmJtN3Vi?=
 =?utf-8?B?SDVUOVkreGRpRkJwRWV4SFpUM2ZpS0NlL3Vmd24vM2RPNDBVR1I3cGhPbDJs?=
 =?utf-8?B?UDMxSWxzL2liQ0tpbnVjRml4S2hvUFhnb3p4cmlRc3VDQkdyVnNqcW5aajBB?=
 =?utf-8?B?Y3FCQ0hqN210aXdPelBaV0Z1THQ0WlVHV0F0QThQMTZHaXFwb2Q1MmFqWC9D?=
 =?utf-8?B?ZEcrSFRlSFJBK3FoNmtSdXpWbUI2clN6Ym5RNE9ENEtXUWtYMXZKMEhSWGRI?=
 =?utf-8?B?cU5UdWNmeklJVnVTM3dUOFQ0c200Y2JZQ0RUQkZhZlBMRHl5NFFlQ05vVm5x?=
 =?utf-8?B?dEtIazhrWVVMalhmSUNMZkdtSndtdERqL1NWR2Q1SDYwZXorZDV3aTJVNGto?=
 =?utf-8?B?QWcvSmd6aDlZYXc5ZUZoMENCQk5CNGxXNk9BcGloZUN0SHlhUWFDVTlxTnZ5?=
 =?utf-8?B?MDhGTFRwT05seWRHMXZCYW9DNVREeVJhTEI5ZU9FZVQvR0tERFRYQmUvNG81?=
 =?utf-8?B?bW11MWtlQWY5RVF0ZG82MWJ4aVVjQ3RCbmFkVXVseXhtaG5SbEl1OVBweDQr?=
 =?utf-8?B?MSt6YTMzaW8rQ3RQTlVrQmNydjBrSndIZ2QvYWI3VlJ4dTNoZEJrcmIwL0p0?=
 =?utf-8?B?a2daVnZwSjNOdHM0Q1UvWXlhRVMzcmlFcTMrTDBKY29RSWIyTEMvNmhlTytz?=
 =?utf-8?B?ZjQya0JXZEovZTVNMGpnSUd4Qk1NSzBCdnRwUE5McW1UeTEycmtZL1ppWSty?=
 =?utf-8?B?RWJ5dWlRN0dZRk12akJySHVxOW5UYjlxMmpzMnZxbTA0Z3NWSGRSK3RQZ3Fq?=
 =?utf-8?B?N0tEMkRXaGVTWkc2WGw0dXFMUkNYMnNabmN2dWxQeEM4aXd2ZU4wUVJaQzJl?=
 =?utf-8?B?U1RmdU50cEtFNnMvcWdmOUZkT3NUcGoySEp3V0hDL2IvNWR4aVdzbFlpa09p?=
 =?utf-8?B?TzcwOHdQRXZTenE2QVNPUXRPdFgzSWNHTTVaelRDdGg2Q3dJSSs4dW1uamJJ?=
 =?utf-8?B?NGptSXNXeDdTR2hwcWk0S2VGbVd5NDJqZlJxTnh6THdMSmNXZEVzckwzSlgy?=
 =?utf-8?B?YzNrTnNseXpjdkpyYzhiQW5hTWdCVDltb2dkWUxBdWRsQzRrT0F4VkFCR0Ex?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	t/ujfoL6myT4mE9mZQWAJRJoRbybRCqtLzY9Ap1+sb9tVhMXLVeRNDuiRuU1N+3PK+rop4Lsgsh+QxybzIKfIDdPJA7x1zrvp7pSWL2qhaeRAbtpEXN2hTFf992sZn2SYoyf/ntl/RTtmRHYJiO34o8JLMF4UXIT8WT5zL0JPkaHhc4qamNi3z1xcBlSvFceWB5ZEn6yGCI+QAR+6hJ6IM6+frVbxB0AUZ851jNY/xovmqL9oPMRx0s6IQPnRjzg3hvNBT/SJaHWxNhoq4lHNC0DlSjhtzDGs/hntKSWdgX5N6BdvsJKD9EO18NHeuivLnduCltQp2BXHY8FSjagW9PLcpnT6leFom79XiIVQKYoU6mwd4wp3a27JRv7kqsgHvjVhVncUlOaL73DWbrtIDTs9t8oYrL5v8srm2KvoMpcHvYlW6pUFFqjpH8XaaG3jg8zaLRVn2uj/nYqNhhbsO3D4Mr/qCbW48yVdpNveJsehffzrkII75s5oVfYmagDiYVR/Pyn55LeA5QCJU75WinUJo6v/D62HMGFNDxjik506gXGp03F1qcbrCyYC2PvcRd5j83bGtSP9m3CZWF1UT/hFzF4R80+An2r3xLf8nE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fa7b7e-61c0-48b1-aa03-08dca4da4496
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:27:34.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fPA2CJliY5aTGggqpGGvabjllPCafxPOP/xeojNQtXdbYqLGGFxR5olm2hbgqgiqlNQXaoTvLJaoiEy+QE7fgFXT8vguZZCYY55ATPq4Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407150113
X-Proofpoint-GUID: 7j6J53yIU9UKgNWOsbevHtN-z2nB59Wl
X-Proofpoint-ORIG-GUID: 7j6J53yIU9UKgNWOsbevHtN-z2nB59Wl

On 7/14/2024 10:26 PM, Jason Wang wrote:
> On Fri, Jul 12, 2024 at 9:19 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> Add an ioctl to transfer file descriptor ownership and pinned memory
>> accounting from one process to another.
>>
>> This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER,
>> as that would unpin all physical pages, requiring them to be repinned in
>> the new process.  That would cost multiple seconds for large memories, and
>> be incurred during a virtual machine's pause time during live update.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   drivers/vhost/vdpa.c       | 41 ++++++++++++++++++++++++++++++++++++++
>>   drivers/vhost/vhost.c      | 15 ++++++++++++++
>>   drivers/vhost/vhost.h      |  1 +
>>   include/uapi/linux/vhost.h | 10 ++++++++++
>>   4 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index b49e5831b3f0..5cf55ca4ec02 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>>          return ret;
>>   }
>>
>> +static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
>> +{
>> +       int r;
>> +       struct vhost_dev *vdev = &v->vdev;
>> +       struct mm_struct *mm_old = vdev->mm;
>> +       struct mm_struct *mm_new = current->mm;
>> +       long pinned_vm = v->pinned_vm;
>> +       unsigned long lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
>> +
>> +       if (!mm_old)
>> +               return -EINVAL;
>> +       mmgrab(mm_old);
>> +
>> +       if (!v->vdpa->use_va &&
>> +           pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit) {
>> +               r = -ENOMEM;
>> +               goto out;
>> +       }
> 
> So this seems to allow an arbitrary process to execute this. Seems to be unsafe.
> 
> I wonder if we need to add some checks here, maybe PID or other stuff
> to only allow the owner process to do this.

The original owner must send the file descriptor to the new owner.
That constitutes permission to take ownership.

>> +       r = vhost_vdpa_bind_mm(v, mm_new);
>> +       if (r)
>> +               goto out;
>> +
>> +       r = vhost_dev_new_owner(vdev);
>> +       if (r) {
>> +               vhost_vdpa_bind_mm(v, mm_old);
>> +               goto out;
>> +       }
>> +
>> +       if (!v->vdpa->use_va) {
>> +               atomic64_sub(pinned_vm, &mm_old->pinned_vm);
>> +               atomic64_add(pinned_vm, &mm_new->pinned_vm);
>> +       }
>> +
>> +out:
>> +       mmdrop(mm_old);
>> +       return r;
>> +}
>> +
>>   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>>                                     void __user *argp)
>>   {
>> @@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>>          case VHOST_VDPA_RESUME:
>>                  r = vhost_vdpa_resume(v);
>>                  break;
>> +       case VHOST_NEW_OWNER:
>> +               r = vhost_vdpa_new_owner(v);
>> +               break;
>>          default:
>>                  r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>>                  if (r == -ENOIOCTLCMD)
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index b60955682474..ab40ae50552f 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
>>
>> +/* Caller should have device mutex */
>> +long vhost_dev_new_owner(struct vhost_dev *dev)
>> +{
>> +       if (dev->mm == current->mm)
>> +               return -EBUSY;
>> +
>> +       if (!vhost_dev_has_owner(dev))
>> +               return -EINVAL;
>> +
>> +       vhost_detach_mm(dev);
>> +       vhost_attach_mm(dev);
> 
> This seems to do nothing unless I miss something.

vhost_detach mm drops dev->mm.
vhost_attach_mm grabs current->mm.

- Steve
