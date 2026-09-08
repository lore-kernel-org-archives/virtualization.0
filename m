Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C2427FBE
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855970; cv=none; b=P5cpkOAcqy5KN8ClWeVYyTo5ncP65D56AC4Y+mne8A6znRYgHpRIEWRG6G+mcG0FQFVQqpagRHwHbGVDqH7F83xc9mZEg6j5HaieruC354yhEE69oJhTcTvu11R3Ps1dFvm5MrCpGT5NH1j6+fPBmwuDbv6Qq5DDz8wESTp3l/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855970; c=relaxed/simple;
	bh=mtlzNqSHslbgTL1E+s1EGrdbdVuzUh95XoEfQxCcoHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NCz6SiOtId86GAOtaeBw4jLgw5n9li/QD5s/jx0yIne4qZxFe+rQtTj+lCia0/5KznIK1fTvE/D3mC8q9ae+HH07MikErlQY4Rhoqdl0Q7DX/bsj+1kRtkifhyw97zCszqo/uEWXjgvgS8cHEpg0QNa0HXvEkTm7BZCJIjiot24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+H7kWc8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+H7kWc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788855966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=;
	b=f+H7kWc83vNv4Y6sIBNWa0K7KgYNWVEMa44dRGMWuNybqnS7g7ajuGDMCdxrho3FNIGpZ4
	hcHPIbG2qP/aA/qPUW0PSWevcaZQCA2hsKFksLQKmVZ1cT4rWKpyqRrbhdDitDHUhYcMHj
	AaTl9K3aI2zLd30uLGcAQhPsSkICvuY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-6uxDF2izOSyGbYYGoKsQaw-1; Tue, 08 Sep 2026 04:26:05 -0400
X-MC-Unique: 6uxDF2izOSyGbYYGoKsQaw-1
X-Mimecast-MFC-AGG-ID: 6uxDF2izOSyGbYYGoKsQaw_1788855959
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-499913d1a79so29149995e9.0
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 01:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788855959; x=1789460759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/cIx/FN1ld5ZUnvvOO4W6SfTMNv+qsyUKpor9qdoZ3s=;
        b=lV3tYxsKSorXBW5EUK/36T7d7khv6FSNUwR/cWM02kVwMwVdIiBbNfkUISfgcivYAz
         5rRDSsoMf/gZVTv26xJifsb+dSV+30O+vR3bkFhtzburF/lLV1XLL87twtPmDqvRsNXv
         QxfRjhq16ENvwHqx0b/3AqqDrhCSP/aibqXQOcXXaGQDQZrfDqmoAs7O1UKd1l5YInNl
         WvIOnqLtzro23SiD5g0xrXT5JIRGVOu5RE6cp+afkSluGZRdhSFnUkHrBygYRl+ORgpN
         tPtZYARu4XeGZwogFoC4pts/qCmTxvcG1p44Q8VPQBkTWy4zE0ly1sUeKctcJeL8hK6P
         VV8g==
X-Forwarded-Encrypted: i=1; AKwUvBx2eVqz9eeppcNfjY2F8+hotEqT5onCVthk4EMVBt0dHyPlmNGhNZOrtwBFW/SHb0OwS2KW5wDLQ9BGPpJvQA==@lists.linux.dev
X-Gm-Message-State: AFuF++lb0D7HIM8NWbhiK961J7tHdjX4B0ppYZGKlcJouNEgPlaS2IX2
	NtEP5+HODO/ndrg/Ld0RcVfnxLKJfe5hweC3ENzhXV5uh36JRUM+lyKhORpNPvylBDUbtrhSIv0
	MlzkJKxD4D7vmeNowpE1C6diSAD2ytrFuDgZvebq7K4pjQptByMA8/mt4dMbS4YYBqM2d
X-Gm-Gg: AYBFou07pK7F5Ndmu9ndMZsdP7n8Q+yDX7aNYV6fwTwpWUpN//CFQSRWkGc0iENFZPZ
	LcZCYVtophY9l0FT/yCzQnrJDFtDalN2YprwqCCFzaveI21IrV7SY60kOmY4/i7CfbFF9oXZgLK
	il/7LRNHF80uuOeyNQ1RDNMCsypxTM85IyUI3M31TDUO+eUVc2CALCSY+SOYGxUZrsKxU3fP0ya
	rJ34FDNjmNlmwQV/f6Q3VEYnPFklYGiCd5JNAItGjPCmDqzSWPUABplTmomyB/HWg2ouX0btmUE
	mMRsUjPYvkT/RuoQRl/euAW8de091T4X4tPc6pK96TtbvwE28IVTinudkFoGKasUTLMpd5G6oMf
	5PcAZWBIoUCcXgt+2BTq28TA=
X-Received: by 2002:a05:600c:c4aa:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49cf8241a84mr469629115e9.9.1788855959356;
        Tue, 08 Sep 2026 01:25:59 -0700 (PDT)
X-Received: by 2002:a05:600c:c4aa:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49cf8241a84mr469628205e9.9.1788855958792;
        Tue, 08 Sep 2026 01:25:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d04fe7f9dsm275644125e9.0.2026.09.08.01.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:25:58 -0700 (PDT)
Date: Tue, 8 Sep 2026 04:25:53 -0400
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
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 0/6] virtio: fix and add callback synchronization hooks
Message-ID: <20260908042440-mutt-send-email-mst@kernel.org>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3jGyIKoPBPNejK3nXr7HwknFl8WJk-8NlX2YrJ5fRNY_1788855959
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2026 at 07:38:11AM +0200, Karl Mehltretter wrote:
> This is v3 of the callback synchronization series. It is based on
> Michael S. Tsirkin's linux-next branch at f49e6cf91942 ("virtio:
> synchronize callbacks after device reset"), which already contains the
> core change and the virtio_input teardown reorder from v2.


Thanks I applied since this looks like a net improvement.
Pls keep iterating on the core change.
If you want to take a stab at some of the pre-existing issues -
will be welcome.
Pls do note which patches were tested and which were not.

> Patches 1 and 2 fix two bugs in virtio-ccw's existing
> synchronize_cbs() hook. After a fallback from adapter to classic
> interrupts it selects the wrong lock, and the classic interrupt handler
> only takes the matching lock when notification hardening is enabled.
> Patch 3 adds SRCU tracking for remoteproc callbacks, which can sleep.
> Patches 4 and 5 replace the RCU fallback with synchronization against
> the UML IRQ and the TmFIFO callback locks. The fallback already covers
> these IRQ handlers and spinlock sections. Patch 6 adds SRCU tracking
> in virtio_vdpa so callback synchronization does not depend on the
> context in which the vDPA driver invokes the callback.
> 
> The UML, TmFIFO and remoteproc reset paths do not themselves prevent
> new virtqueue callbacks. UML and TmFIFO only clear a status field, and
> remoteproc does not wait for the remote side to acknowledge the reset.
> Without notification hardening or driver-specific teardown protection,
> callbacks can still start after reset. The new synchronization hooks
> do not fix that. The TmFIFO hook also does not synchronize with the
> rest of the FIFO work item outside the callback locks.
> 
> The virtio_input loop change from v2 (continue instead of break, so
> events the device already completed are still delivered) and the
> event buffer leak are sent separately.
> 
> Changes in v3:
> - Rebased on Michael's linux-next branch. Dropped the core change and
>   the virtio_input patch, which are there already.
> - Split the virtio-ccw fixes out of the core patch, one per bug, and
>   the transport patch into one patch per transport. The CCW and TmFIFO
>   changes are functionally unchanged from v2.
> - Patch 2: added a Fixes tag and described the existing shutdown
>   case. Removed the dependency note on the core reset change.
> - remoteproc: read the queue pointer once in rproc_vq_interrupt(), and
>   synchronize with callbacks in __rproc_virtio_del_vqs() before
>   freeing the queues (Sashiko). Place vq_srcu next to rvdevs so the
>   hunk also applies to mainline, which added attach_work after index.
> - virtio_uml: compare against UM_IRQ_ALLOC instead of a bare negative
>   check.
> - virtio_vdpa: use SRCU instead of a per-device rwlock, so the
>   callback tracking uses per-CPU counters, and cover the config
>   callback (Sashiko).
> - Rewrote the commit messages. Corrected the RCU fallback description
>   for UML, TmFIFO and the vDPA simulators. Dropped the claimed simulator
>   reset race: the simulators disable bottom halves around virtqueue
>   callbacks and serialize reset with the worker's mutex.
> 
> Changes in v2:
> - Moved callback synchronization from virtio-pci into the core, as
>   Michael suggested, and added the missing synchronize_cbs() hooks.
> 
> Testing: the changed objects build with W=1 without warnings, with
> clang on arm64, x86-64 and s390 and with gcc on SMP UML, and the
> patches also apply to current mainline and linux-next. The runtime
> tests from v2 were not repeated on this version: the input, rebind and
> shutdown checks on arm64 MMIO and x86 PCI covered code that is
> unchanged here, and the remoteproc and virtio_vdpa hooks have only
> been build-tested. No remoteproc, TmFIFO or s390 hardware was
> available.
> 
> v2: https://lore.kernel.org/r/20260905152059.89560-1-kmehltretter@gmail.com
> v1: https://lore.kernel.org/r/20260818040433.66986-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (6):
>   virtio_ccw: fix synchronize_cbs() after interrupt fallback
>   virtio_ccw: always take irq_lock in the classic interrupt handler
>   remoteproc: implement synchronize_cbs() for virtio devices
>   um: virtio_uml: implement synchronize_cbs()
>   platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
>   virtio_vdpa: implement synchronize_cbs()
> 
>  arch/um/drivers/virtio_uml.c             | 10 +++++++
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 15 ++++++++++
>  drivers/remoteproc/remoteproc_core.c     | 12 ++++++++
>  drivers/remoteproc/remoteproc_virtio.c   | 37 +++++++++++++++++++-----
>  drivers/s390/virtio/virtio_ccw.c         |  6 +---
>  drivers/virtio/virtio_vdpa.c             | 34 ++++++++++++++++++++--
>  include/linux/remoteproc.h               |  3 ++
>  7 files changed, 102 insertions(+), 15 deletions(-)
> 
> 
> base-commit: f49e6cf919425cc55f10fd7cda7e0fc895df4cc0
> -- 
> 2.39.5 (Apple Git-154)

