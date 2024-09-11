Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFA19CC3C
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071640; cv=fail; b=YNbqI0nSp13aR5FrIAjM4F9ROgfSS1z5twaDkACAmpE0GL/Rj++swX4PGrBOaIK4XRF1chdiJG5/JnsAtJE92QX/Ja92y/spM2TFnrth4pXH1blcFFzQXAqeK0ObfXm/tEroF9H/dG7UmH4FhGUqz8DMOBkntrWeumVqb6GGIWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071640; c=relaxed/simple;
	bh=1dZQ0R4RfzdLuypMV3T/nynwT6kEWEYWsGcMTDsDlTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gXP8h6ak1XiSfdAns+WVvcntVq/V0VV6+Y1xe+ezlagoDVSigUUGTSR2n8SXqX6WmkoJb+DquIJa+NpKYRAARN/OcAIb9+K57BK8oy5m/cqPfTrZiAUsW6eL/VLt2i7Wx5TnpQU7zlNyQEP2UncWj2RT+HsVpieMGn6JtKAQNcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TjOnKvwW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y0Df+1GJ; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TjOnKvwW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y0Df+1GJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C58D1606D5
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 16:20:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.489
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bj715tf-nwfg for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Sep 2024 16:20:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=michael.christie@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C17E66006A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C17E66006A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=TjOnKvwW;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=Y0Df+1GJ
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C17E66006A
	for <virtualization@lists.linux-foundation.org>; Wed, 11 Sep 2024 16:20:37 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BCgCck011520;
	Wed, 11 Sep 2024 16:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=M5j65B1NWwnyoIGJ9br1Wl7JwB5uzT6NhzGTBghCMw4=; b=
	TjOnKvwWaonQeY+QLPiFuVrEJVt64XPgvx7R6IQzP00mKdNqOQ70JMPvlfzdSZ9Q
	o0Vo6ghxbruWE4srVCOmQpByOaPt3P61LiVegFrODx4081RZkv2UEeC9x/s2XJZO
	xeLtEEMIPKCObN1qoL7vozQdGUKPmeNH+tkjUC3fpTIm7x7/2fBIdrCrTSNQG+Dr
	6Z/Bw7QVTRHENGNzY/VvdPJOoJV7etdTT6Lh8v9mvvx3rCybAfW+jOSFkQNGOZUA
	g3+CH1jMAzwyWv8dE9fYA85g0FKZ0gkGZeqUZTd1ZfA9hEcgZ3W2O40NnZ/hiLw/
	eWuKI6RR7sUxl9arzH0/ZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjburex8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 16:20:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BF9cAZ034196;
	Wed, 11 Sep 2024 16:20:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9anckw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 16:20:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3FlVs87UbT2ilbIhLISTuaC97JjGdAiqn+ful1uGAlMrxpF44QJ08hlOBZnckiabRfuH4p7dsToZqZeFaiKaNlu9j6Xdcz8kMKtcHWgAXpd+HaNUxW+UTfpjK5/2HWC0KRTS/i2mt5tvS9o41du2wYRKOnOSo5sgKfRw+nwMD/pTfOG9EvK+Ku+R4D7lGTR78SMcBugk8gFGB8iLF0wMEvtp1jnot++lz6rNXHjT8MFANvRA8KZfplqDGSyC7B82vgJncCwZZldTZd4M/SnFl3QgqvKMPyPI1BTa+b2gxAmGMlfdiN8dZR+1gEZbdqeUyYOOFM+dlwe1YlmW4A2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5j65B1NWwnyoIGJ9br1Wl7JwB5uzT6NhzGTBghCMw4=;
 b=Nfv2PEP1q7n6V67t+eSaCOFKnFxc9KfRqvdATfj8Ao/uqkZii1q/kWbqSEY6x+lVI9tV/n5JL9pzA8/Narslmhw+bw84vM9meETlDgBXyKGFkY8a7eh2j7vHFHScqlQbtKUBS2yhrZtDz2jaku/uWZVrtUozXnSM3k2Ekv3JpvlKsxfMrxQHYb2b7CtJt3egVtttzzbHiKSEMllzEH8ipMPawI0MA6MCRLYqhzDryGzYXf957Mqj+XWhuyV0fgUXlaSo+NBXSJt4NKq14ulSt2dYOOXb6QOgSQZ2osMcQjs3wlzCs8o8CfOmcf3g8MVsvNpVTrjBMdtczxG+FVeQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5j65B1NWwnyoIGJ9br1Wl7JwB5uzT6NhzGTBghCMw4=;
 b=Y0Df+1GJag4lL2Vy+MsGabfwj2yQaTAY8a33FTdz0xKpXanCulphanz3onWc1/HAYNjoJvGRY31KNa+9G2sUiwaOHRppzdLm8YoskxOeobETeUrswNZFiuKaMHgDGDhFBqp3nglcWQeCBu2QbtQ5Iim64HWbUx1cG0EAnCaV6Eg=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DM3PR10MB7910.namprd10.prod.outlook.com (2603:10b6:0:b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.16; Wed, 11 Sep 2024 16:20:32 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::b779:d0be:9e3a:34f0%4]) with mapi id 15.20.7962.014; Wed, 11 Sep 2024
 16:20:32 +0000
Message-ID: <85fb3a90-fbf4-4925-8b53-197f3faa574d@oracle.com>
Date: Wed, 11 Sep 2024 11:20:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20240909020138.1245873-1-lulu@redhat.com>
 <20240910032825-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20240910032825-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::11) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DM3PR10MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c2d58a-825d-4d19-ca24-08dcd27da8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzJaYzVOMFFGTnZ3RzNuOWc5L0ZuYjYvcUVwRml0OHR2NitHV29OQ3dQR1Vj?=
 =?utf-8?B?L3F5b3dsN2plTHJzSjNtZXUzL1FCVmZUOEwweCtoL3hHc0d0cjY2Y2tsdWsx?=
 =?utf-8?B?R2FwR2FYWVliN1FOZ1NFbkExY3F2N0pXOTRVRE5vYVNuNEFjdnVhVDBUMTNX?=
 =?utf-8?B?MmFhb3RNdmtXZG92NmhlcWhrQ3Zpc2cyVTh6dkNhL1Bhb2VWeW5YUTZNN0N0?=
 =?utf-8?B?Y0JKWUVvZHp2UTNjSjBDd0VWY2RZRnRiUjJsZEY2VWx4eDgra1ZkME5vWnJ0?=
 =?utf-8?B?VXBsWmZRbEVnS3VOSWwrQ0VNU0RCWm5tZFo3ZXAzSk9oMTVUVk1NWjh1M29I?=
 =?utf-8?B?WkNDeCtPWi9YMVVURlZ1b0dpanBnRHlqWWpYS2orM1cwZVV5L0t2ZFNhSnUr?=
 =?utf-8?B?UFR1YWxxWXNoWFFlS1gzVUFnblp0aDkrYk9Rck5SWkp0bXFadERVQlZBYTFY?=
 =?utf-8?B?dHZmQTAvSTRib1pKWGdGcjJnMmpBR1J6MnpwRVRBWDVqN293RlZjOW9GUkQ1?=
 =?utf-8?B?L0ZkOFNrdnNEZ1AyQnpudDZreE5laTFKdUtDVXJOcis4UEVWRDFWZWtvSFg2?=
 =?utf-8?B?SlNOQTFOcnd3SVVuOWpVS1dGcEIzb255eGhKZ3E5VVB6VW8rTUM4WllJN2kr?=
 =?utf-8?B?V0hhbVRZSFVKL01FcUZhVzlacHpCb21LamtMNU5tUXRGR2JmRjQ5ck9BZXQ0?=
 =?utf-8?B?akFldzNWbkQ3QVYyanZDR2FYVXR2bWw5VTFqei9iUk1jVWtUUHF6RDZ0UGVO?=
 =?utf-8?B?ZFBVNXhyT041QUFNaklBeE5qeDA2V0JYMmh3L0ZySitzc2lnMmtvb041YlFw?=
 =?utf-8?B?SUZIdDgvK2o1dzR3a1dSVXRlQUtPblNBSVJyL0ltSnhwZ3Q0TWZNQy9PRGFl?=
 =?utf-8?B?dTZGTmRCUHJJeXNnVVFDcEwwUmFaYVFIMlZVWTVoMTVTTUgzQUFSZ3ppdzRs?=
 =?utf-8?B?RlNxdTF5d3pEVVZMQy82ZHp3N1NWUHNMOFlpTG1WK2p2c3pxYW8zOE5jWVZG?=
 =?utf-8?B?QldSWDRjNUFMOTdTOHgrZm1oSXFVeklBSXJwRXdyYllHTkZNZE9oSDNVWWpt?=
 =?utf-8?B?aGdqc0dMQ0xVdWN3a04xZ2w4TWJXbk8vWnFiQUFtNnVhZjA0K2FEeC9ITCtC?=
 =?utf-8?B?c1NGYjYvbWVNQUQzc1BsaGQ2cEtLUmM1RzFRa01OSVdTZE16ajI3OGl4d2J6?=
 =?utf-8?B?dWdZUW9lZHJodFNWWDZHYTlSYkpLTENJM0VtVWc5TXVQZE9vdHBBMThMYjVD?=
 =?utf-8?B?ajZuMklvM0R1eWRzaVkwL2liZUhqQ20yMVRHbS80aEl6Uk9vUVVVNTlxRkFl?=
 =?utf-8?B?WGp4OG0rc2VqMkFsaHZ1V08vc1lrcHdRWUZud21xcDY3MjkwYW1OUzBRMnhy?=
 =?utf-8?B?ZGxMekZOWTc1V0ZiMEdFa1I4OUs0L0RvSTlEWm1mM0YyN3JqVmFoZ0hxMllW?=
 =?utf-8?B?Z2tsTHlibXlHSW96Sis5emNqRGFjOW1CK3Mrdk1pa2FBSVVqRXQ2dC8rQmRW?=
 =?utf-8?B?SExDZjJXaWpYeGQvRUpKeGE3RmlFRW9BakR1aWZXTklHRU1sWXFmWHJCSkg0?=
 =?utf-8?B?Mlp2emgxeGtHbENya01MWVFEcmtYWDhhVVQyRkZyNEJ1M2pUbjNNNFNGQ0RZ?=
 =?utf-8?B?M3dac2d4QTlob25xaGwvc2Q2MjB5ZEc4bDJSRXpoQXVCNGZUTkdpajA3UjRZ?=
 =?utf-8?B?QnRlM3IrUkRubE5hN01MZURUdmJWSEk2alhpcEFXN284ellPYjZpYUZ0eEpJ?=
 =?utf-8?B?bFVLV21XRFNWcHAyY3NzaWF2dHZZaEJ2SytaeUF4ZHVnbjE3SUZYaGhIaFpY?=
 =?utf-8?B?MjI0ZXNjZnNrcWFaeThGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0lWaVRlSHNWTUZNelpQUlNkcEZwckFIZzQ0Slg2ekRDdlhYV2t2NXZEYUI2?=
 =?utf-8?B?UEllNlBvMUQrQkVkZkxDdmNwY1NNdGpiRTU3QmhXUXNqN2hZZWVZK1cwOTdX?=
 =?utf-8?B?MXhlQWxIbmUxVFRvd1U4Zk93S25aYTBYSnNQRXdWbGxrNDg2U2g2UnVKOE95?=
 =?utf-8?B?TW9tRjVyMCs2eUg2MUx2YzY4c3JWQXBacGlUS1V6ODhoaHJMSHZielQ0K1Q3?=
 =?utf-8?B?UkhRd3k4OUZwclU5QnhqNTZPUG1WV2ZtRTVtdTdHbVQrVWhmdDlheHVOUlds?=
 =?utf-8?B?V3FOWDRuTVROeGFvOGt6WlFuSzZudGU4clZwSWlsM1B6dk5pKzV4dkNrREoy?=
 =?utf-8?B?d0VpZU0wMUJCYSt3MkhzT0hOVDloZjdDVkFFU2xRNHpxNU9lL3g0NE5xSWwv?=
 =?utf-8?B?MS93QmcxVEJ5RUdwWmpMaGZhYXpzZkUvL2psbHVKOE5FYlNPR2xuQWI5Rmlk?=
 =?utf-8?B?WkZCdGQ2YXhKcWNSQ3BYdFRBdFR0dEgrb2lyQVp0dU9xY2hBZ1BuNnQ0UkEw?=
 =?utf-8?B?YnA3UHFzYk44UEpneXNIR2plUzgva2pPOUJvOVN1d0ptRlhVRVBPMmZ4RTIr?=
 =?utf-8?B?Nm85VWpGaHkxRnRlTEVac1AyM3A0dXE1Q1dSRG1HZVRIM1JWUWhwV29NNFBX?=
 =?utf-8?B?YnBleTRLU0M3bUgxTk8yRDRLQWN5YjZXN0cyNlM0S0pFNDh0TTdQS2ZmcExi?=
 =?utf-8?B?cTlUUEdmZnRXeUx5VFBGWGtJMStBRi9hOHJ3YllzYUZWakhoVmlnNUtoR0dV?=
 =?utf-8?B?c2puNXpGb3grRkk3NWxuajRaNURNZkFsVmlGYm9ZMHd5NjZNdS8vN2RJTW51?=
 =?utf-8?B?QVdsbUxmT1VoaC9LK1BKTThLbDFmaGNFY3RSa0R2Qm1Vd2dXNXVMRnUxUUtr?=
 =?utf-8?B?NklXN1FvcnJ6MXB4RkM1V0RVS0lvaUdOb00zcFJ2b2kxak4rYm9QNlcyS2RC?=
 =?utf-8?B?cW9vZW5tdWtXSEVUVE81QlFkMkUwQjNCUm1adnJCTUVmS2VhMm9GcEcvRGFP?=
 =?utf-8?B?UWVPbXNaNXBha2Jnc2FVZWE5VHlLVVVqNEhxS2ppR0k1bHBNUmtWN1gzQVR1?=
 =?utf-8?B?NGtZMUE5TkQybm9Hcjk2TU1TdDdxczN0Mzh3WmZIeVJ2eGhXTmZuMFZVVTZE?=
 =?utf-8?B?UXUrbjNkTEFyWlhvbHlqOCtqR3NZRzFrWTVYQjZMTm5CZjY3YVZwWXdISzc1?=
 =?utf-8?B?MEJrU01KUlZyRlVpNVVqdHNRQ3AvWDMvTUUvVElKVFBZUGVzVUtwUkhzYU5v?=
 =?utf-8?B?NlNXRUxubGFaNFUwYk5IZzNSQ01qcENFSmZPeS9SNkFra2FjOUh4Wmw3WHlH?=
 =?utf-8?B?NTFkTUZETFUwd3lhV25BbS83ZlAxRUc5M0grT0RubHhPZWpCUTVabWVuYlE1?=
 =?utf-8?B?SDVjVHZGbGM0M0xGbHBkaW56aGpsUUc1K0srR1BydWZQY2Y5bVJidXFia2xl?=
 =?utf-8?B?MmE2cG1NN1dxaENES01mWG1EdnJLUEMzQXRaeHQreUhlSlRZVDJJVWpZN0dT?=
 =?utf-8?B?aXVNRUlnZDZYVmlWcU5tZjJ1SStoNGgwODlBLy8yeVFla0xkT2kzUXB4ZGNu?=
 =?utf-8?B?V0pzckZlU1Y2cVVBTmxlM3BqK1AwcU16Z0Z0QitIb2ZwcHRPaE9XSTJlZVZF?=
 =?utf-8?B?Tlp1Y2tKNzRKK1Zmb2hQZkdJNFBrMnhGckk4aFJVMWZXRWVGbllHblFyZkhN?=
 =?utf-8?B?b2tsaDJ2T1g0T2tXcmoyT253UXpzYkZQQ1IrZzROdjJ3ajhHYTZLV2Zkc1Jq?=
 =?utf-8?B?SW5WUTFSWDJJM2FmSFFKdVg2UVhxdi9KZ2NvOHBNZy9OaDRjc0R4TS9Iemcz?=
 =?utf-8?B?ZVRLaEhBa0NrMG1NeTBpakRUZFQ0d041Y3g0L0ljKzBzTThTTmhEUTNFQnR0?=
 =?utf-8?B?MktYM25ORGtwVkFLR3kvYkdmTktLcTk1VDdCeW5Vd0lLcUw5eEZoTTlDUnBM?=
 =?utf-8?B?VFdxYkx1czY2cXRWbnUzMEVjTzNpcmh6RlMvSEh6eHR2TkFEZTNibWp1L2Za?=
 =?utf-8?B?b1FQZ0NhMkl4eFpxY0M0U2NLcThNc24wNFhPOFNqRm5ZQm5EZE45Q2RFbmZU?=
 =?utf-8?B?TURUZExTS2pIUlk3OFMyREdjWkNpYzVOdnQwQ3ZKRC9zZTFSSEpwdVl4Tm9R?=
 =?utf-8?B?L05iQ2s1ZFk4QUd0RFE2cVk2SkF6elExd1FTSWdsdmxJN3J6NUhtUXV4bW9C?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YO/WuPpWoDwSQtydBKU5w+Q+qU2NpNQ92Fzz/3mmxnWjbhsOyWZALVnsXQGZ4fWvpU3QSnRUh48bGLDai/GQpEJvtfMmSjQVTzNAAF+w9CUuNn+RgJ5QnJQHqriZz90fPQkjx66s9PxK+yyDCQHcAeewwlOrKlo01HyeP/lL8FzyiOJM0NCWwsPvN6irgnZ15FxC623tOWqhZig8g9nf9WYZNhCyg0Zc+xqAxorhTP4nUEPz50eLcr8YNvkls9v6Zbd2URyhy5yswQCM3qdAJZkngZ5U1zKYkr2BN8n48h8KLmwg7xHQnXX4FjgseONXezRrV6QIxNXHvu4tPZi0e3aGnsQ86VMF9tj21+pUyhiYM1VUmuWOsKReLOMy5jdP0slMEZ/0E91hwwRUwOrGyI/mK//os821vUyC8c21lFnrCoI2NRL6kIriaBFv+58Rlm8HioemsFeho7m/b1V6/pnivyVrAhkj7THVecDCMg155liCUuZmK7Su1fFtq4h8qdwPb5gNHUbNJ0XJqft7qctBwCkdKu5RsWWKbwhRx3BPmyYTB/YdhmCxf7aaeBWbXvTkvLW7NbqqZar2JwbyzgXHR16r6EFjMtj0/xd6aX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c2d58a-825d-4d19-ca24-08dcd27da8bf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:20:32.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQt++Pky9dYTmLjFJqOnst4oeuLHZ/cHhVolJPHS9QLfNDH2AYDcUqTzhEEKNq+XabNTPCovAZQBcqy1INQPaq2CbuCVnmJXmlX0BRy8efA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409110124
X-Proofpoint-GUID: VVFnzby8csyt0Nm4z_R3a5CfXSa-a579
X-Proofpoint-ORIG-GUID: VVFnzby8csyt0Nm4z_R3a5CfXSa-a579

On 9/10/24 2:41 AM, Michael S. Tsirkin wrote:
> On Mon, Sep 09, 2024 at 10:00:38AM +0800, Cindy Lu wrote:
>> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
>> vhost removed the support for the kthread API. However, there are
>> still situations where there is a request to use kthread.
>> In this PATCH, the support of kthread is added back. Additionally,
>> a module_param is added to enforce which mode we are using, and
>> a new UAPI is introduced to allow the userspace app to set the
>> mode they want to use.
>>
>> Tested the user application with QEMU.
> 
> Cindy, the APIs do not make sense, security does not make sense,
> and you are not describing the issue and the fix.
> 
> 
> The name should reflect what this does from userspace POV, not from
> kernel API POV.  kthread and task mode is not something that any users
> have any business even to consider.
> 
> 
> To help you out, some ideas:
> 
> I think the issue is something like "vhost is now a child of the
> owner thread. While this makes sense from containerization
> POV, some old userspace is confused, as previously vhost not
> and so was allowed to steal cpu resources from outside the container."
> 
> Now, what can be done? Given we already released a secure kernel,
> I am not inclined to revert it back to be insecure by default.
> But I'm fine with a modparam to allow userspace to get insecure
> behaviour.
> 
> 
> Now, a modparam is annoying in that it affects all userspace,
> and people might be running a mix of old and new userspace.
> So if we do that, we also want a flag that will get
> safe behaviour even if unsafe one is allowed.
> 
> 
> Is this clear enough, or do I need to elaborate more?
> 
Thanks for working on this Cindy. I've been trying to implement
this in a way where we don't have to duplicate a lot of code but
have been hitting various issues. For example, I've been trying
to modify the vhost_task code so it can emulate the kthread
behavior we had before.

If people are ok with something similar as in this patchset where
we have both vhost_tasks and kthreads, then I can send something.

