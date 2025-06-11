Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2827511A
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675489; cv=fail; b=coFoUfS2arjDZ/GJ68BOhy1JWjMsO0Ss5G8S/V+6xz+XYJndNq3G7SVyV5nyGeS9joYg0VrtFBdAyqeJpequEe5EBycFv+IRIfT1D6Z5wMGccu4WgWW4nyZ4X7f8SDL5N/o2eo8UC+dfZdGPzC4HFaat/QfmOvYwOn0PtyJEYDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675489; c=relaxed/simple;
	bh=ePGkb+7MfIF9DsTc070iaZ28csfKxXo4S4N/jri5zSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PiVvz6KaC+RTBMhkAEVm0Fx293vEMNGROwh8FjqGWWaizSQchZcF4/wvqBzyx6vKaThwOd2Wjc1Q5VnXJub1HJEr9K+Mwqb3wC9dsrNalrZmAw3TIybAo6tL4pxzmh4ml3XO8/k6JCjxTawiB0JUg7SiBAof18yun90uUYgDSD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lj9gc1lh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pcdp7wq+; arc=fail smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lj9gc1lh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pcdp7wq+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EA6B80F6F
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 20:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aGm7Njwoy7Xo for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jun 2025 20:58:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5763D80F5E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5763D80F5E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Lj9gc1lh;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Pcdp7wq+
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5763D80F5E
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 20:58:03 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BITuQb004621;
	Wed, 11 Jun 2025 20:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MwkiBK4F43M/P7xHdkfYGtWAvLFiLssZ3MgN96B+z0k=; b=
	Lj9gc1lhFUdF5RYHBe3kxC/zZQ19HhGgFdIpOAqUwCE1nW99djVMrKPFQnDLkIJi
	z75NEMIj6SmY28ZdLkcR7KzZkSt6BUvMedQaV3HfeuKmH3xRNNXga9VghEhraVPx
	As65vaUeFs9cCAF0Xgsv47KmSHCtV9xIgSv6J7/f82OiFKbhR3gl26HkVCiPbtTJ
	dPRX7zlfUjbYs2QZT5RkoQC8F44ZACdcvy4I8zYC79p/Cz9XvI17Yhm67CaEY0Mb
	QTfb2boBJJUseVpniTvsfAcruo7kxcEEutYow3ZIOkklrG1cYizD0RztONc6npit
	p0Onp4jWKJGW1zX8rH8koQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyx0m19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 20:58:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BKgMpI021511;
	Wed, 11 Jun 2025 20:58:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbes1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 20:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luYQw5nI/PIuP1GKbZICI0ophJ7ANAuQa05PeaO1qJKfLndKo0dtd8zAIG5XZ/cLWPk5eZy9iqYKoc3Lc5mt93ZRMVFwMHmbpbK8MQp0WmZ3vDvhuZX95bEjh5R7es2zN+s9maTBTVNBZE1vvZ19Iityg5SBWkSNWctBxB2XVGOkMGX560/4vAs99VTeVTt1K24yUHjligcxY6IPKNPl5RlOmgqJw4SMfPEi/OsRchXdOBjKqCldTDu4/uP9vplsCJsCzRPkMAxXW/gWEZ8Xkm/8wG+Rbc13d3NC80lDxdj+xFQ+UkHIeON3w77kTW+Kmfrn6aqJUSMm2O1LZ57UGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwkiBK4F43M/P7xHdkfYGtWAvLFiLssZ3MgN96B+z0k=;
 b=B+Wj7qdkYtvxPOFVT3UII8WO//x3/Q3hQq4p6v8ptYJwm9TeTZUsQqTOUvUA3sqMWWFBhyVhZjoKzG2xVC2/lEapKySS/ojNpf48AUgLYL0/2VS/FRlUVj++RVqeynjkdolNZ3DI7b6Lj6ZZBBmzoOuyaz6S9AoB+tZ1hopFBucMTT+wIKdvXZnnRUqHWhthXfiUSwfNfc2nHYaGTvrffc/qvOMQt9ZG7sqSO+LhQxhG6XRO9fUXZrca4LIDb0KQHiDxqiIUM1b/FcqB7jeAWPyuqGSIhZYrvTYm1p4bbGmbkmYws7StjUNClKXPVXqZxl45VGFiXXHqdy8Hd3dgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwkiBK4F43M/P7xHdkfYGtWAvLFiLssZ3MgN96B+z0k=;
 b=Pcdp7wq+A+/L9hW0A6ump91hSgInLlQSbjz/kXkoJDE+BPNIFzEhNX49Y6YKruh9wjxTA8RJkByTN4m11eJ1nCMtaHUfUhJnY0e98IWACrtpJbmEoMYiNPE12/VCVkb5vfPs+1rTeBSR3GqbXvog9FD0RlAsL23uaxxozuKjTzM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SJ2PR10MB7708.namprd10.prod.outlook.com (2603:10b6:a03:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 20:57:58 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 20:57:58 +0000
Message-ID: <0c5424c1-19d2-4642-953a-62d4e17ddb60@oracle.com>
Date: Wed, 11 Jun 2025 15:57:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-scsi: Fix log flooding with target does not exist
 errors
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        virtualization@lists.linux-foundation.org
References: <20250607171815.111030-1-michael.christie@oracle.com>
 <7hsh4exxtfbeu2h4zvt2bptunezs5ppaeqep6gkn7xkmpu4y7k@rb5wfwqaembu>
 <051e7185-5fd9-418b-92ca-807418e88ae9@oracle.com>
 <oudxv7fw7jziowituwevjiah6ow6is6y3fmnbcdfkz5mkgoyuh@qs2whsn7kbit>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <oudxv7fw7jziowituwevjiah6ow6is6y3fmnbcdfkz5mkgoyuh@qs2whsn7kbit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::29) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SJ2PR10MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b910e4-6348-4973-72df-08dda92aa542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnE2OHhvNkdSenBzWWZuL2RMdXo2c2NMTWJHdElxelVFbWF1MUY5dEd1Qytl?=
 =?utf-8?B?MTBXOFZ5eHBvUnM1TG1YazVRbzlmRVZRNHE2bG5qZzduRkNPWXVtMjk4bFhW?=
 =?utf-8?B?MTZtY21iYndZQkFjWWVYSjVEdmZFcUd1Qkt2aXp0OWM5TDdwcWQ0MWI0YjZM?=
 =?utf-8?B?M1dwUjh5WUlMa3FKdE1NdDdFOVJ6RFhTSTJac2l2YnRuRlRNeTZVOUw5TjRp?=
 =?utf-8?B?WHZhQjBIMHpSWkp0MWJ0bWxJU2JBL0JzNnVVbkFOdHdoYXpqaDF2OXpCM1Vj?=
 =?utf-8?B?S21pT1dTZk5aUmV2YTgybE1iZEFjc3drdElnTEV4UHdtaEo0SGp1ZTE2a1JX?=
 =?utf-8?B?REp6NVQvOW9pQ1ZyQ0RJdkZxOUc4MVI5NTVHcHJhVFVkaGVhWWJSZ3hrS2lW?=
 =?utf-8?B?YnJpVWRwRUdSWFl0Y3hrai9wUnFvcHJSNndLMHpDN3hFK2dkbGpIdHNiekVL?=
 =?utf-8?B?QXExKzhEOTZHVGN1UjlycDFiZUdqSmZnczhCQldmeHhVRU81SDJ3RXZLeUMz?=
 =?utf-8?B?UWhxWFVuWnArU2R2TUd0UmhxN2J4OTdQVnNVRTJneUFuS1lCZWFTdHBjVTdY?=
 =?utf-8?B?NWhwL1pya25iL2c5bVZtVytuRDYrZEdxZTc1cktGc01hMzRQdXBtVEhGTWZS?=
 =?utf-8?B?WXJ2ZXBHQVBJcEtNd1Joc0wxSzdtUklOR1lqZXlSVUREa2pGNVNZNUFoY3NS?=
 =?utf-8?B?RTdJZFpGMWZrdTJDVmlNaE1MdG53WTlOc0NETnFVT0l3ZHV0Uk1mTWM2dXMw?=
 =?utf-8?B?N3V3YTljRXFmTDIrSGo1MDI0R2JyRVlxMHNsQ1N1RzRQcnZvS1FnaUZhVkll?=
 =?utf-8?B?S3hDLy9yaFZlRGVMc2RRMVA0dmRyeHpQaHF0MnY1S0VQZ2ZjWTdGbzR2aytU?=
 =?utf-8?B?N0VoVEZHcjVKbTM3TUtVb0xLSXBTREtmVWFJWkRQYzVFSUFaSU52V3NzUzlt?=
 =?utf-8?B?T1FDZk9VTkdjcVoxeWVDQW5hTDBmQUpHQXlWK1Y1ZExmaGgzTXAyeDNvbTl6?=
 =?utf-8?B?TnNEbUtaUkJkeDMzcWFQWkhpQ3I3RE03Tm13S1E5RDRyUWRobWJjMlRUdGE0?=
 =?utf-8?B?ZzNlYW5lTTdxaW0rMEJBc3VoeGZqdUhlWWRJbDI3K2l4aUdnZzZaT3hsRWVj?=
 =?utf-8?B?QUw1K3l2YlcxZWRtNHJzdUZWc01YL2RNM0xVS3U3amVkRXVnUmYrSEVib05U?=
 =?utf-8?B?SlVzMlRZMEhZNjN1dmRSN0xOOU84amhvemhmTHpyN1huN3RzcG1MQUtxTjFu?=
 =?utf-8?B?WEZyMTA4dTcva2liRTVKV3lCV1dNckM4Vjl5Z01pL2JVUjVuTVhla0k5bUI5?=
 =?utf-8?B?WGVCZTVGRUlna0xtR2hBdXlXWkdOZ25LNGdCVFZoR0J5OGRkMm5DQ1kwNHpI?=
 =?utf-8?B?bW9XNFRuODRTM2xTZTVrd2J1ZzJGb3NnVUd1eWVBZnRiTHhuQXlDK0dJNmFN?=
 =?utf-8?B?MGVVZjdkVnhFQ3psdGZuUHZ4UndRdFRBWnZkTkxVT2tObkJPdmxaSGFCZWZk?=
 =?utf-8?B?YkFaVmh0dFVnZ1M5MVR3WldlaWV5YWlOM1ZpRTR3ZjVQSWpGY2JzM1JTd3JJ?=
 =?utf-8?B?eDI4OG1qbDJVdUJvR1RIdVNFeGFtL2k4bWtJTVdnd28rNjFDck4zUjNtNnpR?=
 =?utf-8?B?OUFvUVFDakl5K2RidUxUVFhVbmFnR3dkU09iRnllSms4eDhsNnNlSDZoTEhC?=
 =?utf-8?B?UnFZMWVkYTdoZ2grMU1KN211aVVDRnd2dXJoZS83Q1hxUjMrQkwxTFpiUzMz?=
 =?utf-8?B?QW9ObVZSQ0FOL1lvS3pOSDhKbVZsZDAzZ1hxaWRBNUcxUy9vc05rNyt1aXY0?=
 =?utf-8?B?U1RxYVdKT1hPQnRFZVFML1hWZW8rbTFKb2J3YlNFZHgrdmsyKzBmeVExOHd0?=
 =?utf-8?B?OGo1N2ZJbjFWcFJFU200dnExZHFFWThCeExWZU9WNGx5bENFc0llUEtTMlV2?=
 =?utf-8?Q?58zBhoI0D+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzY3V2FDNU11ODZ1K2RkWGdJWHpZRytYOGQzN2NJZjBnUG9mVmJOS2kvMW1B?=
 =?utf-8?B?UXpMTzJQWTFQbHY4OE0xd2VTYWRqeFNxUHZ1eDA4R0NQWk9wUFBabjlYZU5w?=
 =?utf-8?B?eWFuTXJBYzhDK1ZkKzBOWEI3cUVqZXRTdXZmVmZFOUx4MGlWcG5aSkhMZFFC?=
 =?utf-8?B?ZWt3TngvVUE0Q2pna00rTjJld0pOeTE3TWVQSVl1RnoyeGk3eGFQSlMrMjdP?=
 =?utf-8?B?dGxJMUo5YnZTVi9vVXMya2JOZ2grVTErTlpQd2tKeDUzWFJraEh1Z0tPMWpt?=
 =?utf-8?B?c1VOVjVzVXd1cUNSS012WWNuUkxsbDMwdnBoMlZKMCtzNlhwQWJEQmJhcU1C?=
 =?utf-8?B?TWxWWHRacGlJMFJtbWMzMXIwQk1CM1dLWVZqbFpWT01ncEZoWmlaU1NoZzRB?=
 =?utf-8?B?MGNqNCtKMDdhQUdYY1V6djNYMUdUcmIwRXcrS01pdzBKQUxudVJPZmZmV01h?=
 =?utf-8?B?K21EOUM4a05PWlZueUI3TW8xSGFiUUZoMnJpQlNneVFsQytwVFdkRXpuRTlL?=
 =?utf-8?B?YkVEdGZaakRtb2FWbWVZc1lJWFcxY3RJRWRLRUJ3K0hndXBibkRGQVFpT2ZM?=
 =?utf-8?B?UW1vWHp4bGN2ejdJdjA4aGRTRHp6dEVvd3pBajhZaUtjOEEyTU4zUlZob1ls?=
 =?utf-8?B?ckw4NXVJS2dWdGRLeEZKOTVXd1d5NzhEc28rWk9JVU5lUkpWNVNtSzZTT2xH?=
 =?utf-8?B?amZsQmpERnpQRzdRZHh0NmIySE12SGkydjhoMVBSNTdYalAwZHQ4cGFEQW54?=
 =?utf-8?B?OGw4MjZ2SElKcERjWUN0T2pkS0VyV1Z4WkQ0QXpRNENGMEpnckQvdlk3WG8x?=
 =?utf-8?B?UnNTcFErRE1IZDg3ZDNmZitiUU95UDYxZitjZlNUaHVxMEN5b2N3TmFtdHJV?=
 =?utf-8?B?QW9vZzJ1R0g0clIzenpCZjM2RWxmZlZXOTV6dWVZS1FYb25RaUVnN2VZVlh3?=
 =?utf-8?B?UlpXZGlHaWlMZ2I0bzhaM3VwTUR5ZDQrRnpxckRZOW02SUowUlYvakE5amxW?=
 =?utf-8?B?S3hvVlhzaWVYTDZYZnZ2VDdwNEQ1VGRNU1MrV1p6VVBXRjZ4Y0ZnVS9IVkJD?=
 =?utf-8?B?RXJLZFhPQjBGblA5L00wWUc1d2xIcDEzaENzSXdNbUx5eWdVK0QwT010OWti?=
 =?utf-8?B?ak9UeVZzUWJvUVdxdXRoQkRvT2pzN3hDQ3J4SnlHUFRjblNldTNJa2RLRDRX?=
 =?utf-8?B?TWFEbldzVEJBT1Zic1NVRjYrSFI5dFhvT2liSFJGbGNQcktLTlBNS3gxV25Z?=
 =?utf-8?B?NjEycXl5WTdFMnUxcDQzbjJIQ3Bwb1YrbUFheWFwS0lOVGl4S0VPK1B5R1d0?=
 =?utf-8?B?YVR0bEoxb3RGRzBteEVpNko1VnYwY0FxNi8xQWZPSWQxeGR4eXEvM0JHbjNn?=
 =?utf-8?B?RHVROGdDMndacWYxV2t0dGlCdUtFRFBUWTFnOE5RNnZzTGkyWGZzcXZEbjkw?=
 =?utf-8?B?K0oxQzNCZlRXc2VGNHJIdlZSQkFjY1RUa3Jzdytja2lpWnRCTVUxb2R0Wmlr?=
 =?utf-8?B?L3Q1OEZBYXd0SStMZzE3bFQrSUtyV29QQTJNZXpzaEhDb3F0ZXFUOHVoaURV?=
 =?utf-8?B?K2xuQ0VLY0hOUlVYWjhmU2l0OHJKaGhwQ0t5MUhNb0RudUh6NDBBYVlEeUt4?=
 =?utf-8?B?V3liMTNsSjllZGo5bVlKMkRyc0ZweE5rVEN6bEY1eW1ZcndoZlQ4L3licW42?=
 =?utf-8?B?THEzUG8yblBnS2tEQjhWUTFzQVBCRUZyMVl4TElCbFUxT0JFL2ZESEl3d21l?=
 =?utf-8?B?Wld4QVh5cnViU2VQclJuQ2cyZVVVTnUxNVVOVlBRZjBiaVlDL1R6cWV5cllz?=
 =?utf-8?B?M1hNRWRxMVFtYWlsOWx3YUZjb0RzQkpGWG8yT3ZwZGtlQk9IaGVtWEtwaCtW?=
 =?utf-8?B?NTY5eWp0ZHFYYlRZSkZ3NUNXdytVbDk0N0lKZkV0UHBEa0dxRmt5b0IvcUZa?=
 =?utf-8?B?S2t0SEtxOVAweDZ6ME1Kb0xYNVJCZWsvVVlKQlpDZGhac0xNSlFuSVkwNmpC?=
 =?utf-8?B?WDhibHdXN094WGMxL0E3eWJLNlBzN0pERjhXc0I5T2pXZ09tMENza1BhbnR6?=
 =?utf-8?B?NEtkbEp6Q1hxNndSeGxOenAweXZvV2EwU3dsMVJEMUsyL01mRDNqV0h1ZWpK?=
 =?utf-8?B?bkk0d0NIL0dORGtvYWtzTE9iZUZ0TlRpeTJOK0tKTHdMdUFCNVJ6TVVQQTVq?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vXRQYHCqU4GE3IYS3U6ol4/1hFSqNN307j1EcKsndzOVpNooJZ2IPmqkMKTbF9T/pO36FLnfJyme8QhKhnNNxNfWu72p6cqzqBclpN+akGHcOSh1d1XdexsFUDBxzOxyskgCvR8WYR+uYP2kwLCPMTJ4YUgzXrwtZJWjInc4GQ4xFd0n18ePTLTDvYZokMswb7maFyUS0g6Ae8olL46p6XmD/AE96k9l1zoZQWkXO8Dq50cJO2YGPsrPEOvIjqA5TIFvHaKRUlNwy+u9N5wTL+Mg7H0WJ4IxQm51US2MKM9AubBJNrYmN164Nb74frTED8x6uviPMfuyHo1oPKA2vmp47s9mQCoacWIsADvoDdWhtKOl2+3FRJRhF8lCdK3q38rG6HjJquJZT6dnqWGgPcGvoG5wOiTUskCsASajteifpRYIBRr41Xqd3NwqKZwEOJ0ZXe34sOJg8rWwUFHLAQvrKyTXyOYnRcBJZrKIEt7nKZ8jIJi31rGgUnGcqtA7NoHI0jiPc8MDtls/mY1izCf0qMkeKfNBlMW2lIUzfr9oFv14/qW0rW9MmgkmMdGAaFT28fGgg9LMPZyetKcDQAYTLATwxbTFKMCkYxAMoGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b910e4-6348-4973-72df-08dda92aa542
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 20:57:58.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfWR2iG0qXcyLuVkN2y619swojtnpov8bYjzmOzjPKJ9tZ4anzwZ5MrPghSJEm4jxGWNgGh0DDD31rW557h4EcgRlnRUpH6ylKpLX6m5Pfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110176
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=6849edda b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=9EMkc-tziYbfMo1J_DAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: DpdpWewb_98IM4-Xxoe-J2XhddaaQrfF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE3NyBTYWx0ZWRfX08W77SMQzExd s6Zn3B3WMcXyWvXEzoh9oHuy6OiKbAMuFLZ5NXYw+gUEgV0wUWCQlegHDh+Eq3jpFsHUdqy8QdV Q7ynbftQE2UC4/1Ba5F12FN6C+7xRq5hThLUEQizE16XANVSfjty9In5bZ2dLyDrjMATSk8pn6u
 7vi+dOYxffCfQO8B5p9UNvGghCZ9G2+6PVu1ERolXVUaGGLXB6KYpn9GQLQBik+Hea1F20mzsJl qcaouHXvTr7BgUUjEwq4lntTuNkhLv4zNV8CFMRHlHcbBEF4vi+/MZfeF9njzqS8Dl06Od9gzWO HkpOIIAdG4RVyqmHGVf+Sn/HbDpM0sno9PDlniRVVNmz25/md4lFCbbPeFEwOcEICz6CTIf1ntH
 M40/s1EFdP1k5GKG4SPFM1FwL6YHH7sytfAE3YaqSwhKiB6f9tPw77ZhT9WMaVFw/0D/dGYa
X-Proofpoint-GUID: DpdpWewb_98IM4-Xxoe-J2XhddaaQrfF

On 6/11/25 2:50 AM, Stefano Garzarella wrote:
> On Tue, Jun 10, 2025 at 11:30:58AM -0500, michael.christie@oracle.com wrote:
>> On 6/10/25 9:18 AM, Stefano Garzarella wrote:
>>> On Sat, Jun 07, 2025 at 12:18:15PM -0500, Mike Christie wrote:
>>>> As part of the normal initiator side scanning the guest's scsi layer
>>>> will loop over all possible targets and send an inquiry. Since the
>>>> max number of targets for virtio-scsi is 256, this results in 255
>>>> error messages about targets not existing. When there's more than 1
>>>> vhost-scsi device, then you get N * 255 log messages.
>>>>
>>>> It looks like the log message was added by accident in:
>>>>
>>>> commit 09d7583294aa ("vhost/scsi: Use common handling code in request
>>>> queue handler")
>>>
>>> IIUC that commit just moved the code, but it looks like it was added by
>>> commit 3f8ca2e115e5 ("vhost/scsi: Extract common handling code from
>>> control queue handler")
>>
>> I saw that and was not 100% sure what patch to blame.
>>
>> Your commit adds the new vhost_scsi_get_req function which adds the
>> vq_err call. It also hooks the control queue handler into it (control ==
>> SCSI task management like LUN_RESET). With just this patch we don't see
>> a problem yet because the normal SCSI command handler is not using it yet.
>>
>> My commit hooks the normal SCSI command handler into the new
>> vhost_scsi_get_req function. The SCSI command handler calling the new
>> function is what hits the problem because it's the SCSI INQUIRY command
>> going through this path during scanning that hits the problem.
>>
> 
> I see, thanks for the details. If you want, I'd expand the commit description with part of this details, mentioning commit 3f8ca2e115e5, but keeping your Fixes tag.

I'll fix it because the wording in my commit is wrong.
