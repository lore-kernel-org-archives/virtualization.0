Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF332D0C92
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219250; cv=none; b=W97Q/b8hMCFvoDughzRNuuKMwnerboBwfOsbMBR5RQUtxuTVy1gR0IY7JFoIjkxbLwrCFoKlyhpNQ+UnO9D21bHx6IgVGwUsfBcxMCLDV0tTucToSxAK7WBBgv8h69PlVlK4d3etwkKks/BzQ6T6mj3ZxZyQgtziP7+jJqi5iVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219250; c=relaxed/simple;
	bh=hfFeAiIDDvcWTY7CcVSvPu7m04vemVeg0WMspIP5i4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qMps44yLkYGwKXUkFlzdq6M0VfAeWKT3IMQid/HiOJIbkEF5iU8xlRD2D2UqnjN40LrciADFVItW7yBj9YkB1dmeG9dW/aYgCJ6Lrgyj9S/ikrVLc0zdSYYAvV7A/Gh5WbxEgo4Kj2b9vFM5iRRGnhzZXUZn+OBdU62G4A7MRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8O3H4qX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8O3H4qX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768219248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OOV5rZtkgq/TYG6iIabLFlqJMdYBjVkhddu7QsUorlw=;
	b=f8O3H4qXAd09JvSDgszE1DaDHpHRnJbVXvowVrFpQgZlFm1+Czyxsbd/oP656Tn+8lvGVG
	F/EV5luPEyMzzR7U0M95h8g3DtLl0JFFfkC1/s3gexYwbtFPQCzHyFB7XCrbz3KnHe3NoI
	ziD37neCDxTP4kBTHC0/a5f3NiBu0lg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-aovfHkI3OruTlkti_E_q1A-1; Mon, 12 Jan 2026 07:00:47 -0500
X-MC-Unique: aovfHkI3OruTlkti_E_q1A-1
X-Mimecast-MFC-AGG-ID: aovfHkI3OruTlkti_E_q1A_1768219246
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so52075435e9.1
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 04:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768219246; x=1768824046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOV5rZtkgq/TYG6iIabLFlqJMdYBjVkhddu7QsUorlw=;
        b=iN7t6HQyLbMITInruO/EUQt7T91Hr2fHD1eFrOi/WoTNoHMjBS5vGRJLxpWCesg57b
         hTUU0WzEy88TgcQMQPAiRXmDHbfw3W6M8hzNF5z3/510+9n0uQzeTCB53nvgKbh7cLJ0
         x0GtwgpW61zK+5Hoj0ycdmIYWtohEYJlr8tA1QLPJGsnV1y8kjnofzGWnGbi9uU60rM6
         qaWqIoAYdY+uOZYMqO1IFZd8oRadT6boo2kUAZGsY3P7P7uvXVx07OmfEe2m58PmOhJp
         fwYj9+v8JHr73mDO5/D0TyQlo8APLfwbLt/0te+2NdmhfzFyRRM8RhDfmfZKlf5BiAPx
         8KlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa/GlqSGTuSJ9DFu58ng0ptVmnRBGCm17OnowzpMp0cchxQiH/tUbVSABi9dVpq3u/dZEHyjXzDsWwr9C3Ew==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEE2Vd90UncgokQyHD2bCk5JjQhZ4STbo2Nh0F/RzNSrC0cbw/
	ws00FzkEo/XSjHtudkJ20t/m5o/S4qiqvcWpUAt0VnhLSllJWLsljHJL02AikyXP/8EmENdw2tX
	k51AQTKiqr/Htf5TYSKi6JqwQ+5DHtC4iRJg7ZQHrMBctjKzefdgMiwNLd9hkYCUe/GjT
X-Gm-Gg: AY/fxX449/RfjyNErkBFS1KmI3vL3HQKtNinLGyU3k/i3xfuYKgtfudTMLST1fLBUry
	8DDRLdHFlSFkw7mn6GDacf9sS61cs+vPfW0FCRPSpyZ8jLgl0lEv1NtSlegcGALChb2TEhYqust
	IglLwoQfQGe05W6RAzu4oDKrnX6EXPq/GxMvyQZ+VVpNtrj/MF6dNz2fVgSqC8PZkZmMWLQe9tm
	eyGXR/32RfdOXmS4DXZJTJoYSEnU7gDHfWNX60ICNxVsV/eARIKJvQ5INfp5QoWdHqxZSTnv/rX
	VCNIy1Y2WSIn9zVagrYMjLFQb3FmvmfPVxWAMFEwEJg8fTRE5o4KNoL2aUNMxzgMyiNXGQ7pxXI
	5wW9MtfRHh4m+tRJEEGzTCiBO6AWs6Qo=
X-Received: by 2002:a05:600c:a314:b0:479:3876:22a8 with SMTP id 5b1f17b1804b1-47d84b2d285mr182865215e9.16.1768219245585;
        Mon, 12 Jan 2026 04:00:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwS0FwA3G4d77kbD1y9f5zWxZfwkk17a86x64r/GhYecFR2Oj58FTKjjZU+xN7PYXrh1xDnQ==
X-Received: by 2002:a05:600c:a314:b0:479:3876:22a8 with SMTP id 5b1f17b1804b1-47d84b2d285mr182864805e9.16.1768219245113;
        Mon, 12 Jan 2026 04:00:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f668e03sm363963425e9.14.2026.01.12.04.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:00:44 -0800 (PST)
Date: Mon, 12 Jan 2026 07:00:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 11/12] vduse: add vq group asid support
Message-ID: <20260112065928-mutt-send-email-mst@kernel.org>
References: <20260109152430.512923-1-eperezma@redhat.com>
 <20260109152430.512923-12-eperezma@redhat.com>
 <20260110185711-mutt-send-email-mst@kernel.org>
 <CAJaqyWdg=RXmmQRNUKFfCn-3o_JzmHz5wmQ=3xLU8rRMvTa4yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdg=RXmmQRNUKFfCn-3o_JzmHz5wmQ=3xLU8rRMvTa4yQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4hsp-DWoZ8J1CS9CVTiOrpa-6nLrorfdVVdj1W6ADVc_1768219246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 12, 2026 at 12:56:34PM +0100, Eugenio Perez Martin wrote:
> > > @@ -439,11 +453,14 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
> > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > >  {
> > >       int i;
> > > -     struct vduse_iova_domain *domain = dev->domain;
> > >
> > >       /* The coherent mappings are handled in vduse_dev_free_coherent() */
> > > -     if (domain && domain->bounce_map)
> > > -             vduse_domain_reset_bounce_map(domain);
> > > +     for (i = 0; i < dev->nas; i++) {
> > > +             struct vduse_iova_domain *domain = dev->as[i].domain;
> >
> > I do not understand the locking here an in many other places.
> > dev->as is dereferenced here apparently outside as_lock?
> >
> 
> The virtqueue groups' "as_lock" member protects the virtqueue groups'
> "as" pointer. But we're not accessing any vq groups "as" member here,
> we're accessing the dev->as[i].domain pointer here, which doesn't
> change in all the lifetime of the device.

Ah. got it. maybe a comment near the field definition will help.

