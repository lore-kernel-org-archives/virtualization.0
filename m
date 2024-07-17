Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638A18411A
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240920; cv=fail; b=Rk70EwRFNf1Ew6dB5ePyJ1AW0h6ZpW3BnZXhrNf4O7HkfBnsxe/IoamaUxXNVK4cZ+o9IDWFwoNRgesvKBavKMEVe+LQhP7L3AlMb25nJB8YvTdRXaO3cL7/SRDWvC6x5OwmR8DJEuKFr4APlMVmj6zmEFzkRM5lc0zgTqtvaog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240920; c=relaxed/simple;
	bh=9sPr3T08u7RQOShWKNRH7YuNpKAviM9E2f+bQQfZHJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMYM57KlkW6uANL+4bgx3MZ6XR/sVWG7EJST6dyMG8K9zzlE5XhH8E/gIE1uPQfdxuQ3RtuEcDpiPaa0pwh98P/CrQUxGDyQdS9bFLXg25FBifYX/m+QRVFfOG3S6kbSN0+vCPThsi28XUB511VNyOWACM03kFXJXfE025RIBbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S8rSoNLX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rAPLLxnw; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S8rSoNLX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rAPLLxnw"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 738934030C
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 18:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t3eFBiPpBuO8 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Jul 2024 18:28:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0D6D64030B
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D6D64030B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=S8rSoNLX;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=rAPLLxnw
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0D6D64030B
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Jul 2024 18:28:36 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HIB3SG024279;
	Wed, 17 Jul 2024 18:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=wRxC0I9ioCRbz0bwMgmALdESCfUjyHk9XwhwcmbK5II=; b=
	S8rSoNLXxNK0MNaS0IUDzeaMmLc18VB+6ti2feY6L8Iw9o7bNfENaajYdiPP2bDj
	MaTAZrGocZ1cEoFlFNti/mhxN0E/A9Uj5lVrXHEDLXExyuPCY56NPJYw+Xg22iL2
	e7MJOwd+e+gIuDe8H9e3Yyk2k10amHtASv5Y89gl9hcjhPdsDRfYfftpXsW7a5ti
	PHUk8WrrP1N4drUhE5XhTWbng2YVPtj732EWn07FDyiDE5xSY2abuf0XXsiGDBlo
	D5/A8vN0A+6V7ZvXzdd607Kk8t68osi2ks0Lx0EtEaHG30kS050HplfW8UWY4oma
	Jd9AGsz0hMhtlL1/FDQ9VA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ek0gg1d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 18:28:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HH4T0Y003762;
	Wed, 17 Jul 2024 18:28:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dweye3d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 18:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk9b5LGAWXs1HwjhNK9tRgBdUn1EEevjhN4MMXUkQUx4c0cNJOj+plsXPQzMAQH08POGVmSaTMspSBdVsw/L9t04i/TappUiUVH0/5yqDUfUnAAYwVB4NxSgQrTN0ZTLpuC/rAJx02piAIzvAlZz9Z7FGFcx74BN0RFWrvWxt/HZqDgOgQXN/4EFdm9IlNiTbkBjCDHT4SKex6+EM764AmxtJfVx+NiToBZRtfaVYALbweipFErstBZg7VerF1S7qYXWBnzXpeKn4116i9OtWXN6hnmKdJqrNVS5xgePs7riasC+VrjSgXxgoiFAFv0wkH80G8f8gpWxjAB0iBrzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRxC0I9ioCRbz0bwMgmALdESCfUjyHk9XwhwcmbK5II=;
 b=pXaMbxwE+e/9HHpWNJLoYvFB1EHz8RKh9/ifTw4wh9RhR6oEDNbdab8jjXFig4DYH8IZHyQpJmZrfZ7KJjNkKyCQx3JDQQ2M/xHaFa/UyFBlk5AvKq3djVYWWonViP0QrBVWXY4423YzpnCfutBIlnae/24oWa5MkUoFPEWgRljJYP4Ch7PtsRRCWNWGxOMLBZTek3E63e5uw9M2sghwTn0ZL+HTwNljV5oi7Dtu4qSk7iuF6m1NJ2Nkp+yYr6bDSusjyYMh5dACDrwp84WdhnXujYN9TE+HkQm5qROb9c52XjM/0wtSOSpRI55gCEcXaclY7uJ6us3aVNBqmno+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRxC0I9ioCRbz0bwMgmALdESCfUjyHk9XwhwcmbK5II=;
 b=rAPLLxnwvs6AKYpTMrnYKlxGtJP1fsTXCXqljRkXxP4c5O8+gGro+Xwh2DUeRf994fhZgt9LCK6tTF3aBjpgeKeVKrjrtHENJ/LZrfcaN2rmx9pP9VijUs4WNNFK+4tO+ciXqeSFq23AFVzIWBG1F2PYRKF/tI7GTG6SsVP33+k=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4183.namprd10.prod.outlook.com (2603:10b6:610:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Wed, 17 Jul
 2024 18:28:28 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 18:28:28 +0000
Message-ID: <00d3d446-fdb4-4c82-ae19-c65de9398677@oracle.com>
Date: Wed, 17 Jul 2024 14:28:22 -0400
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
 <acfccf72-2883-407d-977a-9c2566cf8cb3@oracle.com>
 <CACGkMEtL7Fkj+srq+beK8UBZ5QDowpz+hT2HZ8RZR00UsRJcVA@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtL7Fkj+srq+beK8UBZ5QDowpz+hT2HZ8RZR00UsRJcVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0142.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: de1d51f5-d79f-4a29-d376-08dca68e40e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y1ZCWWlwRXJCVGhsU2ppNUFoWnVUZXRoN3llVzQrWXdwNDc2SlhYVmU3R29N?=
 =?utf-8?B?ZFZvK2tHQmIyTks3T2ZqTnJlYTMzL1hWTVpvUW5vMllaZFgvSTNOM1ZJeUl4?=
 =?utf-8?B?Q3N3MHVzK3Vkc2RNSWIzOVlUclE4NU5ja3hmYUp3VFl0aDJMbG4wWGNET2dN?=
 =?utf-8?B?ZERYaUJaOFNMVmhRQnJZS0llRDhGait3U3htcjVweDlaczJoSU53NVV0YlBN?=
 =?utf-8?B?YXMyWjZHa2I1bGxBaS91T01hVlVBelBkTFpBR2pmYkpYcngvaHRrK0gra3g1?=
 =?utf-8?B?NTlVV29oS2Z4ZjlvU3k1cVJwZlpQcFpaWmxFN083UmxiNmxIN2NsamQrWENx?=
 =?utf-8?B?WlhZaVF1OVNpSFJ0NHgydXpoczBEbFN5NWp5NnMvVTBJYUpHRkNqYk1xTzhu?=
 =?utf-8?B?UVZFUktHdG1FdlhHQldEYndoajdLMmRXVTNnVnJUMVp5MW03blFuUkMrdkRJ?=
 =?utf-8?B?Y3p4ZnZiNEd5Ylo4MWRpNlBEOWt2c0xGc2ZwL21QYUhiV01OU1hneHJjYTJF?=
 =?utf-8?B?Mjh4enFmdVpzMnUzOHQ2ZlBVeHVhdzgyTjk1YUxnblo3VW1FQ3JxZnJSYkVi?=
 =?utf-8?B?b0RCS1lWZ0NiNlNQenNJSXhuRlVoeTFScTNQNGk0YmhnMWJxNG5VNjZ6aWc4?=
 =?utf-8?B?cFJqRk9YQ1RvQUowN3RPbUxBd242RnpsS0lLclNDaDdMVWx4eitpNVpKNHBH?=
 =?utf-8?B?OFJBYW9XbUF1TythRjhtYW5SR2pkTHBuL0N3U2E5dmtOME1kUHFqV094aFNn?=
 =?utf-8?B?SzlSL2ZjaDVJWUd4MkhPTTVYUHlpRy9wc2M0ZlptbWhwNTY5b1BPUVhnbG5R?=
 =?utf-8?B?SGkvL3BpcGhxcHFkNm5USlJpQVg5UktoOVBqZFZ5RSs1blJEMHpreVFybDFJ?=
 =?utf-8?B?eVFzR0k3cWlFQ25kSWk5ZytkYjJnU0pobktrSkMwQUFWdDFwd25aUFU4VXJn?=
 =?utf-8?B?QlZYeWU3cFFIZDhLOGcyTG5oQ29MMUMxYzNEUzBmbklwU3JNMUgxUG1LQkRk?=
 =?utf-8?B?dzFjNUFJbTRKYmRFb2ZjdldpOFFuZjBqNy9LSnFWU2pJb3YxaExqdStKdldr?=
 =?utf-8?B?SXRnd1FkbkNpcVkvbk5SZjBtS3M1ZjI5anhsK3FTL0dYUllPL28wcHB4cDJS?=
 =?utf-8?B?ZXJNZ1UwK0trUm5WZW1EYlhjeUdDOWpqdXMzaEk2bGFjR0paK24xR21QQlow?=
 =?utf-8?B?NkhSM1g5QURpbXFjQzdOZ2VheGtiaFU1bkVlVytwNjdXcURuaXAreXlRaVBj?=
 =?utf-8?B?Y1NCQ01mQnhhNjFyZEtVcFNLZEtIcW1uMmlQRVdqc0JCQnhSS1RHNDJVVEpF?=
 =?utf-8?B?WnU4czBnblM5THlWdjc4cUY2R3J4SS9TM3BKVEtPN09QM1loeCtjbGRwbDBP?=
 =?utf-8?B?Q2VoMnc3L09QTDc3ajN6S2lvTWFBTVhQclY1MHhVREp0VE91TzBld3l6TUhQ?=
 =?utf-8?B?dm9CL0I4S2pEelhlVDZSSThvMmh1UlpnNmU4Q01hTXA5bTRTMk81WlQwNzJu?=
 =?utf-8?B?ZkJVQ25KN3BuUmVjV1hoeENHdUxveHNJTGxPcko4bFBVbVpDOVZYTFk3SGNV?=
 =?utf-8?B?cEhUZ0VOWi9hL1lTUkJaOW5hWlNzL24xSVZ4U3JvM2kzenZyRU5UMmdSMUpY?=
 =?utf-8?B?QThmT3lUVWlpYUpGSkVGQlBZdHJJbnB6VEpwUlNTL2x5WFl2aXBabitpUEQ0?=
 =?utf-8?B?b3Y4d1JnTzFVdUhNTUMyeWtIV1hwc2sydi9HeWphSTBGNlI4ZEdlSGFoM2hM?=
 =?utf-8?B?SXRLNjBRcFFMa3dWNEZCMUJ0KzlYVnQyOVVMWExITEtaME9pUi9GQlRDdmRx?=
 =?utf-8?B?TlBkbWRsbW9JdEpHbFl1Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OWswQSt5WmNQdVJkOUI1eHdkMFlvTjRwY1lNYXRkMjlENDd2Q3pVVGt3SEVa?=
 =?utf-8?B?TERBM3hjUXpWSlVRUStQQVRyOHVUMWZscjNyeEhNbElPSitpU3JPODZJQmVI?=
 =?utf-8?B?dnZONUgxdVdGaE1YdnNQeEdIV3U4b3VUcWZVL3g3amlRK2pVeFV1YStQOGFR?=
 =?utf-8?B?VVZjc3YvOVA5M3hBRGNxcmVaTHVZTVlJNU1iUVcvQlh0TG03N0hFS2p1NGxW?=
 =?utf-8?B?cm4rcWFtRE1mSi90Z2VnNWRqVmdpQ1JxKzBjYkx3SUxpckkvT2ZwclRmekY0?=
 =?utf-8?B?TTFqa2EwdDZpOHM4cG5GQlZqbTlXMmo3RXhNYjhieWJTNEpEa1dnZ3RuenRa?=
 =?utf-8?B?cTkvelFGSkxFN0VZNTZOZGlXcGJTUFJDOFlXYUJJUnhFYlpaU2kwMXd0MTRZ?=
 =?utf-8?B?SEpmZ1FseTJlMDd0TmVublVJMU5PUU1mVkVNWlBJZUlYSlJzSHJST1ZNMHBK?=
 =?utf-8?B?MFE0WTMyQ2thTlV1ZXJ6c2RhZFg5SHora1N3d2FMcUJBcTNVS0FRK3ZrbXZ5?=
 =?utf-8?B?ejhNQ3lBODMwYUtPN0tCZWFrZDRQMUpPNnhHSC9tcSswM1pha2tvOXJRUG55?=
 =?utf-8?B?dEtrTE1JZ2xvdzkraUhWRFZsUU1FaUNoSHhkQjdYb0FRS0hXR3EzQzZ5RkNB?=
 =?utf-8?B?Y3E5V25vdjNZcFFCWmcxbG11NHo0WUR5cnU0RkI1ZkZKcUF5cnBROC9ScXE0?=
 =?utf-8?B?ZElENElZY2JYd2ZyNUxSc09aWTQwOGoyUHFmSGdTc2FDN054emE3TEh3Zy9p?=
 =?utf-8?B?YzBYemFRdzFITk4wYi8vcG9rKy9lTVVpZk5YRjZSS0VzOE1kdjlSUXFHSlE0?=
 =?utf-8?B?ME0vb3lOVE10NVRBWStnU0lNN1FLbXNyMFBqQ3cxQ2EvSjkrbU5VOURyWUwy?=
 =?utf-8?B?ZllrWVQrVmh1UGpWZjlIQW9aTkdsZjZpemwxcnp2NllnOENHQy9nTE5QUkFS?=
 =?utf-8?B?dG5GdHhzOFMycXJsVVJnYmMyZkRjbWorSEF3K0tEeWM3TU5yaEFZeGkxbTlw?=
 =?utf-8?B?M3dMb3VqZ3NjN1I1cVNEQ0F1UzVrVGhTdnVkWXdncWZBSlloYXJTK2k1c1c4?=
 =?utf-8?B?TndRZU52am02OHgwS3lmZTdrY0xUTW4wUnRaaTFMWlc3NGFXNUdJV0ZHK3dn?=
 =?utf-8?B?Q2g4ZVNFM0kwNnNxNGtGT0FvYmR0NmVwYXIyRTVRZEUvUnhEZDFQc05Jem9I?=
 =?utf-8?B?VUtnOWFVazRNTFpJei9GOTJlb3RCTDBLdmpabGp3empVZ3hLWUZtbUZ3TUg1?=
 =?utf-8?B?M1k3R2VKU3lXSTVnOFhQRzJLMTkvVXJCR2xndS82VXBmTFJGVmEvaTJFOENJ?=
 =?utf-8?B?VnVxVmtyTTYzRy81aVlXT0lxYUZoU0RYZWhnMHlKU0FKR0pCZGJ0bDhFaldq?=
 =?utf-8?B?NXpmSXNFVVRmVHhYT2NiaXVzTW1OSjFScGE4bHpVbGlDU2pKR2V3ZVZIVmRG?=
 =?utf-8?B?QThlSHErYTdMU2FPMURLVys2aUplTkFFV1lPK0JUMVVyMitYQlNMMURXUWRS?=
 =?utf-8?B?ZzFaOXRWNHl5VVZtL1QxYWNFazRTajJ1WmE3Yzg4SjBic2UrYTI4dyt1VSts?=
 =?utf-8?B?ejQ2bG9Bdm11QnU0RFpzNTZBUDNlM0RhYm1XeWh0T0V1ZjJRc3VrandFUGpX?=
 =?utf-8?B?ck1ROE4zSGQ5emF6L2Y5ZDBNQWtvOW14UjVoUExwMSszUFRicHhkZ0w0OGtQ?=
 =?utf-8?B?UVhvWVZrd2YvOUZyTVQxNGZjcGNhb0VLdnBELzQ1M3VFdHpRbEp0UE1Yc1VD?=
 =?utf-8?B?d1R2WFFzVlNHY0lPNmlkdEt2OG9iOHVXU0JoZU1KeGxMcTBZZlIyWTd0UVRk?=
 =?utf-8?B?ZnRzMGhLVk5oT0RUVnp5aGsrWHdXeG1lVUtDcjU5MnpoRlMxSkdRL21jbUNu?=
 =?utf-8?B?WTJlWkVOTVJxMDdVb0dmOWtTbkJyUTg0S21CMTd5RXpGWjA4ZUdBOTRzQ0I3?=
 =?utf-8?B?U2RuN0hOSFdwRnZIdjRxdjkvZ2R3SU41TjNDcG8wQys5OEIwd3BKTEdybXpJ?=
 =?utf-8?B?MVM2dlpBMlFLQ1lMNEEzKzFlL2ZJRkpKRzJwdXVXcWJCQlN6cXRUZmtuUDVj?=
 =?utf-8?B?ckpSakN1L2ZzdVQ1a3h6NWJLOGVtNEdyWVZUejlxOGEwMVo5WHhLTDBvNkQw?=
 =?utf-8?B?Z1l3TFM4S2toZ2wzNi9hcGVLUjRObUk3RituSlhCVUVXSzVXVzIyWkMwNksv?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	F92LZO8SM4133ZlOZhEWOaEhILpEHzWV3C73cz1telzuJVJZHSerfMVLutKthMd5S0ziEiEOvFYWV5pkI0aWtx3XkWbS4P/VRAzggyAWlwdbQezTbkLjLIhWywy2ky3lV4Kxsq/Vqzu5d8giA/bVjMrwMSKK46v6kE8evKlowDq/auV2kLmkYdgB616xLldSSQXWacRigA/s1Gj+we7ZWyYaOR3/uPBKvQ3Ulbrikp2h6Icnbor613brPxPqx/7Ub7ZcscLICZfLaZ8C+6KKTQfv5E6L4AZs/zZp0tA5OtSs/hoVC0vEnkl2oCcNtx98uyqzjMrIVh2dVsY0l8Sa7p45ZlLmipoApIKVonPsijox5DNzfow2rLaJX6opGhGmHb4yoTqepZDLd2FoiqdN/QK27qApA0NcX7tb1WAG6ho3SDik7DE661meZotj/3Ih+/MIz5PtN2eCLqTqvfILBxXPJjDG5AgiVINBqePEZLoKVIcIEFkQ16iW3GW7iKi3rxij0349v24RdGPEbB6aswUnAkopoqmckyACiXgpztinvHUYE5BbRhzmmhC5njb8FJxFwlEDhP4E0yexOdW0vOeax52MzvtasJfaA3gzdsU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1d51f5-d79f-4a29-d376-08dca68e40e7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 18:28:28.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vvj43p3RPJq0N+yuTx/58pskNmrz75rQmXzQD3ykUWuvp+1OEeTc4x2nSgBZsI5Ut5HBjBYXXa9qnG2yt8QG5aS5SnNeM5jp60B1ZWx0Y+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_13,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170140
X-Proofpoint-GUID: CVWT140fTujoXIY8KgQkjBYHDFcW6cCr
X-Proofpoint-ORIG-GUID: CVWT140fTujoXIY8KgQkjBYHDFcW6cCr

On 7/16/2024 1:16 AM, Jason Wang wrote:
> On Mon, Jul 15, 2024 at 10:27 PM Steven Sistare
> <steven.sistare@oracle.com> wrote:
>>
>> On 7/14/2024 10:26 PM, Jason Wang wrote:
>>> On Fri, Jul 12, 2024 at 9:19 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>
>>>> Add an ioctl to transfer file descriptor ownership and pinned memory
>>>> accounting from one process to another.
>>>>
>>>> This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER,
>>>> as that would unpin all physical pages, requiring them to be repinned in
>>>> the new process.  That would cost multiple seconds for large memories, and
>>>> be incurred during a virtual machine's pause time during live update.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    drivers/vhost/vdpa.c       | 41 ++++++++++++++++++++++++++++++++++++++
>>>>    drivers/vhost/vhost.c      | 15 ++++++++++++++
>>>>    drivers/vhost/vhost.h      |  1 +
>>>>    include/uapi/linux/vhost.h | 10 ++++++++++
>>>>    4 files changed, 67 insertions(+)
>>>>
>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>> index b49e5831b3f0..5cf55ca4ec02 100644
>>>> --- a/drivers/vhost/vdpa.c
>>>> +++ b/drivers/vhost/vdpa.c
>>>> @@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>>>>           return ret;
>>>>    }
>>>>
>>>> +static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
>>>> +{
>>>> +       int r;
>>>> +       struct vhost_dev *vdev = &v->vdev;
>>>> +       struct mm_struct *mm_old = vdev->mm;
>>>> +       struct mm_struct *mm_new = current->mm;
>>>> +       long pinned_vm = v->pinned_vm;
>>>> +       unsigned long lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
>>>> +
>>>> +       if (!mm_old)
>>>> +               return -EINVAL;
>>>> +       mmgrab(mm_old);
>>>> +
>>>> +       if (!v->vdpa->use_va &&
>>>> +           pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit) {
>>>> +               r = -ENOMEM;
>>>> +               goto out;
>>>> +       }
>>>
>>> So this seems to allow an arbitrary process to execute this. Seems to be unsafe.
>>>
>>> I wonder if we need to add some checks here, maybe PID or other stuff
>>> to only allow the owner process to do this.
>>
>> The original owner must send the file descriptor to the new owner.
> 
> This seems not to be in the steps you put in the cover letter.

It's there:
   "The vdpa device descriptor, fd, remains open across the exec."

But, I can say more about how fd visibility constitutes permission to changer
owner in this commit message.

>> That constitutes permission to take ownership.
> 
> This seems like a relaxed version of the reset_owner:
> 
> Currently, reset_owner have the following check:

Not relaxed, just different.  A process cannot do anything with fd if it
is not the owner, *except* for becoming the new owner.  Holding the fd is
like holding a key.

- Steve

> /* Caller should have device mutex */
> long vhost_dev_check_owner(struct vhost_dev *dev)
> {
>          /* Are you the owner? If not, I don't think you mean to do that */
>          return dev->mm == current->mm ? 0 : -EPERM;
> }
> EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
> 
> It means even if the fd is passed to some other process, the reset
> owner won't work there.
> 
> Thanks
> 
>>
>>>> +       r = vhost_vdpa_bind_mm(v, mm_new);
>>>> +       if (r)
>>>> +               goto out;
>>>> +
>>>> +       r = vhost_dev_new_owner(vdev);
>>>> +       if (r) {
>>>> +               vhost_vdpa_bind_mm(v, mm_old);
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       if (!v->vdpa->use_va) {
>>>> +               atomic64_sub(pinned_vm, &mm_old->pinned_vm);
>>>> +               atomic64_add(pinned_vm, &mm_new->pinned_vm);
>>>> +       }
>>>> +
>>>> +out:
>>>> +       mmdrop(mm_old);
>>>> +       return r;
>>>> +}
>>>> +
>>>>    static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>>>>                                      void __user *argp)
>>>>    {
>>>> @@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>>>>           case VHOST_VDPA_RESUME:
>>>>                   r = vhost_vdpa_resume(v);
>>>>                   break;
>>>> +       case VHOST_NEW_OWNER:
>>>> +               r = vhost_vdpa_new_owner(v);
>>>> +               break;
>>>>           default:
>>>>                   r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>>>>                   if (r == -ENOIOCTLCMD)
>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>> index b60955682474..ab40ae50552f 100644
>>>> --- a/drivers/vhost/vhost.c
>>>> +++ b/drivers/vhost/vhost.c
>>>> @@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
>>>>
>>>> +/* Caller should have device mutex */
>>>> +long vhost_dev_new_owner(struct vhost_dev *dev)
>>>> +{
>>>> +       if (dev->mm == current->mm)
>>>> +               return -EBUSY;
>>>> +
>>>> +       if (!vhost_dev_has_owner(dev))
>>>> +               return -EINVAL;
>>>> +
>>>> +       vhost_detach_mm(dev);
>>>> +       vhost_attach_mm(dev);
>>>
>>> This seems to do nothing unless I miss something.
>>
>> vhost_detach mm drops dev->mm.
>> vhost_attach_mm grabs current->mm.
>>
>> - Steve
>>
> 
