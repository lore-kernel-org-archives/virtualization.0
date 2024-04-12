Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD6146D7B
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940790; cv=fail; b=SKf/sNCPM3vO0Oolk8BQI/t98Nlpf5GTKSF8AfEyMB3vKnjuHOVJuvKsqKnU6RkRtAVSHFGG+cxTgVMHFXAnufC5p5MRVMrdzickKA2brsrNzk6MLMoAwMeax7EYN8SciqVBQG9FC8VHaOVdbgc6CEi6afB0LPm9QZ+tl/i+unk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940790; c=relaxed/simple;
	bh=24Q+PKOCrhNml+tNS4pvydKZBmjs3OK1c7QGcAZuCOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nl3NQlC48qudA0iWD/4PkqpiDDHwqYn2cJCVnEubvQzHEYE9MgjWPEogCNgvksfQRUhDaAe07R35/uE7yG38nDtcFF5lLqH/TjKe5PYyaYfyJEiArnecSxkx5YE0QbmWXc/k6a+BHDtCjvPljBBKiJID0DE0kDDPiYA49TFTaR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ma156sDh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rkA5La78; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ma156sDh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rkA5La78"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30767606E5
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 16:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xuwYLvGcADNi for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Apr 2024 16:53:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3F8106069A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F8106069A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=ma156sDh;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=rkA5La78
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3F8106069A
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 16:53:05 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CFURDu006406;
	Fri, 12 Apr 2024 16:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fQrAAaDkchrQ/KNUXCJ95DgDbn+LVVCQKoOpBnUcMDc=;
 b=ma156sDhwWIyoQ4XeOa+Lnq2xd9c+0A83su7bT1fXLZbhqa/LWHp73PzqDnrHDJRFH7P
 h9inBaOy3HfxPyzCgWt2HI00tQEh2EaLfG5f5Ei145hkypsozCDLuVrkDWO9bHSHkywU
 TmBu7fVVMFcc98swqfcmzsjraQ/L+ljVe2tVGOsLXAJiAaP81SmBiktuo0XIF3bOCgYj
 m1JXJgoiwxaNdzW04OaUJQA/ANH+Ujq1a2RlUbG58VDkrnWBUdV2fNttf4OXOeohfrsw
 JQtZB2gnoJz74gxVaf/AKgGpjiX9U+soy0UzLw6S2grT39pcWgw38UywKIBDF5GN+peF 1Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacvaqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 16:53:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CFDhf0026403;
	Fri, 12 Apr 2024 16:53:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrsubfux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 16:53:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQ5Axl3OyqxJqj/MOFmHtbOILJZlAcEkGQ47KVJw9lFZacU1OpTijuJJyf8VXMJg+5QUNTWruCsT0TZyitghuiNsSaFooyFSJ+JBlDgJIGgcnrlNCbwEW7CRuzWaBBqQ91hr0UcIUM7j0jN6TrQ6M9BTEL84jWiz1BGYn7oBdl+w1PejPqc/VVV/4n+fZak2gt8hlPHCPI+dUE/ZjiWtKrcp+iv+e1Fed5uOT2b7q3VvnIv8vCzFXdjbUwJ8WpavdlqeiB8CpoyKgV/ruMO1ixW+gRbHue3nFCmjifgpN5mS4OIzSZj8FEsnaSqK/H/vtahJwKU5qIJyeUSf1aDmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQrAAaDkchrQ/KNUXCJ95DgDbn+LVVCQKoOpBnUcMDc=;
 b=bJtEu1c9LwakMBhOZItSAny/bo+qzErHFJ+0Au10CISLqDOtQVfyxioXGUgHd9INvuQcWkTMPN2aVoPoWr1VwDRWNVQBX0zaGvxFVCQPdcHWtiYmwUZmte7UWjJe7EcKgZE1wWrlRQ3twpE+6qlwgH62cxip9IAQB/fsAlSJUijudOyHFxSQ3VvIQXO+I3W6QAbR42U0M55Hmqm/vMwRNE+NLpWRgEU+rtnamYStnJMq0QH+mPLLrWKbqTrkyR+krV7+FR/sfeCJ0uSw0u2/XNPQ5cRE28LOjarmfN8PV4DCTH2Syw/zAhpi93HFUYhWnvi1/auID2hk2Hg0tmwPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQrAAaDkchrQ/KNUXCJ95DgDbn+LVVCQKoOpBnUcMDc=;
 b=rkA5La78dJwtwUrwgat9Y86OTXAJyrfP3b66Num8IAB7aVRK4aPpSkutbmrfvJqN6kJxr1ZZYEA5OsFESItDIyVHnp3L5bqu4z/51j8ioLSMFWXLARptMh0vyIGRhKQaGZhsRyhe6plaq9IsTu1TBNgkuSN2YaARSIk8TmyuMbQ=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BY5PR10MB4146.namprd10.prod.outlook.com (2603:10b6:a03:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 16:52:58 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f140:2fa7:5c83:77d2]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f140:2fa7:5c83:77d2%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 16:52:58 +0000
Message-ID: <06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com>
Date: Fri, 12 Apr 2024 11:52:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: Jason Wang <jasowang@redhat.com>
Cc: oleg@redhat.com, ebiederm@xmission.com,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEs1KSdUOgLbwbR-S0v1jv8-N5cM5ZwrWyK8raF50MSRZg@mail.gmail.com>
 <9f75952f-c1a4-4483-8ec7-beddf022a821@oracle.com>
 <CACGkMEuY9cyCb+myzscHDetbfmDLZN-_JAFvZaAfrO0-Mc0FTA@mail.gmail.com>
Content-Language: en-US
From: michael.christie@oracle.com
In-Reply-To: <CACGkMEuY9cyCb+myzscHDetbfmDLZN-_JAFvZaAfrO0-Mc0FTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:a03:255::17) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BY5PR10MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 499af413-f591-4401-3692-08dc5b1101d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NpkoqVdOFFEPM/N/50E6ZJeHNofNn2Mg3vuc2apwDO/x4XK/Xuhl1wH9gn9SVuJxaPEw7rpLqd495uEU8Uue/80Tsw8DGtUVP04tnVHRutYXOBbFrysPMQA5LAAF8DxWzAsVcB/6wtvCG81JKNW5oPL6npO/ld4KrbCVF+1bpHL6KeOiMLRkNXg47aQTnyOmOTPk/Eu0QDb3eBZ7CXDKjbiNQwJGo4ZUaSTyrWlk+JAol5SCWsHrjZ1WrGvbfOuJ3NSDx/2V2c1B5Rrnj6C+b7KfjI/sPOLc6m8dS8uhx6fwhUBNHpGmDCJqsyQJ8qEWbLdwhxFdvLni+urYLMUBoH0ZZDamEgvq8pXuqNjtob/It3v+OfsAuBAcb0b4R7lG8ovrvr7fn/QOkVAyTKs9M+trVj0Uq3oVGdhzS3+6ESlFjjA+7zHkTV9yhTmv6eQ2rFhbNBmiP3uW799ROxZ+TWkZCbxFhm7gyJugJZmc6GQFbsfUxwMMtOTneUiZJE/x7Z3K5uKIYj6tWQKJGKD3ePuoYj8CeG6Yg7vdpIF1kyAUYS2+z3B1MFjOSSw8Mb1z0A9SkbP5b22fjNmvvyCK4gqyNLCgaDONS9ImHTgacNGvRWvLpDQ/KnbaZjCD5agzmH30oJUwjA76KJVUUgm4+M+CJx942n+b4PGhDHY97uw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dlR6elhnMG16d1RrOWdzeGh3YktLbzFrWW9GdTFUMG00NVhlY08vdlFhK1lX?=
 =?utf-8?B?YnhQdWFhelpscUFhSHA2cmhlVzU1UExocjJwZVI4bVY1bmduRUkzQlE4WDZz?=
 =?utf-8?B?U1NYRndJd2ZhdlIwY1RVWmh0NTFaMTVsQ2VlaW5SbUlsRUZCUFhoT09hK1dO?=
 =?utf-8?B?Sm1wcGtyQWttaU1TWmVMSERUb1pQVWlRYmNWT3lRS1lKSWh5eTZRb3MrMUVy?=
 =?utf-8?B?bU12NVZNVVRxaUMzRGNIQThZbGdqUmFKQll4V3Q4TnlKREpZYUt4S1NHeXVX?=
 =?utf-8?B?TGlhbEdBMDYxZzRidDJRS2xVcldGZmVoeXZ4dmV1M1JQUTdPRFFRUGNmaDRX?=
 =?utf-8?B?bk50U0xnM1hSOW0xRmN1cmxucVNZWlFjbnUyNWw5N3hBTFgvcm9taHZrRitO?=
 =?utf-8?B?OU40dkZLSVlRMnZwRk40a2FxRFhLb2JUSHdQWVRFN095TnNIYk4rMGsybitE?=
 =?utf-8?B?RjczcGJuanNTZE95d1gyZkltUU9xOVUwbndqODFsaXJzYmF3eVNDTnluOERO?=
 =?utf-8?B?Y2VmQVJ2UDY2VnB4V05RdFhJUURQZFIvdVNURWVRaWRGbGgveFEvYjhtRE9O?=
 =?utf-8?B?YzNFQm1IQzFKZ29MVlVweVdwVjZGUVJTazE2a0VqWVFENTYrTDA1UHRKdkF0?=
 =?utf-8?B?ZmNpN2JXbURUWVBqMDd3MW5Zd1lhOVFHNk5hRUhwSnJjd0ZJbkUwVkxxOHEy?=
 =?utf-8?B?T0xBYnBDdms5YXMzVFJWMFlwZnp1Zm43V0RvM3JDSEx4MWNobjhZcUhFK1BI?=
 =?utf-8?B?SmhxOTYzeHE0bHBMbGVkUlY0Uk4ycFB2MkMxT2M2blhyL2x3UEF5dXFJQWUw?=
 =?utf-8?B?Z3J6eWRwMy9xcmJvQytKK2dYS1B5NkExOTc3NTVtUXkvd21ma0ViTCtYaGZr?=
 =?utf-8?B?VUhxbFlXUnRmTzBDWndUTEtEbERlcmdBellRK3Y4U2M1OVhqekYwWFRpNVZL?=
 =?utf-8?B?WlVxM2VFamtLajE3Zk5JS0hrcmhKd21KQkd2Uk9lVXUyR1dweEl1bi9QSkJQ?=
 =?utf-8?B?N0JxcE9zOTBuQzhiN1N4VXA0UkgxS3VNanBLbTNoRWVBSk52WjVIcFpLTFps?=
 =?utf-8?B?YVMxS2NHWU9lb3dNN3FZUlUwbVVYV2ZyOFkyL2M1M2VINHhnZGZWYmh3R2da?=
 =?utf-8?B?N0tDNHBNcHR0V3RyS3RCWHZaa1RRKzRTUEhwMm5Wd0YwS3BOdS94b3M1ejFx?=
 =?utf-8?B?YTNZVWh0L2xsZXVRZEIwZld6M1F4bkJqTm9RUUhvNlB2dk94NDRHTXFhT3Fz?=
 =?utf-8?B?bitGSmxUaXYwRng1MVc4b241aC9jdkYxUjlVbTJVTmF6d1lrcFhtNmxpNHdu?=
 =?utf-8?B?V3JnMStQZnZyUEpWcCtvb1ZrbmcxclpyR1M1eWVNb25nbXhqcnpnekdGYWhV?=
 =?utf-8?B?MXhCZGs5bmdmK3dmUEYzTlB2RUxQY010MTEzeXNPOCt3ZjI1anZ2cE1mMmQx?=
 =?utf-8?B?bTA1eGcrRWtmMnVDVnJIdFVaWVRja1JKWXUzWEZ2cXlxMUFuamlxOWQ0OFJP?=
 =?utf-8?B?bW0wZTJ4MmxBOW9hdUl6YlRLOStpcjNsN3hDTXhOaDVqTHY1MWk2U1Y5YkYy?=
 =?utf-8?B?WXNiWXYxR3duSEJIZzhOb3FNSElCUW1vMHpDaitVNVFNdFRMOUZUVVF3ZVcr?=
 =?utf-8?B?dngxd24xZmRrMW1DV0k4OWhNbEFLNW9BQk4rZk9WQzVxWHpKOHRtd2NTVEZR?=
 =?utf-8?B?TW1XQy85QlVIT21iZDNUcWMveWM4OVZLbWgrQjN3ZGJpcWRaaStqVTVnN3l1?=
 =?utf-8?B?NmZqZnUrVkNNL1R3WXIyanBMMWlwM0ZQMzh2T3ZPK2JwR1F0TCtZYnExRWRl?=
 =?utf-8?B?MHBOY3FRTnhVM0pUbXVOcVA1RkpUQndxaU9xUkQrQ1NSOVhhekpHTEVLazBU?=
 =?utf-8?B?Q1UxMjFtajY3bTRSaldzczA1VUFHRzF2YWdYYXBCV3VCcElTREVRc213Rk9I?=
 =?utf-8?B?OXFZMXRxNlZlVXBaSXRZMlprWDdBa1Y2SWtzZloweEY3MGV4VUFqK2lEWFVW?=
 =?utf-8?B?dEd0SXhCeWcreVJwMEo1WmxYOVZjZTl5dGNPaENWKzdSZ2tzMUlGMjB3WGk3?=
 =?utf-8?B?N0hTZWFjNyt2R1BINy9HR2hXYmlVVHNUNjRzaUR3QzBBRFlYSDRiV2tPZzRz?=
 =?utf-8?B?MmtYZW5qV08yZ0tKYWRDTXZtUkFDbHdZZmF5Rk4rMXRIdWdmNld3aGdpOFBn?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fs/SFnIu8Ayx/J/9PnH8Viw4VUSMvr5u751/MaQz6kKVUIL94y5pbCzYrd84iew5jVtcn8tGOF7QT9DAd0mwG2MLMmgXTxzUCZ2iqw1zcRaFgqQCanNKubVilDK0mDDBai7rScpotXhnMHhfswHiAxzsx/KFQvXmtrkf4tbPrqSjAPtn8iXvCJp/wr/rOZuAubuq/ycXh9f6w9pi5eRtvuy7xMJ/cTp1LB5dpoNlBmpgEKVozPnCbuPlVwtTqaJSUbHBz4HmOuHmn+d4BtxkGQbYALq9v2h9pKBy7No5PLqddw8RsFP34Y6v7VAuRvEBPfJPYF61LNEEX943JmQ6d0wIIFCgUumE0Yy+9k3Jh3eSqYF/JeJIEal3Fn4tMNIyIzyzUw5ehgc9+GHfajUjaOz3LhKm6i8h98vTjv2QxvA16HYE54YJ2jjGiPUoiKRZbdLDaH0FoldaDvKsoRwfsHnbaFsigcu0FUSLs3flHwu10rkoMBCGeVT4IqTKmA/S8pQHjjTvPGI7LIcY3iSniqGL4JzS/iqhSgwNfMFrhbLq/yEGWl+LgwdQfrkil/1aisMGljx5Qf2XWSJzC7vNToaH0J5fB3BJG2Dz9jmrdZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499af413-f591-4401-3692-08dc5b1101d6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 16:52:58.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xL5BD8FoBBl0mcg2hwgHiayODXjViosAXrzt1oS8tLtp2Dt8InUxnBwbYxzTVyBcPJFGzEyrvTbjh+jQUr7gidKqCAm6KBFPgJElBrwYd5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_13,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120123
X-Proofpoint-GUID: 9OeCVstpNyLvO-DRZyhT7NwYs3Kh9jy9
X-Proofpoint-ORIG-GUID: 9OeCVstpNyLvO-DRZyhT7NwYs3Kh9jy9

On 4/11/24 10:28 PM, Jason Wang wrote:
> On Fri, Apr 12, 2024 at 12:19 AM Mike Christie
> <michael.christie@oracle.com> wrote:
>>
>> On 4/11/24 3:39 AM, Jason Wang wrote:
>>> On Sat, Mar 16, 2024 at 8:47 AM Mike Christie
>>> <michael.christie@oracle.com> wrote:
>>>>
>>>> The following patches were made over Linus's tree and also apply over
>>>> mst's vhost branch. The patches add the ability for vhost_tasks to
>>>> handle SIGKILL by flushing queued works, stop new works from being
>>>> queued, and prepare the task for an early exit.
>>>>
>>>> This removes the need for the signal/coredump hacks added in:
>>>>
>>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
>>>>
>>>> when the vhost_task patches were initially merged and fix the issue
>>>> in this thread:
>>>>
>>>> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
>>>>
>>>> Long Background:
>>>>
>>>> The original vhost worker code didn't support any signals. If the
>>>> userspace application that owned the worker got a SIGKILL, the app/
>>>> process would exit dropping all references to the device and then the
>>>> file operation's release function would be called. From there we would
>>>> wait on running IO then cleanup the device's memory.
>>>
>>> A dumb question.
>>>
>>> Is this a user space noticeable change? For example, with this series
>>> a SIGKILL may shutdown the datapath ...
>>
>> It already changed in 6.4. We basically added a new interface to shutdown
>> everything (userspace and vhost kernel parts). So we won't just shutdown
>> the data path while userspace is still running. We will shutdown everything
>> now if you send a SIGKILL to a vhost worker's thread.
> 
> If I understand correctly, for example Qemu can still live is SIGKILL
> is just send to vhost thread.

Pre-6.4 qemu could still survive if only the vhost thread got a SIGKILL.
We used kthreads which are special and can ignore it like how userspace
can ignore SIGHUP.

6.4 and newer kernels cannot survive. Even if the vhost thread sort of
ignores it like I described below where, the signal is still delivered
to the other qemu threads due to the shared signal handler. Userspace
can't ignore SIGKILL. It doesn't have any say in the matter, and the
kernel forces them to exit.

> 
> If this is correct, guests may detect this (for example virtio-net has
> a watchdog).
> 

What did you mean by that part? Do you mean if the vhost thread were to
exit, so drivers/vhost/net.c couldn't process IO, then the watchdog in
the guest (virtio-net driver in the guest kernel) would detect that? Or
are you saying the watchdog in the guest can detect signals that the
host gets?


>>
>> Here are a lots of details:
>>
>> - Pre-6.4 kernel, when vhost workers used kthreads, if you sent any signal
>> to a vhost worker, we ignore it. Nothing happens. kthreads are special and
>> can ignore all signals.
>>
>> You could think of it as the worker is a completely different process than
>> qemu/userspace so they have completely different signal handlers. The
>> vhost worker signal handler ignores all signals even SIGKILL.
> 
> Yes.
> 
>>
>> If you send a SIGKILL to a qemu thread, then it just exits right away. We
>> don't get to do an explicit close() on the vhost device and we don't get
>> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The kernel exit
>> code runs and releases refcounts on the device/file, then the vhost device's
>> file_operations->release function is called. vhost_dev_cleanup then stops
>> the vhost worker.
> 
> Right.
> 
>>
>> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so the worker
>> can be thought of as a thread within the userspace process. With that
>> change we have the same signal handler as the userspace process.
>>
>> If you send a SIGKILL to a qemu thread then it works like above.
>>
>> If you send a SIGKILL to a vhost worker, the vhost worker still sort of
>> ignores it (that is the hack that I mentioned at the beginning of this
>> thread). kernel/vhost_task.c:vhost_task_fn will see the signal and
>> then just continue to process works until file_operations->release
>> calls
> 
> Yes, so this sticks to the behaviour before vhost_tasks.

Not exactly. The vhost_task stays alive temporarily.

The signal is still delivered to the userspace threads and they will
exit due to getting the SIGKILL also. SIGKILL goes to all the threads in
the process and all userspace threads exit like normal because the vhost
task and normal old userspace threads share a signal handler. When
userspace exits, the kernel force drops the refcounts on the vhost
devices and that runs the release function so the vhost_task will then exit.

So what I'm trying to say is that in 6.4 we already changed the behavior.

> 
>>
>> However, the change in behavior is that because the worker is just a
>> thread within qemu, qemu is going to exit since they share a signal
>> handler and userspace can't ignore SIGKILL.
>> We then run perform the
>> steps above like in the pre-6.4 kernel description as if you sent a
>> SIGKILL directly to a userspace thread.
>>
>> - With the patches in this thread there is no major difference in behavior
>> with 6.4 and newer kernels. We might exit a little faster. Instead of the
>> vhost thread trying to do it's hacked up version of ignoring the signal
>> and waiting for userspace to exit and call file_operations->release, the
>> vhost worker thread will exit after it flushes works and stops new ones.
>> So now, you can have the vhost thread exiting in parallel with the
>> userspace thread.
> 
> Everything would be fine if Qemu wanted to quit but I meant there
> could be a case where SIGKILL was sent to the vhost thread but not
> Qemu.


Yeah, in the last mail, I was trying to say that behavior already
changed in 6.4. In 6.4 we basically added a new interface to the vhost
layer that uses signals/SIGKILL to tell the vhost layer and userspace to
completely shutdown.

This patchset is just removing the hacks Eric and Oleg allowed for us in
6.4. That code where we do our hacked up version of ignoring signals
(clear it and just go on) combined with the signals/coredump related
hacks done in this patch:

commit f9010dbdce911ee1f1af1398a24b1f9f992e0080
Author: Mike Christie <michael.christie@oracle.com>
Date:   Thu Jun 1 13:32:32 2023 -0500

    fork, vhost: Use CLONE_THREAD to fix freezer/ps regression


is causing this bug:

https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/

Basically, as Eric mentions in that thread the signal/kernel developers
considered the signal/coredump hacks were meant to be temp, and we were
supposed to convert to work more like io_uring's io_worker_exit. That's
what I'm doing in this patchset. Patch 9/9 in this set then removes the
hacks from the core kernel/signal code.
