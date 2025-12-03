Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012014.outbound.protection.outlook.com [40.107.200.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97F301460
	for <virtualization@lists.linux.dev>; Wed,  3 Dec 2025 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764785585; cv=fail; b=tAX5CweglCy0jxwtHoZN8DIX1moF2WWS3fr7Va7lYYyXXzcS8SpV5zyklJHLLJqM3OCTLX7HcZ4yI4sTPebIeN9JaTb1drGjdsb0wACmLROiA1BoSFsN/ZwGo9PbhuD8Srlmmhg4FmgQFBPZXv7Igo6xcCOXmyMZg2hCcrz7OCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764785585; c=relaxed/simple;
	bh=ycafD8orlE8SR7cxLwJx830hXCxg7x9hvo/s0xesiNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fn2EnjdDsVuXOFrpm8uADY4VGA1eK0PLa4euzZfesThovGShtDCJzT4/e4dy+PyVc+YXReu3MEQHZkfuG5njWcvDDYYnDoqZcXlHpat0CeKHACfGFAYpl3SiviZ7FrEx8z69zMNs7YQiJ62tw+z96AELEwCkTrTw1Mr5RFhdGhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KO5SH1Nq; arc=fail smtp.client-ip=40.107.200.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KO5SH1Nq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqMYa2LgcTt2DEFzTPDPCmphLwTJwR1jBmNioMeOD+v9h3uMZ4UwAeBOXTXciYRuRvglya0XXysxzdK7Vmtal//Jx0B+eqCEeK3Tw/cVJaAVPEfauUTk1w2dKUINpcZwGNGIhVMzuIAmXnuFg2AbOTm3SrN0p7qdZ3pNEaqKi2zlOeyKH3SBVUozbQ/pB91Q2lZ5wiQ/d0oAJX0rvI5DtUkfTJe9AoSyxH8pYSXKeLACEz58YVr6eh9BLwvJgVwbv437AlAA4VCAQx+oLhjWFC9HyFAOI/NERVavyyL2S/KFJDVY0eyt5X/zIbYxHnQryED/vLfreGsbCjNSLu5ZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQIddkI8a9nByBo7WLCbu8JtIk+1yKtl/qri92PRXNc=;
 b=cl2p/Txga9N0e3oJc1Y8vzOP/0/pom4ktIObYQthJVOqbYBCIGMDmTdOZ3yKsBA38MzeUoL2A1734Ob5VcWy7VfxLIo7GvpIy4LhybWJFfDNTUFyoOywcu+4yy/1koV/NGAZVxocEkeUwlRcoYcAlOC8RB30N4DV2/il0EZCD2x3gDvQJA8uNbij+snAPyhwKHw4polp/+kM/E+7m5FSqOmEK0GzFK2woQgtfm+ZS7DYtWQOYOtknZD/mF4liXRPsAVWaVpuFBIpCZ9gS1llin7FIHBX1EO1F0U/iK4DAwO19vdbPrN8aJTaFAGb1L8cFXQWInnSdhFCxOH8nnu7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQIddkI8a9nByBo7WLCbu8JtIk+1yKtl/qri92PRXNc=;
 b=KO5SH1NqNlPjYHSp1g2WWYMLxWUv/ESYSgkx6BSBAh6IjMO7YHnpBo1Ol0x4KWyMlnMKIdsbRcxDOoD2tRQmAGWB/ZEM9nUF3GXo/XTrDUG/iSZgC071w/29Bx/TFgkrDRfV3CNNoYJTPFnQ6/jVmaK0e1EBvG+nGTa7i4K/LiI=
Received: from SJ0PR03CA0377.namprd03.prod.outlook.com (2603:10b6:a03:3a1::22)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 18:12:56 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ec) by SJ0PR03CA0377.outlook.office365.com
 (2603:10b6:a03:3a1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Wed,
 3 Dec 2025 18:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 18:12:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 3 Dec
 2025 12:12:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Dec
 2025 12:12:52 -0600
Received: from [172.31.132.204] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Dec 2025 10:12:51 -0800
Message-ID: <c5395ebf-b0ea-4be8-b0c0-6a51d4c98e09@amd.com>
Date: Wed, 3 Dec 2025 12:12:46 -0600
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
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, <andersson@kernel.org>,
	<mathieu.poirier@linaro.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>, Xiang Xiao
	<xiaoxiang781216@gmail.com>, <arnaud.pouliquen@foss.st.com>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-3-tanmay.shah@amd.com>
 <11280877-95f0-4361-9112-23bb17372e91@oss.qualcomm.com>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <11280877-95f0-4361-9112-23bb17372e91@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 42805fae-d6db-4ab5-9534-08de3297953b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTlDelBvRXR4REt2Qy9LYmM0TzZkWmxOeEk0NmZsa0U4a3lyVTZpZFo2ZTZ1?=
 =?utf-8?B?U3NSeGpkODQ3ZTY5MDIyVlQrWDNjNlgva1Q1MHo4NnphVFJWU0YvNU5ZaWJt?=
 =?utf-8?B?c0ZOQ21TVS9rclV1SzBBbjMwaHZjZDJ4UXFOK1FVMnBsWjdQUHIzcUpYRXlL?=
 =?utf-8?B?dzJGN2l6THBYTkFlcXlPb1ZXeGNTK2FSeXNZLzNKUjBPQms3azBDLzUzQzJB?=
 =?utf-8?B?S2I5MlFrdHZKcDc2MW84RDlUVk9nS3VaS0dTYUE3QmVwK3FvRXEveURRUno1?=
 =?utf-8?B?VkdJVXN3NCtRVzUvMmpKQjNob2doZGJybXFlRWRlbkpqeFprV1g4dlExeXIx?=
 =?utf-8?B?dGtVUEF5TVZZNWkzZmhBL2h6bDU1YVRPZytWa2QxUEdiV3pqaytpNTZmQVdQ?=
 =?utf-8?B?b3htNS9KSUdKbWZzQzlQK3g3Rk11R3I3bW9Tam9TZUptN2lFVHEyaTZlWklx?=
 =?utf-8?B?VkdXWjFFcVo2alpqcUdJTEpOSVhTWkhuTTMxSjgxWGRlaWI2TXpnbGZ6alJx?=
 =?utf-8?B?QTVLZnREVTFqQlJtWTJ1R1VzK3QyYUliY0txZnkxY0xIdzhDQ0NUdVRwb3kr?=
 =?utf-8?B?TjhOM2Q5T1A4SFJqNy8weWMvcFU4YU02Q3ZKQ04yTWNSeVBJM0ZFT3pBQ0da?=
 =?utf-8?B?WWwzcEY4NXZOR0RPMTZKSGZyRzB5WFo0TENHbk9IWkJXanUzNStDSE1nTTVI?=
 =?utf-8?B?Y2tuSElPelF3RlQ4aWZKd2U1MXZaR2RRMXcyVWJCZFZWM0FCbjdDbU5GRnU0?=
 =?utf-8?B?NjAvL3BJSjAxaGhxUDhnTVY0aEc0VnNMY1Z4STlvV0N3TjJCRFdQa0hKZWRW?=
 =?utf-8?B?aGdYVlN4ZDBEUmdSQmd3U1lXYUtETTZNNmNwcjJIeWttbDMrM1JERXltTmN1?=
 =?utf-8?B?ZUhSbmlEZFA5bjhtUFhHV3RCZ1ZGQUpsdmttc21rSzBodHhIM3ZwVjVMNVdq?=
 =?utf-8?B?TnFGazRmaTR1T0tZNml2dXJWRm1ZTXhvTXZreTJJdi9xQ2JQN1BqVmlZa1hK?=
 =?utf-8?B?bm1pVmhmRE9xaDAwcnpKK2NRYXpYNjFGcTQ2SjdiUFZPWXo2RGd2L3U2bDlD?=
 =?utf-8?B?Nks0RUhGT2pZaUJzWWVUbFBsZjM4cFJPNGN0NVM3WWhjT1NubllJbTd0RGVK?=
 =?utf-8?B?MWxxSWpseDN3THRJd3hsZlJ2R3ZKNjBhVVBwQU5tUHd0WTJTNzlQbUs3TjRl?=
 =?utf-8?B?eFY3ODJoZGZUUEpKS05ybU9XTTZiTGI1NzcvRFY5YkFzT3pXY1lvZDV5YVZ1?=
 =?utf-8?B?NUlHMHQzRm9kZlZXSTFuZU1TeUJtMFg4ZGZEVWpiNDE5ZGt4dXF1dWpoM2ZQ?=
 =?utf-8?B?Y3lQOEFwU1pESStIQ296Z3ZTUTI4dUh5NStkaVJ5ZW5GbzBDKzR5dkJDVWNj?=
 =?utf-8?B?OFVJci9mYzZJeTJra0pFeWxpQWVHVTBjTlVObG5OMXFPTGN6dUdoYWF0eDU4?=
 =?utf-8?B?QmZjM2VPMlRIeTd3M0VDKzBoRE9NS2xLYndlMjRINHJBa2MyZit0c3BlV09E?=
 =?utf-8?B?OFE1S1NnMDVzb1JQYkpuMHNxeG95K2hXMTBPdmg1VGpyaU8wbDNCcTRKSEpI?=
 =?utf-8?B?OU8xWkJQSTZvc2syR2ZVbFpxekhCeGpaV0RHLy9FREV1QzRmWUJMbkVBRFlz?=
 =?utf-8?B?MW8zQ09LcnRKYzloaG1OZW02bjQxWW5QSm54OVJTdnYwaHRyNkVtb0E2eWtC?=
 =?utf-8?B?VUEvZ0tsbWx2UEJlUFZTK3lMcndPU1VveExmRWVlaWwwcWFXcXRwUlNPdFN4?=
 =?utf-8?B?M3NQMTFyL0EzZEkyUHFPRlR5Wm9Sa1R4RnlVMmVaMjFtNU1KNDR5S3NpUlFa?=
 =?utf-8?B?NUlmbjZteVVzSERtM0g5MThrTXpNN1YxYjVTZVdwQ2xMR0d2U2d1VW1IS0E1?=
 =?utf-8?B?VllmeEREMDB1ZEdWSno3QTlzRFJIQzdWeVNhRmFXVHJDL3NNKzBVMDhxaEV5?=
 =?utf-8?B?eE1kVzl1dHFtVWpQS29vdVBWaExkdGtDa0JhamJ1YnlYMmp2YnR4bHcyZ2NR?=
 =?utf-8?B?TS81TWplL2FoclBidUNzSjRyYmhYUE8rb2p5dEs4M3FkakkzVjZZaVNCRFp4?=
 =?utf-8?B?VkhsV2d2cER5cXFMZjNHRUhpQ1J1TGNyOEZyTzBSWDJoWTVFd0N1ZXhhZVhC?=
 =?utf-8?Q?YrMc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 18:12:55.7019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42805fae-d6db-4ab5-9534-08de3297953b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555

Hello,

Thanks for your reviews. Please find the response below.

On 11/22/25 6:05 AM, Zhongqiu Han wrote:
> On 11/15/2025 2:46 AM, Tanmay Shah wrote:
>> From: Xiang Xiao <xiaoxiang781216@gmail.com>
>>
>> 512 bytes isn't always suitable for all case, let firmware
>> maker decide the best value from resource table.
>> enable by VIRTIO_RPMSG_F_BUFSZ feature bit.
>>
>> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>   drivers/rpmsg/virtio_rpmsg_bus.c | 68 +++++++++++++++++++++++---------
>>   include/linux/virtio_rpmsg.h     | 24 +++++++++++
>>   2 files changed, 74 insertions(+), 18 deletions(-)
>>   create mode 100644 include/linux/virtio_rpmsg.h
>>
>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/ 
>> virtio_rpmsg_bus.c
>> index cc26dfcc3e29..03dd5535880a 100644
>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/sched.h>
>>   #include <linux/virtio.h>
>>   #include <linux/virtio_ids.h>
>> +#include <linux/virtio_rpmsg.h>
>>   #include <linux/virtio_config.h>
>>   #include <linux/wait.h>
>> @@ -39,7 +40,8 @@
>>    * @sbufs:    kernel address of tx buffers
>>    * @num_rbufs:    total number of buffers for rx
>>    * @num_sbufs:    total number of buffers for tx
>> - * @buf_size:    size of one rx or tx buffer
>> + * @rbuf_size:    size of one rx buffer
>> + * @sbuf_size:    size of one tx buffer
>>    * @last_sbuf:    index of last tx buffer used
>>    * @bufs_dma:    dma base addr of the buffers
>>    * @tx_lock:    protects svq, sbufs and sleepers, to allow 
>> concurrent senders.
>> @@ -60,7 +62,8 @@ struct virtproc_info {
>>       void *rbufs, *sbufs;
>>       unsigned int num_rbufs;
>>       unsigned int num_sbufs;
>> -    unsigned int buf_size;
>> +    unsigned int rbuf_size;
>> +    unsigned int sbuf_size;
>>       int last_sbuf;
>>       dma_addr_t bufs_dma;
>>       struct mutex tx_lock;
>> @@ -70,9 +73,6 @@ struct virtproc_info {
>>       atomic_t sleepers;
>>   };
>> -/* The feature bitmap for virtio rpmsg */
>> -#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service 
>> notifications */
>> -
>>   /**
>>    * struct rpmsg_hdr - common header for all rpmsg messages
>>    * @src: source address
>> @@ -130,7 +130,7 @@ struct virtio_rpmsg_channel {
>>    * processor.
>>    */
>>   #define MAX_RPMSG_NUM_BUFS    (256)
>> -#define MAX_RPMSG_BUF_SIZE    (512)
>> +#define DEFAULT_RPMSG_BUF_SIZE    (512)
>>   /*
>>    * Local addresses are dynamically allocated on-demand.
>> @@ -443,7 +443,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
>>       /* either pick the next unused tx buffer */
>>       if (vrp->last_sbuf < vrp->num_sbufs)
>> -        ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
>> +        ret = vrp->sbufs + vrp->sbuf_size * vrp->last_sbuf++;
>>       /* or recycle a used one */
>>       else
>>           ret = virtqueue_get_buf(vrp->svq, &len);
>> @@ -569,7 +569,7 @@ static int rpmsg_send_offchannel_raw(struct 
>> rpmsg_device *rpdev,
>>        * messaging), or to improve the buffer allocator, to support
>>        * variable-length buffer sizes.
>>        */
>> -    if (len > vrp->buf_size - sizeof(struct rpmsg_hdr)) {
>> +    if (len > vrp->sbuf_size - sizeof(struct rpmsg_hdr)) {
>>           dev_err(dev, "message is too big (%d)\n", len);
>>           return -EMSGSIZE;
>>       }
>> @@ -680,7 +680,7 @@ static ssize_t virtio_rpmsg_get_mtu(struct 
>> rpmsg_endpoint *ept)
>>       struct rpmsg_device *rpdev = ept->rpdev;
>>       struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>> -    return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
>> +    return vch->vrp->sbuf_size - sizeof(struct rpmsg_hdr);
>>   }
>>   static int rpmsg_recv_single(struct virtproc_info *vrp, struct 
>> device *dev,
>> @@ -706,7 +706,7 @@ static int rpmsg_recv_single(struct virtproc_info 
>> *vrp, struct device *dev,
>>        * We currently use fixed-sized buffers, so trivially sanitize
>>        * the reported payload length.
>>        */
>> -    if (len > vrp->buf_size ||
>> +    if (len > vrp->rbuf_size ||
>>           msg_len > (len - sizeof(struct rpmsg_hdr))) {
>>           dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg_len);
>>           return -EINVAL;
>> @@ -739,7 +739,7 @@ static int rpmsg_recv_single(struct virtproc_info 
>> *vrp, struct device *dev,
>>           dev_warn_ratelimited(dev, "msg received with no recipient\n");
>>       /* publish the real size of the buffer */
>> -    rpmsg_sg_init(&sg, msg, vrp->buf_size);
>> +    rpmsg_sg_init(&sg, msg, vrp->rbuf_size);
>>       /* add the buffer back to the remote processor's virtqueue */
>>       err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, msg, GFP_KERNEL);
>> @@ -888,9 +888,39 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>       else
>>           vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
>> -    vrp->buf_size = MAX_RPMSG_BUF_SIZE;
>> +    /*
>> +     * If VIRTIO_RPMSG_F_BUFSZ feature is supported, then configure buf
>> +     * size from virtio device config space from the resource table.
>> +     * If the feature is not supported, then assign default buf size.
>> +     */
>> +    if (virtio_has_feature(vdev, VIRTIO_RPMSG_F_BUFSZ)) {
>> +        /* note: virtio_rpmsg_config is defined from remote view */
>> +        virtio_cread(vdev, struct virtio_rpmsg_config,
>> +                 txbuf_size, &vrp->rbuf_size);
>> +        virtio_cread(vdev, struct virtio_rpmsg_config,
>> +                 rxbuf_size, &vrp->sbuf_size);
>> +
>> +        /* The buffers must hold rpmsg header atleast */
>> +        if (vrp->rbuf_size < sizeof(struct rpmsg_hdr) ||
>> +            vrp->sbuf_size < sizeof(struct rpmsg_hdr)) {
> 
> 
> Hello Tanmay,
> 
> May I know if the omission of = here is to accommodate the ping/pong/ack
> scenarios? mtu will 0
> 
> 

Yes. At minimum RPMsg header is needed to ping the correct endpoint. We 
don't need to have any payload attached to the packet. MTU will be 
sizeof rpmsg_hdr I think.

>> +            dev_err(&vdev->dev,
>> +                "vdev config: rx buf sz = %d, tx buf sz = %d\n",
>> +                vrp->rbuf_size, vrp->sbuf_size);
>> +            err = -EINVAL;
>> +            goto vqs_del;
>> +        }
>> +
>> +        dev_dbg(&vdev->dev,
>> +            "vdev config: rx buf sz = 0x%x, tx buf sz = 0x%x\n",
>> +            vrp->rbuf_size, vrp->sbuf_size);
>> +    } else {
>> +        vrp->rbuf_size = DEFAULT_RPMSG_BUF_SIZE;
>> +        vrp->sbuf_size = DEFAULT_RPMSG_BUF_SIZE;
>> +    }
>> -    total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
>> +    total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
>> +              (vrp->num_sbufs * vrp->sbuf_size);
>> +    total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
>>       /* allocate coherent memory for the buffers */
>>       bufs_va = dma_alloc_coherent(vdev->dev.parent,
>> @@ -908,14 +938,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>       vrp->rbufs = bufs_va;
>>       /* and second part is dedicated for TX */
>> -    vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
>> +    vrp->sbufs = bufs_va + (vrp->num_rbufs * vrp->rbuf_size);
>>       /* set up the receive buffers */
>>       for (i = 0; i < vrp->num_rbufs; i++) {
>>           struct scatterlist sg;
>> -        void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
>> +        void *cpu_addr = vrp->rbufs + i * vrp->rbuf_size;
>> -        rpmsg_sg_init(&sg, cpu_addr, vrp->buf_size);
>> +        rpmsg_sg_init(&sg, cpu_addr, vrp->rbuf_size);
>>           err = virtqueue_add_inbuf(vrp->rvq, &sg, 1, cpu_addr,
>>                         GFP_KERNEL);
>> @@ -1001,8 +1031,8 @@ static int rpmsg_remove_device(struct device 
>> *dev, void *data)
>>   static void rpmsg_remove(struct virtio_device *vdev)
>>   {
>>       struct virtproc_info *vrp = vdev->priv;
>> -    unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
>> -    size_t total_buf_space = num_bufs * vrp->buf_size;
>> +    size_t total_buf_space = (vrp->num_rbufs * vrp->rbuf_size) +
>> +                 (vrp->num_sbufs * vrp->sbuf_size);
>>       int ret;
>>       virtio_reset_device(vdev);
>> @@ -1015,6 +1045,7 @@ static void rpmsg_remove(struct virtio_device 
>> *vdev)
>>       vdev->config->del_vqs(vrp->vdev);
>> +    total_buf_space = ALIGN(total_buf_space, PAGE_SIZE);
>>       dma_free_coherent(vdev->dev.parent, total_buf_space,
>>                 vrp->rbufs, vrp->bufs_dma);
>> @@ -1028,6 +1059,7 @@ static struct virtio_device_id id_table[] = {
>>   static unsigned int features[] = {
>>       VIRTIO_RPMSG_F_NS,
>> +    VIRTIO_RPMSG_F_BUFSZ,
>>   };
>>   static struct virtio_driver virtio_ipc_driver = {
>> diff --git a/include/linux/virtio_rpmsg.h b/include/linux/virtio_rpmsg.h
>> new file mode 100644
>> index 000000000000..6406bc505383
>> --- /dev/null
>> +++ b/include/linux/virtio_rpmsg.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> 
> 
> Echo Arnaud's comments. If it is intended for UAPI, please keep it in
> include/uapi/linux
> 
> 

It's not intended for UAPI. I need to fix the license. I will check 
other virtio headers in the same directory and fix the license accordingly.

>> +/*
>> + * Copyright (C) Pinecone Inc. 2019
>> + * Copyright (C) Xiang Xiao <xiaoxiang@pinecone.net>
>> + */
>> +
>> +#ifndef _LINUX_VIRTIO_RPMSG_H
>> +#define _LINUX_VIRTIO_RPMSG_H
>> +
>> +#include <linux/types.h>
>> +
>> +/* The feature bitmap for virtio rpmsg */
>> +#define VIRTIO_RPMSG_F_NS    0 /* RP supports name service 
>> notifications */
>> +#define VIRTIO_RPMSG_F_BUFSZ    2 /* RP get buffer size from config 
>> space */
> 
> May I know why skip bit 1?
> 
> 

Thanks, that's a good question. I keept id 2 unmodified from the 
original series. I don't know why ID 2 was chosen in the original 
series. I will have to discuss this with the linux remoteproc/rpmsg 
maintainers and choose the correct ID.

I don't see any problem choosing ID 1, but for some reason if ID 1 was 
assigned and deprecated (I don't think that is the case) then only we 
should use ID 2.


Arnaud, Mathieu, Bjorn any input here?

>> +
>> +struct virtio_rpmsg_config {
>> +    /* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
>> +    __u32 txbuf_size;
>> +    __u32 rxbuf_size;
>> +    __u32 reserved[14]; /* Reserve for the future use */
> 
> Should we use __virtio32 instead of __u32 to avoid endianness issues?
> 
> 

Sure, if that is the standard in other virtio headers I will modify it.

Thanks,
Tanmay

>> +    /* Put the customize config here */
>> +} __attribute__((packed));
>> +
>> +#endif /* _LINUX_VIRTIO_RPMSG_H */
> 
> 

