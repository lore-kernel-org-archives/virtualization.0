Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489295;
	b=P21AcLPIv/KT0KaCwjoI5LM78/UmMvs2EvYrZ6bmIOm/t1DNiE/liVlA5Ia2N4dpW784
	 u98acBttG8g12q2eEp62G5LngRwmVzqrHfWIYnbE3Hywrf+mdyOV0apJYqLwBd0gH4xyQ
	 eb2/wEZsOj/07cl8or/a8lCvde7YyNJsAIVx9mihL5FM0vB2tRZsX4BFLPjRYqyGvzyGS
	 Pb3UbYDs3RDSSVYHonVSEsmWUoVY1Ks7eKk/EEWzJNGp7oGKKwkYqENR8tZfFnUtbU4gv
	 qRNfOpFQ64ycgdEGWNSJxjZTlytL1HIb2xpDAMHS/hYCWITxoAqWJ9OLXiYsslo91TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489295;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=DruToGQJ8QxTgYnIiS8jfyW7h08d1jOiadZ2C/M4nnM=;
	b=Uae6Gdy6sqvWyaLvv/veic5jsSG5UMYU4sROwb+04Un0ckGKwgXZpsLknVyTdRuJT0Vz
	 +ZK0DkDF5pYrbHyYqZ2zK2rhU7LC++LIuHrrqdW7cEsChJd7bSsX7EdbqzAULiJV/tfEd
	 qIwxgOFdF3vhHtHnGj0W6DSIl1c+pwodseotGLPhrBYCtipIxMz3cTvnGN39GMihI17o7
	 NwsQbolwLrBdtP80dO3TkbnP7VV2jyvTl5q11q91Dq4Jz0NFHhxAHnZU5yjaNKJI8G1rD
	 0xwTYaYDlRVIG5ZGOTie2ssuH7fDDVMz4zLzyiovCyjxNqL8dbeELDjXXbLyJZZd/zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="K/JJF7cn";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0818606A330
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 09:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0818606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K/JJF7cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792489293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DruToGQJ8QxTgYnIiS8jfyW7h08d1jOiadZ2C/M4nnM=;
	b=K/JJF7cn1b2v39EPXSI4LcmWuQRbWrADl1q8iTSWrSIltNdbR4rVMTKkdXGqJ64Y5n4uHk
	VUKDLUa4lYeTgz8sMAuv+ggQoO7SG2xPDossWKDWTbWefQwsrbkGR7IM/41QRhlMgRzBPz
	KSK1y8iBGhyWJZyf/B/VfMj3yKtNnJ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-gEuAtM7ANSSEC7xFnqQVog-1; Tue, 20 Oct 2026 05:41:32 -0400
X-MC-Unique: gEuAtM7ANSSEC7xFnqQVog-1
X-Mimecast-MFC-AGG-ID: gEuAtM7ANSSEC7xFnqQVog_1792489291
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so2715793f8f.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 02:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489291; x=1793094091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DruToGQJ8QxTgYnIiS8jfyW7h08d1jOiadZ2C/M4nnM=;
        b=MR0LbgpyO9sZ8pMbfIPrY+dmLJQ2J6Isc/hgtMCvNVUiMQc/5QparDCZ/TKBjkRkW4
         Rb76//yzLMUJZ+JS8fqzEvJTY69GRadlXZdMDRv87N3CNgMflyy8JfZ9IsmC5VieEvAP
         AT3XnQbJ1paXmGluyUHgha3BzPGYSRQoKonnGVir8Dlb/DeCCZgMapGFXWzmo+Uci8QQ
         xrua/QqglcKjJsXmXFPrmyijIuABGdWL4Nhd/aWq+koSAcqUprP3M2Ys/LII/JqmYi/v
         U3IyGbOJs33qtUXa/smj6ffgIjq6FvIRmcO8LdLloSZu4tQFrU4h1IiSAq8HtDXOfd5N
         4/0g==
X-Forwarded-Encrypted: i=1; AKwUvBzMRJzE/ddvT/rvMeGJC4qxJEOB7wf+8qcGjUEz3AGkitcDXKwhxXwmo8ZimzwVlDxGNrhwTqlfEFlCYxh8PA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKP7zVdsAASHIMngX1i7o9uOAJt1IGvY7Lwaj1kD/EU2ROCkBjk
	9ElvJCZpSqRqIHr/Z/RoVPhQ1ARwkmav/6jue0YaZLayNnoRjfCu/WiPAAh06qGMiZZ9DC8EXIN
	4vCscuER7tjx1YjjglXEfEKcOtFYh7a1tM8d4ZzkefdN9Yn/Du6BTib8tuvMyfy4zkAE2
X-Gm-Gg: AYBFou0k0rFNpoHoyRd9Qzii9XwbrlTpdlXbbKzPoT2GGYe0AXHJf2iIZm98RUAJ83H
	8m+28f2xFFwAyCaflw+NDArd9qFN4Fhpi87nN3acPG8o2s0d1jxrJHLwtSsu2JXavZ2Xa0+1+nC
	Z+tO9+BPau7wZMbcWG2+bZ7V66cBhvHCAuIrldbnpc+pEUP8hjkf3KDiBvQiTAw6G03XdOxFRIS
	xeOwLp8dOr+OIcmIHG3mUVWgL1Xr2U0o711z5pmlf+blAV80ZckWzsPqYuFgFX0zE0HlW17pJRV
	PHli1YZ72cGsfU1sXQR9YgpTRFJiKs7jeHRGs4zgq+qvNwCOm9v/1HedD6tPZxzb/e4s8w==
X-Received: by 2002:a05:6000:4288:b0:48a:fbf7:15c9 with SMTP id ffacd0b85a97d-48e079888a1mr21624725f8f.1.1792489290962;
        Tue, 20 Oct 2026 02:41:30 -0700 (PDT)
X-Received: by 2002:a05:6000:4288:b0:48a:fbf7:15c9 with SMTP id ffacd0b85a97d-48e079888a1mr21624669f8f.1.1792489290347;
        Tue, 20 Oct 2026 02:41:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82dec7sm4899460f8f.46.2026.10.20.02.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:41:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 05:41:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Wang Haoran <haoranwangsec@gmail.com>, torvalds@linuxfoundation.org,
	jasowangio@gmail.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020054100-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAJaqyWfcg_K33c5hzSh83vgTvujn_M_8odcxFSTVzkcv6jQu9g@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfcg_K33c5hzSh83vgTvujn_M_8odcxFSTVzkcv6jQu9g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XWIuyG5s4Jm8OOqJGE_dltUcOaHTAs-vTXpkfHBAy1k_1792489291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 20, 2026 at 11:22:59AM +0200, Eugenio Perez Martin wrote:
> On Tue, Oct 20, 2026 at 8:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Oct 19, 2026 at 03:14:46PM +0800, Wang Haoran wrote:
> > > Eugenio previously offered some additional suggestions in reply to
> > > my patch email. Should these also be addressed?
> >
> > The following seems to work for me. Testing would be appreciated.
> >
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Subject: [PATCH v2] vringh: use get_user/put_user in the use_va path
> >
> > getu16_iotlb()/putu16_iotlb() pass the address produced by
> > iotlb_translate() straight to __get_user()/__put_user(),
> > without access_ok checked anywhere. Not good.
> >
> > Switch to get_user()/put_user(), which are always
> > correct, and safer.
> >
> > But the fact is that accessing user memory like this
> > will sometimes (rarely) race with page being swapped
> > out, trigger EFAULT, and it should be retried
> > from a worker, and vdpa_sim currently does not do this.
> >
> > Fixes: 42823a871fd4 ("vringh: support VA with iotlb")
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ---
> >
> > Notes (changelog):
> > v1->v2:
> >     Use get_user()/put_user() wrapped in pagefault_disable() instead of
> >     access_ok() followed by __get_user()/__put_user(); the helpers are
> >     reached from BH-disabled sections, and __get_user() is not a valid
> >     way around that (David Laight, Linus Torvalds)
> >
> >  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 2 ++
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 ++
> >  drivers/vhost/vringh.c               | 4 ++--
> >  3 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > index 76dd5b0828d7..325ec8f0ab85 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > @@ -347,8 +347,10 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim)
> >                         smp_wmb();
> >
> >                         local_bh_disable();
> > +                       pagefault_disable();
> >                         if (vringh_need_notify_iotlb(&vq->vring) > 0)
> >                                 vringh_notify(&vq->vring);
> > +                       pagefault_enable();
> >                         local_bh_enable();
> >
> >                         if (++reqs > 4) {
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index a6514b5ccd86..964cdf422467 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -77,8 +77,10 @@ static void vdpasim_net_complete(struct vdpasim_virtqueue *vq, size_t len)
> >         smp_wmb();
> >
> >         local_bh_disable();
> > +       pagefault_disable();
> >         if (vringh_need_notify_iotlb(&vq->vring) > 0)
> >                 vringh_notify(&vq->vring);
> > +       pagefault_enable();
> >         local_bh_enable();
> >  }
> >
> 
> Why not move the pagefault disable_enable to wrap just the accesses?

We want most accessed with PF enabled, so memory can be faulted in.

> Future vdpa drivers could use va and we might miss the call. Also, the
> reverse is also true, vdpa_sim could be configured to not use it, even
> if it is not a big waste.
> 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 9066f9f12ba1..74836eb60c7a 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1213,7 +1213,7 @@ static inline int getu16_iotlb(const struct vringh *vrh,
> >                 return ret;
> >
> >         if (vrh->use_va) {
> > -               ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +               ret = get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> >                 if (ret)
> >                         return ret;
> >         } else {
> > @@ -1251,7 +1251,7 @@ static inline int putu16_iotlb(const struct vringh *vrh,
> >         tmp = cpu_to_vringh16(vrh, val);
> >
> >         if (vrh->use_va) {
> > -               ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +               ret = put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> >                 if (ret)
> >                         return ret;
> >         } else {
> >

