Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795047172;
	b=4AEm1TSDgHQRYIAHUS0sDCQW+dER7l2Z9AqkZFbVr2ujPkXSj6uZCUUIK8CROXdtpN+f
	 cxgcA+Bu/YdnkiKd+icgRU2+Qi65ayhhUOhKWRhSe7r7IvEXIKnx2lapKF2vkK7wWZFHi
	 EQx4F81mesvYG4d8KvOY4nxnv1HHZ9UAx3roNbmpUHrfXBWVRufI2jSHJ2PWT3c6Fs7CB
	 DpNG8xqNacJ9umOnBJmNw8TilSoytTdkUsip2Z4OH28ukAcy8/XGleZdLR5kDZliWcoID
	 MlEkPHP4ti/ZpeuoZtx9ALmY2mDQApxyQnbeSlTkYVQbHJAW1uwviGmASzsHyuwtbgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795047172;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HSwmMFbMcuoGnbaPCp6Kzu+PXKVfQeQZKhHagsueKak=;
	b=KJBqC2xjo8pSj5xuRgKcihNObwR62EOApJP7tnI3L8k76yX4YelLjNAytwsRSfC4dUg0
	 DQPju1vNGKnaWKjiekHNjAtReudO8JlvbXwov3kZkty8NFs/9dkaJhSQc5s4aug1FYY1T
	 T5YfVbcyMNC1Hl+5nSkA3bhW21u3yEWEgxaOprCpZTa4x30Z2aHNC7Ys+WBmqoC1eyqvi
	 aqiPdgjLZgAqJkfKuGVo/MgpICL0oskMdEcNSsml6I14eeF5j3uD7I+YjPOtBnWSOBymO
	 W2Xclt0H+Fl9n53n0NsXRC7r7+v0cU61eLK+UtLrA1CjtFKq1AxLlF+54YJFzA9rKHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pBqrXFZx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.55
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C0606A333;
	Thu, 19 Nov 2026 00:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D97C0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pBqrXFZx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYPY9aNZ9+VUFhuRTVWItXWe6LA1ELe8NyvJ7Ok2zx3/0wkPzK0mHPeU885hXGYmXDJDxuQ7BBu2RK5vqwb3eytMcmL0W1me1vzW7v5CHSymecosg/qx51eSl1E/fGuCzo8s5oOIAXKZulZcjM/K84iHGlGbfcyzpCrEXGqbNobqj7fX78oh1y2ze7pnQ/26A8PLfioBrS/gDfmzBjoI9xPTKup32u7c65t+vlMCASfDmTHV2rF/fgmmgFORd/yBm8+q6zFFdZ6mA5wOBveJJPS89vOsX8BlkS8gg67HR2MKaEJE0X9d840zGIlEjD9Ow4QcKvKQ2t6YiTjFeRK02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSwmMFbMcuoGnbaPCp6Kzu+PXKVfQeQZKhHagsueKak=;
 b=fbYdftSE80tBLNnV/ez0jiIknAiZgPvNKRgmuK6YOosa31MsIyqxVPRQZ9mM9kMvG1oFnC1umFZmiFWKwovv3x7+uQmy+EVsMNqUq6MI+VXF7HCjwreDT9o5e1V4+BFULwuh/CN+eR+iwklotRHZdeh/qK0xTkwr4S9T4mBHeqNOlVlxtlnkMoBHZxJE2hurX6uC4DAiSQqnA2puFMscBDyHgGgvH6hAPmYD7oqkQE2hDGda9f8giyJSF7N3ik1PTpJJ7x3+WhbjV/omWcp7vpVpzQXUBZzXj8Sv2wef6377uq2TObmhBUsM6LevuA0veCJ6OqgaxOeLcKjA8rmnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSwmMFbMcuoGnbaPCp6Kzu+PXKVfQeQZKhHagsueKak=;
 b=pBqrXFZxH5df2mkpkvSBs2ZBAVdHZFTMIcVKqU8gM0iPbLxwxoxum+60y9bhZPeYj0YxNhvDXmDtq7dhNlNygpdTdgLfS6W5K+1VIn601umtFZZKNAXhWo5RK+UlAzpQB54dVdVnk2PsvZhtn4ZBRV1DMnsBFDbqKWd9DmO4WaM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) by
 SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 00:12:47 +0000
Received: from DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e]) by DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e%7]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 00:12:46 +0000
Message-ID: <f3be0259-80b5-4474-94b7-0f6e7591f499@amd.com>
Date: Wed, 18 Nov 2026 16:12:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Allow untainted use of driver_override
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Johan Hovold <johan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 David Lechner <dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>,
 Thierry Reding <thierry.reding@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Karl Mehltretter <kmehltretter@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Marco Elver <elver@google.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, Jeff Layton
 <jlayton@kernel.org>, Bradley Morgan <brads@mainlining.org>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Pnina Feder <pnina.feder@mobileye.com>, Mete Durlu <meted@linux.ibm.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Rio <rioo.tsukatsukii@gmail.com>,
 Feng Tang <feng.tang@linux.alibaba.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Yishai Hadas <yishaih@nvidia.com>,
 Longfang Liu <liulongfang@huawei.com>, Ankit Agrawal <ankita@nvidia.com>,
 Brett Creeley <brett.creeley@amd.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Julian Ruess <julianr@linux.ibm.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Eric Auger <eric.auger@redhat.com>,
 Mostafa Saleh <smostafa@google.com>, Pranjal Shrivastava <praan@google.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, qat-linux@intel.com,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 kvm@vger.kernel.org
References: <DMYH4ED3GWDO.29DGXPK4M82VR@kernel.org>
 <20261118235645.2907908-2-alex@shazbot.org>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <20261118235645.2907908-2-alex@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To DM4PR12MB5389.namprd12.prod.outlook.com
 (2603:10b6:5:39e::8)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: ef748d09-9e5b-4b0c-44af-08df45d1d5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|261026140227099003|261022105027099003|261028144727099003|56012099006|4143699003|261021123027099003|11063799006|261021121427099003|10067099003|261009223027099003|261102123227099003|261022075727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Q71K5ZIH7rsQeAfNKqqsD9kMUMPictFuHLsbFC1/vZLlN6oVeKs1hOnprAF7BRnSDO5eCMQ5JvSRyod0AmD4CERon511iXrAlTXWnx7oqCgYYKS4+TUBKBUiS+H02hiFlrE+b2BTwMS1e5rs4VgvBI/tf6G1SSgfLaVk7ONgHSB/eL+JX34B1EGQ8XN+ulRpTLKS1eMNPFww5qLu2fOdZkL1voMGA7A1mWuf1okXmUXy1GJRst9Wn6v2x4z7FE+Bc0ZM72Bfx/gumEo8pvqQmxjYHsYSQCnFSw2591bYwlq8JPKB0YBhO+DKO7dwmiHv/nzUP0IWC3TOCYQE7STufyQvDdgPQbbpjvoPHkpC26oJ70kLreacG1VjXQ0eLVE8ZeF+PkeKqswS4FoeYP+YLS9Iq8CDD3FCILT7CuhXLQST2743P/gVj3HNn1La66KZ3Opj78LMjsMawi9OqQE56YOxtV4ZO1g0DkS2kSvcGW3GDZLMj0kFS0JB1fC0dfRUpVyDTmE5bUZqAp3BLD/aQp9Bktqvussi+vnTT/Ca5iFpmKST0zhiS7uc1HmkriU3ARsGyvR2ChMqiznnLETjyN9eEe1RzNL9Xeminamm6A8fLwicQV0CDgu/d8i4Oy774+mMFMyUpla7wPOvSNlR7ytHi0gbTZ8XCMrS/kr0nvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5389.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(261026140227099003)(261022105027099003)(261028144727099003)(56012099006)(4143699003)(261021123027099003)(11063799006)(261021121427099003)(10067099003)(261009223027099003)(261102123227099003)(261022075727099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YndLTnFQU0VsZmdsRy9MQm9VQ290OUpXblRhU3J6TUkxYWx5YjRXTmJrbmRo?=
 =?utf-8?B?ME83cU5yNjc3SjBTWDYwVUh0aUFPbmJaeFZGMVA2TWtQbndtQTVzbzBxMDRC?=
 =?utf-8?B?U0tFT1BiZHJsOVd4TWFjTk9CakFkMEhRMmFlRFB0cFNKQlRnTHgzdTkvNk0z?=
 =?utf-8?B?bjE5N281emIwaE5Tb2JpRGR6di9ReTJFcUxmV0I2dm5yQ3NvNHhFSldOUitS?=
 =?utf-8?B?YjJVRUlkUGJ4R0g1SDlVM3hZNGVJOVpESWZWS3o1OXR0RmNkdzgvK3ZSc3VU?=
 =?utf-8?B?UmcvaUFCWTN1WVg2K2V0YjBSR0JwZjFJNkNkNWtsZWZvejVJalRQMlArbzRJ?=
 =?utf-8?B?QlZFMFA3clpETkIwcExVM29CTUxRZGc5SVFWM1B0MGVuTGhBRUZ1YkUwellS?=
 =?utf-8?B?U3l5eVkxMWtNQThJZ2VhVkxZbnBpWmVsQXRiU09VUEhkbkZlbHhiVlJrZGcy?=
 =?utf-8?B?Ym9iRnhOTlh2MEU4ZjdyZ1pXZXBGUkswcGdEb1UwYjhFY1F3ZFNqTHhVTVBB?=
 =?utf-8?B?R2k4ZzFiYi9NMEdQOEM2aFl3a0l3dmVoQ3RLaVAwajgxeitkN0JNUis5R1lY?=
 =?utf-8?B?K3FlOGwwTGF1eXpQR1dNaXBSVUxKZGQrVEErWlk3TFZ6OUNYMzlRcnl2WG16?=
 =?utf-8?B?WExCMVN5bkhCWFFXc1JsaGYyaHBqQ2RxMmJjWXhXYjRIaG9OVFY3NHVnYUxt?=
 =?utf-8?B?NkVKRlpWTVhmaU9uRkNvWU1RNlpMSTVzQjkrZ2xwM3dYN0hDOWl1TFNLaUoy?=
 =?utf-8?B?ek5jVnpHRHNuM2l5eVNGc3h3Wjgyd0FEWkoyUGdIUDRzeDhEUG1TSFhqMmQ1?=
 =?utf-8?B?WnVnUk1UU3gzZzZDZE9qOUFDVFh6eGN1ckdnR1AzUldkT2tIMUlONWpLWnBC?=
 =?utf-8?B?V0p6L3piMERzOG5GTTNwU0xDNEhHMmpSYWxUcFpuaXFIWm1UU3JTNklPTWZ5?=
 =?utf-8?B?ODFoU09rT3pmZWVxT0xnMms1RG0zMm9mWTcvUnZqRFRUdzRSVStCVTNLcDlz?=
 =?utf-8?B?QWFKNUlJMXQ1eENRZGY5ZGpUM0pRSFlGcWlZSWR4aTBMNWUwc2xpNDR1OE5T?=
 =?utf-8?B?dzF1ZlJyd1gzNGpjaGlTYmlGNllSMjRPNnpJRHdBUmdUSHI1QUN4Z3NvcTJi?=
 =?utf-8?B?dWUvN1F0SXFVTXVxWnBHOTIxUTE2TXFVL3JPSzhFQVc4dXZXWHIzNFd5NHlJ?=
 =?utf-8?B?OC9DVUlnYUxNZnFMcDBJcGVFVFR5K1I2REloZTFsZ281Q2dTaWNzUEMyNExE?=
 =?utf-8?B?Q3pqUWRLdUtyREVMM0ZWekEzWG1OTWRLZS9tRTdSZm96RXYrY2QweWhJREEy?=
 =?utf-8?B?aGlVMFE0Tk5VUzZjbVhPOGoxcVZ0ZzdRZE5QNEtNTFc2bTdYaGY5YitnR2V1?=
 =?utf-8?B?WEc3NHNCaTR3aXFxQm1mdURnclFaK2IxVE1reXpHM2dqNDRiLzJuR2laWHc3?=
 =?utf-8?B?NUt0OVpmOTd0ZEp3VG1RUFRCeGIraEtPSGZlRHFBVmE4YWRTSHpqVHYyZnlE?=
 =?utf-8?B?YXBqUnhhakR2Q3E2ZmxlL1JGSHNxZUJyb1EyOStodVRLd3hTbFlMN3dQaFJk?=
 =?utf-8?B?b01VRDZEUWRGQlhEcEcxdTh2VmFuMXUxUlJtQlRSanlDQUh3ZkhqRnlPS3Fs?=
 =?utf-8?B?NEc4Y3Ruc3BKMjdHMWJJNXZya2VaOXp4emhXMlRYUmVjRUszbUtqMjRqcUJF?=
 =?utf-8?B?ZjN3MGhJQXBGUjc5cU56TkswbG1OVFpuTlg4SGU0V1ViT1I3QjJtb3JkMEJ2?=
 =?utf-8?B?VkJHbUNpZ3VBNndVRHo2WWxxQ1k3eUw4bUxiM0MwNW96eGUxVjB3dkJiUGxu?=
 =?utf-8?B?dzU5MDNEYmhDeGhDSElMSUViV1ZDWDZxMVhJTWRnRzFTNkpmbGpwVmxDdFpv?=
 =?utf-8?B?MlZ4a1VrWVZYTnVrdGRScThYTEVqbHJaK1Ftc3lhSU85Z2EzMGQyaitKWTZP?=
 =?utf-8?B?Y3pCcURvYVVYT3RBSXAvVGJmS2UvYnZpejJzKzh4bkxxN1N5Z2ZHUkVHaEtR?=
 =?utf-8?B?T2xid1dIa3kzaHpLeHlSSXFDU1NhbnBHVzBqUUFLYWFaN0VCR29YMFlEaFBm?=
 =?utf-8?B?dXFWVDIzUlJKVE85RXZ4SGJjNFpCUE9YSzg3NzhNakdSeTVPRWd3V1FZZ1l4?=
 =?utf-8?B?N3VKOTBJNnJwalErNitOVzdMbVo5WEoxelEyc2RlTHNHU2Q0OURDUHVsamYv?=
 =?utf-8?B?anZLTnF1aFNORUZHeGFyYjNJdGlheUd4VDcwT1ZkQ1ZWa244VEtqTXdwYmUw?=
 =?utf-8?B?ekpJdzZYUWFhdVYzTWFCT2VycDBMdzFkOStuaWhUYmtWVEZzZlgvYXo0VE1F?=
 =?utf-8?Q?os8m4OH8R/6p+fxIcF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef748d09-9e5b-4b0c-44af-08df45d1d5f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5389.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 00:12:46.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtBuCPMdT9+dmHBDwWX5VxhpUlzh5eUWAR+6BWWwIBmohxPQ0v7ZkPE7zBmSsAbF5WUYtHwyuKHU6wTnVNnBqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005



On 11/18/2026 3:56 PM, Alex Williamson wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Driver overrides are the standard mechanism for binding vfio drivers
> to devices.  With the introduction of the support_driver_override flag
> in the core driver struct, it's now required for drivers to declare
> themselves as driver_override compatible, otherwise driver_override
> bindings will be denied or generate a kernel taint.
>
> Set the support_driver_override flag on the driver struct across all
> vfio drivers.
>
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: Longfang Liu <liulongfang@huawei.com>
> Cc: Ankit Agrawal <ankita@nvidia.com>
> Cc: Brett Creeley <brett.creeley@amd.com>
> Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Michał Winiarski <michal.winiarski@intel.com>
> Cc: Julian Ruess <julianr@linux.ibm.com>
> Cc: Nipun Gupta <nipun.gupta@amd.com>
> Cc: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Mostafa Saleh <smostafa@google.com>
> Cc: Pranjal Shrivastava <praan@google.com>
> Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
> Cc: qat-linux@intel.com
> Cc: virtualization@lists.linux.dev
> Cc: intel-xe@lists.freedesktop.org
> Cc: kvm@vger.kernel.org
> Signed-off-by: Alex Williamson <alex@shazbot.org>
> ---
>
> Uwe, this should cover all the vfio drivers that expect to use
> driver_override.  Thanks,
>
> Alex
>
>   drivers/vfio/cdx/main.c                        | 1 +
>   drivers/vfio/fsl-mc/vfio_fsl_mc.c              | 1 +
>   drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 3 ++-
>   drivers/vfio/pci/ism/main.c                    | 3 ++-
>   drivers/vfio/pci/mlx5/main.c                   | 3 ++-
>   drivers/vfio/pci/nvgrace-gpu/main.c            | 3 ++-
>   drivers/vfio/pci/pds/pci_drv.c                 | 3 ++-
>   drivers/vfio/pci/qat/main.c                    | 3 ++-
>   drivers/vfio/pci/vfio_pci.c                    | 3 ++-
>   drivers/vfio/pci/virtio/main.c                 | 3 ++-
>   drivers/vfio/pci/xe/main.c                     | 3 ++-
>   drivers/vfio/platform/vfio_amba.c              | 1 +
>   drivers/vfio/platform/vfio_platform.c          | 1 +
>   13 files changed, 22 insertions(+), 9 deletions(-)
>
> <...>
>
> diff --git a/drivers/vfio/pci/pds/pci_drv.c b/drivers/vfio/pci/pds/pci_drv.c
> index cf7e33d4d17b..1fcef987f1b0 100644
> --- a/drivers/vfio/pci/pds/pci_drv.c
> +++ b/drivers/vfio/pci/pds/pci_drv.c
> @@ -184,7 +184,8 @@ static struct pci_driver pds_vfio_pci_driver = {
>          .id_table = pds_vfio_pci_table,
>          .probe = pds_vfio_pci_probe,
>          .remove = pds_vfio_pci_remove,
> -       .driver = { .pm = pm_ptr(&pds_vfio_pm_ops) },
> +       .driver = { .pm = pm_ptr(&pds_vfio_pm_ops),
> +                   .support_driver_override = true },
>          .err_handler = &pds_vfio_pci_err_handlers,
>          .driver_managed_dma = true,
>   };
LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

