Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F51308F19
	for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112843; cv=none; b=gc4PsHdr+6f8piTHaCSC2F5ledAqvryyWtnmdDUjxRBIvXwrG2gmlBWvvlghJ+rUdZa1RgpES90jw2FcgKFJTByFxaa1G3vlBrGnneeE85+TaKsV+0obcLikqCQEDrXmx3kaJL1YomNkPpNBmPFBp5mXxpbkin/iV0Vpq+7R1vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112843; c=relaxed/simple;
	bh=RCAYjz6vIOf/R1vbx+PtwnV+PTpqHXlUQYFV+h701Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jUE4SsuoZQBpfWdX1P9O56ZBBNi5PKQH2X0JugUSlZU6yfid1FYyB9pf8Gww3olnGjP8/rvaqiPwi6fPkIyrgDNE3vA/kTXvn3xI4W1zwzNusubrVSHsxBLuvMpoCNUVBjJ26ylT0aNFByk54hmyQ0kykhLq36ucI1qM+iRgDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMpQc78G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMpQc78G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763112839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=36+oyKfeG61oAI4qrJ6KOF+T0ZR3Arugp2HRWWLDhJ4=;
	b=JMpQc78GE17hnwakn+exQU8Yjh+UhdhTxB6IdmlnC4VhEMIV394aYJ0P0HUDwPSG9DdCMi
	9vcYWXTDVe0m3FKr7vMRqvS+A+5JONJIfV1VbLfwIJnD6F93E6xx/AEK8pRrk3ePdmbO79
	5hVeBBQYyG1Qgaa/SEk9Y1u5KHEaQek=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-a_Oowv10PpqzsOSymrHHwQ-1; Fri, 14 Nov 2025 04:33:54 -0500
X-MC-Unique: a_Oowv10PpqzsOSymrHHwQ-1
X-Mimecast-MFC-AGG-ID: a_Oowv10PpqzsOSymrHHwQ_1763112834
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8823c1345c0so25685996d6.2
        for <virtualization@lists.linux.dev>; Fri, 14 Nov 2025 01:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112834; x=1763717634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36+oyKfeG61oAI4qrJ6KOF+T0ZR3Arugp2HRWWLDhJ4=;
        b=VDjLCFUJxD0wiOZWuo6wMc21i79Pr2yI5DJJT03jvPcIJ8G2V/X3UoiQNmlb4nKd4Z
         kAF2gq4009McSTYqF6S8oA/LGTXagp1ZX5wuGDcpr6TVRt8ux+FzsHixcLQxqJ+gVBnd
         suyDaM3w9Blvt6QaFwf9Y7GeHnZ1MkukzRxLQRNm3mKmNGkMaQ07CSWuq1gSlSprS/k8
         peckboED9OIT07PzJDD8LsBA4RaV/BIY/lG+df2UTyrnvd41L4BmNES/rt8h/IiQJNgU
         bBUd0XyPaFGTX04R023e+DVDycDUlgkxibZ8hrIckeNp7m1m2YSmZTw7BLIocxjtr7HR
         JIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUABfqLKbpy/M0J7yhdO7cdOAarqQwQ8pINw2O1pk5AqdyBDgW+F05JbVvlcHSC74Vrtzbh0J+aKTH1wlXz+A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+FiMJyCajmh5iyz2fQKh/IIR8g7XtQPihbranhj47ZSjlT2tu
	ObK6ydsHL71OpnQF31h/aKELaQT72mwT4f2G9T3KBMw0FCl/9H6kVliDFpIEYBsc0NkGa3cTbpK
	W5ZL7bMbGDw8jButuMdUWPfqDEKP6MXFQXCBOSTHX9Zde/U6jOT7Fl2T9Vm7jqbivqQ68
X-Gm-Gg: ASbGncsnCJICtgweZGxEIPdFrTbijlEytXzGr/ojBOTUH2Ns8YwZIBHuUAZqhBl82Lp
	PNaVKngRWeqRTkNI/WAdy17R5Cj01MBlAz17/Snr5hZgZrcMT2omwjLq+f5XyHi2VYNk+1BfVBQ
	YhIRlNckcJ4lbO91MLixN9eSTGnp2e8fGceFdRzbjtNqucCbOEIPN5PyUYjy74WS1CFpgxVIiTf
	kgf6BbZx/xQR0tk4tTidxMTuoMCNU2Csk28l+vcvHeNJRAKUVaKGCTXgbHJ99eJJI1qK9uvD1XS
	cuf0mXSdFVeiC6cNMSilIak4grsYgGxV2d0FNXT9gzZ0SGayh+ANBMg2oFu/89dZR604EQeAmUE
	whOLTKh6QwV/eSLaTiQj0qAyXHZPaQ7JiGwCfF+UVATtzp5Iaqyg=
X-Received: by 2002:a05:6214:d05:b0:880:48bc:e08f with SMTP id 6a1803df08f44-88292686794mr35504826d6.40.1763112833694;
        Fri, 14 Nov 2025 01:33:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjHrJ9Ml1IttqxcPVYY9SH7uhe2Rph9BOIsWj75UI9bX73556O1rec437jZYFpPhU03rOjlA==
X-Received: by 2002:a05:6214:d05:b0:880:48bc:e08f with SMTP id 6a1803df08f44-88292686794mr35504466d6.40.1763112833200;
        Fri, 14 Nov 2025 01:33:53 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865342c4sm27689996d6.28.2025.11.14.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:33:51 -0800 (PST)
Date: Fri, 14 Nov 2025 10:33:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 06/14] vsock/loopback: add netns support
Message-ID: <kwgjzpxxqpkgwafydp65vlj6jlf7h7kcnhwgtwrrhzp2qtgkkq@z3xfl26ejspl>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>
 <g6bxp6hketbjrddzni2ln37gsezqvxbu2orheorzh7fs66roll@hhcrgsos3ui3>
 <aRTRhk/ok06YKTEu@devvm11784.nha0.facebook.com>
 <g5dcyor4aryvtcnqxm5aekldbettetlmog3c7sj7sjx3yp2pgy@hcpxyubied2n>
 <aRYivEKsa44u5Mh+@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aRYivEKsa44u5Mh+@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tAUnOwjezxQ2Uq4_Mcuwkt_YPy3u_C02JRawqqBqXDQ_1763112834
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 13, 2025 at 10:26:04AM -0800, Bobby Eshleman wrote:
>On Thu, Nov 13, 2025 at 04:24:44PM +0100, Stefano Garzarella wrote:
>> On Wed, Nov 12, 2025 at 10:27:18AM -0800, Bobby Eshleman wrote:
>> > On Wed, Nov 12, 2025 at 03:19:47PM +0100, Stefano Garzarella wrote:
>> > > On Tue, Nov 11, 2025 at 10:54:48PM -0800, Bobby Eshleman wrote:
>> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> > > >
>> > > > Add NS support to vsock loopback. Sockets in a global mode netns
>> > > > communicate with each other, regardless of namespace. Sockets in a local
>> > > > mode netns may only communicate with other sockets within the same
>> > > > namespace.
>> > > >
>> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>[...]
>
>> > > > @@ -131,7 +136,41 @@ static void vsock_loopback_work(struct work_struct *work)
>> > > > 		 */
>> > > > 		virtio_transport_consume_skb_sent(skb, false);
>> > > > 		virtio_transport_deliver_tap_pkt(skb);
>> > > > -		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
>> > > > +
>> > > > +		/* In the case of virtio_transport_reset_no_sock(), the skb
>> > > > +		 * does not hold a reference on the socket, and so does not
>> > > > +		 * transitively hold a reference on the net.
>> > > > +		 *
>> > > > +		 * There is an ABA race condition in this sequence:
>> > > > +		 * 1. the sender sends a packet
>> > > > +		 * 2. worker calls virtio_transport_recv_pkt(), using the
>> > > > +		 *    sender's net
>> > > > +		 * 3. virtio_transport_recv_pkt() uses t->send_pkt() passing the
>> > > > +		 *    sender's net
>> > > > +		 * 4. virtio_transport_recv_pkt() free's the skb, dropping the
>> > > > +		 *    reference to the socket
>> > > > +		 * 5. the socket closes, frees its reference to the net
>> > > > +		 * 6. Finally, the worker for the second t->send_pkt() call
>> > > > +		 *    processes the skb, and uses the now stale net pointer for
>> > > > +		 *    socket lookups.
>> > > > +		 *
>> > > > +		 * To prevent this, we acquire a net reference in vsock_loopback_send_pkt()
>> > > > +		 * and hold it until virtio_transport_recv_pkt() completes.
>> > > > +		 *
>> > > > +		 * Additionally, we must grab a reference on the skb before
>> > > > +		 * calling virtio_transport_recv_pkt() to prevent it from
>> > > > +		 * freeing the skb before we have a chance to release the net.
>> > > > +		 */
>> > > > +		net_mode = virtio_vsock_skb_net_mode(skb);
>> > > > +		net = virtio_vsock_skb_net(skb);
>> > >
>> > > Wait, we are adding those just for loopback (in theory used only for
>> > > testing/debugging)? And only to support virtio_transport_reset_no_sock() use
>> > > case?
>> >
>> > Yes, exactly, only loopback + reset_no_sock(). The issue doesn't exist
>> > for vhost-vsock because vhost_vsock holds a net reference, and it
>> > doesn't exist for non-reset_no_sock calls because after looking up the
>> > socket we transfer skb ownership to it, which holds down the skb -> sk ->
>> > net reference chain.
>> >
>> > >
>> > > Honestly I don't like this, do we have any alternative?
>> > >
>> > > I'll also try to think something else.
>> > >
>> > > Stefano
>> >
>> >
>> > I've been thinking about this all morning... maybe
>> > we can do something like this:
>> >
>> > ```
>> >
>> > virtio_transport_recv_pkt(...,  struct sock *reply_sk) {... }
>> >
>> > virtio_transport_reset_no_sock(..., reply_sk)
>> > {
>> > 	if (reply_sk)
>> > 		skb_set_owner_sk_safe(reply, reply_sk)
>>
>> Interesting, but what about if we call skb_set_owner_sk_safe() in
>> vsock_loopback.c just before calling virtio_transport_recv_pkt() for every
>> skb?
>
>I think the issue with this is that at the time vsock_loopback calls
>virtio_transport_recv_pkt() the reply skb hasn't yet been allocated by
>virtio_transport_reset_no_sock() and we can't wait for it to return
>because the original skb may be freed by then.

Right!

>
>We might be able to keep it all in vsock_loopback if we removed the need
>to use the original skb or sk by just using the net. But to do that we
>would need to add a netns_tracker per net somewhere. I guess that would
>end up in a list or hashmap in struct vsock_loopback.
>
>Another option that does simplify a little, but unfortunately still doesn't keep
>everything in loopback:
>
>@@ -1205,7 +1205,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 	if (!reply)
> 		return -ENOMEM;
>
>-	return t->send_pkt(reply, net, net_mode);
>+	return t->send_pkt(reply, net, net_mode, skb->sk);
> }
>
>@@ -27,11 +27,16 @@ static u32 vsock_loopback_get_local_cid(void)
> }
>
> static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
>-				   enum vsock_net_mode net_mode)
>+				   enum vsock_net_mode net_mode,
>+				   struct sock *rst_owner)
> {
> 	struct vsock_loopback *vsock = &the_vsock_loopback;
> 	int len = skb->len;
>
>+	if (!skb->sk && rst_owner)
>+		WARN_ONCE(!skb_set_owner_sk_safe(skb, rst_owner),
>+			  "loopback socket has sk_refcnt == 0\n");
>+

This doesn't seem too bad IMO, but at this point, why we can't do that
in virtio_transport_reset_no_sock() for any kind of transport?

I mean, in any case the RST packet should be handled by the same net of 
the "sender", no?

At this point, can we just put the `vsk` of the sender in the `info` and 
virtio_transport_alloc_skb() will already do that.

WDYT?
Am I missing something?

> 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
> 	queue_work(vsock->workqueue, &vsock->pkt_work);
>
>>
>> Maybe we should refactor a bit virtio_transport_recv_pkt() e.g. moving
>> `skb_set_owner_sk_safe()` to be sure it's called only when we are sure it's
>> the right socket (e.g. after checking SOCK_DONE).
>>
>> WDYT?
>
>I agree, it is called a little prematurely.

Yep, but I'll leave this out for now :-)

Thanks,
Stefano

