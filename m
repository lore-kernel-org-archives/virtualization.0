Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020105.outbound.protection.outlook.com [52.101.84.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C041D22B
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815079; cv=fail; b=X/Sn46jnSRwqrZL0VczVnNWurqf/5RRJ2pQCqfyNAOGtCbE0rL+j5HcTXB15ELvpA/yP3ejikHIgsTcmX7QAAxEA1CVBxPvz/G3T2Tr7Q8mmUmqBUJ6NfbISE9J95lHF/07TMxb1D6TP37Apau0JDkJ3qU4GWIY8lufcV5cXlNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815079; c=relaxed/simple;
	bh=m4QvLqmReIPDibQuBe7gRr4Wi9P5/BsPWLQu2UqkHeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=asG1fFhUjEZOBZhYV5Tn5RQnqDuNM8Y+bU2EWTkBbcWPZcKlelHmy+WmsU2S/wVIzr6746y8LJIKy6mzDVATGmQpk5Gz5XBB8hvjE4BHR3IwY6V4hp9/RvT9+Wnl1Y7XmpjZ5jVfAbsVXFiyajyBfnhv7Wv1PMhwSTn/Vx6wtJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=bJs9wsU8; arc=fail smtp.client-ip=52.101.84.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bJs9wsU8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4ilUKkl/8swOzhQ6vKMHBTj+LguMTC34iv2nXEDxQ4moe7pFV8HucqzTvBo4BhDrNIGcGwb15h7BuKc+t5Fo5HxY6K0ykNlh3o5EUXEeH40QuXLTEJKu8Alxyr06Ckw84M1XRTvrm4p8jT0lp3TsurHBvAmUdBwjhsmAum+EPrHGqaVsni//IRrKTLiyq8riiTWDcDHLWtANVEhm/ckUqvSdyrwp0dzujTbXIVZfeyuqP1U5GSPHzpQfBjkIZ4j25/rNFYmTPZVMQsCg2wcnjIqevxfRsP6XtuR0mPwc4xpAxnH2yQ+Dgfu/wV3iE28XoeKLqLY4O7mkPNxILtgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FToMkOMl6EXXBx5p9nYHG8QC7ng451xTvniX2Kw/hnQ=;
 b=oWtfDIeS8E001B407m3+X0tbqJrHDuiBmGxo+VNUamymOJ2m3Ns/QCNr0ePM2JjCSLlMDe5CJyUw7jf93MfyF0FKT+HgU6T+tS7BRVI/a/vHGXOL6BB09Z7/9l3yPl/7kxOUP5KpZfG5G1mhWohIlUIZ7LacGjt+GzIbq/yq0Ck+NYQ7DlSTH8aNVzQin5x8b/H1nY0y506ZNl+f1c2bguwUBbe9oGKT4aCBzLw4+K86wmPcKKubA3DFgyfzAAl2WQgaqnjfwSycM1RtIldKctAKvl1tcBm4L8ENzoKWzWWEW4D3LL9pWgtyE6IQ3k+9Kj/kiZJ+4vSUuUBYb+ueLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FToMkOMl6EXXBx5p9nYHG8QC7ng451xTvniX2Kw/hnQ=;
 b=bJs9wsU87iHqOHHJ+MToSyNkx0qxxIA7mKHW1P5T38v8fzUYQNVRHuJEcp/UCCeP1SRStZz3ZCZr4z5kAcyUwnKsNp1gUUgKY6ibE/ER53MeCUNyBDNDcj+4lUsS7yagLoNCC2Krkxrcz+oH5EaYi/LtPoOh5RIo2aLuHgXdqNDLWH+tEQTdw0nd4bov40/xgdlhW+ZTQCG9lrRPC2MwbTFP6LF2V15UBCcOrZgISTuET/67y3EelGdTYg7dxguEknazbR54W7LP2cRxdhmy9mXA8gAB2Nu8WwkF6Idb/BfHI9mXX37uZe3wkY9dYrWp+Odb1v58vzebn+iJTnZl1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM7PR08MB5320.eurprd08.prod.outlook.com
 (2603:10a6:20b:103::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:57:48 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:57:48 +0000
Message-ID: <82066fcb-150f-47ef-86a7-0df0f9eb41c5@virtuozzo.com>
Date: Thu, 23 Jul 2026 16:57:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com,
 stefanha@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com,
 bchaney@akamai.com, mark.kanda@oracle.com, ptikhomirov@virtuozzo.com,
 den@openvz.org
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <amCPLOrnpYmr5n0p@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <amCPLOrnpYmr5n0p@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM7PR08MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: bbfdb14a-0435-4a92-c4e2-08dee8c26124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|6133799003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KE+VptCVCCFwf6KD8knRiXK/3XdJH9977N2NNBhI4fUj9Z1IUINNhZv4HIPVkuUT/IWutpzx3heBTPXFBxXT3GcZwjNHxQ0qFFBw6+FDv0/4y1LLRyqSHGcTifNGREoYtxZYgNDyUTdFD+hlzzsGLmF4a/oqzbbkPozyzPjXsj9OCFE061xrarIAxuaB1Z2e9rImkB46aO+8ycTnB7CCAJPgk0JfGMmzfk3iDHW/5tV8H3e3fwkN4g6xse+NfM68LqlIzIhEdKGxXGBgBj/nc1TvehNEX5npGqDa5XpWCX/9lttqT1I8qb2wEeZSNpKG2Yy07axFyKheP4JpNEAcawN7HfTksEluoVLhAsotXbu3TIkZybO7AbGaToCioK/s3nEAMxx/j+cuom91kXs8shrBWkm+13zi7R/IGbY8g1UigSJhTPuGEGXfpDdeYc9jJWEpOtJ41HDk3zzSScKjgAPTBc+90wnj7Avp4XsBk9RojBOgmmBxG4HqW0oenFKvFQRfo7+xYQ/DM5jhj6vjiVIiJOzTDeoxQn/dZCe9yQeI7qWANESIlOSWvGTFU4N6FCNabepNAVavgIH6IzY5OBybiq2Q4A3t9K0tRSda52s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(6133799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDlrQnVxcHdoNXpPVm5PZkpCU0JUM1djdGp1SEhqRnVkYkVjbDU5aFJrU1Q4?=
 =?utf-8?B?Q2hkb201RW80SnNyNSt5eFV4Zndpd2FwYlY5TVQ0Tll4d1V3aWkwNStnSkxt?=
 =?utf-8?B?QVhHS0N5bWtERVpGNXAvZTZtMDNoTE8zaE00WGZFUzlmcThudXdBMWpmNUZK?=
 =?utf-8?B?UFJtMGJ4RGdNaTJycDd3MnN2Rm5udXpjY0QzbFBQZHFGOGtpZUFmS0k3aDZV?=
 =?utf-8?B?N1B5MU8xTTRTeGo3L0txUEhUNmZKR2NiOUR0MWhkQlN3Wm11eER0cU4vYnVF?=
 =?utf-8?B?VFJ2RERXeFlUeGlUUVVDaXdwemRqNUlreFBNNTR2NkJkK0c2Vk9KSEllVjNs?=
 =?utf-8?B?ejdOR1RMOStWeFMvUVNoYUxTdkM4MFJyZmlqQ0VFNEFEWGZuN0dORnd6NUds?=
 =?utf-8?B?RDgyVFVtMEg1RXNlQVVrM0dYdDFlSWZDeHpNQTZGTERaVm9EeHZGYXVuOGsy?=
 =?utf-8?B?THM1SW9TeWxxQlpZcjJyYU56aHZYV1FEeUlZWjloWnBtVWtGYTc4RElSU2pX?=
 =?utf-8?B?QXMybFhGdUNSb0VPa1BDWW1Na3JwVW5DemlGY1RDOXZYaXhQVW41ZVZOaGRO?=
 =?utf-8?B?K1FicWZCYTl5NWJtRWd0YWhkT3VCLzlCUGtKQ2ZJL3VNSjhkd3YrMGpCWDBT?=
 =?utf-8?B?dExrTW9GaThGcEFHUDdQY0Zla3hzaTVtMFVnQWJNVVFHcGxHZnpCbUVIalhS?=
 =?utf-8?B?QzQzWHFrd3BUYVIzbnlsd1MvZzlNZ1BnTUdEUHRiWkZrU09QMFlpVDdYY2pL?=
 =?utf-8?B?M3VSM0V6OUVzNUVqZTl1SnJ3K1V3OWZHZzJDTFZDeFE4dlJ2a1kzam5wdm1o?=
 =?utf-8?B?TW4zdk40NzB6VlRGazB4bDhybldCZTJXRjJUaW1OVmRnZFg0cTZrZ2hIT1RD?=
 =?utf-8?B?NE1vdzdMR3YvWTJtVklXS2R3aUZZYnQ4OHNpREx2ajBFY2tiOUJIci9NZy9H?=
 =?utf-8?B?WW9CejYwRFA3Rnk4UGFEZlI5UFdid0Vvc1VBRVFjOTBuUUVaZDkrUzlTNzNi?=
 =?utf-8?B?STJCcDBmWklCYXRIV0tsKzRJWUp4R1NvQTd5UzA1QXd4dDRqWTFnaXB6c2h1?=
 =?utf-8?B?YTdvMmlRTXRybloxN3pmbEdZa1FtNlVieEZWa1dLdHhWcFRwSksxbVY1OXor?=
 =?utf-8?B?MWt4QU5rWnBZdTlGc1I3UW5wcm5IaExiaGZFOExGOTNKODhzaEFLYTA5UllH?=
 =?utf-8?B?Q1BjUlpFb3RqeVNUaGxYT0t5aTAxcDNPUUFLSXphY012RHY2SG44MHZUSllZ?=
 =?utf-8?B?T3F0RmFVWGRsWXRWLzlBREJDVURsbkVEcVNFQlJvOFlYSWpNcllSZmRCRDVN?=
 =?utf-8?B?ZFk2d2ZlOW1wZGtaNDYyZERiQnIvMmgwREltWjVCN0hTVVRDdFBxWEhkU29q?=
 =?utf-8?B?eFR4ekN6dDl5NW5ZbkJ6VkpIMmpGMVIxRkZaWkZpdXNCU0k5WnNFNW9zY2lS?=
 =?utf-8?B?cmJGckpWT2dQYnl2Q25qMmhXNlhJVFNWNlY3alpraW9Ic2VlazRaTVRNNkh0?=
 =?utf-8?B?R3B2anpxdElnMkROaGNJN28vTkpEdU9QcXhGaFZzUlRwYXhEYXAxVmpaUENQ?=
 =?utf-8?B?ckY1ODBwcW9JcGtmM0tUY09BbU51clZLcjFiVHpSZ1lpY3ZZN0FiQjJQVXJv?=
 =?utf-8?B?SWpDdkdWN2dTTTlyV2tmYndrWEtlY0M0TTV2b0RTOUNFOHN0MFIxcEx3a3Zk?=
 =?utf-8?B?MVF4SS92OHFid2xsSTR6ZGhtOWhkUDBQaTM0bVYxSTA2cGpTMWxxcDR0U3Ja?=
 =?utf-8?B?TjZxUG5jbHI4cDFLa0o3aGVGaEViVlVUV3F2L3B2WDJxZ1ZtczFXSjBNTWh3?=
 =?utf-8?B?WE9LWW9iOVFTU1hZbU1YK1VHZUVMZi9pVnVlclZ1MDRHOGNPZG4rRFR4cTNJ?=
 =?utf-8?B?c0ROVmpBRS85WVY2SkNlWS8xdmhhcGx0MVVqU3JUVlJOZ0hOQmZjOXhlelZZ?=
 =?utf-8?B?R0pLYzJJN0RrTEI5RGZhdHgyQnFSYW9CUE1EQjdRMnRwMk5oemw2eUxVK1o2?=
 =?utf-8?B?K05KUjFnazRFM0VlbTJWWGtNZWVHTDRGeWNLODZsTkdvUkMrdTFxKzZBeVBm?=
 =?utf-8?B?L2Q1WTh6aE80RDVmSlR0dXl6OTRuVk9NbHFUZHhYVEtTRm5Dc0NUdWpYNzFk?=
 =?utf-8?B?QnpZOXdYSys2RkFvYWNUSnYzUXMvdkxNTVpBY3RRU3dtQkhsWWlWaTNILzlz?=
 =?utf-8?B?ZmJWT1FHeS9LYWVmZFVHZUhVTGkvV0pNbTkxTm55U1U2b1RKR2hCRXpmVXpR?=
 =?utf-8?B?QXVaZW5Xa2F3VDg1UC82eThyckd2U1RsUVJoTkRvZTJpS1VxdFozeDhycDFV?=
 =?utf-8?B?Yjc2RDRJTjlXRlNGYlF0OU9pY2d1VjBhQ3lvNUhyR2VYYWRBQjRLcTBJWnkx?=
 =?utf-8?Q?SdcWAkDBTxh4JnkM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfdb14a-0435-4a92-c4e2-08dee8c26124
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:57:48.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qafC2m0RpwA3Sdd/JiuJAg4ZNyxLg9a9Ur3fIcJq48DYSt2zsxvgsFhUzHIDD+9ALtMT/lXjtjjY8GDIIBL7W+9FmfIFR/idR3ya0Ic06Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5320

On 7/22/26 12:43 PM, Stefano Garzarella wrote:
> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>> vq->worker and queues work on it.  vhost_workers_free() however clears
>> the vq->worker pointers and immediately frees the workers, without
>> waiting for a grace period.  A caller that fetched the worker right
>> before the pointer was cleared can therefore still be queueing work on
>> it while it is freed.  And even when the queueing itself wins the race,
>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>> future attempts to queue it are silently skipped.
>>
>> None of the current callers can actually hit this: net and scsi stop
>> their virtqueues before the workers are freed, and vsock unhashes the
>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>> in vhost-vsock keeps the device hashed while its workers are freed, so
>> the lockless send/cancel paths become able to race with the teardown.
>>
>> Fix this by clearing the vq->worker pointers, waiting for a grace
>> period, and then flushing the workers so any work the last readers
>> queued runs before the workers are freed.
>>
>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> drivers/vhost/vhost.c | 11 +++++++++++
>> 1 file changed, 11 insertions(+)
> 
> Sashiko reported some potential issues here:
> https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4
> 
> IMO the first one is pre-existing, but not really sure it is a real 
> issue since happening when the worker/vmm is going to be killed.
>

Sashiko claims:

> Will this leave the queued work unexecuted and permanently break the
virtqueue by leaving VHOST_WORK_QUEUED set?

I agree this issue is pre-existing and doesn't have much to do with our
series here.  It looks real, but in reality should be harmless since we
may only hit it while the device already dying.  Means there's no VQ
state to be saved.  The only potentially observable artifact I guess is
a warning here:

vhost_workers_free()
  vhost_worker_destroy()
    WARN_ON(!llist_empty())

So more of a cosmetic noise on a dying device.  Again, not relevant to
this series.  But one optional way to make it go away would be to clear
vq->worker under vq->mutex in vhost_workers_free() (mirroring
vhost_worker_killed()).
> The second one also not sure if it's an issue since the sender is not 
> lockless IIUC.
>

The term 'sender' is confusing here:

* vhost_transport_send_pkt() is the .send_pkt() method of struct
virtio_transport.  It only stores skbs into the queue, doesn't process
them. It indeed is lockless as it doesn't take vq->mutex.

* vhost_transport_send_pkt_work() is the .fn() method of send_pkt_work.
It's called by the worker thread to process skbs in the queue, calls
vhost_transport_do_send_pkt() which does in turn take vq->mutex.

I think sashiko points out to the former.  Still, I don't think it's an
actual bug.  Look:

1) By invoking flush, we wake the worker thread:
vhost_dev_flush()
  __vhost_worker_flush()
    vhost_worker_queue(flush.work)
      worker->ops->wakeup()

2) Then woken worker does:
vhost_run_work_list()
  llist_for_each_entry_safe(work) {
    clear_bit(VHOST_WORK_QUEUED, &work->flags)
    work->fn(work) // for send_pkt_work = vhost_transport_send_pkt_work
  }

3) And then in work->fn() (vhost_transport_send_pkt_work):
vhost_transport_send_pkt_work()
  vhost_transport_do_send_pkt()
    if (!vhost_vq_get_backend(vq))
      goto out;

As you can see, we return early in case backend was unset.

So after doing this flush, we have: 1) QUEUED bit is unset; that makes
send_pkt_work re-queueable. 2) But the queue doesn't actually get
processed, and VQ state isn't actually touched here - so I guess
Sashiko's conclusion is incorrect and there's no actual bug.

> But, please can you double check them?
>

In general I'd leave this patch as-is as Sashiko's complaints aren't
very convincing so far.  If you want I can add another patch which wraps
NULLifying workers in vhost_workers_free() in vq->mutex.

WDYT?

Andrey
> Thanks,
> Stefano
> 
> [...]
