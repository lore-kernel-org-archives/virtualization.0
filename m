Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9A317146
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481159; cv=none; b=dIeusjwNZnkWTBb8sanMwNmgjykfpaa8d95awtcqJgIaz5/v4mGUK7NAIRHfdAl8VsF10X907el2aNkPX7sgTrfbxfEqaUHLAGpS+vSsoxXN+I2SUYuVn9i2fsjSkAFSaFOkgqRetXXQD2hXIhw2xoy0ASnuD5i+ah6HrtEqsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481159; c=relaxed/simple;
	bh=5s4Eh05ziMMWq72814hetK2sQYeQqsihE2/3kPLb7uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nKjp6EhzBVw7D3qJ5qHhRvTTcEr/ptmSSYJ0ueGGpGfcBGE0zUczzKCaa3RQV5phWNSXj9LH8wfVn7fmA4dxF1nG8Kdyc6scIMwO8Nh3KRMkoI1ny8kWbHNN0ZUeS/QKmkulqgW/Y6NvFE3nlZyAPU8OMpp9H15Z/pDJ4GntH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzZSAJ8U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzZSAJ8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772481157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaGhSybAE4JXA1WjpWM9oOlkMHCgTkwYOUSZuMrCDp0=;
	b=gzZSAJ8UePNOnsf22wlc8j1UxGPKm8H6CYCfx0uLPrpI6I1FE8A3gu6bn/yd7bL92o6ZwT
	InhC87dU0rvMHweifg0RB/t+CAaVckdZ2uKBda4r5IS+IoTIps19E3G9PHYnCQrS5miNAs
	YPIv76CuKPhaDo/ZiLdzNQUruCIk/GU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-OIyWreDQOPWHVhqOANcrLQ-1; Mon, 02 Mar 2026 14:52:34 -0500
X-MC-Unique: OIyWreDQOPWHVhqOANcrLQ-1
X-Mimecast-MFC-AGG-ID: OIyWreDQOPWHVhqOANcrLQ_1772481153
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43996fb9cf9so4461717f8f.1
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 11:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481153; x=1773085953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RaGhSybAE4JXA1WjpWM9oOlkMHCgTkwYOUSZuMrCDp0=;
        b=qUpnab7psAIQ2KLrlJvwKFmstUt1Deh/ufEb1HscB8OHrMCRIbiozN/Rj7q4eyB4QB
         Un7HI+zk4p3GpZwj46XVCHtNNGnlMlRNzybRTbWeEzMleqKFsY+uDfNbhEVKxyJS3wEH
         BqCL8OOSESleFk5+bZ3/8lE+2xcmzl79P+4CxgtYKSuWvaKiATdSrCeesQhdOmHq5ndq
         nhfhGuf8fjY8Wg1I4mbQThtoPe8II1BJgsvWRurVhzNKgy6c/PjVFIEWQgKf3Tcij5Xv
         Esg23S7Pf+XCefuWPdt9HoHEzYMPBQCygAsjGGDuedhTdX8II4OOol9tja6EDsWfl05d
         WmBw==
X-Forwarded-Encrypted: i=1; AJvYcCXTwKf/bs0uV2Nqw7RPC6ahBUInS1pnK4GcG2tcKY3X+55act63KhyVbLB24cj3wVo8ugohSyfn/g1hf5PK9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTiOE5Q9ElINK7eb+brYqfZ6bXed/zY5ByvDG4YloFN2cdyU/s
	/ml/0ceXe8Dz+x0BX+2OqCZKAr6BKm41e5pCi1f0ReK8GIjoIfpezlYKudtK7C/h/I3iFt5261S
	t4aFpbHoeeURPStbuMBLENSnoVV6vrLUTc+8JOaKhV9UzrVLL1Cdf8zCuSlDqBf5/b9is
X-Gm-Gg: ATEYQzwrxiOiXkQSknw0DEqX38DF9k/WmI6aLzCQCTFmEH7hIdtTwj+I7iCmJtE4wyk
	er85H5Ud4wQuKA4zyr+fBe4Ep5QMDz8X2A/eYT+wQPMy9zeBkZzP+WqiaHmHto1/EynETdZKeEo
	qZyAKIgNUF7MNlw8w6tPKKkoNBqvBafiRb2XaW2hNG7Zikhkq+DVtvnWa+O6IoRIXiJM1BmMhml
	UOWRPUw4aaD16BUfQKYNuwA4ZKZfL7jqX7X92p/DsrTRd6/voExjGfKtvqwkpMHe0hVmcJi/HC6
	eezIQXjxz1Lm1x5vM+lsw7aAHybCyQ/OlCKPfrI6iMHns///u8r5KhaQoSkGhLSBfgfmNub+r7V
	mEwjaU7TXOSggx7Z0jYe4DK6EQ80+vRITHMwdmIIeaN8hWw==
X-Received: by 2002:a05:6000:26c5:b0:439:ba69:101d with SMTP id ffacd0b85a97d-439ba6912e2mr6085918f8f.1.1772481152607;
        Mon, 02 Mar 2026 11:52:32 -0800 (PST)
X-Received: by 2002:a05:6000:26c5:b0:439:ba69:101d with SMTP id ffacd0b85a97d-439ba6912e2mr6085851f8f.1.1772481152050;
        Mon, 02 Mar 2026 11:52:32 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c70ed47sm32278553f8f.11.2026.03.02.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:52:31 -0800 (PST)
Date: Mon, 2 Mar 2026 14:52:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, nh-open-source@amazon.com
Subject: Re: [PATCH] vsock: Enable H2G override
Message-ID: <20260302145121-mutt-send-email-mst@kernel.org>
References: <20260302104138.77555-1-graf@amazon.com>
 <aaVrsXMmULivV4Se@sgarzare-redhat>
 <aaV80wWlpjEtYCQJ@sgarzare-redhat>
 <17d63837-6028-475a-90df-6966329a0fc2@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <17d63837-6028-475a-90df-6966329a0fc2@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qXBSd2MKvPrlLd-t66UDPxrAkRpdgIq9sLINnSoSy3Y_1772481153
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 02, 2026 at 04:48:33PM +0100, Alexander Graf wrote:
> 
> On 02.03.26 13:06, Stefano Garzarella wrote:
> > CCing Bryan, Vishnu, and Broadcom list.
> > 
> > On Mon, Mar 02, 2026 at 12:47:05PM +0100, Stefano Garzarella wrote:
> > > 
> > > Please target net-next tree for this new feature.
> > > 
> > > On Mon, Mar 02, 2026 at 10:41:38AM +0000, Alexander Graf wrote:
> > > > Vsock maintains a single CID number space which can be used to
> > > > communicate to the host (G2H) or to a child-VM (H2G). The current logic
> > > > trivially assumes that G2H is only relevant for CID <= 2 because these
> > > > target the hypervisor.  However, in environments like Nitro
> > > > Enclaves, an
> > > > instance that hosts vhost_vsock powered VMs may still want to
> > > > communicate
> > > > to Enclaves that are reachable at higher CIDs through virtio-vsock-pci.
> > > > 
> > > > That means that for CID > 2, we really want an overlay. By default, all
> > > > CIDs are owned by the hypervisor. But if vhost registers a CID,
> > > > it takes
> > > > precedence.  Implement that logic. Vhost already knows which CIDs it
> > > > supports anyway.
> > > > 
> > > > With this logic, I can run a Nitro Enclave as well as a nested VM with
> > > > vhost-vsock support in parallel, with the parent instance able to
> > > > communicate to both simultaneously.
> > > 
> > > I honestly don't understand why VMADDR_FLAG_TO_HOST (added
> > > specifically for Nitro IIRC) isn't enough for this scenario and we
> > > have to add this change.  Can you elaborate a bit more about the
> > > relationship between this change and VMADDR_FLAG_TO_HOST we added?
> 
> 
> The main problem I have with VMADDR_FLAG_TO_HOST for connect() is that it
> punts the complexity to the user. Instead of a single CID address space, you
> now effectively create 2 spaces: One for TO_HOST (needs a flag) and one for
> TO_GUEST (no flag). But every user space tool needs to learn about this
> flag. That may work for super special-case applications. But propagating
> that all the way into socat, iperf, etc etc? It's just creating friction.
> 
> IMHO the most natural experience is to have a single CID space, potentially
> manually segmented by launching VMs of one kind within a certain range.
> 
> At the end of the day, the host vs guest problem is super similar to a
> routing table.

If this is what's desired, some bits could be stolen from the CID
to specify the destination type. Would that address the issue?
Just a thought.



> 
> > > 
> > > > 
> > > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > > > ---
> > > > drivers/vhost/vsock.c    | 11 +++++++++++
> > > > include/net/af_vsock.h   |  3 +++
> > > > net/vmw_vsock/af_vsock.c |  3 +++
> > > > 3 files changed, 17 insertions(+)
> > > > 
> > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > index 054f7a718f50..223da817e305 100644
> > > > --- a/drivers/vhost/vsock.c
> > > > +++ b/drivers/vhost/vsock.c
> > > > @@ -91,6 +91,16 @@ static struct vhost_vsock
> > > > *vhost_vsock_get(u32 guest_cid, struct net *net)
> > > >     return NULL;
> > > > }
> > > > 
> > > > +static bool vhost_transport_has_cid(u32 cid)
> > > > +{
> > > > +    bool found;
> > > > +
> > > > +    rcu_read_lock();
> > > > +    found = vhost_vsock_get(cid) != NULL;
> > > 
> > > We recently added namespaces support that changed vhost_vsock_get()
> > > params. This is also in net tree now and in Linus' tree, so not sure
> > > where this patch is based, but this needs to be rebased since it is
> > > not building:
> > > 
> > > ../drivers/vhost/vsock.c: In function ‘vhost_transport_has_cid’:
> > > ../drivers/vhost/vsock.c:99:17: error: too few arguments to function
> > > ‘vhost_vsock_get’; expected 2, have 1
> > >   99 |         found = vhost_vsock_get(cid) != NULL;
> > >      |                 ^~~~~~~~~~~~~~~
> > > ../drivers/vhost/vsock.c:74:28: note: declared here
> > >   74 | static struct vhost_vsock *vhost_vsock_get(u32 guest_cid,
> > > struct net *net)
> > >      |
> 
> 
> D'oh. Sorry, I built this on 6.19 and only realized after the send that
> namespace support got in. Will fix up for v2.
> 
> 
> > > 
> > > > +    rcu_read_unlock();
> > > > +    return found;
> > > > +}
> > > > +
> > > > static void
> > > > vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> > > >                 struct vhost_virtqueue *vq)
> > > > @@ -424,6 +434,7 @@ static struct virtio_transport vhost_transport = {
> > > >         .module                   = THIS_MODULE,
> > > > 
> > > >         .get_local_cid            = vhost_transport_get_local_cid,
> > > > +        .has_cid                  = vhost_transport_has_cid,
> > > > 
> > > >         .init                     = virtio_transport_do_socket_init,
> > > >         .destruct                 = virtio_transport_destruct,
> > > > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > > > index 533d8e75f7bb..4cdcb72f9765 100644
> > > > --- a/include/net/af_vsock.h
> > > > +++ b/include/net/af_vsock.h
> > > > @@ -179,6 +179,9 @@ struct vsock_transport {
> > > >     /* Addressing. */
> > > >     u32 (*get_local_cid)(void);
> > > > 
> > > > +    /* Check if this transport serves a specific remote CID. */
> > > > +    bool (*has_cid)(u32 cid);
> > > 
> > > What about "has_remote_cid" ?
> > > 
> > > > +
> > > >     /* Read a single skb */
> > > >     int (*read_skb)(struct vsock_sock *, skb_read_actor_t);
> > > > 
> > > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > > > index 2f7d94d682cb..8b34b264b246 100644
> > > > --- a/net/vmw_vsock/af_vsock.c
> > > > +++ b/net/vmw_vsock/af_vsock.c
> > > > @@ -584,6 +584,9 @@ int vsock_assign_transport(struct vsock_sock
> > > > *vsk, struct vsock_sock *psk)
> > > >         else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
> > > >              (remote_flags & VMADDR_FLAG_TO_HOST))
> > > >             new_transport = transport_g2h;
> > > > +        else if (transport_h2g->has_cid &&
> > > > +             !transport_h2g->has_cid(remote_cid))
> > > > +            new_transport = transport_g2h;
> > > 
> > > We should update the comment on top of this fuction, and maybe also
> > > try to support the other H2G transport (i.e. VMCI).
> > > 
> > > @Bryan @Vishnu can the new has_cid()/has_remote_cid() be supported
> > > by VMCI too?
> > 
> > Oops, I forgot to CC them, now they should be in copy.
> 
> 
> Ack. I can also take a quick look if it's trivial to add.
> 
> 
> Alex
> 
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597

