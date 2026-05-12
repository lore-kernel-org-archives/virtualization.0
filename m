Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2D3AA9E8
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600401; cv=none; b=H1l5iFTEWNewz8RmNUIIP+Oe0vA9A0UB+DqAUzvdBTfz1hvG29KTfMXiI4tUQpNtHokMKpFz6recx2sbm9rKtKoJl/g/N+ycInIsPOJvMh6mFX5JadaP4GTAQMuBcQhdD0k9XA+Qif7zQSYh0ntY3MAG0eCaHpbyOM5c4Q6cgtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600401; c=relaxed/simple;
	bh=KglCHTuNm3x37ez9MagfZauxo69r9aH1IwV/+zMyGZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BZPOgn3mQtSrUGqvQYV72FrXiWbpIsr9XNDDSA0SSAqrhuwFI1VFi5v3pLFEMGVsA/Hph1IkhOrCCFYYQtLsPV9/8DLZhyQXZfg9PsiXDElYOVYZ5IO1nOkio1dA0TNGqvq4uPad+UbHc5v01oWpek3+dkPtD5zEjOusQsCN2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaGFRURu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaGFRURu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778600397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LsdZjZ26kSZ8u0NFCo8P+xxqj1x4mfPz9ccyxXizpko=;
	b=HaGFRURu15nLJFMO1lYQHNUQuPLLZ7nPjaZoWohAFsSGxvbKUlOItQq5zHdY/JhxRtzDRr
	0XudZvAwjMjKjGZQqPCRSTB/DdPH3QYrndxswdT8IE37pyZk3yPpIbHLtI2wr5ljNHzNYQ
	jbcV537sr04hsZKgimRsvnOxaIXa8s8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-sMHpK1QBOTKuL_5ANtKXPw-1; Tue, 12 May 2026 11:39:55 -0400
X-MC-Unique: sMHpK1QBOTKuL_5ANtKXPw-1
X-Mimecast-MFC-AGG-ID: sMHpK1QBOTKuL_5ANtKXPw_1778600394
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso34148035e9.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 08:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600394; x=1779205194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsdZjZ26kSZ8u0NFCo8P+xxqj1x4mfPz9ccyxXizpko=;
        b=pI+6YKsGm+/7tQaZbExNtyE/fGmQtbvrb5CDBW9eQajRqvm13WtQtCZh19ZwN07HF9
         sdafanguioXNYwzI3YSugzW8VBEPeFaCweYLZyf21Ira9dCG2d0Q/vpuSscsKaxh3IfQ
         fblClDPMG43iz/M5LvURrCNdyE9AJwX6YVq4tAs1er4dAs95JsLVMEyDvkUjcfBeI4iD
         l8dPQVv415RyHE7SYneFxrL0icv6H94J4M0ogpoWV/IVX8XVAWZWhvafyoeSCYf+s2Yj
         CRVWPnzIw4ipU5F5MKNa0/iPMwDiC+HWcfbDZCCZCqkwsKPHTA63GmXqzUrKv5xB4IYY
         vnng==
X-Forwarded-Encrypted: i=1; AFNElJ+xS+YfSlkipxc1MroFVyQAvRM+yT8HJi8doB2f+8Paaze5P+V/V27v5ir73YVZGA53OMIx53mwhqSYipff4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwI+WCrZR6S1QsA7OO5Yt9Tbuk0rjEthhmkzJXyg2LguswoL6nk
	VMSc/lX4jP8scWp7DKyHPQbELnSU9Su56G0UN/1uvRGN3hRi/SKB2k/9W6uqbd4Y98CJNDrBbpM
	l2XP+0rMldZB3vb5hENo/BK1tp5DOXU0n0Ny0lMnnB/T4qd85pZfDgG/qED7WG5I0WhkP
X-Gm-Gg: Acq92OEIEZwZxxNCzAyA9/Sunz0JGnjWmr1M2ukF65aJcyqzmFmQfvq0RQHvrD/WAxf
	VHm9vv4sgvPpTHA5Z4pwE/diBW6EvlJwX2FP4LAy7hKSGlMugkWd0p4m6j1C6JnR+FqnyDXgR2/
	P6dHLFXXvk/PkGYQQ0mxXAeBkFI0W3LHhBJhjawkCtst/uMF+0J02pYdYS2mAiUEIiohqqtdlQC
	w50DPw0ZnXTlfSQGIVYUuG1+L/r5GlTAsPNjId8ASfw2pIIQEcSNz2C4bQFYSN/x/U8m73KrBxY
	ZpZ0+KTiq31R6N3kOgBg0k4ZIEhoPOZw5JxAfg8kvE9t374c0YyqOWoZVhSOzYVe1XGUVeuB2Z/
	jM9FJqzvVpXy4D8T73F9II7uq+7RDKlXMNnN7Lfqxn4Vw7/+AB5Mq0AQywwhZtpCfRygaSXkrjA
	==
X-Received: by 2002:a05:600c:621a:b0:48d:35e:849d with SMTP id 5b1f17b1804b1-48e8fe4dca6mr55140425e9.6.1778600394469;
        Tue, 12 May 2026 08:39:54 -0700 (PDT)
X-Received: by 2002:a05:600c:621a:b0:48d:35e:849d with SMTP id 5b1f17b1804b1-48e8fe4dca6mr55139695e9.6.1778600393794;
        Tue, 12 May 2026 08:39:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f41a8b1sm31709705e9.7.2026.05.12.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:39:53 -0700 (PDT)
Date: Tue, 12 May 2026 17:39:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: "den@openvz.org" <den@openvz.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <agM8cxqUCJNjBDlm@sgarzare-redhat>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lyKkAPgVZb2qpQBm42GAunTLjIQ2Z-T4ZrqyxkQ8rLE_1778600394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 12, 2026 at 02:32:14PM +0000, Polina Vishneva wrote:
>On Mon, 2026-05-11 at 17:56 +0200, Stefano Garzarella wrote:
>> On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
>> > From: "Denis V. Lunev" <den@openvz.org>
>> >
>> > When the host initiates an AF_VSOCK connect() to a guest that has not
>> > yet loaded the virtio-vsock transport (i.e. still booting), the caller
>> > blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
>> > vhost_transport_do_send_pkt() silently exits when
>> > vhost_vq_get_backend(vq) returns NULL.
>>
>> Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?
>
>It can, but it might be difficult to find a correct timeout.
>
>And, generally, there's no way to distinguish "the guest hasn't yet initialized
>the vq" from "the guest is up and running, but didn't reply to connect() in
>time". That's exactly what this patch is attempting to fix.

Okay, so please mention this in the commit message, I mean why 
SO_VM_SOCKETS_CONNECT_TIMEOUT can't really help.

>
>>
>> >
>> > If the guest doesn't start listening within this timeout, connect()
>> > returns ETIMEDOUT.
>> >
>> > This delay is usually pointless and it doesn't well align with our

I still don't understand why this is pointless. If an application wants 
to wait while sleeping, it can simply increase the timeout long enough 
to wait for the VM to start up and use a single `connect()` call, 
instead of continuing to try and wasting CPU cycles unnecessarily.

Hmm, or maybe not, because the driver will definitely be initialized 
before the application that wants to listen on that port, so it will 
respond that no one is listening, and the `connect()` call will fail 
with an `ECONNRESET` error in any case. Right?

If it is the case, is the following line in the commit description 
correct?

     If the guest doesn't start listening within this timeout, connect()
     returns ETIMEDOUT.

I mean, also if the application starts to listen within the timeout, I 
think the connect() will fail in any case as I pointed out above (this 
should be another point in favour of this change)


BTW, I think we should explain this more clearly both here and briefly 
in the code as well.

>> > behavior at other initialization stages: for example, if a connection is
>> > attempted when the guest driver is already loaded, but when nothing is
>> > listening yet, it returns ECONNRESET immediately without any wait.
>> >
>> > Fix this by checking the RX virtqueue backend in
>> > vhost_transport_send_pkt() before queuing. If the backend is NULL,
>> > return -ECONNREFUSED immediately.
>> >
>> > Signed-off-by: Denis V. Lunev <den@openvz.org>
>> > Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>> > Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>> > ---
>> > drivers/vhost/vsock.c | 10 ++++++++++
>> > 1 file changed, 10 insertions(+)
>> >
>> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > index 1d8ec6bed53e..a3f218292c3a 100644
>> > --- a/drivers/vhost/vsock.c
>> > +++ b/drivers/vhost/vsock.c
>> > @@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
>> > 		return -ENODEV;
>> > 	}
>> >
>> > +	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
>> > +	 * private_data without vq->mutex is deliberate: even if the backend becomes
>> > +	 * NULL right after that check, do_send_pkt() checks it under the mutex.
>> > +	 */
>> > +	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data)))
>>
>> Why not using vhost_vq_get_backend() ?
>
>Because it locks the mutex, which is slow and unacceptable in this hot 
>path.

ehm, sorry, which mutex are you talking about?

I see just a comment about the mutex to be acquired by the caller, but I 
don't see any lock there.

>
>>
>> Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?
>
>It's racy, but as described here in the comment and in the commit message,
>any possible race outcome is covered by the subsequent checks.

Okay, so what is the point to call READ_ONCE()?

>
>> > {
>> > +		rcu_read_unlock();
>> > +		kfree_skb(skb);
>> > +		return -ECONNREFUSED;
>>
>> This is a generic send_pkt, is it okay to return ECONNREFUSED in any
>> case?
>
>EHOSTUNREACH would probably be better.
>All the current send_pkt functions only return ENODEV, but it has different
>semantics: they mean that the local device isn't yet ready, while there we're
>dealing with the opposite end not being ready.

In the AF_VSOCK prespective, I see ENODEV like the transport is not 
ready, so I think it can eventually fit here too, but also EHOSTUNREACH 
is fine, for sure better than ECONNREFUSED.

Thanks,
Stefano

>
>Best regards, Polina.
>
>>
>> Thanks,
>> Stefano
>>
>> > +	}
>> > +
>> > 	if (virtio_vsock_skb_reply(skb))
>> > 		atomic_inc(&vsock->queued_replies);
>> >
>> >
>> > base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
>> > --
>> > 2.53.0
>> >

