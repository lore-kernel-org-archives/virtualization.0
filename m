Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2E33E35B
	for <virtualization@lists.linux.dev>; Wed,  3 Dec 2025 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784856; cv=fail; b=fgWiwQKghiXVwrEB2Cd79kA75qAOT2vNmwH7CR+whvXo4GyEc/fgcoP4tFJvBy48NRj6SDvy/srSSSHeSdflnaSSSp6SgS7xMe78QXyTopjbiopkmgr9TtlcH+T0GLtW/ZYwLQy8NFTabWaKPilbmYIPOmRJ4kdWNKpWY70oD5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784856; c=relaxed/simple;
	bh=ApRbotkrw2lCCkTp8oce4EBJgQCqwoVBXTd+CC2rMdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u1JTiWSpEh13jMLOp6CWvmSJZSQUIWh8SDmlLGB+VAwJcS1/fM/Q+uAgy6gM+yzzdSKKeIJ1xf1XtkJcgHLBv8GGC19cTDCpDAoSiWwrle0CYoORy5Lye9aAp1j9Pbr6gL2ZB4BGpfs+w1lRU6nTW2VhhBnokE0oI5sfC6l1BgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oJ0vSTCG; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oJ0vSTCG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSkkrQsBRbJszhtuQe94GwQGpBgBikUuQdDIj16aTt08pNOe0Yteb0RssiQB2ey0h4K8V9NX2wQdAXEDoKBKC0PXXT9RJjInLH4zVL9OYZiHdoKF1ZpleQoIapdM7UqUx2jrx3DkfcMAzAO+K9ycPx+UAhfbpgsq2qAqTT/pYurNMIZcjOBt0PAJ01imMpHMNnk7l6DZsfemUCztLCXvI+fr+ZwmR9fPwjvd4kWWa50twuRi9ISTcTO2zAoKiSanVaY6hzs0FX715/eEqV9hW0Qph4byRqfydrz62R9nq9fOqTFPxg/gwtnhfZNbrgVK/eZBjBkLf9qU+HysGEP25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsFQedK9Xra58iX1gdsQagsYcGb5eemuXA3GqUjb3kk=;
 b=wQhmnuZpEfDdBpYjhaWFzl7wqzPSnWf5UyHI4sQprPr84VI1RJhXjklZzdIfnuSaLFJhD+0rOIqzOabh/iqZqvSzrfAt83sjnmP2k1IjVDqvrN4wLao8/9Z07qpq7GvQYaGmSJTQaNTEzwxcBsqhHOcTZTbUSPAz67Vsn+7bW3vYxMASwwJXHpyoUj6dqNKCYISqYYITHIecNDelB36rhg7WcnvZ3NEyQx073VjH70oxnZV7CcAyHHcKSUWEE9Y4pJMYbBRpDubQ2q+6FC0HlfVhEyY2FrMqD2B9GTS0WJvC5q5AWY8xWN44FBvFk5u/6+yKSSkCNkT2/nOFTSkmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=foss.st.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsFQedK9Xra58iX1gdsQagsYcGb5eemuXA3GqUjb3kk=;
 b=oJ0vSTCG2wxODusvLOIClBX3q17B1A5azmLNjWpGrgv4gXS29sKMJuFhFXUfZzng8lZPKlKZjj8wC+RPxAM3fKNtnBY+tXcWKkJ3R/uZJ9gyRIPh2ghGGSjREFGoofnB9IMmrCyc3LYDqHdK56q/u3YGBS54Rg/jUOMWK+TreVA=
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 18:00:44 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::33) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Wed,
 3 Dec 2025 18:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 18:00:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 12:00:42 -0600
Received: from [172.31.132.204] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Dec 2025 10:00:42 -0800
Message-ID: <65e5ba1e-c846-469a-a6e0-b63441da8cfa@amd.com>
Date: Wed, 3 Dec 2025 12:00:41 -0600
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
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>, <andersson@kernel.org>,
	<mathieu.poirier@linaro.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>, Xiang Xiao
	<xiaoxiang781216@gmail.com>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-3-tanmay.shah@amd.com>
 <0a2b9fe6-d8b2-42d6-b6b3-9a94a82c6738@foss.st.com>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <0a2b9fe6-d8b2-42d6-b6b3-9a94a82c6738@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1e35ad-a653-47a1-3856-08de3295e0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUlSemd5WDJ2czErWnpzL2ZYZElSRE5xREIveFF6L0ltSS8rMjI1U0hIZGFX?=
 =?utf-8?B?UWMrWFlpT01aUVhGS3RlMlpZZmhyYWR1ZjBnTUk0cFNic3lzd0g2cm1sUTVk?=
 =?utf-8?B?bGtyOE1RVGF2V3lEVHJQTlM5SEtqekVpSUE3THhEanZ3SmZGUklMSGgrV2Nj?=
 =?utf-8?B?Nk9lNHMwWGY1M1U3eXo0TlgydDMyTkVYWFdKZ0wxRTVSeE5sNko1dU5Gc0cy?=
 =?utf-8?B?S3hjYWRRK0p6UlVTMVNsZ0NrbU54Yy8rb3FxS3BIWjFxTkxVTWtaTzA3cGJ6?=
 =?utf-8?B?b0pQYUROQWRYeVNtVGh0TzFXc3ppaUdNY29XN0pnK2YyaENXdUJvUnVhcGV4?=
 =?utf-8?B?bmxJdkJPNDFYMWJTZWt4SGh6aDNpYzYrM0lER0xoc01PS1RRdTlodGtIR0d1?=
 =?utf-8?B?eGhrdUZpZnNxYktsdnJ5aS8wdS9idVpxUEhJU2svTG1SYlM5eHBVQXNheXZT?=
 =?utf-8?B?YTVYNFhnS2FhbFNMSnQvQkFsODRpbjkxVU1WZEh3REtSc2RYcXphNDJTOHMr?=
 =?utf-8?B?VUl2MlU3R1NyekZDTWRPanU4RFNxNGN4dytETWkvclNqN21Mc3JHNUtyb3l1?=
 =?utf-8?B?SU1ZcFVUckZnV3ZRTVVpM3cxMC9OZlNQYmFrTmVCR1ppTHNWMzBBbVgydFJ4?=
 =?utf-8?B?YitDNkRXZWxScGRZUkx0R1hQdERtRmg5Nkk2N3VzcXVWVGhPRGc0d0NORlQ2?=
 =?utf-8?B?MUtWWXQ2bHE5WVNhWHhPcHhMSmdybUZFSUJKM3czU3NWcXVycHhycTlUR1lM?=
 =?utf-8?B?SUs1VzVmZmVmUndPanBqc0pYRy9RK1B0MFhDOUJaN2tzNm9EbGtNY1FnUWtq?=
 =?utf-8?B?TWdoY1hremJNclBER0JUcXVqdTY4eGNaTkQyQytjUTZ6c09kQTlvMTM3WEQw?=
 =?utf-8?B?QW0rcS9xblJaSFlWSEwySUdlOVFMNHNCdjJBT1JWckJoRFdBek9wZWpzZXRP?=
 =?utf-8?B?b2VZaXg5VHo1VWZzVy9pRTA3bERFSDlXdTlOcFI5UWtrcVlOMWl4QWlNbzN0?=
 =?utf-8?B?OEpINXVNR1BnektHYjZLVTRjM2JjenFoZWxjTW1HWGExUWJEMEFSbEE3WXJK?=
 =?utf-8?B?bjFVWmNUeXRZQmxDcVJua2VvUWcrVmZHdjVGejdJYWxtM0o2WWZ2Unl6V3hQ?=
 =?utf-8?B?bzlvUXlxK3ZCVjk3ZzlXNkxoblhlVkZpMlg4TG9FMjJtWnViWldiYzBCcWhv?=
 =?utf-8?B?N0d2Yk9yTHRmZnJwLy9LSUlRaG5KS1Q4K3VBUHBSdkJIWGF3RGZ4cldKU2tp?=
 =?utf-8?B?ZjJlZnN4bFgwUHAyMFpqbnlTN2g0VzdqWWZNTjB5cWU2OERpbkdYaFpiSFYr?=
 =?utf-8?B?UGpwZFVOb3NvYnZaT21YeWUvSGZRKzlqQllzZExJYXlRN0p3YnoybkhNcU1o?=
 =?utf-8?B?MGRnVkdvdVRiL1VRSnk2dFJ6WHhOU1pocXA1RUV5RWhlMUdkdzhuN05oaGI0?=
 =?utf-8?B?NWRvMjNjVHJEbDZFcTRXVjVvUktaL1d6QVQ5OEhiT3VGRkYvNmQ3TUM2VTNt?=
 =?utf-8?B?cnQrbjEwL09kU2tmemVtL1ExMWlZR0NOOFl3L2NmcStMZFJNZWlpT1BJNmJC?=
 =?utf-8?B?bFVQTHJqQXMxWWRwdEdBS2VMNFU2eUVBbjUvZm4zQTNLVDdBSjcyL2RZb3pO?=
 =?utf-8?B?U3JkUmRraHJDUllGaHR6N21yMVN6UUVvQ1NQeEhINHlFWVY4b0ZRY0UycXRi?=
 =?utf-8?B?cVh4a0w1TDNpRDhDcnY5Tzlyc01wTFJIclRReVVHVzdFNUdrWC9TUkJPbW11?=
 =?utf-8?B?aGE0SnlwRkgzRXFnaWlnQWVvTEdqTFJ6d3JRYTdaM1NhMndIQWFYYzYyYXZB?=
 =?utf-8?B?ZDlDc2ZmaGRhUGM0MjNscWU2aTBWYlcwT29HUzR2ZHFnZzRzR3RvRkNXdmp4?=
 =?utf-8?B?Y0d0MUJPcEFnR0IweHErTW56aC9rSVROR2xoSGowa2c5a1JCb3lhc1ovT0dP?=
 =?utf-8?B?ZnhhOUVMbWhhWkdETUc1c2syMjRLTDdMRmsxSzJ1R2dXOXNXS1M1TXRSRm02?=
 =?utf-8?B?cHVLUklZbHJzTXFabTVmRE52dzcwMm1XUTMyV1JYanJ2VElua29zeFJkdHRO?=
 =?utf-8?B?Tytxa0d2MUNadEYyemlJMDFaTUprOHorZkIrSk42Y1VoNkphV1JUU1Bzalp5?=
 =?utf-8?Q?ZnP0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 18:00:43.5235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1e35ad-a653-47a1-3856-08de3295e0c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862



On 11/21/25 3:44 AM, Arnaud POULIQUEN wrote:
> 
> 
> On 11/14/25 19:46, Tanmay Shah wrote:
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
> 
> typo:  /* The buffers must hold at least the rpmsg header */

Ack.

>> +        if (vrp->rbuf_size < sizeof(struct rpmsg_hdr) ||
>> +            vrp->sbuf_size < sizeof(struct rpmsg_hdr)) {
>> +            dev_err(&vdev->dev,
>> +                "vdev config: rx buf sz = %d, tx buf sz = %d\n",
> 
> message could be more explicit: s/"vdev config:/"bad vdev config:/
> 

Ack.

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
> 
> Needed? The allocator does not manage the page alignment?
> 

Ack.

Not needed. Now as you pointed, I think it's better to leave the 
alignment to the allocator. This will be fixed.

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
> This licensing seems reserved for the UAPIs
> 

Ack. I will check other headers in the same directory and update license 
accordingly.

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
>> +
>> +struct virtio_rpmsg_config {
>> +    /* The tx/rx individual buffer size(if VIRTIO_RPMSG_F_BUFSZ) */
>> +    __u32 txbuf_size;
>> +    __u32 rxbuf_size;
>> +    __u32 reserved[14]; /* Reserve for the future use */
>> +    /* Put the customize config here */
>> +} __attribute__((packed));
> 
> I am still convinced that adding a version field would help with future
> improvements, even though a feature bit field can be used to handle new
> configurations. Indeed, how can we address the need for more space
> beyond the 14 reserved words?
> Thanks,
> Arnaud
> 

Ack.
Okay, it's not a deal breaker for me. I will add the version field linux 
side. I will add new structure in open-amp side as well accordingly.

>> +
>> +#endif /* _LINUX_VIRTIO_RPMSG_H */
> 

