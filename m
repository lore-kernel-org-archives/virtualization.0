Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A56E1E5714
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765293189; cv=fail; b=nut2ns6eYydWPbqBzw64vKHaHmdbxnDLIkLPzTmKQTUAYT/XDecfm3uNYP79669N+8LkgOJ0sGoDDODd179/gesQXtUtexCF92SR1EsxJtyhLpQ+cLlsvbLfx2N2EG7+cgSME7dpiummSmiu6LveVRMjD22oEhQwQ1tNJmcM9gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765293189; c=relaxed/simple;
	bh=sLX9JcPzrNkGQBUclmHnlwn5lzn3xf2GmWRxdoA33BY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K8vUO6wEYBNS43MQ4l+NfZxz+7orEz56BAh1d5YHNJL9hpXpblAnbCQKAQaQ69qQLEd7HIuca7BSIbP6y0jF6fmbFXUg2Em0QJVjp03sh80RK36JRSWn+76EVWd4uK3w327t3y96CjlMYaPIr+hUREZUEfeqTUIRGmdsMn4Z7Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LGBm2om1; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LGBm2om1"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15F3660894
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 15:13:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id elv20b67rzoE for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Dec 2025 15:13:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=mgurtovoy@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4DD76606CC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DD76606CC
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LGBm2om1
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4DD76606CC
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 15:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofR+bXQ7NG20Avv5HgdVpOhPSGCHaD3iMv1jKK3Datyj7e34Zx75OZtYSF1kmeSRdscjf4RNODKauW/igAiEZsnxy6cvyOKVK0LpARPmTLTMv7Kr4jtcn/WxfBS8YaLtmCoyUSBdSeqmiMSOqoig0DZ/rgIKSYD+UJZ6Zrq7XM8Wug6rGRWMpFVbWrDuuaevkYX8iSE1fgp3uJ1coDBMjnBOSPyDsqmkeYbG1p0ll83vvkpE3V1+0aoM/zaKxOjwPT7ITngjOXyOBW3MO01WwbkylbKKyOUzt5NJJ3kPd3uYvCVj0IGfISt5LcKyMcvQNrqyKDbkrJ+liPuueQETBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ponLiv3/J0kzpyYfnNqqZC1NJw+g299MuI7lfON0d2A=;
 b=WV4imUaCs7ync0ERhc3H1//ueKrD5k4e1Vg/rYPDF7BexAgKapxC5Nxh5MOqrVgES4AxsVdDtdJtmel4tTjIQ4u9qj9/HMoYKk2U0e2BEvzE1cLP4IsW4K4HDebfG7d3dZMnlROOarSblHufGTOwF/FbmXZ0JIfQvY6nlfgb3d2nRX0Ryyc4+GId2P1ARKm8FEr9JBn28hwvwdNcTXRa0NDJMO6hPugM3SMxN9ArpZlEZswXHxZM6UbXQKgDcRj/iLGr8b6Y936DHOZMNw7XFBOyncSG5yfF4CLO3gZXkG9ySEFaZoXJlJ8lPXNRYQFKXcClqKdBOV/4C5RCLjOAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ponLiv3/J0kzpyYfnNqqZC1NJw+g299MuI7lfON0d2A=;
 b=LGBm2om1pWrr2QCIPcudxh7AxhqH7Uzi/yxyQCXQJF8ohe5PtqMOEhrC38NXJq7vvNtMLswCojhX211oyv2uJYjDYqBPBsH9b6Aalc+PPsbF5teepjVzl/0VsFpZZ85GwZJ1GY9+JpBeCsLeB7JoQJZANNsfz4MRxPoAtenWTV23rhARj/dpj/t9xp1N6jvyOIf8JUHxe1q12E4IAqxrwKeIWwOaZUS2MazVS/eCjzi0Zbbd+Vmfq2K6lKlHW+lv7FLyn6u5nKeKA4O4xJboutQfX85i2SVxuCMy8/NDFbjv4mK6DnRlrUlB9iOvBe8wWzo7oFtObiDjnZ0YQc9g1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 15:13:02 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 15:13:01 +0000
Message-ID: <59d5c4c0-1679-435b-9c19-7778845331bf@nvidia.com>
Date: Tue, 9 Dec 2025 17:12:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] virtio: add driver_override support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, sgarzare@redhat.com,
 virtualization@lists.linux-foundation.org, oren@nvidia.com,
 aevdaev@nvidia.com, aaptel@nvidia.com
References: <20251208143925.32246-1-mgurtovoy@nvidia.com>
 <20251208155412.GB1346548@fedora>
 <7c4f605e-6faf-47e9-a920-3d7f782e9332@nvidia.com>
 <20251209135902.GA1370792@fedora>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20251209135902.GA1370792@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 03515bb0-87e4-403b-10b6-08de3735719b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVNyOGx1TjU5eDlLd25GTGpRa0s1enRvaTFOMXBQYjlSRWRKcUg4a1pkRWoy?=
 =?utf-8?B?Qmk5aTNRcno5aEdYQXVjVERQc3plY2dxYmMyamsxWlBzbXdJMmVHbWQrZHlx?=
 =?utf-8?B?eHlUTzNYbWxkMGc3UmFscUJNcDF0Wk9RZ0MwT1FHUjVJQVRGUVhHTDdzZWVr?=
 =?utf-8?B?bkNSR0YxS3lPQ2w4L0p1Qy8rNjNWQ0NqSFN6TEJjc1JTbVEzODFpakxoalcv?=
 =?utf-8?B?ZkFkdDFCZHlMQll1c0FKTksxT0VCSXp5OHhtWlVmdzBldHA2Nko4alNVZjkr?=
 =?utf-8?B?R2pnd3VaVm8yRlc2K0NCekozMHRBbjhDWTVWMFF2dnNvemxSR0dqODl3alNX?=
 =?utf-8?B?eVJkdm1qOGVWU1RNZHluVlJzNmlXa3FLYklSQ0hlRkxTVTFlK2dsYlg4VlZN?=
 =?utf-8?B?V0locElHSkNqM2orblYvcTdnTGJUM1N0Uk5raGZxT3k5dWNTeDFZay9UMDFD?=
 =?utf-8?B?Y2QrYTdjTDhqRTBKTDlJcnRwdmZwaTJFMVBlcmUwb2kyL2FZNkdCcDJ1WFcv?=
 =?utf-8?B?ck9oNk56Nno0c0d6V3B3cWNuK1pmY2Uxa1ZvQ1NueDdhdkszQXB5UnNSMkp5?=
 =?utf-8?B?OGV5Vno1ZVk4YkFabDNPZUVKc3VsR05mZzJSUmg2aExlTXVnTDZYVUFiV0RC?=
 =?utf-8?B?eTM2a29YTzZ2ckFwbFh3SVM0cXF6VENrQWxvamU3UmQ4dDVKOXpkQ1Ava25V?=
 =?utf-8?B?UEErZitVUjVoTWF4NzladitZMWtwRWxwVnE0cUJwU3NkVWd6UUFEQnZRZEFx?=
 =?utf-8?B?eEpBcHJpZnR4cFFnYXk2ejhuOVFSZ2xxemdEVGMzQjVkRm1USGpwNjBiUnZO?=
 =?utf-8?B?UVRIcTZFTGowSEpwZ3MvenZFTUNReVZUNFNYcW1qQVhncklxZjJLcm1UY29u?=
 =?utf-8?B?RmpobEVEOWJzVkhtN1JSTEZuUFpHaC9heE9yT09tbFhMZHFmK1Z3VGhSRERW?=
 =?utf-8?B?V0Z4V21GUlQ3QXJtM1NTK3BhVmZ0TVpDb1lLMUlyUFhxNDJKNndKVFhHWTBC?=
 =?utf-8?B?VkUxN0hVQnZPUlVOVTI5YTBnWTVDaTdESXpNelhvQzN5T0J5YTFzVFFvakJG?=
 =?utf-8?B?VmtUaEZzRWxibHpqVW9zWVMyd0xjeHUrYjkyNVUxSlB4cFRUU0VNcTVrbkdF?=
 =?utf-8?B?b0tZVDVjb0g5TGYzWit0WG5EUUN5NExMTHduVFlRb0FYejlWNUt4QWVaNHV4?=
 =?utf-8?B?aXNMQ0hMcWVwM2hxN0tlb05RNGwxdVl1eG5oV0YxMUgzbW9KU0tZMTVsNGcw?=
 =?utf-8?B?Q0lZNHc1WDdDQUtxZm9zSjFXclV2b2ZuOXJhdVlmTFFEVlI0VjR4SUNJOUNL?=
 =?utf-8?B?dW05K05rRFVSdjdFZ0FhRmxmR3NWbDFhQlRJbTBIWUFRYVNDdUxkTnVRMGhh?=
 =?utf-8?B?OVZIUjBnLzEyT3JKWFNkcDJXdHc1TTdwcVE1N2xtY2Ivb1JUNkdZb0FyOGZB?=
 =?utf-8?B?MG9IQUNRMHpzUGJjMWYwVzVLL3FTNVFCSkZ5bWNvZFE0U0lxMUhsVGFBRXRv?=
 =?utf-8?B?SzRGSXdEd3Jxd2dCSXdMNmN5YkJRMERNRCt6YSthdnBTd1IwTnRNZEhNL2xS?=
 =?utf-8?B?QlF0VE9PQWpvOVkzK3d0ZWhkSzhUSmRJK2NWUkFNRTRSMmJqa1hhcmI4d0xD?=
 =?utf-8?B?Qng3VWF3NmUxT1BLa2t5M29hSWpnNmVtRTdOUzJoMVYxNEM3andUY3lkZ2Mw?=
 =?utf-8?B?SjA3ejN5ZTBReDZSeFYzRDhwbVMyd3UxMFNleU1ER2ZVZStYQXlXOHIrYTd4?=
 =?utf-8?B?eTZnSDdNSWZEOVhpc2ozdmFZVXE3RkxpbkVHM0tqYkJocXg3eXp4OVVxTWQ3?=
 =?utf-8?B?UDBRNittNTFjK0MxL00xT2R4K1V4WmZsUFVHbllMTUJrTjJtUlJ0U1QvU0pt?=
 =?utf-8?B?RGJvSDV4VGpkZno1RjIzNFdWQ0p6N0tQM2hpNG0rTFJSYlVqR3k0amRwQnVa?=
 =?utf-8?Q?h5kqiRugdY1JsFwrEs4mL8ZjNgzVA5QR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K09raFMzTjVJd0xsWlF2RVB5NEowWEFzRkZMekRzZWozSmt1b3FrNWFsdzlS?=
 =?utf-8?B?N1NZS1B6VmVoZmx3UnNONVk5d0xGd3RLTW45SVdPMVdPUHZrcURGQVJ3a3RN?=
 =?utf-8?B?RVFYY01KK3J0WGNZTk9HbmJ2QjNCbmR1RStOVmE1WXZIL1cxWC94VW9DSUJw?=
 =?utf-8?B?TmRweXc2WVozZzE1RGU5aURwRG8rcndZcmwzcXZ2UHRWa0Ixak9FQ1VWSEhm?=
 =?utf-8?B?ekcxb2RTbFk5cEl5Vy9RWVlWWlM0aE1xdjFUZW5aVWNtSkR2cHRYVUdVSGor?=
 =?utf-8?B?ZUxsVGI0b3FYWUN4TjhKQ3ZGdi9laEs2d3JqN3NVeXBMNjRQUEVwMThsRk4z?=
 =?utf-8?B?WTJiN2pLdkZycFg5QXpiZUMrQks4b2Q5UjNLTDFOVFhpU2VMTmNOZTByd201?=
 =?utf-8?B?NW8vZ0hJYk85RUxKMDlNMVJ3cXBTMkdyRnlMMTZIaXFxRTNSUEtBdXJpNURO?=
 =?utf-8?B?MXR0dEdOUXJsbGgrREdoMTBTR092MTJnUjB3VXdvcFFob0hZRmZrK1ZhSFpX?=
 =?utf-8?B?bkdsUFdsRlB5T3RaSEcvZ3NRZExPOTQzVTZkYUVrK1I3YjZLUWNoUENYN2RN?=
 =?utf-8?B?TUFyRXVQdG1heGs4WldiWUF4S3lIbm9odEZTMzVKNVo5dUpyNnU4L3JjcGxJ?=
 =?utf-8?B?Mm5YYzRJd3I2WXRJbGl5STZXdDZCMTMwY1NZQmFQWkJiRG1UU2l4TldCa0J3?=
 =?utf-8?B?Vk9tMFhHZWExNWdsb21KejJjT3VHTmxkUTIzT0R5Z2ZoOVQ5LzZWTEMwWkEv?=
 =?utf-8?B?bVNmRmNvUnJlT0lwaDJyRS9nYThZbzhkVi8xbzNlNC82Qmk3SWpTcnBuTFYv?=
 =?utf-8?B?bWZRMS9HZi9QWkl2bVA5S3IwYlFUK3IwS1VseFJrOCtHU2NlQmdOZ1prMW41?=
 =?utf-8?B?ckpQdkcyTHNOVXJ1Z1JHUDdxcFIvS3V2UFkwbk1zZ0s4T25PNkY5SFgvMjNC?=
 =?utf-8?B?OWx6SW1pNEt0YjhoME1DMVZJZ3UvWFRHVlRRdEVFc3RQUVNoMWhQcENpeGNZ?=
 =?utf-8?B?enRNekRGNjQrbDFlRmFpU1BXbis4UHZtT1BhdHI3MzZUYmtUcDBxb3VBdWp4?=
 =?utf-8?B?SG5zQlliNUxYUUtvVFpUQWJmV1JmUnlmYTNPWVFRdExwRjlQRi9mZkZCRk50?=
 =?utf-8?B?bWlBYnRZMVdwRm1jS2VkalpkdFpIMmhlTmlWVWZtM3dVVnpOVmlFQVB5UVRL?=
 =?utf-8?B?WU1VbFNKdm1COVlXWnZWc3ZobGxBVDg5M2h2M2hVNDJaMzdXNUV1cTJXbWo5?=
 =?utf-8?B?S1Bub0pkWWQ5aXNmb2p4TmFjYlZEVVJrc3EvK1RBM0ZtenFucWVndGxpVjE5?=
 =?utf-8?B?RzJrRzg5Mm4zWDl6TDc4TGcyZDlud2pHZmx6TnBuNEFZdDZKTnIzQStaS3J5?=
 =?utf-8?B?R0xEL0UzdEpOZ0VBQ2RNbTVvSndteE9vbDU3Yy9BYks2a0k0Vk1jOTB3NkxF?=
 =?utf-8?B?eVJxZXNlNUpBd0NnTit5UjVTL0c5T3hiN203Q2tYM2trSmU2YWhVS0Ribkox?=
 =?utf-8?B?UitGOHk0cUthdGhWOTZiQ1dWNEx0S3BkQ0o5OTFKY3Vlakx4K1RldVlvV3NM?=
 =?utf-8?B?cmtBT2xyVytlT01tVUNzV2FBTUpUR2JDdmVUNEhMVC9vQzQ0OEwvWHk5c3pF?=
 =?utf-8?B?ekJ1VkJNZjZVdXdWcVRhZHR1TWorR0tHdzcrL2VzL0kyMGlSYmYxOHZOVWlG?=
 =?utf-8?B?OE5vMlRBS25aeTFGNXBCVFMzRzJCOXU4K2hGaUVjM28zT3dheDIvbGYySGds?=
 =?utf-8?B?ZU45Misycm5iUUpmeTB5L2pzMytKMnZmenJ6YVpTWFNBWlo4MXh3TS9wck16?=
 =?utf-8?B?M1oyY0Q1bkVKM3RzUksyTHFnOHl3QkNocWl4b296SFVpelVwQnZjNE1HSU5M?=
 =?utf-8?B?M3dJcXUyT0xLK2FoRWlvWE1vbVBhcnBleGdRUDFCREFoRHQ1WVlYLy9OaXIw?=
 =?utf-8?B?OHd2UGRSNkJpUUtkS0swTUtRcy9hcnJhV1ViMERQQm9qZExobkxNMTVHQ3E3?=
 =?utf-8?B?dTZjc1dJZmNRaFBOM2NlOU9PQnhPdVo4VjkwSkhOd2N2SXFCUVB1TlFQSTVZ?=
 =?utf-8?B?TDBac3VCS1FZTnlyK21NY3Z5K2pQeVc5VS8wUXBSUlJEYVBvdzd3S3VzREVj?=
 =?utf-8?Q?cWjo1hkU1UaylIBKAVxvSo+4a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03515bb0-87e4-403b-10b6-08de3735719b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:13:01.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1+zKu2HPdwssGHQyWaRdOYcCDWW6ZWInbmT0bcs8VHPJl3CBBRezB09VUjAgRADJepY3rjuoaawQ70lcWSabA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205


On 09/12/2025 15:59, Stefan Hajnoczi wrote:
> On Mon, Dec 08, 2025 at 06:18:14PM +0200, Max Gurtovoy wrote:
>> On 08/12/2025 17:54, Stefan Hajnoczi wrote:
>>> On Mon, Dec 08, 2025 at 04:39:25PM +0200, Max Gurtovoy wrote:
>>>> Add support for the 'driver_override' attribute to Virtio devices. This
>>>> allows users to control which Virtio bus driver binds to a given Virtio
>>>> device.
>>>>
>>>> If 'driver_override' is not set, the existing behavior is preserved and
>>>> devices will continue to auto-bind to the first matching Virtio bus
>>>> driver.
>>>>
>>>> Signed-off-by: Avraham Evdaev <aevdaev@nvidia.com>
>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>> ---
>>>>    drivers/virtio/virtio.c | 34 ++++++++++++++++++++++++++++++++++
>>>>    include/linux/virtio.h  |  4 ++++
>>>>    2 files changed, 38 insertions(+)
>>> What is the use case? Is there something missing in existing drivers
>>> that cannot be added to them by extending the code?
>>>
>>> Stefan
>> The main goal is to align the virtio bus with the flexibility that already exists for other buses in the Linux device model.
>> On buses such as PCI and vDPA, it is possible to override or replace the default driver for a given device and bind it to an alternative driver.
>> Allowing the selection of which driver is bound to a device can be useful in both development and production environments.
> There are use cases for PCI and vDPA, like binding vfio_pci to a device
> that would normally use its device-specific driver.
>
> For VIRTIO, I'm not sure what the use case would be. Is there another
> driver that could bind to virtio-net devices, for example?
Yes.
>
> Giving a concrete example would be useful to help people understand why
> this is necessary.

See example in my v2.

-Max

>
> Stefan
