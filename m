Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54413C900
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887136; cv=fail; b=VAE30gH25Wku6w1gx4TTobBGOjw78sjx0EqKEg7GBIWMZ1DI3ZtI4UgSf6ITlSI+QgTT+KQoQAC/VkrdqGVK/XbL4oSHL0G2lR7m/cRnj00DD8YrQAi1AmHQI5ZqKaDv3eXG59tcKHM3pZcKiIpseWDcFJLrKItCAjzioPBpTg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887136; c=relaxed/simple;
	bh=aGY206hKlHyz2gDUTqEGhT0GVBQut/QYuK4e1yW5COw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8IqeNF3LSk2gxiaHOdxSCvRGkk+Gm5Ia+LE+1WG0x7fNW03D1ATOsf1uNAuuoaniFjGx6yclNEDOzyRyxqYvWNKFK3ow7Ci4Be1OP+/hfACj6OLVM/gdC8rEy/Aywk3inQ+LetYHGFMJujFBBc8oz3fVpIhJWQ9YQD6JP8APwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LDtdDple; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LDtdDple"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LT7tJxxyJKTZsGjWSw5eO/f/WgOaPrUA9la8EYaULLk3a9OBCgCoJY8bWNb4x7su8jzW2JoTUfsKUZsZZHtGo4bX1DYIUKyPLyDbEQfZPvlA98LVpWZtwdSRnerhwHqgFNfh9N1qi5sZlvLIJ3Gi4rssOOHem1OilkYvZJvM7CRyTUuN7xNsOm7wGjgN2ASfjA+o+JtxQ5j7V7b0MZP5VcZAERkVCLMeQ1s71RH3v1K54IjE6RQfhHIn/Zeisf/NGkCCY8nLQ05cuqoFAFCZSs/wYdSP+YWUn7lCsKJUvxV+hI8D4VpwOW/Mm4ICVPPWydqbUyGuK7xboV9kzmHI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGY206hKlHyz2gDUTqEGhT0GVBQut/QYuK4e1yW5COw=;
 b=mFKxlq1j25qR8N67qYqXjoSQ38v1iIWAsfGhmVCYfMiU0L5U02QYbkkOwbl90/M6vZuG75JPLVCekFHjxIAxJq86WdvhrZojqIJJaJTeSaGcSDngJkoXIIGOkPPdwyygyoeshhPuqpOn+pPub6b8mews2Oeoi55XBixEFUn/mafFw3QJrcMbxMPlnZuPJiIC9iVnNG+oSy9pOiBVNRkQ6/rqCCqND7xA9KR68pINbxtarADgiyScwrk9Es1AQenJ8pTakXjuOSjZUE22Na+s8ZBUuGGlEhIsFpC457EZSD5teCwrggubCSsH+qsc0Db+FxITDgWPUqN5H4BYXP3xmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGY206hKlHyz2gDUTqEGhT0GVBQut/QYuK4e1yW5COw=;
 b=LDtdDpleorOBmhUZq62oaD83mRhEClArjJIvswyEq6pI2kS0q0VeXhEHELhLFJWzC7A2qRaBn52Eofo2GqULoyJxpguAZHlDvRZ7NUHv/kBTVHxzVaqjCM3g2aM3sjv4OKUgGd76jfQZU8Tz06suTDD/Uq2u/ZXhJ6wL6VQIZv/yjLI822qx8QxEB1WRMeeOEAtI3S7VafIlpqCWHODsxF9F2zZzhosyaNCuJqpLgWAn+p3jYX3zGUC7I53gsaOTObmYajMrQv8BliQ+8tv2MlaoV+Zukj0sDDmho5rzAHNm6q6UFWbBB4eyah1PbWt6whVyLSXMPOzGCWsuQckc/w==
Received: from SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 09:05:27 +0000
Received: from SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19]) by SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19%6]) with mapi id 15.20.7633.017; Tue, 28 May 2024
 09:05:27 +0000
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: "vgoyal@redhat.com" <vgoyal@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "jefflexu@linux.alibaba.com"
	<jefflexu@linux.alibaba.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, "dgilbert@redhat.com"
	<dgilbert@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Yoray Zack
	<yorayz@nvidia.com>
Subject: Re: [PATCH 1/2] virtio-fs: limit number of request queues
Thread-Topic: [PATCH 1/2] virtio-fs: limit number of request queues
Thread-Index: AQHam92yba8hegvWYkG+XBs3ApVoXrGsfYaAgAAHIQA=
Date: Tue, 28 May 2024 09:05:27 +0000
Message-ID: <91722cfc27ff57a0963d4f55f5ac241a5e407f84.camel@nvidia.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
	 <20240501153817.540855-2-pgootzen@nvidia.com>
	 <6798df13-4db3-4165-a6f7-d8a7201b7093@linux.alibaba.com>
In-Reply-To: <6798df13-4db3-4165-a6f7-d8a7201b7093@linux.alibaba.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7833:EE_|PH8PR12MB6939:EE_
x-ms-office365-filtering-correlation-id: 3ed4d2af-38cb-4bea-e6e1-08dc7ef5512f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?enRxVmdxbjhkZmkyZm9iemkyR2hUWmdyZGtLYnY1V244aElYU2g0ZW0vbVRz?=
 =?utf-8?B?S0Q3MUFjQnJxeE9rM3B6eUc5SVY0cGdWOTBBbEIvQnNwT296U3BFejZXaXQ4?=
 =?utf-8?B?QUhuS2NwcGlXL0N3RnltNm1xRS9XNmoxbnhYWHNFcWhINFRrVFV6NUlFUWJn?=
 =?utf-8?B?SERtdjFmVStSWkMzdzd5eEJvZHBPY1BueE43WHlIMERkOGZuVEZVTlFXeXdT?=
 =?utf-8?B?T0Vldi8zUExtWWQ0b1E2bjZqcCtxalZxR2F5Mnk4cDF5RWRyYkZrVDdTL2I0?=
 =?utf-8?B?N29pOEhYTzdzQW5keXRKQUJiQUNNYnZyckdOTnZTbFgxdmtCQTE4NCtjOVRw?=
 =?utf-8?B?Slp2Ym9weUtKYWFESkpJN29GWU9XTCtxbjdhTUZYVmY4Y2hyK2ZDZnZKTkVm?=
 =?utf-8?B?SXpXUWQwWlIyTmFxRlZpbkt2TGpVdW1LdXZLdXZZcENPcmlqT1I4QkhRVGg5?=
 =?utf-8?B?WmErTmJWK1lKYlgzL3JLOEZHRUpVNjJpU1lFSFJKQmZVd29XYUNKVUhjRW1L?=
 =?utf-8?B?YTRYOHo4bDRseWRNR2RTN2hWT2xvaHRNcXlxT2IvN1VjUHpORzR2VldndVdr?=
 =?utf-8?B?L0hsQVdYZzBtQ2krMWNSUnk4ZkpaUE96dlNhTFhMOGZOVXA3dTNxeklES2gx?=
 =?utf-8?B?OU9UYzIyS1RnZlplUWIvQ040aTZUU2VRSU9YbzNVM1VvZGI5Q09xQ2djOHNI?=
 =?utf-8?B?MHF5SXg4ek93S0szKzllOFpnMFRtajhIZmRiSWwzRDJGSzMyOUxqV1ZwMGpz?=
 =?utf-8?B?cStMS01GeHc0aGdYOXYvUGZYcGxFRC9Uem1iSXFYSjJlNU9tdVFTUjdLL2Vl?=
 =?utf-8?B?ZHpnenFIWGw4eFFFZllmSG9rVmpBMkRzRmRjdUJ3QVU0WjlHMjBtZFh6SDZv?=
 =?utf-8?B?cVE3SmRHTnFWT0QxTklvWjF5MHBYdGlXTHBiYTR6NTZuVXdndDlza1VXT25m?=
 =?utf-8?B?eTB6UzM5bFRoTU5hekZIN0xoNUludlQ4K2c4ZzhrUko0T1h3UUNULyswelds?=
 =?utf-8?B?SUxaVllCWmJiRmcvbUgyUGw4ODN4Smk5ZzVVblYxaGtFbkU4V3oyRFdKWm9h?=
 =?utf-8?B?RHRWMiszR1EvQlNLR05KNGQ1bVZ0N3NLaEMyVmlIY1c5OGJNUExzOENmUzZE?=
 =?utf-8?B?dlNCb0MrWlFHYzQyOVpsdUh5N1VScEdpSkFxVEZ1QVZsTWl0VUpkSHA4VGVY?=
 =?utf-8?B?TzloQ2dOaHYrUEtTVHB2YjdrTmxEZ3Q3UWtlZG5OMm1ITi9kMm4rT0tLMmNB?=
 =?utf-8?B?dXhXWktUamtudklMZW00UlBTMVdiKzhhalEyMlBRS05CeWw5WktvQm0vbW1X?=
 =?utf-8?B?dGlIcUdJMGFVdCtOZWwvbk40SmNuSTgvR3NUQ2c0Yk8vNmxYMHh6d3BrVU83?=
 =?utf-8?B?dHNRR0o3TW1CSEs3clY4VEVudzFyNG1KMGV3SXhSQ0w1Qkd1MjlpSUhJOUpa?=
 =?utf-8?B?UGhFYXdwZmM2Qm1WMXQ3VVVjbDJVZzFKdUFEUnNyUjd4TFYzMjJOd0ExNUpH?=
 =?utf-8?B?NGdxdlh0eS9DTnlucnRIZHhJcDNkckRKL3QvaXdVZk16L0ErL05DdlhVczBm?=
 =?utf-8?B?V0tqVk5Edk9palhPQWd2RlZ5c0RrNm1HTDQzazFoZkgyMFdqcFN6cGlhSFdL?=
 =?utf-8?B?bzN3RTVHQzI3NmxiNkh3emczT2tVU3VwOE16TlR0THkxbS9vQnZiT25CL1J1?=
 =?utf-8?B?SE51NWNVTlVHS3p2N2NzeHRUUnpRTnhyazkrY3h5eE5Ob29MeDJRNWhwV0FK?=
 =?utf-8?Q?BLLMfunip+nfCnHIBexU8E+Pc/0sb28HfQWEi9u?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7833.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OC8wci9CUGdCTSswMjYrN1J5cVUwVDJTUVlNQzNGZXhMYWgvNmlROXZlelhB?=
 =?utf-8?B?ZU1rQ1VRUjFNVU9LK3dHMVJ4MGdqQ3hrT1FJdE44OHBoczFCYjg2TUl4TTdX?=
 =?utf-8?B?KzJiV0p1aS9iOFVjdzdFYmlWaCtIcXgwd2piRFJtWlFHYUJhUFp1UGJqTWln?=
 =?utf-8?B?Q2xVcEhqU1lPQzVpckhtQzVhZlQzalc4SjdwVWhIakdkUUdmZjBLYWJOTWJq?=
 =?utf-8?B?T0FJQjFnOXloQ2d5eW9ndkRTL3N0N0I5RlZCbDErLzYyRDg1WGRjS3FDc2p4?=
 =?utf-8?B?SklzL25iUUdPdmxRUHRtV2dYT29jREZQQUZkWUx4clNpemo0RnFHZzI0VkRS?=
 =?utf-8?B?MDlGQ3JnUEF2cTNhNnMyVGZvRU5XTFJpRUJ5eCs3WDJiSUZVSlNWeEpqNmk3?=
 =?utf-8?B?aEcwZ0FJMTYzTDRCZ2lOcHNYYlh3RGRPSkc2WnFXMXJoVHo0MlFCTXZMeXFV?=
 =?utf-8?B?SkVGRkpNWDRaNkFTUnVMS2I3QnBYQmtLaW15S0xKUEVxWnA0L0YrS3FhbjdW?=
 =?utf-8?B?RkRWM2ZzVDVMQjRqVzM0T3k0eDR6TFVvcmVOdUx6S2VoWEU4bjc2VUJIeWlZ?=
 =?utf-8?B?NVdwcisyVi85NnNtaXBkMTh2WlI4S0VzQm5Zc3IyVGV5RzBoQWFreDZDbStk?=
 =?utf-8?B?QTB1UHBaQm9GUGZNR3pQYlhDZEdGWGRuUFoyUUwyczNRRm9MdkR5dUZMWGlQ?=
 =?utf-8?B?YkJtNWI1NHRtYURmS1pYbmdPdTFOUks2cm9aQkpxb3V1N3BKY1ZUNktSZWhs?=
 =?utf-8?B?ZVhrSDZLZGVWVHNudTlXTjN3NUFuYlVyOFp2bXNGWnZPR1U0QytUZG5JeHlm?=
 =?utf-8?B?blJHSFI2VDIrODZBOXlhRUxKMXI1cXRyTTRpYWhvM0RrQ0Y4d1BrSjVsZ04v?=
 =?utf-8?B?bHdPQmtxdElIOXVkMnJGbyt5amhGZThlYnl5ME1lNThJbENjVmlPYUd6S2JQ?=
 =?utf-8?B?UUZyTE5FR1BXMkIvaHBvcXpGcTBsWTRiTmIvZXRMZThlRElHdDlOVUYwaVZN?=
 =?utf-8?B?eVR4QU9hMmV5bXpIbkdNMDJtNE5sUFRlTEZZK2Jqa0d3N3Bwd3ZDTE5wcTBZ?=
 =?utf-8?B?QnJXOVdjdzEvS3hHckxnRUdqY2JrNXdZTDI0ZVE1cm5oQjRobzRqelU3YzE1?=
 =?utf-8?B?RENkTnRpVk9kdGRVSmlIRk83TDlBMEloZjcxYmtPQWtwdU5KZ2x0MXF1anpr?=
 =?utf-8?B?Y3plNkdQWStobFZPczdWSVFxUnZWMFZzNjBwajVSazUwN1pjSmFTdjFBK05M?=
 =?utf-8?B?cXZUd1oycTYrcHdJek51QzBncmt2T2ZwNjQvcG1RMVkyUk8wcEFaYlgxMzd6?=
 =?utf-8?B?YjJEWmRoVUVnakRuQXVZblN5NWZHWFRYdVRLL3BtaGw2K3dxZWdiblE3QlNC?=
 =?utf-8?B?aS84Wlp1RVFKMElaT283REYwY3dVWTJCZWlFa1hGdWVXRmdUUGxKTDRoK21F?=
 =?utf-8?B?UWFKNEE2OHZtUkJaVFRTeXZoT3IweEY2Z1BhQkQ3L1dEZzJGZ3IxSEpXaXJK?=
 =?utf-8?B?VSswZVlZUWkwTUJKRUVqTlpsb0VuRS9uZWhiUmhQZkZyM2dsd2NPME45bHZm?=
 =?utf-8?B?TWZqOWhna0tRM1pNeVpnSGxFZjBoeWMrYzVORWljRVdOVHpWQkpUMGhTeU5p?=
 =?utf-8?B?STRHcy9BR0QrKytyYVU2NlVGVEk0UzU3VUlydy9FVzlVcS93N1pIQ256Y3E3?=
 =?utf-8?B?azR0dk9hUlAxRXJyRzVlUnVlWndHMlJSeWFtWnZFelBiLzFBbmtFcnZwR3pL?=
 =?utf-8?B?b0tPL3c0S25OMjdaYWNJYTJwUzNPQXlZdW53bEZxSi9wcE8vOVlQdUNSM0pi?=
 =?utf-8?B?T0FMNnVQYzEzbFFIemFZNGEzZXErZEZnMk4veENmSWc4amFmaVd3UzZlanho?=
 =?utf-8?B?eEs0UVozanFhU3lMVzNRYUFDMmZ0MG9HNlZLL0lpWUdmTHpua3JrclZSZy9H?=
 =?utf-8?B?anpUQnh1UDcraFZOdG5SaGxuNmtrdUpOYTRIQnphNGlLcHdjaXphRGxGc1Rn?=
 =?utf-8?B?QjVkUTRkcGkxdlNYczRCR0JoYjJ5QmV0NCtkWCtnRnNDTlFvNVZQaHFPSUdW?=
 =?utf-8?B?UzdYS1JVUG1uZU83Nk56UkJpOWh5YUdVMWdwRXRObGsyeGtKb1BIVjJXWWV5?=
 =?utf-8?Q?i7yPz/XGTT4AT3SxDcdL7I7jL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8C08ECEFBEA334CBF980C43CDFC135C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed4d2af-38cb-4bea-e6e1-08dc7ef5512f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 09:05:27.3921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8IfHp6yjWesv0RxuUlwYAGY0jTo8WiBEEvdkpwFEoOTR7KunJ5Is4v8GcY26Y5DRoBpQRhjiPJ3teWxrdIqEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939

SGkgSmluZ2JvLA0KDQpPbiBUdWUsIDIwMjQtMDUtMjggYXQgMTY6NDAgKzA4MDAsIEppbmdibyBY
dSB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3Ig
YXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBQZXRlci1KYW4sDQo+IA0KPiBUaGFua3MgZm9yIHRo
ZSBhbWF6aW5nIHdvcmshIEdsYWQgdG8gc2VlIGl0IGlzIHVwc3RyZWFtZWQuwqAgV2UgYXJlDQo+
IGFsc28NCj4gcGxhbm5pbmcgZGlzdHJpYnV0ZSB2aXJ0aW9mcyBvbiBEUFUuDQpHcmVhdCB0byBo
ZWFyIHRoYXQgdmlydGlvLWZzIGlzIGdldHRpbmcgbW9yZSBhdHRlbnRpb24gd2l0aCB0aGlzDQpw
b3dlcmZ1bCBhcHByb2FjaCA6KQ0KDQo+IA0KPiBCVFcgSSBoYXZlIHNvbWUgcXVlc3Rpb25zIHdo
ZW4gcmVhZGluZyB0aGUgcGF0Y2gsIGFwcHJlY2lhdGUgaWYgeW91DQo+IGNvdWxkIGdpdmUgYSBo
aW50Lg0KPiANCj4gDQo+IE9uIDUvMS8yNCAxMTozOCBQTSwgUGV0ZXItSmFuIEdvb3R6ZW4gd3Jv
dGU6DQo+ID4gVmlydGlvLWZzIGRldmljZXMgbWlnaHQgYWxsb2NhdGUgc2lnbmlmaWNhbnQgcmVz
b3VyY2VzIHRvIHZpcnRpbw0KPiA+IHF1ZXVlcw0KPiA+IHN1Y2ggYXMgQ1BVIGNvcmVzIHRoYXQg
YnVzeSBwb2xsIG9uIHRoZSBxdWV1ZS4gVGhlIGRldmljZSBpbmRpY2F0ZXMNCj4gPiBob3cNCj4g
PiBtYW55IHJlcXVlc3QgcXVldWVzIGl0IGNhbiBzdXBwb3J0IGFuZCB0aGUgZHJpdmVyIHNob3Vs
ZCBpbml0aWFsaXplDQo+ID4gdGhlDQo+ID4gbnVtYmVyIG9mIHF1ZXVlcyB0aGF0IHRoZXkgd2Fu
dCB0byB1dGlsaXplLg0KPiANCj4gSSdtIG9rYXkgd2l0aCB0cnVuY2F0aW5nIHRoZSBudW1fcmVx
dWVzdF9xdWV1ZXMgdG8gbnJfY3B1X2lkcyBpZiB0aGUNCj4gbnVtYmVyIG9mIHRoZSBhdmFpbGFi
bGUgcXVldWVzIGV4Y2VlZHMgbnJfY3B1X2lkcywgYXMgZ2VuZXJhbGx5IDE6MQ0KPiBtYXBwaW5n
IGJldHdlZW4gY3B1cyBhbmQgcXVldWVzIGlzIGVub3VnaCBhbmQgd2UgY2FuIG5vdCBtYWtlIHVz
ZSBtb3JlDQo+IHF1ZXVlcyBpbiB0aGlzIGNhc2UuDQo+IA0KPiBJIGp1c3QgZG9uJ3QgdW5kZXJz
dGFuZCB0aGUgYWJvdmUgY29tbWl0IG1lc3NhZ2UgYXMgaG93IHRoaXMgcmVsYXRlcw0KPiB0bw0K
PiB0aGUgcmVzb3VyY2UgZm9vdHByaW50IGF0IHRoZSBkZXZpY2Ugc2lkZS7CoCBXaGVuIHRoZSB0
aGUgbnVtYmVyIG9mIHRoZQ0KPiBxdWV1ZXMgYWN0dWFsbHkgdXNlZCBieSB0aGUgZHJpdmVyIChl
LmcuIG5yX2NwdV9pZHMgaXMgNikgaXMgbGVzcyB0aGFuDQo+IHRoZSBhbW91bnQgKGUuZy4gOCkg
dGhhdCBpcyBhZHZlcnRpc2VkIGJ5IHRoZSBkcml2ZXIsIHdpbGwgdGhlIGRldmljZQ0KPiBzaWRl
IHJlY2xhaW0gdGhlIHJlc291cmNlcyBhbGxvY2F0ZWQgZm9yIHRoZSByZW1haW5pbmcgdW51c2Vk
IHF1ZXVlcz8NCj4gVGhlIGRyaXZlciBoYXMgbm8gd2F5IG5vdGlmeWluZyBob3cgbWFueSBxdWV1
ZXMgaXQgYWN0dWFsbHkgdXRpbGl6ZXMuDQoNClRoZSBkZXZpY2UgcmVzb3VyY2VzIGFsbG9jYXRl
ZCB0byBxdWV1ZXMgaXMgZGV2aWNlIGltcGxlbWVudGF0aW9uDQpzcGVjaWZpYy4gU28gdGhlIGNv
c3Qgb2YgdGhlIGRyaXZlciBjcmVhdGluZyBtb3JlIHF1ZXVlcyB0aGFuIGl0IHdpbGwNCnVsdGlt
YXRlbHkgdXNlLCBpcyBkZXBlbmRlbnQgb24gaG93IHRoZSBzcGVjaWZpYyBkZXZpY2UgaGFuZGxl
cyB0aGVzZQ0KdW5zdXNlZCBxdWV1ZXMuDQpBIHNtYXJ0IGRldmljZSBjb3VsZCBhdCBzb21lIHBv
aW50IGRlY2lkZSB0byBzcGVuZCBsZXNzIHBvbGxpbmcNCnJlc291cmNlcyBvbiBhIHF1ZXVlIGlm
IGl0IHNlZXMgdGhhdCBpdCBpcyB1bnVzZWQgKHJlY2xhaW1pbmcgdGhlDQpyZXNvdXJjZXMgYXMg
eW91IHB1dCBpdCkuDQoNCkJ1dCBpbiBteSBvcGluaW9uLCB0aGUgZHJpdmVyIHNob3VsZCBub3Qg
YWxsb2NhdGUgbW9yZSB0aGFuIGl0IHdpbGwgdXNlLg0KVGhlIG5ldyBzY2hlbWUgdHJpZXMgdG8g
bWFwIGV2ZXJ5IGNvcmUgdG8gYSBxdWV1ZSwgc28gd2Uga25vdyB0aGF0IHdlDQp3aWxsIG5vdCB1
c2UgPm5yX2NwdV9pZHMgcXVldWVzLg0KDQotIFBldGVyLUphbg0KDQo=
