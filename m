Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724618E03E
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925634; cv=fail; b=Dtexz2eeLdtn+bhcT1CkgWqS2osrKGsEDAMQm3YisU23xr35fv88usehNuKFDxlVl1fOy0sKE/RXaMewWeAFtaF/LaO0L5oDmakq+DUg7Cf3c+ZtVuceUzV3Zt504l9SLhm/59PrL0vJrZnTDT4jmcZvddY1WDLx/vuJ+KJy5Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925634; c=relaxed/simple;
	bh=8dD0FqOBgbejmFQquoGWhxJrcxoKlYTJsuaBLFY9qrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jt1rdUoPk9w9Ln/LbbbcgTK4ukdAlpNn+/CaakvZrXKt4t/AllSWRCxELjDH131IeqnQX11+/ArcGjuiChC+uGzLIy1LOHhyI3vwe703sZgZDehuMJKk3AqAMZeqrrsM25qGHik/uEhf/MoFVosjG4afrgxh8F+1S5K90otZWAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QwtTJsjZ; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QwtTJsjZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSedZz3yetvRGg59f1WgRGlhP5f8FkT7CMyU5eGUGwOBN61wrIUY4LH2pI0xBCIf7Zmu9UXMH8B1xZtPt1vVdu4KBET7+sFqubR4Sbboq03drsAR+odQOjwgnY79K995Rz0mWSJHFoh1s2hsRfLgV1pkqxSJLWlAoekCdbYFADE3vNSZFnLsbOwVcDzSpa0ECuUiPV46fMUb/qu0ggNvTQ2RSg8InKPDqvZMA5ed2neH7Y5e+nZkZUUgDBLhmZhKq/XishjiVl8WUc38juUTTxdcw3fqE6Tnd2gpBe4Xcvpwte9U+B50V41e6x0jwo0Gv/VjCjWiYPARFszZ17ho3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG1gEFxc26FVp2PmkXzQnZaakg8ls/XRTwSnV6Y7Pak=;
 b=nkZhvQsiPW9bGAVMXSMpQfCJdS1wpIRLCV7ivG+Um+mSlj00NZHX+P31+t/+aEaW/oMEvAtNU1qf2afxqVFGBLZb/fGhoHU3bCPPbDa3CgI/CLSJz6h9eqyJ+uyI71nlupC3quVcuJhOeXo3MDRPSczP3psqBx1BEs3wA3QCqvlZmhdg6q4hOm+UfozW0JPPR5Lmd/31mpVjwnyrkQ1bx9ARTxCTdXPMe6ZB6yGdG3O2HrR9z+UUBxGnJqk0Yx+p+48NCfOdMTib9sv0hU8OAArJejqRhiuSKWHqxBGF7fUNVGUC0G9oJM3Eg/bcrM/xD0MKiVD3QlXqLiJocATxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG1gEFxc26FVp2PmkXzQnZaakg8ls/XRTwSnV6Y7Pak=;
 b=QwtTJsjZalUYuRC+j6X1I9uT6dy21skRTzd8IaK6SGLQo9fETvT6FP/V8XgszhrjlSd5qWvHSYkUx+Tl7a3UZHxZ/xqKTE6tjlEgFy1a4XWLqPSCUACFJSaS0ABE+t6O6EFvhzabSlIFclpGS1+dfwUS+awNyvj2UFW/RhU5KPVwBFnlyfmBBxnn53+lpcRh20gsMzIDXU6+pLAtNyN9KOnES6AUE1jD0JlnHeSZzSsKN/nhc8aHntAynA0Hjd38YYibnzcQEmYgsCIsMpxJd93fi3JthsyzJNYHszCz+n2DdlP6IL5dX3CqcGyTmQqbSqOh1k08NJt0wnlgwLdXGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 10:00:28 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 10:00:27 +0000
Message-ID: <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com>
Date: Thu, 29 Aug 2024 12:00:22 +0200
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
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f104266-3327-4d2a-495b-08dcc8116888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjBKeEcvUGdHeThqaUZ0a05Td3A2dnJtZ3NpZTlxRDY1ZzVLVzgzeHl0RHBp?=
 =?utf-8?B?d3VQTFRQWkQzYUdneDVGNnFpalVkbTlRYUpzL3hlOGdtTWpEN3ZtUVR4ZzVZ?=
 =?utf-8?B?ZU5uTWhjVHk0bmN1azd0NHQ4cnF6MnVjV1pNZ1llOEpXZlVseGNpeXBYbEhV?=
 =?utf-8?B?R21NQyt0SHA5VCtEWkg4YnA3ektOTnJpNGdYalBkT1Z5SUdvMHkwSlllNWZl?=
 =?utf-8?B?L2hDQk5lVmJSenRSaDFGamNKWno1ZzNXRnplN2h4d0lWRzkxT3Y2TmZ2U2Rs?=
 =?utf-8?B?QUVtTmtDcXpwVU5QWkp6NUFkWFdKeE5ycU15bUs2Q3MyOUhPeE9uS0s1ZitZ?=
 =?utf-8?B?alR0cGhYTnN5cVdIZi9yank5V3RKc1lMSndWd2lBNU0zRkJ0UmxENjBBWEto?=
 =?utf-8?B?OVpjeUFRLy81TFNweHRkRCt1Q1pjVGNXWEpVWE8rMENuQTdYMXZvdnljNm54?=
 =?utf-8?B?a011L2xMa2k3UFhYZDFyNHRmOGRCazN3SlVtdU1WZ2FUaEY3UW0xTWR5eHJk?=
 =?utf-8?B?MjhvWmszNUIrRllVMkdCUUh2TUV0THJyVk5JZnpUNFNCRG83TkRnMnVXc1ht?=
 =?utf-8?B?eGwrRWVwMFEvUGpwTWpsTk1DMEhEWGRJWTN0d1E0Wmx5LzdxM050bnlBVGZr?=
 =?utf-8?B?VUVsY2t4Y1lMdUt4RGx2TGdCUTI1YVlrK2Q3SXRUY01zVW9RVDZlcUM1aWNh?=
 =?utf-8?B?UDNHSlFOdy90V0Evc01CL2srZ2FHbU5lWVEvVjNVS29sdGhNMG96U1hwMVhu?=
 =?utf-8?B?TDZrMzE4KzVnc1RCME9YbUl1czZycjhPRWpZSXlqQkNCL1IycmlydWNNenFy?=
 =?utf-8?B?T25ob2MvSENGbmxDYWZRdGxuaXoyM2YvZTFTaUdlQWsyaG9ud25KY095WE9L?=
 =?utf-8?B?RkUrRWc0SXREdUVHRjliaDlnMWFMYXVIOTF6Mm1ka0M5eXVsUGI5NWRRMTJN?=
 =?utf-8?B?R1JRSWJoQWN0QTQ0bCt2S1pDNUl2T2JNM2xUUlVCdGgzbE1vMkhxL050YXNp?=
 =?utf-8?B?ZlhybkozMVV4Uk4zQjJsWThiVXllNnRxckY1OU9wZDdCSWRDVng5Y3pITXdh?=
 =?utf-8?B?VWtnT2NDZ2dxbTZkZFYyamhtT0lVd1JGcm5YMkNlZTQ1OG1IZHJJU1pyVDk3?=
 =?utf-8?B?aDhmekZyc3FCcmpLNW5odW5taGtVYzQrbGthakpGa09SM0dyMmFaenJkRFJV?=
 =?utf-8?B?L3NGdnFxV1VBL2ZlbkhYUTNQYTI1KytaS3BIZFc1TlhlaTFmdVBoZHcxUk5q?=
 =?utf-8?B?TU13YW1Pd0pIN0FvbitVc0U5NjA2a0ZRVXlxNUtNUmh0TmhaTThmV0RQcThV?=
 =?utf-8?B?c1ovTWxSU1ROaXhSQ1k1NlFHVGUrU21IaFBhVlF4MGFCdW9VR0xTeWUxQlR5?=
 =?utf-8?B?YjhlVFYwcjNGWmhORnhXZVZ0YUxCdHlqczB4QVVlcVJMU2VHZ3FzdnhmZXlX?=
 =?utf-8?B?b1ZXVDRJdmFwWUQ5UmloeUJGM3diclllZzh3KzZjc0VRc3Q2Y1FxUjN5Ulow?=
 =?utf-8?B?RTkyQlI0UTNyNVpzTGlzN01tVW1EbHhrZ1ZFWk5Fa1JiSWR2WmFDRkxBU1JG?=
 =?utf-8?B?OW9ROCtiM1lMK3pBeG5xak5pNTBBRkVZSFpaYjJiRldzN1pWV0t2VVVDV1Qw?=
 =?utf-8?B?RE5kMDJMNHZUdG9LdnZtU1VtVXpGWEVvM2VyNXkrQk9qTHh4aTU3c2NoS2Rv?=
 =?utf-8?B?MFdFWDN4RXZBck1McDVWeFMzOEZvRjFpQjZQTHhZTlJWRThWb1U0dWtRNHkr?=
 =?utf-8?B?Uy9HMWNPL0dsNGVib2NZNGRMZFBMNVlqaW0rVDhvVHVVNDVtZjk1NnJFSGxJ?=
 =?utf-8?B?TzQxZGRudEpIdlR4WFl2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGpPQVdXVktzY2kzdVVKOHJVem5CcVRhT0J3VjdsT0p3VnMyNnNMMmJObVhu?=
 =?utf-8?B?aXVhSHQxN1gwREdIclhlWG5oZ3V6MHRNMHROQVRjVHhPSmd4UDVPKzA1L0c4?=
 =?utf-8?B?c1RFOUsxd0VLZ1NRWnFWREFOSGFJczcwOGdVZ1ZiK0JjSkV1V0pDU0ViV1Fz?=
 =?utf-8?B?Z0V3eWQ0NWIwZ1EzNFBnUXV3cXJsQTUxaHNhUy9FS0NWSkxlQ05qTGdMcmtJ?=
 =?utf-8?B?NDBFVmhLb2V1VC9vdlgrTXBBNDBRTE16czVWdTM4QWJTb20vV3RUWFRSRERw?=
 =?utf-8?B?QWQ3MHpad1o3UEdoQWk5U0pnQ1hKaVAxYXVieThhZE9QOW82VjNZeXZCM29Q?=
 =?utf-8?B?U29yTEoxZUs0dHUwRyttZDhTR2JxLzZxdDhQcHZTbjlRdVdGOUVjZkF0VURX?=
 =?utf-8?B?MTUrZ2Q3TTBiRVl6VHhLZ0xhYU1ueHZHTmprWlpQUVUvTjNZOFc3OHFka0du?=
 =?utf-8?B?dHFCbmY3Mjd5SXZZNXRpYm1pZXo5TTdLY3lVTDU5QTA1Rmg0clVFY0xDbkxN?=
 =?utf-8?B?NURxQU1ROEJBSzR5cGFicUpNZER2T1BFcFE1UXk3VUZQVHk0TUQvclRhL2ZB?=
 =?utf-8?B?Nm92bEcxVDFVdmRzRXhNOG5HVVhTa3g0NGNXTnN5Vk1UM25tNHl4NGkwUWoy?=
 =?utf-8?B?L1ZScHhCNCtaSlFjaGppRkhHcTI3S1lRWWM0Y0VlaEtZQm5YK2c2OXNCK3hN?=
 =?utf-8?B?dDM1bkRQTU4yNVBXRmhYeWZkK1NxWlhUaGk1QW9zMkpkblRBWGN0akM4T3Nw?=
 =?utf-8?B?VzNTdlQ5NzdOZTRHc0VtZ01QcXZQMHNPMjVBWmFhM2lkRUtKYVpYalZZdytx?=
 =?utf-8?B?cUU2SHFxd2tBZDcxUDBGZ25zNEFSUFpremo1ZDBPakZrdUlrU3VVYTA4VmRJ?=
 =?utf-8?B?ZVpueHo2Yml4Vlp6UHVjc1o5WVVORElsbnZSQ25ma24zSVFoQVNWR0Nhc0tP?=
 =?utf-8?B?WEhmNGtPWDZpcWNOMHBMUnhUV21JYitnWmZUTXRJSU1Cb0hqampQc3ZIdlgw?=
 =?utf-8?B?L1AzR3BRdmVJTVYyZmtMZk5ZRkNNMFNzMVR5WTJHSHVGbHVXdDVHa3FVeHNC?=
 =?utf-8?B?NkdVQVZCUlBsM1ZOZDhhY3o2akVlUzBwZ0w2cDdsY1pxN0FsRS9pZHpmQmdu?=
 =?utf-8?B?NFMvclM2MnBoVmRGYUhaRnp1WDlhcGFlRCtCV1ZiWC9MamZQSU1RZ09hdTBW?=
 =?utf-8?B?L3lNNUJOZEwrWHVmUkNzMnFhcUcrRHJaMDY0UmF5b3p3RHVTWTZSODhMOHdN?=
 =?utf-8?B?WXBiYkMrOWRubDJHQlVVUUNUYklRVDlZSDlxSUx3RUJpelFObXdTd0szN2Nh?=
 =?utf-8?B?ZWNjcW9UU05OWmQyKzRFQ0dwTklleEYvbUVoaGltQW5EWTJHQ2lzNHh6MU1E?=
 =?utf-8?B?a3R3Nk1aMDhPMHo1QzNYRlh3aEJvcnpYb1ZmTFd0ajB4eHgwQkkxbmxudjFT?=
 =?utf-8?B?MkxnNWx1QTlIN2hNdE55dDY5MmFRbFpqeWt5Q3NKcGdiUVN0bWJReVcrMGxp?=
 =?utf-8?B?djJFUDJqUjEvUjg4UkM2WHlyT1p6VmV1TlVCWGptdytZb2pKNTBidXE1SzBm?=
 =?utf-8?B?YlNKWkxldkd4UXZEeUQ3d1NhYTlBQWhHWDJHcVY3NFVSR3dEQTNsc2pMR2tE?=
 =?utf-8?B?SVJsS2NNY1RYeEpuTVpsdXFxNmNKM2IrOFNVeGhPMWszNndVOTl1dHNFVzlI?=
 =?utf-8?B?dGZuNUpaWWVuYk1ST2p5MCtmNnVQTEloNHN0MzlPZk1raFF2aTRyWGQvMjdE?=
 =?utf-8?B?RkZMSmJtaWpxMENCSWFhRzBLU05na29abkdJejd2T2o1Z0trSUZhWVFLVUVv?=
 =?utf-8?B?cDhVNXdWNVBsbTVPVmtwMFhSRFM3MTVWQWU1UmVwc294WUYySm5iVUFQdkJi?=
 =?utf-8?B?MjRkaFNPVklONFZBR0lCK2Z0eGpDRG9VVU5LTWQvT0ZsaVdQNjl6d2t4M2hp?=
 =?utf-8?B?OWpIbGJwYXQ2MnVNTFhxMy93YUQvVzFQSXpOTnRxbmZGeERnYURZQjBUMytv?=
 =?utf-8?B?aU1EaGlZRzUxMjdMOUZwOFpvMEZ4YjFyQ2c1eGJ5ZWw5clczby9mWTdlc2Yw?=
 =?utf-8?B?dkRaalpIaXllZFN4YTVVeXUzU2lZUjBGOE5qak4rSlJpMTJ1ODF4bFdPR3Vw?=
 =?utf-8?Q?/vko9bPh8V2MCgfbxgGVIFBP8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f104266-3327-4d2a-495b-08dcc8116888
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 10:00:27.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6OSB7RT2APToSA4UQv2nN7IrUx72bwFOoLv+WGAOmqO2N9G6RZfclJYTEUb9wY+RtlJy1vriouZtVP2onsLNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405



On 29.08.24 11:05, Cindy Lu wrote:
> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>>
>>
>> On 28.08.24 11:00, Cindy Lu wrote:
>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
>>>>
>>>> On Wed, Aug 28, 2024 at 12:03 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>
>>>>> When the vdpa device is configured without a specific MAC
>>>>> address, the vport MAC address is used. However, this
>>>>> address can be 0 which prevents the driver from properly
>>>>> configuring the MPFS and breaks steering.
>>>>>
>>>>> The solution is to simply generate a random MAC address
>>>>> when no MAC is set on the nic vport.
>>>>>
>>>>> Now it's possible to create a vdpa device without a
>>>>> MAC address and run qemu with this device without needing
>>>>> to configure an explicit MAC address.
>>>>>
>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>
>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>>
>>>> (Adding Cindy for double checking if it has any side effect on Qemu side)
>>>>
>>>> Thanks
>>>>
>>> But Now there is a bug in QEMU: if the hardware MAC address does not
>>> match the one in the QEMU command line, it will cause traffic loss.
>>>
>> Why is this a new issue in qemu? qemu in it's current state won't work
>> with a different mac address that the one that is set in HW anyway.
>>
> this is not a new bug. We are trying to fix it because it will cause
> traffic lose without any warning.
> in my fix , this setting (different mac in device and Qemu) will fail
> to load the VM.
Which is a good thing, right? Some feedback to the user that there is
a misconfig. I got bitten by this so many times... Thank you for adding it.

> 
>>> So, Just an FYI here: if your patch merged, it may cause traffic loss.
>>> and now I'm working in the fix it in qemu, the link is
>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
>>> The idea of this fix is
>>> There are will only two acceptable situations for qemu:
>>> 1. The hardware MAC address is the same as the MAC address specified
>>> in the QEMU command line, and both MAC addresses are not 0.
>>> 2. The hardware MAC address is not 0, and the MAC address in the QEMU
>>> command line is 0. In this situation, the hardware MAC address will
>>> overwrite the QEMU command line address.
>>>
>> Why would this not work with this patch? This patch simply sets a MAC
>> if the vport doesn't have one set. Which allows for more scenarios to
>> work.
>>
> I do not mean your patch will not work, I just want to make some
> clarify here.Your patch + my fix may cause the VM to fail to load in
> some situations, and this is as expected.
> Your patch is good to merge.
Ack. Thank you for the clarification.

Thanks,
Dragos

