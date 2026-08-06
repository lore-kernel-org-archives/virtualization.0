Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB13484232
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033294; cv=fail; b=kstoM9gabIvWuQFz+RX3eeyomU55y276Lf70MwXLFbyzOTJQ3Z7rr2kjmZOdj30Tg4QxDdTctrViuYWemfVOe/O3Btj/wXVjWE7VIQNBsb/cIDUBsVYDYVO0L8OGxWglh+5V0mjsq9T6Y6F8PA6Y3C3T+DIOLFPrWPsdDj/dRVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033294; c=relaxed/simple;
	bh=vnOHa11kkfCGJNFUOHUP5YJhRdrIdRQPk8phXeOU75E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JeqsM/TVWqpohIK52njbmKfaDpR3/H2NMQorqhXukMSxHVCvF40Q9aKijj1a68fQxw/dtWZ6RHyUGogs+o63YUJs0XjK7BVTuxQEszzyQM1AYKLV8P8tfxX3xGAp9jIHJqhHWg2xrQxFjUEBXHFVpK52uL/LWCfe4nNi+sNDTPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bT/7IRVe; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bT/7IRVe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBxJZxVeeyjdrppI95kuLriak1CPdziWMd9brHJOUY8Jv3fG7GcVKBtzwsnSkNsz28B4lxxWYD4dTgbHzj7Wc5SY6QIkSLNQjELC2tMekVr3V9CL+L1I9RXCPV4IakVm6HHLOPTi5Wpj6umsUjXqGPcUJF57JiwpIJ1R8d0z6Lzq+8Yr6C0ThK7NE7Bi8cmeMuafLYW1LmBVj6uYKD5pmh4HS3neIRY4L+vr1a4p+jBF60eL5kvpdA3jUhAReekTcSqrhLEGGAo+mPa4GrWNxD7JikLSNboCXsm+0HRBaKIHbCL8aUnQGnKscGfCCvAZzjOBVzFcJSD/cKOjgsSrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c3ZjhVDROJqiuKhABpQY3HwqqrdGCJ0MVu/nEKkR94=;
 b=THtOL+2/PffcXCrgnKxLUiVRpoyzct1WsI4CpfZPMZvzhAlYD+G1+adQ0NwDI2cnbiXI0YuqKkGQ0VG75enj9y0wEsPI2GjA2sfeMe1i9HUt+dlWjHgt89CPcV0725CFpZahFhB0Nulhc6dWOjeMYUWMepRp7yCK2KOqO2mjhvVfwA0qVg9qIb6zOrXwPFpIXMvyatQmi6iiJ2ljGh1fepWEfFH5m9tWVUTuEwB/uEucfkN8ppE1nJkQV44Xk/UX9jBYDDXAZ7wn/ovz9TEF+cGuc3Xf9olxn2achLNptys9qI/i2Nf+fZVRbpYo1StKunGdcb4z7//NiDLCFajjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c3ZjhVDROJqiuKhABpQY3HwqqrdGCJ0MVu/nEKkR94=;
 b=bT/7IRVevduTJdb/W7P6eLpsSz+LLFWAEFeAL0/7M+/X2Io2xsMw825t8j76+CP7azHBN8Hn3/NdEgq6nQuQ0mf0Hv4mPICfNOLQlSchVzpgNuSS1ABCpQR9VQxoZyTEx9AYSD5WKqaoBXJmJjUHuWK5Yb2/4fMeVQLMlAoKmyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) by
 CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.20; Thu, 6 Aug 2026 16:21:27 +0000
Received: from DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e]) by DM4PR12MB5389.namprd12.prod.outlook.com
 ([fe80::1f4e:98f9:2c94:8e4e%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 16:21:27 +0000
Message-ID: <05ed4e3e-ce2c-4b5c-8bbf-2e1a2e820466@amd.com>
Date: Thu, 6 Aug 2026 09:21:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa/pds: check virtqueue notify mapping
To: Xiong Weimin <xiongweimin@kylinos.cn>,
 Brett Creeley <brett.creeley@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio Perez <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260804085341.1333303-1-xiongweimin@kylinos.cn>
 <178597788671.1875248.17519886919048135568@kylinos.cn>
Content-Language: en-US
From: "Creeley, Brett" <bcreeley@amd.com>
In-Reply-To: <178597788671.1875248.17519886919048135568@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::16) To DM4PR12MB5389.namprd12.prod.outlook.com
 (2603:10b6:5:39e::8)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5389:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c45c1d-272e-4336-9b16-08def3d6c3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|5023799004|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bh4sTlEXnkBSE7463s5pd/JilehNuumuohkgQ2dX2qFiDsOyP6GsUssZLY4kq2huS3dQ0aEIYtqkEE0zOxdQy66T3Gr7rl/N3/zFAK4MOfyLtHDI3gtDK66Gb87I6lvunyOXmKHzYBwCOOVWcZ/yREmV+MFm193tQ4zV2QiTUfKj+xAJrPYaWW1An4wMiWbiULgOqYfOyInj9iTi2/jGEN0yUkfWryF7NhmIIoSDKTT55j83gJ4BA0pv8i0y6jlvNvPSi3SFiwtUELmBSghWhSNTlFw/Q+g+hTBrZXPsfF7V2YC8Vk+/QWXfvnc7oWwQ1sRZWH0MKLLOpOy5dkf5/HxPofTAJEuQ9ZBJn0aLvAZmuYM9OV13ig0g6i4iWGCv4SxRWJZd3O4+3IaOF4D0xWvApSlAz+0qmoOYXVa+4kyqhCCFGdklgtiNDGsdqEfIuHGQg2RNG3FNrZljlUjb1GsLVe5PbKO6ECjiVFW4wZYr4blp0UQaqr1/YWBHFu2otWr6bK0TCPzvVeMPSljFlmy1j0Qh8BpUitblrkM3GJ1eNtMx0uW7NGeNA2N7HuWjPayuE9m3S0UbHWHphtklp8YJxVmtR+vksLNcjV6bNqu5MZAV9Xinxe+Da73z+0R1buyJqLOE6aDhH4ZsTeP8+YE0lejw7SW8xcZ+4wcVtR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5389.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFBROUg2UnhBTlkvUUtUYlllYkIxQzB5ZTUrTjRUSFRya3lvNVkvMldydjBI?=
 =?utf-8?B?SnNnM2tlRXl0ODdjNVhEalhkTTl5d2hWWk4zdkRKenpndU9lN245dUhDWUU4?=
 =?utf-8?B?cWRleG9OemMvYkY2L2xReWd3aG8wTjRLRkt1U0Y5aUxhTldtTm9DRXplaGNs?=
 =?utf-8?B?QTdxK1hwd3NYV0t6c1JraVZHb0g4U1BFQnZ6UDFCUkFhOWxlQ3AvQlVpaUZy?=
 =?utf-8?B?NTgrcmNCNldhREx4K2NrZjNKbDd4ajd5YXh2MTlaTzVjRzRBd3JLazAvU2pm?=
 =?utf-8?B?SmQ5VWEvODdraGdrZkRuMFgxN1FXWEl2V05FNmtmb0JOUE1wMXJsMmVyaXN3?=
 =?utf-8?B?enJxVTI1TGxFcE51STJoRU5Ta0FLdDZqN1BSdDdJbWltTkE3T1hLSDZMakpj?=
 =?utf-8?B?YkJubFdrYXJrOHFMU204emJpMXJ3Y0ZMem9lUUoxU0ZRS0RxSnZRUkx3VUU1?=
 =?utf-8?B?akZaRXpvTWdnTzdLSExDUFNRNVF5WGVrQzVsQWM1UEhjNDE1d05jUW1LWThI?=
 =?utf-8?B?YU1pQ0RDaGFMQ2dZNFpJM3RmQ243L01lWHhFdzdDUUZJVkNQaVNiK3lYQWgr?=
 =?utf-8?B?ODIwdzRTWHdJU1hOYklUTFhNdkFzREhjYlp5d01JdlFSU0lJU2IycFNGdzdD?=
 =?utf-8?B?Mno1N3MxOVlUeDE2bWxGWTVFVVhtcFh4L1VQUktkbWhWbmlyQ3VyK0dBOWUr?=
 =?utf-8?B?cjBhbWJQek1laVQzcHpUQVZmSDgrZ05iZ0dEMDVxN3VqR2U5OE9rSWd4QTAx?=
 =?utf-8?B?K0FIY3NvL0ZHaldqdUZxM1NaczJJTTQxOFNoa2VUQ2JocHhwVFluc29zcVZN?=
 =?utf-8?B?cmYvRW1JOHpNY1VBMkt6R2d3TktZRDFCKzE0dWdwaG1Iand5QzdLVmp0dFYv?=
 =?utf-8?B?VGgxYk1yZGxRR0EzRGlqZzh3Yi82MnZSSHFjZzhVQ2lhR0RVU0psUVMzak41?=
 =?utf-8?B?UGFvZEt1YmdQRGNKWFQ5UUJqdld4TWtObmFwM2I3MDlIRkx0R3M2MnppTzJM?=
 =?utf-8?B?dTRCMWo4dUVmMkszWTN1aEdhOUFEa29DTVZYektlRVNCY1VxVnZpZUVCZG80?=
 =?utf-8?B?M2tWNitBS2d6QXBTdmtMZ3RkOHdRQ3NKcEZ5U1AwYk1PcWtLV01NMFlrNzMv?=
 =?utf-8?B?MmtTNHNhOUY0UVREM2xNUmVXdjZWRHN2NWtOWS8vWWVmcDdNMkhXdlE2RnF3?=
 =?utf-8?B?NndXdlUvc05QZTlWUGRKbDlHVVRQc3NENCt2ZlI2MVYxYld5YXkyQS9HOTNz?=
 =?utf-8?B?cW5DSHpGSWova0V0U1dPQ1M0MVFsVmEydVBFTi9oRmx4eTdPT3pjN0NjalE2?=
 =?utf-8?B?OCtVWTE4RUZKQXBVb2RuQzEvS1luYXhJVUk1MVExbTBUQlBVOHhOdnFuVVVS?=
 =?utf-8?B?ci9JdmoyaStIS21hRS9mRUhNaFVoOWRRSzM5MjEzdFg3ZDJnNHVmU2sxT1pB?=
 =?utf-8?B?TndERnBqTDAyejhISlhjQ0QvTlJyNU40aVZpaEdicGJCY1pzL3VYU0ZHaVVh?=
 =?utf-8?B?Y3pzUVBlYldLU09FZ25qOXRxZy9rbVM3cFpYWTRneEtseFJhVUJOWkM2dUZk?=
 =?utf-8?B?cW9zemRaVGt0cDhjdGQ0TysvZy9DNnJ5VlFsYStnTXhMdXR3TkhnOW1rdytW?=
 =?utf-8?B?WldFMXh4VlFwNFg1SDIyMm15SVNaaCsrMlVvVk5vWXUvL1Z1aUwvbnRqcHdh?=
 =?utf-8?B?ZjlpRzVkUTFYbmYvVERKVEJUTU9BVEFVc05sbDQwWWwxNjVxdkhScGtsWGRX?=
 =?utf-8?B?S0FreVVlY0VYMEFNaUtqTjJlSDBteHV1eDd2Wk5CTkw3TmMvNW5IQlJPQkty?=
 =?utf-8?B?R2VvTGRsRktXUVBGSktobE9OMWxiVXBVN2M0dVNhblZzUUs1YUFkOThTV0lD?=
 =?utf-8?B?NTVrT0ZIdERkeVBON3p2WnVUZGRYN2t2NEs3NnhlQVRRcmh0dmdzU0tEcVpJ?=
 =?utf-8?B?NnNDdVFBLy81L20weEZiUng4dmVtbnlLUWlDM0RpR1dzRldXaEVnRS9LWUJ6?=
 =?utf-8?B?WnN2Q0RsQ3d5aWxWQi81dW0vOHlaZkZKUTRTMS9GMm9MTjc5eFYvN0V1dHht?=
 =?utf-8?B?UklEQThjakF4eEZsVjVhdG5na09LMVRqUFdTNFlkTVBRdnh5ZnBWSXQ2MCtr?=
 =?utf-8?B?TTlNSDhlaXBLbHA3OU9ld1dXZk1kSUVPMWtMMVlRdWNwalFPaHBZREtQZm5u?=
 =?utf-8?B?ai9BNnVDeSt2OXNwRkRsVzc0QnU4OXBoSUVUTWhpQUd2NldXWWxRL3FBdDhZ?=
 =?utf-8?B?aFMwRG5Zd0h5dTk4L0dUWEZoM3RYUTg1b0Zjc2IySXpIMkJsbnRUWmRzQjhj?=
 =?utf-8?B?YjNQRlZpSVF3ZGFBTXFuWnlERzBoRHlpTGRRQ0EwUy9rdVFEN0Fwdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c45c1d-272e-4336-9b16-08def3d6c3ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5389.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:21:27.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ox5w9Fq8jfhSLvE4yzub4hP23X7MXSVOATzmuuimV0EHLo9w+btMQ20eJWAcveNHW9iATVFujHxBh/2iMH4j5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232



On 8/5/2026 5:58 PM, Xiong Weimin wrote:
> [You don't often get email from xiongweimin@kylinos.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Tue, Aug 04, 2026, Brett Creeley wrote:
>> Nit, but why dev_warn() instead of dev_err()? It looks like this was
>> copied, but I wonder if the other spot should be a dev_err() instead of
>> a dev_warn too?
>>
>> Other than that, LGTM.
>>
>> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Thanks for the review. Agreed — this is a hard failure on the device
> add path, and the rest of pds_vdpa_dev_add() already uses dev_err().
> I'll send a standalone [PATCH v2] with that change and your
> Reviewed-by.
>
> The matching "Fail to map vq notify" in vp_vdpa.c is pre-existing; I
> can clean that up in a separate patch if you prefer.

You could try sending as a separate patch. I was just pointing out that, 
at least for pds_vdpa, this isn't a warning, but an error. I believe 
that's the case for vp_vdpa.c too.

Thanks,

Brett
>
> Thanks,
> Xiong

