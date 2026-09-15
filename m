Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A65A3A2551
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506222; cv=fail; b=o/pElE4KfngB+CRAW2DevZ31D/f8imfzRAGOXx41WbJNgEKXWZN8JUomah5uaNdCOITZND6N1PA8mDr1ACwzeBI1txxNi4UdeRWQS9IZ8yxYemjByGDwKGfyo4dZN0l/8TFJ1o8JNabZfqkAFVv7THHN2cfXCy+LlwfuzSCVhR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506222; c=relaxed/simple;
	bh=GcN2CIZ/lfpJTA0nSTgU6GSkHHA0JLi/3vsLqa1SVBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JfPq9Y5mmzk+t7Er6MWygW44uuD5+SK7U+Vq3KfA8pRaM/b+kqlhXqFwJP2hUun3CLdqWyydHD4VpE5Ih7F9jv5Tp7nAV2V5/1oJx2a9o18VEVntX/+zG1ZoFaXR8T1pO1eZdezVPTAsFyJ+PzvH+idKhSuIsSgyQCi9veCQrkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qFhjc7oV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mEEgyO2+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qFhjc7oV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mEEgyO2+"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FKUxH6420223;
	Tue, 15 Sep 2026 21:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r4oM0Jo/sVvbOGmU0v5GYV0qZz5mUH+79bUL/ppMt9U=; b=
	qFhjc7oVMmx8cpUWvZotN9ZseFvetqaUr7joaGoALnpFsLIihvL9gQn6V3KbzGj6
	DzNR+9Jq+Es8G1zSLIsgsa6ghmXMO4nU1G5H5tix1ZPlaO8cqYolZiLIxER0YX93
	El8rlhoTkzIvgN0KR8FGc9o4y0XAc6s1aQhfiuFwl6YAZtXjpK9AymhpwrY2Y69J
	XBha25RcOAsCNSuYpH9yBD32tBeS3BSw3YOzQETAUgVubYJ+xeHnQgWjSPqcoU8Z
	0gLXfsnixZzcQ33W2eNsDwDP18HaNvNuFOaBkMMwgBfuILSu0gGiS+K/HUDz3Rzb
	cATDoamVAQmZrIXGw5CrIQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmy9rvfe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 21:01:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68FL1CSP002287;
	Tue, 15 Sep 2026 21:01:33 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6ptkp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 21:01:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgD+oqyl0hx8wTmunpIjtw8dM+lHN6W0SSqUFlnlE/kTQQkm4gc/+82wpCDikLZDFiRMcTuws1bhbhYt8YNuK0vTOiEHkK4b4uJTvb86naKuXtN2y/DTlFv17e6XC5KWefZ8MGl8XpPcqgVVxPNZXBbfuXWHMs94pEhIzo7/mM0ZzwtYSeuYyKKAlP64BsxjYunqAehQBYjUKM4Y6Y+IiMiY/KcWYC0X55xwopJYs6iQtSSzp+XSnLiO7WJnrGABBTNO14kGaEtuXGVPB66hghZbKXfU21SwZgc8BfDoxnktUuBkuSLjLqTwcIr9wytPR+zwiJ8mTLMnxwqyMnC8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4oM0Jo/sVvbOGmU0v5GYV0qZz5mUH+79bUL/ppMt9U=;
 b=o5AYTgki8iCPzhihDBEP4wEnA3tVJPUxnNv5z6JrkOlU8tK0waQ/fi2jJ8ypwlAh3NTTlYVJ6E7yOi7kr/XNJ5x6ueDo/eNE4Mk8vLOh0tudp6/tBEDvlHBlp2P+ncNWjMyhPicUXdzh2BEur9CUAD9t2EVbbvXYmYf5gsQB2cuFEgn5qGlNOFupLEs2NVaAaBIRLiXvQTivwH7fM55ya1j9jgVb61KvWKM2XDam4ZiD36LHd1MDU/DOLnRGr+jwsghR9UF4gDCdhSicvWP2L0MPtXyVR08CevfI82Ui10z+OnjDxA5fWORsdRUFcq3Hzj/koAXcYEvBxO58ppHyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4oM0Jo/sVvbOGmU0v5GYV0qZz5mUH+79bUL/ppMt9U=;
 b=mEEgyO2+Q/iY58qwxWS8mB5Iun8uir0H6IjJwOSbHKlJFf1XzjBmCLt50cL8be+czY8ANhBtsMl9p4OFv6h1p7M9oMzkCMGH7TDJvM0+C0ugA2K1MS2H6dCoLtb2KDoRTYWV2ZEyo+uqJCs8DBTUtb+GNr1QUUi9HGQp/tIQo5M=
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by DS4PPFCC66F9CF6.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 21:00:57 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f%6]) with mapi id 15.21.0428.004; Tue, 15 Sep 2026
 21:00:56 +0000
Message-ID: <c8867400-9b31-49b4-b74a-3d27e6046330@oracle.com>
Date: Tue, 15 Sep 2026 16:00:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vhost-scsi: preserve event ordering
To: physicalmtea@gmail.com, mst@redhat.com
Cc: jasowangio@gmail.com, pbonzini@redhat.com, stefanha@redhat.com,
        eperezma@redhat.com, nab@linux-iscsi.org, asias@redhat.com,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260915094244.7900-1-physicalmtea@gmail.com>
 <20260915094244.7900-2-physicalmtea@gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20260915094244.7900-2-physicalmtea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:8:44b::12) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|DS4PPFCC66F9CF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db99606-4053-45ad-2c5f-08df136c700d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|7416014|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6m6+X+APlcwOr7FHjnWatquxR1rF6rKihgmib/k+Lq99n9T9/z+r+y35yNUed+QHrggmAeOhkx/c/b4xs/NXvGAb8Rw5Exa4K72oxZl9o+tzUKphLaB0EvvCGS8ZijVKvBjlDJAZFPJNsqDh+kGJMHaZCGXAQX+4tyZDnlyeIoh+uE6BtGPAi08Nu2mfyJ1qk5Ng9UiRmM5azyaDNK5/2VPVIgA+xwbA+E1+mm3vrwNW3HvMoq5Kz8ulHJ4bQREmeu7+gNIxhNskARLIGYuFtvHOvkSnnogaEQ2gqIOkOE6efSL7UPdeLK+EISbIevN+/ndCaLolCeB9ZaVYXB2FxK1fPbAImbXYg3QWHXqIaXtnLN9qD4YP9hyxlIigxLQ05mkwob1ZdK0P6tz3VmC1F2nKitcKneIJszXZ3K+OsHYRmzfH9va2h4wtt2nTvq445B2fTCofFr1BWL9g0MYD2CMgaVHnLLGavH3pHsZkoUwwkPKNuZr9Jivya2XZTlCmA0RJPES06D548BA/0QPJuvJIOR6x5krrpHio/KTY5AoZLkt9LFn/FBmzVQy6MS150owtg+44+tuM3m5VCWJ2x8HrDqD8kB7W1dWSmlAZ8AsIZvFudTyM++LsG+BEU2AwHHE5FSmR4dqw+BiUkV/IG5y4HlgITQaH0Onx2IrbtMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(7416014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE45NHdWSWYwc0lUQUIvR1BqbGNNNjgvdWI3aFVUTDhoNDB3MGRrZTJmMFpz?=
 =?utf-8?B?ZStwbFRHeWJYUXJKR1ROSWtjUXNQQU1EaitDWkp5YnU3Qm9BZmpiTVNFVHA2?=
 =?utf-8?B?d2JuRjUvUmdpTFBmV0FheHFDOTZ2OVlSZFNSMld4b1hKS25pMG94ZWtKRjNu?=
 =?utf-8?B?K01nYWtsek5pQ3lSam9QU3RjRmU4OFl2UW1QUEJ3aFIvUllRN0JMQlZWb1Ir?=
 =?utf-8?B?YUVZNmM4RHdXeWNGZUNQL0pobi9VY2ZpZFhuelIvSW82VG1CYnhDTkhKbkFX?=
 =?utf-8?B?ei8zQ0VOdzZHcXpkYnBRdlFaZ2dEWER3YzMzUFRlUnpoMEFyWUFOdXJ0RGNp?=
 =?utf-8?B?N2lWa3p1NFpSMUxvRi9pd2k5ODVqcTJBWG9yU0g2M0IvT0s2RHduS1hPVXFz?=
 =?utf-8?B?VnhYdUFveVpyTVdlQmlQN0U0TkZDU1hnK0VuSGJJYm1nWXlDTHlWYXlaNkl2?=
 =?utf-8?B?L0IzZkgzMGYxeEp0RXNjSTR0K1NXbElNNkJqYUxVS0x6NmJxUm5ackhwYjM5?=
 =?utf-8?B?V1JuVWg5eUhuS0o1QW9iYUtVcTFFR3lzSURHbzgwazZkelUyTUZkbUlUamJZ?=
 =?utf-8?B?TTJoU2lSQXl2TlNFOWhYR3hYdUx0YXF6VXhqMjY0Rk14cFBXT3VhcGRrdlJm?=
 =?utf-8?B?d1BKVjdkVnc4WVZSK0ZZTnpiNUl1RGRIenUyNU52OXpOa0dwYSt5aEM2dCtJ?=
 =?utf-8?B?WDhYcmwzOWpBcDBGRVdDZDNwTTF5dWFjeldpa1l4T3M1eSt5ZjBDaENFd2Rv?=
 =?utf-8?B?M0lQWjgraGlqbnEvcnJQbkhUUWdIczMxRnp5VDRUVXVjdWZLWm5ZQjJsN0pt?=
 =?utf-8?B?REJEcmthOERieHljdFJzY29wcWYxa25nM3YrbHFsTXJBcS9vaE54MG03OFZl?=
 =?utf-8?B?TkFJSld3TWdwL0loSlVycWNkcG96NllHWkJ2OE9qd3N4S2hXQjArWXkxbHFV?=
 =?utf-8?B?clRiNXVoMFpoRTRlUXovRE45RHRYc2FZaE9tTVNIN0poUDBPRTlyZWg1TUg3?=
 =?utf-8?B?T0ZPd3dRb3RhMWs4TVBDZmlqeDRGNVRNV1hyTmpqaER5TUt0SnpyZzhOVXFV?=
 =?utf-8?B?ZStiQnVHSEw3eWtpeDRkU3l5Uy9TaHRuRVI2YWZya2F5MWFrV3Rha2JLQjFl?=
 =?utf-8?B?QzIrZFJDcExMQzdIUGpFNGdtR083eVJsRE9QL3Fobys1Z09ZMnlPTVM3KzZz?=
 =?utf-8?B?OC8zS2J3WVh5RTc1ckdzN3p3cE9MRnJzZXhuTjA1UGZEZUdmeTRPNjNlalh5?=
 =?utf-8?B?L015andlTXlsc0x3aEROMnpId0ZDQk4wbTR2ZUg3SnFGOG5OM29sS0tLbldx?=
 =?utf-8?B?Q1lhMHlDTlMvYWJoU3JVQ0VYS0kyc1h4bkJCSEtyS3dzVDFOQklBaFlZa3lU?=
 =?utf-8?B?NGlIWUhBR0d0VFhjYkJwTFpYenVzWUpkazIwcVh6N1NlMWVDYXVndXBZYmt2?=
 =?utf-8?B?L0xqbWRBMThlWEh4dzR4V0wxZ1hyeGJiM3Ivc2syNUhyTEF3MGw5ZnJ5Ynh4?=
 =?utf-8?B?dEI2UWs1Q3UyazRLN2RtTzVmdWJEc21rQmVrQ3hQQ1I2TGhpSVFaTy9nVStH?=
 =?utf-8?B?ZVk4RUlNN05pSHdGUSt0ZUs0ZE45dTlwa3F4aDR2Y3dOT3JGMzFwTlhIczI0?=
 =?utf-8?B?Z1l1TXVUM3BsV28zcVRMUUxCZWZuOEJQaHVCNE5QdGZTOG9aVU9rUHQ2S3k5?=
 =?utf-8?B?R0RmRHloM3VxeDEzNTk5ZWxGbUNyM2RrZkFMcEdub2FjVDQyc2F5d0ppQ29Z?=
 =?utf-8?B?V2xwb0Y2VDljSVE4MEQvd0RKci9tWFN5Uyt3S2VBQlNwSmN1V0ZQYWhza1dh?=
 =?utf-8?B?cVBCclF0V0o4eityblhHMEN4MlhHbXl3cXArNTFZb0VNQVZtaThORlpvRDlL?=
 =?utf-8?B?SVdXV2JtZXZoOVprdXkxVndnTzlpWHppQ3pCZ1FPWmtsb3VHbWxhcFhYSUR4?=
 =?utf-8?B?VENjcE10amUySFQ1MXJhUnAxMVdqYjZBZVI0aGpLSXpzdkJ1VmN1ZmVGS1RD?=
 =?utf-8?B?V2RWbmtwYjlKa0kvWEp0aGh2aXRpNDB4YVh4Qlh2RlBTV1BBZTU3UEl3WWtn?=
 =?utf-8?B?YitvbHVrUkJ3dDdEUXErVUVDNVVnNVRkRkNic29RUk1zNFRnWWdkMkdEMDlr?=
 =?utf-8?B?OEVRNm1jTjE1VUF6MVRDdE1SVkVrdTh0eVVXYzhMTTVGV2Q4Z2ZpcHVEaUc0?=
 =?utf-8?B?dnFNUUlFMzVLTFgyZ1h2dzMzVWYyeEVzczNJNmQ2cU9tTThwdnVNUm1ncDFs?=
 =?utf-8?B?ZHVqY1pVZDRXT3pXOWRlSGdNUWJxOUVPZ1FvaU1PcVlqVUJnVVBiVG9RS2g0?=
 =?utf-8?B?NEFaby9NV3p4bHBaQVo5L0ZjaUhyNXNCK0IxNFo1U3lETDVXSzdhNzg3MlFW?=
 =?utf-8?Q?XKDIlmNyqIgU8j9M=3D?=
X-Exchange-RoutingPolicyChecked:
	H8bLxkLZcfiUPtph2qixLZcGoTXEYWxUobrZIMVfbzp+79j2WvnCts6UwpMRTbO5fQPK9GO74AB5V6C5IyqgIB3x0tEU9PLlyk8BLI5REIMLbMEskP2KUKQL1AjIgFyG3pKDnn0mudQzuNhbSyK6QWIF74mMbKzEm2fCfosPr9DqBLmPB3I+VEL6SN3YBUwf3bNfWbhbi0jV+rdXhf7Ywm093GC4fr8nolk1BXJRqTQmQLjSANPbPMUycvHqV67j5WqnJ50W44JaTQCOgKnQaZdSXQ+KXTfNeJtx54wGU1Cz3pb+oGPxh4Fv9E/fP0CtnyC86zEvhI/LmWiiKB8uDA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ky8mBWMuf8DNphMxR878Qtc12obg9mEnEb6ge/eIchVcYi6wgq8+KIk8nojs3unHGmdo53rhAL1SEJvrXbao3bvf83Ki5lUgAeYdsAkJn8FDtpZBiRdpxFGeTUUz1xraS8J0uN17VoMtgDbsd8Bc4OmPZg2AQoIkUCYUSVTZF5+MpUnqw83jQfNdaT0Pb83j2pQesd/Temv8vGqVzQKMpyaQZ/DZ54fQid2ZSoXI+Wyu76p731+BZszg+SNKYTbqFOhkHAWgWoAyl8HSI2qUUbiYCFXFUrlYUZ/FuYA4juo7DwsTXM/HjX7Ww6X51ekTlNVr/bFYqEfcnfPBRccCQyqsHA51G9T2nxMseUvE6y2bN9wjjc4Ox3txQ9StsFAs6mHQ59vab+k9C6OspXzYwlY0Il2WBcBIfA8+BSWqaHFOHXzrSl5/KdvG04fBUNCkwNlJRnW4OX/T4G+yZF0zE6hM4fORrZVTpvMdd94+xc0DQg9a4Vw7AZuKjVfr1HG7/yYM9MHb2LOoULAITe9ZpXZRQFWOxAzX/gPBI0093hKliho1d+EEjrbFCwuU+A0VA39xshMgA2GE6gvuvYh0y5RGt7zxgowVu632LR94Q9o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db99606-4053-45ad-2c5f-08df136c700d
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:56.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dorZ9vmhkaEJN8VB4UC9dD0cPWOPTUvdvNChN4rQXTbiVgqqsOaXeRf9dkeOI76ITEqKmcGt7p48aq770uzbpRvgGIoC/kFP5esM3Ft5/gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCC66F9CF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609150307
X-Proofpoint-ORIG-GUID: Z3xvOF0RJYwnMNEDfI-JPJkTMvv3cc5m
X-Authority-Analysis: v=2.4 cv=MuvHeGae c=1 sm=1 tr=0 ts=6aa9b22e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=3l4_7AiJYdMg46sgo0kA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMwNiBTYWx0ZWRfX4eEd4RDFd/LW
 QHGFLz9B0E2s2HzTg2BAwmOOmi908Z/L4lPuYwxo0qTXh/ZcdyunU4sLaEplkCpla2sXP2b+wxC
 Pvb5hH/w6J8tvZoQIp+Xiirttshnaat6CzqURwvtlqxBf/RNZTP+
X-Proofpoint-GUID: Z3xvOF0RJYwnMNEDfI-JPJkTMvv3cc5m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMwNiBTYWx0ZWRfX33z9bU+QqME1
 t86V9Q6Z4vRz9I1ervtNRWarq8RzL2OsqcLDOaIf/2OxlB6iVhBj3Yb9iJo3YZFn0Sirt1anCgn
 2RVNaQeTT3fmD+YZYglvKRquF/IemcDkqUiZyBAQfX3AUkFpQeLeKrwE0Wb5rX2yqE09PF8jZwX
 Y9Wv6iHUueS4haIt7lPcL9aYvdw06WYEcUb8b59kmLk0a7IP5ZPexf6Ke3tyt3b0NxVtmnSCeKb
 O6YmkTc9RRxlzlx2RdgYYlOzf4awXY9MGOgL2hSBTOT8VVrbH5Wrvqeb213tTt/MGu73nCMBdvG
 ckIhC74HzQ8XHGXiuz5m9S50wKcwjN2b3CnRC5ZJqb24ZGr1l09q9bF8c2iB6XR/pfQPY/VV9L2
 BQM/u7y+buwreuiY6a/rZm2BSMJldBL49aTqiVS1HyjIEopyGt/iUfRS8BwlCBUeOlLS/MIWho6
 qt2ZRmxU1eXrjCGM6+ujRP41NanFPaAFmEtAxDbA=

On 9/15/26 4:42 AM, physicalmtea@gmail.com wrote:
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 7a1f39a32..37f681aab 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -637,7 +637,7 @@ static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
>   	struct llist_node *llnode;
>   
>   	mutex_lock(&vq->mutex);
> -	llnode = llist_del_all(&vs->vs_event_list);
> +	llnode = llist_reverse_order(llist_del_all(&vs->vs_event_list));
>   	llist_for_each_entry_safe(evt, t, llnode, list) {
>   		if (!drop)
>   			vhost_scsi_do_evt_work(vs, evt);
> -- 
> 2.34.1
> 
> 

Reviewed-by: Mike Christie <michael.christie@oracle.com>

