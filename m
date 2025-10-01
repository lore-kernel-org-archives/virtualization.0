Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A468A41
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Oct 2025 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759368944; cv=fail; b=BQY01lHURkg7pYbEndMSLXegbQctw48oy7T0Yh9tdnLjKXLe4rvf5boUAadwnx4dl9v0p0QvQH3DiymjGtuF+jVWACCCvh/d3/kmTiRSL7s8FmcRMQzz8yxsRUNi85ERzyHzHlNN8H5K0gM2c3Lm4jv335yWm/IVnUKsIETn1Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759368944; c=relaxed/simple;
	bh=pm4Feqwooo8G1nSsCFc8IcMFBI4AZiRnSEO0nShZtvo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TugDihHqJ7rkcOnEwy4aKV48zv8zZJsQwrJgi9w8fgao1y7yuBl2LNXWHM5faq5LPrh8rppHNde6DMPMyemXXfe1ZXzUiDD6om38MNtAQqsJ3AcwK3Zhqtzypto7rtU9b9JY+sxqIxCCngHYugv8V3hKvHBg/ifGqN5vQ2kd0vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jgJvcqTu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w8y8Jzzq; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jgJvcqTu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w8y8Jzzq"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10C5641675
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Oct 2025 01:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kOlIuzog2bjO for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Oct 2025 01:35:40 +0000 (UTC)
X-Greylist: delayed 7726 seconds by postgrey-1.37 at util1.osuosl.org; Thu, 02 Oct 2025 01:35:37 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F3D494163E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3D494163E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=jgJvcqTu;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=w8y8Jzzq
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=si-wei.liu@oracle.com; receiver=<UNKNOWN> 
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F3D494163E
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Oct 2025 01:35:37 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591LgPa0007339;
	Wed, 1 Oct 2025 23:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4tqV5DOIs1tKyomb2UtI8spgrNoV+1Ve+r4XbHtRYGM=; b=
	jgJvcqTuugoACx3PPtVB+ColhbQ3mzYwlHteMSb1X6am/XTTCe8wdxYcsmKNbdKI
	fDq0MWFCw/DImkaoRWqCCJmp8hueHZiiROCoP0RN7cv//Lcy17N++8zJkQfq/yBl
	fUAGRpQIlZlwL2UVAognKq7ggFAr/kU/CaxazfK1G0qsS9mTcL/+LR5JA//xPoKM
	hHeF5ZgmuTwdjlM5PeSyT1I7+xY5WkraG/OQQmXycds4R9BbXXEUEaewV26NEwIf
	IfBoQ3Ev+8qOabK+iQWuelnd2rm1rcpeC34PRcTvq44RNqOsgDorX36R1w+6DhgK
	Jf+8ADU4Lif2PF0nFIUESQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmabjfks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 23:26:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 591LJsPZ036099;
	Wed, 1 Oct 2025 23:26:48 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6ca1q39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 23:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7hB9Xw2p3SxwIq7l5LgIEqGvpeF0zzI7im3y77+pNXQu5IHaUXnMm70OeXUxJxzlpR76mKwaaH/bzsDE2CBKEcvnnlUnde/Bv3VKDxMAVSlbUBIZLcw5JelLUamRx5K3DZWZkji88KrNyPC52QuFU2CSbmXQrYR21ulX7BP4Fjx//190yslIE6rvkWp+v9f69LHlyPEN+96G+5eGriDi1NY9NgujwIrTGfl2aUo9NzBUGpHz6zv42EaoWHpgGQf5ppo9wXodYzqiSjt5vpO57sLkrjSUxd/j7hYaD3XHjw3GThceag7IDWdQGrJHJHQdcV1ld2ZuLqp38AOYXhjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tqV5DOIs1tKyomb2UtI8spgrNoV+1Ve+r4XbHtRYGM=;
 b=n8KrXLZ9RZnOj6qxQV6EcoKnxQ835Z3TaobT/INX9Si7fQ2sLNIKzyNQ0LHz3UiZM0CE1I6hXSrhrukN+VSfdEOIvUAuu5NYXekros7wNgIOgkxf8LHcI+rbLlRYaF/apUAvZVpnklGVNp+mVkpISS+/1CmoDjDfdZ5R1HHfATslg1tlr+NuFwnhBn9GejIHQVx12fi2LNhrpquc0n13C6bKmMhJy5my8LFQcjA4vCAfkyFJY76PpH2ajf3CLHHLzEY5p8gRxVqMq3wM4FfO9Rj4fr8dIdZeU0IPOY+4HTqpL8Jdlxh5wLM9tdrSsKFq4lY5Oh6qyEL5KL/eKsQMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tqV5DOIs1tKyomb2UtI8spgrNoV+1Ve+r4XbHtRYGM=;
 b=w8y8Jzzq3H6ZyacBEpM1bvS+SmOxZv1dhz38H3nuH1eexQde0a/EyFtZr8UWXkpq6DEGGrnlTHRs4FC/PQayph7dh1Oa+mUaNs33WRVYU9+NNmCOTEuvyvRWqJtQPh3gnsgmRhv4wKLdSCvoI8dLLIKm7slIsGMBNies+pW+pmE=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by DS7PR10MB7190.namprd10.prod.outlook.com
 (2603:10b6:8:db::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 23:26:42 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::2eba:a565:3a1:571d]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::2eba:a565:3a1:571d%6]) with mapi id 15.20.9094.021; Wed, 1 Oct 2025
 23:26:42 +0000
Message-ID: <f5897b60-8e4f-4a3c-a88d-f85be0bc7705@oracle.com>
Date: Wed, 1 Oct 2025 16:26:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESENT v4 4/6] vdpa: validate device feature provisioning
 against supported class
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Dragos Tatulea DE <dtatulea@nvidia.com>,
        Maxime Coquelin <mcoqueli@redhat.com>
References: <1675725124-7375-1-git-send-email-si-wei.liu@oracle.com>
 <1675725124-7375-5-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWdEZbURGZtmobrED_jBq34DnQEuC8kUoPMH5=p2K7NE0w@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWdEZbURGZtmobrED_jBq34DnQEuC8kUoPMH5=p2K7NE0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF00013300.namprd07.prod.outlook.com
 (2603:10b6:518:1::e) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|DS7PR10MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fdb685-f3c1-49f3-cf07-08de0141fa7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|42112799006|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWZUWGM2YnU1T0ZkMThLNm5yMDhzbzJxTzNyK0loL0RqQ3FtYmdUQmZuYWlR?=
 =?utf-8?B?NFJXdVNoVVZFTEdMWjEybmhydCtGbHltUUxmS0p1MnJmSjMrMkNCSSt1S0Za?=
 =?utf-8?B?NkdUTm1jSFlwSDBlL3AwaTZ5d3FycDVWQzlYNXo0NzRBZDZUMytMb0ZQRTUr?=
 =?utf-8?B?Mkh2QzhhUkcyc1JKdDdzTHphckFjdlhIbUhFdGozK3hrcFUwTXFyWmJqM0xy?=
 =?utf-8?B?SGZZTklCVGF4bVFTc1UyTEJDMU9nRlZ3SnJHdXNXVmZDQWVmczZ2eWttY0Iy?=
 =?utf-8?B?Q2xWaFo3enE2NFdoczJ6R3U2bXJuTlBhNlZROGNiN1crYjBLdmVYVVVtUHVj?=
 =?utf-8?B?cHN1L1VCUXNyNDlqR1FVS3VITlVRMVVyVkdPTUd0bWdqRVdGZzdodmxwTVlC?=
 =?utf-8?B?OXpLWDU3OXplU1RERGloUjlOdjkzMVBJVTRKTWQwd0FuazNocWdVSE1mQVU5?=
 =?utf-8?B?QW1GQWcxSkJJR0lJS3l3QXZnU2hWRTd5b25KYmRlZm50MllFWVoyWHdNbG1K?=
 =?utf-8?B?eFNUNjNaYzBuNjhoelJxL1RpV3FsTkdhRkRWWjhuaWJFalA4RkZ1bkRNTHF4?=
 =?utf-8?B?WVpGT0pYZ3kzb0ZtbUtIV01MbmY0TEhyNFNyV0lsdk40d0FMU1BWaklwdWg2?=
 =?utf-8?B?ajBrYU41OWhPZ3gwNXM5OEpVR29KTGFZZ2pQRDdrR1NzdWFzOFdYMjNBQndF?=
 =?utf-8?B?eTIwbml0Y0tjRmlGQXFLR29IdmtjMUI0TlNHYXlISTNhU1JtQ3dad2JjMmRY?=
 =?utf-8?B?d2FnN0ljSERCdnQwSlBxRGNUdlp3Zzh2b3d2MjNibzluNUwwbnBhbUhzdUVw?=
 =?utf-8?B?ejlRZTdzb2xLdnF1SG5SWmNxMTVTWDl0aGorbnFwYXBzOXQvdXpSR0lMekdZ?=
 =?utf-8?B?TzR5ZzF6YzA2SUpZV3gxM0tueVJYVW9oYTRNdzZWTVBNSXBtbUtZT2t6dHBp?=
 =?utf-8?B?QnF1bjdKVVlWL0Z4NnVJR1h4cE5XWGswUHBWa0NnUnk4czZVMzdBZWcwV0dv?=
 =?utf-8?B?VXlpUXdVekt0V2NTZVRVVElsVGRkS0VwcEppYm9ucUd5ZGdjWE9Pa0pnT3lo?=
 =?utf-8?B?VDlPbEdvcFBHakF5blB1cEJPblk1WkpuTTVuUDJiL2lQRmlrcjhYMlBxWlNK?=
 =?utf-8?B?ZzdINC9xZ3QzZkY3NlFYU0JqR3NVKytDaDMxMVdJV2tjS3BVUElFckh5SVZj?=
 =?utf-8?B?eXRlM0oyU2Fid2FsQXVOV09VV0NTbGtkTlUvUDdYYmJaSVlBa3FJR3VhaVVm?=
 =?utf-8?B?OENEeGduMmZhWVFZaE8wMUE2Q1huUVcyWjdwVTVIMEx6VTJKbEdrQ285UFBr?=
 =?utf-8?B?cjFlc3FBUnVwbWUwRm8rM1JSV28wQWRsQXJGY1JDU2ppamRlRW9PSEZjTTQ0?=
 =?utf-8?B?a0JSWFJFUGloalJCbVV2a1p3UEw1VFYveDB4WmxnbjVtRWZIU0ZqaVh5WW1a?=
 =?utf-8?B?WHJCbU1rMTk2SHExTklpZ1BHVkE2WDJPREFabDlZQmdma1N3alJua2VhOStZ?=
 =?utf-8?B?VXJhQnNOaXFSdjFaUEVtS1NKSmxSUWk1TUpoT2ZzM3lpcTJjMk5ZTXJPU1hD?=
 =?utf-8?B?NHgwZmkzUTZmM2tCNFA0N21BWmpFelFVbStlUWpCN0JVRTZidjdwMUZHbVpE?=
 =?utf-8?B?am9XaGFDTVJrSm85L2RKckJ5VFZyODN2ZFB6VldSZVozV2lUN0FKbUI3cTk0?=
 =?utf-8?B?R2RVaVVyaHc1dGI5ZEgrSzFlQlQybW5PSE5xcDZCTTJVWXZ1U2ljeUNvbjRM?=
 =?utf-8?B?a2pRNUVpTnhaM0tuSEJPTWtjU0N0dFJkSUxpell4d1pFMFFkUys4S205dFRE?=
 =?utf-8?B?RWFNcFh6NXpXaCs3WXJwd2dTbm1YdlNHcWF3dVErMmpheUh4U1NUSTFQYVEy?=
 =?utf-8?B?ekR2a2xuUWorSk12M2ZFUUl5a0tTbXZyZzRQTEZnRkl3bXNxU2d2ZndEc1Z6?=
 =?utf-8?Q?FLVLSYMj4V33JvkRR4GjNtAf5WJ+VXrL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF18D5A7206.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1UyQVRaekpOZ0J4NytIcXNicTA4Y3h4UGxFSWVwWUtIaVlSTzRhOTEzZkJj?=
 =?utf-8?B?ZW8vMUpxL3N0VVRjUy9nalJOQXRHNHpFYkNwMjZtRUExTVBIWlVUREpucVVX?=
 =?utf-8?B?TW1SRXE2alZlZFNkNmZjUWpwSllnaGl1K0gyeVNBb3ZZRWM1WDI1K21qeDVG?=
 =?utf-8?B?Y2x1bjNPblFWSTROMm5EbVRtc1RuNXBaUnF2VS9NU3MwTFg1eUR2SUVHa1Ey?=
 =?utf-8?B?OVc3V2o3VWR2WlZmbzQ4ZC9YQStpeGQ2a2xpQW03YXh6YmRrZ2t1N1pEd2Zo?=
 =?utf-8?B?ZXB0MHVrTWRCYVFJMTFnZjlDR2p1ZXo2UUJmQmVUelJ0Sjc1NjhRNENvZVRQ?=
 =?utf-8?B?MCswS2JCNFZBT1pNUXUwcitSKzNmbnVBajUrSkdKQnc0TEpCRFYwVUEzTGdJ?=
 =?utf-8?B?RmEzU1RzK3UxM3RBcnRTU09UOUhJL0tCaG83WUtlTmYzSWxZYlc0MzE1MytE?=
 =?utf-8?B?NVFxVndESkU4bm1QQ1dHbzFpNHZRSW8rZlpNekhxTE1rcDFoeXNjVnRMeU1J?=
 =?utf-8?B?a1FIRW53T2xhcHlraGhxbFhZUjQ5NmdhQkNTMzd5aG03VHJUZE1lUCtkQkhF?=
 =?utf-8?B?OFdlWHRYSHlBNVNERXNhV1VEbGpxNDBtd2pvVHNmd2pQcmJGMWF4UGsrSm5S?=
 =?utf-8?B?WDU4RDZmd0d1NWsvOE9yWTZaT0FHeWdMc3E2SDRHcC9peUNsZjdOa3RKTGZD?=
 =?utf-8?B?VDJRMzZKMlgyOTk3VjV0NDROa1h1dzdiVklheDZqWHYrY2c2NitMNjlwN0xG?=
 =?utf-8?B?OEx5bzB2bVJjUXdtVGNtRGNxWXh4WlNUZ2RWR1dQSnR5Nmg0NlpHb2J0MUNZ?=
 =?utf-8?B?cmNjNTBwMDVuQndOdlRPKzhTdHFSenZ6UXlKaGx3eG1aVTZZdFNHRVBRL0ZQ?=
 =?utf-8?B?eUsyZXdtNmkzYUc2TktUNURIR2VuU3VqcnN6VzNqd1BQRDhCOXhEZ25QWEl3?=
 =?utf-8?B?ZXJLTXpxZ083MnpqTjZtQ2tKSncwQzE4UGs1Zy9VODk4cDRzK2JRQXJDc1F2?=
 =?utf-8?B?NjlFaloyZk96TUlEYTJyaTVyVG11cGVKdUxmMHN5cU4xWWxYejQweXI0YU9D?=
 =?utf-8?B?QWVtcUNjbkJRZTdtTkJVaGc5RFk1a1laRmc0WHhRK1UxK0VRTE1HSEdacUFu?=
 =?utf-8?B?OEVxaTFvSCs1STA1N2IvNE91YkJ1M0g0dmxLTk1yQ2VJZ2RWL3hkcitBUkwz?=
 =?utf-8?B?Q2dnbFh2MWlESGRISFNPelJQdVh4L2JLVXlVNFBUaVE5b3puZWt3c094ei9B?=
 =?utf-8?B?L3lMbW5xd3kvUjNqR2U1L2pZNnBqTUZQUStWUTJUMllNaTlCQjRlZ2pCTHFK?=
 =?utf-8?B?cjB4SE5DM1ZjTWhMdVIwci9oSmdWc0FrRTdTeWdKc05HTjg4aUExRktNMUY0?=
 =?utf-8?B?Y2ZUVWdESnZZSWtwYldTUFNNTHFRdk1pblhUeEllVXNHWWIxVndtVEhxTk0x?=
 =?utf-8?B?VlRsZmFxR0VtckkvdkJ3Zno0Tnp0a2U1QVVlMndSdjVlSmV1T3o1c1ppSDQv?=
 =?utf-8?B?VXhiK0dLUnoyOVVoVVVzSHNDMmhpaWszMll2MVB5alZRSWtCMjhCL2g5ZEgv?=
 =?utf-8?B?aldLdURqcDZ4d3RwVHdsRHBabVlVREszcktJZlF4OXdjYlRnc1JvSVlVUkV2?=
 =?utf-8?B?Z2RpbmpjV1Rwa3RDcFNwK2ViUkRRMGpMUnFVTGwxdzdyV05MMVpJclNZNVo3?=
 =?utf-8?B?ZzJlQ2tsdG1waXVxak1pQmxNcU9na2Q5Zm5KWXdoSnlxQkR2ZCtTL1JZd0Rs?=
 =?utf-8?B?WW1Da0pxZmxlek9pSzhtZzJneFhuZkFsQUN3TTZZMnVpN0hndjl5MUNlNFlT?=
 =?utf-8?B?TUY2YzJlZ2xUdWJReDd6RjF1MVBvcGJuVmZRNzRXbjhNc3ErRDlJdmNHOThV?=
 =?utf-8?B?STJyeHBONDVMcXVRSzZIbFk5TWUvNVhKRG9uZXZIVThqUERBME44dURIQVZu?=
 =?utf-8?B?c1B6a24vK2NBTkdZRk5mOTJQYXlveFJRaUxTRG5oaXJIcHo2YzdwN1VXeVpW?=
 =?utf-8?B?RHdUYWkxbVRvL3h5Nmo5NzVzazN1aEt4QmhWRHFmc1NFTlJJWHNtU1RHT1dC?=
 =?utf-8?B?V1FhOEIyM0NVc3J4aStlZzBvWDRXSXNUQWszcC9WSW1heDBhRERaZTk4YXZL?=
 =?utf-8?Q?o9FsMdfi6i3ufQ7i4uvMNtZ6K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZL90iOVlsecail/TiLjg9bz+D3E4BP7a5R51apUguo8ualrSKdJ8eMfFmfI17JheC19IbSXvkPsoo4Youithu0OYHquLPlhf4Rv3x/XlTm5uvDRuG06clckEaVfHIb1V4T5IOKVCzcLZWI/8fBcKr5Ov7xzgBhw6KcyY0pwYMDa77p8RaTHa7r8aH2k3AwkdvldJXL3qLr1kwMbcN4aqUcgrE0zQ2PM5eeS58HSe8mZbHjIRvEpu5NXwIqWZk9+deHaeOe47Vq/q+/h7H1XD0t8GSDhpwwRqGlrOg4iLCvgncQVRk0Y4dEKONkU09VSG7AQ40dn+EBPcGbqXIwLzwuaqgBXz1QqlO7N2/gv3+IUxyrzsyCnMtaWCCKAjY4W5YO9+cOwY/xjk1ovg4cBy3ERv1x2NwaysFN3vQJjF8wNgeFdXkLX06dIn6PhZfz2DsIFK+xfk8JRqsAdJ4SRInta256jkJRwAD3ZidmHesGX9ipLt/lnRrSDADqE4QktvUngrWHSQN52HbAvdy1EAPk6EqhxSgIfTZpPvMxM0jclvrB84QEbJhSHVmcqnPCAvq/F6QFizffLEVLqQpxqdrpZ8lnpaK3MC2RZxrOVl+HM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fdb685-f3c1-49f3-cf07-08de0141fa7c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 23:26:42.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZmQzq9SHJtNUL6NV0Z6UNrVbYY7EhiAI3oybBZ6Rt+7sdT4m+4ApFd53UWHvKcGCC1/956Zsgcbk5h4J71eDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010205
X-Authority-Analysis: v=2.4 cv=SI1PlevH c=1 sm=1 tr=0 ts=68ddb8b9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=cMhWQDAZLkWLvb3NV-YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: cnEuk7HLMhJ_KB1s-aN1J-rBtbRW3UQD
X-Proofpoint-GUID: cnEuk7HLMhJ_KB1s-aN1J-rBtbRW3UQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfX9GXzGRupiHMr
 q/dwoQqt5/6HFAnbaRJ0VIoo6giK4d0OkBBP3xkP89pacEpSoBrK8qOedXxr8K1rieGuMK2Z+a8
 YT7qdvH/NOW990UIpQkLMHt0oGQi1mtsO+WFdDqtsPA2OHaxRp8wKTlrejY4nhaq0inx7LwRQhk
 WjvpODrRZe49tdd5K4trlVgZRhZct/Z1Eb7H24OFMKPRSixPfIsLeZqTiiGCP1EjKxlCmM60LBM
 WroGDcgb6oYti47jks6V0G16fHObhfUXehtBhSSwZXpF9n9H+sHEX78H1gbd+UJB9INyiD8dRhG
 kjTadzX7MQZi7grJib7kBD9FfSCdRsaHAo7+z53Pmwgu4jSHewRDP5B2DeA8vddJ3PfUVl+zWD6
 eGUrsJuvQyUiAa44HWxnh9cU2RqP/w==

Hi Eugenio,

On 10/1/2025 6:26 AM, Eugenio Perez Martin wrote:
> On Tue, Feb 7, 2023 at 12:15 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Today when device features are explicitly provisioned, the features
>> user supplied may contain device class specific features that are
>> not supported by the parent management device. On the other hand,
>> when parent management device supports more than one class, the
>> device features to provision may be ambiguous if none of the class
>> specific attributes is provided at the same time. Validate these
>> cases and prompt appropriate user errors accordingly.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vdpa/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 50 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index 1eba978..8da5120 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -460,12 +460,28 @@ static int vdpa_nl_mgmtdev_handle_fill(struct sk_buff *msg, const struct vdpa_mg
>>          return 0;
>>   }
>>
>> +static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mdev,
>> +                                   unsigned int *nclasses)
>> +{
>> +       u64 supported_classes = 0;
>> +       unsigned int n = 0;
>> +
>> +       for (int i = 0; mdev->id_table[i].device; i++) {
>> +               if (mdev->id_table[i].device > 63)
>> +                       continue;
>> +               supported_classes |= BIT_ULL(mdev->id_table[i].device);
>> +               n++;
>> +       }
>> +       if (nclasses)
>> +               *nclasses = n;
>> +
>> +       return supported_classes;
>> +}
>> +
>>   static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
>>                               u32 portid, u32 seq, int flags)
>>   {
>> -       u64 supported_classes = 0;
>>          void *hdr;
>> -       int i = 0;
>>          int err;
>>
>>          hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_MGMTDEV_NEW);
>> @@ -475,14 +491,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>>          if (err)
>>                  goto msg_err;
>>
>> -       while (mdev->id_table[i].device) {
>> -               if (mdev->id_table[i].device <= 63)
>> -                       supported_classes |= BIT_ULL(mdev->id_table[i].device);
>> -               i++;
>> -       }
>> -
>>          if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
>> -                             supported_classes, VDPA_ATTR_UNSPEC)) {
>> +                             vdpa_mgmtdev_get_classes(mdev, NULL),
>> +                             VDPA_ATTR_UNSPEC)) {
>>                  err = -EMSGSIZE;
>>                  goto msg_err;
>>          }
>> @@ -566,13 +577,25 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct sk_buff *skb, struct genl_info *i
>>                                   BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
>>                                   BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>>
>> +/*
>> + * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
>> + * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
>> + * all 64bit features. If the features are extended beyond 64 bits, or new
>> + * "holes" are reserved for other type of features than per-device, this
>> + * macro would have to be updated.
>> + */
>> +#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
>> +                             ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
>> +
>>   static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>>          struct vdpa_dev_set_config config = {};
>>          struct nlattr **nl_attrs = info->attrs;
>>          struct vdpa_mgmt_dev *mdev;
>> +       unsigned int ncls = 0;
>>          const u8 *macaddr;
>>          const char *name;
>> +       u64 classes;
>>          int err = 0;
>>
>>          if (!info->attrs[VDPA_ATTR_DEV_NAME])
>> @@ -649,6 +672,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>>                  goto err;
>>          }
>>
>> +       classes = vdpa_mgmtdev_get_classes(mdev, &ncls);
>> +       if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
>> +           !(classes & BIT_ULL(VIRTIO_ID_NET))) {
>> +               NL_SET_ERR_MSG_MOD(info->extack,
>> +                                  "Network class attributes provided on unsupported management device");
>> +               err = -EINVAL;
>> +               goto err;
>> +       }
>> +       if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
>> +           config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
>> +           classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
>> +           config.device_features & VIRTIO_DEVICE_F_MASK) {
>> +               NL_SET_ERR_MSG_MOD(info->extack,
>> +                                  "Management device supports multi-class while device features specified are ambiguous");
>> +               err = -EINVAL;
>> +               goto err;
>> +       }
>
> Hi! I need to question this last if() :). What's the point of error
> when we specify features device-specific, from net or blk?
Because device specific features belong to different feature space, for 
instance, VIRTIO_BLK_F_SIZE_MAX (1) on block device and 
VIRTIO_NET_F_GUEST_CSUM (1) on network device both use same feature bit 
value of (1<<1)ULL, but they belong to different type of devices.

>
> In the VDUSE case both blk and net are supported. I want to use
> device_features to limit the net features that the VDUSE device
> exports.
Then we have to extend to the vdpa CLI to add "class ..." attribute to 
explicitly indicate which type of device the creation has to be, so 
eliminate the ambiguity entirely.

>
> Also, why is this limited to only net devices?
Actually, this is not limited to only net I think, we can even remove the

classes & BIT_ULL(VIRTIO_ID_NET)

conditional if mgmtdev and vdpa dev instance is 1:1 bound. But at the 
point when this code was written, it's not clear to me how multi-class 
can be supported - such that does it limit to one vdpa instance 
supporting one single class 1:1, or it is even possible to support both 
or multiple classes (multi-facets) per vdpa instance i.e. 1:N.

>   does this part:
>
> classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1
>
> Means that it is ok to specify more than one class as long as the set
> does not contain net?
Exactly, that's why it is coded in that odd way. For instance, if a 
multi-facet vdpa instance needs to be provisioned with respective 
feature bits for both block and iSCSI device types at the same time, we 
may have to extend the CLI usage to support that.

Thanks,
-Siwei

>
>> +
>>          err = mdev->ops->dev_add(mdev, name, &config);
>>   err:
>>          up_write(&vdpa_dev_lock);
>> --
>> 1.8.3.1
>>

