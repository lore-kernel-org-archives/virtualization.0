Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEF22F1FDB
	for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807422; cv=fail; b=WkmJW53kdTj+n+j1P6QQsUAy5jOesp3IW/Jqg2HocA9i0kuYr4tYUpBQUAbopqeN5Q8O/jZL/irbVm/27R37M2csd1NcUcwMDKgP26qe31ftYgV4K/9jTbuL4uD/MvVuNzp+AXvESZjPAJ2aYB3bAemYMBp+VCjtAoQ6BrLRe1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807422; c=relaxed/simple;
	bh=bpL6RAq1ABRYv26XLn/SF6P9zgtrxN0xrUYzJexer9w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AxNgkod6zhfhoVrG3pvPxIgdc29Li7nraHMQBPE2oZQ+v4+tUgMpKZXrHAwMYnSz6Bo24qAwsggPFZqPiynp2TSrn5ZYj0U3TQHK7I1hVyPNwC7AjkR2GFdzmMhHEtGXgdwLuOrdRmmsN4BD6jqRpJ3I40FKz3hOy1OrXMcJAbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WelN7lCh; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WelN7lCh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUa8B1/A+B+4TuMmiRFPbDQ6TtRORIiQI44i5/xer4hGJlg+crjeov7nBWyvWI2ro1PjV3VEs/H6PQNq8sR67FTEP9AtmdJxuJSjgb366HG+9IkmD7FFvNs2Yam3tzMM2IcPhP6EehTv+wdKyzdOREwCVObytFQ/hCugmP8ZNFMTnLDzNnlP8+Dw7BMz/LHUPwE82Zx54Eq3X9QOLFsdRRLazYkCyto82XnNavca/DCv9gawNCMwbFtwLem69KeLZ4X+e8SAuUSl4OMLxZAtEW7/NyEFBVuCEMXERDPv0c0ZKteZZh8FZ8NnC5eZDTsp/ZMRWbZ7FhGVytC3Q+6VUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpL6RAq1ABRYv26XLn/SF6P9zgtrxN0xrUYzJexer9w=;
 b=kKIJdv1qhxMyasV3DEwT6rWm6azu33TdN9AOld0wjdHfHEm2wLsgPZ27rcMkQI53+Dd4rnsmX1jEmX60fvrInFcUEJnFxtPMAzmAjogzrX5plg5nlqgAbDzUwajyHA++nZloLUliYeqebwsWlvXWa4x20uEtqFuBbHuB640VJwH/oGPtCUt4uH/ZJG2YB4F4OLU/92s+CTfTGkWWN7sSEuCA22z/FaoqBuK/7yYqfrExH+I/R/fIM+vKD5dVqwhh43rQCAfwHyyDVy87zBW2l3+N6eWIr5FHiv8IsdP1DnR2iQ6Hi9HUAoU4ORy9bsuOpcygJMUGrFSfOpvQvbzgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpL6RAq1ABRYv26XLn/SF6P9zgtrxN0xrUYzJexer9w=;
 b=WelN7lChmMCUVX/TBo2qejjUR/Z3hD0M8GFHXhWm+tkaJaZjmZqrtLNUaLhG9IFXKQF6Puhsz0QB7hLoQR4mgk0KYGk1ZikWv6BucsP3cD9XEF1Yhj9viljxeFl64P1NAlMHdKY547ZMdcQFq8lKCVtU5F3653cc89O0hBdsST6uZuiDeYEGrZrjgRJRz3ll/Kv0JxNk5V5fn3xnI6X8IPVuOl28WgM7OOiYA7U5SPRjJQ1aqwHjo+1vAtDweSeor1Snsz96cPNJkOxsxT8ILTCMxCg5mwg2b+e6aIrCHuR4w8jDGSkYwKpM2zIaJVZINHCHi6YetMzzmXF4CQAWig==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV9PR12MB9759.namprd12.prod.outlook.com (2603:10b6:408:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:43:37 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 20:43:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>
CC: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: fix kernel-doc for mapping/free_coherent
 functions
Thread-Topic: [PATCH] virtio: fix kernel-doc for mapping/free_coherent
 functions
Thread-Index: AQHcUoD6CtBx7/+MkEC2/PLzYxqEe7TsYF6A
Date: Mon, 10 Nov 2025 20:43:37 +0000
Message-ID: <83709d56-c661-4a7b-a01d-61e122b46099@nvidia.com>
References: <20251110202920.2250244-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20251110202920.2250244-1-kriish.sharma2006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV9PR12MB9759:EE_
x-ms-office365-filtering-correlation-id: 6c79e6aa-cece-4a76-ece2-08de2099d310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0RmZWhWcGJDRWxYSkUweSs2THAwZnFVREs4a1AxOE55ei9PTEVXZ2Vucm8w?=
 =?utf-8?B?UXJGN2pkQThLa2xNRmRLUkFMYXYvaEU1SlMvSzUxbWpzS1UyNE0xQzFHbjNh?=
 =?utf-8?B?Y1duT1pVeGVaSFJmSmQzWU5oTy94Q3hpMTV2WjByMTRFQ292YzNGcTEwMkpi?=
 =?utf-8?B?WWJQN2NESVdVbzUvTDBaV0hwek82RThLa1ZUa3BxTVNXN2ZTRzdGZjVxTWp3?=
 =?utf-8?B?R3AzSk1SWmp3dlBueW9Ycnl0U3JWVEhxandrbVVmV3d5WEs5NkpZV0Vld0Ru?=
 =?utf-8?B?OW9GWDZUQ1o0dWloNHZaNWoxUkpDSldBTmxaZ0ZSdjMvaHYveEQ2RUZOVFZJ?=
 =?utf-8?B?bXY4QTB4UXdnbzZwWGxRUGJNQnZOMmRtaHV1VUdLNjEreEdUOTBGRXZwMkF0?=
 =?utf-8?B?bStHNm9lb2VjekZvS2VWUzBvSGZqb0ZRejU2Wno1cWJpcVRWTi9mei9aOTN5?=
 =?utf-8?B?b3M4L0ltYlIrUWt1Y0NRZVhKRmR2KzMrVGFlUFd2NTl5RndsY2RtV05vZkdB?=
 =?utf-8?B?aTh5dHh5K0Q5WjArRlVoZHIxQ0U0eUtmdVpma2czYjcwUE0zb0pVYjcyRUJM?=
 =?utf-8?B?QWZ5dzZENDdLdTNTQjFoODIxVW54WEJaQUtobnZuT1h4NjN5UmpKMUY0RjZU?=
 =?utf-8?B?UHJCSFlyTXFNQ3c4RTByZGdGWkR3K3hTR05LWDNoR2ZCcGxSTllURnFYdlFC?=
 =?utf-8?B?YjdpVzlqL1JKbDhDTGJ1SFlOTjJ2eGU1SWdvQndKNXUzc1ErSVg3NFhITE9Y?=
 =?utf-8?B?a2tYRnlvTHZPZ1hIVDdvekhxaFJKcjhFVlJkYlQ5dXFlMnBhTkZLZXQ4RnI4?=
 =?utf-8?B?NUNnMW5kcFNza0U4ejM5UWRQbGJ0Yk9KSnN0L1hoZ3BRMFNmb1IzaUI2QldC?=
 =?utf-8?B?anFxYTU5YVJ4WTJKMWtwV1I0TFN3WGJOcUpPKy9iUG5CL1hYYXhSb0lVVWpn?=
 =?utf-8?B?SVVlNi9vc29IUFdLdm9zK0VaNXU1aVFUTkZETTNaWE5HbUZwVGF6R2NwVnds?=
 =?utf-8?B?eW5kWS84eUFpc1RaTkpDUG5MZ1dTSEY0QlB5UkVmaDlCSEc2bFB2WDlPNkE5?=
 =?utf-8?B?U3RuQWJQdWR0U1BnTDQ5eDRnUGZSQkN6RGZGUDA4U250Y3BqL213SkdOVEdJ?=
 =?utf-8?B?aHZ4alhiTHVQbk5sWm9IdHFOWTRuZElTVUZ5c2dVNGI1aHV6WjJPVDBaOE1w?=
 =?utf-8?B?eTlNa3pFQ2xsemFNY2w1Uk1WeVlLRXNmTklwMGFOV0pUa0hNOUZsd0M2VzV4?=
 =?utf-8?B?RThZbXFXOGZLaUFmVzN6dFV0SWFkTXFqNGp3VzgrK01oRC9ld3I1N3k0RVdp?=
 =?utf-8?B?dG5vWmRTWkdtSXY1M2NndFJUaUladk83Q1BTdHZ6Si9lSmUxUC84RXNYaDFW?=
 =?utf-8?B?L3Qya09VZHZPU3JkblJvZGFSTDg5WDVsVTJmdjZaVWx0OUJSaGZRSFR5c1VB?=
 =?utf-8?B?UExnTm1rNExsc29ROFM0MWd3SjlJS2t5em82ZnV6UFJRcDVtQU53cUVteWNa?=
 =?utf-8?B?YXBjZWNsNlJhWW1zYUQ3Tzd4UkIrNVJDS0JRU2VmSkhOblNRNTEvMGRtOGZp?=
 =?utf-8?B?U29PRE92VHRJczFiM3R1eVlSYTRjN3JFYU9zVzJ4Zk9SN1o5ZVFjeW1BbjVI?=
 =?utf-8?B?SWY4RkFJQ0V5SmJhYW1HdTU0NVBFL3U5Zk1adHR5NVVXYmUwUDRPcFNMM201?=
 =?utf-8?B?RW00dDJ1NDdXa1ZkM3dsZWlvaGlsYUExc1dIYjVHUmtrcHlVb1JHV2hJUGFm?=
 =?utf-8?B?am9NTEhXNFROWHZxOUpGbnFlKzY2T3lKN3RWQkNLRVAzbDB6aXZPVkFSeUI5?=
 =?utf-8?B?dFdDUzZDZlAya0c5bjUyREhPN0l6RXdudWJ1a1J3U20wMG5GUG5lRUt1cFk2?=
 =?utf-8?B?WEJWRDJDc0czS3lsNlVKbDc2bkU4c3VtQUtFQ2NBMVp2RDV2UFpzSEIreWk5?=
 =?utf-8?B?OHB6SnU3WVVDaTBlaHhJK0gyS3hyaTRtaHVyd0dHOGhnNzYzelBIV3BvcDRS?=
 =?utf-8?B?OGgxenBkczI3SFpWVDNuaHhsNzUzUGVnbFRMWVZOcEJncTZiY2hJSHBQOHA5?=
 =?utf-8?Q?s9+VXw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjFKVVhydmxFQ0ZsYXMxMGtLU3lsZU0zb01QVHc0UUlta0UyQjE4TUs5WlJ1?=
 =?utf-8?B?aENDVDlQRHhGc1doaU16TVZValU5elVZQjRYclBvSE9pNlpXYnBuTS9BVHJy?=
 =?utf-8?B?N0loMXp6QTNFWVFYV0ducjh3WGpsR2xiS2FPYVFoL2l4RHVOVytYSlZFWjky?=
 =?utf-8?B?VUxnYm55SDBSOGZJS1laL1Q0R0piaElCd0JiNko5SlltcjVWWFRTNk9iZE5J?=
 =?utf-8?B?OUF4KzN5ZllOOHN6c2VwMWdIT0FlSjBRZGNGSlY4UEY5ejZrMVc5bmJoR0xN?=
 =?utf-8?B?WXRUL2hqOVc1QkNtUks3WlZ6eHJSL0VkcUtHeDZNUXJob0FvWlJzbzRLMHUz?=
 =?utf-8?B?bzhRLzY2VEgxTzlvcEI4dWl5T2pmQTdENjNDSjZFSmtaVXh1bEZhVTNFREZW?=
 =?utf-8?B?VUVkMkMzNk1uUGxwc3JHOVppUFZZVUc3KzY2eUZxc2E2cVpNbUdFUFZ1UFZK?=
 =?utf-8?B?dFlNZ0kzTGM1MU5uSWNDaVQ2cDZnTk5vNlFWYTR4WHB3MzU3TnBGUDBQRkRh?=
 =?utf-8?B?WERqTzdqNjlibk5LaHhHNHRpZ0Q2WXlyNkVrWHNha0VidlRaT3NFWVdsYnpx?=
 =?utf-8?B?KzdzUzRWcjNXUlBiTG0wakQzUXQ4amkveHBkcy9uK1lnTi81UXZJTGxrY3Qv?=
 =?utf-8?B?MjhnTXRmVVAvVjh4U1ZhdllhU3ZJNHBha0ozVnJrK2liZ1I4ZUlQeENQUm1r?=
 =?utf-8?B?eFdhT05keXUvMytVOWVWdW1BbTV1ZzV0Tkh5a2d0Zk5YWVYrNkxxK01SbmlT?=
 =?utf-8?B?SFNoL2ZYQXhpaTd0WXBnRXlFcXpiSitKREFySWlVS0docHAybTBEYzhGbXht?=
 =?utf-8?B?YmNJUXlpb2YxZFdpZXBSRHRLb0RCaXhQNk1scjlQVTh2ekY5ZGpJNGFXS0Nu?=
 =?utf-8?B?R1NoOGNqdFVmcGpuVC83Z29WNXZKeUQrWEMxTzF2Q0dXQmhNOXRDT2FINSsr?=
 =?utf-8?B?WmV4V1hqcyttNzBWWWhkRzNPYW8yNWFWMGZsS3B4OVdDWC9NWGQ1WksxdXZr?=
 =?utf-8?B?ck1zeTh5Ui9YRGRLKy9wR25tZlJha2VuTFpjN2IwV3VWQ2lxbm1ITzJ6Ukw0?=
 =?utf-8?B?cThxSDErcyt1OFRXRDlDR1E1T1JuVGZQU0UrMDR5L3ZJTXZsMTEvRFJCY1JK?=
 =?utf-8?B?dEd6SldVRFp3ckxvdDJUQ1FxUUVhaHRVcy96R3hnUVRNUmJBNFZVQTV1WWJC?=
 =?utf-8?B?R0JCdlh0aWZvSHlISjRZN2x5ZnpVSHVZRTNmSlE2WDJBbmE1QmRoOTJ5Umxm?=
 =?utf-8?B?VHlHV1pJK21LN25yNlNObW5xSUdVaGFmOS9DTHBiZVMrNDgva0toM2RlRVh4?=
 =?utf-8?B?aTNQOHVKQ3gvVEVHV3prUHpSRGxHT09TUHlqRU1HR2hsdnprQStNTXVyN3RL?=
 =?utf-8?B?aUM0RkR1RzdHR0NNT1lGL0pPT2tIWVdMeFpSblMxRk4ySU0wbW85Qmk5N1VR?=
 =?utf-8?B?RURzZHNMcExYWlVVaCtEd2ZyVGFFSldpaU9qMVYvRE9BZk5xSVh5dVFnV3l1?=
 =?utf-8?B?eWN0VytWWVRNS3JIQ2JYenZnTk91SmFBbmd0Zk1xYnhpRG5lMjNRTUtMaENm?=
 =?utf-8?B?U09oT3pnT1NFVlEwdlZOZEtBYTlDK0p2WnlNWXYwNmk3dmRIbU9YTHZBS0xX?=
 =?utf-8?B?SWhQcFhCdG5RR2ZZZDZNclBOVmVxZHBmaHFkeWJEV1lSS3lWUDJwb3FOb05C?=
 =?utf-8?B?cDU4R0greXRzYzhGMTF2Y0dsQmI5NEZJVTRvVHNVVTFSTmoyTlFQVXV1OWNz?=
 =?utf-8?B?eFdic0tTcll4aSsra1BaZkthV0JPL3pKcm1HZWlDaitqNHYyb0JUOVdMVmpI?=
 =?utf-8?B?NnhBQ0htYXFZMmtkMTBKSVIyL01jV0ZNY0pzTXhYNzFKdWgwSExhWTNYZEFz?=
 =?utf-8?B?SU5zUFpUSEVRelp6SGN4aDF5STB6OFlZamNXOFZSdStnM1ZqSWt5YndKbktR?=
 =?utf-8?B?Y25RUWhOR2lhZllMMFZHRzV3WitzN0JrWW5WcUQxU3p2dHAweExGY2d2WGNr?=
 =?utf-8?B?cHRSMVdnc0wzODR6SjlNRUxGdlNIVEhpYUwrRGlycXB5cnpKVDI2WjVRSENu?=
 =?utf-8?B?RXVzc2JaZUJFZjRXaFNjVzJwOHBDblp0QndmMnJ4S3A2NkZvQllmYktMMnpK?=
 =?utf-8?B?YVFQS1lVdDVLV2RUYTQ2RjZlb2tpeHVVWDR0V3dTeHViZXc1a1gzZkhydkFh?=
 =?utf-8?Q?WDOKlNcLjRbYx/GDB+j5TAvoFli17zMdAmUWek0xU6iO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EE26335D1D9DF4695F58889761AAD91@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c79e6aa-cece-4a76-ece2-08de2099d310
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 20:43:37.5902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gu79J+nqTtGWg1jQ5KOFCKHz+54TG6ahHkRDeINzzIjvBQCHooSabB0wiWcYYKmXAE62yoAIeqFuc3Cm6aycxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9759

T24gMTEvMTAvMjUgMTI6MjksIEtyaWlzaCBTaGFybWEgd3JvdGU6DQo+IERvY3VtZW50YXRpb24g
YnVpbGQgcmVwb3J0ZWQ6DQo+DQo+ICAgIFdBUk5JTkc6IC4vZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYzozMTc0IGZ1bmN0aW9uIHBhcmFtZXRlciAndmFkZHInIG5vdCBkZXNjcmliZWQgaW4g
J3ZpcnRxdWV1ZV9tYXBfZnJlZV9jb2hlcmVudCcNCj4gICAgV0FSTklORzogLi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jOjMzMDggZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgdmlydHF1ZXVl
X21hcHBpbmdfZXJyb3IoKS4gUHJvdG90eXBlIHdhcyBmb3IgdmlydHF1ZXVlX21hcF9tYXBwaW5n
X2Vycm9yKCkgaW5zdGVhZA0KPg0KPiBUaGUga2VybmVsLWRvYyBibG9jayBmb3IgdmlydHF1ZXVl
X21hcF9mcmVlX2NvaGVyZW50KCkgb21pdHRlZCB0aGUgQHZhZGRyIHBhcmFtZXRlciwgYW5kDQo+
IHRoZSBrZXJuZWwtZG9jIGhlYWRlciBmb3IgdmlydHF1ZXVlX21hcF9tYXBwaW5nX2Vycm9yKCkg
dXNlZCB0aGUgd3JvbmcgZnVuY3Rpb24gbmFtZQ0KPiAodmlydHF1ZXVlX21hcHBpbmdfZXJyb3Ip
IGluc3RlYWQgb2YgdGhlIGFjdHVhbCBmdW5jdGlvbiBuYW1lLg0KPg0KPiBUaGlzIGNoYW5nZSB1
cGRhdGVzOg0KPg0KPiAgICAtIHRoZSBmdW5jdGlvbiBuYW1lIGluIHRoZSBjb21tZW50IHRvIHZp
cnRxdWV1ZV9tYXBfbWFwcGluZ19lcnJvcigpDQo+ICAgIC0gYWRkcyB0aGUgbWlzc2luZyBAdmFk
ZHIgZGVzY3JpcHRpb24gaW4gdGhlIGNvbW1lbnQgZm9yIHZpcnRxdWV1ZV9tYXBfZnJlZV9jb2hl
cmVudCgpDQo+DQo+IEZpeGVzOiBiNDFjYjNiY2Y2N2YgKCJ2aXJ0aW86IHJlbmFtZSBkbWEgaGVs
cGVycyIpDQo+IFNpZ25lZC1vZmYtYnk6IEtyaWlzaCBTaGFybWE8a3JpaXNoLnNoYXJtYTIwMDZA
Z21haWwuY29tPg0KDQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBL
dWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
