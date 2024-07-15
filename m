Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CCC18EA85
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053675; cv=fail; b=gkK0uPsbzCggqoMnx1YvUELUlHQTwAVbeKcS+ONiCrTxTCA/gxU5PXmbFJEDjVqx4EZvTpQH7akvsoTOaN9fJjqbUzPAWcC6AC98zfaZG9NnX+Oznc8YpwRbGM/DtFKHFz0nBeatRYESnWhIuvqwSOtI/Yr9fNFZYb4LfM67dmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053675; c=relaxed/simple;
	bh=74yE8EojKiKR3t7MaqSVEBvz2WhG4jeJd0TCPfgpxiU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MjQm4XKA4Uap//Vqrewn3PVKC2QciDElxh897JjD2PQHFfgfasQ2/e2ocgX6WaL403ziTf5riELcleW7CYa1BYqf3VR01V/rHG4bLB3VphFO6buU8Kd6L2ZwaCRRgEQ+29DVWO6r81nAX+MGoG5Dr4stR7J2Z12ZtvsZE18jqjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YAlZDx0/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qcsW4qd8; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YAlZDx0/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qcsW4qd8"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E97F160815
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.798
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LIVx_HHyfyLH for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 14:27:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32; helo=mx0b-00069f02.pphosted.com; envelope-from=steven.sistare@oracle.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 293066079F
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 293066079F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=YAlZDx0/;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=qcsW4qd8
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 293066079F
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 14:27:52 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FENdRr002336;
	Mon, 15 Jul 2024 14:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=nsOvKbdGSvcOvrMLUlu3ywVxDc6l8UEXwNdMQ/CHy+8=; b=
	YAlZDx0/sWKqJxIsvlucCcGnka9xzmpNDYPSeRJNXFlJxuj+IZfAndKXkUu1Mfls
	H+UXljPf3H25phfRfuOk8e4PzbBCvv1dqzcLHa0zgb0F0X9iF3eNnCX9q+ETWBNk
	7r2UMBTZ3x/74OqjVd2zsfvJtdxnwzj7KAO8Xs4IfB/QKld9qA5a31zGv4A8xcWc
	NMIr4u23gO5AUkerf4rBnTFwswqhilMaLH3en5P83P58N1x32feGQy/Jh9RUjrBH
	dCYq9/gaJzuRcsf5x6CXiekQvIWZHGcy1xVXXRO/vLMUOaC29Fi9dU4tPazKRT1G
	yQhGomPyLUvxix4gegB4yA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bg0ckjx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:27:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46FDTIPk002702;
	Mon, 15 Jul 2024 14:27:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40bg1dshyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 14:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAjofMnhajxi+LTpkDzv54oUBYtd4sj4BpqqMKsGG5/Xb9N7/dZm5MUTz7qrsgjwp/SNbzOE4onAoYRRlr1GDDv+Hu2mJOegdpEqtxsan5HbcQrwU/ok7cEznVipR1KxfOwc0IZ//eypj4SaWINlA9WiXczcF3NuZWLrUEbf3bMYad+Br1N8X8QJZQnIgTRxlV2rHcwJTG0Qk/z1eTbBMrIXxYN/aAY8xFTq09IrGmYgiDubrdqEomMHOXvI+qnEfmPFDGDxr1iHb6bQmDW8ZhCUBIW7mwJZaDxjbrakPTipQhNj6kVKcHNoagdRiocK9tZVJc7xNEShBOXxwMzH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsOvKbdGSvcOvrMLUlu3ywVxDc6l8UEXwNdMQ/CHy+8=;
 b=ck+sbDXGtvaWiioXFVF8XQqbc7dY4GmYN4fTcsRikvb87cqHAn3IF8qdxsX06DnuBxTjUSIih/ngVNQvIdCghRVLMxeGZapI1m3TlBmiJfcNJdh0Xdw4K40QuVy1caS62NqkqFk5q943xbex4w9ZDKKuya/ypjXMqgAUXMI8LBa9gQS1QrXJQcPO5SLGFYNvQ4Xb486jEBqpjpoT5lNDVGuElPaUfmuV0QASl5kHOk+vPjk8PujzF/e+vp7SR0pLPH2nmkyY3CA8KXGXUVyC7xyISrjjWml8pE3FaZlvrF6FtRBh3vyn2epyU8ttGlgKIV04NqEIAOXsFugfGDM3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsOvKbdGSvcOvrMLUlu3ywVxDc6l8UEXwNdMQ/CHy+8=;
 b=qcsW4qd8IOp5Nhubw0/JuZ1zroytcO9i5q5UUKfNWt9j1816chIZOE3dq/fClHMs/4pb4dFt06+nDekZ6mUr6NajMPTASF5jCOfyIFZ9aBvP1Rtnj6Y+momeJnQlBaVZLW7I7qN735oBxwCKpQ29k7DdxiXvtlJArfkBDetOtoQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB5769.namprd10.prod.outlook.com (2603:10b6:510:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 14:27:45 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 14:27:44 +0000
Message-ID: <d8b1a0b5-2763-487a-a7d9-01355d608656@oracle.com>
Date: Mon, 15 Jul 2024 10:27:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/7] vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
 <1720790333-456232-5-git-send-email-steven.sistare@oracle.com>
 <CACGkMEucbri21SeE0q848O--yMVCtuT9ZMKUYgd6hLEqLGN7Tg@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEucbri21SeE0q848O--yMVCtuT9ZMKUYgd6hLEqLGN7Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b0237e-3041-47b7-f75f-08dca4da4aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U1VGSVVocjNFdUVVelZnS0hENmVIR08veHVmVldjUnBUY1lEUE1UNlNBaWpl?=
 =?utf-8?B?QnpjV1FBZEVKTVRGVFZiWElZdVJqYWxDREZ4clpBYnhWOENzSTNnVHl5WmVP?=
 =?utf-8?B?K2VBWHhTYkNxUW1kdWFuK3pQNGJIQnMwek1WUTJzMWQ1dExQNG8yNVR3UlRL?=
 =?utf-8?B?R01sakRFZnVkWFVTZDV3UmNMdjNocU5Nc3JJSDNiVm04UEl3RXZwWkcyd1E0?=
 =?utf-8?B?UmJMMWl4WUdmbjRtRzR3VGJhbTlIYkNhZXdoZzByRSsrY1A1azIwbWxUV1RG?=
 =?utf-8?B?MnlJT0c1NURBbEo1REhlMWRjbnFCWk1xK2ZHWmgzN2pZRzFlS0hxbi9qc3pY?=
 =?utf-8?B?Z2F2aDNkWnRXanp6M1diRXFXVUZDTkFGdE9md0tYRjUrNGYzcUlFSWZwNFhh?=
 =?utf-8?B?WlRRNUVBeC8zcjBKdlZTclRqUmVtQmJFN0U1cGNMNkQ5QzJSaDc0dW9OUDEz?=
 =?utf-8?B?MkFzWGxzbHNoamFjYWcwTkZlNzJLNk9ndVZJMGpzZFhmNU5JRnVMbnN6YUVU?=
 =?utf-8?B?TVA5dzhpeFJxdVVGMy9QRlY2bEJNU2tlcGpBREs0OHNrb1F0WFVrNFBFNk1F?=
 =?utf-8?B?N1FyQVNpN3FqMmxVeGFhMERwQWxjY3ZDQmJWTENKR3R1Z0Y0MGtTNkxvWEMz?=
 =?utf-8?B?QWhsRkZieUR0ckdQS3gwU0VkWC81aGVja3FNWTZkbW1hYTQvNXRicERHWVdB?=
 =?utf-8?B?cC93VU5HOGtiUUtCa29VUDdMNEVVZ1Y2MzN5ZVRybFhoenhVU08yR1loa2Vi?=
 =?utf-8?B?emllRE51ZU9mQVgrRWZFNVpKZ3dZaDhreUs0aytjcWMwRmhDVWJRZ3hhVFNR?=
 =?utf-8?B?aFAyblpsdXFuNllFRHZWWks2TFI1QlFkMldUVENrcGswdTNuTFE3aDNNd2hH?=
 =?utf-8?B?WFJVdXpLQWM2TURON3JVNHVTRG14OXBOUTM0OThMSlJtMDF2eFVFK1RLZEtV?=
 =?utf-8?B?K25OTVNTaVc5bmhDVjZwYmljU2VqRk4waUNpdXBqekNjK2dlT2dJYzFaZXNL?=
 =?utf-8?B?alpDSFNvOC8yd3VqRkN4OE5ac0kyc0hGNzk2NFkyNnpaZUFNNmxvL1MyTTNU?=
 =?utf-8?B?ZXlLVUpUR3p5T256Nisrb25aeU1jam9QckhkaU81VDNXTWRJVWJTZm9OZ3Nx?=
 =?utf-8?B?MGNHa1k4MkQwbUFpWUVYbGEvNHFzVWt3OGltRlFSQTJDNXlsVTB1ZDY2UWh3?=
 =?utf-8?B?aEtPWmNMM3NFcXVGRVVlU1dSUjROY1dyU0hDWHJySjZnRTU1SVdJVSsvZXV2?=
 =?utf-8?B?SHlxYm5vZGpzMFBtKzcvemUyNlFLMGdBa2ZjdVE3K3RINWhKU1dlL2EyejZ0?=
 =?utf-8?B?L2J3UytzOTl1clB1cWI0NWt6Vi9BZEUrRXcweGErYnpKRDcxaElKVjZvZTZE?=
 =?utf-8?B?SEhGKy80NFpuQ2h2R3dXRXR3KzNxMVN0RVRFK0hTc0crK3RhOHlqSkJ5bGFt?=
 =?utf-8?B?a0tlZ0crL0N6R1daSWphV0xOT2dzUTZ0NzNqNHNObTlYd1R4NHloUGpRakxh?=
 =?utf-8?B?TEYya3Y4WmVobVVuaTYrSkhkVTJCMTRCYzVUSXZKNzd2em5vZFFpOEl1bjNo?=
 =?utf-8?B?ZXdvU3Z5UE1NVU4xN3QrTmFVMnRqUjBPa053TVBWcnNZU283SmRZL1ljcHRI?=
 =?utf-8?B?c2IrUEJrVklNWSt2OTNwQVVIUk4zVDhLQmlSemorVWptNVNWY2p1VXFxbVNt?=
 =?utf-8?B?aGUwbVhQdGhVOS9xVDZBS25oRnBLaTQ2NERKOHpDZ0UvL0RWQ1ZLMjNIRCs2?=
 =?utf-8?B?OHkyMDZIblJqQ2R3VEVkdnE3eGtGSllQMVVUcktoOEdUU1N0S1kzWllJL2hN?=
 =?utf-8?B?Wldic215STBINGlmUzB4QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVA5L1hTazR1UU5Ndzk1OExKVHVWamNJMjVOSmhIM2wwTmZTQUtMelUzWTdW?=
 =?utf-8?B?cVhwNjV4SG5EcHZldWFnWitzU0ZQRFcyV0RoV1Y2TTZvZnBDSjlQa2pTUmUw?=
 =?utf-8?B?cnVrWElkS3FJRzd6UTNxei9OZXFHN0U3eS9lQ284YWk5M0JnSElLaXFvN3Z6?=
 =?utf-8?B?SSt6eC80THFFQ2g3YnZ1Q3QwTTREUEMxamI0Q1VnVGo2a0RJU0dxcHZRYWRj?=
 =?utf-8?B?bHZycHl0VmdNc3pRWDFONUE2d2t2dnQ4TGFNUUZwQ2hWSkdCMFFIZU03K1hM?=
 =?utf-8?B?blZ1Slg5QjU5NnprV2QveHpTaHFVcmQ3L09ISDIrdTY1bHVSdHgxRSt0MmI5?=
 =?utf-8?B?UEhCMEk3TFIzcUJTbnptdWNGVmV6TEFNQXJoSWlMdEtpdE9NeU8xRy9yQzFB?=
 =?utf-8?B?TkRtVkltNCtLbkJ3SGQ5SFBXb2c0dHlzbC9VMU1ibGhMSUdnYTBZMVlJUjFk?=
 =?utf-8?B?LzNPaEVyLzhRZDBWcmdxUTV1RDJrNU9UazFjdDhtbkd1MXhkbGwxK25WcnZB?=
 =?utf-8?B?TXRQQVU5aGpVKzZPMWg2WXNMVVU1cklRRkZHU1dyajFTaXdaanhQcGxTL1dn?=
 =?utf-8?B?RWlvL1BLNWdEa0hMKzBUM3IwODZwRDZFQkRYdzZvNVdUN29hYXBkRXRtckx1?=
 =?utf-8?B?WmV4eDdmeXNEbGpzdEZNejUzMnVKVkdvNG1Da0tJd0lOK21RQUdNY3c1SGZy?=
 =?utf-8?B?NzVxU0w3bHhSNE9NZ09FOVdsTy9WckV3MjFJMW1LazF4aWlVcXVKOXozajJE?=
 =?utf-8?B?YklIV0ZibGpUZVhYQUp1VkZxT1ppUXJTM1NMNGxyS1RYcUxoTjc3eWtqQktu?=
 =?utf-8?B?Um9xU0Jab2pWV1NBeTRLbWdlM29sVnQ0T01Id0cyaUk2TlJVWUtUNVd3ZVZk?=
 =?utf-8?B?bzFhcmZjNURwTjhzQnl1SWdHVGJVbHpQVERtSlliV05pYlVVUHk5Q0ZBS1FG?=
 =?utf-8?B?RCtORC9RUmlUL2NxZ2ZhbGJSaFkyNUI0N0VyWUhsUUtoLzdhbCt1Vml5TmhT?=
 =?utf-8?B?aEwwVXlWTnZFMXFFdW81WVVBRVFkRS9wTGhwbUZlVXp2RlBsRk5VSEhVbjZR?=
 =?utf-8?B?TitpcFBxaFJYY2pXWHFLaXlITU44aEphRXB2bzU5TWViQ2V5M21EMWxYSFRq?=
 =?utf-8?B?eTVnNllON0thVWhKZ0MrbnkxSm9rWUloT0JJMUl4WkVZSzB0Zk83QWg5STJw?=
 =?utf-8?B?OW96aWFZTE53d3hhaTBMTFJYMzVlZnlyZFhacStnMDdBNm1zNTVpS1BDYVgx?=
 =?utf-8?B?T1VYSk96dCt4dzRNSjhYdjRDYVpGMksweHhpYmNBOUR2V0RYMER3ZWVzZVo3?=
 =?utf-8?B?YmhXYjBoakxVMllpa1Q5RVN6Q29meENwaEFrb1d4NkJuUGNLMjlhUzJTL1Zy?=
 =?utf-8?B?WDJPSjBuUUJabkZZMkJmcDV1dHAyWlArVGxVQ2w2bFBHTjN6SEMxNDFaVFR5?=
 =?utf-8?B?R1c3S2VVazNBRVgxeHBXbGwyb0NkbHhYajBTdUEzZVRpdUxWRS9NNWFCUE5o?=
 =?utf-8?B?bmVZSGJnTHZFYzFncGFQcmZIWFd2bU9GWTc4eXBUT0FNZWZsdXZrSk5CNmdG?=
 =?utf-8?B?YzZrMkt1Z2FpTzdCL3paQUtFWjBHdzhYVHlwRThOUXk2YWVYTERXd1dWUHYy?=
 =?utf-8?B?eE5yQUhPMXZzWnM2MzFWWVJLVmU3QnVRdzBiSjVMSEVrTDY3UGZaK1g0MEdI?=
 =?utf-8?B?QkVlZUZFTndaSC9JMEo1YU1nc091K3N2azlxaDBSNDcya2owSFUrR25PNW1Z?=
 =?utf-8?B?SmNiZk1GWEVBajFzU3U0aytCSnhBWHptalpRNC82REhmWTRsVkw3SE9FbUtP?=
 =?utf-8?B?RmVrOHdPdk5Db3gzd3A3NW1FRURmbkwwdjJ5MmhhWmo0V1lMdTdMMU42RU5h?=
 =?utf-8?B?UVhWSXBIZzNsRERoekg2YUFiR0NTK0Y4enBzU00xeU1wdWZXVHZrYlVCVU1q?=
 =?utf-8?B?SnNjeXErKzc4dXFGZFRGS1BJWnV5WGZET0dYMm5yakpYNThXM2dlYnlFdFpQ?=
 =?utf-8?B?aC9ucjVib3BzWVdLWGNtQ2xTNDY3OUg3ZHEyeHJMWEhwcXR6SGdreE8wMCtT?=
 =?utf-8?B?cEtRUExpdnlxMUNlQ1YvQU9uZXozSHhsN1hETHB1V09pUUVvYWp4a2xZblNm?=
 =?utf-8?B?NUxLN1B4Sk91bDJHNWp4VXc5SG9rVG1CaTZaUzViZ0xDUnhxem93aXNSMjVB?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	U0ikD02K+sU0RlqBVzDaXM2jBn4Hpji09eeK3mDmmHyGx35E4KHt5X0isbUIJMwQUMN1sUfDzcrmU8mH/y61vjbEV8IkEyqAlBoO4fySyn9WREJIlOFDh2Y87jNQOnjxyzzv3JDUx37ygjJcbQNMW/pX2Z061aZru5yAbapBrotF2Yl9vj7ddrlzaV9FG8DrxpNa9g/Oxc8x/Jhj5lWpGqDa9FdblE4igCTW/LEDPyngiRlknkKKkGc5g/Rj8g7U7jNDTaDqlum9FF/gCYxn8xM72dpV2zIP0x2nnnl/xOgKaKrl1dA5BvEjr4NJWDq9I75gg39VDngj7wyoiCWkb+JP6tbKCqn+XkBRsW4sjrF+0m+4HsT8fr/LjYVH82LHO9f4lLmf+55vmShyIQWGEDXSdkkU/52XgB6UaP17V/m4Fzy/rDSpdUME6Jbh5R/T43VdHSqk5o9Tvku+I/CSg4mzKCZIZo63FU3KN1T3FFr1eW7wEkNDLq3CmrZRNiyYdpKc0js/Tts+WZNUs4zhecKxCSeIcubXF+L/dNNNd/zwj/VysXMt7TCw6lBg4vg1+yItRi0DbQ/jfo0ajEC4sKua8AKjTv/U+BYGT+w+1G8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b0237e-3041-47b7-f75f-08dca4da4aed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:27:44.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85GZUgJ7hcra11lUgmQkihKobDtYkk5yit0WucvMU7884GZ0wy9ziYrmrgtWprFFOe3xfJGqn3XSI9fUH03Utoyi8eb7DaMQOuyoCVcKPKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407150113
X-Proofpoint-GUID: My51ESTN_nOCukEoRRdy2jinVNzWGrnt
X-Proofpoint-ORIG-GUID: My51ESTN_nOCukEoRRdy2jinVNzWGrnt

On 7/14/2024 10:31 PM, Jason Wang wrote:
> On Fri, Jul 12, 2024 at 9:19 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> Add the VHOST_BACKEND_F_NEW_OWNER backend capability, which indicates that
>> VHOST_NEW_OWNER is supported.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Doesn't harm but should this be part of the previous patch?

One developer's minimal logical change is another developer's gratuitous patch:)
IMO separating this one makes the VHOST_NEW_OWNER patch slightly easier to grok.

- Steve
