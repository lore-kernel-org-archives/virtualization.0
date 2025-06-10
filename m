Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EBD35897
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Jun 2025 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573071; cv=fail; b=K4AKMChC9n7dSRRaltzQMbwEyAwL1OQMGgwK4GsLwHhFiSXxkWZPrBKBK+yCjrlg1Kwi2dGAxJgMKY8moACmwewveIhfBsTzzlDfw9Asm31nNL6x6BP1okwu3XZ7mHIXQKUxBfNo8IJkC/Ls6keQWVyQ+djH39rWb4mDjRbx+9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573071; c=relaxed/simple;
	bh=P+ju5kKPZf8Tyi78BUQDIy6GUPRdEgxI5HXy8wUEsMI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFzULVAwv5s9ddNQ43nrGRfK8/M2BrhGiN3cEZ1J9UfcU6mDhu+PCHFlb2LZhPxLRY5J4Wc7zJB4nj6o/g5Q2U6k71vEBfIKF+RiYuADJuz4sbQyi2fgx1yp34o3ZhWn7AL176VIfggwUbXIlcQL0hVS9I8WeEQSfB4iu4Uxzy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m689oizN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i/+6h6zP; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m689oizN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i/+6h6zP"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEA116083A
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Jun 2025 16:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3H-XT8Uizkj for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jun 2025 16:31:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 978366074D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 978366074D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=m689oizN;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=i/+6h6zP
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 978366074D
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Jun 2025 16:31:05 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGMacL008628;
	Tue, 10 Jun 2025 16:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9e3+1/2xFX4wcmNZA8000XZbvvS9rMjSKT4KKPNOQiU=; b=
	m689oizNt2u5PChQcwquJ8uNkxnXVuaBPU0wxqXsI5VgFzPxjD54EylA5WRtClE3
	cHlGU91Ka6YEzsUH1NrjYuAtbSCCjTvV4j7LGC/OX+M08QA1zeGreY5H0cI9cQ7X
	Hqt51NugnfxIKB4B9VDu6S2+FyxvQpvCVZkE86gLbIMf5MQTrCsDcmKBvddWrtYx
	YkUEXwazIlejKCamvv91R+lsscAyWGgT2p/JvM4tU1guc5AFgPpAG2odg7WvBGDR
	oG5J58Sk8NUM6gmVZ+dbyU1f+dA5AuKd6iCVkyHypHxaUMeInP78iNgwHMpyZBGI
	edYw+h7KPSACuRV9J9Fy9A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbecmd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 16:31:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AFUJed020677;
	Tue, 10 Jun 2025 16:31:03 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9p2e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 16:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLXERnaSIrbuH2C6+kVx6eSyGPlWDWP2hi0B+3S77wfo7IJ3X04+7Z9n0SkWLGiTznpyCQSsePZ9+KyYRGonXbBO4OUrcLl8bEmxBUVRrXrnemKiBkqy1Le5I7LLUxvUt1Ox9Q9fgug8IyTLdk7oBddhvq0LlWQ01LGyNyE00+Y8EiFyzjNf04a+3Vl00FCRPIj0kd3/9FqsHOunfzgE+CZ7XpmQdm1jg/zbS3+voS/RuL1X70PIKzF0VdVMSPQYkVNCGAvB3/17isJfkPnsLs2rtBv5JZ3yoNYRrD5QnI7IY58ofmlFG8T8kl3sUVsQLEPAiWwakcTTmiAqA2OtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9e3+1/2xFX4wcmNZA8000XZbvvS9rMjSKT4KKPNOQiU=;
 b=DhbBwdNJq3mxK4ZafjgX4JbVOh5tA7gQUYOHV4T/Shxhir9R/3Iw8hwgI+MSwRsiHzTsT7+vcizIdkBscAtJEaYU5850NfJQCur23hD1cnozEfRdxDW+qS7mn8PNNh7/ExyhnnJ67YKxpfxDC1CeKVn+/Y44moQ0rqhoFVlUE818q6W9AajzgVsHN/q4XoFC4citIYZbcyTeab9E/9E4enHSsvnnO439+DISVxt/ZcCI86OKzFVA+gneW16ERbBHtEn9DyCyG9BqOdBVwjqTY6blnCG8WfATQzxRg54JrPpxeGB7b+i6aTOgfQxbvC2Jj/rJ6C3WiYaA283dkv10Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e3+1/2xFX4wcmNZA8000XZbvvS9rMjSKT4KKPNOQiU=;
 b=i/+6h6zP8POIiiRo3tIzjGohj4qjqJVM1QxVbfPPQM5nzy9v5zEmHeGGCWvMU57jHPdXyr3pItk/e4EeVYERI50Du5ZEyohJNbBOtJaFIH/Fv+HJCicW0GjlsjFlxlw/Vl0XS2YxIi76nNOoFm+hO4X2HBXSgDyhHVK5wIJr294=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SN4PR10MB5589.namprd10.prod.outlook.com (2603:10b6:806:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 10 Jun
 2025 16:31:00 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%4]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 16:31:00 +0000
Message-ID: <051e7185-5fd9-418b-92ca-807418e88ae9@oracle.com>
Date: Tue, 10 Jun 2025 11:30:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-scsi: Fix log flooding with target does not exist
 errors
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        virtualization@lists.linux-foundation.org
References: <20250607171815.111030-1-michael.christie@oracle.com>
 <7hsh4exxtfbeu2h4zvt2bptunezs5ppaeqep6gkn7xkmpu4y7k@rb5wfwqaembu>
Content-Language: en-US
From: michael.christie@oracle.com
In-Reply-To: <7hsh4exxtfbeu2h4zvt2bptunezs5ppaeqep6gkn7xkmpu4y7k@rb5wfwqaembu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:5:40::46) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SN4PR10MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ee17d1-3352-4ae9-f1e4-08dda83c2f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1ZQajM0bkpWUm02R0dIQXBndTBaa2FzejlLQm5weDk3ZHRiRVZYaXhQcWxk?=
 =?utf-8?B?TStZQXIySUF0Yjl2bFNLaW5FN2hOeVhwR3VsendadXlKaWdQKzlVZ0xDc24v?=
 =?utf-8?B?ZzI3SnY4RmtXblB5alpYT2hyK1haM1IvZTFsb25mc1VDdjZnSUF4M0x5SDRS?=
 =?utf-8?B?RnU4cGltSExaRW1OVlB4eXo0WmVMM1RqdGRtQXl0N09QNkFkK1JKT1FiY29H?=
 =?utf-8?B?Zkswb0lZd1B6cGJ5Z0xnL1Z5TUZURmQ1QlBrOUVQYm5OdnVaRFlWVEgzZHlH?=
 =?utf-8?B?WDlOOHdRUFptWGRmeEZ4MkVBSDBkeUlzb2VMQ3dsc1gvc1paSFl0UVl3L1Zh?=
 =?utf-8?B?YkJOMVdkVlduajJkdWNoRFF5Uyt5V3gwRFVla0MwL0tSWUZuZVlLd0VRNm5J?=
 =?utf-8?B?bElvbGFFWThhdG15YTUxSG1NN2NBTFBVYkVrNUR3QWdVUFVTMmFzQlpBQk5T?=
 =?utf-8?B?eEtEYmJBM3M2c1JPZTlieUlpTzRYK1JURmMva2VhMDZjeGVxVWdQaFlCMDR2?=
 =?utf-8?B?SGZlTmhKR1YvTzRPcEU4MWhWL0d1WGV1aFI5bytqOEo0dTFqM1l2S0lBV0tJ?=
 =?utf-8?B?M0pVci82Z3hMVnc5bWFPQVhkaVJ2Tlg4VmZvejcrbWI4djJVR2lNQ3dLQ0dV?=
 =?utf-8?B?ZWpBcEhnbEJxMnFINHM2SkFVYzRGU1dYMkt4N3Zuc3pHMmh6eVJYc3dvS29H?=
 =?utf-8?B?eEJkaWk2Q0U1akdLdHF6dE1qZEZnYzhlZHRhTDZYZmgxOGE4YzJGTm5mY2Rx?=
 =?utf-8?B?ZkcrcUE4NzQvN2FnWGN5UHF0anEyaWlIa1Q5TEV4RDQ1RzV4N1ZiVjVGT2xJ?=
 =?utf-8?B?V0oyY00rQjZBaXdMNktpKzR5QWVXMkJuVWg0aXcwYlhWRHdMdjROT1pING9s?=
 =?utf-8?B?cStUZEtTQjVod3pHdVNHRjloMWpVSXFaTVE1KzB6ck1sNkg5T1RpSEFmRkZV?=
 =?utf-8?B?eStYRktDMkRVRjRQN3dJNU1sRVpPUk51ZUQzalJiZE9JbVdhVG4rVXJ4SVAr?=
 =?utf-8?B?Yjl5WkNQenc3T3pPZlllaUFseW1qWjFwNFIwdUI0Z2pES0Rwc3dLQkliaG90?=
 =?utf-8?B?bkNHcUdyMmNkcklVVGhiQWhPOXI1QUhDRWJOMlVLM0FOSVRQcEgyVUR5SVpa?=
 =?utf-8?B?cjkvelVjaUZISC9Pb2hSYWRTazNnMzNCUjBQVTdWN3BleGlOaGFuNUdBdHRF?=
 =?utf-8?B?SGNQU1VPOUJzQkZKSmlCYS9xOWJlUGRFR29CSTlSdTBJRHMrY3hJdFE4dGtF?=
 =?utf-8?B?N1FIdDhleTFzamtSN080S3NacjcxY1hINE81QVM4NHJoeWpLV2ZDOFRFYmY5?=
 =?utf-8?B?TmlsNGZudUVnTnJrNVRwYWUzMU9RRUlRaFkwSzArTy82ZExGLy9ONm5TUmxO?=
 =?utf-8?B?c05DTW1XbmF3L3kzWmxTbEd3QUZhQklPVW9WYS8yMHBNMTJ1UmZEa2J0YjJr?=
 =?utf-8?B?dnpyUnVKK2lSZEhhQXpZbS9oclhXdXFwazY1YmhmbUhOZ3ZTcElnMTRDVU4y?=
 =?utf-8?B?SEJHRWFwWGtYSnFxSnZ6R3djbk9ZNmxWbmpUSkFJN2E3NHE2WnBhYVQ3REdR?=
 =?utf-8?B?ZVBrSkhBaGFDbmtuUXJQMDZEenBUNDREeTZNV0ZWOXl4MGphd1kvVTBheVpr?=
 =?utf-8?B?REg1OWZNUjJhYm1xZmdiQjBOYlFpd1FhOFd1aVZvN0JUTWVXUFRnL0Z4MHRI?=
 =?utf-8?B?L0JqcWpkdkxtbDQxaXZyUFJuWGpsZUdvc1RoRnhUZWNmaENicDhONytjQ2tl?=
 =?utf-8?B?SmEwR2M3Q0FUbkJLeCtnTkVwL0NUY29aRGRtVkFlMCtUa0ZuajNXT2QyOUd5?=
 =?utf-8?B?cEZvdGVLNE1WZlVtbHdram9ZcXczVmVVbUVZTFhBWGVib3lma1EyOFVCSDVv?=
 =?utf-8?B?SWtGQ2ZMWjdMaml1N3ZLQjlYMENaUE5DNmFqRWYvbCtTWjR5dExnSWNCZGVI?=
 =?utf-8?Q?WyTL+29/wDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UklOcjI0STBxeU14aVg4Z2NPOFgwWEgvbjJGWk5CTW9BclQ3NFFSczFobTlk?=
 =?utf-8?B?d3NScWNoU0NMZ3daalo2clFydnVQdnFLVERETzA2QTI5Ty9WOHlwQmpMb2RG?=
 =?utf-8?B?VTcxSElTSXV1NWl1WDd0VDZxU1crZUZ4VmNvMnNRS0RnYjFGK0xMWjBnMkRU?=
 =?utf-8?B?K1YvN2ZCejJ2ZGp3WjVPS1RQNkxEUUFibU1lTjJidWZEU1hzTGZvcHA1eUk3?=
 =?utf-8?B?WTVwd1IyMng0WldFUE9jMUt3bUdtanVrSEcrUzlpV2YxVEhqc3JmNXF4d1Fy?=
 =?utf-8?B?cUI2d0NueFhqemdZNWRkRExzWWUzV3VPUVd1WTBYSWFyekE3Q0dzM3BoS3c1?=
 =?utf-8?B?bzhCLzE4eUdaYWtEUVR0WnVVRlNLVnZJZTIwV2Q4RjdYNE9hYU9tb296ZFR6?=
 =?utf-8?B?WCtDTlJ2TkQrSFNCWitPWDFQRTd5ZG1VWTBRZHArdWRpekM1NEh4RngrN2ZW?=
 =?utf-8?B?aHFKWmFYWmliZ3A2Wjg0dndNSS9IYXZVQk5BK05JbnBsTTJ6UDNURS9FVWNm?=
 =?utf-8?B?RW0xV1Y4bThmZERhbStGOGl0QmFIQW81cFZ0SlhzRTlEWDNzM0paT1BTZUpV?=
 =?utf-8?B?UGRCdkRxckwzd1ZHMzRhdTFralJYUnJBY2JYeXU5dkdoY0l6UXBtUnJkTk9s?=
 =?utf-8?B?L0JvaS9oa0pCS0h2dmpKVGpmWHUza1ZtLzRZdE1PTUx1MTM0NGdXTWRsTG5u?=
 =?utf-8?B?WU51WEtSZnN1V0dKUG5DOTJPTVhTbldzalRLOFNLSElDNzhSZTlScVpEeU1K?=
 =?utf-8?B?MFBJRTJYOXp5Vi90S3FNVjV4ZDdqbjFwb1h1YWo4dXMrTzR4eDNwNDV0U2JC?=
 =?utf-8?B?ZzBQMlhZbWhEMnpZa0M2UDU4d2NxaVhOQ014WEtZdzBKaDNnWUZrSmRZUXZa?=
 =?utf-8?B?UjdIclNLSHZUUTF4K1Z2Mm9QeGpzaGdMSXhCYWJPd1hPMGRzYnViQmlyMEIv?=
 =?utf-8?B?UTRZNTFEQjIyM0dzLzZoU1poR2Z4ak83Snh0M2cxekZJNmJYSEVaTUx2VG1a?=
 =?utf-8?B?S1NiT1BYWE41bkFVSHVnSE5TQmVnWWd1dThxcjQzZVh4aTY0ZFJLZjRTbXdJ?=
 =?utf-8?B?TnBxd0VvbUZYV2RTdFlzQU03QkFYZHJkNElOU0gweGU5d2hjbHlvcURma3N2?=
 =?utf-8?B?aXdzZk95aG04YU0vOTdCNW1YcUpvV0xkRVRwcGNNcXFnRGRRQTFJc2pRcEhE?=
 =?utf-8?B?K2pkaml6L2FrcjJYSGNIVEF4OW1QZUhwdENKMkMrTEZ5a0FrTDJmS0dMcE9k?=
 =?utf-8?B?ZXVKY0ZZRHFwTDQzbjF3dDA2Z3d1NGZQak5aWS9UdE5Dd0Y5Z2IwYXdHSnJh?=
 =?utf-8?B?UVpuMTY4TnN2a2xjcTFJaW5yUzl1STFQUkh2QnYyWnR2czVoeXZHYXZzQ05E?=
 =?utf-8?B?NFBlZ0tSRzFhUzVjNmdYajltL2ljcDNsNkEwa2lYS0w1a2laZEl2Q2tXOVlX?=
 =?utf-8?B?WUd5SmUySk5yOTdaNWp2L0NiZXhHT1BrNjVraGxQV1M4d2F5b0NhUS9CY3Nl?=
 =?utf-8?B?V1NNNXhrRGl2Ky9MaTVndlNDMVhGVkZJQVc1Q2x1RS95RHFoRmpUZnhNZ3Ry?=
 =?utf-8?B?VmRaaGlEekRSTzB6Qis1a0Z6cEpRZGZVa1FHL29HSEVzN1JtckFMKzlsQXdo?=
 =?utf-8?B?STdzelVkdnJoV0FyQjhoZ2FRamp0cWJiOUd5djlNSmd5TmE1SHhrZmtjQjVk?=
 =?utf-8?B?cGl0YmoxcW1RdDg5RmpYZHFzY29FSzZVSTREKzRQenc0UWFDUmZwQTVrTy9v?=
 =?utf-8?B?dzVJaTdJUTdlVXM2bURzODZicEQ5a0hEMlFtSjBTZHQ2b0F4MGtSZVZ4N1kz?=
 =?utf-8?B?TVltRmo2M080MVkwNUJqcHZqKzlSYjVmSmJqbC9sWXc5NG54STlLOWVZWWR4?=
 =?utf-8?B?MzNyTG1oclM0bXowU3lLeWZpdnpVT3FjZjQvcmV3RDRYcEVNbVNzaytyVmFS?=
 =?utf-8?B?ZUpXbklubDNXcVhCa3NXdUpuS3Z2eVpGMUpVMkVvUFdzWUFFdkZGQ0lHRW5O?=
 =?utf-8?B?eldmSDkxdTlwZ0RCT2pWUm16S29FUytySEREcVNEcS94Lytoa3VrNkh3UE9Z?=
 =?utf-8?B?cHdWSGYxQTlkMlNQTWRIczBpYTlKN1M3aXZId0traE1ab2NERTdPWER4aS9v?=
 =?utf-8?B?RVJiMEtMMzRmYW5LbnIxNUdJNUwrUWFvK01jVmROeURWZit6cG1mVE5Yb0NY?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sw2cjWDII5i8HdoXZBYkZ5VvhN+irHAV06rOjQW2m27AaxeeaqsIlaiJ+Oxy/th5LODAnlM3hp9BC0Fh9HW1NGU/ZQRu3TtKBC6SjhQ6Srj8FTWFLEvABhEVqJza+/Va1fV2uAVDILjt6zDft9k1cr40LnAAqLaF+OBYSXGQuEAnh2hAqUIUZVZ/ee+DFrYAWv0fvXdkGAogzNQcw1ryN9/hrVvMD0CHOizsxnmThscozy+dIYoN5UMm/yPOHcgRS6utaaFsJj2VzVSfo4NWmNe6+xmnXIECy4mJ79pjSEI8q9VT84JC4YJ07sa6oD4T9L+dGerO+IkzTYypmqzBXK2eg+KUYSPw7F38rxIjq1HV7XLPEDCFPgZfls4YNH25EOJytzo36XZyU2a+XzlGfrto0fWPZvIVQmbbX4dvTTMqQLC5PNzFFfXE1khJKjqYzUPQZ1xUnx/sYytqmO0dn/3KnTzP0o/9AVknH3aCJkxjeNpgrquRo9Jgig68UArRg+WqoqzAQjzIiNsdOZtF+3KdAHhlX77jr53kPnAblKOv0MwZB1e4uz/tW2n0eY85afZkusWh06T652b0EmskKZWbDJOSfn7GwsHF0gVWEds=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ee17d1-3352-4ae9-f1e4-08dda83c2f58
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:31:00.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wytk70VdpX3a0chUgwK4zjwitqyonsgQ76RPKAZ7osHBmWVZw9PD7omGxfQQyXwWSyFfjUdu7N9kKGyB96uke/JmsPzK56aCs87/aPJ+ZUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=979 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100133
X-Proofpoint-GUID: GZg6xE5_7uz9dfCT7NxiQ4s7WGAJOZf_
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=68485dc9 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=8Ht5mTzImztgYP5ylZkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: GZg6xE5_7uz9dfCT7NxiQ4s7WGAJOZf_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEzMyBTYWx0ZWRfX5HqLD9C4cB2X 9IJecwXLtjXO7aTvtW1JWyq9uqjhlDf/U72C7L/890Qpxqc79BGawmI/mHgf391MY6tvxwqvWFU +80r7Dsic/j/U8rapXpVQLYbHwjefvIpW60Rq6EjCVR0gqpBoSU5fP5DDOpAlCWAxyTxy6mGB32
 dM120vyfKgFE41M+hFzHftHBZafijhRUTncFKZ62nfshJKO+8xscG2n3dAFbzteV0/lmCz8Ypx5 aw9Fd0E+SfWKLYaMkupXN3ICkAfTsXkD9wYSp82akK47jyoBfnGt1BPflEPPa/tCfWwpsRSH0Nt QjiPwTZIn3lszgNVc3bJ8Xz7VmICpH8Kkwb8JCQz2auMPPsqPFbrkSnXcFhEFAGrs8F5hcJSg/v
 +AZqH5Rgem2GVIol4PVdyNTFqe+3cL/2B/KCMSguLaDM6X0RpX4or9yAyaFO9VWiKviVK4bS

On 6/10/25 9:18 AM, Stefano Garzarella wrote:
> On Sat, Jun 07, 2025 at 12:18:15PM -0500, Mike Christie wrote:
>> As part of the normal initiator side scanning the guest's scsi layer
>> will loop over all possible targets and send an inquiry. Since the
>> max number of targets for virtio-scsi is 256, this results in 255
>> error messages about targets not existing. When there's more than 1
>> vhost-scsi device, then you get N * 255 log messages.
>>
>> It looks like the log message was added by accident in:
>>
>> commit 09d7583294aa ("vhost/scsi: Use common handling code in request
>> queue handler")
> 
> IIUC that commit just moved the code, but it looks like it was added by
> commit 3f8ca2e115e5 ("vhost/scsi: Extract common handling code from
> control queue handler")

I saw that and was not 100% sure what patch to blame.

Your commit adds the new vhost_scsi_get_req function which adds the
vq_err call. It also hooks the control queue handler into it (control ==
SCSI task management like LUN_RESET). With just this patch we don't see
a problem yet because the normal SCSI command handler is not using it yet.

My commit hooks the normal SCSI command handler into the new
vhost_scsi_get_req function. The SCSI command handler calling the new
function is what hits the problem because it's the SCSI INQUIRY command
going through this path during scanning that hits the problem.
