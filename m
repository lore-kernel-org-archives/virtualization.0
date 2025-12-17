Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2730FC17
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010043; cv=fail; b=igRi4QUwgDMEsVAdwJ5sle4ZozQJRv0EetFsJNnltheidjMxirClP67TK2ogFAvzFSR+PJcOSVxZw5dJ3Ue44cwGgL+hMi7ndWuJSGIcxBsIRtKbmECCLkViNtUZDTA5pAjKFT9uZH0G/HFFLW8zT6QVX6DRMVfHD+Emrid/G00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010043; c=relaxed/simple;
	bh=LUcvX8JhWyGNwCuOXlUr2PcbSjALNK2Yhb2dDFu4tzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X1nmPR+ew5ELZXvHz03DXP6oem6OquYTDGNut/I08xdegOw9CLoD4cKLE/aOkTwnv6AbJZLunP8614030HRh+8X9wvfZKRi2nKWX63CB2GxCTkd3io5RWt/CvkpxCAQsVUayoqaX0l6t5NQ9sVk6dcXktXqRZfZP9A6NKVyosUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YI7hxhei; arc=fail smtp.client-ip=40.93.198.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YI7hxhei"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diCN67lvHqtbFfuuxZDDeR6IusHkhMGm3m2s6YNvKBvKE5sflXcImFtfOp2c27+5I2zjhPBhaWLF+P9bIk8dIGh9d6nqKoB2L1gEKYWe2dpBrCmBFdCIrDkq0zl5UbmkYbJDErjT7JEmWUE1HS+N3lMLjera4KR9aojUX47utDz13DXsgojVk0+q7hnGk0kEo4qiW5U1oolpSfBM2g3SiBtJGWQqkkzcyfmawsNtQlXjnU2NmRRVqq0+ePr9qqeFbd3m7Lc9Rqzt3SX8EemmWtfNN2Z81tQw8APkn+hyYbCLAzKCAmxi6jKyUUF7cOK+U5LH7UGlZp5vC96azjB6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP/69Y5FQUIB3dg+4OA0DDl+X4oBvJ8NmtR1M1kZq4k=;
 b=FNVHjbhV013Lc2etkpTJd0aPaMMYDQT4wvAz1eUljYmdkUSXMstTpDbj6djLc2vVnZAlJo4o698LLJpvUra9nF5mkGUjuiDrbphhCnyBrU3XDB54NQsL/GLbwqCR2ZYS2HC0djkYU4woaHquoRpOqxh6iz8i8rXtjtle5MUviWMJH4Hz64rXUVULGfqUwMyVWuavtpQZeRV+XoD96r16gKf15GVyKM9/VlfFuiqwa10f2b/187xAjgxXk2S7xavWFwIzHeO2hO++25gSYcSPSQNFp5DPceGB4g+zgSgBG4WEyyFMmyz1xgZokA85ncwU4yzdVPIuW6wIHHVa4voi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP/69Y5FQUIB3dg+4OA0DDl+X4oBvJ8NmtR1M1kZq4k=;
 b=YI7hxheisK2dYomBqzlLFb2xHSQviOscDIvl59u4I0Q9EZFbDobJGJGSjzsKnvM5J4WlNU7wt4KwNZoMyZoTmp3m3Rx1658NvchHCA/ur6l+vBC/CNCfN2KXF+9PSW75aHozKAhBj/Cq9wV5mcA2Xs40dDGk1l3b+0Y0KPR1ivE=
Received: from BL1PR13CA0223.namprd13.prod.outlook.com (2603:10b6:208:2bf::18)
 by LV8PR12MB9641.namprd12.prod.outlook.com (2603:10b6:408:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 22:20:36 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::b6) by BL1PR13CA0223.outlook.office365.com
 (2603:10b6:208:2bf::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.4 via Frontend Transport; Wed,
 17 Dec 2025 22:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 22:20:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:20:34 -0600
Received: from [172.31.132.204] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Dec 2025 16:20:33 -0600
Message-ID: <d4733fde-b1de-4852-9c75-c1c7e1896a9e@amd.com>
Date: Wed, 17 Dec 2025 16:20:33 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <tanmay.shah@amd.com>
Subject: Re: [RFC PATCH 0/2] Enhance RPMsg buffer management
To: Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <andersson@kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <aUMhLc9fe5inQN7X@p14s>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <aUMhLc9fe5inQN7X@p14s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|LV8PR12MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ec91ce-f1fe-4e63-2128-08de3dba7fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azJldjFQTWJPMStlVE1QZ21jMzAxbUxXbkVYNGgwN05mSzdIVDU2dXJQcFI4?=
 =?utf-8?B?U0hNVDB5dXVHVFBCN29tbHczOTFleW1GMjZBZmk3THpNeGtCdUR6dldFbU1D?=
 =?utf-8?B?UTcvWmVhYnIrSkZRRHpVSEgzTi9TVEVYL05mYTZ4UVUyMHhHQ1dqYkdxUm9l?=
 =?utf-8?B?Z2x6RzhtZzQ5eDJMWXFSSFpnT2NYMnVQc0FkYURESnBlUmxBUlBxR1V0ZGpj?=
 =?utf-8?B?eVN0LytIb3ovN051U1VTR1RYckFIT1dBbmVRRVJPeUcxMnJyRWRLOHgzaGV6?=
 =?utf-8?B?Z1F3amk2RHF2ZjZoM1VaaE9hbC9BdGdDejhoNlUwUDloc2F1cWw2bGdPV3RN?=
 =?utf-8?B?amJEUU5nV2t2WFQvOElKOTl5WGlxenk2amYxeEFnREtWS0dVNE5Ba1R2YTlv?=
 =?utf-8?B?UjF6NDdROEJVbDJVWWczbGp1bmlUSnBHRENrSTBHK2hJN2twYk5zTUduUkYx?=
 =?utf-8?B?ZHozRVRrZXFhQTJqckYwVU9rN29pdCtudExoNFJKNWVMQTRlWXhLTEJScnhQ?=
 =?utf-8?B?TEU0bXZ6cmVxb0RWTi9mVWx3YWxzeDFLcGhyUENwQWZyaXY5c0R4a0tNcGtk?=
 =?utf-8?B?LzJzaENrYnBWbEtmR1NZelNqcVZUemJad1dtTlB0Y05zZVpZZFBzZFRacVVq?=
 =?utf-8?B?QjRZUUQvdld3MWtqUzBZQmljZjRYeHUxL3pSY2hzSWtrVElpYUY2eTFPSXh4?=
 =?utf-8?B?Qjljb09aVXVPL3V0YlJIZDZQTTlNdWNLWlV5SHFMbURzaXc4ZWExenByNWpS?=
 =?utf-8?B?dEUxM3lmSDlNck8xWllVQk5NNHRuV29YdHFVUTVXWmxkb3pITkljU01yUDZW?=
 =?utf-8?B?MXhTTHBGUnk3RGFtM2FVVjN6cVhySVNTTlVaRkw4aHhPS3ZiUzZNODl3NU1k?=
 =?utf-8?B?L0J0dHFTdVRkMFA0dzZVVDFSdVg4TVluRUhOa0NpTmxpR3UxNEg5RlAvRkVm?=
 =?utf-8?B?OFhybDI2b3B6QTRFRWVWYkZCbXBSbkhOUjN6cHZhK2huclVsR1dKQmVKVlky?=
 =?utf-8?B?WlhzQjIxRWNmK1F1RkxUcVlzeVZEYVBiUTI0MVRiazJPNzBWeDUwKzFqMmU3?=
 =?utf-8?B?STVXMU1weUlINUFaM011WDFhejk0Y0dlWlBRU2VyWHRqSkVQUUNGaTBjaDhL?=
 =?utf-8?B?L1FINFZGbzI1U0xGa1d0bUN6RlIrbW9ZYWcxNmxhM2lqVkJ0NjdhODZDS0Q0?=
 =?utf-8?B?aVZLMHAwR3dNN2ZMbUI1eVFpb0FNSEplWU5VSS9DajkydThCSlhTNmJWbDk2?=
 =?utf-8?B?UXNqL1R3TEVUajlXVEFmSFdHaTB0MmRoQnEyQTcxcXd1QytTb0J2dXVOeDhF?=
 =?utf-8?B?S3B5aldJWUVaUWgxV3U1QWlzdjAzR1Y5RWVBeVRwNU1zWjFkZWwwUDR6V1RZ?=
 =?utf-8?B?cEhtL0JWcUVmZ1lsT3dsWnRZNGp0NnFGL1UvN3B3YnVuUUxacGp3djF1NzVm?=
 =?utf-8?B?UVpSb0lKNVFiK3RidkVqS0dkQXN0Wlg4OEQySVlDUU1pdjVieEl6bDJkNjh0?=
 =?utf-8?B?cUcrVjdNSkVjd1NYT296NnZHVlUzeFJ5eHdzelBSc3ZDTnIwaTJZSkh1aUdQ?=
 =?utf-8?B?ZjVoYno4VGN1bWpUNVFESjR2akhndUswMGRBWWhQOElhZTVwS0dCWXQ4Qmls?=
 =?utf-8?B?dTlNMXdiSWR5K0hKYld0MkowN3hGSTNxcEZwYTM1a2FqcTFzZld2M213cjlC?=
 =?utf-8?B?T3VJbVFsZWJRQ3E1dFVYZHdqR0tBTUhqMlZCZnNOMXF2eERjc1ZhdmdnbC9q?=
 =?utf-8?B?bmtkWGZSdGlQeWlZK2VhMC8weU44SzJGMGdxR1Z2aHhnTXFUczBxbEdZTFFV?=
 =?utf-8?B?bWpRbWNZUUxMKzBsL0hyWS9vd2UxS2oxQW9vdHlra0d1S3FnVVR1N1hic1Qw?=
 =?utf-8?B?ZDU5cmtZS1FDaXlKemtBNWs0NGNKbXFmRS9TTlA3bW5qQStMLzNTSFhpNGVl?=
 =?utf-8?B?UUkyN2I0aHViMkhYejJGbWRVMWpsNkgrQ1d4QUlwRzNQbitZOC82aGkwNzll?=
 =?utf-8?B?TmJLdHZYcXZOeEdoOC9NYXdGQjM5MTZkK09hYXFyOStEUnNCbXNGRkhqT1dF?=
 =?utf-8?B?R21lWktFcnk4V0FzcUpBUmp1bGwwY1BPOGZzMVhXeXR1UE9qUTNIMUsvV29w?=
 =?utf-8?Q?2QEM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 22:20:34.9544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ec91ce-f1fe-4e63-2128-08de3dba7fc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9641



On 12/17/25 3:31 PM, Mathieu Poirier wrote:
> On Fri, Nov 14, 2025 at 10:46:38AM -0800, Tanmay Shah wrote:
>> Take rx and tx buffer size from virtio device config space in the
>> resource table. This allows each firmware to configure RPMsg buffer size
>> as needed in each direction.
>>
>> Original seris:
>> https://lore.kernel.org/all/1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com/
>>
>> Following modificaitons are done to the original series:
>>   - Separate dma allocation is not done for tx and rx buffers. Instead
>>     allocated chunk of memory is split between tx and rx buffers.
>>   - If vdev doesn't support VIRTIO_RPMSG_F_BUFSZ feature then use the 
>>     default size of 512 bytes for buffers
>>   - Change MAX_RPMSG_BUF_SIZE to DEFAULT_RPMSG_BUF_SIZE
>>   - move virtio_rpmsg.h from uapi to linux dir
>>   - RPMsg buffer size must be set to hold rpmsg header at minimum in the
>>     vdev config space of the firmware.
>>   - align total buf size to page size when allocating and deallocating
>>     memory
>>
>> Xiang Xiao (2):
>>   rpmsg: virtio_rpmsg_bus: allow the different vring size for send/recv
>>   rpmsg: virtio_rpmsg_bus: get buffer size from config space
>>
>>  drivers/rpmsg/virtio_rpmsg_bus.c | 105 ++++++++++++++++++++-----------
>>  include/linux/virtio_rpmsg.h     |  24 +++++++
>>  2 files changed, 93 insertions(+), 36 deletions(-)
>>  create mode 100644 include/linux/virtio_rpmsg.h
>>
> 
> This set is going somewhere.  Please address the comments that were received and
> send a new revision.
> 
> Apologies for the long review delay.
> Mathieu
>  

Sure Mathieu, no problem. I will be on leave in the January, and will start
working on this patch series once I come back.

Thanks,
Tanmay

>>
>> base-commit: f982fbb1a6ca3553c15763ad9eb2beeae78d3684
>> -- 
>> 2.34.1
>>

