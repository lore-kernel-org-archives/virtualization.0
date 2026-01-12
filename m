Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67C32E138
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204825; cv=none; b=lCCLFuUdY4P2LPt7yZ17CHwW1YH1TKbN25+364YgMfGE7OdkOKSdeb+5XsXxveLI8J/7P/c1ndpiHKKuSZojod1qW6oNB/UTpnU7htCgWgY8A2VO5bjL0ZY9etWWvkcOEZCcP+asZBATI5H681RGlFXKiZgWfX9jTMg13pZJjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204825; c=relaxed/simple;
	bh=5dhidBQ2qVRjY7HWzYNvYRd1oZBKRDvfQdTEJffco/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iFaax/DSS3dlbXf/kjANGYhs1BK2uIrdcH8YrxOydh5q4PQrXnk0AJsw5C/QznPoUKGyO5mfbEIQMkEfuhF2yAom87uEfeeBNXU+vXn9F4YS3juNpvHAl2Fn0LMU4aWaMlep9ep/asSn6oyGh3JEHTkI1ObM0G+DBdco+nRrztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFOnRrVR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFOnRrVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768204823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVlVMdkkC1Jjx95S4ueZ2nCAXykmbyB/9y4QNLXeHAY=;
	b=PFOnRrVROiNKcCEnA9KTvQahyPq01D32p/lXGrx+PpA82FQy3dJZfH+Y03ZUyufJPChXr7
	ti01ntgoPI5hLjRHv7Yiq7HidZtV4i/mk1E2I0eJ/zJGFwl6xXwGasd4p3edZOmzFBe9Zi
	VOxs00SelUKNrxzw/UlY231a8xNqQ0c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-GbYfjs0IMBmBw6hlj23HBg-1; Mon, 12 Jan 2026 03:00:20 -0500
X-MC-Unique: GbYfjs0IMBmBw6hlj23HBg-1
X-Mimecast-MFC-AGG-ID: GbYfjs0IMBmBw6hlj23HBg_1768204819
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3ffa98fcso39932325e9.3
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 00:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768204819; x=1768809619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVlVMdkkC1Jjx95S4ueZ2nCAXykmbyB/9y4QNLXeHAY=;
        b=lHTF2z/BJbDEpiwe4Kzq8JLIqQ5C1Lv+kCOaSoNtFu+0ImmhKEjHYokkb6EHSzthht
         WNTLQqcOpqTx3s1vWl0FwSUaHSvV6vfVUlr3y9m1zwyWGSLCZU0Dij7Sy47fpXXLX2kQ
         bHN/bTyaFMSxQE2qmUANyAUJU3jQTt1Wy2L1hc6TDDn36yeZrKmxWQLFfIhb6F1QD7LC
         sJJuHGKvPjArcfjv02hranDxp0MCVdImquCDKK5BA+G0D1aiXx+6tgazB+FpY0MwKu6O
         bFCfwwxAouUoBGxYi+e8VI98wIaNFD43Zg6yMU4i+IA1vqVeVRCVIWNNvKfLiwQQdDGy
         eMKg==
X-Forwarded-Encrypted: i=1; AJvYcCX+HJFNK34eY9enyKdvcOUKAdpqfoKvAniMQe7DTeGB4PdGA4VXNMQ/odgGHeTEqTvxCrSGnPUyE1x2W5xmEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5jF0EWOflCu5iQjVwGeejlFVOMm8Uvwi7werr5Sp5J1Y6OQNE
	IIpUvyW3E67WPss47G2meERkfMWnWkWY8jAiMv293CAlTozq3UwnX/Nj1Rwu1RCscACLTgQ0j5H
	FA79mxtofy79Isgj/Z/0ZQjxSEAyvuGBxznN8cs4AqQQ30GUwHivHJ5++fxoVTfgWQ3eY
X-Gm-Gg: AY/fxX4fdskFIVn0XJp9ZykH8RtOqjdKMSmQ7JK3Z3/wrUli9MRUakQAPVZnOCujmng
	ajZnYvjVDh83Abu8XAa0nQ1x/zzMjwVuuDvwSDXsQsa/y0VykRYR4oUkBRSGbE5rkLYSExrG7yh
	kyyCX2P+WEK5URHU0JVF4J6pOlyNUAkfkcu5UX+vbfcniIBcIY3BL2oeK3pKD3nI/BK+UOakAAo
	EYEgNYEWMtxJWE3gem14nahR0daAFMRwG8E30HlgdFh/0oAubRJLC8vr6prd0NyBWwdTLU/sdEG
	kgStbK+QhuyeUNH5GqzbHi4xmkN2PYpclDEIaH6ea7K5/C1KeLTkolTdAV+uzNNk0EPZDdZRXwb
	VITMD1D83wYNS+qMZkfA5o+t1GtBDAU4=
X-Received: by 2002:a05:600c:8484:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-47d84b1a095mr175391745e9.14.1768204818983;
        Mon, 12 Jan 2026 00:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq3Sj3sI5Uz7LmIr5BjRNBlTXc1OS6InhejNK0sTEWVefFhTaJ5FHexT2Lqrk80oxjuSK5zQ==
X-Received: by 2002:a05:600c:8484:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-47d84b1a095mr175391295e9.14.1768204818436;
        Mon, 12 Jan 2026 00:00:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f4184cbsm357729585e9.6.2026.01.12.00.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 00:00:17 -0800 (PST)
Date: Mon, 12 Jan 2026 03:00:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v11 02/12] vduse: add vq group support
Message-ID: <20260112025737-mutt-send-email-mst@kernel.org>
References: <20260109152430.512923-1-eperezma@redhat.com>
 <20260109152430.512923-3-eperezma@redhat.com>
 <20260110183910-mutt-send-email-mst@kernel.org>
 <CAJaqyWd4VZaqA3E0NCeCH6ur1q7stu1HgHTKEv5hjRQ=eLn+uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWd4VZaqA3E0NCeCH6ur1q7stu1HgHTKEv5hjRQ=eLn+uA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aUXTC_699XL8aGLcpPwy-PVdYPrVPVYVaOgeSjsNf7I_1768204819
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 12, 2026 at 08:35:37AM +0100, Eugenio Perez Martin wrote:
> On Sun, Jan 11, 2026 at 12:44 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Jan 09, 2026 at 04:24:20PM +0100, Eugenio Pérez wrote:
> > > @@ -1252,12 +1266,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> > >               if (config.index >= dev->vq_num)
> > >                       break;
> > >
> > > -             if (!is_mem_zero((const char *)config.reserved,
> > > -                              sizeof(config.reserved)))
> > > +             if (dev->api_version < VDUSE_API_VERSION_1 && config.group)
> > > +                     break;
> 
> (Bookmarking the piece of code above as [1] to reference later)
> 
> > > +
> > > +             if (dev->api_version >= VDUSE_API_VERSION_1) {
> > > +                     if (config.group >= dev->ngroups)
> > > +                             break;
> > > +                     if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > > +                             break;
> > > +             }
> > > +
> > > +             if (config.reserved1 ||
> > > +                 !is_mem_zero((const char *)config.reserved2,
> > > +                              sizeof(config.reserved2)))
> >
> > Hmm but if api version is 0 then group should be 0 no?
> > We should validate.
> >
> 
> The check (dev->api_version < VDUSE_API_VERSION_1 && config.group) is
> above this check in this set of changes [1], am I missing something?
> Would you prefer it to be reordered here or written differently?


Oh you are right. It's just not very clear that everything is covered.

	if (dev->api_version < VDUSE_API_VERSION_1) {
		if  (config.group)
			....
	} else {
		....
	}


would be clearer.


BTW I don't really like this idiom of "break to return".
Just return -EINVAL would be more explicit.

But this is the way current code handles it, so I'm not demanding
it is changed as part of this patchset.

-- 
MST

