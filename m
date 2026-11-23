Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452520;
	b=CAdlK8NK6WqPlmfWB0nA5Gaf112rCCx0ecpT7gaKxro4IW5FhCQlUnquN/6Fu7RRTkbt
	 lBuPdPzRttL8aKMfKh+eC9yByKIBMhcm9fbVv+d02ONvGq9u+gfrHqFMxgRu5jn23ciwA
	 RVKUsmYwluPXfBCh1scjWrT4Ysricet1cMn9vVS61UpEsyTjqd63IbhWO1RxzMBhoDDKc
	 xmuGFWB+ijKIk+Jp1JZEWOGr7b2Op9vwsPTHYvCIewuYjp5QbJR0AL8K77XYfoxPleMWV
	 Ga1wJ1jUzYyYvFJKcVQWtLPZkZP862TVdxbsXOLUaBrImvGpkALTzhXDob3ZdbbnLzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QTHxkjwnWdi0Sg67/NbYoTIjq9LWwP65YaigHl4xtvM=;
	b=wHGloOPq5g9QCtsdihBU3I6WBK7GKJu1E9SXDSb8ys8pAl07kVz6supN57GhgAy/K90m
	 QwsXE7EMGbcLXrojkht/tOyMmaWzuSkKDyUxLe9kmUkLNq1YiZQjz+eLtP+xt3IFD8vzM
	 NmMLkmGIiX+ddO0TikcsB/1TRFnJrY2AVl79UHh2BzKQQ7i0fs8U8PNNcKSpcLUgABUgQ
	 nCRg+nBwZvHZORFcYanzIhkH5z0V6ehbzJHbY8+TYsiGEisUUGZr14NaiZaB/2UVVaMHA
	 MF8KGmEWgJIwZK6UmTVrGaAr3WxR4go9QFSUzQ2uAQdHgnVp53sBEhGwrPNjSDCNQJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=txLwN9ll;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A8B606A33F
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 16:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A8B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=txLwN9ll
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a07078200fso1771450b3a.2
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452520; x=1796057320; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QTHxkjwnWdi0Sg67/NbYoTIjq9LWwP65YaigHl4xtvM=;
        b=txLwN9llBvlRmNYUR+vvEymsCmBJ5ic2EI2O4iISIm5m0Vz4iH9U44mHYlmAo9m4L+
         PHmX2hKQfkDknZoonnp8cSq0xo7/K8cCfMk1cqGeL67RJX7iKQGWg8VIL7KE1ED+ejTb
         Id9/UMq+MKngLgWKCYnoB4lecf/bDCeayMMEVxP1JVyvIB4NDfd0baqn2sJ3rpIKwxVh
         KOCEkZLu+kHnANQ+Hzh3kuKVili1YSh1dSpogcGd2HIwZ1e1yqRyAErkBeuM0nb3jCUp
         X8CPFeIltHvZES0WR6mpXO3hlxlnsefgI0CPUf4hbCzHLQFvSecdU3BkMi/OAm1XScP8
         xxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452520; x=1796057320;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QTHxkjwnWdi0Sg67/NbYoTIjq9LWwP65YaigHl4xtvM=;
        b=RHe9z9WCtWYiKFHyK9NwjIW6vE+bFD3N7uB5jPA/vFi0GBSvDrwnbD8rhfaDVge9aa
         qVreJSdIuzLEY02wrPzbCO4QsOzuNpN7ysmIao5XgUsP0fGO1XKxo5s9wcRVG7S76S0l
         VjZjYZtlYeu7FU7Afi0Y1aaAnL9hr9dpoDoXju56DBoqaNLckKCWrqUkPVoxZH9bgJsN
         NoyFa2BbMykmomW0dABrqzMueqxQS0zeZfxI4W0Hj7gO9FeMU1uzRR8B5JXAoqNs7vos
         ytP75FHdIAs8DjwiC2E7KFEpxAaPb79mOrvh5y7nWZe2WV5bQXh/UMzwyAkmRkv8/LGi
         eSMQ==
X-Forwarded-Encrypted: i=1; AL+hErG0KtDwMT99YmHLbyxu45AXGgGW08SvfZmE2S7kUhvgxt20iMdyGXBuU62PueoZcy9kNXE8TPGaxIwse9M48Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+8FtC7GPymKljtMDWrDafmgP3bd9EO6GgNq1SDQptfOxSgztpe
	BOUbvMRImql7KHcCY84CQ/TUi94JyzQ7wqLh3xuqnaRF6mCkrw9a7G4c
X-Gm-Gg: AZFdTZdUUjSN1eA2XT7y/CaDUmrDmwu96nL7OMKOE0I0Fy7nU8msGyR4QlDzztMrTM5
	AoCDAi7qrjFxYSkWBssEgEdk4rkieW+sVz6d1CC0ShvYvIpHknc8FVUwEqaDzNAYGU2tshqvozg
	prpRu1rl73y++o2hygXXw3YiH0AyDHuxl9zmY5mZHE8Fbw7s5hz/5bl+gMxbG7axmwwzOBqpPKy
	QxQLLfuOo89d/Ac/RpJMnSzR3BSeJgIPvr6RQNp8Uy5J5UUI+lkssjV9jFbBgviSlZViADGR/ly
	GKck3mR1pceNEWcgxtjk2WaKf8gp5r+4G4cC/QXwktdZFdYzPUynISS6Uv03ScQw6LS8vm5kk7Y
	uta98XkXaPG8a7mEsb9xwyyiD+n6mHwooL6/QIyCjjAmXkTp5HrTeYyxp4KQgt/cKhk/8taAvnC
	nEgBDLz6DYgHk2hkGEB+QSwYd2RmEpj2rZiv1U8i4p1o3jPlEXvxEm+92JHckFnerqidpAWci2D
	kwY+HRx1Wc0cCAeMNFCOeMsYk9uAQeCic3lzTyonhbm/3ZIE0FJdEg9SF13LAZjwMpxKQxmfJNU
	jbBpKVPgTbuzMW7INI3DWMjOFeBA4Q8RTEuCZgpi5XthGyQ=
X-Received: by 2002:a05:6a20:c992:b0:3f9:9114:804f with SMTP id adf61e73a8af0-4014d15937dmr11140810637.27.1795452519544;
        Mon, 23 Nov 2026 08:48:39 -0800 (PST)
Received: from [10.2.0.2] ([159.26.115.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343fe6csm6085691b3a.37.2026.11.23.08.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 08:48:39 -0800 (PST)
Message-ID: <a7752192-b417-4e70-8f39-a3cdc983f447@gmail.com>
Date: Tue, 24 Nov 2026 00:48:34 +0800
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vhost/vsock: annotate lockless accesses to guest_cid
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Asias He <asias@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261117164916.2332953-1-phind.uet@gmail.com>
 <20261118012321-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Nguyen Dinh Phi <phind.uet@gmail.com>
In-Reply-To: <20261118012321-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/2026 2:33 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 18, 2026 at 12:48:43AM +0800, Nguyen Dinh Phi wrote:
>> vhost_vsock.guest_cid is written by vhost_vsock_set_cid() under
>> vhost_vsock_mutex, but It is also read without that mutex in
>> vhost_vsock_handle_tx_kick(), and vhost_vsock_get().
>>
>> KCSAN will report data-race if we issue VHOST_VSOCK_SET_GUEST_CID
>> ioctl while the device has TX traffic. For example:
>>
>>  write to 0xffff88810f1596ac of 4 bytes by task 7914 on cpu 1:
>>    vhost_vsock_dev_ioctl+0x25f/0x720
>>    __x64_sys_ioctl+0xc2/0x110
>>    x64_sys_call+0x299/0x20a0
>>    do_syscall_64+0xc9/0x510
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>>   read to 0xffff88810f1596ac of 4 bytes by task 7910 on cpu 3:
>>    vhost_vsock_handle_tx_kick+0x41b/0x740
>>    vhost_run_work_list+0x97/0xc0
>>    vhost_task_fn+0x98/0x1f0
>>    ret_from_fork+0x2e2/0x3c0
>>    ret_from_fork_asm+0x1a/0x30
>>
>>   value changed: 0x0000004d -> 0x00000032
>>
>> Both readers load the CID once and works correctly with either the
>> old or the new value.
>>
>> Mark the store with WRITE_ONCE() and the two lockless loads with
>> READ_ONCE(), so KCSAN knows the race is intentional.
> 
> You make it sounds like it is just KCSAN false positive.
> Is it?
> if yes, this should be data_race. If no, document why.
>

This is an actual data race, not a false positive. The value of guest_cid
can change while the TX worker or lookup path reads it with plain accesses.
Because each check loads the CID once and either value is valid, the result
is equivalent to the read running just before or just after the ioctl.
Even so, plain concurrent accesses are a data race under the Linux kernel
memory model, and using READ_ONCE()/WRITE_ONCE() also prevents
compiler re-fetching or tearing rather than just silencing KCSAN.

>>
>> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> ---
>>  drivers/vhost/vsock.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> index 88a310390eb0..f26c59013075 100644
>> --- a/drivers/vhost/vsock.c
>> +++ b/drivers/vhost/vsock.c
>> @@ -78,7 +78,7 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
>>  
>>  	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid,
>>  				   lockdep_is_held(&vhost_vsock_mutex)) {
>> -		u32 other_cid = vsock->guest_cid;
>> +		u32 other_cid = READ_ONCE(vsock->guest_cid);
>>  
>>  		/* Skip instances that have no CID yet */
>>  		if (other_cid == 0)
>> @@ -572,7 +572,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>>  		hdr = virtio_vsock_hdr(skb);
>>  
>>  		/* Only accept correctly addressed packets */
>> -		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
>> +		if (le64_to_cpu(hdr->src_cid) == READ_ONCE(vsock->guest_cid) &&
>>  		    le64_to_cpu(hdr->dst_cid) ==
>>  		    vhost_transport_get_local_cid())
>>  			virtio_transport_recv_pkt(&vhost_transport, skb,
> 
> Will prevent compiler from hoisting the reads out of the loops.
> Does it matter?
> 

Not much in practice: because the loop body calls non-inline functions, the
field needs to be reloaded across calls anyway (and in `vhost_vsock_get()`,
the `vsock` pointer changes on every iteration). I checked with gcc 16.2 and
clang 21, and the compiler does not hoist the load out of the loop even
without the patch.


