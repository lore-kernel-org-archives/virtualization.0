Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDC32F49EB
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766099261; cv=pass; b=oNxH7WUgO8R2RW8Qq96mGKlMWO9+YjyAFQjfg8JGuV8s+XB5rw+EhYD3G6szQeM0OlJyi18NDZdwho2cFgze2AwZJ6/lzQChtzIxElX9sUnyyTOxUOeLI2ewsRYLd1wapjTwCca/BeQX6LLhfEpfyv0vfVLEaF8UE3uJjp3G0pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766099261; c=relaxed/simple;
	bh=WIrquFek2qwGJZJw/uuDm3s/AhluUWirf651teSSguk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBFUlFGmSwZCUeuy4M9a+4PmR7EzEBtPVndxV4tB/NFAuH4m5ZE/s43Mplh0uCBzHjQ1EHptbHr77QhDftmoYTWNlKCqmexC4DlualphvqjQmXInNnvkc0kTCZ6MWT7Ltpi8m0qbr7wo59Pp8LrbOyIPYK4QvlBB+SdNJHkvR4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=bq6O6xh3; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=O1DCjK9Y; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="bq6O6xh3";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="O1DCjK9Y"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-1fw8.prod.antispam.mailspamprotection.com; s=arckey; t=1766099258;
	 b=iuRkvEapv+mqj+dHM55T7m9404juSnSr2pZQp2mYt96N0JMxUIzApjiMmX+zyiRSnRSOSKaqbW
	  U/zFrCoTeqsDRfuEXCUKvyrTcB2QmV9wZMiVjl0Au1vc3BSxUWDSNQ1iPrl++X3IMFmw74HWZC
	  o9UOwTdfHkF7FogUWpk9RA8IwEG+HOoEH4tFqNNuYXCYhw4CgQocML0EhXEEs/Q9VD+EdvaBhz
	  XD9ExD7FLAew7eX8boVxxkfnXcNHzc3tZbr0M4bAzGX8LGq/iNEPljnL+5ORa+tRquPwbuGwd/
	  faEiyQ0CbAT2jCvzxHRZ4qVVEm3d6K0I4OJ4w7qyQAXvwA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-1fw8.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-1fw8.prod.antispam.mailspamprotection.com; s=arckey; t=1766099258;
	bh=WIrquFek2qwGJZJw/uuDm3s/AhluUWirf651teSSguk=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=uvJRfMdvklxnvhW8WQkOllG7h5Hod2Kt/3bbGEcWO9yB7Gngsbo+3W8NBGFImkVpxwROQIa9hN
	  si0AlOFouy4LhaLNQW9eQ8YNMVrSCST36rKBt3f2eeQesGYNwXMcFU731OHh0JMbJTDsfdmrMk
	  nsvaNgqbF80fSzREpFY9DdtSbdq9hXrVinx0XfnknmUMqtxWxEd3ds9uXMTys54BSlYUM+USN5
	  c+tLNizefSLjEyEZpgdDgbrsWw5friV4dtiOqyjxUADnZe2V3A+NObDGX0N4xM/zfO9n4lSHzt
	  gDTadLnDgrbQdVafKh75dJgdlfGDRIAmcc2m18wJm1HriQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=9eiwpUNfhbsf8LRovY3H100lMJHv4CMAoY/xU9rzgm4=; b=bq6O6xh3XdXIAp03zGItHilxR7
	MXal4062aLGedyCTT+KW6b2NWfZKgmXPzNOQYj4A/geI27j3ZASqNVb0ZwG01MRkZPBiTPOwdq+Ki
	A6Zji7ObNUtuK64Q+HklvgfohVUXHKRinYk0vir38Vt6DREKaW3j0HbeaC5lTM4PEMpk=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-1fw8.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vWN5p-00000006FtW-3hS9
	for virtualization@lists.linux.dev;
	Thu, 18 Dec 2025 23:07:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=9eiwpUNfhbsf8LRovY3H100lMJHv4CMAoY/xU9rzgm4=; b=O1DCjK9YDTvL21r+OyXSOk+DaW
	YvLnvSzzRTOLEvhLfXGyTo2F5S7ZyavYHans8W3HKsacal53ZErT9+Em4S09opJj/QiINbycIrPJz
	sWtX15/oIMsn9H9MVOHRNzXdsoS1Vz9k1n4FC66Sg/kxjXmizGGPThjR0B/lxtQz865c=;
Received: from [95.248.141.113] (port=64540 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vWN5c-00000000LPF-2lUb;
	Thu, 18 Dec 2025 23:07:20 +0000
Date: Fri, 19 Dec 2025 00:07:18 +0100
From: Francesco Valla <francesco@valla.it>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
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
Message-ID: <aUSJJtRNOJTohjCS@bywater>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c5df0c-48d1-4d3a-8f25-8249b93c9b60@oss.qualcomm.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 9abe5d8abaeccfd48508ead1037e8c45
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vWN5p-00000006FtW-3hS9-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-1fw8.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello Harald,

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

I *think* we can restrict the locking to virtqueue_ operations; in this
specific case, protecting virtqueue_add_sgs() should be sufficient.

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

I am stil thinking about this. We are sending a ctrl message with
VIRTIO_CAN_SET_CTRL_MODE_STOP, so new frames shouldn't be arriving while
the interface is stopped (i.e., once it is brought down). May it be
sufficient to consume and re-queue all pending vring elements as part of
virtio_can_stop()?

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

After further investigations, this seems to be happening under similar
conditions, i.e., when the backend wants to enqueue a new message into
the vring but finds no available buffer. I still don't understand why it
never recovers, though.

> > Restarting the interface (i.e.: ip link set down and the up) does not
> > fix the situation.
> > 
> > I'll try to do some more testing during the next days.
> Other than fixing the swapped feature flag values for the next release internally I've had not yet the chance to look deeply into all those changes and really to think about them in depth.
> 
> 
> 

Regards,
Francesco

