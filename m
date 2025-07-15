Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253322D46C9
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577203; cv=none; b=Q+7GAR8W6v1VM2TNLYygbun4kMnqzML1/0Hzy+voBv19czcRjQi1eCis370QMSEe5PbslJzXbwG5BO/AfNhqATKeFz1VFKuIOyrk07bi5Y6hGEECFFq6qfD3WtmLM+mpSHumDPc9eMtTn8MEvwqskS6ZJt+WB5ObMrO9HJWB0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577203; c=relaxed/simple;
	bh=JyxyvVyo58Tv9n1lQT6wmOdxLpJGAVrrVTpk5Zt7UHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fy2hyfggRfr3siHcpuncnwXk5fcIek/yOLL6Zup+Mp9qwlJ7rsN92pgxVwHHxkYN0jIl72n766l6sab/ANWLCpvIBts8DEE2uNYI/fJHfk0pDel+De2OFjoE9GtWl10lNcJkOwJ6U03sapi2OL6xNerwzR2G57uthhSQDbJpvxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aH2Na6Ds; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aH2Na6Ds"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3508961d43so4737585a12.3
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752577200; x=1753182000; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Hoq4cDqVbVGE+Ycot0nstw/AhDL4PcoQMiH+SXTuyY=;
        b=aH2Na6DsEzpdcd+IuKX/N6KEtJlUUIdYdKNr9JBOWjSXQHplXxqD+jLxVZUEtsoC1J
         PyC1bFMmzt14OThz4e2ySzNA1Zbaq3vhnJ1ouMGk2r4NZUwvhPwe5i4px6dwhiQgvoxC
         l8NsLLyMelmfBexQUdZBsIQXAfYxj4YTFeotbVeKyYr2zGS72JO1K4NDYR0d1ISk6+ro
         8Xy76sLFJaOYUvMk7MF9Mqa3+isJ8psqy3/S4KPEJ+rqWv+E6UHeh4yblW9djQLUviFk
         xpsDtD9vxINRjeb6liPskF0+yz6YS43R8omD031YD94W9flzWQCyQDznoqFZatvzGY6K
         LSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577200; x=1753182000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Hoq4cDqVbVGE+Ycot0nstw/AhDL4PcoQMiH+SXTuyY=;
        b=e8tT6tOLhVug089ZuW9C2zcp4BuTZEpiI25UcEx4oL+sBe1ptwCOvo9ukyn12sJ9JT
         cDnwzZlfsZL11O2YiN8MPmxRYwMr9FYNAgBnM57BiKMjgeDvJd6ZxEli3fQNoT/yBdqk
         I4320knxmZrP8R7ZZu+7Wob9L/6ApcF0fnz7MuU2dB/0e9cuCliUiHsAfx5UjXJ7LCV9
         cL+E3cW3hTssvV4iontv06bbs+b1kD36R5+4XIidMUJpUF/SMfSiJT49G+NyrRanxJN8
         O7/UKVeOy27CSL6nw+CVAtXNW0DPlr0ZIcUmJPGdIfQ/FtCLwL24DAHr+4USbiCys4VN
         qcUg==
X-Forwarded-Encrypted: i=1; AJvYcCWkYtS4HMfXtBIdn9h8AeR/fvEPmlRYZiBtfNUcZwvfJcMOWd7+nPXV1HeHxwAXTSH0V67Uz6RihH+mdy0u8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5MmImzb5XIV8t8Ja1h7n3gRKR+tzUhWWFmsJwFaZrHqCo4c+5
	eVIqsygR3MMiwsOH1pmHenY5dH1568wlB+t0wYWsvV9nNiVwN/JGWztlaVLfhJWn6Iasr+9ad24
	SV8p+
X-Gm-Gg: ASbGnctI+TAGmJAajkbh4KYHbxeIKrG5nueWLm/6jy7TGKeTioUxKhUn/xBZwfFbAyb
	3uFnZNdQdeh4BtoKfOAqiCpLV7cnJG+3zW8Xi574VBDZd6deiDfWdNXfOIEKsiKdIoV9jbq5IvX
	zc5dzThL1l2f0YH1garmj1xlByioEohc+PibBjRu8lYr2ZimUXHSbtV10kjhJ1aiihTnEbcZHaP
	0q72vDlzpMWCx9kxO9YLetv6UNmU1BDEqyyj92uoPq6ofXwtvihvC0QbOAJPYdzwWQRq08WRjkJ
	Ooe6vul9A0luMpAfKKUdegZWmPwzANmUOrPIts/vyxMKtAmQDH+KneIeiXoyTN9JiouPK4uY1mQ
	APJx9ozHuT7+eV8iLAHphvyWyMQiYltsXj6BzHNGhH0bOUTisc8OnGsFJyr3tZFbG0Unj4gmyeY
	PaaTriBthPIZLfeNMy
X-Google-Smtp-Source: AGHT+IHvpsjafBiOobqzMQX50H5RG9z1RSoNeOMIZ+2waPu6N1IUMPFUwGoGDtzQMC5wlRhtR3h+fQ==
X-Received: by 2002:a17:90b:2e4f:b0:313:271a:af56 with SMTP id 98e67ed59e1d1-31c4cdad83emr24239971a91.30.1752577199877;
        Tue, 15 Jul 2025 03:59:59 -0700 (PDT)
Received: from ?IPV6:240e:3b5:3092:aeb0:443a:1cc9:144c:1f02? ([240e:3b5:3092:aeb0:443a:1cc9:144c:1f02])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e973e80sm11898803a91.15.2025.07.15.03.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 03:59:59 -0700 (PDT)
Message-ID: <d5ad1b10-f485-4939-b9de-918b378362b9@bytedance.com>
Date: Tue, 15 Jul 2025 18:59:51 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH net v2] virtio-net: fix a rtnl_lock() deadlock during
 probing
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702103722.576219-1-zuozhijie@bytedance.com>
 <CACGkMEvjXBZ-Q77-8YRyd_EV0t9xMT8R8-FT5TKJBnqAOed=pQ@mail.gmail.com>
Content-Language: en-US
From: Zigit Zo <zuozhijie@bytedance.com>
In-Reply-To: <CACGkMEvjXBZ-Q77-8YRyd_EV0t9xMT8R8-FT5TKJBnqAOed=pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/15/25 5:31 PM, Jason Wang wrote:
> On Wed, Jul 2, 2025 at 6:37 PM Zigit Zo <zuozhijie@bytedance.com> wrote:
>>
>> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
>> the virtio-net driver is still probing with rtnl_lock() hold, this will
>> cause a recursive mutex in netdev_notify_peers().
>>
>> Fix it by temporarily save the announce status while probing, and then in
>> virtnet_open(), if it sees a delayed announce work is there, it starts to
>> schedule the virtnet_config_changed_work().
>>
>> Another possible solution is to directly check whether rtnl_is_locked()
>> and call __netdev_notify_peers(), but in that way means we need to relies
>> on netdev_queue to schedule the arp packets after ndo_open(), which we
>> thought is not very intuitive.
>>
>> We've observed a softlockup with Ubuntu 24.04, and can be reproduced with
>> QEMU sending the announce_self rapidly while booting.
>>
>> [  494.167473] INFO: task swapper/0:1 blocked for more than 368 seconds.
>> [  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
>> [  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x00004000
>> [  494.168260] Call Trace:
>> [  494.168329]  <TASK>
>> [  494.168389]  __schedule+0x27c/0x6b0
>> [  494.168495]  schedule+0x33/0x110
>> [  494.168585]  schedule_preempt_disabled+0x15/0x30
>> [  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
>> [  494.168835]  __mutex_lock_slowpath+0x13/0x20
>> [  494.168949]  mutex_lock+0x3c/0x50
>> [  494.169039]  rtnl_lock+0x15/0x20
>> [  494.169128]  netdev_notify_peers+0x12/0x30
>> [  494.169240]  virtnet_config_changed_work+0x152/0x1a0
>> [  494.169377]  virtnet_probe+0xa48/0xe00
>> [  494.169484]  ? vp_get+0x4d/0x100
>> [  494.169574]  virtio_dev_probe+0x1e9/0x310
>> [  494.169682]  really_probe+0x1c7/0x410
>> [  494.169783]  __driver_probe_device+0x8c/0x180
>> [  494.169901]  driver_probe_device+0x24/0xd0
>> [  494.170011]  __driver_attach+0x10b/0x210
>> [  494.170117]  ? __pfx___driver_attach+0x10/0x10
>> [  494.170237]  bus_for_each_dev+0x8d/0xf0
>> [  494.170341]  driver_attach+0x1e/0x30
>> [  494.170440]  bus_add_driver+0x14e/0x290
>> [  494.170548]  driver_register+0x5e/0x130
>> [  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
>> [  494.170788]  register_virtio_driver+0x20/0x40
>> [  494.170905]  virtio_net_driver_init+0x97/0xb0
>> [  494.171022]  do_one_initcall+0x5e/0x340
>> [  494.171128]  do_initcalls+0x107/0x230
>> [  494.171228]  ? __pfx_kernel_init+0x10/0x10
>> [  494.171340]  kernel_init_freeable+0x134/0x210
>> [  494.171462]  kernel_init+0x1b/0x200
>> [  494.171560]  ret_from_fork+0x47/0x70
>> [  494.171659]  ? __pfx_kernel_init+0x10/0x10
>> [  494.171769]  ret_from_fork_asm+0x1b/0x30
>> [  494.171875]  </TASK>
>>
>> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
>> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
>> ---
>> v1 -> v2:
>> - Check vi->status in virtnet_open().
>> v1:
>> - https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@bytedance.com/
>> ---
>>  drivers/net/virtio_net.c | 43 ++++++++++++++++++++++++----------------
>>  1 file changed, 26 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..859add98909b 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3151,6 +3151,10 @@ static int virtnet_open(struct net_device *dev)
>>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>>                 if (vi->status & VIRTIO_NET_S_LINK_UP)
>>                         netif_carrier_on(vi->dev);
>> +               if (vi->status & VIRTIO_NET_S_ANNOUNCE) {
>> +                       vi->status &= ~VIRTIO_NET_S_ANNOUNCE;
>> +                       schedule_work(&vi->config_work);
>> +               }
>>                 virtio_config_driver_enable(vi->vdev);
> 
> Instead of doing tricks like this.
> 
> I wonder if the fix is as simple as calling
> virtio_config_driver_disable() before init_vqs()?
> 
> Thanks
> 

That might not work as the device like QEMU will set the VIRTIO_NET_S_ANNOUNCE
regardless of most of the driver status, QEMU only checks whether the driver has
finalized it's features with VIRTIO_NET_F_GUEST_ANNOUNCE & VIRTIO_NET_F_CTRL_VQ.

We've made a little patch to verify, don't know if it matches your thought, but
it does not seem to work :(

    diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
    index e53ba600605a..f309ce3fe243 100644
    --- a/drivers/net/virtio_net.c
    +++ b/drivers/net/virtio_net.c
    @@ -6903,6 +6903,9 @@ static int virtnet_probe(struct virtio_device *vdev)
                    vi->curr_queue_pairs = num_online_cpus();
            vi->max_queue_pairs = max_queue_pairs;

    +       /* Disable config change notification until ndo_open. */
    +       virtio_config_driver_disable(vi->vdev);
    +
            /* Allocate/initialize the rx/tx queues, and invoke find_vqs */
            err = init_vqs(vi);
            if (err)
    @@ -6965,9 +6968,6 @@ static int virtnet_probe(struct virtio_device *vdev)
                    goto free_failover;
            }

    -       /* Disable config change notification until ndo_open. */
    -       virtio_config_driver_disable(vi->vdev);
    -
            virtio_device_ready(vdev);

            if (vi->has_rss || vi->has_rss_hash_report) {

For reproduce details,

1. Spawn qemu with monitor, like `-monitor unix:qemu.sock,server`
2. In another window, run `while true; echo "announce_self"; end | socat - unix-connect:qemu.sock > /dev/null`
3. The boot up will get hanged when probing the virtio_net

The simplest version we've made is to revert the usage of
`virtnet_config_changed_work()` back to the `schedule_work()`, but as in v1,
we're still trying to understand the impact, making sure that it won't break
other things.

Regards,
