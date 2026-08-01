Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9D35202B
	for <virtualization@lists.linux.dev>; Sat,  1 Aug 2026 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567571; cv=fail; b=QDf5ff+lgQo/8/t5xHE9GdzPlL5mQY7xA//I+5suAF2QIQRcpRlooGe0Hl5B5F7d2z2SXFtMzd3bk5+wZfLa2RfCcsL+5HErI2GtVr0onja7a0/mU5W7C5RnvwJZVmMlNLrIiRI4Zh5YIAlX1Kpz7Ek0dXbuumbe+EBqa1p4s5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567571; c=relaxed/simple;
	bh=hZqpf8UwyrUuCB6iDOGU4W150DvS9zNKyesFyCrN4tc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=orJdglroGL2YkJNLfUS87KoabHzB5f7XgoeH/I4kpsKkjEWp57kRxRPoioPYz/kKP7spJzbEzlpmOwXc1g0/UbHybCSwnb7IAfO10qExdS1YLlrWaIUFkGOcVuCZumewUGfL9qtSwPYMop6EMB9EhZlNb0QOhJEzX1QSlQbshSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gxAU+t7O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nUsts5ns; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gxAU+t7O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nUsts5ns"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6712Xok11128942;
	Sat, 1 Aug 2026 06:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lc0tMHryV8+KogpKTQI5U47yKHiVEWlCRIQ1RyAwsyw=; b=
	gxAU+t7Oce1IxNTuSDBn3oFbTtCGDWfdqvPaBjZqAUIczaYPTJTNuqaFkh/WEz8B
	oYg3jTTCc1a8dVm/uGh+6vm0LZ5d9xsEFzFukgfFkL63mHF2PpvyvxT0oWyDEnp6
	NU0AkXG3deU1UYJCBZbij/9hOWHNlC86knZ5POsa4uqB/cJvLQaJ8Zwtq5J+peu8
	vbwuzEFe4IfvBck/HCeq0eyHn1twklMmJX7XZEstyIqr9yNY4jjoJvL72Sc2CsF5
	QrTvHqOLgxdG9R4SpQ9mJrsIBkNsrsaC9orv9QdfWoubf8rPIqJ7lbOWZcHuItXN
	mqVZMEVUN9LeYYafvKxqgg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7k38tck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Aug 2026 06:59:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6716tXOa037368;
	Sat, 1 Aug 2026 06:59:27 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78qdsjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 01 Aug 2026 06:59:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMf9oZutuBSt72Oi0FTRxHNJI5egjjhLtxNvaMRKLMfHKJobWJL/VgqAgagsXRkHlgtnlEtqXDcxZR1tIG/TjA+Cn6tEwGQEEHiWtLaVeURUJJqSXla24etxN+TXPwqGKrmqreKJicjAe5K8+5hWzz3IBAYvXAUJuF5t+0pE/c2hdPCr1saf+pdMIHVqvDzOTihxDz+eGY4E8db1VOASXpHoCgcAXiiEdramlr73vvTkHgr5gK8+HLuVtDjBfzSoMtaIzXlIcYT+YV2smSwZs5HmALL+ByhjafXNYggG+6mfU171iGDxDz0B7Hv6q2Beqvc7uh6zNhgIvDzrRebhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc0tMHryV8+KogpKTQI5U47yKHiVEWlCRIQ1RyAwsyw=;
 b=fy9WsgsDH22TK2eJeABtNp1biPOQz73AdWuqX0v7JLnwhYGkclwfldopXI1NiStuAFIxqaHB9APZGBT5OVdc//Dx9fwy0Dkh0HFpnrTL8d4SmqPjQ8e6d1CHXwSfySdzdQ4AAg4lJ0SG9LLQTpOAlYIjE2tW6mjmO6jPKBv0zz61qNACdeQU6sHSxg9JOuROG56IPB6CObVSjGzOKAjU4jpKSrndiy/MORIhgDJoCLcQdxmTxIDQCPQhCFpWyV9fCGTar6r6srQIY26UX7nkUQ1IMhhhkfTaafXz42B/qYf2kQCG5wh7rdPJxzsrBQ9RRv/n9FmGibCFhhsSQ6Neuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc0tMHryV8+KogpKTQI5U47yKHiVEWlCRIQ1RyAwsyw=;
 b=nUsts5nsPunqr0WgJqUgsk0mW4oOibbip5SS+8fqEQDGgG8BYFnZn6GbtZwbkLlJDJc1khZ4oKUBtBHquxLROYOL01jaX2msqvP4dtCAHKKQ2mosd1pFPxi6MHR8VsU0ebdwHzIMksp1MWoYsnGhDx1H4pwp26lQ+MRKVphqNAk=
Received: from BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 06:59:23 +0000
Received: from BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83]) by BN0PR10MB5109.namprd10.prod.outlook.com
 ([fe80::d9fa:7ad2:804b:bb83%6]) with mapi id 15.21.0270.015; Sat, 1 Aug 2026
 06:59:23 +0000
Message-ID: <d24ab42f-fa00-4a5c-b987-c05f6a9898f2@oracle.com>
Date: Fri, 31 Jul 2026 23:59:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vhost-scsi: reject invalid max_io_vqs module
 parameter
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowangio@gmail.com,
        michael.christie@oracle.com, pbonzini@redhat.com, stefanha@redhat.com,
        eperezma@redhat.com, kvm@vger.kernel.org, joe.jin@oracle.com
References: <20260731221116.236791-1-dongli.zhang@oracle.com>
 <20260731221116.236791-3-dongli.zhang@oracle.com>
 <20260731195756-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20260731195756-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:510:23c::12) To BN0PR10MB5109.namprd10.prod.outlook.com
 (2603:10b6:408:124::23)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5109:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: d73eaeb4-ca09-4d8a-e82b-08deef9a6b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|10067099003|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QsGww8AvGphZ1uWpAwVnaTSqXbeNGeQk3BKlkgTY6icaaY7qygNNXeqgUG0UNKWmTKOxEbEqNHJ0bkDCzvYvi8eN8nuhFfAPYxZm1zgyNRrWZ4tN33Y65/v2y2/0YqwauZfCdqNdCZa/eDmwXxYcXgqw1xYYvhxi6o7m8qYbzGCgNXVHa01Xd42gxi5aicgpa6RJfHeQMdHwzpl9t2hztxmtk4jPWyT+ETJi95NDcCCDI/4eh3NnEUM9+barh6TFOK/FbgZh8bjGqkgSq9cDTjlXCMTy+v5FDDfKuLb6I6nT3bR/IWaxEZpffXraxpluNslVL/0gwxPyNT1a00yVjpTp5pg4iMkiDE1a8OxYqxnZ/omd+7VkkzDe4otKjWRCnntEbInBQDsfNKfU/53vBGeZqIdHvyak9+8sL2UrJ42L0Csn/iT3fsmT+prYNUW62dqk/ynBeR0l2PuRrJJtKMT69UiFVUKecvHee487MLKyXrxUKpNrq4vOhuzVeVEJWx5HXB+49Je6IcA0ftI0z5/xZgDv3EvKP/2IBlGAdpdpbsy/kyMZByCecWm5U3olrndziIVWaAPs9PZT7Bf5R49MXp83Q+1lAZrqDsEfuiD+1VWBeHr1NJfekp2RnI+IwNK6p/Jo0kBtKZ4c51cUs7mMqgprHWugGZq5duIRjjk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5109.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3dXYnFYcit1MTZRcUgyb0dpWTlRckl2UldxQTgwSnJHL2N4aldFUU5FVS9Y?=
 =?utf-8?B?WTZGdHZoWXNQWlQ1c01BQXNubXFhM1VhaHhlNUdBYUJjcW0vRVA4c3R2QlVR?=
 =?utf-8?B?bE56RExvZEV3NTlhTUI2L0pTVStidzVxaTZLbDFGTFNmVmpuYWphdmNNUmlE?=
 =?utf-8?B?emdLZzB4QU1rRUdjeTNOZ25OdXMrREVrM1YzYTF1WFh1bnVMeTFJdE0zNDZm?=
 =?utf-8?B?Y1Ixekc4em9iOTRFMXRza29EbnkvWmZJcEhOSkw1UGdNQTVqUFRRUkxueTR5?=
 =?utf-8?B?QWxQVGxRdUFlWjNLYzhIWTExbGRIdG03NUZiTG1jSW9YNUNpRmNOb2pVNXJW?=
 =?utf-8?B?MWFrK05kc0g1RVdnSEd0RDErZzVyN3A1NytmSmczWGtWVm90RWlBajZIR1lY?=
 =?utf-8?B?Tk5sVlJuVUpRWXVhRTNtOVVYTlNnUXlqS1B0UWl5M2NiRzBBM2ZEeVlQMlg5?=
 =?utf-8?B?NW03RVNHeDAvT04wa1J2WHRkYkZsdUt0VnJzVlBQc0c2RzhtY25zb3hYVnVn?=
 =?utf-8?B?YnE5L2hHeWF4K05FSHZOVDRvMDBhQ3VCNDM4bm5NcitDSXkwRURXUnJBdVBH?=
 =?utf-8?B?dnQrZ0JpZklQWksxR3UvYzAyZDZmLzgzTURhaFM1Z0FlWTNqUW11ZEIzYkJE?=
 =?utf-8?B?enJld3lTN1JLQVd3RHovSHQvY0tzVlFzZ2ZpWnlFVGVnZGFySXdHZUwrOU9p?=
 =?utf-8?B?aGNsWUdyOVo4bU43TVZhZmwxTTg5dnUzeHNBMko2UkEzZVFxZmUreXlYUlFG?=
 =?utf-8?B?Qm9iNEZHemxOR2xsUVRPTW9hblRwbEpuTkFUYzcxMnZraXZML3Znb2MxVkox?=
 =?utf-8?B?Z2YxTFNqRDJCZDgzOXdkT2VDOGhUT0QyU01OV0MwOHhManQ1UjJpdGJhU1VC?=
 =?utf-8?B?WGF6bWlQMTBzeDBqbzBuOTM2THdlQVNFVUNKQkE5ZjgvL200dmx6NGdGQ0pF?=
 =?utf-8?B?WXhlS2NBRHh6RWMvaGN1MTNSOGx2Z005WnNaV3llZU9EU0JjZHpFU2xIZmts?=
 =?utf-8?B?b3dOY01VMTBNeUlUSm84cEprdnpHb1BSVmFwQjFzRGZJOVFGcjJQR2k4VTNk?=
 =?utf-8?B?RzhaSjRMZU9yWE5UcTU0NzlBUWMyOTJwT0U5OFkvbGZZZ29USU9leEhqMDB1?=
 =?utf-8?B?bmxBUExVT1k0aHFFU2pReDV2MjJuUzlWMDV5RVNsK2xpb01ZTzMybDZoc2ZF?=
 =?utf-8?B?bDRYSkIwbkFSS1FoTndOeUc3eFdSUUhqY3ErdnFMZXBJZFBrQjZTS2xWVFRO?=
 =?utf-8?B?ZXBXWWZJYWVrd1pTRnNZRTNaMnFVRWJFOXQzeW5nR1ZrTmhiT2JXVVkwYVFW?=
 =?utf-8?B?N0p5T0tqTjJDWEl2L21MQUxDUS9qUHE4THNYVkxXbTRCRThUMVVYMFdabWwz?=
 =?utf-8?B?S2RSUElNdWludG56a0ZGdStvWVdHS3QxZGRDeXhMenE1S0dqRWkwQUNkUWts?=
 =?utf-8?B?TmliSEZzVHZydXJmNCsydG14NmZHUFdIVjFYZzgvcVRDdnFrMlQ1aVRlZGZX?=
 =?utf-8?B?RlczaGlMVU16S29Rd0w1RXg1NC84anpKS2luZXI2aFNwSmRxSU5SQWV3eEdj?=
 =?utf-8?B?RlpRU1NWNlNEQXpsZzVnUWZTdkxrMmpRN20wZ2hta2d2VUJrN2ZxUWFLVG9K?=
 =?utf-8?B?OWpPWWxkMFprRGs0RnMzTmt2NnFDMTJrNVVEM2loYk4rSlN1czVmUk5haHJi?=
 =?utf-8?B?WGhGSGVGbFBScjRsSzRSbjdUTEpzdGRvUVFRQ212OHRTbHFPKzhnRVBtLzNt?=
 =?utf-8?B?SklxY0N3R2wxVlVQYWE1QUlvM3VvYWdrQ0pqRXovWVk1amRONmxaTGtZMVVk?=
 =?utf-8?B?Uis2b0IxaHZHOXlLeXJvUlkwUGhlcGZZUmgvWnY4SmhJT1hDbEhLbHhseUJP?=
 =?utf-8?B?ZXBFUkQ3cWxrTTd1cE5WaGpvQWs5enFJUy9HQTljb0hvSWU0OVUwKzlLTFA0?=
 =?utf-8?B?akNRUVVUMjV3SjhPQjk4b2dtbTJkVUx5V0FCME1ia2tUSUNKUzhDbi8xeWMz?=
 =?utf-8?B?UmNtSHpnZmVEbDFHUFBuQXBSTElJSHdKNk1keVQySUxBQ1NUVkQwclEvenpl?=
 =?utf-8?B?VmZ5eVpJcjlFQzBuN3FkWFFrZjBTZDU2L0Q3WVNQMll1UjB4N3p3NEtMTCtX?=
 =?utf-8?B?SWwwZkMwTXdqcTJJWFR4V1FXcm1sZitBVmQwazlsWm9DTVRGUjB3bWR4UmdK?=
 =?utf-8?B?Z0lDa1pjMHdrbldpWFF5QjQwVUF0QXdzempVSXdrVHJEdmlEWEZSMzV0aFAv?=
 =?utf-8?B?cUM1NmNIUFVFcDFnK3QxdnQ0UjVvNWgwVitnejcrWFFPQUMxLzZOTWVncDVa?=
 =?utf-8?B?bStKRXlwUEhqUkJGRDJrZVo5ZXBVbldKcFkzNFp3VXM4eWtWTVNYUUJ0WjVx?=
 =?utf-8?Q?6erF5XPPid4ynKdA=3D?=
X-Exchange-RoutingPolicyChecked:
	ZUQAZsKY6aTjUyhqrOYE+uMDsdqb1Hs7JnJJ9rxBQZtDSEHtIyqDL8NtRVyCNn4Bw4Rq39iHatDxMseARWrxZBFVUh+28gemkZyH8b0gIrlcEwp78bKsd510yq5sBDFubEQT1fStS1/QDF3VCTFW480bpUCnAd76gVToifAeUtXfpVaXAhQsVMZDTY8HrWEgb1/xxeuQAVH+zEBFI4eA4NWaHnMuM6ZU1qfTwBy8TXRbjbvhGE/OqcK6ssvVAEiTgLuaOIOG4QlXmtGa6sfbwa8nyzhccIKlvq4mVerh57tIH/J52EXcFkQzwYIwbPzNv7xDe7LtdO2T4aFTwzhh4w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kS+AKwPpSOINCEvL+6PH2vEKwEKvkysVzFkoUd+DO6mXnbyvdSv5LzNqdrDQ2q4pNt283xA0l/v1TenAD3gSAcqbxkfFH66TI7ezrak/b89qdbW+4L/Xukg3C1VX/Vtusc19wra9yFQJldCfmxv/P4n3IoYGS+7z1fGuglKeNerXB0q7I5ppGfRg4NAHxP3wAPPHbelxEsERXodFqt9ZVz9mPYyQadSLpojBu4e/sGb7KVf48rao9u7rOfoXJlPM7OLs4DgAA60lrTq4+3LZpE8mbKOAlSZxYW0hIfGN3wfhRm34qFwPrn4r/WXgATV2IwuzA/j2fSCH9HJOL0AHWQ/R3rLFeDVFxMtrGUqwatBY4LnOnFDfE+V6PP188AsNVYCEnFnek5prZCalgpGSUKXb1zWSdPvJNCWjPwbMLKFe00uqNWL82unBQWW0rGoGZQkAOUoy1Synh/kdkCoI+t2HeelB+t8jX7I75YZlE3EBjRoob0ndGJp9m1Pd4fQ0Jq/88hRKXOYijR0HF0b8l8mXhFLvn9BplZWuEwaE6BETfE/7B+7bJRksv4EB7anRdNnkiJLpeZLI/SRSowRLVv8CveEiqlMwtxDf+LFPgIQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73eaeb4-ca09-4d8a-e82b-08deef9a6b11
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5109.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 06:59:23.5549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IbvCXXgMVW88uC02Kd3qkwagi8g56Rv01kVmaB6bDBGbsk/F7OiKS471Qa8OLym+JlyL1w5C/YgRDBh8ZylDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608010047
X-Proofpoint-GUID: sP0jXFw5Umy9o4wHhQjuxXi5o7iapHd5
X-Proofpoint-ORIG-GUID: sP0jXFw5Umy9o4wHhQjuxXi5o7iapHd5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA0OCBTYWx0ZWRfX7mKcGXwAVLaw
 Gp/QodjVMhroRROJmYRHv5bLgqY3UwsOqZ0AjzwQ9Nu71syeNyX0ZWtyygv/pegCc/rq33efhD9
 D9zZNT5DCc2F+EPRnK7uqwhZptMx/aXd2HKdhploegPlZeEHHhz5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA0OCBTYWx0ZWRfX40iL0NCEZUiU
 P3wcXxPJt9CYk9YJ6Y9O29ZAPNOqDUnIN7kZJSljSy/K/eo6JrzeRySFbqnKUqEwGepKYfTUvEe
 N6TwYgZE3/hpDVx8hRKX+kNbC8cxz8uyME3xoc6rhwgkx1eO7w6DBQqLzpaRQbRZuzS38O9QJmq
 VEo8aK9hY4n297D7tbKeqdgJV7bmUw64CVjMmwv/X9ov3DibUgYM3st5jUrDuXM8WmgvOTjQl2D
 ElXTDqO0pMdFKv4HuNPoKWjcjG2yhk1u6drQPDs+/kcct74gSbe5Aoy69L8j7HS0ksYRHat7K0K
 wnuZMdx3EjCq3McxODsj91PdWsaO4epFJdCzH4PXK78+NJVIj8bt054yQdn5w56XDFe4i5VqVCT
 +q6VFM57soSCHLM/t6xvWQ41Z+DCuIhY8cigq08CvPEfttCYJ0jhovtTuO+zfNd/E1ySJ4AGDgV
 4aFwfHLKvnWU2+jPXggNFK08wd15yDrZW1BPGVwc=
X-Authority-Analysis: v=2.4 cv=Iqcutr/g c=1 sm=1 tr=0 ts=6a6d9950 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=wWHP5sqHqZArG8G9kJgA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107



On 2026-07-31 5:00 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 31, 2026 at 03:10:24PM -0700, Dongli Zhang wrote:
>> max_io_vqs is currently validated only when a vhost-scsi device is opened.
>> This allows sysfs to show values larger than the driver will actually use,
>> e.g. writing 2048 succeeds even though vhost_scsi_open() later clamps it to
>> VHOST_SCSI_MAX_IO_VQ. This makes the sysfs value differ from the value that
>> will actually be used.
>> 
>> hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs
>> 
>> hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
>> 2048
>> 
>> [  315.630495] Invalid max_io_vqs of 2048. Using 1024.
>> 
>> Use a module parameter callback to reject out-of-range updates when the
>> parameter is written. This keeps the visible parameter value consistent
>> with the effective queue limit.
>> 
>> With the parameter value kept in range, remove the duplicate validation
>> from vhost_scsi_open().
>> 
>> Invalid values now fail with -EINVAL at write/load time instead of being
>> accepted and silently adjusted later when the device is opened.
>> 
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> 
> why should we change userspace visible behaviour now?
> 

Everything started with PATCH 1/1.

The original purpose was to resolve the memory allocation failure addressed by
PATCH 1/1.

To validate the bugfix, I increased max_io_vqs to see what would happen.

To my surprise, I was able to increase max_io_vqs to 2048 even though
VHOST_SCSI_MAX_IO_VQ is 1024.

hv# echo 2048 > /sys/module/vhost_scsi/parameters/max_io_vqs

hv# cat /sys/module/vhost_scsi/parameters/max_io_vqs
2048

However, a value of 2048 does not work when creating a guest VM with vhost-scsi
because vhost_scsi_open() fails.

This behavior is quite confusing.

Therefore, PATCH 2/2 was proposed to avoid confusing users. If 2048 is an
invalid value, then setting max_io_vqs to 2048 should fail explicitly.

Is this really a "userspace-visible behavior change"? Without PATCH 1/1,
increasing the default value to 256 could already fail because of memory
allocation. Perhaps this is a good opportunity to define the expected behavior
of max_io_vqs before more users start increasing its value.

This also makes the behavior of max_io_vqs consistent with inline_sg_cnt. For
module parameters, it may be better to perform sanity checks when the parameter
is configured rather than at runtime.

Thank you very much!

Dongli Zhang
