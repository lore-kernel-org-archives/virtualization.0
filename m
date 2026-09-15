Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6242376C
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508325; cv=fail; b=DEWZY3DM8lWpIPdtnVeBSAcSxYWIW4e9w98vssflbYHuqDo7Gt2xBKBH5zXKytW/SoyQnXpf678jRCB+6PGOpmFYpuAOBitWAK5FMkExFXglGrkPXGbVoNxaIYKFvS4JpDeyVoymLckSKJMXCPc9o9wnu81PpIYk5yKXbX1nFhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508325; c=relaxed/simple;
	bh=/V+mhqWvJ/HmyJZ6VaLqc8BKmNzTtlT+FGeuAsAYDSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=H8ryN/etVp3Q+W0YWditl2rpOy0aGJVJQFFJg7nJ5/S/TcRLQ2eP11R9AJ1Cfi6r5QVOoVqA6q4aquFI2XtRgkv3A/+xXP/WHm6PcjY2VSPZrqZPRRQecIxuqfkUsi6v24088RqhghU0Y0l7tJjwsojxb9T3fBgh7OI6Jxee9xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fkXnNyD8; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t/WmDCT/ reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fkXnNyD8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t/WmDCT/"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLXLoq615751;
	Tue, 15 Sep 2026 21:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=q4Hb6j+TRlJza2yYjcnISItgzbvDVQvknUe74h94sUk=; b=
	fkXnNyD87QEFbCx5KlMVWOWEujNYLmsBXPpVEj4FyeH/g3bPtJGNX1vFC+OOvIL/
	vJ6PCKLScXgWS3ROw3gjGatqHEgvvr7UVLBr3n01Emeh3+ADxdWeTTp46sj/2WVH
	mstXmNeTIIyJbdlDRPmb0jsTLINr0Osq5P1A3mVftzT5qFVLE1xQAGAYEdOn8Xjv
	CZQ+6uQ1FtywoLbksY6nzd29i8tga6BWSUDyuwZxa9hXGD+mqCgIOQkmLsRn069F
	yjthWceyX3MNI7h4HlU3ZVWclplPhLEKxGkZWWGeKr1MoE8cka5Ivi7q9RV1dX0f
	hRBqv24yu3IT/EnmoxJD/Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmway4k80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 21:38:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68FLZnKJ016718;
	Tue, 15 Sep 2026 21:38:41 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6am9pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 21:38:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqAoD7WqeHwhzVcPkZSwp1+tVVLTFDstPJmLWENp3tICIbKkweKNcGC7XfvpUtV1brZAz6Y897TVYJkyuCRBThTqeTJkZTQvKXGz0NhsdLrvG/ZZPofnMcqxC4w0GWzK7QAefYz8FbCJZVTO6nrENlZtl0CcFbrukirmm08a78q+thyf/RhRZVie5jl9L+RHEI7wf1R9Cyg/y5zIuduWkkQIH//lzg/RFW6FL28TkJKFn0RwQkDC15vLax7S/naLIj26BLifjPAzoDzCFu0ziVq3SVMcVykqlSyw4DD0+M7bB5Xgl/N0tqD4xrw8EM5zQZfoBIRe8XQ7QghHcFbk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMlLaKp2r+AJXzgic4K0AIXT41cwcziPQ0E/HWkhifc=;
 b=mhlm5bc1aYUFywkysiTZDflguPXN3nlcxem9A69dj9QPj6hg1IFxuOw2YiD5h9XRsPzFy313DEoyTkf9n3n4B7kw+gegozuxnH1ikT+yUak7hFeiW9bvFD4MGzSCq19iDxqUn8oku/QO+Den100aU9RAP4XB0Zak/n0jmLCRUPv45xfpV+kW2ozo2qBR5BcgAF2QT1zSSdNmu3sSkaVXhAhyDHvp8Np6jyKQQKX1jGNrNTylbMfuWgcRcp/1I3wIqtdPoVTV9WLvM/86Wj0n6EYLyDcv4WMRQu7i0CI+EiFTt6w8uih+j6CK31QbYYQUXzLRekoVXVhT4TK4D8IyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMlLaKp2r+AJXzgic4K0AIXT41cwcziPQ0E/HWkhifc=;
 b=t/WmDCT/MUZo5pvimMkLX+TI1Dhd6th6r/OIROtVwyO69sDHq01YSO7IdKqNQKswkJkDIvP6KRj1THQlElGprZOiFX3L9Z6tAVgpgbo5WlQHh66QDNmvc0CES/JrJdKYZaMaiNpgVlGKTNFVIRX98LYe00aAQlG7FliZDIzIZdw=
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by SA1PR10MB6294.namprd10.prod.outlook.com
 (2603:10b6:806:251::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 21:38:39 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::c70e:bb7e:7d68:be8f%6]) with mapi id 15.21.0428.004; Tue, 15 Sep 2026
 21:38:39 +0000
Message-ID: <7a2ed1bc-bf7a-4744-84e2-72c79bd36f2a@oracle.com>
Date: Tue, 15 Sep 2026 16:38:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-scsi: initialize command pools for late I/O
 virtqueues
To: Linfeng Sun <linfeng.sun.dev@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260908-fix-warning-in-sbitmap_get-v1-1-767c2c211a2b@gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20260908-fix-warning-in-sbitmap_get-v1-1-767c2c211a2b@gmail.com>
X-ClientProxiedBy: CH3P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::34) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|SA1PR10MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e18f842-d898-42a9-8a7a-08df1371b471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|10067099003|56012099006|22082099003|18002099003|4133799003;
X-Microsoft-Antispam-Message-Info:
	nfUzNIVlPcNpQZu73u1ieGKRfBoaF02dGw7uw7f184mgWTID9xQ/SQ6QEUTZY01Xy3MHMf/M1XB3xm2hSaZIn62ND1eV8QXGGytngfgOtVRZTwXPMpVArZTzeyDHJCNz97tg6DvAHVLIYKNv5BGjZMF9ncNiBeI7NhJADrexWp5uSbd55u+PA8urU4Ixz0bg9Kzf163h6BIvkIFSFOSKWaZ4j65SzFyzfR3zE8HmEiikHjZ1Bti/k8xw6hSoy6QwH1K+LodZXPQMYhn8VRfn29gl+VjVts/ecAEIFeZDIdXztj9o2CO5bO42tz+aeR7eDH/A9bCvg2M5wow6c2JiQxK89i9w74SvfHJoyipjvIvmLIn2MHFrEMYh7S5d9Sd8MEfwyYnGiLyBzrCtPJUVOt5F+VFEkOAgzFJmB3UzOjsjMmIP+k9IJ1oYaa5GyWPqnB4azeahktp18mUw5055MIpE8FXBTUXTBin4GP7wA3va6mv50GVT6+ZeaKCANqTbnFATTuGycssQFEVK9CZMN22fNlN1Sm/LYPo3LMGnoqeEcPRLbFPA2nAbVBwJ6ZE9Wc6e9X1GlTZsIIHAJN9o8mQgD8pRmBTyRnNbZp8BBnrz4/H4k2CZ8z0Je3kOtXpyW9/vDUCsg7sYtWhWbXUrdLM9Y7KRHQjeceCzD4PemUg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFGVGprV2lEaTZTSnlCeVlkZWo5OGRlWU5JTUR4NXEvQXJkcTd1U21EVTl6?=
 =?utf-8?B?eDJOcXF5cjVxU1pLak53WlpkZWxTRTdKNlFrbjJGNkpBdXpXdFAwNjNWR1dy?=
 =?utf-8?B?b2JTMll1ZkQ2VEE5NVFOTDRra2lzaWVXRWJFbHNMNGlGS29WVzhYaHo0V1Ur?=
 =?utf-8?B?cXZiM0lCVkp3eUw4U2ZheE1IUHpLcFVaU0lUK0RDSmtiSEdyc1lIVmI3SDFR?=
 =?utf-8?B?ak1EZWx5S2FhVlU4TUd5NDlZc2gySWdOSXRvVkFzYStDMWZPQUZnOVF3cFZz?=
 =?utf-8?B?Mm8wNGZxeTQ1TTVoVnFaUFIyRjBnWDRYUWFTb2p6S09yZnpVR2VlU0gyci9o?=
 =?utf-8?B?OXpJSERzQ3pMRURzVUlHbDFUQTEvaHdGUERkRTZTd1MwV29JQWtIMG9rS29z?=
 =?utf-8?B?Wi9TUWxWSW5NWXUrR0hDVUZmeTdmU2I3K24xUXdldzAvalVjelVwVVo2V1g3?=
 =?utf-8?B?NGMydEZPV1RLMXc5K05HcStlTkxKb0xYaFBXeG5SYU12UXVrcTVpMG1hR3FF?=
 =?utf-8?B?T0ZUNFZIRlZYZWdxR2k5STNqNnFVb3JXVjVkb3hxTEpMVVdjM0dPKzRLRmtS?=
 =?utf-8?B?RXAyYjV2THBLVjFUTUVOSUFjRUE0TUMrRE1ZNlE0ZTVVSUkxRUdZNlFacVhv?=
 =?utf-8?B?bDZmOVhsVkE3eTdjZFdSNEkxZ0c3aW13Njh4Zkc1MWhETzR0Ri9BR3FxVDhw?=
 =?utf-8?B?R2xoKzYvQmQvVmtodWZ3UTcyNnpqZjhJYmFYNkw0TUl0cHVUVEpLR2FvUW1w?=
 =?utf-8?B?T3V1UTNhc0VQdytMQXZWRWtLdERNcFM5Q0pFNE9OaFFRTjlIRFlYVXlZeDcw?=
 =?utf-8?B?WEppNjhOZ3J3YU1BejRkbkN4N1BkVUk1SldxZ3owZDZyQXFtTlVJMmc3S2Z2?=
 =?utf-8?B?MUt4UGFSYkxlQjJZUVdSV2FZRCtXYjlEOXUrYnNidUZjUHNNcnF6SHdSNDZZ?=
 =?utf-8?B?OTdRRUJISk9WV09YRUJVTDU2L1Blam1wdnlNSHRrUUN5bjVNTGNmek5EdGNP?=
 =?utf-8?B?S0xTVWl4YzZmNGsremhzRnpQcGpkY01vay9LcnBIeGk2TzVQZDl5UE9LTkQx?=
 =?utf-8?B?ZGxRbDJLSVU0VTl2OExVUDF2NTJWY0MrUGRaYmVaSzhCRTZUd0lRSW5ObUc2?=
 =?utf-8?B?bFZMR2VyeDhsL09pZHh6enJkbEtPMjZMSXdPRndoVFZrYXZVYmVtV0ZUcWZP?=
 =?utf-8?B?MmYvMDJESFlwY0hsSzM1M2J3SjFWdml6RTRxQk1KUjBzM2xTQzltQW9HVVpP?=
 =?utf-8?B?a1cwdmc0eG1pOGU1bG80cm54WXBRbWxTWkZXa3dvUzlQbzNld1UrZlpUMlBK?=
 =?utf-8?B?NW9IMWliOTZXNm85WTNLK0JibUgyUFdFRmNEVGVGWmlialF4WENFYk5FL3cw?=
 =?utf-8?B?SjVaUGVNaXE4T1ExaDd1MmxiSzNDdmRiNmUwOUJkbEpwZDIwZHBnemxpOHd1?=
 =?utf-8?B?YzNjREpzckVJcVJ6akJNZDd5Qnh2ZWFsZStYQ2JFTk5zanMyNU5ySzZnR1RI?=
 =?utf-8?B?c0lQOVNzNDFQc1pxY3B3M1pMOWl2b0NZUjNrS2sreXI2TzM2UE95cjdoUUNV?=
 =?utf-8?B?TkdnM3Z2cUYvVGN5VFhsQlJ4VEFFV0ozVzZGRk9hQVhOcW5MS0YrdGVZVTF3?=
 =?utf-8?B?dFFabG83MGUvOWtERWVhY0JUc2lCL1JKSHZxL20wVUdpTkZKamVLMHI3dVpl?=
 =?utf-8?B?SGhTaWRJOVNUZVN1N1F5eFlRZFdWb2hFdUpKUklZQWdQRDFmbzR4cmNFV0VL?=
 =?utf-8?B?RW5vSy94aGZTLzdpRk9ibzlVWUNrTTBEaVM0SWhQUjYxZFpBdEVWYis5ODg5?=
 =?utf-8?B?NGNkVzR6RjVTNWxzVng3OGV3YlRDc1R1M1VSVU5JY2FxdkM4NU03eWsraHJD?=
 =?utf-8?B?Y0hvUG5ZSnBpMXl4b3FLajBmTUdyOU5IVExvWkplOWt2V2hQZHVnQmhLaFZu?=
 =?utf-8?B?dHFOeDhmeHdnKzRZQ2krdXVDQmMxanpveHdDSnlZQ2VGcWxPbDJkTlFOTS83?=
 =?utf-8?B?RSt4SGRWaVdScGp6RjZ3Ullqd1lzcVZhRVUwOUNvYVlxMWVYa0RGVzhRRlJH?=
 =?utf-8?B?NWNRa21OZkpvMUt5dDBOaXpyYThZY3JOdFM5KzBMT0p2RFFvdjhmZ0JUN1dI?=
 =?utf-8?B?T0hSZFI5eVhyMDNYVk9qVFlwUVdHT3U5aXBNT3Rucnk0Q0xyUGlVWmNPc1dh?=
 =?utf-8?B?SCt1OGJhMlEzY2dZMlJXS2Jkd1Rka0s4cFRXMWtmMlAwUjdoRGlMazRlbzJE?=
 =?utf-8?B?KyszL3VHcUtZZmVhQ29Dc3ZEbkRGQnRiY1ZMYVo0UDk2YzJaWFBkTzY2N1pz?=
 =?utf-8?B?bjVQdXUrMFdRM09ZWnIrcGNOVndxTks1cTBLZjk4alFTRzlqVTZhNUtkY21j?=
 =?utf-8?Q?sQBDgRXvdQMG1zu4=3D?=
X-Exchange-RoutingPolicyChecked:
	qQe/FTou6tak+kOuvjYqN6RL3hwiFQsgeBfh7m/5Y54wYLCxqrZ7UVqrKfFRPF54LqYrk8MtCQSa9dawCZX0KHJydwqgmJGiybYoVbZ3VXv8dMGn4urz+mjHAuD9mN2KdadMoNM29PeQnUpNtQDQ9QVfOaOxXMddB5W8jvi3MIWJWzkOqfww6S3DHKbmp3ucFGct3M/j89ftt86nkuzZH+ARglPE/jqhXWkuQLzxErEDFuMC+5e1eZXtQOjdbpuoStAJp1o7BAVkSS5J0IXSyTtmMMGWUHFVDMjbGusuROy8LquhSmR+htaaM9WtmUKHd0AL7yCz8+Jd/N6pjSk3tg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WAznKOmTPeNn37IcI5Ug8u8xlbeEQg5pcJjwbeIwBiZlDBc79BJAJ1+4JdG0H/CQW7PA3wB0d0yjIcqgTYYE8fYPiUXL2hpCYSCe0jwJtqgMPci/pyE0MrPO88pP9SQSFRQNufTZvrcMNfkTyV11XEnpYtrz46k9jCK1w+CYa+4E9i2pppicuktZq/FAsV9u6Wk5ZpW2uNXeggX5OQyDCKebY2P1mZBabfbTBalZVfFu8ROsqw9UXuyHgt7Y5JILjJS2Ny1o5Vt5tWnJZNbM9daGGrLecNzbsx9KjlU/XEMnagG4M8T8/+TcQ0I0bkAytgKZh3r77xp5PmxWA0osZp2+K0BBb3BDY9GLStxR2S6R+F0HK40KvSe94G8aWk5H4pwtz5cDpugYcJZoPnFQxo6SKAtw3kC5ejGdKoTwdET4HbDR2aIqeDQ+RG6d1PkbQbthqmsa4h8UPif+U2jUwJ1zunRGEXBKyD+EQDDS72UUcqKAHS4OgaB9EQHMhbOKhbae/L2wKw73H+WbEZBWVjCAufHupFnj8G23gawRrGnMqDDgBJ6FiiAltmsB4LwTrDydvH4NFBEF8YBjirmGbKWHGqtN83VX8cyiv6VU2i8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e18f842-d898-42a9-8a7a-08df1371b471
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:38:39.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PubX5oRq4Gn0o3mXdECO1tKEPsRuqmuB9UMeN/55p8O777hOvWOGNp4wsIFq3EnuxQHC19JESA42mRIMB6kgptfSMrwS5WSWiMDFn7wnEoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609150315
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDMxNiBTYWx0ZWRfX3H/XmPvdYhpI
 jgDC3uzmmQuOZjIr0aGxw3xO02uDIUfnOKNUrhY1UlFz+ZvR1SNM5d/nQdgyKRME7kiy5URBSFX
 KRHLpdv4VtoSRI3/dcTupgYdTBl+oClKY8simO7r+y44GA3dUchG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDMxNiBTYWx0ZWRfX4WpOdDE5ivzD
 b0fwCPktYwkjNy4t9ULrvF0uTM8ZoJfeoyP/OFIqy7gOd2kybtMwcY71EZOiIS1NJliNtnedn0k
 yfjDUD80w4F75sCqGUJmOWGMa8hBPC1ROI9wEuu3qZqWuMtDm9JWX947wPyCVge4JvljyACwJsC
 Jysx6khxScEgOF/5NQExZJv4O+l1kPZuCIeGcQ9jLt9U7hRjUj+/+YU3f1vNEhEv86eEp/NLwOC
 dDGa7Mj6zTYDbv1v2X7nM/nbA6RbeEX1Eskm9qQYjxt0dCjydIJa01RGTt3aP50vPKkFMxhLNUm
 whemy0s1cDfRgjWKhGXjN3Gk3FyWVjG708DxA9eze6watdRmlseejdT9sRj53PXmct8hxdrsEFh
 YWKJ91/+sASiFkmQ/kjWVPua0IP19/ynxSytpbPC5yv2fxHOGLM57jVmZ6Sx1Cxydy7P61M9vGp
 EAzfhG8Xncmjq5FAuvg==
X-Proofpoint-GUID: LzR7-ayYOSEMru4FpxIeGO31ib-BIKIP
X-Authority-Analysis: v=2.4 cv=GIadgeNK c=1 sm=1 tr=0 ts=6aa9bae2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=RpNjiQI2AAAA:8
 a=pGLkceISAAAA:8 a=M3OJPJYpTDPP5X17kWQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LzR7-ayYOSEMru4FpxIeGO31ib-BIKIP

On 9/8/26 9:30 AM, Linfeng Sun wrote:
> vhost_scsi_set_endpoint() allocates command pools only for I/O virtqueues=
 that=20
> are already set up, but publishes the backend for every virtqueue. If use=
rspace=20
> finishes configuring a skipped queue later, a kick reaches vhost_scsi_get=
_cmd() with
>=20
>=20
> vhost_scsi_set_endpoint() allocates command pools only for I/O virtqueues
> that are already set up, but publishes the backend for every virtqueue. If
> userspace finishes configuring a skipped queue later, a kick reaches
> vhost_scsi_get_cmd() with scsi_tags uninitialized and triggers the
> !sb->alloc_hint warning in sbitmap_get().
>=20
> Leave skipped I/O virtqueues inactive at SET_ENDPOINT. When SET_VRING_ADDR
> later completes their setup, allocate the command pools and activate the
> queues. Roll back both if access initialization fails.
>=20
> Fixes: 25b98b64e284 ("vhost scsi: alloc cmds per vq instead of session")
> Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>
> ---
> I checked QEMU and found no evidence it's affected. I haven't checked
> VirtualBox because I am not familiar with it. However, the virtio spec
> doesn't require a specific operation order, so a new VMM could still
> trigger this issue.
>=20
> Crash log:
> [   34.698961] ------------[ cut here ]------------
> [   34.699385] WARNING: lib/sbitmap.c:286 at sbitmap_get+0x227/0x270, CPU=
#0: vhost-82/88
> [   34.700542] Modules linked in:
> [   34.701309] CPU: 0 UID: 0 PID: 88 Comm: vhost-82 Not tainted 7.3.0-rc2=
+ #14 PREEMPT(full)
> [   34.701958] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arc=
h_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   34.702717] RIP: 0010:sbitmap_get+0x227/0x270
> [   34.703247] Code: 41 8d 5d 01 89 df 44 89 fe e8 f5 3a 46 ff 31 c0 44 3=
9 fb 0f 43 d8 e8 38 46 46 ff 65 41 89 1c 24 e9 25 ff ff ff e8 29 46 46 ff <=
0f> 0b eb ba e8 20 46 46 ff 44 89 fe 31 ff 45 31 e4 e8 c3 3b 46 ff
> [   34.704234] RSP: 0018:ffffc90000ec3bb0 EFLAGS: 00000246
> [   34.704677] RAX: 0000000000000000 RBX: ffff88800500dee8 RCX: 000000000=
0000000
> [   34.705166] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88800=
500dee8
> [   34.705584] RBP: ffffc90000ec3be0 R08: 0000000000000000 R09: 000000000=
0000000
> [   34.705988] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000006
> [   34.706477] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88800=
50094d0
> [   34.706955] FS:  0000000014d05380(0000) GS:ffff888099c36000(0000) knlG=
S:0000000000000000
> [   34.707463] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   34.707854] CR2: 00007c0c3c20e000 CR3: 0000000008e47000 CR4: 000000000=
00006f0
> [   34.708592] Call Trace:
> [   34.709259]  <TASK>
> [   34.709822]  vhost_scsi_handle_vq+0x4a9/0x1b20
> [   34.710437]  ? update_cfs_rq_load_avg+0x2e/0x230
> [   34.710874]  vhost_scsi_handle_kick+0x2c/0x40
> [   34.711292]  vhost_run_work_list+0xa6/0xf0
> [   34.711673]  vhost_task_fn+0x76/0x1b0
> [   34.712003]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x30
> [   34.712506]  ? recalc_sigpending+0xe1/0x130
> [   34.712890]  ? __pfx_vhost_task_fn+0x10/0x10
> [   34.713325]  ret_from_fork+0x37a/0x630
> [   34.713673]  ? __pfx_vhost_task_fn+0x10/0x10
> [   34.714031]  ret_from_fork_asm+0x1a/0x30
> [   34.714535] RIP: 0033:0x0
> [   34.715201] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   34.715587] RSP: 002b:0000000000000000 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
> [   34.716158] RAX: 0000000000000000 RBX: 000000000048bb20 RCX: 000000000=
041ca3d
> [   34.716571] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000003
> [   34.716957] RBP: 00007ffcac47c4e0 R08: 00000000ffffffff R09: 000000000=
0000000
> [   34.717418] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000004
> [   34.717826] R13: 00007ffcac47c778 R14: 00000000004af868 R15: 000000000=
0000001
> [   34.718363]  </TASK>
> ---
>   drivers/vhost/scsi.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 42 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 4f8c0260bc9e..069a6ff4dd40 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2008,6 +2008,40 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_v=
irtqueue *vq, int max_cmds)
>   	return -ENOMEM;
>   }
>  =20
> +/* Callers must hold dev mutex. */
> +static int vhost_scsi_activate_vqs(struct vhost_scsi *vs)
> +{
> +	struct vhost_virtqueue *vq;
> +	int i, ret =3D 0;
> +
> +	if (!vs->vs_tpg)
> +		return 0;
> +
> +	for (i =3D VHOST_SCSI_VQ_IO; i < vs->dev.nvqs; i++) {
> +		vq =3D &vs->vqs[i].vq;
> +		mutex_lock(&vq->mutex);
> +		if (vhost_vq_get_backend(vq) || !vhost_vq_is_setup(vq))
> +			goto unlock;
> +
> +		ret =3D vhost_scsi_setup_vq_cmds(vq, vq->num);
> +		if (ret)
> +			goto unlock;
> +
> +		vhost_vq_set_backend(vq, vs->vs_tpg);
> +		ret =3D vhost_vq_init_access(vq);
> +		if (ret) {
> +			vhost_vq_set_backend(vq, NULL);
> +			vhost_scsi_destroy_vq_cmds(vq);
> +		}
> +unlock:
> +		mutex_unlock(&vq->mutex);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>   /*
>    * Called from vhost_scsi_ioctl() context to walk the list of available
>    * vhost_scsi_tpg with an active struct vhost_scsi_nexus
> @@ -2105,6 +2139,9 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
>  =20
>   		for (i =3D 0; i < vs->dev.nvqs; i++) {
>   			vq =3D &vs->vqs[i].vq;
> +			if (i >=3D VHOST_SCSI_VQ_IO && !vs->vqs[i].scsi_cmds)
> +				continue;
> +
>   			mutex_lock(&vq->mutex);>   			vhost_vq_set_backend(vq, vs_tpg);
>   			vhost_vq_init_access(vq);
> @@ -2466,10 +2503,13 @@ vhost_scsi_ioctl(struct file *f,
>   	default:
>   		mutex_lock(&vs->dev.mutex);
>   		r =3D vhost_dev_ioctl(&vs->dev, ioctl, argp);
> -		if (r =3D=3D -ENOIOCTLCMD)
> +		if (r =3D=3D -ENOIOCTLCMD) {
>   			r =3D vhost_vring_ioctl(&vs->dev, ioctl, argp);
> -		else
> +			if (!r && ioctl =3D=3D VHOST_SET_VRING_ADDR)
> +				r =3D vhost_scsi_activate_vqs(vs);
Is it ok to just not support the delayed setup? So just do the
fix in vhost_scsi_set_endpoint?

Is this a useful feature?

I don't think net supports it. When it does the vhost_net_set_backend
call it does vhost_vq_access_ok. If it's not ready to go then it
returns failure.

If we supported this, then I think vhost_scsi_activate_vqs should
active the specific virtqueue that VHOST_SET_VRING_ADDR is called
for.
