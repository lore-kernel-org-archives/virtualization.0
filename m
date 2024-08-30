Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F81AF4E4
	for <virtualization@lists.linux.dev>; Fri, 30 Aug 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025985; cv=fail; b=cnQa4lXJD/qmY28XznATaYxDw+wV+mSYL9NUCKHwuOV4fKG3dHieZ2fvWyM2ZtHa3ZCpvHW1dnfQeBhc+dLBjrTukJ01MYrlX9pHJBa96QPy6sZBinzkvgjhdR8xQqokDym/HCEwKnr9COwEBtmw94oWT7QBolA1LdXHsTGG1mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025985; c=relaxed/simple;
	bh=lICDPl6NbIhkOtEAKGqp5MQx30mELqbaS0QpEhCQYO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tWiufOT7qD+aTY64Jz+gxnwwhAX6yDbElE43dBL+EW4kMALXNzxn43PVPqhxRPeNMzSCIVQDEgmpqTOTZPv4N63vEUC1uWPSRhwMIq4cINN3u/4m7OZiOt4Xzlx73K6v+hY9R3lmgAoMO1SblrI4zMN+OUNODdCEIKvWCLNNuXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UIHDvmxR; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UIHDvmxR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5vMEsC5HPKkWWG4PcGSKzWROeaRyY98/L4czRSdw15opSPNuX+j2Ebi8qup9L1yzjr46uJcVLt7msj+mUCoKQN8ERxV1X5dSz7L4oFSfn59muqNHXbK97hBOXrhSC+pnGPEtOo4CjLk+vIU0aKfPeTy6p3dapIf5aIShvBEVPIm8mB3NPAGPj7HdntC4cbbb1Nbz+M0vDxEAc6SV9hpEbTM/DCvxpiMIp1C79keYZOQy0gYaxmtbQK3ivrP6t119xIep56KMytiTJv6vSteLZ720Vt/+LTfABWa4BflPvOKRVP7rXbPcIvxZ/8h+q2lcSy/5ut8JjSa1+arCAxGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0EVLeE9CH69LkUup0XcwXeJK6eYUbIJ6xwUZravfcM=;
 b=j5MuXC/ia64Nk83SZILQpuCTHkstwH2wHDqlSMFtWuAiyLvNgKDztBOTJ5vbNJ3IQFMBJXFTzCtD7pMcMlGLMlYB7CkUXiHBYGa2k15WX0udDDgozeS1ZqfPjwAb6fPHYFuNYpHD1har7Z0MeFt2gc6t0POuWbkKi9VGB3/tae5kV+Tp2xyfoiifMXRKm+L93Fbjjv7hNJgaceiBirAjZi+JrAtdo8YyuAq/LU1ZrzWvFQvHArgfeoPLTvv1+obNEDTdqgZA66X6UsiQq96kZMaVNgckn/WPJf4LXm/2TGkmoyCCnbnEXcb69ntWbpHdGiBp35gqX13TRS/7qEuZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0EVLeE9CH69LkUup0XcwXeJK6eYUbIJ6xwUZravfcM=;
 b=UIHDvmxRm8kV34wMNxcj2UZ0UmPVi4KY4Ai3t6BycYqWd9UaXmjiq8j6fMtvnxbYopOiPFX9Bq/yzxSarrP6EA1oxut8SCJvbaXqJh47b/iJ8vSW0gW0tDUa3VbOsaF3fnVoIMsa7PKrZQrCkZgXciTW4cNwd+ea/Jvi0JXXLIwAV36AwFNwlJ/Bbc4xL2e9AeGyjEBUSxsaXSRMHSY9kcrE3A/rCY/uCU/V+zr0go5lp2WBA6mykcqGApBFe+YcL6j4y4DMgIOdD+yYUSDt9sQKZG88oVR8AFxwCALMZL6qnf5Qd30f5qD2M7fSMCwDgMYtLRFUTr/vBZ/lUw7zVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 13:52:59 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 13:52:58 +0000
Message-ID: <cfece74e-a979-4f74-8a6a-fc8869e354f7@nvidia.com>
Date: Fri, 30 Aug 2024 15:52:54 +0200
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
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CACLfguUZVDGaY4MD+_tDqM9DQC-C6cuPfCf34X59e2RkMztEkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e42d077-134c-4dd6-3e56-08dcc8fb0e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTZjTDluZVJOVldDL3AxcURIQXRrZllrOWNVaHRmbGYzcGRGRDhFNGJ1ZE91?=
 =?utf-8?B?WUFzaEhPQUNGbVd1TFRqNUlvbE5BbEtBdVVXZThxYUx4ODRJbUtUSHRlTkRu?=
 =?utf-8?B?U3l3N21EK3FOc2VwUUt4YjJwKyt2OTcvWWZIVms2cTdadyt4MGprTVU5Uk40?=
 =?utf-8?B?KzNKZ2ZYRzJWa29oakMwN0UwaWF1dGlmNXB2UnlWRmJ5anRWL3A0dkZ5K3lX?=
 =?utf-8?B?bS9iSjN0QTRJTzlpK3RFZll4MHdLckd1U08zYTVGWU04UnBNUGhkc2RFYkFz?=
 =?utf-8?B?MUN4OGtUZlJTbTBoeG9McDdrYlI4UXdmbll6RzY5c2g4aHJ1RlZ0TkRWd2RG?=
 =?utf-8?B?dUFSWUpOZVo3cStLNUV6R3JOQUVSRXd1b3o3RnRxTEJ0eUtNMEtoVGZFRmxz?=
 =?utf-8?B?bWZqMXgrSzV2L01mRmQvSWZibVQ4TmxXKy96eWdESzJxUjl4L21IUDRTNjNL?=
 =?utf-8?B?c2E4OU95QjdpRTlxcEYzUTVXeGFxM3BkYkxrTWRhaDdpQW1sa2lXV2EyMU1l?=
 =?utf-8?B?dGNkcU56UUdzU1EySjdCQUFZQnJZaHp0MVBlV2pTZTlVZzB6Ym53Lzd4Z29W?=
 =?utf-8?B?SzlaeWZHVUoxbnFKaFE4VnUvQVRGazlNMzdMTEk3L2JQUDhFTTRid2NETFQ5?=
 =?utf-8?B?YlhobkNCWHVZWmdrTW4zRE5iZzdobGNVTTdkZHBYUTdTWk54MG9LeHQ4QVJZ?=
 =?utf-8?B?TzdoU2crVjNwSDRpV29FYjNzZlJoVjl0ZE5yNFhOaWpBcDJzZE1mVDBVMExz?=
 =?utf-8?B?a1VjMUFzZFRZbUJFSzJtSENVcVpJaURnajVKNzdUZnhvcE42WGtVbTFIUk1k?=
 =?utf-8?B?R0ZwNXBMUlMrem53dGxFNHg5eWcvYk90bFUxbit5TXFlUXk0N0RoaEJ3SllP?=
 =?utf-8?B?NHMrNndCTVlPbE5la1Z0N3lxV3Z0TGlJZE5GYU1TTzVSYTNRRVBPMDc0SVhm?=
 =?utf-8?B?WHB5NGZNakZIemt4ZmErTFN5V2RBbGh0UnBsalFDWTZmVXZ2SHV1MzlNWktL?=
 =?utf-8?B?ZStQVUZyZXVobHdQREdPMUFkZXBlMFozTnVVOWhFMDVMWmZWMk5UQVF0b0Vn?=
 =?utf-8?B?aVR5enBGZGZyc2owMHNnNDdsYlo5VWlWeXh0SXhIWEFBRHpxNW03OHVKSzhO?=
 =?utf-8?B?ell2ZmxqME5kWmV0NzhjRTB1cVhEK2FwZUs4bnJ4SGtLMmtSOW05ZFNKN0Zm?=
 =?utf-8?B?cUdIRm83aVg0TTlvL0Zjc3BMdFgwT0g4dFlTcXJZd0F5VlZyRE1GOE10cGFt?=
 =?utf-8?B?dnhYUTZzU1RXby9sdno4NW9pUnJNL2NOZEJhelg5SDZ6MFllRWVPNm91WlM5?=
 =?utf-8?B?d2JseFpQM0ZzczdkQ1Z2VUNVRUpGeEZCQmwwR25UNzZZYnZ5SkRCQ1o1QXlu?=
 =?utf-8?B?TDlJZzYvVk9vYncrOFBISVpCTHVPLzJvVFR1UmtRQnpsaHpPdUlPQkowbExj?=
 =?utf-8?B?Q09zaGNha05mdktZQXFPYzR3dXphVWdnMWE3YWZzcWp5VVpBZ3pGc2tFOWM1?=
 =?utf-8?B?NVVNMmpKaWNhNzhjUkVvcnp4YnloUTVwZ0lRNXNmc2xvK2hUUEpZSk81dzBn?=
 =?utf-8?B?cC9KbFFod3ZzeVdORkczbnZHK0IraCtKZ3ZNK0hJOFVmdGZWbDl1aUEzVERQ?=
 =?utf-8?B?aGNsQUszMFNZUzJiK0xPWVR0N2IwK3JvcUVnMjgvRVRxWWtjUmJ0cEw4cjR0?=
 =?utf-8?B?UytnQzNDdDh6QndQRE9CMVEydDNNMlhYMWh3KzRNUUpGeDFrTkpQSEdzMnBO?=
 =?utf-8?B?bWpTanBSdnpENGkzTmRicy9FRldkbDRENU1SdnNwTDJiRXVETVVNbXZ4dFN1?=
 =?utf-8?B?ZkJ1dGxqcUdXRyswUXNhUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDI3VUJpRWZCR0RPb1YwekJrS1B3TkpaNHhNZFgveTJSZnJ4enVZTVFnRFJm?=
 =?utf-8?B?MlhBbityajRUUkd5dFlGclZ3S2toUEF5cFBLVVNEbW9hTWtnWktiZkFMc1Mx?=
 =?utf-8?B?cDZjMGo0RERYSVZUNkkxZm9CcitIbVdXVEdMdlBMY0tFWmkwMGNCL2tWMFk3?=
 =?utf-8?B?WWNDL0RLUWxMU0FlMURPVk9MZ09xalpFVGtLaEpzakpVMjNKRzZ0S016bXh4?=
 =?utf-8?B?OU1qTDczeE96dlBYakpraUZyK0xqZzRxTjRHcGVPZWhQRWNnV1RaOXFKTHVB?=
 =?utf-8?B?T3BQc3RRdHRndFVQU3VVamNmem1lS043NzJ5ZnhrQXBLSFNqTDFtZW1yN3hR?=
 =?utf-8?B?Q0ZpempxZGFTeUl6UEdHME1IVlNFV3g2QjJqNXRoM1JXUmJSVklxZUtUSWsy?=
 =?utf-8?B?enhQQTZ4TERiZGNucDFycEcwekV3Mit2L2ZXaWJ6eU8xWkNoeG81TTlUelZz?=
 =?utf-8?B?UGY2eXdYeVlGK3hYK05PUExacm8zeDNlMHBXZEFMSWhQbWtnL2FYajg3ZWcy?=
 =?utf-8?B?YzV6WWZiLzJCbDh3QTd5WnQ4WVR1M3g2WExidUdsRmxMNlNhUTV4UkpPR0ti?=
 =?utf-8?B?RnNHcW1CdzlIZkRNQnUrSk5GUEZzT1h2QnpRc2pCbTcvL1RsRUpjcE84S0dz?=
 =?utf-8?B?cnpOYmdubFlVckJGVUZKYlNKbS9vV0dVY3VJVWFhMjRnQTNPYVoxR2pNcWdZ?=
 =?utf-8?B?WnJDUlJPTTVqWGJoOVVSMTJtZkNMc1FVWlpvTGN4Z3lLV0FadUNjbi82aWtO?=
 =?utf-8?B?Z2p3T21GS2wxeWoxY3lRQWtJVU5wNXAvbGRreXdJcG1YYktaVlJLUXNhY0Jp?=
 =?utf-8?B?MmlBRjVwTENnNzFNWWE4aUZVdmI2UmNLcklEN2ppc1RnN3ZmYjRaNkRBWXF6?=
 =?utf-8?B?Ymd4Z1JvVFdHZ05lWVhWSUFqNC9UdmxST28yRFhyb29sUnY1VCtSb3phWDhC?=
 =?utf-8?B?VStFd0dHUUlVNW8vQzk1dEFHbDJtd1MvVVNuaUFvRVhuaGlMM0EzblB4TWpY?=
 =?utf-8?B?Sk1nenB5M01JQVEvaVJ6bzZjZXV3QUhmcHNvN2xnWTBQTTg3Sy9uOXBNeWxp?=
 =?utf-8?B?T0hKUTBEbVNqa0Q3eXhhNHJJQ2xKMmUyTDNMVzVhNmpVaWZqQmlqUDlobkFn?=
 =?utf-8?B?SWF3ZW9Ld21udE1ST2tzZGloV1hEbG05QmtSTElQd2tWNm9jZDAyNUdiaTUv?=
 =?utf-8?B?ekxkVjkxdldNYkFUcjFKcVJTeVd2S0p0N25KWDdQNGR0d0N3K0NsQUZQN0kr?=
 =?utf-8?B?dFRqZm9na3ZBSzRySGJwdHFvZ3F1aXVsazdiWXBjc2h4bUE0bmdjNGQ4dW4w?=
 =?utf-8?B?NXpQb2Z4MFh3c0Y0dEZ0VHRNRis4OWlPZ3pMZDlyRHB5WHlVZ0NkZHo3SjNl?=
 =?utf-8?B?MWt3RnpwczdjK0JYeXF4RFlIcXMzU2ZKRzVIK0JDRDVnKzJTRWQzd2JlYkpm?=
 =?utf-8?B?dzBRZ0wvZVlwcmJYOVVaWVBablRrN0NhZ2pKbWYvbEdOeGhscmRuNERoUVBw?=
 =?utf-8?B?NGQvayttVW1Ob0ttckM1SEhZU2VaOFdEc3NWNUpLeVBDODU4M3c1bWtNVHJH?=
 =?utf-8?B?WjBZTUdMdHZNMnZoTUJZUmlSa0F1MU1oVnJ0ZWVqVG5QaGtyZDNURi9oa3Yx?=
 =?utf-8?B?ZDFWb1hwdGs2U2FRd0pBVHBRTzVzMHhHaG1VNGtyWGIxU2ZFbXlvOWtUQlB1?=
 =?utf-8?B?aTlnSmtPMk53RlFtdGtmS3hpZ2d1eko5SCtzQXVSVjdKVTFRZ25KVURrNERD?=
 =?utf-8?B?cXFCVlV6OVc0d28xOW1mNlZUNUpBY1FPdVJKZFJTTTFrT05hRXNnMDlZRkZr?=
 =?utf-8?B?QWV4cmtoVmV6U3FWYkxDZjkxSmZKdUw2cGYwOHNFaCtHSnVrckJaeUJZakRW?=
 =?utf-8?B?bnF4OHVkS05xTjlLamNhS0cvS2QyMTQ4aWJ5MGtFT0NkSnU2UDlKVG9IV0xn?=
 =?utf-8?B?TmZTYWp1VzZwcjRvbnNOQll1cFBnQ1MrdHN0TGlPTjU2cG9HUFhMaFRMVXl5?=
 =?utf-8?B?TGpNa2FETkNBTHZZckV4L245aFV6bExGRVRqMHVwQkRaMDFFMWliLzJZWDhz?=
 =?utf-8?B?QXBrTEE0ZjVsK0ZTWGZvdWJmdFdqZEcydCtUOGtlc1NCL3dZcVRubmh3VUZz?=
 =?utf-8?Q?L1YFF2vgWN7nSbqtzwJu7JLuI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e42d077-134c-4dd6-3e56-08dcc8fb0e61
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:52:58.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyXXLUEgetVKmQxLyOH7kc/m+LMILWQ7pBrZs5ph93B/3cQkUI4mEId1/8IQlumtPtBlbc+TQPh6c147b8mD1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830



On 30.08.24 11:12, Cindy Lu wrote:
> On Thu, 29 Aug 2024 at 18:00, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
>>
>>
>> On 29.08.24 11:05, Cindy Lu wrote:
>>> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>
>>>>
>>>>
>>>> On 28.08.24 11:00, Cindy Lu wrote:
>>>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
>>>>>>
>>>>>> On Wed, Aug 28, 2024 at 12:03 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>>>>>
>>>>>>> When the vdpa device is configured without a specific MAC
>>>>>>> address, the vport MAC address is used. However, this
>>>>>>> address can be 0 which prevents the driver from properly
>>>>>>> configuring the MPFS and breaks steering.
>>>>>>>
>>>>>>> The solution is to simply generate a random MAC address
>>>>>>> when no MAC is set on the nic vport.
>>>>>>>
>>>>>>> Now it's possible to create a vdpa device without a
>>>>>>> MAC address and run qemu with this device without needing
>>>>>>> to configure an explicit MAC address.
>>>>>>>
>>>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>>>
>>>>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>>>>>
>>>>>> (Adding Cindy for double checking if it has any side effect on Qemu side)
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>> But Now there is a bug in QEMU: if the hardware MAC address does not
>>>>> match the one in the QEMU command line, it will cause traffic loss.
>>>>>
>>>> Why is this a new issue in qemu? qemu in it's current state won't work
>>>> with a different mac address that the one that is set in HW anyway.
>>>>
>>> this is not a new bug. We are trying to fix it because it will cause
>>> traffic lose without any warning.
>>> in my fix , this setting (different mac in device and Qemu) will fail
>>> to load the VM.
>> Which is a good thing, right? Some feedback to the user that there is
>> a misconfig. I got bitten by this so many times... Thank you for adding it.
>>
>>>
>>>>> So, Just an FYI here: if your patch merged, it may cause traffic loss.
>>>>> and now I'm working in the fix it in qemu, the link is
>>>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
>>>>> The idea of this fix is
>>>>> There are will only two acceptable situations for qemu:
>>>>> 1. The hardware MAC address is the same as the MAC address specified
>>>>> in the QEMU command line, and both MAC addresses are not 0.
>>>>> 2. The hardware MAC address is not 0, and the MAC address in the QEMU
>>>>> command line is 0. In this situation, the hardware MAC address will
>>>>> overwrite the QEMU command line address.
>>>>>
>>>> Why would this not work with this patch? This patch simply sets a MAC
>>>> if the vport doesn't have one set. Which allows for more scenarios to
>>>> work.
>>>>
>>> I do not mean your patch will not work, I just want to make some
>>> clarify here.Your patch + my fix may cause the VM to fail to load in
>>> some situations, and this is as expected.
>>> Your patch is good to merge.
>> Ack. Thank you for the clarification.
>>
>> Thanks,
>> Dragos
>>
> Hi Dragos，
>  I think we need to hold this patch. Because it may not be working
> with upstream qemu.
> 
> MLX will create a random MAC address for your patch. Additionally, if
> there is no specific MAC in the QEMU command line, QEMU will also
> generate a random MAC.
> these two MAC are not the same. and this will cause traffic loss.
Ahaa, it turns out that qemu 8.x and 9.x have different behaviour.

Initially I was testing this scenario (vdpa device created with no mac
and no mac set in qemu cli) with qemu 8.x. There, qemu was not being
able to set the qemu generated random mac addres because .set_config()
is a nop in mlx5_vdpa.

Then I moved to qemu 9.x and saw that this scenario was working because
now the CVQ was used instead to configure the mac on the device.

So this patch should definitely not be applied.

I was thinking if there are ways to fix this for 8.x. The only feasible
way is to implement .set_config() in mlx5_vdpa for the mac
configuration. But as you previousy said, this is discouraged.

Thanks,
Dragos
