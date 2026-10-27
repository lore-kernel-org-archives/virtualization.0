Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104812;
	b=kCdPdtZDZTE9TyW97Cg2FQSjSGXQ9nDnZ5fGqpIT+5d4zZKzUNl7MogpACN//phf8jxP
	 R5bc4N7NoloEcplrLH85gCNbq1WebL4BCdU/aaOCBawaavb09Hdif4t7tDi9x2NsCa2lc
	 fWEa+2G+mHel/cKOwhz1VXyb3pZJ0RPBfLqmzg0ckqgK+8xqvY5SxiQjTf+c/eH59Za3E
	 YCtv3Sn1KXCGW1nS8ihuCpnwEOTzhQnXuWRGWGIzaPzq2Rdmol/NwfUPf7PsdBcRuG2f8
	 zU+zh/gdzzN6pn4kRIZxV/++NN2pC0+zYPKiSUNcZYqO3/j02BdF8t9/s/hN+ZpF/Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104812;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Mi9hiqxsLrpMoS8pdP+ccDuuJgKT+wlBtqA3CohVCQw=;
	b=gxafhoa98+XeheJ2Q90rKAiHumXsHw9U7TZJjbxmzydStdT3AjRBLxl+1gIR/lTchBJq
	 sG5X7oi1QNT/fWn0te+11rHk0vrcd4FkILiTqixSQ7VRjyAgbuTyLt+Z9o8M02UebPBpp
	 h5qwT1ZvYcmqpLm4xEGwJF1zG+aOG7Fu7HvC2ReJ5XghF+j8TdiI0ejkQnc/FYVlqZmtI
	 x4kWHkXFVqYzXpZpnkSmK+BgiLMAODc8tvHfkBWylmeY6WXZRuzg4lOoBbj39hIuxp3rj
	 mhUrkcK/46Gjt4MFNCIEsfKB0etSOT3KEGM7u3uxFCXT5zVtDwEErygJ4sciYRInjhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QMlsBPjD;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5024606A325
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 12:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5024606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QMlsBPjD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793104810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mi9hiqxsLrpMoS8pdP+ccDuuJgKT+wlBtqA3CohVCQw=;
	b=QMlsBPjD3chYdh8Y3j3FhWCYXjca2dTSjjrV2oCKJAVG1Zsc957ArShRvWpzbG2Xf6OX9+
	N6MhMcgM9QzWjGob/fR9PRBP+hp+sked7wPkwPxDOuG+/eIT66EWYKfLdlIIyN6Kx9KOHB
	Nu9KXvmOsghWaYwRg8cpDJx14U/GpVc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-gYZajsfFNCmg4CCayxutqw-1; Tue, 27 Oct 2026 08:40:07 -0400
X-MC-Unique: gYZajsfFNCmg4CCayxutqw-1
X-Mimecast-MFC-AGG-ID: gYZajsfFNCmg4CCayxutqw_1793104806
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so1974753f8f.3
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 05:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793104806; x=1793709606;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mi9hiqxsLrpMoS8pdP+ccDuuJgKT+wlBtqA3CohVCQw=;
        b=dguCLJ+cWX4WId7SPwPGlXGx5XigFzje5UzblEKMzNlSyp/SOBX7OxZHww0RSRlV+5
         vQqNHw/95fAfRjeFtmf35ucNgr3JAteQD4wSsCerK1/oU2f7n7LA0BbB9ZbJpw+rpax/
         OGd5b4WHLUsK7q//kYH8JuI53vAg9jCQL+MwQCBrFR2lOEchuetfSXmLRYtK2kP5iAJa
         sNUJMihKv7IINGMaolEEPg0JhmL1p8ZH7YH2ug5dVgxZDIzkSgdYWu8dl+r7/8ZKoPMb
         m4R2MS7C86SO0So901bQW8dME73DM42z5yz/wtTOPzFBdiqYc3TLMGFwdNoFOZkthqwa
         6Mfw==
X-Forwarded-Encrypted: i=1; AKwUvBxP3toAOFtRiGpdM+/h8C1Pk9lrP+6XtNOQfJfF/3HOXW0X5kXf4NRcw+8v0ni5SR5zS4ZnaXT1QSQwG7Rf0g==@lists.linux.dev
X-Gm-Message-State: AFq9FYI6SO3br7JKH4sAnG3paUDCFrJ81vuoQz9L6Fuo+oiYICFMeCRd
	05f1nfOS4onSART61b18douJFwMGERWUKaZ6/clCnZWXvJxTew5jQj99Uda9p4J/+u0FBOW41Ra
	sI45QqsvItgt6eq8vq4WNIabg+pzF2+Vq0rLBk4/1umjYNlre3y/p7lRD4LCA9Cf90Svn
X-Gm-Gg: AYBFou1qLVK+a0r6DZp0F/F1BA3+YMXj7fumqtoKzXGhFprfupxZc0Ij40ek+oS6uT+
	+aCPGXY6UFH+dZWUwcmPoR/p8ewF5U7syuvBAi/TPh+fuafa2/Xmfn5MJYvtF8IZWDP9PQvlIsU
	tVfvtEFR2tV/P7a7IB00OChufRu+Lq7n1fGZI2df2ZTlx3E4Cpj0j3GU+FXt4CEtXj8CUswNyN0
	RBeNb1qgm2MApIYMbrbZi1/P/fiA+YZfwQZs0e3rL3Px6MbswgJloOgy0CQ1ilrpY+jC8sndiu4
	ZJArChEL7q6e1lJOCFm4CzzqAAcf00Kp81ls7z6+ciAyjg+f77lHRoOdL+zGVsyVIfI=
X-Received: by 2002:a05:6000:2884:b0:48d:ec3c:3247 with SMTP id ffacd0b85a97d-48e3ebb18bamr16997770f8f.44.1793104806185;
        Tue, 27 Oct 2026 05:40:06 -0700 (PDT)
X-Received: by 2002:a05:6000:2884:b0:48d:ec3c:3247 with SMTP id ffacd0b85a97d-48e3ebb18bamr16997676f8f.44.1793104805593;
        Tue, 27 Oct 2026 05:40:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3cfasm22687863f8f.17.2026.10.27.05.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:40:04 -0700 (PDT)
Date: Tue, 27 Oct 2026 08:40:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ruben Hakobyan <hruben@meta.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] virtio_balloon: submit reported pages as
 individual buffers
Message-ID: <20261027083627-mutt-send-email-mst@kernel.org>
References: <20261027063247-mutt-send-email-mst@kernel.org>
 <20261027123204.2671561-1-hruben@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261027123204.2671561-1-hruben@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JhvF_2_G1mMLA_mO365f1SgRiTUqvW4PX1MZ4qRHo_M_1793104806
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 05:32:04AM -0700, Ruben Hakobyan wrote:
> On Tue, Oct 27, 2026 at 10:35 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Oct 27, 2026 at 02:26:33AM -0700, Ruben Hakobyan wrote:
> > > On Mon, Oct 26, 2026 at 11:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > The virtio_balloon driver reports a scatter-gather list of free pages
> > > > to the VMM so it may discard unused pages.
> > > >
> > > > For an arm64 kernel with 64 KiB pages, the default reporting and
> > > > allocation orders allow entries ranging from 2 MiB to 512 MiB. If the
> > > > report contains a sufficient number of large entries, we will end up
> > > > with a descriptor chain that represents over 4 GiB of memory. This
> > > > violates virtio spec, which says:
> > > >         Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in total;
> > > >
> > > > Specifically, submitting $2^{32}$ or more breaks Rust-VMM.
> > > >
> > > > Submit each reported page as a separate virtqueue buffer instead of one
> > > > buffer with an sg list of all pages.  This also avoids indirect
> > > > descriptor allocation (kmalloc in the reporting path).
> > > >
> > > > To avoid multiple buffers causing interrupt storms, keep callbacks
> > > > disabled while we wait for an event.
> > > >
> > > > TODO: as an alternative, keep using virtqueue_enable_cb_delayed
> > > > but add buffers after there's space in the ring.
> > > >
> > > > Note: if the virtqueue is broken, wait_event on
> > > > virtqueue_get_buf hangs.  This is a pre-existing issue:
> > > > the old single-buffer code had the same hang.
> > > >
> > > > Reported-by: Ruben Hakobyan <hruben@meta.com>
> > > > Cc: Ruben Hakobyan <hruben@meta.com>
> > > > Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> > > > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >
> > > > Notes (changelog):
> > > >     changes since v1:
> > > >         keep callbacks disabled while draining: get_buf re-arms the used
> > > >         event for the next buffer, reintroducing an interrupt per page.
> > > >         Disable the reporting vq callbacks at probe, and only arm the
> > > >         delayed callback to wait.
> > > >
> > >
> > > Thanks for the patches! I think sashiko-bot found some issues on broken
> > > queues in the first patch that are worth looking into for correctness.
> >
> > Surprise removal of the balloon? Nope, it's a pre-existing issue that
> > it's broken.  Besides it's not really practical, no one removes
> > the balloon - no need.
> 
> Fair point about that. But I meant the broken queue check.
> In virtqueue_enable_cb_delayed() there is:
> ```
> /*
>  * When the device is broken there is no point in polling used->idx,
>  * the backend will never update it. Return true to let callers
>  * exit their cleanup loops instead of spinning forever.
>  */
> if (unlikely(vq->broken))
>     return true;
> ```
> 
> But virtqueue_enable_cb_delayed_max() doesn't have this. So I was just
> thinking the same reasoning should apply here?

It's broken there, too.  E.g. what is the "cleanup loop" in balloon?

> >
> > > Other than that, I tested the "normal path" on QEMU and Cloud Hypervisor,
> > > both on 4 KiB and 64 KiB guests, and this works correctly.
> >
> > Thanks a lot! Can you pls confirm whether the performance is about the
> > same/better/worse?
> 
> >From my tests on QEMU, CPU time was about the same as my original patch
> and unmodified Linux.
> 
> To bring a concrete example, with these patches it took ~437 ms of CPU to
> reclaim a whole 8 GiB with 4 KiB pages (vs ~434 ms on unmodified Linux).

OK so that's just noise, there's no difference.

> 
> With 64 KiB pages, it averaged 121 ms CPU (vs ~112 ms with my original
> patch).

Is this measurable, or also noise?

> 
> (I tested this on Nvidia Grace)


Thanks!

> >
> > --
> > MST
> >

