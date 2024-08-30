Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E6712B17C
	for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029199; cv=fail; b=NpwU9hpowzCV0gN3qUPFLn54TJDKSHqkneopCjbmG7tT0lSnJPXtVokRVFSqqyFuK5JxP3nIWt2deAHZt/OePtgSpQtlpjbpLJB/h4rqxdG8x9f9DUuqx800HICDz115P4mqdibF3IwMyGTgYJbWh6egijvZeMAQwftWfeOKSOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029199; c=relaxed/simple;
	bh=bDmLrYmgjLvUX7tA4UN8RAOLFS4VnMYVk3K6+g72BkM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q8VwhPv9rZNX9OACWxlLMZBrrcrbhxYDCqZtDHeR57dk/qWwjqdT3PlvBgHZ1MdaTykrcKWNoqQUIDu806Ltsnpq1/kTbu9WNgCiBmHXBslJL6viHguqD9BpUMnouxnfHX8ZAbB/viHXGl7O+0wx8ZfNGPEXPwOaC2aiTvcOG6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RD/vTGmd; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RD/vTGmd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2yHCrSUE/dKM8GCa1kfeT5pjzCkzJDbwjD4pt6Cch4pLauDQ7mnGWEsmYUOuuVL1/goTWXuIxDdeDpvrmnAZ9OWTNZLAAqPDR7GtNNESv3y6ny4XHlLXPwWWqr+XmCbWyj1hJV9vPxLxU9ZYDRhOJTxPOBUuv2xY82oowZ1twibspAujuDAN+DJ0S0npHgEUMzMJuPk+VNsXSQ1LcEAMweIhroXbp8XnNp/gETAuNmJjYYTNQ0RyGfEdYngI/LlyybEYJomiVUMMOL9u3Cr3AWG8wIrJ27sa0d/MYb9FxQzh4Wo3E7h63cZIt5V56E9Sa4dToju+S8kjs0PgiiV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5oi9/epO3wdVTeDlXOH7RicqYn2oq0kEarZ+SxLWVg=;
 b=CPC0d8Gm0IKZloUJBhFSyv/yrXiFLL1MIp8p0da9fpB7EqFuuTCXMI+MyttL9tzIxIK7Zyv6Xd8MezqMMLcOJaBInIRbnkDCkGJi0oIys8y9Xh/L5Qkfqcqf/r7IAqt3/9ZTRWyRRnKbmY0asRvnUAnTKdVpQkzxiYg2GIqB6L/LRTQLlNnxXNz6zdEWFfzVvo3yx4p+Gm989FKuZ/7+QR1f+KQaXLDCGmn+e0BbfnKbNPb5gl9BW0STNBes61BV5DqbVaK0YjtohZKc3AJqwvXSa5+OO189Zd4RhFH/9T/Itbq8gPX0xN74jkSFa5hLgMGyn7M9Nt0gA3nqct1lBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5oi9/epO3wdVTeDlXOH7RicqYn2oq0kEarZ+SxLWVg=;
 b=RD/vTGmd5qX9FTcwpCww/GaKVqbKni10poEafaPIwY14Bi3rn9PaTc1Vj3h0SMYeZlqup8ADwrgZjIN6J+unPwzq7tUIvxRfHc+4cQtqy0osEe8Ht4UlNayq4af0tgJXVzyVFVFrtGWpNdWDb1OKbbdN6+EZvq++KWHnpLe0Suq/7vqO7gldtEkxF9OtCE+akhMlj9qZZsaMe3u+hvoGFL8yJ9q0lEB1IsllQisVRwCGGzHEUVI/KcmPOFrWxxyPT0Luk9wsE+w9DDNvVcGDl1WaIyiq7HolYaKh4bvGPWTBtgaJXfraGRo2+zQDaT0Ar48MSrWQt2d4uy1kSStk3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Fri, 30 Aug
 2024 14:46:34 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 14:46:34 +0000
Message-ID: <750da215-adea-422c-8130-7524671a8779@nvidia.com>
Date: Fri, 30 Aug 2024 16:46:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC
 set
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240827160256.2446626-2-dtatulea@nvidia.com>
 <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
 <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com>
 <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
 <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com>
 <CACLfguUZVDGaY4MD+_tDqM9DQC-C6cuPfCf34X59e2RkMztEkA@mail.gmail.com>
 <cfece74e-a979-4f74-8a6a-fc8869e354f7@nvidia.com>
Content-Language: en-US
In-Reply-To: <cfece74e-a979-4f74-8a6a-fc8869e354f7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d606a9c-d5bd-4700-db84-08dcc9028b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enJYem9tN3psSjFVdHl5R2VnZm1sQ1FIYkdOWTJqS0NqVzBVSjRGOWpZbUNR?=
 =?utf-8?B?R2ZiOTZtMW9sbjBsaWhGdytMZWNYZldySnNmTnFuU0VxYTVmMllqU1BwNVc4?=
 =?utf-8?B?UUhJWVhaN3VIRE9pWWVMNUk3OGxGZWtTYnpZZ1FrOFkyZWVYTFhoLzdhK1By?=
 =?utf-8?B?b0RydUVSRk5Ra3JDTWlyZTkyS1UxOHBud0cwQ3JHdFhFUVNpZ0ZQN3U3UmJN?=
 =?utf-8?B?S3NxS2ZmVFZ0R2RNSEREK2t0YkVtZHJUWWJnRHZnaWUzbDQrQjBmdytKWnU0?=
 =?utf-8?B?NUpNR1gzN05sNjRvT042ejVsckFDUmtYbkZKZVI5TnpiK2FRVnN3N1BXNlRV?=
 =?utf-8?B?THgrT1lmZ2wyMUNUWllCZEczY1Y3WG5EYzk0QjA2d0E0alhFZzhkdjlqNDB3?=
 =?utf-8?B?VmpMSGQ0SUdHUUtNSGFhNzVacTQ4c0xaY2gzL3dZb2dSbnVBays2L2NkNjBn?=
 =?utf-8?B?RHlKUWowTjNvWW1TdXZEL0YxcSttaGdkL2U1ajQxT3B2cTZSMXU0V0tCYVRY?=
 =?utf-8?B?MFlzbTEyclNMZi84SG9nWmdDNUlTNHVyOGg0K3F3di9oNHZ3QiswaXBYd3pB?=
 =?utf-8?B?TFF6dWIxRjNrSzRYaHV5VUdBQlowTWxRU1lFUm9VbElnY1lSZ2FCOEttU2JN?=
 =?utf-8?B?N3BRY1J0QXNaZmhnT0hYbmlqY0ZsUEtYWlllSXNnQm5sQW14amJCZjBSNG8y?=
 =?utf-8?B?U2kvZ3B1M0oxK2w4eHVtWXN5KzNDTDNua0lqb282bVAybU4wbWMxRUp5ZkZZ?=
 =?utf-8?B?QVlXamJRVlA4NFNZWjU1U1dDdkZDT243VEh3SXh4N1poU1dqUUovYW8rUlJN?=
 =?utf-8?B?bmZ3UDFRN0JvN05OdXJXN3ZpRWIxK0dseER6ZnJmZUpKWHJ5UDNhbkJUT08z?=
 =?utf-8?B?elNrQkRncUM0N0FOUjN4bzNadVpiSUVhMDJIWEhGOU5kR2ZwcldlOWNmODgr?=
 =?utf-8?B?L3dKb0oyekNDOS83NlRtTDA5eUMwSjlSTFJLUEMrakZCZUltT29tZ3FER281?=
 =?utf-8?B?eTFwOVArbnFoejNhaCs5MTIrSGtRTjdpLzNnYjhuWGh5WTd6bUoweGxTenF5?=
 =?utf-8?B?Rm5pcFZMVmlkSFZGZldlZENvUytCZERiRnZVL29UWnNsVGExU251UTdSVXRL?=
 =?utf-8?B?NkNIZlNWWnEzdGJ1bjB4VkRBMHpLcmpFMWlRQkZ0WWxCS1ltTmxOazZUTk5D?=
 =?utf-8?B?d2hqQklULzZBYjBQMHp3MVgyZWlhRXUrM3lEWE9EZTF5WGRPamwyVWdxSXha?=
 =?utf-8?B?bGVrSHJvZzUrV29RRTI5UVpMNFZ0NjQ4a3p0am1FWDRBcVVwRXp3akZUanZ5?=
 =?utf-8?B?ZGNJWnVmZEYvQmRKbnRRQU1UWm5LQjJaRTgrUnRlOVVjRFJwM3ZHVGlLczNu?=
 =?utf-8?B?Vyt6M210cnBDalR4eFc1VFRWSVJ6YWlGM3NreVNlMzN6cENuQ2V1bTF2dE5Q?=
 =?utf-8?B?Z1ZYYktyWCtpL3pLSEtTeEtscTYybjVKZlMydlFPYld1WVFaaVMvb2s5OUFl?=
 =?utf-8?B?QkwrSkdqWE9jMi9wcXdCZFN4MkJucWs3K2xEWE9yaTIxbm9KVnpxbGdKb1FI?=
 =?utf-8?B?WXp5UnM5bkdxQ2NDbi90RGVybnk1WjArUnVKRE9WRWNHM21iSmtIaFIreUhp?=
 =?utf-8?B?WkF6MndCcXpEQ1dGRUVGaEpZSEVpZUQvOThJUFBWNkdaek1NY01oUk1MaThu?=
 =?utf-8?B?SlB1a0I3RmI1UzB6bGtUTCs3U2J4b3RRVXdFelpTVUhaeXAxSVp6cXNkSm9W?=
 =?utf-8?B?Wk5aSzZkYkpabzJpZEhmaFpSSkZJQnA1Yy8zcWZubkxDWUVueEQxK3RGVG0v?=
 =?utf-8?B?SjltQTVDaENmRUcwY01RUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0owN2NzZmgvRmVEU3ozckhzSWlWaVArd2JpMjZaRFlmVk9SZ2F6aDQyRk1j?=
 =?utf-8?B?VkJ4WWwvcWt2L3NHclRHUXZjVm9BclhJaVlLWUJHb0xmMFkxM3JQdHlNR1gr?=
 =?utf-8?B?YWJPcXZIYWlYYkQ4aXo1Q0IxV25pLzl2V1FmQnVXRWlWOTFTaDkwaVoxS3dy?=
 =?utf-8?B?R1RaSkJnNlNBY3JMSnZqb0NWMXo4ZHI4ZEhTMWNxdjFjVjFqdDNvRklmeWNp?=
 =?utf-8?B?MVdjVmFYcXBJT3ZVUk9hNmR1czh5UjErd1plc3R5QUhuR2RFQ0xsM3RQcnZL?=
 =?utf-8?B?M2w4SlJDUk1Ha3lkbmcrY1J3Q0gvbnZhR3dhRGpBUWZQZVJOOEtCd0J2Q1ZL?=
 =?utf-8?B?WDdwVlp0cDJqNzF1UFoyMnpoUFQ1dThFU3h6TGNaQ3ZiUTZkTVE0dDZYWEE1?=
 =?utf-8?B?RVNpZGhjdXZ0MU1tWCthWTJIaUdXYzRVamhjL1JzQ1YwQWpmUERUamU1TU5i?=
 =?utf-8?B?dU84eUQwOC82dDhwY2d0RE9JbUEvSzdXUDBMT25LV0Rkc2gzeDIwYkdsTjVE?=
 =?utf-8?B?c0FkM1gvMkxaSWRBakJlQXlZbjdsc2N6QTdnem4wR1FiUWV5ckNacEdNUDRZ?=
 =?utf-8?B?NzgyZmxUQnc0cklBQmFVS0E2OWxCckkvK2VEODNrNjQ1Z2pheWhERWNhbVln?=
 =?utf-8?B?Z1BlcER3azM0YTBiU081Vm53VWdwNjFaYXdmY2xJVHVoTHFxQm95WGQzYWZO?=
 =?utf-8?B?MGNadjlaYnVzZEJqVE9MOGNmY3d2SS83bWRKdHd4MDVpeHdRbTRrR1NJVUkx?=
 =?utf-8?B?RUthKzJhaXhLQWl4RVRjMktjQzkrZnFxdHZrRXQ4OGs0Y05xSDl0MjBrdXc2?=
 =?utf-8?B?dlRlSVBSSVQ0MTZHNDdzOU9rQ2RTYUVIdmU0VjU1Y3R6OWR6a0MrTmYwRDdo?=
 =?utf-8?B?YmRSTW1qem5VOHJ6S0pTZFR6Y1NMMG9pS3pyZE8wYmxaS3VCNlBQblMraVRR?=
 =?utf-8?B?enlnVG54M2R3Z2RHUUZxM3MvQ0FRcDhIZkVLVUt0L2hFZ1k1RWFIc2RhVEdt?=
 =?utf-8?B?OHdHNTZwTjJndE9LeVZaQlp2aTVBMGNCQ3lndFpBWnZLa3FaNGtYUzRvNUlp?=
 =?utf-8?B?dk9EdCttenZtNHlRSzFmS0V4Lzlua2dCRDh4aTRaeEJxajJIVlpQWmFDSjhB?=
 =?utf-8?B?S2gwcklpOXZHdnZrSUV5THNURHFERmk3TWxWemVxaThYZCtDYm9Sb2ROVG5s?=
 =?utf-8?B?aDZSQVBRNWhUV0hpeWNJczg2c3gvZng5WTdra2VJdWFkNC80emFOZTFPOHFh?=
 =?utf-8?B?cXZxVHptejQwekxsbFcvNnFpMTZPN0J2K1NUYUZnR3d1NGxwN0drbk1SSUhM?=
 =?utf-8?B?ZnBrMS96cFRTVjBKNUcyMVZ0SWVYank5MVAvV0I5WktXMjFYWmpKKzVNSzVi?=
 =?utf-8?B?cFdCTkdGTmcrazNmenl2N0o3Wld6ekZkaWxXQkJLdWtoeEtGN0pqbTBQRnpn?=
 =?utf-8?B?S0NvWm5UQTR6YjBJbTNGNktXT3p5V2E0ZTlYcVFEQU44UXRCWHdTRWVOa1Mv?=
 =?utf-8?B?bm9GQWt5Uy9pSmFBdEtWRWVnbVFTRWNxQ0xwaWtZb1kzNWxrY1hyblFhWWMw?=
 =?utf-8?B?eVcrMmdnUkI4ekFBL0ZzbXM5dVJnRVdyUlo3cFMxK1YxdkpBcXVxYTc1bUow?=
 =?utf-8?B?endiNmI4a1g3aVNUb1NkeWd6MG9pMWlOM1k5MnQweTB5YzVwekRudk85RVlW?=
 =?utf-8?B?amV3SWdjbVpPTmFobmVGYjM1U1Z1YTB6a2JxeW0yVmk3Sm1XSEpkeStuWGZm?=
 =?utf-8?B?VzB3OC9sNStKdWFidjlEZlowOEx5OThNTWxqZzhSbWRJQzRnVWp1R2IyYmxB?=
 =?utf-8?B?QjhpajNmd3J6eGpmcktSRlZrOUNSN24xUldvZzNhMDhxODBKTjdDS25HYXd5?=
 =?utf-8?B?bEhxZFRob3UveTVSWmhHc3JUTW1Nck90RklOaGxEQmZBVXAwM01IQkgyNXR2?=
 =?utf-8?B?bzF3eHVCaWtVSmR0bUlLZUZtcjhCamJRK1Z4UTEraXFrNEZvMjJ0cTlna29S?=
 =?utf-8?B?eXBZdi9FZjlzL0pLL05NM0lvMUF4MEZzTWlzalQxbFVZQXVzTzRNMHhPUTdx?=
 =?utf-8?B?Q2VKMXN6Lzh3dlhpZzRQUDJvSjkwM3JiMTFnS2RHRHZZL0t5dmN5WkVaQ1di?=
 =?utf-8?Q?9n0I+NiwWWdBx/gXL8IrebLPs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d606a9c-d5bd-4700-db84-08dcc9028b0e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 14:46:34.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+O07xFEy1gGZw9PSbPENMgsy5oaaJhTT7VAHyQQoiAYgQD3Vfl2/Elpth85iI7AqrpmOA91Auyev2LAL+sGOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944

Hi Cindy,

On 30.08.24 15:52, Dragos Tatulea wrote:
> 
> 
> On 30.08.24 11:12, Cindy Lu wrote:
>> On Thu, 29 Aug 2024 at 18:00, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>
>>>
>>>
>>> On 29.08.24 11:05, Cindy Lu wrote:
>>>> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 28.08.24 11:00, Cindy Lu wrote:
>>>>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>
>>>>>>> On Wed, Aug 28, 2024 at 12:03 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>>>
>>>>>>>> When the vdpa device is configured without a specific MAC
>>>>>>>> address, the vport MAC address is used. However, this
>>>>>>>> address can be 0 which prevents the driver from properly
>>>>>>>> configuring the MPFS and breaks steering.
>>>>>>>>
>>>>>>>> The solution is to simply generate a random MAC address
>>>>>>>> when no MAC is set on the nic vport.
>>>>>>>>
>>>>>>>> Now it's possible to create a vdpa device without a
>>>>>>>> MAC address and run qemu with this device without needing
>>>>>>>> to configure an explicit MAC address.
>>>>>>>>
>>>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>>>>
>>>>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>>>>>
>>>>>>> (Adding Cindy for double checking if it has any side effect on Qemu side)
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>> But Now there is a bug in QEMU: if the hardware MAC address does not
>>>>>> match the one in the QEMU command line, it will cause traffic loss.
>>>>>>
>>>>> Why is this a new issue in qemu? qemu in it's current state won't work
>>>>> with a different mac address that the one that is set in HW anyway.
>>>>>
>>>> this is not a new bug. We are trying to fix it because it will cause
>>>> traffic lose without any warning.
>>>> in my fix , this setting (different mac in device and Qemu) will fail
>>>> to load the VM.
>>> Which is a good thing, right? Some feedback to the user that there is
>>> a misconfig. I got bitten by this so many times... Thank you for adding it.
>>>
>>>>
>>>>>> So, Just an FYI here: if your patch merged, it may cause traffic loss.
>>>>>> and now I'm working in the fix it in qemu, the link is
>>>>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
>>>>>> The idea of this fix is
>>>>>> There are will only two acceptable situations for qemu:
>>>>>> 1. The hardware MAC address is the same as the MAC address specified
>>>>>> in the QEMU command line, and both MAC addresses are not 0.
>>>>>> 2. The hardware MAC address is not 0, and the MAC address in the QEMU
>>>>>> command line is 0. In this situation, the hardware MAC address will
>>>>>> overwrite the QEMU command line address.
>>>>>>
>>>>> Why would this not work with this patch? This patch simply sets a MAC
>>>>> if the vport doesn't have one set. Which allows for more scenarios to
>>>>> work.
>>>>>
>>>> I do not mean your patch will not work, I just want to make some
>>>> clarify here.Your patch + my fix may cause the VM to fail to load in
>>>> some situations, and this is as expected.
>>>> Your patch is good to merge.
>>> Ack. Thank you for the clarification.
>>>
>>> Thanks,
>>> Dragos
>>>
>> Hi Dragos，
>>  I think we need to hold this patch. Because it may not be working
>> with upstream qemu.
>>
>> MLX will create a random MAC address for your patch. Additionally, if
>> there is no specific MAC in the QEMU command line, QEMU will also
>> generate a random MAC.
>> these two MAC are not the same. and this will cause traffic loss.
> Ahaa, it turns out that qemu 8.x and 9.x have different behaviour.
> 
> Initially I was testing this scenario (vdpa device created with no mac
> and no mac set in qemu cli) with qemu 8.x. There, qemu was not being
> able to set the qemu generated random mac addres because .set_config()
> is a nop in mlx5_vdpa.
> 
> Then I moved to qemu 9.x and saw that this scenario was working because
> now the CVQ was used instead to configure the mac on the device.
> 
> So this patch should definitely not be applied.
> 
> I was thinking if there are ways to fix this for 8.x. The only feasible
> way is to implement .set_config() in mlx5_vdpa for the mac
> configuration. But as you previousy said, this is discouraged.
> 
I just tested your referenced qemu fix from patchwork and I found that
for the case when a vdpa device doesn't have a mac address (mac address
0 and VIRTIO_NET_F_MAC not set) qemu will return an error. So with this
fix we'd be back to square one where the user always has to set a mac
somewhere.

Would it be possible to take this case into consideration with your
fix?

Thanks,
Dragos
