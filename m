Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90A346FA9
	for <virtualization@lists.linux.dev>; Wed,  3 Dec 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783514; cv=fail; b=EsY55bVzWViM8vhFFXONb9JBILhD90Bmj25cJ5sbjoAqeD22p2MqsKYAbRuiyKXCmA9InQtM8ATK75K1mkKn6kdf4lvKwKhDF0EQtsqtS5VMSeXc1Svm7cdRAZ4hl29kGmIKoqlDMDI1/Ug9A7N8PrSx90MY0h0Dem42GUyPp4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783514; c=relaxed/simple;
	bh=xiiHhfKwkdLbHOgkPWsGwux4jjz3/KwqUAjG+1RGoMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AnycXJkxwwOtmY1JRFKL2vL2Cu3nmSPDFBlNP+osFyCtbw5dpuratJlklcmQF+JhhTXiBsNgZew+Rpj+yur0PO9Tc05ZEk6b6ehRqtGy9WGHryVnbsM0DIVkv2kSBtStmtJFzsxQDFLRPNgNza/iFa8zeqBPxusBwcephhV54dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZqiNF9bW; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZqiNF9bW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1heBngkkrxYVAeNDn81LUSaJTPG7kAt+VEhLXiBM3KCFDMkhMHS7lGpVDrNo9QF6Qg+mgflzaIuv8efKFKVMW7Q0rD6L71GjzSbi4gbP65DR+nbPlZhsjl8paKXQrUSq4QCY+P0SKWx0aUTIiAvwF3jF1NJFqClzl0fbUoLnmJAOs0e3DDpfTSz8DH3MLJobXQu5ETDZByIQIdFk2JqXHqywoVy427P+/J8XObsEnJV5BdkaEpjyE7UY1W30nvj+9dxAyiaNYpPBl6D5xMi59pSHkYesbdBc5SmZWrzzIzc11NKtu/0RTzAX0m9g8VY4wAnhbB++hrsoarfwjXZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+QrQdCVMBMr7mG3F9HcBLuB/gpL3cpGT4r6i1TmIPI=;
 b=k97hvJRCE1V8jHLDNlbdNZb/yxjPMMdMaA9RpOaWkTuDOFXVTYxQAif8OAyLdho/v1ZpzLSm639jQf1EAE0jayyAaC/22Vo8KZgiwBHIZmBg53mTyoLp4zk91dp1SyuFHdqR7KYYdJ4blDaTC+1DDVktEoTQeahEJk6SruVwA5rROkNZouorhzYhsyYMKPNp3jaNDRQceh7qZfOsZR3txRjsnH4ffC1EjsZILjMkDs973O547ewWhXIC3J1nF7nI5kmCo+zyUI6fxDOYW6+SKPpMPoM96OMxgK9E0ENCD5bL4DHQ+6bNnWgmT5hFbdaRvcKS48Su2Ix0oi8oqPESCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=foss.st.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+QrQdCVMBMr7mG3F9HcBLuB/gpL3cpGT4r6i1TmIPI=;
 b=ZqiNF9bWOBBoWxX3ZUFJHvI0ExV3l9IBqiuQxIXEYYHm4X8vxYpM5LYrQg/rEZR1GVryPaXgM6rYKRFppq8olvcbmqmJaTfoD8PJio3tedWXofcQ4rY9TWI0t4MIbn3p9mlMm8LFQ1gCOHEq/4hsiy90MoNXoXGGAi7FjtNphIQ=
Received: from SJ0PR13CA0210.namprd13.prod.outlook.com (2603:10b6:a03:2c3::35)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 17:38:26 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::9f) by SJ0PR13CA0210.outlook.office365.com
 (2603:10b6:a03:2c3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Wed, 3
 Dec 2025 17:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 17:38:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 3 Dec
 2025 11:38:22 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Dec
 2025 11:38:22 -0600
Received: from [172.31.132.204] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Dec 2025 09:38:21 -0800
Message-ID: <8ce68f59-2181-452c-8bfd-7cb79b9aac06@amd.com>
Date: Wed, 3 Dec 2025 11:38:21 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <tanmay.shah@amd.com>
Subject: Re: [RFC PATCH 1/2] rpmsg: virtio_rpmsg_bus: allow the different
 vring size for send/recv
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>, <andersson@kernel.org>,
	<mathieu.poirier@linaro.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <xiaoxiang@xiaomi.com>, Xiang Xiao
	<xiaoxiang781216@gmail.com>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
 <20251114184640.3020427-2-tanmay.shah@amd.com>
 <d1f07248-194b-429c-aceb-9d586aad934b@foss.st.com>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <d1f07248-194b-429c-aceb-9d586aad934b@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3744bc53-3411-48aa-be5a-08de3292c1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2U0b04rWWp4K0lnUVJvZGtWanVTb09UMVg5ZWlZQlcvZHJoRlpGVFB6aFRz?=
 =?utf-8?B?bHBUZ0hheG9lQ01IVXIycjdXSExSOC9Rb05VVkhrZVAycWtFU2kvdjNMRWlI?=
 =?utf-8?B?dDIvQTVIemJZZXJhdy9zQ3pBTnJKK2R3aEUwKy9Rdy9kMm0yVWtIM2NHQzZi?=
 =?utf-8?B?d2VOREphMFRqZU5lU2hRcEtOeUZrcjNiTC9DcE1BRzlFRzFZckJxbW0rbk43?=
 =?utf-8?B?dE9HbUZxN2V4RytJUzJ4V1g3VWVFU0hDTGpsSC9zVjZiYjdPZXFRaHBXSGRk?=
 =?utf-8?B?TnlLbHN2blhQNDNjNjRrbWsyYjAwQWFRMmhEZG9vT2xvOHBjeEpwNnRGcXdJ?=
 =?utf-8?B?d3V2OUdNODVOc0UvTUw1bFlaL1MrMnVrakJaUjIrMm1nVTlJTDJ1MGxFN0Qr?=
 =?utf-8?B?R3ZLdldMb0xZVFRaM21WM1EyQXo5V0lXZ2RsNVBoOEYzQVR4WHlJakM1Z2xT?=
 =?utf-8?B?ZlZvdGZpL1Q5S0N4bGNyQ1p3VCs2MG5IMWRRc0JYR0V0MEt3V291K0pTdFA1?=
 =?utf-8?B?WXVjbDQzVVR4NzBzT2Y3cGw5Q3VZdnFtdXJpQ2U2UVpma2ZNU1JkRCtxZG1l?=
 =?utf-8?B?d1RtVDB3QUZMRjVNN0twaC9Pb3M1U2I0L0NHUU52OEdKTnVTRWU3aEtzcDlp?=
 =?utf-8?B?Q1YrWndFYm01MnhRWk5Say9YWGFjUURuM2tTaTNYbGdxM28wc0VpV3NraU1j?=
 =?utf-8?B?OU5neStVU1lIRnQvS0l2L1VudFhzNjBBOWMzU1ZFenM0MUNQRDhYb1pYSWNi?=
 =?utf-8?B?Z01Fa1hQYXFFTE5DTGxaTE9SSC80U1ZrL1ltcWtqajJteFdQQWtWc0Jha2VH?=
 =?utf-8?B?ZUQ5dWpPdUhEMUNwY0g2emlEN2VGa0ZMTmxYcXNzeWIxbTdQcE82cGdUN3Ex?=
 =?utf-8?B?TmN3THhyc0x6TW5wSGY5QTh3anY3VFZINS9QT2NxMGdmMVMzbS9sSFVVN1Jj?=
 =?utf-8?B?RmtXRER6UnBQeDJJem1LWjFsMU5acERnYlpENitOamxGN0xiMUZVQStxVlNz?=
 =?utf-8?B?MjJsTTI1R1dPTmc2OGxJMU5jblNUbmVYdkpMdEl5ZHRhcVZxK3Rwblk4eGhi?=
 =?utf-8?B?Zk1URWVGRTlnM0FTTm1QbE1reTBJVmhhYk5vQW5ocWpmTUgrK25BZUwrV3N1?=
 =?utf-8?B?UHdqeWlIdC9keTlrRENoUHdWYzdxTTB4QWhnQXZiTnR2ZUN0RXJXb3pmNjJM?=
 =?utf-8?B?Mmxmd2ZET3lSd3hZajRMY09lWXNuclVzaldmUWNCUlNsTkhhdjh2QXhxN3Zv?=
 =?utf-8?B?Q2M0MDRsMmRtdzF2YjVjdDBObWFTaC9TdGJBRmRQMjR5bUZhZjJuUmtiWE5R?=
 =?utf-8?B?K0JtcnNOY3BDQzM1a1o4a2lhK1hGTHdja1l4QnBqMHI2TXMzaHpXNGtqV2VH?=
 =?utf-8?B?TUlzRkJ1cExvSkdlM2Ribkl3V05sdmhadmVYSjZUTjdmdVpqbjc4QnpkOHRN?=
 =?utf-8?B?TGxOUzhQY011ekkzdmY0dWlucUFlZ0hFMStmTTRxNkVVSUgyQkdIYkJmL0U4?=
 =?utf-8?B?WkV6dVB5WER6citBRW5hcTVsS1JpdHdXZmtrNVVaNWZxdnBpL2wrNHZZQk1L?=
 =?utf-8?B?eEM4K3E3Qy9uRWlnRkhtVFJNTkxhVkpvYjFjOW9oa3Exb1YyOEQzWEg0TzFh?=
 =?utf-8?B?K1l5UVJBN3ZqN1grblBFd1Q3cklwbjAyMjNHcng0QlR4SGxwWjhlcDVoMjI0?=
 =?utf-8?B?bXFUemxVTk5KNDBYdkNqQVRQM1pYMzVtMW1BVkVZdS94a29xOGJYRGQ4ckNG?=
 =?utf-8?B?SlZMdks2U1ZqaDE5cEMzK1AwN1YrVkRkdTNHWEdHdGFJc0NHUEh5MmZtaUxC?=
 =?utf-8?B?dTdzNlF5SURlZ2lJUk44MnFUU0dsNENZbDlOa2FYT0NycytaUDJFbFFaT2Ix?=
 =?utf-8?B?ZHBCRUdTTEpYVzE5RE91NkdYc0MwZWY2Z2dxdVdmQzVVdnA5RkFsUHBSTTBK?=
 =?utf-8?B?TWZINERKMWVmVnlHTkFUclY4cVhWU1FxanV4NU5LakVCZGdMaUpEVCtXZ1d1?=
 =?utf-8?B?aVBvNTVqT0J1djg3UnJKdGlyWk9pMUtkcCtGN3diNFNacHE1RkszZ052VVR4?=
 =?utf-8?B?ZVhBdkQ3KzFBNFpYcnZ2Y3ZBN0x1Q2daamE0NFJId29JOWVlaXcvUHptZW40?=
 =?utf-8?Q?mnZw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 17:38:23.1842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3744bc53-3411-48aa-be5a-08de3292c1ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185



On 11/21/25 3:40 AM, Arnaud POULIQUEN wrote:
> Hi Tanmay,
> 
> On 11/14/25 19:46, Tanmay Shah wrote:
>> From: Xiang Xiao <xiaoxiang781216@gmail.com>
>>
>> it's useful if the communication throughput is different from each side
>>
>> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> 
> 
> Thanks you for reopening of this series!
>> ---
>>   drivers/rpmsg/virtio_rpmsg_bus.c | 47 ++++++++++++++++----------------
>>   1 file changed, 24 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/ 
>> virtio_rpmsg_bus.c
>> index 484890b4a6a7..cc26dfcc3e29 100644
>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>> @@ -37,8 +37,9 @@
>>    * @svq:    tx virtqueue
>>    * @rbufs:    kernel address of rx buffers
>>    * @sbufs:    kernel address of tx buffers
>> - * @num_bufs:    total number of buffers for rx and tx
>> - * @buf_size:   size of one rx or tx buffer
>> + * @num_rbufs:    total number of buffers for rx
>> + * @num_sbufs:    total number of buffers for tx
> 
> Nitpicking... I wonder if rx, tx term would be more generic
> In such case s/num_rxbufs/n_rx_buf/ s/num_sbufs/num_txbufs/
> 

Ack. I can change that.

> Regards
> Arnaud
> 
>> + * @buf_size:    size of one rx or tx buffer
>>    * @last_sbuf:    index of last tx buffer used
>>    * @bufs_dma:    dma base addr of the buffers
>>    * @tx_lock:    protects svq, sbufs and sleepers, to allow 
>> concurrent senders.
>> @@ -57,7 +58,8 @@ struct virtproc_info {
>>       struct virtio_device *vdev;
>>       struct virtqueue *rvq, *svq;
>>       void *rbufs, *sbufs;
>> -    unsigned int num_bufs;
>> +    unsigned int num_rbufs;
>> +    unsigned int num_sbufs;
>>       unsigned int buf_size;
>>       int last_sbuf;
>>       dma_addr_t bufs_dma;
>> @@ -112,7 +114,7 @@ struct virtio_rpmsg_channel {
>>   /*
>>    * We're allocating buffers of 512 bytes each for communications. The
>>    * number of buffers will be computed from the number of buffers 
>> supported
>> - * by the vring, upto a maximum of 512 buffers (256 in each direction).
>> + * by the vring, up to a maximum of 256 in each direction.
>>    *
>>    * Each buffer will have 16 bytes for the msg header and 496 bytes for
>>    * the payload.
>> @@ -127,7 +129,7 @@ struct virtio_rpmsg_channel {
>>    * can change this without changing anything in the firmware of the 
>> remote
>>    * processor.
>>    */
>> -#define MAX_RPMSG_NUM_BUFS    (512)
>> +#define MAX_RPMSG_NUM_BUFS    (256)
>>   #define MAX_RPMSG_BUF_SIZE    (512)
>>   /*
>> @@ -439,11 +441,8 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
>>       /* support multiple concurrent senders */
>>       mutex_lock(&vrp->tx_lock);
>> -    /*
>> -     * either pick the next unused tx buffer
>> -     * (half of our buffers are used for sending messages)
>> -     */
>> -    if (vrp->last_sbuf < vrp->num_bufs / 2)
>> +    /* either pick the next unused tx buffer */
>> +    if (vrp->last_sbuf < vrp->num_sbufs)
>>           ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
>>       /* or recycle a used one */
>>       else
>> @@ -878,19 +877,20 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>       vrp->rvq = vqs[0];
>>       vrp->svq = vqs[1];
>> -    /* we expect symmetric tx/rx vrings */
>> -    WARN_ON(virtqueue_get_vring_size(vrp->rvq) !=
>> -        virtqueue_get_vring_size(vrp->svq));
>> -
>>       /* we need less buffers if vrings are small */
>> -    if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS / 2)
>> -        vrp->num_bufs = virtqueue_get_vring_size(vrp->rvq) * 2;
>> +    if (virtqueue_get_vring_size(vrp->rvq) < MAX_RPMSG_NUM_BUFS)
>> +        vrp->num_rbufs = virtqueue_get_vring_size(vrp->rvq);
>> +    else
>> +        vrp->num_rbufs = MAX_RPMSG_NUM_BUFS;
>> +
>> +    if (virtqueue_get_vring_size(vrp->svq) < MAX_RPMSG_NUM_BUFS)
>> +        vrp->num_sbufs = virtqueue_get_vring_size(vrp->svq);
>>       else
>> -        vrp->num_bufs = MAX_RPMSG_NUM_BUFS;
>> +        vrp->num_sbufs = MAX_RPMSG_NUM_BUFS;
>>       vrp->buf_size = MAX_RPMSG_BUF_SIZE;
>> -    total_buf_space = vrp->num_bufs * vrp->buf_size;
>> +    total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
>>       /* allocate coherent memory for the buffers */
>>       bufs_va = dma_alloc_coherent(vdev->dev.parent,
>> @@ -904,14 +904,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
>>       dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
>>           bufs_va, &vrp->bufs_dma);
>> -    /* half of the buffers is dedicated for RX */
>> +    /* first part of the buffers is dedicated for RX */
>>       vrp->rbufs = bufs_va;
>> -    /* and half is dedicated for TX */
>> -    vrp->sbufs = bufs_va + total_buf_space / 2;
>> +    /* and second part is dedicated for TX */
>> +    vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
>>       /* set up the receive buffers */
>> -    for (i = 0; i < vrp->num_bufs / 2; i++) {
>> +    for (i = 0; i < vrp->num_rbufs; i++) {
>>           struct scatterlist sg;
>>           void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
>> @@ -1001,7 +1001,8 @@ static int rpmsg_remove_device(struct device 
>> *dev, void *data)
>>   static void rpmsg_remove(struct virtio_device *vdev)
>>   {
>>       struct virtproc_info *vrp = vdev->priv;
>> -    size_t total_buf_space = vrp->num_bufs * vrp->buf_size;
>> +    unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
>> +    size_t total_buf_space = num_bufs * vrp->buf_size;
>>       int ret;
>>       virtio_reset_device(vdev);
> 

