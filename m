Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9C28726D
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867323; cv=fail; b=dCBQNSoEawSHyOqY/mpQtM1a78JPIldF8jM+a4tkEAwo5U+hgE1Dj7C84fjztps/mLsD28bSqMwJtR8qV95fqCqNX3Yg0woUwYtlWGNMkTYZJBusumrVlPYZ47ETmGj8YK6h8aHTM8hawo1aHU0QHHPLnefQq8UGt8J3/XwO6e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867323; c=relaxed/simple;
	bh=MpF3lgjFpiTNx5xqDzP8BK2XK15X582dfkev7xF1lDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XJFZ6YYHjz0sYLtQ+dSo0dFxYpRh14p6w+ChuudtlZjNDuQV0iCJKhZHOf1aYwc2C5PBSxvPl68WvZbfggMXKkZU7THf7Lx45+es1jYD93qBYxwbTRF84QPM1cyqpP5jljidCgpfuFQlttFl6B2iFtGVkGfp8sTVInNJhgsLiOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ov6fH1rW; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ov6fH1rW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ef0rzk2QAysAvu2bc8Y2revKIVAvp+v1p6v6t5aV17IR9OK8xFyaxCy4D/bbqhxVIEL2ieIffLDCU5TOPYtXi9Ut+k7tAr5xrPBuoNCigmxoUtzZhbMM9lxou4yUOFJc+OPoory5lxYRxLGvKvW8F9iu6/otSsPYhB9KTmcFcdnRGXqtNnrtbkKXu157ln1+n+84IgExPBOlpuBId3LabEtsj0+pFKdKHy0XVuJ0Irf6Ufiq3W0UxZs+7t2DVbk/o2MHN0mbvPR2l4fUxVlqCkeEBJwTZTW9qNKPTxI0rumqA0ddUucXN/d6h/MoUtylSn/LDQ35T0rq31P6VICyvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tervvq4T+1ubi4aOnS0pYKWS5Je8F7WLziImbSZTk4=;
 b=u4RNFCPuQeZGHsOfnf7Rf95LGiZDkR6NxZyO2A8eIZ5wYwXG/8/oQq1whzy83Hp0iuAOOOULgsbuAJQIu8UJyU4a9VsvvPlNfCI3D23tUAog4Whsi027QxwnBiwSb7odPbGKB6UjWuuiXquhMmC/LwF7hq1xeQDtByDkVgn264MvveaYs+2ZbA1nBs/2HmVlpGeXwi01BnpJHhjwtcPlK0AVaEnsSToCtzTInGydy6aIxbzlNweL1WNnMFH7kMAsrw1IYQOoxIPFZZ7DdkQ6GyJaHstq6NRp38jVRcB897grM/rWCf2PK46YOlMpX7rHigRDeT3RuK7FNsCL69gzMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tervvq4T+1ubi4aOnS0pYKWS5Je8F7WLziImbSZTk4=;
 b=Ov6fH1rWuOg/+zLNlbIllAsW0N7Byo3rlNNDOQevWianMB3X0S8zQlQiAvhgZ0/St82vndIM0gbeHa/E0O2hN1ODrhEtbEFGGKunNuf27pEmXLVkLPNv5acHZqtYBT1Qltl+cZsIknbRkKzn/sFRpkaRJUGzMFNEZEoP8r4WLX4=
Received: from MN0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:52c::32)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 16:55:17 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:52c::4) by MN0PR05CA0024.outlook.office365.com
 (2603:10b6:208:52c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 16:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 16:55:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 10:55:12 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 10:55:12 -0600
Received: from [172.31.132.204] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 4 Dec 2025 08:55:11 -0800
Message-ID: <d858a46d-e5cc-4d87-b5b5-8130dfd42145@amd.com>
Date: Thu, 4 Dec 2025 10:55:10 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <tanmay.shah@amd.com>
Subject: Re: [RFC PATCH 2/2] rpmsg: virtio_rpmsg_bus: get buffer size from
 config space
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, <andersson@kernel.org>,
	<mathieu.poirier@linaro.org>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>, Xiang Xiao
	<xiaoxiang781216@gmail.com>, <arnaud.pouliquen@foss.st.com>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-3-tanmay.shah@amd.com>
 <11280877-95f0-4361-9112-23bb17372e91@oss.qualcomm.com>
 <c5395ebf-b0ea-4be8-b0c0-6a51d4c98e09@amd.com>
 <20251203142540-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20251203142540-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cdd4354-df18-404f-9f7f-08de3355e71d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3g3bThXOC9mTE5xd21hMXZ1QW9xejFJemQ5ZS9zNlE3MFp0Qjk1djROZlZk?=
 =?utf-8?B?WFhadmpUSXpPZVJKZk4rSWRiYVlUVU5nY0RucnExMi9YeDJLMmo4eWpQR2ZB?=
 =?utf-8?B?YTFZK1RhZ3h3VWpVRUdXYjVuaHdnWUxyNkdKNHhmcDBRZ3JoYm85UE4yczFa?=
 =?utf-8?B?SWRhZWduS1JIZm52REd4SkVLSi9ESnFHY01SeGFkV2Z2TUJMd29FZW4zZ05N?=
 =?utf-8?B?b0JrTGFFMnVtWVVRc2p4dG1HUlRCb2tuZmQ1ckNlZitHcmIzMUNlY2htNjNR?=
 =?utf-8?B?RXFxbS9wN25EU1hNbjVIbGNuS0NHdjE1UlJoVjh6N2QzWGp1YTVMUjE3V0hU?=
 =?utf-8?B?bEtuaE5xTytaZk90ME8vSStuWGl3dXVwN3V6NlZNbmpBWHlqMHVlUHZQV204?=
 =?utf-8?B?YzBsbkpvanZXbUVPQlhyM2RsZHE1TkhlQk9YbzdZbGtGc1MwalA4VUpLMS9T?=
 =?utf-8?B?M3BWYWJOTVR6U0JTcEdSNVl1ZCtTa25Wci9YbWNBR3dyb2JhZWdNQTY1dkJX?=
 =?utf-8?B?LzNzVi9RZVFoelowSVBaY0V2L0ZCWGpLZ3Y0Y0R2di9oZTJOVDRNQmpQVzMv?=
 =?utf-8?B?S1J3RVZDLzgvNVNXNGduSHRZWVJ4cVBnVEZYU1VYcmpVUVowU1RncG01SFhF?=
 =?utf-8?B?TVd5eXlVc1FHRWxTWUdJcEpmUWFrWTFjMmxTWlNYenlxZllkdGwxcEZMajVP?=
 =?utf-8?B?eVMrQUxtVXNPcjVKL0NXU1lCTENOUmRLTXVmVXJ5aXY1TTQxMERkbmFjTENP?=
 =?utf-8?B?eEFvc0R6ZmtZalp3TFBFUDJ3YjdOcnlyYkNaTjJjYWE2K0taazBCQnpGNjRv?=
 =?utf-8?B?SFdqZzVHWUhBOVhpV2R4N21oYVM5clpQSWlocFJmWTNiSU83eWFpT3pQaUg3?=
 =?utf-8?B?Ykc4WmFMcXoybUgvbnJZS3NZNEtPd3NHNTk3ajlBb1RCVjdrZC9TMkRXWXYw?=
 =?utf-8?B?U0FNT001RTZjcnlhMzEzYTN0c0p1WG9MdzI5bnFwU1JzSGF5Vml3WDlzeXR2?=
 =?utf-8?B?cFhaSE0xOVVMQW1sL2VhL1o2RW9DcTlyS25jS3UyRkE3Si93dUEvdnNjTmRU?=
 =?utf-8?B?V1ZpTTJXa3VaOEpSQlMxcWJSVy94SVltZWRHSm5Vbm9HQmxQSi8zMFNFcURx?=
 =?utf-8?B?WjJ6OTR1SENKbmtLLzAwQUQ5RVhGZmZvc1oxUm9SRFlGMzNQdnlPcGR0V2pZ?=
 =?utf-8?B?VGlycFhNYzcxTWw1M3kzdm96ZkhVa3FVY1JPdXhFUTRPbnBNeHJac1pnVG43?=
 =?utf-8?B?dlZ3SVh1d3VRa084d0VXNlpQUGZsbkVaV1gySVlnVGRRaUV0VTJGTklOdnJW?=
 =?utf-8?B?aGN0Mm9US0wrS2c0ZWdDdHQyU2F5cWVFVmo2aE1aMjBWSW5HNEo0dEhKZEJH?=
 =?utf-8?B?diszMXNqeWpuRHZmR3VieC94NEpmbjlhQlRYYm5Qc0JlQlJZdTRZNGVBRnV6?=
 =?utf-8?B?RVUyTytJcmJVNmNtRWhhb2dRdTBWTDN5YnNwU1dRMnFnRjFUNjhwV3VySmkz?=
 =?utf-8?B?U1pQRld4M2pmTWExT29FWi93RGgva0svMW5kblQ2VGtQazZjeUtpUHR3ZHhq?=
 =?utf-8?B?bGcvQ3RSR3YwbWJUOGdTN2pDYjQ2Y0lyRVRobm0zZ3NUS2VlTktlQjhQUHhh?=
 =?utf-8?B?NFUra1VxbWFmL0dGWTBsMmVXaThYRWtNcytnZTVINFozUlk2eVFLQkpvUEFD?=
 =?utf-8?B?TGVpbVJNdnlsSmtZQ2x0UFkvWVFPTHlOREVob25LbTljVUg5bmIrWHYvbG5z?=
 =?utf-8?B?N3BMcGdhV0tmUGxWYXJwR0o0ZEMrUlFTRlAyM0U5bjY3Y1hNeGo5d2pkZkcz?=
 =?utf-8?B?WHdCUlh4T3F2TU8ydFk2TWxxRGRaWlZFTHZsczZ6WVhkeDJuSzExeW1LbnVl?=
 =?utf-8?B?ZVVLVnFyWHMyckhQT2JrVmYrMUt6bll4bVN0RVBEZ1ZIS0tlVmlXdTRibnY4?=
 =?utf-8?B?TTcxaFFqalMzZnN3a1hXd2NaY1lsT1I2UjNuanRrTC9zVW5DYUxFcnJvaDVU?=
 =?utf-8?B?VThYZldjSlNzbVZPNldoT1lmKy83S0Q0dTVsQzA3b1UzdmdxTWRwOG1YcnBy?=
 =?utf-8?B?ZUhXVGpUQW9kVlUxVCttVEtUQ0dIVFdWSm9VbWF1aUY5WjRVeTUwZERReHRJ?=
 =?utf-8?Q?1xY4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 16:55:17.5465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdd4354-df18-404f-9f7f-08de3355e71d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578



On 12/3/25 1:35 PM, Michael S. Tsirkin wrote:
> On Wed, Dec 03, 2025 at 12:12:46PM -0600, Tanmay Shah wrote:
>> Hello,
>>
>> Thanks for your reviews. Please find the response below.
>>
>> On 11/22/25 6:05 AM, Zhongqiu Han wrote:
>>> On 11/15/2025 2:46 AM, Tanmay Shah wrote:
>>>> From: Xiang Xiao <xiaoxiang781216@gmail.com>
>>>>

[...]

>>
>> Thanks, that's a good question. I keept id 2 unmodified from the original
>> series. I don't know why ID 2 was chosen in the original series. I will have
>> to discuss this with the linux remoteproc/rpmsg maintainers and choose the
>> correct ID.
>>
>> I don't see any problem choosing ID 1, but for some reason if ID 1 was
>> assigned and deprecated (I don't think that is the case) then only we should
>> use ID 2.
>>
>>
>> Arnaud, Mathieu, Bjorn any input here?
>>
>>>> +
>>>> +struct virtio_rpmsg_config {
>>>> +    /* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
>>>> +    __u32 txbuf_size;
>>>> +    __u32 rxbuf_size;
>>>> +    __u32 reserved[14]; /* Reserve for the future use */
>>>
>>> Should we use __virtio32 instead of __u32 to avoid endianness issues?
>>>
>>>
>>
>> Sure, if that is the standard in other virtio headers I will modify it.
>>
>> Thanks,
>> Tanmay
> 
> rpmsg is still not standardized, sadly. It's really time it was.
> 
> 
> 
> Modern virtio devices use __le32.
> Accordingly, accessed with virtio_cread_le
> 
> 
> __virtioXX and virtio_cread are for legacy compatible parts of config space.
> 

As of now, I am using virtio_cread so I think it is legacy compatible.

> 
> Does rpmsg want to be modern or keep using legacy? I donnu.
>

I don't know either. This we have to discuss with the maintainers and 
other vendors.


> Ideally it should finally be documented and at that point we
> definitely will want to switch to __le32.
> 
> 
> For now, run sparse to make sure you don't introduce new endian-ness
> issues.

Ack.

> 
> 



>>>> +    /* Put the customize config here */
>>>> +} __attribute__((packed));
>>>> +
>>>> +#endif /* _LINUX_VIRTIO_RPMSG_H */
>>>
>>>
> 

