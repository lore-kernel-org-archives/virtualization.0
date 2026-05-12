Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4989E3C81A9
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601732; cv=none; b=cnlYT72C40wguCkAKWglr/lxe94c6jmKcShXq933esxlsVSDX9aXGLPw4pY9cRsGBuj3n8x0CYf61lXYuz9DqzVPpoWFQZNfOa2t7J68wEmWFl6RxttHGoz2V2cKB3ea2kOzwWKD9gqGRc+Qv+Qloe4/x5HbwqXNEJ7f+Gr6tS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601732; c=relaxed/simple;
	bh=vWr9cfyQCOSfH7IJmIj+myZeDwfb59BivVN4VpsvMRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B5hrilVxOJlOHw/yEprpXwd057v3L4qKMFpmi9m0BJXLq3YWIEwBrFUrzd6E3yjK2dqeiUTdy76h9jhplz44ioiB+RjEHh3K4BiGlBTI0dFeKsF6XbGoNB1KEhazDzV9W1uXSW9FyT6o5AU4B6aAC26bkL+XwhKrhoL/80Dgv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BvEOKVK7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvEOKVK7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778601730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FIUiJKhl00kL6+7DmOinctS+OWNE7gekD3egzsDj+sI=;
	b=BvEOKVK77kFv+y+Pw798HkuBhyHGT5BMinQ0Bpfcs4nCNkvddBWUBrFWz4WB1s/HbUaLkc
	ILkuXXaapO+9WDzUwB5vuw70dwuNSxUBMr2QHf7P+6xA39AueN7VmHcoCJ8fuk+qe1WMiC
	6ext2djKmcGS9SjsBxX6VusNEjS4nEg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-fC3g_QmFOfSeb7WjqKArfw-1; Tue, 12 May 2026 12:02:07 -0400
X-MC-Unique: fC3g_QmFOfSeb7WjqKArfw-1
X-Mimecast-MFC-AGG-ID: fC3g_QmFOfSeb7WjqKArfw_1778601727
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44f56d5523eso4681606f8f.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 09:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601726; x=1779206526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIUiJKhl00kL6+7DmOinctS+OWNE7gekD3egzsDj+sI=;
        b=HnV5VSgD4FZlNXqOPE8SZ5gFmraTtOKOS8Fw25+jEzs49AQMiyTK1Bp2eEBYSHyQle
         zEb4HOmsYTunD8yj5suc73JfvifvQ8Muq36R/1p2+Q9P9/sRx5e1ZYBr/TF5rNrzXAAj
         F/SalNROC4chhwvZ/0YMBSvXgVVcVBXql4qQtZvWUK4DTUVrhce12Ne8h2qonxMRGHTD
         TlbnQtuaXrwXHtrUoBzHnXTsgLYIJSQ9bVOKM/Vv2pKazGN0sDdI+WaaTvCvTOkjcog5
         RDrKnDeMZ6INm8ttjdBZ3jvRnXbzZ2RsX51xHIjx9+A+CE/za8ntSnfOrb7N0ARF9P+d
         fbnA==
X-Forwarded-Encrypted: i=1; AFNElJ8gjqfXposhp9msGSA9Vi5idkMULpPaXM/oRn+8RpMjYnUk/v4oP4gtVhcj9cSdT9shtao+xhbD0Ue/HMkszA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU4hul+o6wpMtVSe9zJCbiNGV2xLsd362EY6sdE1ol4UZBe381
	oCPYlm7fz6+nQvHnwFdihLSHps6wtP01t5O3VobiGw12oSMuxBoN4BTCuHCls5A7jku72BPZzX7
	VFMa7ZGUPacTcLkCJRajtMum3bEeVR/uteLisKNThdGYBNuvCNxcS8m3maQcy/Kb4i21g
X-Gm-Gg: Acq92OHroWuyMBjgPMxvPay/uJL+VvCmt9k2Iwevo8cwqDPTyfL+ZCB3wsqYOkIgkHf
	YBuIEUypsKHTr6GahTeY3iL4ew9Th3FgniFXUko0nfzluBHOKiew5R1MYA6SQ7ymMmBAzNL3AwO
	c1eLH4Owcti0AzZVyX1FUHz7Zbg6wsgpd93HwMlTVJD9lJTJPUBJtPXrSQ9ib9wklEruifjHnIK
	+k/Np2F1F3nWVwIk7LPEwYZpWYNuZrQKyhkGNQm4b0zBJcrNuKJaIUXK3b21VaFn8bVRUf+4HmW
	JQ7HFa2fj6K0eHgEpv8NXUooIutrS2zPdgAs94OhQPOXw+mqox7cIBe8Et1MS+da/jvm0DWUb71
	gfyG5QSRjIR7TuT2/ucU39yK/ULo+CrC95C458k7W
X-Received: by 2002:a05:600c:444f:b0:488:9439:880d with SMTP id 5b1f17b1804b1-48e8fe84e0bmr59315705e9.29.1778601726349;
        Tue, 12 May 2026 09:02:06 -0700 (PDT)
X-Received: by 2002:a05:600c:444f:b0:488:9439:880d with SMTP id 5b1f17b1804b1-48e8fe84e0bmr59313645e9.29.1778601724684;
        Tue, 12 May 2026 09:02:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e64385bsm22758065e9.12.2026.05.12.09.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 09:02:03 -0700 (PDT)
Date: Tue, 12 May 2026 12:02:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Polina Vishneva <polina.vishneva@virtuozzo.com>,
	"den@openvz.org" <den@openvz.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <20260512120019-mutt-send-email-mst@kernel.org>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
 <agM8cxqUCJNjBDlm@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agM8cxqUCJNjBDlm@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SmVaYggkRjLq5JzQYBciPfoTUaE4lICqE592s0K-VGw_1778601727
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 05:39:48PM +0200, Stefano Garzarella wrote:
> On Tue, May 12, 2026 at 02:32:14PM +0000, Polina Vishneva wrote:
> > On Mon, 2026-05-11 at 17:56 +0200, Stefano Garzarella wrote:
> > > On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
> > > > From: "Denis V. Lunev" <den@openvz.org>
> > > >
> > > > When the host initiates an AF_VSOCK connect() to a guest that has not
> > > > yet loaded the virtio-vsock transport (i.e. still booting), the caller
> > > > blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
> > > > vhost_transport_do_send_pkt() silently exits when
> > > > vhost_vq_get_backend(vq) returns NULL.
> > > 
> > > Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?
> > 
> > It can, but it might be difficult to find a correct timeout.
> > 
> > And, generally, there's no way to distinguish "the guest hasn't yet initialized
> > the vq" from "the guest is up and running, but didn't reply to connect() in
> > time". That's exactly what this patch is attempting to fix.
> 
> Okay, so please mention this in the commit message, I mean why
> SO_VM_SOCKETS_CONNECT_TIMEOUT can't really help.
> 
> > 
> > > 
> > > >
> > > > If the guest doesn't start listening within this timeout, connect()
> > > > returns ETIMEDOUT.
> > > >
> > > > This delay is usually pointless and it doesn't well align with our
> 
> I still don't understand why this is pointless. If an application wants to
> wait while sleeping, it can simply increase the timeout long enough to wait
> for the VM to start up and use a single `connect()` call, instead of
> continuing to try and wasting CPU cycles unnecessarily.
> 
> Hmm, or maybe not, because the driver will definitely be initialized before
> the application that wants to listen on that port, so it will respond that
> no one is listening, and the `connect()` call will fail with an `ECONNRESET`
> error in any case. Right?
> 
> If it is the case, is the following line in the commit description correct?
> 
>     If the guest doesn't start listening within this timeout, connect()
>     returns ETIMEDOUT.
> 
> I mean, also if the application starts to listen within the timeout, I think
> the connect() will fail in any case as I pointed out above (this should be
> another point in favour of this change)
> 
> 
> BTW, I think we should explain this more clearly both here and briefly in
> the code as well.
> 
> > > > behavior at other initialization stages: for example, if a connection is
> > > > attempted when the guest driver is already loaded, but when nothing is
> > > > listening yet, it returns ECONNRESET immediately without any wait.
> > > >
> > > > Fix this by checking the RX virtqueue backend in
> > > > vhost_transport_send_pkt() before queuing. If the backend is NULL,
> > > > return -ECONNREFUSED immediately.
> > > >
> > > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > > Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > > Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > > ---
> > > > drivers/vhost/vsock.c | 10 ++++++++++
> > > > 1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > index 1d8ec6bed53e..a3f218292c3a 100644
> > > > --- a/drivers/vhost/vsock.c
> > > > +++ b/drivers/vhost/vsock.c
> > > > @@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> > > > 		return -ENODEV;
> > > > 	}
> > > >
> > > > +	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
> > > > +	 * private_data without vq->mutex is deliberate: even if the backend becomes
> > > > +	 * NULL right after that check, do_send_pkt() checks it under the mutex.
> > > > +	 */
> > > > +	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data)))
> > > 
> > > Why not using vhost_vq_get_backend() ?
> > 
> > Because it locks the mutex, which is slow and unacceptable in this hot
> > path.
> 
> ehm, sorry, which mutex are you talking about?
> 
> I see just a comment about the mutex to be acquired by the caller, but I
> don't see any lock there.
> 
> > 
> > > 
> > > Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?
> > 
> > It's racy, but as described here in the comment and in the commit message,
> > any possible race outcome is covered by the subsequent checks.
> 
> Okay, so what is the point to call READ_ONCE()?
> 
> > 
> > > > {
> > > > +		rcu_read_unlock();
> > > > +		kfree_skb(skb);
> > > > +		return -ECONNREFUSED;
> > > 
> > > This is a generic send_pkt, is it okay to return ECONNREFUSED in any
> > > case?
> > 
> > EHOSTUNREACH would probably be better.
> > All the current send_pkt functions only return ENODEV, but it has different
> > semantics: they mean that the local device isn't yet ready, while there we're
> > dealing with the opposite end not being ready.
> 
> In the AF_VSOCK prespective, I see ENODEV like the transport is not ready,
> so I think it can eventually fit here too, but also EHOSTUNREACH is fine,
> for sure better than ECONNREFUSED.
> 
> Thanks,
> Stefano

I think it's worth trying to do the same thing with e.g. TCP
and see what error, if any, we get. Match that.


> > 
> > Best regards, Polina.
> > 
> > > 
> > > Thanks,
> > > Stefano
> > > 
> > > > +	}
> > > > +
> > > > 	if (virtio_vsock_skb_reply(skb))
> > > > 		atomic_inc(&vsock->queued_replies);
> > > >
> > > >
> > > > base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
> > > > --
> > > > 2.53.0
> > > >

