Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA53B795
	for <virtualization@lists.linux.dev>; Mon,  4 Mar 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560704; cv=none; b=qAVXvq6oIYnG1ldEQdP8Pf08E5OgkYx1R1n8Ue/fcBuFMxBtC8SjU/nb24r7uSmiLou0VPuaA/UQtDfAIMFsQjM71dckpdWqsiplJ6J2vBCDpzZFtH2uqNJH4wLkyM4MSsjCW7cXbJjzOPe3bWKVzgFqoQLHURVqVFctbGt7ie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560704; c=relaxed/simple;
	bh=GIIoMXTb+jubmj3EvUmA/6kXLnrIGswSSlxeQCgWaHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLY9e5uxQA7y7cr1NQePc+ddpYNM/2nsyPkPPNJcXiXccQuD5LiYuD9YUM4xW57fZezWKb7dILsXLTl4cGdks+Sqjrphr2NsDGZ/UIYwxdbKx9eyOSq8seT8KTNLWP2MZT7HSdg1l7aLrumcAi81WPsnigJn/xqhBNqfRyg1neI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx8c3Dls; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx8c3Dls"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69069235a0eso806836d6.0
        for <virtualization@lists.linux.dev>; Mon, 04 Mar 2024 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709560702; x=1710165502; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Plfy//rsylxMHB4eQxxysPEOJTihZRQSC1sBjCrslCI=;
        b=Mx8c3Dls/ASs5gMYWQOWDhgTQfQ2oItSq/Rau6kE5pPWBWGlXYUEB+7n7o7OheIyVq
         sW9YTFH9jWHNgGD8N49wCB2pmwSSxWXHmDIvRwCV8ng9hgFbPwmflnDD708g2obzIvai
         k7pEelTd5uNKKLjU1wwpN6Z0lLCwV7Cez9VOA9NOiIzpVhlLbGWLtAUEtmrApHjdb7GJ
         t6sTP9GVFXRL9Zm2QyXcdtcU+bQE0sJrkFk6c91sdKnmSLDpC5xFeca26sg9Ep7Is6Rd
         W8gfdSaQKZm6WmGU/bvI0QKk0bGysH2TjhDYbMw6iBWWleWrkzmVHLBCVarbq4FnyWQU
         O8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709560702; x=1710165502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Plfy//rsylxMHB4eQxxysPEOJTihZRQSC1sBjCrslCI=;
        b=stPR44eVpQQtTN5Tle7kimxcsotj79rkUZ2ASt2xFPtKhyR7Pij2H/wLwdsQ4m4ayt
         /Lo0qOynWws3jipUugjD0DiskJAGM5Idcvfp9nnBumV6rAm+0T9MHu1qbBuTPKx5XFxP
         /LJqJH8pXNHCMlEQ9b0BQcjLvVRzwOUHzepzd5kvBP5pXoJM9eBBnE3u6iJq9yQVzAct
         jbIVZNwyOvIMbZAQBYSp6l0cubbpNYTktpVUDRxIJhPqNzq/vCOoUlfwKyAb/zTEQLNI
         eFdGafNoB9zbBFlhy1JD7sa3s0MfDuOQXEwA2jjJSLaTK5IQV3J6yEp75C+whgxhuoMH
         h/wA==
X-Forwarded-Encrypted: i=1; AJvYcCVRzPsO19eEldycxsJwGdza4iMZCZfXWdn96G2XIwihpTzSeGhIe7hwO9+rSJeAo2fDUBAi0p0k10Twskbbdx+mGCpaouaO004Hj/GMCFk=
X-Gm-Message-State: AOJu0Yzc5A5Cs33ilYxtQ0cpryuTsMhuQvWmk9aL00VNKi5/tqlnlMM3
	3+vaWhZVN9aEgS3Ym/PzdcheHxmLSTSA7pGMieIaoRQnWxGm/I21QhmSzI7665dwwBBQsXjLDN9
	P6pUG2NNXyZ4bIisV5z+utS7p6Gs=
X-Google-Smtp-Source: AGHT+IHVsvq0lEKFqn6fHC7GP6xP5UnPXqrWeVUiUt2RohzlqrCuJl+Isr9qbkGFJVhgPQdYWTGuml8Vs9zhghbXs5M=
X-Received: by 2002:a05:6214:1bc7:b0:690:3c85:c5b with SMTP id
 m7-20020a0562141bc700b006903c850c5bmr10351360qvc.3.1709560702082; Mon, 04 Mar
 2024 05:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1709118325-120336-1-git-send-email-wangyunjian@huawei.com>
 <75b6f7686c03519a1aaeb461618070747890143b.camel@redhat.com> <55ef319de7084614b1883018f69de1eb@huawei.com>
In-Reply-To: <55ef319de7084614b1883018f69de1eb@huawei.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 4 Mar 2024 14:58:11 +0100
Message-ID: <CAJ8uoz0xjdw7iHjP9=9wFPq21A6LdcYuGZBgwUKRemzkB5XoNg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] xsk: Remove non-zero 'dma_page' check in xp_assign_dev
To: wangyunjian <wangyunjian@huawei.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "mst@redhat.com" <mst@redhat.com>, 
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"bjorn@kernel.org" <bjorn@kernel.org>, "magnus.karlsson@intel.com" <magnus.karlsson@intel.com>, 
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>, 
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, xudingke <xudingke@huawei.com>, 
	"liwei (DT)" <liwei395@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 13:52, wangyunjian <wangyunjian@huawei.com> wrote:
>
> > -----Original Message-----
> > From: Paolo Abeni [mailto:pabeni@redhat.com]
> > Sent: Thursday, February 29, 2024 6:43 PM
> > To: wangyunjian <wangyunjian@huawei.com>; mst@redhat.com;
> > willemdebruijn.kernel@gmail.com; jasowang@redhat.com; kuba@kernel.org;
> > bjorn@kernel.org; magnus.karlsson@intel.com; maciej.fijalkowski@intel.com;
> > jonathan.lemon@gmail.com; davem@davemloft.net
> > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>; liwei (DT)
> > <liwei395@huawei.com>
> > Subject: Re: [PATCH net-next v2 1/3] xsk: Remove non-zero 'dma_page' check in
> > xp_assign_dev
> >
> > On Wed, 2024-02-28 at 19:05 +0800, Yunjian Wang wrote:
> > > Now dma mappings are used by the physical NICs. However the vNIC maybe
> > > do not need them. So remove non-zero 'dma_page' check in
> > > xp_assign_dev.
> > >
> > > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> > > ---
> > >  net/xdp/xsk_buff_pool.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c index
> > > ce60ecd48a4d..a5af75b1f43c 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -219,16 +219,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> > >     if (err)
> > >             goto err_unreg_pool;
> > >
> > > -   if (!pool->dma_pages) {
> > > -           WARN(1, "Driver did not DMA map zero-copy buffers");
> > > -           err = -EINVAL;
> > > -           goto err_unreg_xsk;
> > > -   }
> >
> > This would unconditionally remove an otherwise valid check for most NIC. What
> > about let the driver declare it wont need DMA map with a
> > (pool?) flag.
>
> This check is redundant. The NIC's driver determines whether a DMA map is required.
> If the NIC'driver requires the DMA map, it uses the xsk_pool_dma_map function, which
> initializes the DMA map and performs a check.

Just to provide some context: I put this check there many years ago to
guard against a zero-copy driver writer forgetting to call
xsk_pool_dma_map() during the implementation phase. A working driver
will always have pool->dma_pages != NULL. If you both think that this
check is too much of a precaution, then I have no problem getting rid
of it. Just thought that a text warning would be nicer than a crash
later.

Thanks: Magnus

> Thanks
>
> >
> > Cheers,
> >
> > Paolo
>
