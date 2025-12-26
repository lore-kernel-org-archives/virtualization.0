Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FC423505E
	for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766778362; cv=none; b=nihjXcUljgzaktYMD8b2amblHnHH/FKakl4LYhaZuoskelQ22PwzSljcoCeqzm/L+BnnmEhMBbvVrYIisBQqHVlY+9PDoLUn5CqQoFRH3l74Uf0AJvZl9kNPs9HBEeDM5pIRZVxY7fAdCW055YJlM4a+Q+4JZyOwDh+EYyJ6hw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766778362; c=relaxed/simple;
	bh=wVYZF+e1enXNKGfJjuWosy6NKBwBgoZ3nbZt6jDkl1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Rd77PN7rCVkePmHYMB7bpxCl+YmWvcx9J+uct4+6A5UR27K5rCECEITqLudF02i8T2IXcLm71FlBeBOksSmd76CRDbUwLNOGvMHYEYF1LYxX6981yHW1FxNr5AoOMgv7Sqr7r5Y9P4yUymalzJkh6J4DhJIvcvTea3FH8VSIuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAKBXD46; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAKBXD46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766778359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3ANcrzYPkDIAnFUIilXfbPnAAM7NCYeWzEM7/NuXJ8=;
	b=IAKBXD46AUdtHN5+v0AMnR/QNSCtt/FWUU9/9+DrskejF2LrBtzlWoHKGRqvf8HupZaLNg
	QUhk4tqYG15PHFSIHChQ8rV0BmOjxl3rncCckBXOO4HCissm9x0rsizcSgUV7wLHabrZeY
	Q8hOzIxtc47ywVfQPHaUCoc1Udlv62w=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-EqMWycrWOwSmvD4H_EPc2g-1; Fri, 26 Dec 2025 14:45:57 -0500
X-MC-Unique: EqMWycrWOwSmvD4H_EPc2g-1
X-Mimecast-MFC-AGG-ID: EqMWycrWOwSmvD4H_EPc2g_1766778356
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b993eb2701bso7865881a12.0
        for <virtualization@lists.linux.dev>; Fri, 26 Dec 2025 11:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766778356; x=1767383156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3ANcrzYPkDIAnFUIilXfbPnAAM7NCYeWzEM7/NuXJ8=;
        b=obexW9eHq1Mn2XcShh0hnmF3RJSeU4ntThGYcu7q+PHRtk80BkuBzAFer3W0jZav1z
         vt32ODAeSzAHGKkOQWMFtpM8qBAQ5m6vSADByLsamrb6jBurvz2DyctVNlc1WI2ZOGyf
         NoN1uK/CSjfD6fVOoAEbMK8RiUAcv6LwLWU18LuwcTQRESGwcF7Ct7Rl4MmfQdk+jYij
         IVFeXDmDwzHbrtdp6jHVwcLYl9VQa9AlhlkU9wUZg+dvjeM27DdWSVQ/Dcnt1Hrzuxuf
         m59Pw9WuWFMZ/gUxdtkGkHBpI7Ex8jAvwWuqGpipOZaMCCocfrOJY7jSZdEnS/D8LtZv
         sEUg==
X-Forwarded-Encrypted: i=1; AJvYcCVSDxvhDlxzCVawlwDLVyP27iDhIXXFoK7UgTTclWsiqTHIbbkmK7j7aKNoyhApWgOj7gjt0+5Ve6RBYOgr0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHkeREukz4drn98pT0XUG6/9vrjbhuephi+d4EzsLHq35MMRFq
	sI9K52j9n7pHO6vnBHAjzDaGhKsBfhdpzVG5roYKjfDuZvyi8zNGk1MNFHVuwgcjiGzuJVBCMzC
	2NE6jl6w4OhoZO0MF+VMdnXtAooq6RCyuziozgKa5GvlcNmArabSJsKky3MI2sMHOgqK6
X-Gm-Gg: AY/fxX4/Wd2//3Mkmj9JpqNLOirlx9AjE7UrDuTr4Zj4YVIiB/5h3fBsPo86AAiKbic
	sUO5TBNkbCt+a9aIrIWbvYEIOTSwNgA9J9P96ChQJCr8/CSAStPqPO/4WJVYUp1tBELm1NSxW2X
	/yjjMUiL5JDCwhkYXg43hqlSpZioQ28nVL2D1wZgXhVW+cQeglCHFYNhkOKTE9oYrYJUC/e5q4P
	ZVvHNJwOf6ncLYVgKrkO9Qa2TwmIcqa2D4D23AyjjoZIDyjlqgHVZjseV6+XwguG/FtTGIviX2g
	owain3ND7tgKDicbIHFfo6zMjlCOgYE9H7RVI5Esfffa3mRH5Axl6G6DsUtmsqXytFTVipwb9i1
	nBuGNZzh6EGDGVkirusFBkn/VUY1myLhFOTjly7zPA435OHM=
X-Received: by 2002:a05:7022:b906:b0:11b:c86b:386a with SMTP id a92af1059eb24-121722abe20mr17088372c88.5.1766778355819;
        Fri, 26 Dec 2025 11:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMCubugbb6ViKIrXyUFk2mh7Euous4RdnMGFJwHZM5vXOJfaFiwdvfWBHf4PMCa4VGZrJbcg==
X-Received: by 2002:a05:7022:b906:b0:11b:c86b:386a with SMTP id a92af1059eb24-121722abe20mr17088352c88.5.1766778355195;
        Fri, 26 Dec 2025 11:45:55 -0800 (PST)
Received: from fedora (pinamar-179-51-86-121.users.telpin.com.ar. [179.51.86.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm102034332c88.12.2025.12.26.11.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 11:45:54 -0800 (PST)
Date: Fri, 26 Dec 2025 20:45:48 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Francesco Valla <francesco@valla.it>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aU7l7MckMumCxmeQ@fedora>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <23c5df0c-48d1-4d3a-8f25-8249b93c9b60@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <23c5df0c-48d1-4d3a-8f25-8249b93c9b60@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BztSVl7JyX9DBtTKg3a1a25B49ICw7V__JjTNDGae-Y_1766778356
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 18, 2025 at 08:51:41PM +0100, Harald Mommer wrote:
> Hello,
> 
> On 12/14/25 16:25, Francesco Valla wrote:
> 
> >>>> +/* Compare with m_can.c/m_can_echo_tx_event() */
> 
> For the question whether some comments were originally more personal notes: Yes!
> 
> This applies especially for the ones which state in which already accepted driver(s) was looked to get an idea how things may be expected to be done. Most of those comments should have served their purpose now.
> 
> >>>> +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> >>>> +{
> >>>> +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> >>>> +	struct net_device *dev = can_priv->dev;
> >>>> +	struct virtio_can_tx *can_tx_msg;
> >>>> +	struct net_device_stats *stats;
> >>>> +	unsigned long flags;
> >>>> +	unsigned int len;
> >>>> +	u8 result;
> >>>> +
> >>>> +	stats = &dev->stats;
> >>>> +
> >>>> +	/* Protect list and virtio queue operations */
> >>>> +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> >>>
> >>> The section below seems a pretty big one to protect behind a spin lock. 
> >>>
> >>
> >> How can I split it? 
> >>
> > 
> > Question here is: what needs to be protected? As far as I can tell, the
> > only entity needing some kind of locking here is the queue, while both
> > ida_* and tx_inflight operations are already covered (the former by
> > design [1], the second because it's implemented using an atomic.
> > 
> > If I'm not wrong (but I might be, so please double check) this can be
> > limited to:
> > 
> > 	/* Protect queue operations */
> > 	scoped_guard(spinlock_irqsave, &priv->tx_lock)
> > 		err = virtqueue_add_sgs(vq, sgs, 1u, 1u, can_tx_msg, GFP_ATOMIC);
> > 
> > 
> > Maybe the whole locking pattern is a leftover from a previous version, 
> > where a list of TX messages was kept?
> 
> 1.) There is virtqueue_get_buf() => virtqueue_get_buf_ctx() and there is a comment 
> " * Caller must ensure we don't call this with other virtqueue
>   * operations at the same time (except where noted)."
> 
> Are we safe when at the same time in virtio_can_start_xmit() a queue operation is done in parallel?
> 
> Locking may or may not be necessary here. I cannot tell in this moment.
> 
> 2.) There was once a "list_del(&can_tx_msg->list);" in the code here. 
> 
> When in virtio_can_start_xmit() at the same time a list_add_tail() or a list_del() would have been executed we had a garbled linked list.
> 
> The linked list now does not exist any more in the newer code base.
> 
> => could be that the lock is not needed any more at all
> => could be that we have to protect only the queue operations now and this would shorten the locking time and simplify the code
> 
> >>>> +
> >>>> +	can_tx_msg = virtqueue_get_buf(vq, &len);
> >>>> +	if (!can_tx_msg) {
> >>>> +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> >>>> +		return 0; /* No more data */
> >>>> +	}
> >>>> +
> >>>> +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> >>>> +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> >>>> +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> >>>> +	} else {
> >>>> +		result = can_tx_msg->tx_in.result;
> >>>> +	}
> >>>> +
> > 
> > (snip)
> > 
> 
> >>>> +	if (!priv->rpkt) {
> >>>> +		virtio_can_del_vq(vdev);
> >>>> +		goto on_failure;
> >>>> +	}
> >>>> +	virtio_can_populate_rx_vq(vdev);
> >>>> +
> >>>> +	err = register_virtio_can_dev(dev);
> >>>> +	if (err) {
> >>>> +		virtio_can_del_vq(vdev);
> >>>> +		goto on_failure;
> >>>> +	}
> >>>> +
> >>>> +	napi_enable(&priv->napi);
> >>>> +	napi_enable(&priv->napi_tx);
> >>>
> >>> Most of the existing drivers enable the napi(s) during the open() phase,
> >>> IIUC to avoid scheduling napi operations for devices that might never
> >>> get used. But here maybe there is a specific reason to do it this way?
> >>>
> >>
> >> I do not have idea. I moved to open() and something stopped to work. I
> >> am investigating it.
> >>
> > 
> > On a second thought, it may be wiser to have the napis enabled on probe,
> > to drop the incoming messages even when the interface is brought down.
> 
> It's a while since then but I wanted to drop messages not having lurking a 3 hours old cooling water temperature in some virtio message buffer being misinterpreted as an actual value. May have the disadvantage to cause load when the driver is not open-ed. But I see you also thought about 3 hours old outdated values now which may cause trouble.
> 

I see, so if napis is enabled on probe(), messages would be dropped
until open() thus preventing old messages to be read a new ones. Am I
right? In that case, I would move back the enablement of napis to probe().


> > 
> > (last snip)
> > 
> > 
> > While stress testing this, I noticed that flooding the virtio-can
> > interface with packets leads to an hang of the interface itself.
> > I am seeing this issuing, at host side:
> > 
> > 	while true; do cansend can0 123#00; done
> > 
> > with:
> > 
> >  - QEMU: the tip of the master branch plus [2]
> >  - vhost-device: the tip of the main branch
> > 
> > and the following QEMU invocation:
> > 
> > qemu-system-x86_64 -serial mon:stdio \
> >     -m 2G -smp 2 \
> >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> >     -append "loglevel=7 console=ttyS0" \
> >     -machine memory-backend=pc.ram \
> >     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
> >     -chardev socket,id=can0,path=/tmp/sock-can0 \
> >     -device vhost-user-can-pci,chardev=can0
> 
> I had this problem when I enabled the experimental feature late TX ACK on the device side instead of immediately sending the TX ack early even when the CAN message had not yet been transmitted on the (physical) bus. In this case I relied that no ACK message (own sent message received) was lost otherwise I ran out of messages in the transmit queue everything waiting until doomsday for ACKs which would never come.
> 
> The problem was that somewhere in the Linux stack those acknowledgements got lost under heavy load on the device side. Workaround was to ack the TX message early (means putting the message immediately back into the used queue when received) in the virtio device. But this is a device thing, the device MUST put back ALL messages back into the used queue not forgetting about some under whatever circumstances otherwise the avail queue will get empty forever.
> 
> Besides that I could do what I want stressing the code and it did not stop. But this code was different from what I see now, and the testing environment was also a different one. 
> 
> > Restarting the interface (i.e.: ip link set down and the up) does not
> > fix the situation.
> > 
> > I'll try to do some more testing during the next days.
> Other than fixing the swapped feature flag values for the next release internally I've had not yet the chance to look deeply into all those changes and really to think about them in depth.
> 
> 

