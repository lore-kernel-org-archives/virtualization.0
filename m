Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAA12C484
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267249; cv=fail; b=uF74Pqdxa3pWDrmIrO/YfS5ZWtzCazyscYTRF/1QseChggTMTsdbeNQef8Y44xaBjj26AKqnZuJ4/gx/4XIE3I3O5goMto2co9lkvMONz0rVYl3PV9oeVe1K2y5iI+PzFpFIYb4IhGckfmRngi0KF8mWlcPAHbwEo8ujMV8j7Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267249; c=relaxed/simple;
	bh=OANTE5WmXvLkULLZzWyraWaGSUzWw2v+/7NzzgfXWog=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CISP1o1LL6Cvu7KC1JTu0UNphKoPMqJjwLq+HoDkV6iZa1GTRh+MgLneFyCrqmTbkc8VaWm2gPCY6RCxIpeK+mQaftbe0Dk/dHv69xBpUBItdqQKapFmYVYkNWZKqKP87cuQu7kx0unKZQfbgojX2A9kPlZRI/j5ck6w021VlKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EqpatxPB; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EqpatxPB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQRxNXYdU9J5gINw5Vbf8CqWjAz4n63tXr22XSoPwX6XmVr9ydCWNfGTYAG15ph2MAnma7k8Wp4dxVHs5C7UlKkSlskhvqh04YSXnBOSMb0ruAp/S1yI98bz4Xxg/0qvBgt9dtYX/5aSoLsiTei0kGHFfaFELsA6zrQqlZBvuwXoNs7H4K1zMTUBQkg3DRwzQvUhD1JVD4E27fmKOVWGwYISA4Ber+PJndA+0+WE2UZse/e7me3Ujf+F3yuhUFoqyx/9Hz65BNHLo7HwtfP9JFa8go44GjJdxB2jlCittQs9NvoMs86nuYFQVqP2VjYo+9GUZvJmiDp4as+yBq97iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22Gh8jL+dzscSfRj1GFfGyXpUFPW2+0nMLEmXJOIE/E=;
 b=aHVPrsLzReOMa6RU+a7BkxvNM3TyJM8FNWQpvtOXVRM64QI/DaMDQ+tpYijJ7A5bWH63rV8Y7pi8+XCAkLBpU2qQSf5VZaPifrlI3eP0Ikb2fhTJDDEff5m4KFczDm0DamFocIeDdxmqjybkefRm1/7EFaafROrcR5yglPNKvwEv9a/w4IDUx/Y5C/m0stJLjZzsc7Qh5b/BbkZm29+YdxZuiCZBLOokn6Dj+YTDu6OQIyv/d57u6DJem4oo2AVbCLPBoKZ1LYOQ5aYOSfIpsgMAd/RqOOXoi7Z2Be3neqG3+ljHApMhU4HO5jbHr3btdPN4zM9d4tOicA17VbOQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22Gh8jL+dzscSfRj1GFfGyXpUFPW2+0nMLEmXJOIE/E=;
 b=EqpatxPBOOX0/UsqpYuTVzZYbkP97RCwMyC1I7vX9A3iv6Mwq68aq7BMsd5+zhO+2cTXcnX0zcxbxpr2Wi7sV5pM6hebpkSUtVZUt2FpHV11kyywd3U4mYxLP65PDHKZICUfWL2SN+c9ZQf8eW+gd8nSw5RTGBUQ1jeYS7kpEGDhaWPMylyJgy2CjRYWLfQRHgieBQcJg3Oc7VQmQOIW6/VU4qvJ2mVTVQw/eaDckg/rdf2KMzSeG/Axq8acuSqG33N4ukopBbkuI2aftkXZxMl0Qg0RvOGI6kz/iiGHN7ve9NgJqugScGOSuYgJr2S1lLDIMjfiIv95ep6qfHcN1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 08:54:03 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 08:54:03 +0000
Message-ID: <4936c228-a3e6-4dc3-a8b4-0f9706e7541f@nvidia.com>
Date: Mon, 2 Sep 2024 10:53:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC
 set
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
 <750da215-adea-422c-8130-7524671a8779@nvidia.com>
 <CACLfguWu=1aZ=mhtzMGXGG2s3iG-SVAFB8QkObWfg+npdV0X9g@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CACLfguWu=1aZ=mhtzMGXGG2s3iG-SVAFB8QkObWfg+npdV0X9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::15) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 910f5fc5-30b0-457c-0ceb-08dccb2ccb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVdESThIazNlRXEwWnFNb0hxdXJYa0JvRnlOVytvOGZTbFdDbzFzbkxrOEtT?=
 =?utf-8?B?YnAwUlhYTUd1REJtM3FzUGp5L2NQY0NFcmZlNk1CNVdCcGJGZHluNnlQbFhw?=
 =?utf-8?B?dG9wcSs3SDFPV2FJWnVuWUx4VGhBNmVETDV3dHRzZENqUWliNU5qSXg5MC9L?=
 =?utf-8?B?ZE9hRTFaZFpNdlp4dW8reXhVV2ZtZFNTTVk5NEFudXFVNmJWY2xyY2w2cXEx?=
 =?utf-8?B?TGRxZzg0OG1NRW04c1lxYUxCM011RFFLQjhPSmNRcnQ0dTRFQk5mNU4wSGY5?=
 =?utf-8?B?ZHJXMUlROCtZREhJUnpNaGpsNlpaVHlPNjJzcnJMMzZsTVhwOG12OTdUZkxh?=
 =?utf-8?B?akhkMFFNWDFKQk53NEtPeGRUTmd1M3Frall5SzJEVHcxUm04c0o3eFZab3p2?=
 =?utf-8?B?UDRpS29uQm1mWDkrQ0YxQXd5L0dJak5aSGdIK0xubnp5T1d1Wnh5YzlZUUZu?=
 =?utf-8?B?bXBKM09CS3pDYzhDVDhyYklIZ2wxY0g2YS93TUpwTytya1pKZjZBcWxSQlpo?=
 =?utf-8?B?MlNXWENzNFFmN2N4NE5kcldtTEoyc1hhQ1NlTWQ0bEFoRFlWK3RtQ25GWGhz?=
 =?utf-8?B?V0oxcExJOUx6ZURhTHRJMGFmY1RSZXRFQ2l3U1lpWDc3K1NKK3BWbmJmN0kw?=
 =?utf-8?B?c3dpV0NVMC9INkhRdkh5cm5MNGE5TlBsN0VmbmgwRzZBdnhkS2FtSmZiMHI4?=
 =?utf-8?B?RWM0RkJSNE5TbXlWMnU2Q0JPQnFHZHJaeVdTN252S0NYdTRWQ3RUbThGS3Nw?=
 =?utf-8?B?YitVZDFjS0Q3MUdtZzJxOEpVYTEzQis2ZXVPQXN4eWhuOCtwWWR5VjU2aU5N?=
 =?utf-8?B?RndCcnZtVnRlSGl1TDVINEhyYWNSVTVkYngwTkpPd1dsTG9CMTN4VEZ1aUww?=
 =?utf-8?B?S1hOMldPM2tJOGxzWnkrOHdPL1lZT3RrcnBYS0RjZGw1S1JpMGNOeDBCdDBa?=
 =?utf-8?B?Z05WSmwyeWJ1THlFYlpvWWMwUit1eDRRbDhFbkxlREdYZGZLcGlBcXFwY1VD?=
 =?utf-8?B?TTZ2WUhaUXFZZStQRXdoMkFCaWRsUFpwRld4RERUS2NHVmlOcHplQjdFVU1x?=
 =?utf-8?B?alNLSVErQTFrSGNOWVI0Z1h6cEFiY3d2Y2Y5VzhSdUl1d0kvWGw3d3Rya0Ju?=
 =?utf-8?B?bUJiNE1VSi9KYXpwenlhN2lJcEtIUEcrLzFwbThYVk9ndml6bm5JLzJ5alJh?=
 =?utf-8?B?U1lLN0lKRjFmQkFQOGpGUWNJb3BVRzlET213c1pkbENueXdmcWhHZllJUG1L?=
 =?utf-8?B?K0dkckxzc0NLRzRZSDN6Q0NPRFBZTjBrWEZGVC9KdFFGekVUU1ZRazJKMlpW?=
 =?utf-8?B?NUl3YnBJNjBXQk5sbHFpbVFoaGozWnZ0aWdBcWtoeU9JWmJUU000L3BaZ2g2?=
 =?utf-8?B?V1hzV1pnK2ZGbFNEMk1mUVRSTG9nREtRRkVFcWp6VEEwT1N1YUVqTVl4UVp5?=
 =?utf-8?B?T2p0Njg5WTF6YjNwVU5iZGovUVZEdEROL0pGRTZDYmdoenVadzF6MVlSSFJP?=
 =?utf-8?B?VEVJS2Nnd0tNUmYwMzllZWowRWhMQnNueFo0bjBlczRvLzJFR3kzL3E1Y1FM?=
 =?utf-8?B?aERtUkh6d0gxMjdIWGZpWklvYWcvQ0trTDUwYkkycWx0dU9SRHo2R3F3OE5a?=
 =?utf-8?B?TWUvWEtaNDVwRUNDeWVpZzlkY0QzTk9rZ05jNUkyYVVPTFVhcTRxemdxaEdK?=
 =?utf-8?B?aTJvZG5aTk85VXdDNkkyL21aVnNvRmo3ZzFVblYwUS9kUktYaUFKQVZOcVQx?=
 =?utf-8?B?dGVrZzFZU2U3NGgxc2w1ZlRiUi9DVGVVUHZmRmFxVE8vQ3dJV1g2d2pmY3Vt?=
 =?utf-8?B?bVV0RmY5czdlZ1Z3VkVMUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmgyNy9zS2c2MVIvdjltSi9DaFgzaXRwQW1kcDltTGtUQnMydnBEUWlOU1Ri?=
 =?utf-8?B?Q3ZJdnJCcU5KV2lQL1hPUFdFdG1JT2FyRmEwRFhKK29yMlo5bFA0b0w5OWpK?=
 =?utf-8?B?N3lrSzdzdnpqOHdBUHFJZHdlWDZoRnZJZ3VCbFJRck14VytUemlKY3p1R3dx?=
 =?utf-8?B?L2JVSkFPd3RqTUthQStGd3N1dndSSDFVZmd2L1NXc2dDV0FJaW5yajBxT3h4?=
 =?utf-8?B?Skh4TGQ3MldPQm5mMTRhQ0J1NkZBZHhUa1hhTk5UNUI1NFdnUWRTSmxCUGVB?=
 =?utf-8?B?SWFoL0ttUlhNZEl6VEZoS0FJNnUyQlBza3p0c0hqYnNpZU4yQ3VhWi9qUHlh?=
 =?utf-8?B?ZVZlTVhEV3hNQjJjN0M0bHJ0bTF2Nyt0WGxXdlY3dGw2UDNlRkNULzhNVWlP?=
 =?utf-8?B?VElvQ3NvT2NLVno2dTUxUnQ0TWcxVHBQSnB3S1ZTRGtrclFidTk2WDNsRGRY?=
 =?utf-8?B?c3pTQjFpQzdaWkM5Y0JsQ09rNHk1NkNGL0FGVnpQcTRhaDdRR0E1djdqdTdo?=
 =?utf-8?B?RFNwSXhCemJDTUR2NlVmTTdoeDhEdWRKcjU2bUEwK21PNzFrSjBsTURSTWVi?=
 =?utf-8?B?aHZlNm03QWxaeUZYTFZUbU9Ec1RzMUpSRW1INDl3NHZqQ1lveHV3OHNVcjYw?=
 =?utf-8?B?N0dha0YzWmxPK1RhWXBMdURiTWYvTTRuRndsUC9GQkNZK0I3ZjZOZGcxaGRR?=
 =?utf-8?B?RmNIaVRFSWFkNG5yQUluM0lLVEUwZkYrMEdTQzZ3OWswdENLSy9uOW83RVNS?=
 =?utf-8?B?SlRnaVJnbENyZUtUSnRUT3krdzM3Zmh2N0lVUTVEKzloNDJSd0lLbWUyMGJi?=
 =?utf-8?B?bm1DckVhSlNWdHk0OFJaWk5iWFRsR05FSlBMWDZsdERSNi9lTUMvdC84WE9j?=
 =?utf-8?B?V0RFYXBnZmk5V2NPMmQzWDJlS0JDczM5Mld1b2JwN0hHZUk5TlpHVnFULzUy?=
 =?utf-8?B?RjBUWEowM2ZyaEpma1FQazcweVFtbElwWkJncWtiZUZvcEJHMTl3NFZDYjVh?=
 =?utf-8?B?YVNqVTFnZUdBck0xdTJMSWVuUGtqU01uWElBb2FTK0F3VUtkZVpCQlBpeXBO?=
 =?utf-8?B?RjE5dXl0WjNXcFJQblllOElQVlhGZEh0UEg5Uk8vWm43b2hWcnR5MG9id1hU?=
 =?utf-8?B?Ykp3a2FnNDl3WHozVlV3dnh3Q1EzT0c3eWltanBGTHBpYlA0YUxPblkzNU0x?=
 =?utf-8?B?QnFvYXo5SnlKZFdQSUVncHk2UU5SVDNKcDJEeWozMFB0V2c1am9jNGdyMlha?=
 =?utf-8?B?d3AzRW9XbW9UQjBiM1Z0ZlFUem1LRHJvSHVEYklIcWVYUnpvQWdySGY1Z0hy?=
 =?utf-8?B?NjNDK0E3bk9mT2JIblpIcjFwd3E0cUdOcDJxYlRza1IwVWpSaHQwSnJ2Q2Nx?=
 =?utf-8?B?UndOVmpBOXhFME5WYWtta3lTWVZib0xkUURQSVdLOFFkNlVZMGdXVUhzTGw4?=
 =?utf-8?B?NU9KMmIybUxuSGRpM2NqcTl3SkRUN3ptZVNqNlZscWdTMDhLZTJuTFV2amRL?=
 =?utf-8?B?NUh0dDNMd3VRYUJadFdBT0ZYRXMwU0cvSHRWVFBWV2g3ei9hMWkwb2R5ZXA2?=
 =?utf-8?B?Y0IzSlhoTW55bWkrVWtjL2dxL0p6ZUFJbzZjeVNDNXdhZ0JxV0R3VHZFaWdK?=
 =?utf-8?B?aUp6ajViUkY3YTg4ZEJpbklDVlVvdUlQYXVjNXpLNXJXdWVGNlUwUnRmSkFB?=
 =?utf-8?B?VHg0Tm10L2NYT21tVFZRUDhFN3BKTjlYZkhpbWxTQ21DMWVOaVMvenJiWlZY?=
 =?utf-8?B?ZUdNZHRSRTJFcExwVCsrTVNseml1Tld6U21aSkd4QXRRR0tJK1BFWjNUREh4?=
 =?utf-8?B?a1FGSkF5TWoxOUM1MEZZcnZoeldrd21tdE9DMnV6V2xZM1gvTjZSK3JMYndT?=
 =?utf-8?B?MWN6THVOakh6V1pZQlB4ZUovTTB4TUdKTEl4a2FlQWxEY2JzaVJ5QzRLRVRz?=
 =?utf-8?B?eDNLc0hTU1h1ZExHdzRLNEpHVjJES1lmQk1JRHJhUFJycHY5ZXZzWTNIaU93?=
 =?utf-8?B?VlE2T0Z1MVROL3JmM3FtaFBSSjU0R0pDejdRY3BrZ0J4Q0RFNGVzeCtZbm1F?=
 =?utf-8?B?YmsyK2MwR2xqZ0tMTmJoZm9qRktmK2RDRGhuUEpzaVk2WEJZVDAzU2xNZ3lo?=
 =?utf-8?Q?RzXGpWF9HdI1GFDtR40Eo2zjQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910f5fc5-30b0-457c-0ceb-08dccb2ccb38
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:54:02.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4l4o13Z7pvoy/HCVtr8r+MjCNDzUwNvV4KkqFWz8uzANKu1yHD2rgqh12DeVo0fcChNJXFxKDQyCT+YBQWduw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007



On 02.09.24 10:40, Cindy Lu wrote:
> On Fri, 30 Aug 2024 at 22:46, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>> Hi Cindy,
>>
>> On 30.08.24 15:52, Dragos Tatulea wrote:
>>>
>>>
>>> On 30.08.24 11:12, Cindy Lu wrote:
>>>> On Thu, 29 Aug 2024 at 18:00, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 29.08.24 11:05, Cindy Lu wrote:
>>>>>> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 28.08.24 11:00, Cindy Lu wrote:
>>>>>>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Wed, Aug 28, 2024 at 12:03 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>>>>>
>>>>>>>>>> When the vdpa device is configured without a specific MAC
>>>>>>>>>> address, the vport MAC address is used. However, this
>>>>>>>>>> address can be 0 which prevents the driver from properly
>>>>>>>>>> configuring the MPFS and breaks steering.
>>>>>>>>>>
>>>>>>>>>> The solution is to simply generate a random MAC address
>>>>>>>>>> when no MAC is set on the nic vport.
>>>>>>>>>>
>>>>>>>>>> Now it's possible to create a vdpa device without a
>>>>>>>>>> MAC address and run qemu with this device without needing
>>>>>>>>>> to configure an explicit MAC address.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>>>>>>
>>>>>>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>>>>>>>
>>>>>>>>> (Adding Cindy for double checking if it has any side effect on Qemu side)
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>> But Now there is a bug in QEMU: if the hardware MAC address does not
>>>>>>>> match the one in the QEMU command line, it will cause traffic loss.
>>>>>>>>
>>>>>>> Why is this a new issue in qemu? qemu in it's current state won't work
>>>>>>> with a different mac address that the one that is set in HW anyway.
>>>>>>>
>>>>>> this is not a new bug. We are trying to fix it because it will cause
>>>>>> traffic lose without any warning.
>>>>>> in my fix , this setting (different mac in device and Qemu) will fail
>>>>>> to load the VM.
>>>>> Which is a good thing, right? Some feedback to the user that there is
>>>>> a misconfig. I got bitten by this so many times... Thank you for adding it.
>>>>>
>>>>>>
>>>>>>>> So, Just an FYI here: if your patch merged, it may cause traffic loss.
>>>>>>>> and now I'm working in the fix it in qemu, the link is
>>>>>>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
>>>>>>>> The idea of this fix is
>>>>>>>> There are will only two acceptable situations for qemu:
>>>>>>>> 1. The hardware MAC address is the same as the MAC address specified
>>>>>>>> in the QEMU command line, and both MAC addresses are not 0.
>>>>>>>> 2. The hardware MAC address is not 0, and the MAC address in the QEMU
>>>>>>>> command line is 0. In this situation, the hardware MAC address will
>>>>>>>> overwrite the QEMU command line address.
>>>>>>>>
>>>>>>> Why would this not work with this patch? This patch simply sets a MAC
>>>>>>> if the vport doesn't have one set. Which allows for more scenarios to
>>>>>>> work.
>>>>>>>
>>>>>> I do not mean your patch will not work, I just want to make some
>>>>>> clarify here.Your patch + my fix may cause the VM to fail to load in
>>>>>> some situations, and this is as expected.
>>>>>> Your patch is good to merge.
>>>>> Ack. Thank you for the clarification.
>>>>>
>>>>> Thanks,
>>>>> Dragos
>>>>>
>>>> Hi Dragos，
>>>>  I think we need to hold this patch. Because it may not be working
>>>> with upstream qemu.
>>>>
>>>> MLX will create a random MAC address for your patch. Additionally, if
>>>> there is no specific MAC in the QEMU command line, QEMU will also
>>>> generate a random MAC.
>>>> these two MAC are not the same. and this will cause traffic loss.
>>> Ahaa, it turns out that qemu 8.x and 9.x have different behaviour.
>>>
>>> Initially I was testing this scenario (vdpa device created with no mac
>>> and no mac set in qemu cli) with qemu 8.x. There, qemu was not being
>>> able to set the qemu generated random mac addres because .set_config()
>>> is a nop in mlx5_vdpa.
>>>
>>> Then I moved to qemu 9.x and saw that this scenario was working because
>>> now the CVQ was used instead to configure the mac on the device.
>>>
>>> So this patch should definitely not be applied.
>>>
>>> I was thinking if there are ways to fix this for 8.x. The only feasible
>>> way is to implement .set_config() in mlx5_vdpa for the mac
>>> configuration. But as you previousy said, this is discouraged.
>>>
>> I just tested your referenced qemu fix from patchwork and I found that
>> for the case when a vdpa device doesn't have a mac address (mac address
>> 0 and VIRTIO_NET_F_MAC not set) qemu will return an error. So with this
>> fix we'd be back to square one where the user always has to set a mac
>> somewhere.
>>
>> Would it be possible to take this case into consideration with your
>> fix?
>>
>> Thanks,
>> Dragos
>>
> Hi Dragos
> 
> Thanks for your test and help, I think I can add a check for
> VIRTIO_NET_F_MAC in the qemu code. if the device's Mac is 0 and the
> VIRTIO_NET_F_MAC is not set. The guest VM will fail to load. I will
> double-check this
My request was to use the random MAC from qemu in this case. qemu is
able to configure the device via CVQ. At least this device...

Thanks,
Dragos
