Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097303;
	b=s9d428vISxL4NG2xqaW48VadC6sg4u874tp/wYQxuIoKInJSFmEJXlXg9BgstPd4T31+
	 gP0ysbTbCET42MV9LAh3ZkBkyY9CzhgGdSNspte8gzXL6DrrW91X0zNhx/9B2ZmV7ZDGr
	 clxUEc9V7GgHYQNJe3A06v8TGpMagm94V1XLp8dLCKZkJyb2Pa2I6kVoYMIjF+/XbibRL
	 oggELpuQsflx8lDntyjoXUca98FEPw1LETO1+nV+atENGv4kaPIb0phgaBIxgZ9+F8Roa
	 6Kfwnxc7hcQ8biuwMhagQrHLMogN+KMCUq3hul3l6a2Rv75mGBguBeiFus4kmxS6CRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097303;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=wP5SnFym7LuxSO8fJHfvurJtMfYN7gDtkIUiKX0oP0c=;
	b=d0thPqKLggAcBgld39ZXoWZgD+BdfGbrT+uzX4NEf0E/XmRUBUC0tw6aTzUjtjqcRRHp
	 OmGfd26cPS2ZLM+4aE6sDZ3zxjPBXnk3oS2yXhAXz50vtkfOdVfDo5XXMD2skZGnuNSIp
	 69bsZ8xpqSP0Aq21Si0qTJNJGbOHudAqLsJLI+LPwHqtQTi4P92/U5j4kKhQp/p1YRJvw
	 6qyR/OOPKdsgTrSRTrWMgs9U0RW4pW0AlwqYlA5PvkSF5OryAOENCnB87vn/217AX6jEb
	 pyW7CjMn1L5XF2J31qRKFbq/eBPQB3Aaef0GKqmXEOsvV5ZdbsWg4TKhjkprSTDx6Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=En9NQR+7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC70606A31B
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 10:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC70606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=En9NQR+7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793097301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wP5SnFym7LuxSO8fJHfvurJtMfYN7gDtkIUiKX0oP0c=;
	b=En9NQR+7w9i55NpRxzVDOyoGoREtqZcmfrt3uPddMsmZGT32nP4Q6U3wpdldRnVoTvLYdK
	OkoPl4wYPkMd0aQnqkdybP+KcS0EP9uVeAWUtmuO/5XXWW3zqeMEDXyQO6q+dWQP4mbbVr
	1JzviK7hr99OHneJhU+ANi5yBooljlI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-lokpDkolNPSXUwhxdfQCJg-1; Tue, 27 Oct 2026 06:34:59 -0400
X-MC-Unique: lokpDkolNPSXUwhxdfQCJg-1
X-Mimecast-MFC-AGG-ID: lokpDkolNPSXUwhxdfQCJg_1793097299
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e011829easo3110265f8f.3
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 03:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793097298; x=1793702098;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wP5SnFym7LuxSO8fJHfvurJtMfYN7gDtkIUiKX0oP0c=;
        b=tNvT7SD/vsztwI7FWQQwy0C1YXMQgNKleWN+DiyQxZ3E8Y4s5aqwGv28q2kz/1vrF8
         JwhFeRZbFOW4/TXhSTWgxK/D8AVzT6YFRBjGGfYBcDfSVK+dCf0Y4WZ4Gb0tRTZC748T
         iA2rTsW7WkH52C6PC7E/kskh3hEzW8uexYoxmYOG3WGSPi68+NY98l6qrluLvqReBM+y
         w2vk3sleTAqUroXlrZ0eUdYZl2pHKIKlWg4i1e/ZfDtWV4u6kUWe5JpVLJPK2kU0NUAz
         XLswwPnHadhgpg9hzQUdTEtTPaeP3OaAdbzcm14Z3URZ3D732PBGzEw/S93QbLncv6H0
         TDOg==
X-Forwarded-Encrypted: i=1; AKwUvByEK/J/jRBldtVvA4l+//FlNwDOXE5nVhLm79h6j7ra9Wscb8kOd1bbfZkdrX5xZp9oYrUNo3TDP3KoO2cjoQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ5TRcFMU48Ak9y8TqaT8ScinMGX6ZZPXJMYTCoz696s9boiT+D
	9AAkiQjreUDqk9xodGMxgWo5JtKc5ygNkniLjw1BaTI6uRy1Hz9slLvWzw7PVu7ByTzbQwNWc9F
	MGlM+eLKHIBF28LcIYA9qdp4P029pC1goKI3sBkTvJG5P7+9LH8SI3kSOQDIlaLuTzlok
X-Gm-Gg: AYBFou3i2eO8DNwGMOBxeRBzT3vjDbg+jNAkzzSF6w6IVBhhU/GFPtQZDT90ZAHNAqW
	qdPXFCBMZzmpeZPzNLztcUzDpp3l5tekYU3McP+2Z5AjyyBCrG7WQV9PruaFtfk8gG65HbdEX8g
	yxPT2n803yicsI+mC8/AFZ5nCIkS71h0hF0/b0mvtvHmF4EcthbNBehH7s2Q81mwHfaHxFF9gJ5
	HsfKfFZ2vcxMHGGz21QiQs6oxGri/TF9/jZpSz8OtTWasxqMji3Vy6//wd6ypJg3CLMBCe1n67Z
	A1gpm83ZCTN/9hhsOBZhF3RxyjFOgEcXVN19+CUvojBx6HO/rNikuamPL5nlvJqCj5A=
X-Received: by 2002:a05:600c:3acb:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a35aca4fe1mr175945145e9.16.1793097298541;
        Tue, 27 Oct 2026 03:34:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3acb:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a35aca4fe1mr175944285e9.16.1793097297968;
        Tue, 27 Oct 2026 03:34:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a08643dsm204197985e9.4.2026.10.27.03.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:34:57 -0700 (PDT)
Date: Tue, 27 Oct 2026 06:34:53 -0400
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
Message-ID: <20261027063247-mutt-send-email-mst@kernel.org>
References: <02257263433b001cd0a55a52486857df81dd4246.1793057483.git.mst@redhat.com>
 <20261027092633.3831267-1-hruben@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261027092633.3831267-1-hruben@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2tkkpT9glkPcssgqFDM9140Nm-P46NQnqyKa1GJyNqM_1793097299
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 02:26:33AM -0700, Ruben Hakobyan wrote:
> On Mon, Oct 26, 2026 at 11:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > The virtio_balloon driver reports a scatter-gather list of free pages
> > to the VMM so it may discard unused pages.
> >
> > For an arm64 kernel with 64 KiB pages, the default reporting and
> > allocation orders allow entries ranging from 2 MiB to 512 MiB. If the
> > report contains a sufficient number of large entries, we will end up
> > with a descriptor chain that represents over 4 GiB of memory. This
> > violates virtio spec, which says:
> >         Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in total;
> >
> > Specifically, submitting $2^{32}$ or more breaks Rust-VMM.
> >
> > Submit each reported page as a separate virtqueue buffer instead of one
> > buffer with an sg list of all pages.  This also avoids indirect
> > descriptor allocation (kmalloc in the reporting path).
> >
> > To avoid multiple buffers causing interrupt storms, keep callbacks
> > disabled while we wait for an event.
> >
> > TODO: as an alternative, keep using virtqueue_enable_cb_delayed
> > but add buffers after there's space in the ring.
> >
> > Note: if the virtqueue is broken, wait_event on
> > virtqueue_get_buf hangs.  This is a pre-existing issue:
> > the old single-buffer code had the same hang.
> >
> > Reported-by: Ruben Hakobyan <hruben@meta.com>
> > Cc: Ruben Hakobyan <hruben@meta.com>
> > Fixes: b0c504f15471 ("virtio-balloon: add support for providing free page reports to host")
> > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >
> > Notes (changelog):
> >     changes since v1:
> >         keep callbacks disabled while draining: get_buf re-arms the used
> >         event for the next buffer, reintroducing an interrupt per page.
> >         Disable the reporting vq callbacks at probe, and only arm the
> >         delayed callback to wait.
> >
> 
> Thanks for the patches! I think sashiko-bot found some issues on broken
> queues in the first patch that are worth looking into for correctness.

Surprise removal of the balloon? Nope, it's a pre-existing issue that
it's broken.  Besides it's not really practical, no one removes
the balloon - no need.

> Other than that, I tested the "normal path" on QEMU and Cloud Hypervisor,
> both on 4 KiB and 64 KiB guests, and this works correctly.

Thanks a lot! Can you pls confirm whether the performance is about the
same/better/worse?

-- 
MST

