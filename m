Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F90228D8FD
	for <virtualization@lists.linux.dev>; Sun, 14 Dec 2025 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765696849; cv=none; b=mnSY7cHbkJoleGB264aPiLnnq9zmpfOXHVE0NjvojgN6+DZUpEVGqTeryr4jxiyDoOw9F8ElJHKizqQsTB2mq9nlz31BoX16Yknu7OhpwX0bVqFn7k7FwAwVkkGr8TGQNxwl1AJW+leCNe3tkyzte0D6uJDwrTLaPWgNn/c9PUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765696849; c=relaxed/simple;
	bh=2Hruo867MnhKMXqnq2iboVj0I9z7FgOsV0vMzjLmKtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IeZA5CZMYJdRcmTrZJMizHIqjOXSLZkjRqyqVRoJPXUiCDc45bXPz7jZplc+4VCfLnvVjG6rwTLyuqbQe8fOfzxQJWQZ19VBPasIO6T7aRQayv4nAx0DItxf8mIWw2/z27VfJUx5l7yghFa3A9d037tvFOgw04GHoc5wU4SD+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgygDYhg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgygDYhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765696846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6PBHGYUxi7Ek0lK+0qKl7f29nfdLGn+qwm8GebmaVpY=;
	b=YgygDYhgGHX5jqMnsr97Ys/M0/YYN4OuEyExebgK9ghUdbVxbu3jHB9dn1vueBgmQrFrpK
	SWUil6r5jLkAo6jnlxJiMQtqV2YAFE/eTpg0GylQdbGFxygQ04vCqi1RFCA5Tz+Gdm5D7J
	+SsbrAhdjeZ1+iwVOD+QwEB2+i3xmBw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-FBGnEgmONYC9Wi_NeEvCfg-1; Sun, 14 Dec 2025 02:20:42 -0500
X-MC-Unique: FBGnEgmONYC9Wi_NeEvCfg-1
X-Mimecast-MFC-AGG-ID: FBGnEgmONYC9Wi_NeEvCfg_1765696841
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4788112ec09so16216305e9.3
        for <virtualization@lists.linux.dev>; Sat, 13 Dec 2025 23:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765696841; x=1766301641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PBHGYUxi7Ek0lK+0qKl7f29nfdLGn+qwm8GebmaVpY=;
        b=hvfwnl/U3H3CZ18M3eGmiuXDpzksiLJzuoHYmHk8r48sUrN8MK5boSlghvmCdgPtPf
         iHI/ij716VyvFX5S7TnWOHCvaS0oE+D/BNb6tzmd7BkTbgIVZ5Yt3MUHUakjk4GjsHCK
         ungGnB58kB7hWM5D0vWcLOc8fpFYJRVLY7jMeAb8jW8udqc6VeHQPpRM7vRw5lyWtUdQ
         Xh4dROhcbrRuJcCJG5C73mjwSNAtUUqfClhNs0Chs0jTGHpbc/vg37CURxpHMHSYPoMF
         eqQ6e2S8wKj/GI3DSngCpTJx8mnWlKSMkQCbfMhpAA5uWrUKe3KpGR98U+eMkhtnMLoX
         /zog==
X-Forwarded-Encrypted: i=1; AJvYcCWNOErBInhym505McDnq9VD98gbIsE4+vWHY1T8X3uhBxp0b1DfsOIC56m9Nosw90aKLSl1KSFGmZtya3lJww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9Xy/RSexMi7MO+9pf2kAvaYiCwHdMcL3VTN0iNZ8GaPU5KPet
	s0xjRQQF3ILiKz16x0ITw6KLUggGKLeqTYRhDVyqcnJyG8Adn10cZ/NSOGVHSQIq/pkUmm98s3N
	Ij9ZTb/iKmwcqK7Nfv41GfTVFpfX6xXTju2CwvGkW1MuRY3MuW+xRzYO/q0bcVhlSF5AW
X-Gm-Gg: AY/fxX5aOEW1Kb2EW82XV8Mt5HgVld1MZ529MHx3XMjJgBp8huwpcs8kAHZJurIlKca
	fr97Q6PYOiXLYg99HOXx4R0l+B1jclXyaYkorPE961WkNBnuEfSOTDJ1bulvFzKzZBhtlXNwtj2
	bQy+A+oYYdKOAs7rRQ6rSmlubuBeEoRaDg1vs5PeZ0MxhNf0Z0mGWodpSE4aupIiVLYTRKfqeX7
	6w40WLKULFQ4SBgNF7VnYEz8VEhT33E0i571N4+xGinbh1SASxYkcTelKLbP+RQ05MWuBBs6Ot0
	f8/F2eHsLEdPHyx+sVXdpy0Rpd4w33HbJ2ffkP0ogS5nRnQS2jHf7SbirMbB+MuwRKWYAerTUA5
	NcZKUzRLtMbRdMg7uIiMZ9F+iqeNalxQ=
X-Received: by 2002:a05:600c:1d26:b0:471:700:f281 with SMTP id 5b1f17b1804b1-47a8f90e561mr79551795e9.25.1765696841172;
        Sat, 13 Dec 2025 23:20:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+6ozxE+070hZaWXBVgyj/BNlykgsLXh8gS1Icmowaak4rF41B8W319InTAiQMPXUtjTWYMQ==
X-Received: by 2002:a05:600c:1d26:b0:471:700:f281 with SMTP id 5b1f17b1804b1-47a8f90e561mr79551595e9.25.1765696840640;
        Sat, 13 Dec 2025 23:20:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-32-59.inter.net.il. [80.230.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f7475895sm3073017f8f.33.2025.12.13.23.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 23:20:40 -0800 (PST)
Date: Sun, 14 Dec 2025 02:20:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <20251214022000-mutt-send-email-mst@kernel.org>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTw2LORF0QiEcgM1@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aTw2LORF0QiEcgM1@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MR1OVOmxtRblacSLzqeUT8WDG6l27DdOm0UvU4LaV6k_1765696841
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 12, 2025 at 04:35:08PM +0100, Matias Ezequiel Vara Larsen wrote:
> > > +
> > > +	priv->can_ctr_msg.cpkt_out.msg_type = cpu_to_le16(msg_type);
> > > +	sg_init_one(&sg_out, &priv->can_ctr_msg.cpkt_out,
> > > +		    sizeof(priv->can_ctr_msg.cpkt_out));
> > > +	sg_init_one(&sg_in, &priv->can_ctr_msg.cpkt_in, sizeof(priv->can_ctr_msg.cpkt_in));
> > > +
> > > +	err = virtqueue_add_sgs(vq, sgs, 1u, 1u, priv, GFP_ATOMIC);
> > > +	if (err != 0) {
> > > +		/* Not expected to happen */
> > > +		dev_err(dev, "%s(): virtqueue_add_sgs() failed\n", __func__);
> > > +		mutex_unlock(&priv->ctrl_lock);
> > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > +	}
> > > +
> > > +	if (!virtqueue_kick(vq)) {
> > > +		/* Not expected to happen */
> > > +		dev_err(dev, "%s(): Kick failed\n", __func__);
> > > +		mutex_unlock(&priv->ctrl_lock);
> > > +		return VIRTIO_CAN_RESULT_NOT_OK;
> > > +	}
> > > +
> > > +	while (!virtqueue_get_buf(vq, &len) && !virtqueue_is_broken(vq))
> > > +		wait_for_completion(&priv->ctrl_done);
> > > +
> > 
> > Since the call is synchronous, does can_ctr_msg really need to be part
> > of priv? Cannot be it allocated from the stack?
> > 
> 
> I tried to allocate in the stack but the guest blocks when during `ip
> link set up can0`, any idea?

you can not DMA to/from the stack, really.

-- 
MST

