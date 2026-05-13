Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D9388885
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666593; cv=none; b=dEUznzYaDpY5T+WVSGPbiviJj0pfBVlWb9agFVaXC9ISOSq11Uj+EnYQFK3MWCmbLWv0jntxcFqX2SlPIzPRUP+2zQkKws3VTN+6ctjR3sGyLrT749l7O2HKzHOQbtaSe6Uhcw0PWF0QBvmq2X1mNAansnYQwOd/tAQZ1grgC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666593; c=relaxed/simple;
	bh=Exx69UliEats+vm276UOMHgD4bfAdRTp7+mcrKpptDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qwBHsa4BV2OOuA+tl/V5/TW2NOMbRKq4wnltoILr2dznPTXP0/bOZ9Czg/fJuKYjekxdVcYGyyzxWvd19AG8xdQHe41KuDPCpSH9PIVxMNUaEDhHyBth3dOn5A1POI1Nbpms5l+4WU+8BtyyPXtmxpqn2F1KoO0lXdl/X3sE/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVnq/GLj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVnq/GLj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778666591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzQE32mx93ylvQsX4/nZCp5JUmWcvqaEWi0cOhGyU/Q=;
	b=AVnq/GLjO+v09um3NzOo9W+B33Mh0AG6r22WAz3RauDSh8Bs6GFIVGtTlP4vHLbyFXgAqI
	iPUrepqiF0cO7NTXBOdJpTd6tvKSy04RD4GqoI8//ZR5NLFFxfr84DytIUbgWlrRCl/xxz
	dSZHjONhdEdtmKnqtvo5AfdaSWyJnxU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Ljbl9cHwOn2k3tl9t4qbXQ-1; Wed, 13 May 2026 06:03:09 -0400
X-MC-Unique: Ljbl9cHwOn2k3tl9t4qbXQ-1
X-Mimecast-MFC-AGG-ID: Ljbl9cHwOn2k3tl9t4qbXQ_1778666589
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso56009075e9.0
        for <virtualization@lists.linux.dev>; Wed, 13 May 2026 03:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666588; x=1779271388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzQE32mx93ylvQsX4/nZCp5JUmWcvqaEWi0cOhGyU/Q=;
        b=Cn7jkE+90m7ePcqLM8LKTGNYc5330qwPqWQB1wq86vu1t5IlM8p1gtvXDVYt6d+gzg
         jnqNVGIClLmpwGFFqGVQh5DVZp9p427v6nfNtMTPDF+lJ3/p2KR3NsoNPETWWN/OrJlV
         nOn0Iesmyz/faA2rPXq+vFvCnPXbauDP/hMpPWDlCv8p5o3t3FZhLhGGt7PCWBuTYF5V
         0JFG4+drABcPOCIYNy//WR5a1l3+XosIkZJ3D55BC7cMOPY9v7JaT5KAbR6SU7OePY50
         KXcuh1SJCRM8epc7Vdb71rZel3XXzeEOWiqersxGNPfphsJgtATEtqRb6CyK1r4NcWTf
         tJwQ==
X-Forwarded-Encrypted: i=1; AFNElJ92b7M4UqMnAwciRqdG3pxlcjdhwFSI+37hWHzqWes6WTPDXhqkKvU0vJTIVyUVDo2HkGnkp+Fynajcc/j5Kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAKZ3ybtJKcm8lkAmaEZtuEmdEKRB4YH/JAUDlA6PX5tJltrBT
	6HDFaWddNy/R5syk7jvJEz0G4tTEABbYUOFfI451UaWk/1iMZCHCpc7qIgvyt7u4gTePg6p29/V
	Qir4xXqybmojep6GJtNlywi2XUo3elpBisz7Xuo/3yf0YWtN7R9O+LtFONkxzpJPupyGy
X-Gm-Gg: Acq92OEQk8C2vEjO16XoNU9GE8VuTA0TYR+YgumPCaaDGp2bCVLJAq+utoGfcrf+eSD
	9XmrI4A3JD0s4h0NL/1EmxhrYbqpme3zImPf8keIGzYefz8MzPDk9aHnNgip6bpBJ6P3Dao1Oo9
	psuh889LsR/5Vq+LQhsnGsvdIMjbL1JwfNMjQeYNKhOH4iuZe1/NSVnhLuOHl947iLsY4jlVtJz
	XBTkaamXDvuT9K0kBStGDD2qZP8E2igy8XP4AJX7HkvUyYPM26ZRaRGgnc5gqtWQCkxvhTrbywH
	J9Nnz1QlcIm5IjgmmrqoNqLLM5EgjZ+QjEANmhTUJWiRnUfY2Qi4cCp+3M5iCIhHsUxywA49fGq
	5Z6uY98/Cc3iyWV1ceVNlUt4hppNNdYrjPg4kWSTU
X-Received: by 2002:a05:600c:4ed1:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48fc95a5989mr35259025e9.0.1778666588266;
        Wed, 13 May 2026 03:03:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed1:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48fc95a5989mr35258125e9.0.1778666587521;
        Wed, 13 May 2026 03:03:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3e174fsm59587075e9.3.2026.05.13.03.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:03:06 -0700 (PDT)
Date: Wed, 13 May 2026 06:03:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: "sgarzare@redhat.com" <sgarzare@redhat.com>,
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
Message-ID: <20260513060124-mutt-send-email-mst@kernel.org>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
 <agM8cxqUCJNjBDlm@sgarzare-redhat>
 <20260512120019-mutt-send-email-mst@kernel.org>
 <8ae7e443034026eda016322d22da52700e432f09.camel@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8ae7e443034026eda016322d22da52700e432f09.camel@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jYfZUNcOh14MLZ0_ymivuTVf4ACfAm6blirlIbQzt6o_1778666589
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2026 at 09:44:49AM +0000, Polina Vishneva wrote:
> On Tue, 2026-05-12 at 12:02 -0400, Michael S. Tsirkin wrote:
> > On Tue, May 12, 2026 at 05:39:48PM +0200, Stefano Garzarella wrote:
> > > On Tue, May 12, 2026 at 02:32:14PM +0000, Polina Vishneva wrote:
> > > > On Mon, 2026-05-11 at 17:56 +0200, Stefano Garzarella wrote:
> > > > > On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
> > > > > > From: "Denis V. Lunev" <den@openvz.org>
> > > > > > 
> > > > > > When the host initiates an AF_VSOCK connect() to a guest that has not
> > > > > > yet loaded the virtio-vsock transport (i.e. still booting), the caller
> > > > > > blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
> > > > > > vhost_transport_do_send_pkt() silently exits when
> > > > > > vhost_vq_get_backend(vq) returns NULL.
> > > > > 
> > > > > Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?
> > > > 
> > > > It can, but it might be difficult to find a correct timeout.
> > > > 
> > > > And, generally, there's no way to distinguish "the guest hasn't yet initialized
> > > > the vq" from "the guest is up and running, but didn't reply to connect() in
> > > > time". That's exactly what this patch is attempting to fix.
> > > 
> > > Okay, so please mention this in the commit message, I mean why
> > > SO_VM_SOCKETS_CONNECT_TIMEOUT can't really help.
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > If the guest doesn't start listening within this timeout, connect()
> > > > > > returns ETIMEDOUT.
> > > > > > 
> > > > > > This delay is usually pointless and it doesn't well align with our
> > > 
> > > I still don't understand why this is pointless. If an application wants to
> > > wait while sleeping, it can simply increase the timeout long enough to wait
> > > for the VM to start up and use a single `connect()` call, instead of
> > > continuing to try and wasting CPU cycles unnecessarily.
> > > 
> > > Hmm, or maybe not, because the driver will definitely be initialized before
> > > the application that wants to listen on that port, so it will respond that
> > > no one is listening, and the `connect()` call will fail with an `ECONNRESET`
> > > error in any case. Right?
> > > 
> > > If it is the case, is the following line in the commit description correct?
> > > 
> > >     If the guest doesn't start listening within this timeout, connect()
> > >     returns ETIMEDOUT.
> > > 
> > > I mean, also if the application starts to listen within the timeout, I think
> > > the connect() will fail in any case as I pointed out above (this should be
> > > another point in favour of this change)
> > > 
> > > 
> > > BTW, I think we should explain this more clearly both here and briefly in
> > > the code as well.
> > > 
> > > > > > behavior at other initialization stages: for example, if a connection is
> > > > > > attempted when the guest driver is already loaded, but when nothing is
> > > > > > listening yet, it returns ECONNRESET immediately without any wait.
> > > > > > 
> > > > > > Fix this by checking the RX virtqueue backend in
> > > > > > vhost_transport_send_pkt() before queuing. If the backend is NULL,
> > > > > > return -ECONNREFUSED immediately.
> > > > > > 
> > > > > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > > > > Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > > > > Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
> > > > > > ---
> > > > > > drivers/vhost/vsock.c | 10 ++++++++++
> > > > > > 1 file changed, 10 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > > > > index 1d8ec6bed53e..a3f218292c3a 100644
> > > > > > --- a/drivers/vhost/vsock.c
> > > > > > +++ b/drivers/vhost/vsock.c
> > > > > > @@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> > > > > > 		return -ENODEV;
> > > > > > 	}
> > > > > > 
> > > > > > +	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
> > > > > > +	 * private_data without vq->mutex is deliberate: even if the backend becomes
> > > > > > +	 * NULL right after that check, do_send_pkt() checks it under the mutex.
> > > > > > +	 */
> > > > > > +	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data)))
> > > > > 
> > > > > Why not using vhost_vq_get_backend() ?
> > > > 
> > > > Because it locks the mutex, which is slow and unacceptable in this hot
> > > > path.
> > > 
> > > ehm, sorry, which mutex are you talking about?
> > > 
> > > I see just a comment about the mutex to be acquired by the caller, but I
> > > don't see any lock there.
> > > 
> > > > 
> > > > > 
> > > > > Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?
> > > > 
> > > > It's racy, but as described here in the comment and in the commit message,
> > > > any possible race outcome is covered by the subsequent checks.
> > > 
> > > Okay, so what is the point to call READ_ONCE()?
> > > 
> > > > 
> > > > > > {
> > > > > > +		rcu_read_unlock();
> > > > > > +		kfree_skb(skb);
> > > > > > +		return -ECONNREFUSED;
> > > > > 
> > > > > This is a generic send_pkt, is it okay to return ECONNREFUSED in any
> > > > > case?
> > > > 
> > > > EHOSTUNREACH would probably be better.
> > > > All the current send_pkt functions only return ENODEV, but it has different
> > > > semantics: they mean that the local device isn't yet ready, while there we're
> > > > dealing with the opposite end not being ready.
> > > 
> > > In the AF_VSOCK prespective, I see ENODEV like the transport is not ready,
> > > so I think it can eventually fit here too, but also EHOSTUNREACH is fine,
> > > for sure better than ECONNREFUSED.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > I think it's worth trying to do the same thing with e.g. TCP
> > and see what error, if any, we get. Match that.
> 
> This case is not directly applicable to TCP: in TCP, there's no out-of-band way
> to detect the "host up, but not initialized yet and not ready for connections"
> state: this could theoretically be ENOPROTOOPT, but no real TCP stack implement
> this, because replying with ICMP_PROT_UNREACH requires a TCP stack, which is
> exactly the thing that isn't up.
> 
> So, in real world, a similar situation with TCP would result in ETIMEDOUT.

Then it just might be best to keep the current behaviour which seems
to match that pretty closely?


> > 
> > 
> > > > 
> > > > Best regards, Polina.
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Stefano
> > > > > 
> > > > > > +	}
> > > > > > +
> > > > > > 	if (virtio_vsock_skb_reply(skb))
> > > > > > 		atomic_inc(&vsock->queued_replies);
> > > > > > 
> > > > > > 
> > > > > > base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
> > > > > > --
> > > > > > 2.53.0
> > > > > > 

