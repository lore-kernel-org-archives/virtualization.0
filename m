Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3986FC43381
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 09:39:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6A064E6D
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 09:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6A064E6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5583A2040F;
	Mon,  8 Feb 2021 09:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yu1yfI2BPNVl; Mon,  8 Feb 2021 09:39:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EEC4020133;
	Mon,  8 Feb 2021 09:39:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4A2FC0174;
	Mon,  8 Feb 2021 09:39:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A27C2C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 96D65864C1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:39:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UCeFuUiNJ23Z
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:38:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 720CB86499
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:38:59 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id o10so11840998wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 01:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4DGQGSkzgcC/dD62BvVBWWA5K9GNya/Azc5NShmkw9c=;
 b=BrF/s6CFFF8+P8/zewQpBGItF+0CBq4qQd9jwH9BX0gBhEOrrAE2Y9DeVv1Cqe+PG8
 6swWNn4rPizD3NE4gk7zMHMrff4n8Jw6MeEUPj/T7JVyk0TWvzClJxyWB7BHRmbp0HZ3
 hmE8E4eLRrUsCuFl148JcoJmWT9mJ8KGdVsi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4DGQGSkzgcC/dD62BvVBWWA5K9GNya/Azc5NShmkw9c=;
 b=GSescsf0wAx2O+0rJ/DrgUpNqfPVaW9MpKwuzI2Lsy3OZWfgKniawwrD8Zk9QPzGS4
 EQFV9OJKRGLV1bGXwZ1ND36wCUJpyo4vW2T3lJfF3p7VsyA1HtEq4Wkakd9WYs0AfK32
 +pSXO4kzLPtpwS0tTsI20NqH4w8kKPu9POH5CUnMOnkOGB6s/x+JqWN9OyUcHUCPG0yX
 PUxtnxJqGXmboUxmFQdxn9PUEivNeqyWhUA2SDOEnCv6dkmzVkx2EZP17nb7evsDEcFZ
 56JQw40FFgFrw7ontYy1+v0S82NSQzpqUNY5peV0Pxcqfff7ecLtFtmoxRHmd1YLzgF+
 nW4A==
X-Gm-Message-State: AOAM532drGiFxuM+HizDzso817vSUFIixBKeOVXIMj5basShY36NjJkT
 zjcUK3s4/NiAPt5PcmxXqbGnbw==
X-Google-Smtp-Source: ABdhPJzGAETbO5Jt6ZRC/GR0bn81heDLrjvHU05CkeKS+oGw67H4ItRzjTTOIwnpoRRmCRR+dmsFNw==
X-Received: by 2002:a1c:9a12:: with SMTP id c18mr13723288wme.146.1612777137507; 
 Mon, 08 Feb 2021 01:38:57 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id v15sm1548194wra.61.2021.02.08.01.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 01:38:56 -0800 (PST)
Date: Mon, 8 Feb 2021 10:38:54 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Message-ID: <YCEGrrT0/eqqz/ok@phenom.ffwll.local>
References: <20210203073517.1908882-1-vivek.kasireddy@intel.com>
 <20210203073517.1908882-3-vivek.kasireddy@intel.com>
 <YB1sRx1GrT8rATEg@phenom.ffwll.local>
 <20210208075748.xejgcb4il2egow2u@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210208075748.xejgcb4il2egow2u@sirius.home.kraxel.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: dongwon.kim@intel.com, christian.koenig@amd.com, daniel.vetter@ffwll.ch,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, daniel.vetter@intel.com,
 sumit.semwal@linaro.org, linux-media@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 08, 2021 at 08:57:48AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > +/* extract pages referenced by sgt */
> > > +static struct page **extr_pgs(struct sg_table *sgt, int *nents, int *last_len)
> > 
> > Nack, this doesn't work on dma-buf. And it'll blow up at runtime when you
> > enable the very recently merged CONFIG_DMABUF_DEBUG (would be good to test
> > with that, just to make sure).
> 
> > Aside from this, for virtio/kvm use-cases we've already merged the udmabuf
> > driver. Does this not work for your usecase?
> 
> udmabuf can be used on the host side to make a collection of guest pages
> available as host dmabuf.  It's part of the puzzle, but not a complete
> solution.
> 
> As I understand it the intended workflow is this:
> 
>   (1) guest gpu driver exports some object as dma-buf
>   (2) dma-buf is imported into this new driver.
>   (3) driver sends the pages to the host.
>   (4) hypervisor uses udmabuf to create a host dma-buf.
>   (5) host dma-buf is passed on.
> 
> And step (3) is the problematic one as this will not
> work in case the dma-buf doesn't live in guest ram but
> in -- for example -- gpu device memory.

Yup, vram or similar special ram is the reason why an importer can't look
at the pages behind a dma-buf sg table.

> Reversing the driver roles in the guest (virtio driver
> allocates pages and exports the dma-buf to the guest
> gpu driver) should work fine.

Yup, this needs to flow the other way round than in these patches.

> Which btw is something you can do today with virtio-gpu.
> Maybe it makes sense to have the option to run virtio-gpu
> in render-only mode for that use case.

Yeah that sounds like a useful addition.

Also, the same flow should work for real gpus passed through as pci
devices. What we need is some way to surface the dma-buf on the guest
side, which I think doesn't exist yet stand-alone. But this role could be
fulfilled by virtio-gpu in render-only mode I think. And (assuming I've
understood the recent discussions around virtio dma-buf sharing using
virtio ids) this would give you some neat zero-copy tricks for free if you
share multiple devices.

Also if you really want seamless buffer sharing between devices that are
passed to the guest and devices on the host side (like displays I guess?
or maybe video encode if this is for cloug gaming?), then using virtio-gpu
in render mode should also allow you to pass the dma_fence back&forth.
Which we'll need too, not just the dma-buf.

So at a first guess I'd say "render-only virtio-gpu mode" sounds like
something rather useful. But I might be totally off here.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
