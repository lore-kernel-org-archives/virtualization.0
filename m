Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712616F85A
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793212; cv=fail; b=l0Xckj+8SOEPoQozdOBO9oC/5jzlbm2m33KIR+ZzzEk36CD9+2kxkrGosk3Up+SfzFYCN21vuaaizU5U2YVSgjNORA5lkxgVXE/KkzR5HhRhsRg1U+6wN0G3sr5ovdRsarngUgm122hCmnFB6n+Oad4rfMvN8BqBCh16uxE22f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793212; c=relaxed/simple;
	bh=R+aBoXc5UT82CvCUVLoJwSDtpfyRlxNYS/sRL7KO/cM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t57yRSDp24UU5G+7vg4G6LQqQq5YrOvrVyNumNZ8x0UJ4QgyVc44Q2hdkzYVc6dHpBow+DJGXPyXoMgarUlupN3DbFe+dJHILuJIQDoXHMgSASVoWXDazk3//PPHzCaKNS5JGSzQeBHnFI3LzUMsuQ8sjdf823xq5tHAdiKfoW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ATcwfsQ6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s/B5MZ5Q; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ATcwfsQ6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s/B5MZ5Q"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F1BD40273
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 14:06:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cSp_5yqrFqeu for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Jul 2024 14:06:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 980AB40185
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 980AB40185
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=ATcwfsQ6;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=s/B5MZ5Q
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 980AB40185
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Jul 2024 14:06:48 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIMc4025593;
	Fri, 12 Jul 2024 14:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=QYGYIkrdnSsR5/9SughCNhiLl6XYPZG2YLXtfVFhWrA=; b=
	ATcwfsQ6xA7X27rPthKU9sb6Gf00oWAML6A5c6bzP2PyCNOaerphj5PWrxmR5Ec1
	l7q4H5tLlMzoiqjaEDFGe4gmDUygakFlriI7c/0QtYlvycpkJeNE1nLwL/Tf6bDi
	ZGtmdGK7Caio3PYeDAr9vUzI7D65vgeZOnK3bZcsqHF7v7oMQjZisLFVLhlE+hih
	ZX7eiv6pei/TjGpisxJI59NnalCK+lUWnsOFfBkvqDi8UbwzowNdPt1ndk1FnBJY
	QpLdj5mqQARKvTkH474/SKnbc7zoqbtBPDtPak5p53RxtuI3FC7GauKQlRLhNcH3
	Yy9imWvNr9WUdyHZwXgoQQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknuy74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 14:06:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CCcWrB030200;
	Fri, 12 Jul 2024 14:06:42 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vvcn4q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 14:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GP/O5EFIp1yuMrDBYiYIgg8n47R6oWDEhtLnzuoNMUWBiYWxSTwdOR9AatBz5Yw79TnrGmi8dbD1xQ6RcWgjglXKBhCU9XWKs+wZSLCJxu0fBy3zr6h2eoj8FdIcnMJ0ZQrfZp5BSdem37bfqq/X6CX65nOtGnf2cOfSZgS33roGTI5a8iD4eryHdsBMsh4e+QjmSlcBtfzoYU2wzDyt/KU8kS8iujWO9l4XxSfPss3cUyvtQGdwpOAoH4x7w1UWq/SHdlsv88wfNtTyyBCXTs1i0cey9yFoN1Ul2A/hWYz1slWnMGL9Ew3o/BDgzP0Ib66jGdLlUNM62aHHsSsE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYGYIkrdnSsR5/9SughCNhiLl6XYPZG2YLXtfVFhWrA=;
 b=VLFMFMySrPYoSK7t/Bu3mZFmMWHNhgtunjN0v639NA6CKVaJVYb6ZMGiWVadn1edqbOpKpwNpni1LCBucrLCVElZYzfpZO5MTr9lz7bHU/92fAS0nUYb4rEGWytO0HrtMzlQ/jBHaPvoM+jgXMxb2ENfpX+4x9pxGSFJHU2pVLJRg2oHZo0xOfWNEao7GylnruWGXQVaKheOInlSVnFOKBYVyXDSnp7QBgjH9GclTb+VV7ocPY8JUwDNBMCI5dFfWvsshL7eVFyB23/JjJBe2czYHUbgXued+xrRz4puwPCbAxpVAnA3xDyBM72VhzIOkkvOyu7/fRj7O64l+eFCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYGYIkrdnSsR5/9SughCNhiLl6XYPZG2YLXtfVFhWrA=;
 b=s/B5MZ5QrNzRcMwTnfnZwfl1yVEMMeeUJxeAtQD/Dj5lIBwGZBclkNV3aHTQStVfcIxHH7jjjUQDK2+ilP9STb1xdhXBLsfrp4QqjsnBtRKDjZBXcD4jo8Fb7HuKOfA5XsdJjuUThNj0I0kUer7vLjfdqy4llBYmDDNJnmGAJDY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7825.namprd10.prod.outlook.com (2603:10b6:a03:56e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 14:06:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7719.028; Fri, 12 Jul 2024
 14:06:39 +0000
Message-ID: <db3db0eb-f2f9-4062-893d-fd1017a9e783@oracle.com>
Date: Fri, 12 Jul 2024 10:06:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/7] vdpa live update
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0134.namprd02.prod.outlook.com
 (2603:10b6:208:35::39) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 41574d69-4d91-4062-0c8e-08dca27bd953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZVhBYXRCdVV1aE1uYzN6cFhmOEloQVprd3RqODhCYTRSTUlEQzJFUVcrQmdM?=
 =?utf-8?B?ZmhBQjJra0ROb0ZPWWVydERrdm9PK0YvbTNFMGpOTFVOa0ZtMUpwTVdNb2ha?=
 =?utf-8?B?b1RGaVJQNFdST1M2dkhrRnFmMGJZYlhoMlFIMUExSmhJMHFBbHI2d2gvQVRw?=
 =?utf-8?B?ZUJGNUllQ2hWQXpVei8ra0w3aFdlMFZ3SE9hN09xUDk4S3RhdHliaGpiZlNP?=
 =?utf-8?B?ZWgwYTZVUFFhcjB2eE45ekI4Y1d0TWpLRnRJYVB2MjJrRUF2UmQwWERQckVz?=
 =?utf-8?B?ZXVBaUx0MHA3bTVyekFTSVdYSHBsQkhUNllvc1RYak0zZFQwdGV2L1lDRUVD?=
 =?utf-8?B?eUVoZFdkNUFTbXNZMWlBVnlRRm11eWJDTkd5Z3NJWUdNTTQxOGgxUXpJaGll?=
 =?utf-8?B?Qkg2TUJzOTN6Qnc3eVJFbHlxSmJRYzhoUk1jNG5RYWI1ZlJkZitIMkMvMWxN?=
 =?utf-8?B?UUZ3WGRHaUJ2cVRPQXRaYlJKbFFCcTJ1ZVBwZGZUT1o3MjRxVWxtZ04zYnJh?=
 =?utf-8?B?YVE3WGptTnh6SEJjQmhzMWtveUVsR08yaGp6UG55MjEvY040VloxdXdYdkFz?=
 =?utf-8?B?NTRRWGNidVNiYzlYT2s4R2JEbkx4OU5mNHM0MVAwUTA5ZE84SG1JdksyZjE3?=
 =?utf-8?B?N0ZZbVdpMnFsbWhXa2dINVJ1T2FmZUtZM2FwcTVmbmRLWDd1UDdCcVVxQ0hI?=
 =?utf-8?B?alhlRlFuRUNtcSsrcTZjUkpwOVM5eldpUkpTTmNwYVliemVDMXVQUTNFK1pv?=
 =?utf-8?B?ZWFOVVB5anVuQ1E4Mit6MVpoNTF2K1lUOU4rNEs3VXNHM3pUcTVQSHBKMVBI?=
 =?utf-8?B?SjBVRG53QmM0dzdmbzc5c0V0eWNKdnFBR2JyWk11Y0dYRmtrT0Q5M090T1l5?=
 =?utf-8?B?bXRzalJmKzB3RjFpeDRIZ2JzSUxseDU3SUd1Q2Y5ellaNVNyektDSlNRZ001?=
 =?utf-8?B?d1BjNVZ5bDlLTlZkS2V3Zk42cWZLaTVjOVJNNEltbFU5SGxOZS9rM0JPSDJ0?=
 =?utf-8?B?WG0wcUNKLzVVTFBkbm9NM3JUaXZmS0t3L1laeXpZV2tucXc3R291ZWg3YkVv?=
 =?utf-8?B?YW0wNHFST0J2VXFYd2paeHU0L1NORkkwZjBmT0ZwZitacUtOUm85S0FpOG91?=
 =?utf-8?B?R2tPU1h5a3dWaUNxN1gzY3dZSGxpODFyWDYvVnZzS1NZeUNGQlpCVUFSeFJY?=
 =?utf-8?B?YXlCK3Z0WHhFM2dOeDA2bjk4T0ExUkhTc2RhSUFnYkJqOEhNOFZBUElzang4?=
 =?utf-8?B?czVZb1ZyMXd0cUVhb0Z6S2puQS9VL0cxVlVJZGNjLzU2dmJrcWVIbHlnYm5U?=
 =?utf-8?B?L2lmR2VSTUJVaWNHeXZWQVA1WGZwdjZnK0lGUlhLMjdlTkhBcTlWQW1PTXh0?=
 =?utf-8?B?cXhhS3RQMVdNQlBpUnIyQnl2VUl6VEUrMStzbzlFYzNVd3lkdmo3bGw1VmIx?=
 =?utf-8?B?YURIdk5JMEN1MUNnWUhMYStIaGVUa0VJYXRNazFzUXhaOWtYV0tibmlYZGJH?=
 =?utf-8?B?bjFLYUtVNkRNa3h3YTdLelpCYmtYQVF1RkJXelo0MDBOVExWZnRyb2Rwc1dn?=
 =?utf-8?B?Z3ZJMVBicnlVdTNtWE5abktxVFJyQkZuM25PTVN2NTNwMTdGV3pxeTRVSkpB?=
 =?utf-8?B?QUlJTHRoWEcvbjZpMEdaTW5STWptdlpYbENQU1Rjekp0RFZ2WTJKYk00ZUpP?=
 =?utf-8?B?V3gvMlhWelRQQ29hb3JlYlV1TGJnTGNWT3g4K2gya1oyNFFRdi9ydEFobWNp?=
 =?utf-8?Q?MjAJub4XIKIPc/pFig=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eTh5NjhwekMrbDl3Tjl0T1dabHRyM3JEMFJvbWdzTkJNVGZkQjYzZzZVNDFx?=
 =?utf-8?B?eWZNVWtqaGdoVURGVERnb0ZLK3lmZVB5V1FFbGVYengwbzdJcGpRUTRwYXVQ?=
 =?utf-8?B?R0J3UExhODNFczc0cmkwc3hMbGszQlNXU1g4ZVNhbzdHOVlCUS9ya2VsVExs?=
 =?utf-8?B?K3g2RnBMUmRtaGtMeVlpT0RnR0FtQkR1dFRGSG1ONS9VMlAvTm4zWjVXZ3RE?=
 =?utf-8?B?Nm41OWVaZWVhdUsybmJiemVkdEpUMFlXZG1sRmlwWWp3Ky9rNHBUVlpDZTBp?=
 =?utf-8?B?VGVBN0tSek1sWkhDSVFtWUdrUElkWWpDYWFmNkZWelBDUkUzU1I0RXR4ZzZS?=
 =?utf-8?B?ZFRVNUY1VWR0S29aaTFsYVJZb2ZwS3NUT0JQeG5TOGhZZVVWL0dMUjFGN1pt?=
 =?utf-8?B?a2RnSDZyQk1qdXhxMmY1dFU0WW5rWjNJQVM3Njlmb0djTm9TV1REeENaS2Er?=
 =?utf-8?B?NGZlK0FIMkc4QUpEV2pTWjVLT1ZCR2NQWTByQmVlNzdkTDFkZWNrem9mcWZz?=
 =?utf-8?B?SytvWDNQZm5FNW9HUlcxMXZkY1RVYUhYTSs0ZUpjZTRwSnNPeVFpUDBYWGsv?=
 =?utf-8?B?ZGczOUNJQWRuNzYvN0FMbDkxWVdDVjkwdTJwSDA1cEovZitpU0dIZER0Y1lo?=
 =?utf-8?B?c2NKU2RhTFQzSmdFR2NQZ0lMTGtEcnhUZjdibnlsTjdIV2ExdWtZTGhDYVpI?=
 =?utf-8?B?UWZxeWthNldpTkZ4ZWJYUnRRMENjdER6ZGZJeEZUQzlEWUk0UU9zdTAwQlpx?=
 =?utf-8?B?R2Z6MkRORERuWWFadXhMRzNLeDN2cDA4dGNGanoyRStXQ2lKN1lRS3JUdktz?=
 =?utf-8?B?ZDF1cjJSQ1U5a2lmL255TlpBTjNEcUloaXlYY3E5WFpnRWVzMnFadkpTZVFu?=
 =?utf-8?B?U1ViT0dCZU1VanBqQ3NtWCtEbWU1YXBxRTFkR3BkSThhdEtxTm9XNGFtSlpU?=
 =?utf-8?B?R1BJS1ZiQ3lTUk8vNjhKOHZ5bm0yZkU0ZVpIWW1YZmVZMUFmRWVjeXhsaVBH?=
 =?utf-8?B?d0IvQTl2Y1c3NCtrbVdOOWYyOGlmQmwxdUNsOUtPaUdvT3RjdHhvMmx4dFdx?=
 =?utf-8?B?SGIzNk9jN1p5WHY1NXRKcnEzSVFxRmppUWNIQkNMQ1NrRXgrYVJsaEIweTBN?=
 =?utf-8?B?QnBmeTk1M09IZXJ3SnZVRmhyVWUvWkI4RWUvVUhJc05OYmllTzV6dHJBRHBP?=
 =?utf-8?B?dWJHcUMvM3pNczhpWTNxeWlHUlJrOEVDb3l3Qk92QjYycVVrQ1ZQZjVHSk92?=
 =?utf-8?B?UzRYbjRXVm1yR1ZZRVlpSFY0Nm9MSWd6cTU0b1U1MVkweU5XSHp2d1RKTjI2?=
 =?utf-8?B?OGo4MFdJM0pwVng0UThHTUVnYW5kSUZYSHo5ZFpMVEwybVFoU0NoQm5ObEJR?=
 =?utf-8?B?dnNIRG9hYjhCVXJycHlLTTNCSjVmQy9nRG10bmdGbUNIOGN1NlVNanUzSFRU?=
 =?utf-8?B?UGN2UmVoL0NLTzRUeHNTZzFEbWd0TmVoWjF5K0ZsYm1VbHkvVnFCVHlUbEQv?=
 =?utf-8?B?UGhsQ1dkRVpxOHN4M0hkOUZBOWo2dkxRc0xkYUg5WVJiaUFHdVpmbDR1TU54?=
 =?utf-8?B?NWFocGptUWJmRTJWY1pYNi9DcHo5bU1wR0hXcllTVTNEQm9iWUxCL0dJTG5l?=
 =?utf-8?B?cUdVMWh0STBBKzU0dEpxRVgrcUJrL2FBb3g1R3JiY25oRFpDV3Q3MHBpaExP?=
 =?utf-8?B?Rk5GbGtUNnk1TDlBdzNPYW9DYmFYY0Z1Wng0L2lsMGhCQ011Z0FKNWw1ZzRS?=
 =?utf-8?B?QS9jZ3U1V3BSMXZCd3pmd0V4alhhdEpsdUdxM1dQYVFnbjdpUFhOMElSQWZB?=
 =?utf-8?B?dGdYWFdrVm93MmJxUm43WUpCeHR2ZEZSZXFoQ3QvRlNMbzFEaDJYZElLY01H?=
 =?utf-8?B?akZ1UWVHUzFHS3dQQ3hub1hMakxVT21UNUt3SmI5WkhuM3RtWnE3WTRwSkNw?=
 =?utf-8?B?SUE5WHM4U3BLZW83cXJ2S1NhU2x2cDgvQkh2U3pmYURCc1RlUHZ4K1U3bHJJ?=
 =?utf-8?B?NThhZ3Q3WjdvVmIrT0ZiUFRJNHFhcUd6Y2s0VHhtNW83YVVFeW44REVqY0NX?=
 =?utf-8?B?WHI2WWduRHBUYmd1QkgrZjRlaTJzbFp2eEhNUUlFaEl3ellncnpUenQ2bFNB?=
 =?utf-8?B?RXRJemE4Ukk2c0ZxTkNDVkt6L3AxczFFdEY4UGNaMlhGTjZGZFVMRXhBUnRH?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8YiQmCC8OFwLbmtzPGPfwEWjZT+geqDi6BKy9jacbgjylyDzgyWZFcTfYTgjOXIKBY70W67xzRFlQby98AhfBa6B/KFfHax0FH2YqJMjSwcasHHvEaXweVQH+7EIe7O4bdeEQXoXs2w2hfGyFAHbOQ+pjEodUQyP6Ph86Umo7Yq9nhIX4ylYpg01h7UfcKAFdJHDdSdxE66lzqlmP3W6t1Qrfk+yMRmTnIOeP0dw8FK0wMne710xhhylSwPvbqIiKZtHimn/BMDrTO+pwNu2rKIaSyDm8Nl/LMV6HoKk2PaEDbc/qRBdekBtv5IPHxDolReGyNOjdljqwksAlzwR6W3oHQOAuejcwq4V9csr21UiZvYcACmaRBTaiPpESKA6ySg+s6YWKwAfPTTgKIavqzsC1Ys2thwemvmueBSngDl+5MlChv//Bgb0NrR1fSAdIId2s0pH22A5erwPA0Gm2YEvj7XWjvWVirVbIrOdyWOEOvoRFD+DVM3C9YgK9ctj7iVUYdX/2R1ynS7V5eXw59227zGLLs59UIKzU/cWF2zBWx949X+wP8ezVIfgEXSOMLu7oDLeLQGwTREV4Bs8C7bogtQzcFbKH3qUduMO2sk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41574d69-4d91-4062-0c8e-08dca27bd953
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:06:39.1741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5v7dA5o48l+tX8WDOj4jGfYJz5jAuRO7nblVF80DKtsF7GS8wP8oGn7cBMUP7l60XJmOovWWA1TsQmbfi6HZNE0xy1EKZKfGW64s7N04OE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120095
X-Proofpoint-GUID: TtmfeDKXLxUoQuPOtWgjyNUsdYmgzqfa
X-Proofpoint-ORIG-GUID: TtmfeDKXLxUoQuPOtWgjyNUsdYmgzqfa

On 7/12/2024 9:18 AM, Steve Sistare wrote:
> Live update is a technique wherein an application saves its state, exec's
> to an updated version of itself, and restores its state.  Clients of the
> application experience a brief suspension of service, on the order of
> 100's of milliseconds, but are otherwise unaffected.
> 
> Define and implement interfaces that allow vdpa devices to be preserved
> across fork or exec, to support live update for applications such as QEMU.
> The device must be suspended during the update, but its DMA mappings are
> preserved, so the suspension is brief.
> 
> The VHOST_NEW_OWNER ioctl transfers device ownership and pinned memory
> accounting from one process to another.
> 
> The VHOST_BACKEND_F_NEW_OWNER backend capability indicates that
> VHOST_NEW_OWNER is supported.
> 
> The VHOST_IOTLB_REMAP message type updates a DMA mapping with its userland
> address in the new process.
> 
> The VHOST_BACKEND_F_IOTLB_REMAP backend capability indicates that
> VHOST_IOTLB_REMAP is supported and required.  Some devices do not
> require it, because the userland address of each DMA mapping is discarded
> after being translated to a physical address.
> 
> Here is a pseudo-code sequence for performing live update, based on
> suspend + reset because resume is not yet widely available.  The vdpa device
> descriptor, fd, remains open across the exec.
> 
>    ioctl(fd, VHOST_VDPA_SUSPEND)
>    ioctl(fd, VHOST_VDPA_SET_STATUS, 0)
>    exec
> 
>    ioctl(fd, VHOST_NEW_OWNER)
> 
>    issue ioctls to re-create vrings
> 
>    if VHOST_BACKEND_F_IOTLB_REMAP
>        foreach dma mapping
>            write(fd, {VHOST_IOTLB_REMAP, new_addr})
> 
>    ioctl(fd, VHOST_VDPA_SET_STATUS,
>              ACKNOWLEDGE | DRIVER | FEATURES_OK | DRIVER_OK)
> 
> This is faster than VHOST_RESET_OWNER + VHOST_SET_OWNER + VHOST_IOTLB_UPDATE,
> as that would would unpin and repin physical pages, which would cost multiple
> seconds for large memories.
> 
> This is implemented in QEMU by the patch series "Live update: vdpa"
>    https://lore.kernel.org/qemu-devel/TBD  (reference to be posted shortly)

https://lore.kernel.org/qemu-devel/1720792931-456433-3-git-send-email-steven.sistare@oracle.com

> The QEMU implementation leverages the live migration code path, but after
> CPR exec's new QEMU:
>    - vhost_vdpa_set_owner() calls VHOST_NEW_OWNER instead of VHOST_SET_OWNER
>    - vhost_vdpa_dma_map() sets type VHOST_IOTLB_REMAP instead of
>      VHOST_IOTLB_UPDATE
> 
> Changes in V2:
>    - clean up handling of set_map vs dma_map vs platform iommu in remap
>    - augment and clarify commit messages and comments
> 
> Steve Sistare (7):
>    vhost-vdpa: count pinned memory
>    vhost-vdpa: pass mm to bind
>    vhost-vdpa: VHOST_NEW_OWNER
>    vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
>    vhost-vdpa: VHOST_IOTLB_REMAP
>    vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
>    vdpa/mlx5: new owner capability
> 
>   drivers/vdpa/mlx5/net/mlx5_vnet.c |   3 +-
>   drivers/vhost/vdpa.c              | 125 ++++++++++++++++++++++++++++--
>   drivers/vhost/vhost.c             |  15 ++++
>   drivers/vhost/vhost.h             |   1 +
>   include/uapi/linux/vhost.h        |  10 +++
>   include/uapi/linux/vhost_types.h  |  15 +++-
>   6 files changed, 161 insertions(+), 8 deletions(-)
> 
