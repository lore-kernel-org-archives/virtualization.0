Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478FCA5E
	for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238991; cv=fail; b=X6AL4P2SI6OaGUxCNVk3BkPVnSiENUrNAv947oRApG61wromFSz4fsQ+kfxPtusjrV8bZYkBzegHeuy2VPfVzsvLbs7G+X5OTM+DqS7PDl/XO5Sy/cn9/eP8OLa5bqsquObHWNDINoctsWgAlVxEQXtwb7MsvCdvbX3IN7PFtzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238991; c=relaxed/simple;
	bh=CiTcYarjkiIG36fPcW6cSzAY21p1lIgfwnqvsugHSCc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rGY9JyIntjzB/pmfeKR8IItMLC7l7ApeV41aZRv/VChM3lshxjE66FSqarOt9GaHBFWxm9oxFWNiOk4RoAni2uHMidAom7i96fpQdf5OIW0cg77ExNc6ZY7ZYR3MVsl65q5zhk1ciNUTvrQWCEjPO2QKl6LbtfPcJex0kqNpG58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oN394mYB; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oN394mYB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzqIaLdi4M5gk8byOgn7VKMyz3OUSh1jGFfpM6R2631molJP4w7FMHilW2rvDwO+IHY7L3Nl/jzFi5RpJynQQbw+vX5M2Wk7lAfHSlnqsIGUh61UrCUK92mbSYTP8Kft4Wobxob3MZBXHGl3CsyouBXSyhftG4ZhuPHThZF7bL9KSblWrCXBo/ifkF0Ky0Pk8ES6WO725K8xSIs0uqckbLrlkPECbn77dyDI/6jfgfhkIoEl1lVpqRDrXA9bv3odAQcsr2a6zNQORwpGityw5oA8kKofpz40yYHCPLYHCRzhzxQEIYjEnXU8lXoPtCIvr7T3i5+2/EATT3H+E0jf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydLOcgSCeNiwhn4LwjyhN34xuYiSdx8YlDfcSNfatys=;
 b=MCsriOOTBCHvVA2tbH+2c1cnUpworvC+2x6MObZ2Y9+i/rGpncfU8Y5jwIf8lGW8M0i1M7FkK8IocQAp7VoezIWCWuLLkYMbOshO5PBNyu9lviVOylZcuxHlTwwITWNzRQT4X0NE0IxsinuSVlZPHM80na7eYsKe7T7O/1nRxjNFp7Ljc2FPXZqW4YHCxDn4BH73pAL+QgPS3CZXBmkO34DDl4f6AbcZ4Tiugq7nMqGvPsaVmlBSmSRhxwLW4JKqo/BCR4FtKS5xUkcAmACNRPtrC7/f/Un+nyo9fBESbHnpB7OSxiU1mLlPwJepOl+cY40dWGDqb4M6c6ylA/Krgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydLOcgSCeNiwhn4LwjyhN34xuYiSdx8YlDfcSNfatys=;
 b=oN394mYBznUjir7VXBpouu+4N/ScvA6woXpPGngAUK3kgheg9jcWCO7SHIAUJBo7/AW/3uzRrc9ECxkpKLwZqCWbd3AGTm4E68AF6M3MZrHufIHKSYhtppQBj7fkuNyS6ERLGn6V5diDKU9mm0Rnd1xQzCMvZkL/cNBKrHK9CYp6A1TqJQanWWZl/2nQhwaXmm+SsfiOEZt7tSb8SGt/2OWS47FoK8lG7bcN47h/QQU3ShP0gnHozHcq/fiKLJdTEpL7exzu9Yx4LyndmYAHxykL5PH2xOpJahaGIyXuXzmtzwZzKamYWryMY8Ys4jsH2deVBksZqM/ZOcbRG9IoyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 12:36:26 +0000
Received: from DM4PR12MB7646.namprd12.prod.outlook.com
 ([fe80::d87:f674:2f:1c0d]) by DM4PR12MB7646.namprd12.prod.outlook.com
 ([fe80::d87:f674:2f:1c0d%4]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 12:36:26 +0000
Message-ID: <af1e660c-3252-4f13-b0a1-4718e5ce4420@nvidia.com>
Date: Mon, 21 Apr 2025 15:36:21 +0300
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
Content-Language: en-US
From: Israel Rukshin <israelr@nvidia.com>
In-Reply-To: <20250421071734-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To DM4PR12MB7646.namprd12.prod.outlook.com
 (2603:10b6:8:106::10)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7646:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab5a62b-e184-44b2-7e2a-08dd80d12189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2tIMGhxL0wyeHJVd2RKSWc1MmplcHV1NHc3a3BxRnVpY0JzbkFwQ0dJUlJJ?=
 =?utf-8?B?UnBrYzhZMFp3clNsa3U5ZnU5T3RvTndPN1ZlOW9KWE1uV0RxVUc3Tklqc3Vn?=
 =?utf-8?B?ZGRkVzB1dVQwNU1YU3hTa29TaFRCWGpmWlpiRFl2N3RHdmE1WXhQUnEwcTB3?=
 =?utf-8?B?M0ltN1dQWDczUkx1Wk9IR0Y0cGwzaGVJY3BGeXBtMU1PTDBZTUhzTnFBMlJ5?=
 =?utf-8?B?VWY0dGJnRS85V0tSeWNzQnVISzlVRGRqUDVzNGdyc05KMThmY1c3V0JTSWtP?=
 =?utf-8?B?L25vYkxtMFp3QVhNSlhvbDlkT0QzQzlyMDRNKzhkYTMwaVZ1RjNBQVQwcTFS?=
 =?utf-8?B?NjFxSE5mVTFjQlBtdG9ESUJ1MFUxTmE5VUtaa25uK3M5QXpBb0xxMjUrWElu?=
 =?utf-8?B?SWthbnFWUjd1endPNjU2N2FuOThadEo0dUFnZjI3a0R2SHpwZzE1L1ZuMGww?=
 =?utf-8?B?U291V3BudzhGN2ZUVkd2NlNVbEJGQUcrR2dxcEYwTjhxbUcyWlRPV1lxM0RW?=
 =?utf-8?B?MUZFZzdqQk4zUkJET3A5MllPZ1gxOWxTUlVVMnpMMjNNZWlveisyNHp4SnA0?=
 =?utf-8?B?WGlaUzNlM0ZYRXJJbjJSZ0VkSG1GWDdnSU8yUm92cjJGV1NEMlNPdkZmcFpU?=
 =?utf-8?B?Tk9HZnhvYUoyRjQ5STF0RzdZRUlHM1h4bHhRYnRGVWNLekEyRHJ2aWk0WC9O?=
 =?utf-8?B?eUxNMnl6eFlUbXpJUHBNMmtoZzNvZDJ1UlQvWHBBdlQ2TTgzQld3NFlqYWpH?=
 =?utf-8?B?L29IY2hHWmtXcWM0VUw2WVdWeHlrcnB0eGpidkZETEpVUlV3RUZiZGtzTlVx?=
 =?utf-8?B?MDBxWFU3bUFGY1NKTGZVcFl6Z2JxWTBWOS9UTjJFb1FqRHBaK2Z5RVRGVEw1?=
 =?utf-8?B?UHVKcm5pL1AyS1FYa0I3ai81TDMxS1BOS1ExZ09mZmhuR0l6NmdySlhsZTkw?=
 =?utf-8?B?WDI2RVZZK3YxK1FqT2RUWlJGVFNFMzFheUNEdVpkY0Z2M2F2c0N4Ny9Cdm9D?=
 =?utf-8?B?S2tGcUdMYWVoUmNTbWZxblFvcEZwSWlucXVOSkJ6eEJuWmNVbGlrZTlXRWhj?=
 =?utf-8?B?RWRuYWM2Zkt2eWlDMklzRGloS3VUa285b3hZRS95YmpWcWN4TFBrT1hFK1hq?=
 =?utf-8?B?REs0dmpvYmFPRVFMRnV6KzVuY0V5aUJSZ0tLWHh1N0VVUVhwTTlaWm1haHl6?=
 =?utf-8?B?SkhZd29ma0luVWMrcUdzdWoxbFU1MDZrblhqdGcyMk5wU05QTks5aDhOeHQw?=
 =?utf-8?B?QldCYk5FcHplMTVZSWIxV0hhQ1lTU2lvUHY2UVpmakdlaVlKWWJmV3ZkaG5B?=
 =?utf-8?B?aEdUU3JVb1VXQ0c5OW1sQTJBc3A4aUwydTVML1ZxeWxKYVI5SkFvd2FMY0lm?=
 =?utf-8?B?T2l2YmZEWlRVMzdWN3g4QWtlVUxGakFOV2xxWU1XYUMvMXdmc2ZRQXYzYWpI?=
 =?utf-8?B?R3FZZVFscHg3UlRORU45aVpUUFBYNWpwQzU2Zzg0Y01oVGt6ODVJQ3RFL3pl?=
 =?utf-8?B?ZExpZ3pVUW9jNURwdy9IWGRCTllqVGIyN0RLR1FxMktWSmFjb0gxalF6N0xX?=
 =?utf-8?B?aVJyd01sUnk4aERMMzZFaXMzbEZiSWo3a2svaTUvRW91U0lwUHd6djdwWHB4?=
 =?utf-8?B?cStlMTcvT3k4V3VSc1JGRHlEczlnaWhHS3RCbmtuNVFRNVRsdEs1Rys5Sncx?=
 =?utf-8?B?RkJFWlRVNFV4QVNEN1F0WnhESmpDcjNDM2lXdy9leFBmOENUcldKdEJQS0pC?=
 =?utf-8?B?eEcxZkVnYzdyb1FIZkZEaHA4bHNWOEV1UVRzZjhucWJ1bmU3cUUvWW5tMXRw?=
 =?utf-8?B?RERqbE5aUDVJNGNjYTBYMDlGL3RmcXpaYWVYeDlOckNYRTZvZmpXbzNJSm1J?=
 =?utf-8?B?aldvQ3laRHRBOHZoOXJaRTRuQmVGOHZHNXpGZHFjZjN0ZEJYQUVPdWEyOFpN?=
 =?utf-8?Q?aUZgIoCieOE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7646.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eS9ubXpSYlI5amo0OVhLSStwNm1HZ1N1VGFjOURZN21yckJsSnQxVmJudXRB?=
 =?utf-8?B?SlMwSlQ3NTVaSWxFSkhla3I2MldqZEtRb1lUUVRUZ2JwMzZTQVA1MjE1Z2g1?=
 =?utf-8?B?eDd5d1MvSUhoUVdoeWg4ZE9OZFFiSGRVTGhIRWRJUTJFTHMrcHRJZVA5YVlU?=
 =?utf-8?B?VGRhZGFtRWdqRXlEZjFLamtSZllGZTBVY1V2eUJYVC9uYjNUTVpOaHYzc05S?=
 =?utf-8?B?TW9aVVp2ZXhvUU54ZXNsZlMzcC9rVWUxeFIvV25ZTDl4NzdzVU90RVhnNWN3?=
 =?utf-8?B?dlZzak1WeGdUblN0a3dRdnFuR215aWYrYldQWFFUV2ZvTS83dk5iNU95SjNJ?=
 =?utf-8?B?bUpubHkwb1VFbm1GT2JHeHVzbHBiSGZZRTVmMHc5TkkyZ3VFMVNRckg1Ujhr?=
 =?utf-8?B?YmV0a3JFcE80cm1sNlJtQkhTSFJuSkI5UjRQK1ptN1dubHRVVEp0RTVCckZC?=
 =?utf-8?B?ZzI4OVlnUmhOOVJhSXRqNTNKbTIzYkYrZWcyczBEN3J4ak4rcmc1K1RvQzkz?=
 =?utf-8?B?SkdjL3BtdGFuM2RBdDFEajFaNGtBQlpncjZtUWlXYnJnODRWNHNWbmZhTURE?=
 =?utf-8?B?NHhjWThBSG5qM0J1K0w3dFpMME1OSHFRYmlINENHNlk2V3haMG9OMzRhY1RL?=
 =?utf-8?B?RlYrVEZqaTJXYVIxZWtNYjE5eTA4OWJ6Q285N3JjRTdPMkF4WGxmS1ZZenQ5?=
 =?utf-8?B?c0lGdjNkTk5neENKNjJKUE5uQlJaVFJ1aW13RTZEMG5QeHp1T2hPYzZMQU55?=
 =?utf-8?B?ME1JU3VwOTlIQUFWbU1rNTZaeHp4Z3MxS2IwbWpVbE4yZ2tWOTJJcE1QVEpj?=
 =?utf-8?B?dUtpdGt1SHBsanNiQmNvSXJ6ZmxHZVZkN3pnTHlpd2hTY0w4NzVTUitoZVZ5?=
 =?utf-8?B?RmdGWThhUkxRWWw3VytNa0kxODhtS2RBd1JFeSsrZnNEaUF1ZmJIK2VTOWRY?=
 =?utf-8?B?aWw5SjgyTExKNDRzT1EzYUZRQnJ3YitOZjJSK0ZxRzBWb1JaWHJYa2EvQStm?=
 =?utf-8?B?emt5aVFMNG5HQlJPczl5RzVTajQ3WS9aa3lYTFB1bmRpcXY3MVNPMTUyMXpj?=
 =?utf-8?B?dWxoUFdhODl5aFFVMzdVdEVjbEhaWFo1S2V3SlJicDJsVjI3dlBJWDBCNS9Z?=
 =?utf-8?B?NlFLeVNZbVM4R1dOa1R2ME5BeCt0RVBJS29Cd0U0NW5ucG0rK2NXbEJQa0w2?=
 =?utf-8?B?RXJYK2NPdUxKSm9EZVIzb2U1SzdDc05ZcVlzTHh4ekVselhnZ3FTbFBzWDNV?=
 =?utf-8?B?aVI0bUVvZ3cvN21ob2FkblVEZ1FFYjV1UTA3QkFpUXc1Vk5Hd1pIYXFGTmpt?=
 =?utf-8?B?bjlycDlkdmcyVE9tZjhKN3ZUZXp4UmpXdkcxNGpOaE8xTFBLQ05EUXdCelN3?=
 =?utf-8?B?cE93LzJLRTVzNUcxRHhvSDNKc1RTT3VaYlk1VlhmMjdNSEZDZk51M2FaWWNT?=
 =?utf-8?B?ajZjdkhkNzZGc0JEWHBkMnBnNkxxei94bVFVTXkwVWh6eFJuandCbnhrWGFD?=
 =?utf-8?B?VTlxSzhqY1ZacW4rclhiV1duVlk3WE9qamJsa1cwbEhwbG9GSFozWTBRQ0xv?=
 =?utf-8?B?M25CWkxYOFdpTStsQWl0cFFXZUZ5eEw4ZzJJTVVyVXlwNWJaWE1LOTYzWHkv?=
 =?utf-8?B?eVR2R0JFNFluNlRnTisrcnJsKzJ3NGVnOWdEb1hPRG1Da0swZ1FyR2paYkxz?=
 =?utf-8?B?a3NDckxDNWZPRkd1Mm9IRjB2eU9QY1R4MzkrSHVSQ1NEUVo3ZHRlVGQ1bjBt?=
 =?utf-8?B?b0k5MG0zWUlDbUpOTE1oWHRVa2ljak40aFU0VlZ3VTZlaUY3QVlMaEZXdlZx?=
 =?utf-8?B?NGhpTXpNWmVMckkzNC9YMDNNMVlWd0g4ZkFXTGs3UVhFK3Vick9CUTRsSHhD?=
 =?utf-8?B?ajNUK0lUK0d2cS8rUEdLMDh6VnM0RUR2Undwd3I2N1BYMTZaT3FvL1lVR1U2?=
 =?utf-8?B?RU5MQitpRVByNGJZdUVMWlZsSExBcGVZNjMzMGpzYm9ZQmkxc1JrRk42M0RT?=
 =?utf-8?B?a1plbThXWndPdGNNRG1vc2Zic3JvdEdrNjNiNFJydTBHczlTcVY1b1ZmSjd2?=
 =?utf-8?B?MW12YmxrcFVPSVBWZ1hXemZvYWc3NElpY1Y1ZWJRN3hMdXNCM1RoN0V0MnU5?=
 =?utf-8?Q?Gns/mhSzSBXwdqtYgvw5MZtZ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab5a62b-e184-44b2-7e2a-08dd80d12189
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7646.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 12:36:26.0198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEk1rNup8Vao71ncSMPTmm2ci+rcVeCIhz4LgxRXI3eh4DeQSfhqYI8JSrdfcH24s21G66gHCGxQS+mLkc1syw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596

On 4/21/2025 2:29 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 21, 2025 at 02:05:27PM +0300, Israel Rukshin wrote:
>> On 4/20/2025 4:07 PM, Michael S. Tsirkin wrote:
>>> On Sun, Apr 20, 2025 at 03:31:25PM +0300, Max Gurtovoy wrote:
>>>> On 20/04/2025 14:33, Michael S. Tsirkin wrote:
>>>>> On Sun, Apr 20, 2025 at 02:19:05PM +0300, Israel Rukshin wrote:
>>>>>> Add a safety check to ensure that the length of data written by the
>>>>>> device is at least as large as the status length. If this condition is
>>>>>> not met, it indicates a potential error in the device's response.
>>>>>>
>>>>>> This change aligns with the virtio specification, which states:
>>>>>> "The driver MUST NOT make assumptions about data in device-writable
>>>>>> buffers beyond the first len bytes, and SHOULD ignore this data."
>>>>>>
>>>>>> By failing the admin command when len is insufficient, we ensure
>>>>>> that the driver does not process potentially invalid or incomplete
>>>>>> status from the device.
>>>>>>
>>>>>> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
>>>>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>>> ---
>>>>>>     drivers/virtio/virtio_pci_modern.c | 7 +++++--
>>>>>>     1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
>>>>>> index 7209390a5cbf..0374e86aece3 100644
>>>>>> --- a/drivers/virtio/virtio_pci_modern.c
>>>>>> +++ b/drivers/virtio/virtio_pci_modern.c
>>>>>> @@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>>>>>     {
>>>>>>     	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
>>>>>>     	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
>>>>>> +	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
>>>>>>     	struct virtio_admin_cmd *cmd;
>>>>>>     	unsigned long flags;
>>>>>>     	unsigned int len;
>>>>>> @@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>>>>>     	do {
>>>>>>     		virtqueue_disable_cb(vq);
>>>>>>     		while ((cmd = virtqueue_get_buf(vq, &len))) {
>>>>>> -			cmd->result_sg_size =
>>>>>> -				len - sizeof(struct virtio_admin_cmd_status);
>>>>>> +			if (len < status_size)
>>>>>> +				cmd->ret = -EIO;
>>>>>> +			else
>>>>>> +				cmd->result_sg_size = len - status_size;
>>>>>>     			complete(&cmd->completion);
>>>>>>     		}
>>>>> No this is out of spec:
>>>>> 	Similarly, the driver compares the used buffer length
>>>>> 	of the buffer to what it expects and then silently
>>>>> 	truncates the structure to the used buffer length.
>>>>> 	The driver silently ignores any data falling outside
>>>>> 	the used buffer length reported by the device.  Any missing
>>>>> 	fields are interpreted as set to zero.
>>>>>
>>>>> so if status is 0, device can just write a shorter buffer and
>>>>> driver must assume 0, which is success, not failure.
>>>> maybe we can make a sanity check that the len is at least 4B (status and
>>>> status_qualifier) which is basic size to make sure device is acting as
>>>> expected ?
>>>>
>>> The spec says nothing about this. Just zero-initialize the buffer
>>> beyond len and be done with it.
>> What do you think on the bellow change for v2?
>>
>> @@ -56,7 +57,13 @@ void vp_modern_avq_done(struct virtqueue *vq)
>>          do {
>>                  virtqueue_disable_cb(vq);
>>                  while ((cmd = virtqueue_get_buf(vq, &len))) {
>> -                       cmd->result_sg_size = len;
>> +                       /* If the length written is less than the status
>> size,
>> +                        * the remaining status bytes stay zero-initialized.
>> +                        */
>> +                       if (len < status_size)
>> +                               cmd->result_sg_size = 0;
>> +                       else
>> +                               cmd->result_sg_size = len - status_size;
>>                          complete(&cmd->completion);
>>                  }
>>          } while (!virtqueue_enable_cb(vq));
> Can you please explain what exactly is this change doing?
> The changelog claims all that is done is adding a check,
> but that's not true: previously we reported the whole length. Now you want to report
> length less status_size. This is a userspace-visible change, is it not?
>
Sorry for the confusion.

This change is essentially PATCH 1/2 from this series with the addition 
of handling the case when len is smaller than status_size to avoid 
getting a negative value.
According to your comments, I will remove PATCH 2/2 and post only PATCH 
1/2 with this change.
You are correct, this is a userspace-visible change, and the size 
currently reported in virtio_pci_admin_dev_parts_get() is incorrect.

>
>>>>>
>>>>>>     	} while (!virtqueue_enable_cb(vq));
>>>>>> -- 
>>>>>> 2.34.1
