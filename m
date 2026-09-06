Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FEA3BB13B
	for <virtualization@lists.linux.dev>; Sun,  6 Sep 2026 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788677000; cv=none; b=fu43tt2dlPDIJa/QHtGbeA9m2PLgNXq0CMypmjeyToJrr+EPmqgqM42E/DokqGUrOjN7DzhhtOPDUYFkhDakbNUoFK3Zaa5gOaRLrURvSLyar/ICiYoaFMLzLYNTyMq86K7yiXU2Ndma5b9eCu4jo25a3PjW7zETBxidjc0ulhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788677000; c=relaxed/simple;
	bh=aeVqNouzSdYIpv4jAsF0eK1ZF0yh+/lKYMq2kFn1TlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gBIeuvL0T0VAaqv89M6llmrpUee9RlSXlxOazDeW9hL3977Bc4J0+8vGnghk7vsAFkrEowCgejyJLa3vDeiNibn84G6wsNusBxTh4bWONRH62GWhlNzLMNxAHoKg91MRt9b4PPOrLexrXgWCL4/sainHTcfW9hWygjaL4oHDf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpogmUwo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpogmUwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788676997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JFzl9H4Eb8cyafOk0wAUSRBkZEcWcFmHLhnYc0Tm+4s=;
	b=hpogmUwo+JwpbImwhXQsOqEnz4n22rHhDvLrKV03XSU7/UbWa0NdfKm/JXUSU7p52/kH6/
	bZfkyMZAfxKvVFTX7I+OO83k5SeGv7HF4iuOdcoizN/siLLxz1hw4NhfxyxlhTRBn9+rdt
	+aZZid10aClcMFA0nzBY0sp8rZsKZG4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-A8bHODaNOJS6d4c4tAj0uQ-1; Sun, 06 Sep 2026 02:43:15 -0400
X-MC-Unique: A8bHODaNOJS6d4c4tAj0uQ-1
X-Mimecast-MFC-AGG-ID: A8bHODaNOJS6d4c4tAj0uQ_1788676994
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482f41ca436so1975396f8f.1
        for <virtualization@lists.linux.dev>; Sat, 05 Sep 2026 23:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788676994; x=1789281794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JFzl9H4Eb8cyafOk0wAUSRBkZEcWcFmHLhnYc0Tm+4s=;
        b=O059FFA0LAeetStt1gGbern/7YeNHPXrlQeWLsJORV8bEtdiIOmRhmMrwBCC1Xgc7y
         F0bu2C0L7143eLJxxLItB9r8OqNN2FMRcQkNk2pDZQ2Cy5DFG4I5nK7LL3WNf1g617ED
         lDLSy/FB3wLFZaV+hb9F5Y6hBjj+TFKgqkycg4gOs3ku1G3LPOR6Smqrv5aZ3E+Sei/u
         geEs/ljXtpqt4eKP6FsvEn1st2FpN+SQHLcKbiiCJrQA/3OeLZvM1sqkJb+Xeb5Hy9a8
         jex/WmKaklz7du3RxPQsk4PXnrF/QWcWi34TgVcZjJuCJZ5HUrb9G4wSqC5oNcPalAoT
         TAIw==
X-Forwarded-Encrypted: i=1; AKwUvBxueePJoS/oL5tVrM5h2fiNQVuedNFPaSgrPZGpHXLS9wcs3KY3t2Jcu5kbnF6rLaSbACSenSFbxbIbPGpq1g==@lists.linux.dev
X-Gm-Message-State: AFuF++mzxgbnsu6vsiFlWHn5tkBno65wu+O+ZxUaR1VJKSerb/gHn5Nl
	f0CPF+3CTFB0qNZLK5UimjUAGyXfpEJjQJv7UD+nKqTQSc6FKU+2dImqvtikGeVBYZKBztrqg7C
	7hyQ0aG5e6XGSSXZf6NJjiu6KLZaPE1GOz/q/DjZVzrjHJkXWYOEjEfCxGJGi4YbQVom4
X-Gm-Gg: AYBFou0jexgrHRj1Mwjq713ba2fKUzwIs7IFWag3mC/aL6CW70g1MXUOsMz44WagF0n
	sK9qb+SfSES8f2FTGKNbT3UVVMM2lL3k5x6onjqEe31vhTABBZNkJqlmiH+BrwiOz/YSMV7zrUm
	eGGIjL96Jfd3S+h+hZyKy2GuOki9d8qRiDxpyIMoi5mAqzMTVcE6GsU+5C7CQEGetN05BL7xJ1w
	zz1knd1Nxed1eUJHL4/l8xJRwnsGrUcTh28qjo7If7+zUJbXJ38p2EsDilhxCUq467MmkZOt0fd
	UuWo6Q8Xd8Ccwg0SFy68pl9X28unP7Gf/U3sFXher1RlgYUv9LDt49R4F+xKYNJa3X32z3RjvY/
	gLrkBqdBmC7OtW2v4jWKTXwg=
X-Received: by 2002:a05:600c:3b18:b0:49c:fa21:1c8a with SMTP id 5b1f17b1804b1-49cfa211d97mr123999845e9.31.1788676994384;
        Sat, 05 Sep 2026 23:43:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3b18:b0:49c:fa21:1c8a with SMTP id 5b1f17b1804b1-49cfa211d97mr123999575e9.31.1788676993918;
        Sat, 05 Sep 2026 23:43:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm648354005e9.0.2026.09.05.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:43:13 -0700 (PDT)
Date: Sun, 6 Sep 2026 02:43:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev, linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org, kvm@vger.kernel.org,
	linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] virtio: synchronize callbacks during device reset
Message-ID: <20260906024233-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: peE-TGREP6wh7UOuRAyhlDg1CrJ2stdN7qwPCwr5lek_1788676994
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 05, 2026 at 05:20:56PM +0200, Karl Mehltretter wrote:
> A virtqueue callback can outlive virtio_reset_device() and race with a
> driver freeing the state it uses. The reset helper documents that no
> callbacks remain in progress, but that depends on the transport:
> virtio-pci waits in vp_reset(), while virtio-mmio does not.
> 
> virtio_input has a related ordering problem: it unregisters the input
> device before resetting the virtio device, while an event callback may
> still be using the input device.
> 
> Patch 1 moves the callback wait into the core, using the existing
> virtio_synchronize_cbs() operation. Patch 2 fixes the virtio_input teardown
> order. Patch 3 adds the missing synchronize_cbs hooks for UML, TmFIFO,
> remoteproc and virtio-vdpa. Remoteproc uses one SRCU domain per processor.
> 
> The new hooks wait for callbacks already running. UML, TmFIFO and
> remoteproc still allow new callbacks after reset; fixing that is separate
> work. The event-virtqueue DMA mapping issue is also separate.
> 
> Changes in v2:
> - Patch 1: move the wait into the core instead of fixing only MMIO, as
>   Michael suggested. Remove the duplicate PCI wait, preserve its shutdown
>   wait, and fix CCW callback locking. Drop the MMIO polling: reset polling
>   for v3 and newer is already in fa8833c085b6 ("virtio-mmio: add support
>   for transport version 3").
> - Patch 2: keep draining completed events when ready becomes false,
>   instead of breaking out, so teardown does not truncate an input packet.
> - Patch 3 is new, at Michael's request.
> 
> I reran the 120-cycle unbind/rebind test in an arm64 KASAN guest with four
> vCPUs and a 5 ms busy delay per event. With patch 2 alone over virtio-mmio,
> reset returned with the callback still running in all 84 overlapping
> cycles. With the series, it waited in all 103. Over PCI with per-queue
> MSI-X, it waited in all 66, including runs with threadirqs. No KASAN or
> lockdep reports. These runs predate the per-rproc change, which leaves
> the tested MMIO and PCI paths unchanged. They confirmed the missing wait,
> but did not reproduce a use-after-free: with evdev attached,
> input_unregister_device() waits for an RCU grace period that the IRQ
> callback blocks.
> 
> That version also passed QEMU input, rebind and shutdown checks on arm64
> MMIO and x86-64 PCI, including arm64 RT, KASAN and KCSAN builds, and x86
> UP/Tiny SRCU. A legacy INTx NIC was present for an additional x86
> shutdown check. The changed objects built with W=1 without warnings on
> arm64, x86-64, s390 and SMP UML. The per-rproc version built with W=1
> on arm64 KASAN and x86 Tiny SRCU, and passed six remoteproc callback and
> lifetime KUnit tests on each, using mock remoteproc devices.
> 
> Link: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (3):
>   virtio: synchronize callbacks during device reset
>   virtio_input: stop callbacks before unregistering input device
>   virtio: implement synchronize_cbs for remaining transports
> 
>  arch/um/drivers/virtio_uml.c             | 10 ++++++++++
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 14 ++++++++++++++
>  drivers/remoteproc/remoteproc_core.c     | 10 ++++++++++
>  drivers/remoteproc/remoteproc_virtio.c   | 20 +++++++++++++++++---
>  drivers/s390/virtio/virtio_ccw.c         |  6 +-----
>  drivers/virtio/virtio.c                  |  2 ++
>  drivers/virtio/virtio_input.c            |  8 ++++++--
>  drivers/virtio/virtio_pci_legacy.c       |  2 --
>  drivers/virtio/virtio_pci_modern.c       |  3 ---
>  drivers/virtio/virtio_vdpa.c             | 21 ++++++++++++++++++++-
>  include/linux/remoteproc.h               |  3 +++
>  include/linux/virtio_config.h            |  6 +++---
>  12 files changed, 86 insertions(+), 19 deletions(-)
> 
> base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3

changelog?

> -- 
> 2.39.5 (Apple Git-154)

