Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B223EC822
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452353; cv=none; b=XhDip2QWPcygzF7VwtQ4ODADKZsOFHZeXImfLLd0v9gaHwJ/Ndw8CS3508bUJ+3ayxjz4IBHrZBML9O/WV+bmA2zUfTkZzB44XMsGHPMGLka+sj1mdhbyT0YJvdofNXk/FJ2XY9qGMxUvQI+4RvjRQJp2PDy1u5mheANKYxyT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452353; c=relaxed/simple;
	bh=wpO1t/7FGPKrcFhoNcA92Vi0PmjZQCcIGe0oiSegWrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TV80lYFFFy8n5vDopfzwaC/Q3XarH+/7iVyCTVFm1TUYY3xP7/rqlZlr6jShiSWKcMzNe/oJhBBIUPp/D8Eod4Nh0QDrgkRKK9i07WLJDOREs4GStmiwRlBjG1rzJrKVCdWK7CQu5VAvpcvR7HvKMapjvPVi0Bh9vi9y2Z6Agtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UapOI+Vs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UapOI+Vs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785452349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sx+8dGfrU/EPbcECFTxS2R77qIQIIRmUdLHbVGAEsZE=;
	b=UapOI+VsibK5Uol4nHBOSEdTA9wpIfbmOJE9owJgOqj18oejfhR0tdhrOvcPfJWMQakos2
	0zbpMqx75FTdOZffgUEjJbveET9kAJqCtCUPMdHPuYS7P4eye73rqxP/rep2jPYTgYKEr0
	ueZjqCJZR4wqGxvJ6mv31xHhOkZs3Co=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-1bwxPqbTO3WUMP-elwYDTw-1; Thu, 30 Jul 2026 18:59:08 -0400
X-MC-Unique: 1bwxPqbTO3WUMP-elwYDTw-1
X-Mimecast-MFC-AGG-ID: 1bwxPqbTO3WUMP-elwYDTw_1785452347
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-496b6f97676so2505005e9.2
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 15:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785452347; x=1786057147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sx+8dGfrU/EPbcECFTxS2R77qIQIIRmUdLHbVGAEsZE=;
        b=I7FZkpD5L9kCuFsDcPPnJHJy5uPtS52RXnS6f2roWk8ZSVy/mdsx7IKRiXgJQJnlwy
         SPYT7MYQUNaN8RF1cDl7NhMZwFvUiZqYcx6Y0zbgc3P4u6TKBACcWWMNbWRtDfNxHpn8
         BOlUu17HdAagavXVzcrNKUP+dJKkbNezqEYae0jq+wFMD3SCTdKLNc4yo9Aj7a80Vu0s
         fWGK480X+idZvHG5RQtYK4lFHfbAgYu7S8KNPV/E+N5Y8Qk9ckkfynOuUkZ7TV7aC1Mb
         KABg9imOYXu9l8j7lwEGfRPYyO9lQnEFqIORUQQ4bqeZkigHoKMm/rSYCTVOzX7jVzoV
         llhA==
X-Forwarded-Encrypted: i=1; AHgh+Rq66EupUZBttU9/7u0TpCplRrAliW8vFbALrcbkh8Ed1Q8CZ2W6KPi1168hCXNQgfmyrcRNlJ0n6+N7TWriow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi9R6e7YEkh9al49Itl2poPB57sKeLvvTL26pV73vvWim6VTIU
	P5EeYPq01wHMBp/vi8HaN5lC4xRO2FXQvUowZXCYhab7QvRdhkB+GDTjyfJIo5W4KpdUKlEJ/g1
	ArQeNv1vbuAfK4KlnDUTowDfzYQxDWDRZ7lmZ7w5KGUYZu2BPwBmzANncAGsVMe3CELoW
X-Gm-Gg: AR+sD10k9VYsMQymw6bl5LKK5xhzzbo03bUjLXqD7itGsSVZpqtRZi5z4Rk/MEZdpTC
	FbWLsKPOpmasDFQKLDVHF7eJCccBiSKY48gsDQ6H7ib1ctV/OS+jvSlmjplAvWgamPY/VhHoR0P
	2TJZdJzflMLVSmNKLJBVkn1ctvc3j66rONyUYziwIr/ARCZs51QWzKzavE98toKgz7RFfKi4oh7
	YeL31l8ybVlS7kqGxUL73LYQ3dEcmTEQlL9t+sqRjfJMRnJZQr0hCDRMaNjbdrlC/DwRpkrxDkz
	QTRHMtfoQhFsH3xzYX8dBRUdSgf3bXZ4VtgGrvQzUPJOkrGRHnfELKiRWL17koENfUBawE3m+x0
	ICHJ++nvQRKJAd9liJ0qoRVM=
X-Received: by 2002:a05:600c:1d15:b0:498:490:3bbe with SMTP id 5b1f17b1804b1-49804903c27mr34935015e9.16.1785452346900;
        Thu, 30 Jul 2026 15:59:06 -0700 (PDT)
X-Received: by 2002:a05:600c:1d15:b0:498:490:3bbe with SMTP id 5b1f17b1804b1-49804903c27mr34934755e9.16.1785452346444;
        Thu, 30 Jul 2026 15:59:06 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49800f1a91fsm89806315e9.6.2026.07.30.15.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 15:59:05 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:59:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Octavian Purdila <tavip@google.com>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH net v3 1/2] iov_iter: export iov_iter_restore
Message-ID: <20260730185844-mutt-send-email-mst@kernel.org>
References: <20260622222757.2130402-1-tavip@google.com>
 <20260622222757.2130402-2-tavip@google.com>
 <20260625-erstbesteigung-mundschutz-invalide-3b0d4cd4cbc9@brauner>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260625-erstbesteigung-mundschutz-invalide-3b0d4cd4cbc9@brauner>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5PWT0WPJslRQX_sryhQ5cYDkZ3lxdmda4aEg08Xx40g_1785452347
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2026 at 12:43:18PM +0200, Christian Brauner wrote:
> > Export iov_iter_restore so that it can be used by modules.
> > 
> > This is needed by the virtio vsock transport (which can be built as a
> > module) to restore the msg_iter state when transmission fails.
> > 
> > Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Octavian Purdila <tavip@google.com>
> >
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index 273919b16161..f5df63961fb2 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
> >  		i->__iov -= state->nr_segs - i->nr_segs;
> >  	i->nr_segs = state->nr_segs;
> >  }
> > +EXPORT_SYMBOL_GPL(iov_iter_restore);
> 
> At least only export it for the module that really needs it. For
> example, see:
> 
> EXPORT_SYMBOL_FOR_MODULES(__kernel_write, "autofs4");
> 
> -- 
> Christian Brauner <brauner@kernel.org>

Octavian, you wanna try?

