Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DD383310
	for <virtualization@lists.linux.dev>; Sun,  6 Sep 2026 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788677596; cv=none; b=NiePv6EvPpsps8rIJOyBhQwyQ/pV6g9bZ2uFq6PKa2akFSyqlxpKWAIHkaEMdbYbdYupohkHOb7D1X9epD+7xQlRnN28KuG82Uciihvbz6xKD/7PpvL0Ud0Vn1ltEjejpY3aVT+ZX+N+wASFRbj4RttgWJMKjH2xgvt0vD0dM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788677596; c=relaxed/simple;
	bh=0PsOoZ9E0BwunGG9ae2zYdRQMe8ZwVOWFfFaILVsAVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L5WraaB/JtjbFuQULfM3VUZAhi21PUZeyo7ur1fY8MKx3fSlHAa6JfZgk3cEnHX9UZEFe0mVnXKn3L7ErfIG1h2UehAlnNkttv956xvXy1bYRfAYSiOXnYcWIuwjBwplrFpIuwOsgIMac+XjRehPje4Nl9MLj9PKKHch04Cf4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnumEXMP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnumEXMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788677593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uDjy72BsvDFpaL9e5tQovRjuStP4IqOhC4YA9r9skOM=;
	b=UnumEXMPRSO/NP7PgvyQcw7YAbph/wzDPJ1HZspdMwceSilCUdBVk2e9+21XEUXbEYWZaR
	zcm9J79N37ZfVZDaDrPkf1naCh5/VtB5yPuuXRMKBgvC3IBOkNGEttEpz8rjjrMosSzNOn
	VZDdSteUuIbs5qcWcsehs8fHfo5NG8k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-nSfHKMqkNtyveV1ZNiixBQ-1; Sun, 06 Sep 2026 02:53:12 -0400
X-MC-Unique: nSfHKMqkNtyveV1ZNiixBQ-1
X-Mimecast-MFC-AGG-ID: nSfHKMqkNtyveV1ZNiixBQ_1788677591
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-482f763db88so1365425f8f.2
        for <virtualization@lists.linux.dev>; Sat, 05 Sep 2026 23:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788677591; x=1789282391;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDjy72BsvDFpaL9e5tQovRjuStP4IqOhC4YA9r9skOM=;
        b=eXEAtWgGVRZ+3NcRwg3ewFeXC58V9a07kLyTVRH5zChJf/SwylldY3dHCIWgtSARZt
         mYvRu/8nG/A1zvTq7ejqH7+33CHZ56uFheJApfwiZ53DaID8A8aBqG6dvjvXgZWESKtz
         Wb/gUeK/BckVXUG6HffVO4Bys2zV05vbWzZkIMdGv2smJM5HiGOBGnRv40QeBxO0orAx
         Z/AOJrNphk5yrsVLyOaLy0xefg2UI4kgT1GirGYiSQs6C7YGl6OulUFSXikLKFMjxl4f
         Px1PB5HavNAUOCiTeJeLhPsGOzaVJyqeJGh+iS5zDxxNqiWQPvScOEUhgiZ5jjKca3Ot
         6Leg==
X-Forwarded-Encrypted: i=1; AKwUvByH1yWA63jb0qFOkei/opt27ePa8GYmkxOMBgO1x6nIJ/Pvy82C2iF69f9c1wT3+ciRG9Ls+tZDJd0FU3hG9A==@lists.linux.dev
X-Gm-Message-State: AFuF++mQ6pohqj5BmbfaPe6TBA5zzSpY97rAlOYgurp3Czo82OgGOZch
	s78nzkj2WAN6tumNFrADQ/+qqxZ0Av75qix9Z3uGCfC+yiaColp2LsRG6wTSxzblhCkI6AaA2ea
	E+EOC1XYbJIp3diHqanNqlCUSi29mRbYJ4vSowG5t6J8Yx9pySS2qMY2RL6ZDHOixproV
X-Gm-Gg: AYBFou0NXYCdhPCsFvLHDJYS9pWGUdqaGmBgg/5FIUc76Av9q2P2+ZLQMLz/KPdGuth
	3ehUuJ9ts1H52EQlZdjwbotYhD8vpTlJ3BWLSKylJHiOPMDLo0tA8m2YeXOg+miy0bpt4gHkUUp
	BEbvJ9Y+AG38fnZm92GUCa6ze8ig3GFTS0rEFQPa9j7UeodP/Fs+KSYHap/USInXHF5bLm+9TjG
	m2TLb2pMzPNx353Y7MMJvGQgDriFhdHMwb+fiQ47ygglRB26WywQthYqSDVsx2zUrwkD6wTU7PO
	I8VfAeI2nAkMydQnV6Rm3hdzoUOo10GOYDBqmR9kl4AQYcbdMqy/3XqhG1ujuLWtTQ+hFr46gg5
	INFwYWNT0rxYIbhzIu9+uGTk=
X-Received: by 2002:a5d:64eb:0:b0:482:e4bc:51a8 with SMTP id ffacd0b85a97d-485870899cfmr18773118f8f.7.1788677590873;
        Sat, 05 Sep 2026 23:53:10 -0700 (PDT)
X-Received: by 2002:a5d:64eb:0:b0:482:e4bc:51a8 with SMTP id ffacd0b85a97d-485870899cfmr18773081f8f.7.1788677590394;
        Sat, 05 Sep 2026 23:53:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883acd33sm18455464f8f.18.2026.09.05.23.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 23:53:09 -0700 (PDT)
Date: Sun, 6 Sep 2026 02:53:05 -0400
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
Message-ID: <20260906025249-mutt-send-email-mst@kernel.org>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kcaxKiSDNPbIt6aC28L4au0bdaIlAK5-NZm5vRhw_P8_1788677591
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


You didn't send patch 3.

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
> -- 
> 2.39.5 (Apple Git-154)

