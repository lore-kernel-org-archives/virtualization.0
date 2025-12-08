Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FE225403
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210706; cv=fail; b=A94urYJGvx+fHxRO3Heom+FxRxrdVzOU/AyT775Q3ZdVhwjD8/UpNhPWGfc1fc/aF2WST4CK6X6UuP9eKz960TnHns2tLNI9kJ7RkWCUZEGYKXN6GEOd+C5i7zREpggV/O5WHbxLjDmsSDZjgsL0Qbj9J6ODakNAwm8f6wOeaTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210706; c=relaxed/simple;
	bh=5qY5sF/UeCMMPwhQs3pkXgf2ydPBZBXW7lRgw++1MSk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBAyOVxxBfZyNDRQojoCLv/GqfFTFOLFt23tA6uEoJdMRrCSq+iaoYbUALUvd6/xt/e4U5NbCadO+1YAvAjueXQ4667vpkhSwus2f2iFUie4MKiSsNFlJsKppZFH4mROT0eXKRYqCXz86MTuoXK3b1I5E8NONz45feqEiFZ3pwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KNVb66yI; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KNVb66yI"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 397CA6074C
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 16:18:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zyhSRQv0neL0 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Dec 2025 16:18:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=mgurtovoy@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 743BE60721
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 743BE60721
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KNVb66yI
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 743BE60721
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 16:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgTecJxajIIC/ug2P5MIV+OnlYAzu7yWDpiDlQ3v+GW8sTvo3IWnScMMP7jjES06xliKCv54x2l4/OK6z12isFd6NCICY4uXKFLkeNFJz6y+84FtnS2wemIX8SufD2hH/4PCt1NjI2p/qSrvfmlakSC5PulPXxzGI1j04nrTOYAvwic77YYn5B4Pu5wjr0Mt9h2Qd3bGMDUxUPmzx8o9nnm5Yg2XboCh80HyUwQR3fUFAY93MzTWR8uZEOBzNIx7l2C40bCIp8IrSVWjg02wIedRAnpLTZAiN95VGNDftUHxVQRd9F7AhKrTUiWZcm351L1Kk9Jsftk0fg4zWgUw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWl58L9A6piVlQcOzTAIUzJsrinkPE8I8hBb2doolAk=;
 b=fj6/pDU/V/hCgzVqbcyzVTZKb4KFIkSq9Vcb8lomsyk7mTaPpQ7+Xt5I4ri/csR4PucHeAHne7Nt2ybpikjr+7I089vXG7AxfCsYVMLO3mz6ukX25jS5dI5sI5lf5JVr6GwxwzwcTCcUPM+F366BR7Du4VhjEUfrZI5bTDHQMeTpBJa3FJe2ZVWj6+Qlq95z9AkcKVRbIGMWaG6egHrk57rzQKBq0VZJfnnmU7BMuavP4Oo+MzNqqA5tDuoJs5idLmcItbZ27AJVmHnSXdB53tfo0Uitlc5KRyHpy7wQTHLwOLEhEIbfBjAy8oc6ScmKxNE1ULOObpfzWk1PhS9okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWl58L9A6piVlQcOzTAIUzJsrinkPE8I8hBb2doolAk=;
 b=KNVb66yIDQX2heDXUehX3OsKTKA02L2XAWMKpaWbdrauMJUkNorpPux6oDm+0NQjoQtWU0p+nIkvuUyiw391i65kDAjUgMCVQTntdv2iQbevRQwaBuXkTd0sK6uaG9tRezjZm4rEpUtEjmcj/z+zsMheA+h8ZZrDt7zTQdwdCPqkdUffECTUb0JWa4KJ6U+LejpkEOXjzGdRxODdX81HQrmVGKyLpuOmJK4g9TaMPuW99syg6hOvCkyHv31KticZBvYPIP9eZCQSuDMzmvXK9a2FlFEAjj4AcMrE5RbRiZLLidp3lJqKwDQwZpiByQcKyTjBTP706HY96Q/VAPJD/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 16:18:20 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 16:18:20 +0000
Message-ID: <7c4f605e-6faf-47e9-a920-3d7f782e9332@nvidia.com>
Date: Mon, 8 Dec 2025 18:18:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio: add driver_override support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, oren@nvidia.com,
 aevdaev@nvidia.com, aaptel@nvidia.com
References: <20251208143925.32246-1-mgurtovoy@nvidia.com>
 <20251208155412.GB1346548@fedora>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20251208155412.GB1346548@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::6)
 To CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 8563da21-6c19-4c29-9b95-08de367566c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzZYYkU3RlRKUm1Tc0Vzd3pGdXFucFF4R3c3ZVExYkVqMW5HMm9sN1ljdVBH?=
 =?utf-8?B?ay9DVDRHTllBNGJiMytkWWxDRWxKeUVHWlh4TGYyR1FoQnlhdkRkWkhoMXhZ?=
 =?utf-8?B?NGJEUFRtU0VWM2xoWlhJWkVrZU1rYkNtaDdTWDFacHhlTmhpbzZqRytYRmta?=
 =?utf-8?B?cklzZHEzQzhseGQ1aFJLaGg0Y2RQSTAxdTc1RGFEc3E2b3ZiVUwyT0xmSWtI?=
 =?utf-8?B?UkFDZTJwWnZXUng3WGpqWWRQc0NNalZEQlVielV0c1RRaytNeGZoRTIzTThk?=
 =?utf-8?B?ZlZ1ZDlDUFdDUmdlaGlVd3g2TEhXcGs2S2tvSlRDM0ZxNHU5cm93Z1NGVElI?=
 =?utf-8?B?QkgyZ0xIYnA2bUZLQVFNWFEvbG81VWYwWnlBTFBybWFsUkhkR3dSOUdzcURQ?=
 =?utf-8?B?VDkzQmxGQWc2RDM1TTRUUnVuMUx1aStMUU81Y2tjYStWQ0pxWGxuTXBpdjIr?=
 =?utf-8?B?UVpaU0RVU1JsUzhGNXFIOUVWeVRBWDFFVjRnOXIyUGUvT1dQU0NSSkRiVTUy?=
 =?utf-8?B?NGdzdkJYa254KzR0NEJPQVV0L0VIM2htY3BCdXZTZ3RvR2lYQmo5VUNKZnRK?=
 =?utf-8?B?eDlXZGNrRUw2ajN1QUFGMlJ6dW5hVThxVEVnZU9Lc0RXblh0ZVRvSUowdEk5?=
 =?utf-8?B?MnB5cWhOUnk5Rk9oekR2K0lXOVUrNmJidTlBR3ZkbFFYQklBNkR5d0k1a2lv?=
 =?utf-8?B?MmZSVmdGWXYrRjgvcXJSVWVMbzFjaS95emVKT3U4OURqWm9yVnVjOEdudksx?=
 =?utf-8?B?emxYY0RRTkNyT0JHeDdVT2Faam9qVmNDRmxLc2RIRDE2Uy9UTkJ0L01SRWpj?=
 =?utf-8?B?czVvRlRpTkw5VjdYQWZ2ak56QTZFMkZVOUV3eGcvaG55UmlwOFZhb0lLeEpz?=
 =?utf-8?B?Z0dTM2hDelBUeUk4NHpVUU4wcjBDSWpXenJUWXJiN295ZDVidUtJVUtWT0h1?=
 =?utf-8?B?UWpra2dKV0xqTmxlaDhnY280OHpTZkVrUE1hSVNUK3Zvbk43d25iZ3BpdTJF?=
 =?utf-8?B?S1FWaTdBUGRLVFQrR0Zod1dJMzhXR1doZXFPVklReTNsWkxHQTBKUnVkVUJ6?=
 =?utf-8?B?NkdkZ056RU9XOC9IbS9QOEcwUjJ5UkM0Q2N3V2FYOHgwRWsrY3VOek04R3Qw?=
 =?utf-8?B?TkZXMjlpWmMxR2NwMFhFZGlQejR1THM1WXBML3RuaEh2aCtoM2FnTk8rK1hP?=
 =?utf-8?B?ZHJhUlgvTUJtbEo3Qm9vSTJoSFZGNlVHTDcvMTZYL3RFaGF5WDR5a0Y1RkxG?=
 =?utf-8?B?aDNjZHpmUFBWdGI2SjB1d2RIZzZnUUVpa1hTMGIzZkVzVklGQXJpTkgxeE5W?=
 =?utf-8?B?ck9rcDBBS1lROTdwVUdYazNwcHdiRVVEdWdlVmlyN21SQXUreWM4Rlh4bWFO?=
 =?utf-8?B?d3d3alc1VFhHbWZPUjQ3aFVRaG9uUEE3T3U0dXNkcVJKeE5LanpZSEhkM3Nq?=
 =?utf-8?B?TWpDeHoyckhTb3gvQjBDaWpyTGlDaVgxcEpaZHVZT1BJRDRsNjN3MjZNRTJE?=
 =?utf-8?B?eXh2ZTFQRlQ2Yko5eDZQMklKVGg1RUpjSHROVHlrRW1DaUZ3dEZrSmViZ3Mw?=
 =?utf-8?B?bGJOcEEzUDgxK0RVK0w5dlNVVWVrN0swUTZxTkpLSkRjaWJRZjE2OUh2THlG?=
 =?utf-8?B?K015T3J3aE9oelZ4ZWNNVk9oR0xYUUpwM1NzblpZeGFLbCtGMU1WeFdDa0l1?=
 =?utf-8?B?ZU5hUGQwNGpHOVZjb1ArREFPYUFrOE4rZThQdVBSeU1LYXdIcktkb1lHSita?=
 =?utf-8?B?bjVsUVAwUWJ1NWtBMURIaWR3Vy8xUmFmSFhhUGtGQ3k0NHRJQ2FyWlVzeURm?=
 =?utf-8?B?TlNjeVZtMTIwdVJITkt6SkRHMkhTQjZqZEpDU2xGTi8xWlRVNjl4bzhDSk5V?=
 =?utf-8?B?WnI0Z0lmOUdBNk1RcnEweW5JU3hNdDdRK0p3WUprSGpGcTY0bFhkVHBCYXNY?=
 =?utf-8?Q?5e+sH0psB9HR/S7WaQYNfZximPpCTwTH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0lPR29teWFnTVlheitaaXRZV3p0bWFyU3RUd1JmaG85M3BDRys2TDF1UkYv?=
 =?utf-8?B?QVliaC9abzBuZk5qZVhqN2lUOW1na3lRZWtFUWZUTXBqbGZuRkxTZ0RHOWh2?=
 =?utf-8?B?VWlxeFk2bEllV2NZbUY4d2h5OXFKSWgwUjhobGxncHpmbTRJT2dxeEVObVgx?=
 =?utf-8?B?SFlXV21oY29IRDViZFFFVWtHcktuVFoycGZFd2VUSFQwL0JWRGVPR0Nubm8v?=
 =?utf-8?B?NjFnKzZDZ2pycm9TRXRGcWpmYlpmVldNNmgzQkxCSkxzeFZlU1NaeUZtVUc1?=
 =?utf-8?B?eEtkUmZYaVVxSngvTGRzWlIxYzlrZEUrem85TUIvelBXSE9JTnNQTHA2Y2ZV?=
 =?utf-8?B?cDVDTDB3RUMrUUowN0djVnVja1VMc1k0Qmp4ZkRNSmVzaDMrZ0psWjlOcXVy?=
 =?utf-8?B?VnNzUjNlVkVYRWp1M1EySHE5cG5qQlBvMU9PVkJtWWhiRy9QL3RvTyt3eW9I?=
 =?utf-8?B?R21VU2oycVpRbG9jVzlQYnZ0a1R6Nk1OaFYrRFFpOGh6blM3TmkrRGlBcjNG?=
 =?utf-8?B?QWlKMHpTci9FVlZsR2ZmN2pzQU5jZjdRcVozZmxrd3h4VjNCTzFrOE9yT3Zl?=
 =?utf-8?B?SXFSeEx6Nk1SeUtnb3Rrdi9jaUtoWnpqb2UxSHYxd0JJMDlwNjFFeUJaRHAw?=
 =?utf-8?B?akZjdG41TEZQd1NBZFloMWtaQTJrTkpxalBJMlBNK3dpUzRKMXFFTzV2WE5H?=
 =?utf-8?B?aGZmbDBNL0lTNGVDdkZKMWhzb3h2VVdPKzVDelJmL0d1bXp2cDcrb1gwM2cy?=
 =?utf-8?B?b2RUOE91bW5iUml0RGxlWEJINTdMTzEzL2VodWJiaG1iNjJuZWdReE1WTGxq?=
 =?utf-8?B?MVE3RTVUSDhZdVQzZkF6MTV0bDNQWDN6bUF1WVRFM2hxL1dIZ05MZ3NvNGVz?=
 =?utf-8?B?YmtjSldYNU54aXlSa2thZm9tRnIwbTVZeng0TXl3UnFxdy83alZqYnZCMGhX?=
 =?utf-8?B?UEtLZlBoTWFVYndkUmJ4KzNTa1dUVlczTjhaR1ZhOVprYzZZVTVNTitvZDNn?=
 =?utf-8?B?WmhObEU2UExGc21QZFhiekhKbEk0dUJYUVBYVWJjeU1TWEZGcXo5MVhlTkkv?=
 =?utf-8?B?dzR2VnJCejNFYVE4TmxDOVpKOEJzT1NudFlKWFE3dUxxd2lEb3V3cDRLdlFu?=
 =?utf-8?B?b3BpQmR0VXQrN1RXc1pmQ2tBaFBJT015TWs0a0ZLeTR3MS9RU2d1VFBhem9k?=
 =?utf-8?B?L04xREsvN1dMN2l3T05nN1BNUG55d3N3TVBBYVlOdTQxcmpCWnNQbHNQNVBr?=
 =?utf-8?B?bnhaQkJ1NlZ5MDdLMVh6cjY3L3VYUW1sbngyVjFlR09pL3BrTHBFMHBEdmI1?=
 =?utf-8?B?QUI4ekIwUUhqYmJxNktpSjByYWd6QlRXYllQVzJTU0J1YmduVlYwZ29qTjhV?=
 =?utf-8?B?Z0xibGJqZUJKS0VkL25UdSs1WFRzNWVDNEZOSEZJQUNUT3lVVjJXc05KZkJT?=
 =?utf-8?B?a1dGZGFteU81cTdSZis2QUl6NWVmY0gxZ0VLdURiR0V0MkZQQ1M4RFJ2MVpl?=
 =?utf-8?B?YTZqMGdxZnlpVDExVXd1KzE5cHF0T0p0VGJCdWI3QWR4ZUZydnNvU2hrQ3FC?=
 =?utf-8?B?b2hNS3F4eGRtYmtFOVdyd1hFK3NEZXJ5RDBCbHFOMkhVMGdvOG9QMi8wVm5D?=
 =?utf-8?B?ajFuK2NmV2tFNm0wQ1hMY2U3NzZhazFOVVQ4VGlKc1ROZjBXNUtFcUp2NU1I?=
 =?utf-8?B?WjJKb2dlc1pJZGU4Q3IxRERRdE9HT1dmOTRVV0wvNjNSZ21QYmdiMEdNcHdR?=
 =?utf-8?B?MHpoL2VXZStLWnQ0MXN3T0dQSjdCTUExRVVMazkxcDNCUklCWkFzMEN0RjZK?=
 =?utf-8?B?b2pJUmI5UFZWLzdnY0dXdnZjZXZ6S2RxejIyU3gva1Q0bTByQ2t6REdEMW9Q?=
 =?utf-8?B?Z2hTMk5RTjkrMjg5bnhTSldOVUpaT0djSjNSKzRTZHhORm5Md2pCMVhGNXZC?=
 =?utf-8?B?cTlUVlllRTgvaitmOG04V3BzOERsSkVhZ1dtQzBqQVQwMkZKaW9od0tERkZI?=
 =?utf-8?B?SmozM28vL3UzSjBPQ2FQMFF0dzBNQitpa1NxQ09xU0ViZ1kvRXA3V2QzUFNZ?=
 =?utf-8?B?UkhLTDJxTGIrZThTUjdFVURieTlBdmEvQzIxYk9uSlZlRGh1OU5teFlMbm9J?=
 =?utf-8?Q?dMhylyTqGA2b2OwIdVDBKt0y0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8563da21-6c19-4c29-9b95-08de367566c3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 16:18:19.9532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /18GgqY89hzL2e4N4VT19FFzKrO5chbd12UHj9GMJdY2yDcI8rsNTtCoDuo2wt71RYNmXBDSXdz6WdBGTMyeMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917


On 08/12/2025 17:54, Stefan Hajnoczi wrote:
> On Mon, Dec 08, 2025 at 04:39:25PM +0200, Max Gurtovoy wrote:
>> Add support for the 'driver_override' attribute to Virtio devices. This
>> allows users to control which Virtio bus driver binds to a given Virtio
>> device.
>>
>> If 'driver_override' is not set, the existing behavior is preserved and
>> devices will continue to auto-bind to the first matching Virtio bus
>> driver.
>>
>> Signed-off-by: Avraham Evdaev <aevdaev@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/virtio/virtio.c | 34 ++++++++++++++++++++++++++++++++++
>>   include/linux/virtio.h  |  4 ++++
>>   2 files changed, 38 insertions(+)
> What is the use case? Is there something missing in existing drivers
> that cannot be added to them by extending the code?
>
> Stefan

The main goal is to align the virtio bus with the flexibility that already exists for other buses in the Linux device model.
On buses such as PCI and vDPA, it is possible to override or replace the default driver for a given device and bind it to an alternative driver.
Allowing the selection of which driver is bound to a device can be useful in both development and production environments.

