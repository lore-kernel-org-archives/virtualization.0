Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD8136672
	for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247638; cv=fail; b=IPTrDdaedx+1CbJZ5U7xMEQfn9RUkbBFEvw9rKFcxE9y57U4rbIPNCl7bUrQBUMaX5zSAaAN211YVB3R0tw41l3RxsbfPyWAimBmGo8U+zvuDHbuqUq+liNjNSqxNSJ0EkGMjAL58rl8SjcHxPD8NK+u2q88KRUGIlNKok6lGRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247638; c=relaxed/simple;
	bh=hORMa90dLIsbpsM5/qqKaxbRckSWyDhkWDWynG30OTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PUTr/y30YeYnR5ZbaLBQ84gUFcpWxnAK+kJ5KEF6cBEROYLCn0Z+iHphQQ1Vn3vo82fe6C7mrmhbsPd6e4lmS2NNjqr3+gb9eZazf5oEwxFS0OOezGWlLGx4yzSTqGb8Vv2AzyQEgm+u0nkbvDQt01/KSjAeeIN8jsO7G5MlRyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SvukTTYL; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SvukTTYL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmA2zrUiBzV0THwejnpvYwqReLOD9fLVPeSo8DukuTJAsdb2wjhtXToozs/uveebK8uhOmfRxO49bWbSOnrufR9RUIJ6qG3rA5aL5ED6gtzOFQmXX6f+5TKuNgHEJ/O3japOXDwFSiGlIeawkkJ5GGMz/VBEtKVXENHP60zqJw7wejKr11BbsV2VC43cf/B+bf4Kgq35d/m86wxB/s/8tUqOfk5+ZcoUJ6nShHyq4Rs5furcvUPpHkeoQ14zpnrCFT19U7H7t5Pg7GUiA6XYo6Ebg+9cO/E9p5OfRV757iSpprFH27898YenASiEeLiPEUiliiTLErxUwLX7Si7HNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZGNdP7zM5p1oNK43cAv6qDcCGKCaLDMSWAL8xO+UEM=;
 b=krlB0Be98j8GZBuFoscKnjPfw0FuQq6RXlgGeUI+x/6/yy9bvq2SxS/FF3RUoEVJhDzKOSTGF/1bh+5Z8Mk/zGS46VOum0fk8W8fMFmiWR0S3XvMiTfcI5j0w3clbajxZf6vqZDVUXgq6qYoqmOPvNO6y/ImR8IF0Hzd3kbF4dXNlMcN44mwZpmZJ1B7dyFy4oNuTi4sfDGGe4nSq2JTFih6KqsgM7zAvGAqvUjNHVi6YMJ6dZR6nqljQzKE7tSppUm2Sb8PYMbUfNsIMA9OEiUXpJVWxdxUWrFx5XIOAnSQXPmwwv503bUXuaCazPNM2XJjKpmaoydA14D+1SIUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZGNdP7zM5p1oNK43cAv6qDcCGKCaLDMSWAL8xO+UEM=;
 b=SvukTTYLTMNQi3pPWRCzRYG27XaLm1kksowlnEUutGVAeDzI5q9I2HD0V68PQr5PiLM9XGv7dYvi7kjQQyKxftrkVSo7pdFN3WYZPE6gWuOxLPYefBZ2TU/B+iXAJE69eCiODgUFJTc0uXEKbTPJaC/WssdpL5PUZ4YbbBy5tokV8VRwA6e6uqrlP0GuhU7NzuWDW+XP8ZW5JTT8gKmr2iQZtM+P6g7wUb8sYG+VqhtML+VyEBU23Yi276cAgsL2MXFCJGXyfTfSaKPNl2uRD9vWg6VyOSTe3Hb4w2cohH5+lszaMdI8hlipckel6YvP8dMEybA7wnci8AzFY8xUlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Mon, 21 Apr 2025 15:00:32 +0000
Received: from DM4PR12MB7646.namprd12.prod.outlook.com
 ([fe80::d87:f674:2f:1c0d]) by DM4PR12MB7646.namprd12.prod.outlook.com
 ([fe80::d87:f674:2f:1c0d%4]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 15:00:32 +0000
Message-ID: <28749eee-7dcb-4f25-923a-0a858a661610@nvidia.com>
Date: Mon, 21 Apr 2025 18:00:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-pci: Add admin command length check for device
 writable portions
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>, Nitzan Carmi <nitzanc@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
 <1745147945-194225-3-git-send-email-israelr@nvidia.com>
 <20250420073230-mutt-send-email-mst@kernel.org>
 <b9e80050-9d09-4ed7-ab05-6a23a8e6e6a9@nvidia.com>
 <20250420090604-mutt-send-email-mst@kernel.org>
 <f8ee410c-bfbb-4364-8e1e-c73ee7147fc6@nvidia.com>
 <20250421071734-mutt-send-email-mst@kernel.org>
 <af1e660c-3252-4f13-b0a1-4718e5ce4420@nvidia.com>
 <20250421101137-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Israel Rukshin <israelr@nvidia.com>
In-Reply-To: <20250421101137-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0027.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::11) To DM4PR12MB7646.namprd12.prod.outlook.com
 (2603:10b6:8:106::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7646:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab103e6-0d82-4b5a-a402-08dd80e54344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjlhbi8xdUt6K3VGbm1aMlZLeDVsMXZSWkN4ZjZvb0d6MVYrRUI2Z0NyblRL?=
 =?utf-8?B?Z0xuU09WcHh2RmZublVPZ2gwbW1GM0x6aDVGNm9sd0V1aitaSWpwWnN2eUNF?=
 =?utf-8?B?aG4xTVpGeG8ycmxtRDlWR05VZ1hVOHlDNmlPejNFay9FR1FDZFdLZjIzK3Bp?=
 =?utf-8?B?Nm00MzFkbitjR1g4ejFQK2lkclg3dkxtYjJjaVI3aCtxWUNHU1BPY3dpdlBi?=
 =?utf-8?B?Mkp3S0ZPZG1xMWFXS0xjRGJoakk2RDRTekRDc1hUS3BzdHBteXVxczg1K1Ni?=
 =?utf-8?B?VlBEUVAzampNbEJiREtJQmF0TEczVzJzYkhkTVdEWjBHektOUkcydXhtUEor?=
 =?utf-8?B?eWgzUyttYVhJd0FRRmZyUkNlQ1dHQjcvNDZZSndYNGZ2a3B4K1o2Z3pHQytV?=
 =?utf-8?B?S1h5V0dzMHIyMHBlMElYSG1uV28zUXd2bXE3aFdGVGJKUjJueGdJdXFkWDMz?=
 =?utf-8?B?VW1XaWVFeHRxTTJnZVVsdmcxaVkxTFNIbGYyTURiTWZZeThtanNydlRqNy9S?=
 =?utf-8?B?aTJteGpaZ0hRUC9MMmFzWm5JWStWUFJ1TVQ1MkNWWGVrWWkwMllVRXI4N3p6?=
 =?utf-8?B?cHFDR25HaEd5UklmUTZWSmlicDRWZVhWMlg1NHFpVklMcTNVaGlFczl6QS9i?=
 =?utf-8?B?RnZzRk4vSmhaWUFVT2hGK2wycnZvVVByVCthZ2h5NndtU2cveURUMDR2ZElW?=
 =?utf-8?B?U0Yvb1V4Vk1uT2ZXNUZLU0dmV2ZaMHY2SHlYUU10SXhYSVEyVENsTmQyemRv?=
 =?utf-8?B?SXpEQVl0Nm8vSDZDYWZMSGYvSVdHTytNOHBOTkVydk1OY0hYL1lpQXBHS2la?=
 =?utf-8?B?N1NBQkpBSG1OQlloYlV3V3RnQUQ5K21OY1VDVHpVa0hLNitQbEEzZVYvOHlR?=
 =?utf-8?B?L09UVUtXRjQyUGIxQnN2blkxWGVpTTNvT2Z2cWNLd0VzWkZZUXh2bndZREM3?=
 =?utf-8?B?cVVJZVdwMXpGZGtJdXdMRXdITjBhZitURU90eElsdzNFZEtlN0VYNDU4Wmxy?=
 =?utf-8?B?dUJlQU0vaE5jcGFwRWovS1JKMktzcDFTQm1HanBEOWN3WHlKRHZyY010Wk5J?=
 =?utf-8?B?ejBwaGNEVkhMU0tjc0hpSlRpTmpCVktCSVoxRUFLTStHcjEyUTgvYUhHRzB0?=
 =?utf-8?B?QWxqSUdvYjNrNjIwNG1lTmVCempuTXhzOTU2UVJ2aUJhVjhnN3FXRW8yUVFw?=
 =?utf-8?B?V1A1YVk0eUlXU1IvS3JpZFBYakdWcWZ6UnJVc1hoNFIxOXR3RkVxbWtVc2Zw?=
 =?utf-8?B?Z0U0QmQzbXdIb2JJdEhjYkVud2twV2VEMmpCcTd4dk9nZ1hkaVVTWDcyRERz?=
 =?utf-8?B?WGNvbEJDRytGd2ZOMjlDdmFlSjVWKytVN2xaOVhjMExtM0lyQ3pYZnlsUjYz?=
 =?utf-8?B?eHBnaHVtMFpjWGRpdFUvdHl0Wmw3TElPcnV0cFBmazUrRHg0Y3ZnWTdKbEdC?=
 =?utf-8?B?akI5RFF5SGx0TUI2bGxwdmV0Wi9PaGJoU2s2eWxVN1R2QUhvMldxME9HSy81?=
 =?utf-8?B?UFY4L0NzZUNFRm9sWkd1THZFYldyWU1ubkNNTEE5SlBoVTFwNmZUbG1oTlc0?=
 =?utf-8?B?NCtyS2krSkhZUGRpenR3Y2Rrai96enpmb0Iya0hBcklNenk2eEVpRTVKT2pn?=
 =?utf-8?B?SVcwTDFKeGpVWk1Zd3Y5SzErRGx6Z3pyZ0x0UlRLaEpVRWZnTmkzM2Ivb1VT?=
 =?utf-8?B?OThjQ2JlU1YxWkRvcmROTGFGMVNvaW1LT29KQXZrTEFucm0vVU92WldJanQr?=
 =?utf-8?B?S1BoeE5VTDQrMUtQTFlIa3hkbzZJbFZWelgrc084WVRXUVdJMUtzcTZCamtY?=
 =?utf-8?B?WXdoa2RIQWZ1ZnhwejhTVVlJOTMyZnc4QWhDNWZCRFBpbks0S0NDVHZHcEdE?=
 =?utf-8?B?UEMza3RFd2JueU85Z3NEa0ZUY05DdWJsRzZPamNETS82c1huWFA4bS9PWXZS?=
 =?utf-8?Q?zEYit+ZCeR4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7646.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0JNZEYxTzR3Z255cGJrbklnTEpoMklPYVJockdnZjVQS0FTYlUyY05qMzZi?=
 =?utf-8?B?UUROMlpjT053Zm9PK2dCd0lhOTlRYTlYUHc2SHVjWjkxVkIvZEZGei83NUxm?=
 =?utf-8?B?UVpDbEQwcGgxQWN1U0g0aEk1b3pCQ3hEbnZKMkNhWkIvL0h3WGgxQ3JoTjBq?=
 =?utf-8?B?d0djSFNNbzh3MVRSTFRvQ0Fzd0QzTy8vTkd4eHJldS9hOVorMjBPeVFZeTla?=
 =?utf-8?B?czlkMW00NFYrWlJadUFKc3dZblFtOWJvcGoyUU03cmF1SmMxUHduTStmdWNo?=
 =?utf-8?B?QThFV3JDY28xNFJwUG1XQlh3WENwYW1hL3daaDg4dXYyRGRxOHF2Vzg3U3lj?=
 =?utf-8?B?QTZpYi8rSVVUMGw4dXFKNTJoeDhpcjM4VkZYeTVLQmQ3UjlzZ1dscnFPbmpB?=
 =?utf-8?B?eEdmL0twd29IcWRzZW1pUmFldWoxRk11RE1URjk3bjhFTDdyWW01Um8rTm5m?=
 =?utf-8?B?aWFjRzkwZzV1NGJ1bEVTYTA4Q3FkMjQ4OURLTzlnRWVyZWhFMHV3Q2I2MVBD?=
 =?utf-8?B?bTZiWkZFSnFMblBneDloSnRETEpoWUNmVjYrV1Ntdk9PTCtzLzNaS3VFb2Fk?=
 =?utf-8?B?M2pLQlVWOUl6bVRlcGEvUlE1S1QvZUw5bk1sTTlpTlo2LzJPSXh0NTRLbUFY?=
 =?utf-8?B?SXJJWC9vT2VHaCtSaTdKMW4wNDNFeEMvRHNBTEV5WnUzQTJGTFZRcG1FZkJs?=
 =?utf-8?B?ZmEyV2NNVHdjY25ISGs1YzFlMkZNdC9pSitJRSt0RmZLTVdDRGJGMmtUcFlm?=
 =?utf-8?B?cHlnOG9MOHJqVTZEQkJ0cVNQb0lheDV6VWxha240Qjl6QWk1RmpKNVZoN0xi?=
 =?utf-8?B?SmtnajYwbkZidHY1Ti9BcDYreGpGTW1WcHE4dXZ3M2h1K2RubzQrY1V4Zmxy?=
 =?utf-8?B?OFZNWkFuNzhZbkMwbE9ZRG55MU1oUmo0bjgrT0N2OEZoVjkvdFdFeVIyeVI4?=
 =?utf-8?B?UmRsR0RaenJVa0loeFRBSjRVU3l1VklPUDlvSm52ODdiNWZJdnRRS016dE9t?=
 =?utf-8?B?YVd3Nlh3c2xjNC9YUlpWZzJaMWdJM3lDdVBuOGZibmhXMUV6cnorL1pMcy9h?=
 =?utf-8?B?ZEFYdzk0amllZ3g4d2pHclFKTFM3TitXZW9HNXJmSWRZL1Y3N3RlelVaRzhz?=
 =?utf-8?B?eDMzalVHdmFxTXhpZjZ5WW9sMHZpYnZ6Ri9WV25xK1V2Z2U2WXdta0RQWGgx?=
 =?utf-8?B?alJxUTB2eHVteXk1RERBaWN3YWVxMjMvL0p5WStJRjg4UWQzVkFpU1NES0I2?=
 =?utf-8?B?My9OQm1xK09HVlZ1MUtreU1XcjY2T0VIRFlyaDgvaGRBbTlWZm1taGIrOUtk?=
 =?utf-8?B?NjJ1VFhzdEI3cVl2dGd5bm1vSVZVMkZLZDRhdml5VGMrWFZSeUJ1STBvT2V4?=
 =?utf-8?B?cTBhbFQ0NmdPM1ZzZVBXY290dC9PVUJmeHlqTUk4SXl3Wi9iZ1JWMGF2UEhQ?=
 =?utf-8?B?bk1DU200bWhSVlQ3d2p1alFjZU5ZQm9yVVUxV1A1QkhxV0xSWGNkWU03azN4?=
 =?utf-8?B?ekdKbXRJbE1UZmRNWWEyU0Z3bUdxWk8zZDV2b1lqSGlpbld0UVY4LzRrZE43?=
 =?utf-8?B?TGcyNDljUktpN2xOOE9sMHhmZnQzZSt0MVNuZ0R6V1dhRG1ZK2dWaFVvZDBy?=
 =?utf-8?B?L1plZTBrZEc0eTZSbDRFaTEyRmdxSjkrbDZ4SXhIdGtuMmozWEtBT3NBNzZY?=
 =?utf-8?B?YTZ1SFJrTkprdkh0NGpRM2lFVTZ1djRjdzlDS1doYUhSL3dQUGt6enEyVHUz?=
 =?utf-8?B?blRpNHJHVlNQQVM1SGF3ZUdoNVRJUGlqU1lWbVE5T3dnSmNneWwzeEFCaW9z?=
 =?utf-8?B?aWk2dXZDTERIMEk3cUt4dXVSdFZxRnJTUC9GM1NQak9WOU5HY0IyakRNRi81?=
 =?utf-8?B?Qlg1OVVocWk0dGdnOGNwN1l1THNpdE55QUFvSEFFck5LL1FLdHRGZWpKUkR1?=
 =?utf-8?B?VGo4Z1NxRHVpdy9aTm1NNUY1dUo0enZpWGpDdDZyR3BzNEhxZzJVT09vaTIz?=
 =?utf-8?B?Y1ZRWmRid2hsT0ZZQ2hJSExMUUNkaTR6aGs5SnR5KzhaTGlMMUtwemFneC9K?=
 =?utf-8?B?V3RLcEd6bEwwdWg1WWdscW1xeHVVMHFWdXJiVm42OU8yVVNxaUw2aThidmcr?=
 =?utf-8?Q?UdRqvWJxOrg/x+lJjW4L51BA+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab103e6-0d82-4b5a-a402-08dd80e54344
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7646.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 15:00:32.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjvDQE2A3OIcATvYeHPShuIO7NQmN6ZmpIFRGhm3YC7x9I+thWf793vA9uEXVelvypGK/SpmoiefXTO9Yl3WqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159

On 4/21/2025 5:12 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 21, 2025 at 03:36:21PM +0300, Israel Rukshin wrote:
>> On 4/21/2025 2:29 PM, Michael S. Tsirkin wrote:
>>> On Mon, Apr 21, 2025 at 02:05:27PM +0300, Israel Rukshin wrote:
>>>> On 4/20/2025 4:07 PM, Michael S. Tsirkin wrote:
>>>>> On Sun, Apr 20, 2025 at 03:31:25PM +0300, Max Gurtovoy wrote:
>>>>>> On 20/04/2025 14:33, Michael S. Tsirkin wrote:
>>>>>>> On Sun, Apr 20, 2025 at 02:19:05PM +0300, Israel Rukshin wrote:
>>>>>>>> Add a safety check to ensure that the length of data written by the
>>>>>>>> device is at least as large as the status length. If this condition is
>>>>>>>> not met, it indicates a potential error in the device's response.
>>>>>>>>
>>>>>>>> This change aligns with the virtio specification, which states:
>>>>>>>> "The driver MUST NOT make assumptions about data in device-writable
>>>>>>>> buffers beyond the first len bytes, and SHOULD ignore this data."
>>>>>>>>
>>>>>>>> By failing the admin command when len is insufficient, we ensure
>>>>>>>> that the driver does not process potentially invalid or incomplete
>>>>>>>> status from the device.
>>>>>>>>
>>>>>>>> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
>>>>>>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>>>>> ---
>>>>>>>>      drivers/virtio/virtio_pci_modern.c | 7 +++++--
>>>>>>>>      1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>>>>>>>> index 7209390a5cbf..0374e86aece3 100644
>>>>>>>> --- a/drivers/virtio/virtio_pci_modern.c
>>>>>>>> +++ b/drivers/virtio/virtio_pci_modern.c
>>>>>>>> @@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>>>>>>>      {
>>>>>>>>      	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>>>>>>>>      	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
>>>>>>>> +	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
>>>>>>>>      	struct virtio_admin_cmd *cmd;
>>>>>>>>      	unsigned long flags;
>>>>>>>>      	unsigned int len;
>>>>>>>> @@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>>>>>>>      	do {
>>>>>>>>      		virtqueue_disable_cb(vq);
>>>>>>>>      		while ((cmd = virtqueue_get_buf(vq, &len))) {
>>>>>>>> -			cmd->result_sg_size =
>>>>>>>> -				len - sizeof(struct virtio_admin_cmd_status);
>>>>>>>> +			if (len < status_size)
>>>>>>>> +				cmd->ret = -EIO;
>>>>>>>> +			else
>>>>>>>> +				cmd->result_sg_size = len - status_size;
>>>>>>>>      			complete(&cmd->completion);
>>>>>>>>      		}
>>>>>>> No this is out of spec:
>>>>>>> 	Similarly, the driver compares the used buffer length
>>>>>>> 	of the buffer to what it expects and then silently
>>>>>>> 	truncates the structure to the used buffer length.
>>>>>>> 	The driver silently ignores any data falling outside
>>>>>>> 	the used buffer length reported by the device.  Any missing
>>>>>>> 	fields are interpreted as set to zero.
>>>>>>>
>>>>>>> so if status is 0, device can just write a shorter buffer and
>>>>>>> driver must assume 0, which is success, not failure.
>>>>>> maybe we can make a sanity check that the len is at least 4B (status and
>>>>>> status_qualifier) which is basic size to make sure device is acting as
>>>>>> expected ?
>>>>>>
>>>>> The spec says nothing about this. Just zero-initialize the buffer
>>>>> beyond len and be done with it.
>>>> What do you think on the bellow change for v2?
>>>>
>>>> @@ -56,7 +57,13 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>>>           do {
>>>>                   virtqueue_disable_cb(vq);
>>>>                   while ((cmd = virtqueue_get_buf(vq, &len))) {
>>>> -                       cmd->result_sg_size = len;
>>>> +                       /* If the length written is less than the status
>>>> size,
>>>> +                        * the remaining status bytes stay zero-initialized.
>>>> +                        */
>>>> +                       if (len < status_size)
>>>> +                               cmd->result_sg_size = 0;
>>>> +                       else
>>>> +                               cmd->result_sg_size = len - status_size;
>>>>                           complete(&cmd->completion);
>>>>                   }
>>>>           } while (!virtqueue_enable_cb(vq));
>>> Can you please explain what exactly is this change doing?
>>> The changelog claims all that is done is adding a check,
>>> but that's not true: previously we reported the whole length. Now you want to report
>>> length less status_size. This is a userspace-visible change, is it not?
>>>
>> Sorry for the confusion.
>>
>> This change is essentially PATCH 1/2 from this series with the addition of
>> handling the case when len is smaller than status_size to avoid getting a
>> negative value.
>> According to your comments, I will remove PATCH 2/2 and post only PATCH 1/2
>> with this change.
>> You are correct, this is a userspace-visible change, and the size currently
>> reported in virtio_pci_admin_dev_parts_get() is incorrect.
>
> Sounds good. My only question is, how bad is the current condition?
The migration fails if the state size is exactly 4KB, because the 
allocated buffer (4KB) is smaller than the amount the user is trying to 
read (4KB + 8 bytes).
For other state sizes, there are an extra 8 bytes of data at the end of 
the state.
According to the specification, the device at the destination must fail 
the migration because this is not a valid state.
> is there a chance userspace will try to work around it?
I am not aware of.
>
>
>>>>>>>>      	} while (!virtqueue_enable_cb(vq));
>>>>>>>> -- 
>>>>>>>> 2.34.1
