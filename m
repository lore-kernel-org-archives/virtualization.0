Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB649365E
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436395; cv=none; b=djiIt06dcLrf0Ka/po/qu/VAL0u04mHIeCAwTjcXQIHljqwlbNJtk+RmpjSTNMyMayhja33fX8gUEUJGr34NDs51fPT43dUfUF3zQsK6gHKWT02HVJgtWfPPvwAK1k3WxtApNW4PTCEstMPNvrTZ2fI28u3TOoTrDzK7Wx716o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436395; c=relaxed/simple;
	bh=NXdwaN0ZLM9X4EiI3vGfuaCSH/ohhs7TAIZQWzgxxSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Vtb2suLuyYcJ1yJA5laqETnanRCdRLpc36kQiVGJIvjK4KnkoEHjWgdImceTUd1vBK/zBVvkIV8FflsAxWQqTVCv4UN/70E6Hjcguh0IlUMcZMAOa+sP4+gqKACj0PKXklCxdfYiZx6OxObev3HsEywvuhpP7SI2A+qxH823CmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTqGY2fR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTqGY2fR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788436388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zt5TFwXrVFNhjDyjDPH7hfKRxLknQjHaFWOGKgUQ+7s=;
	b=JTqGY2fRMNPXsUrhYqtgi5lmOx4faRPVd0RhOkWIXCVLOmaUi3mzrJUpSWXvBdARSPukf2
	S0H9Ckk0BJfvTbPk61NLUHXfFMlEXVVkrC/B/7qfx17QwWdOreIf/gd+nq5YriAM3C9iW5
	Hk8kLq32ujBCvn5737Mxc8TahrbP2wo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-SZN1q9ooPrqoOfM9Gr6Lsw-1; Thu, 03 Sep 2026 07:53:07 -0400
X-MC-Unique: SZN1q9ooPrqoOfM9Gr6Lsw-1
X-Mimecast-MFC-AGG-ID: SZN1q9ooPrqoOfM9Gr6Lsw_1788436386
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso19249615e9.1
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 04:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436386; x=1789041186;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zt5TFwXrVFNhjDyjDPH7hfKRxLknQjHaFWOGKgUQ+7s=;
        b=MrUS2P5WqVMV0hlvWqFDBGl3mYIN7DO9DMls50zpnQbUO7TwXd5IK96+1KmUwQ+MZD
         hG+bMIehO/tFH6OAwE7CIDtVnimGOni2Kp+e/n8ivI4JhRCu6Sabzy2UPNgW6RvcnKSV
         O4GSNqL+f3+NCmjw8CYJrqtWY0JTMcyFhFN/m0onny6B+v3k95er3Elkv24i/qcfmL7K
         ooxmHXpfp9dge89LV/XLh3n4GSePcX9T/gbiA4xB23BzBfvm/KrNsQBuFeXRHvqWiyct
         +X1MW4YqhbltIqWWbTe5IOUBz5j0fyfYf6KKPzTLBcZzc30iEDzvBvh2Tn1YtPeqCqTg
         jU7A==
X-Forwarded-Encrypted: i=1; AKwUvBwcB6hdYNaG7scnyFkNgTxVetTESbBDhedl0DEF/SSYoPWsyGSUZemvvbowjgPoPX+US5it4n30O/4Fl3tqcA==@lists.linux.dev
X-Gm-Message-State: AFuF++lKZU2xNqex/vj9p2qkCUOyk8Af82czv1tbrG8GSTx+5BH3Fq3f
	qluI49DTOQytsByMXM/krjxjX4ksf2eeOO0WoF54VoyIHkZ8foWuEdM5j5cKTdr5zrvlSfT5ntl
	4z4c78D+2jCtztugPi04QEqYiE3EG5So4NWGENGrQFwc3aB5QGu5xPd4sTkSVV8nQVA2o
X-Gm-Gg: AYBFou0P3hshl9X0BB/FF4kl3Szc96BSUQurHdN8dqhwCbZueSK8SIb9n/d6/soU4qo
	hzM/IIMBO/sAbK1XmYerTqHJ8bMtbRhEP3ocG+9LkP0F2UcpVQcDyrX2qRn/Oz8nGmPuGHEiwcD
	xkUnRBpWHgt7p/MW829xO2wQj3nvykB4QGEGRcsjt5q5x+MKHSsKK1gSatNf+vHfUuPnTZ1W6Lj
	cJs8HyHRMj4ca7ONTIdRtwhuOWg/KnS2kF2EVtZVn69DqV0IhHj4tlIuc08vEMFYcYUmgzGQw3d
	xJKLc8Wy8lzgTMfNVrWuUZ4Lxsi4M8Tag6a3qmyZe4mrMEOTpjEM4KCOTVQ+iT9BKO5OVZ2ydyn
	JOz+O9p9oCWw23K+RXrbIVZQ=
X-Received: by 2002:a7b:ca42:0:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49ce55fbdbemr146698965e9.4.1788436385734;
        Thu, 03 Sep 2026 04:53:05 -0700 (PDT)
X-Received: by 2002:a7b:ca42:0:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49ce55fbdbemr146698175e9.4.1788436385256;
        Thu, 03 Sep 2026 04:53:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce46696e8sm85689205e9.0.2026.09.03.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 04:53:04 -0700 (PDT)
Date: Thu, 3 Sep 2026 07:53:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio: synchronize callbacks during device reset
Message-ID: <20260903075247-mutt-send-email-mst@kernel.org>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260818040433.66986-1-kmehltretter@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pIQ5amykiYD5kqdYzSaFc2PBVxK9Ff8vtl99UiKVT0Y_1788436386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2026 at 06:04:31AM +0200, Karl Mehltretter wrote:
> virtio_reset_device() documents that vq callbacks are not in progress
> once it returns. virtio-pci delivers that by ending vp_reset() with
> vp_synchronize_vectors(), virtio-mmio does not, and a driver that frees
> state its callback uses then hits a use after free.
> 
> Patch 1 brings virtio-mmio in line with virtio-pci.
> 
> Patch 2 makes virtio_input reset before unregistering its input device
> and stop its callback once teardown has begun.
> 
> Together these patches fix the use after free on virtio-pci

pci has synchronize on reset already

> and
> virtio-mmio. Classic virtio-ccw and other transports still
> do not provide the documented guarantee.
> 
> The use-after-free was reproduced under KASAN with the race window
> artificially widened.
> 
> Callback synchronization was tested in an arm64 QEMU guest with a
> virtio-input device over virtio-mmio and four vCPUs. The event callback
> used a busy delay, not a sleep, and an in-progress counter tracked
> overlap with unbind.
> 
> The driver was unbound and rebound 120 times under continuous input.
> With patch 2 alone, virtio_reset_device() returned before the callback
> finished in all 109 races, each in under 1 ms. With both patches,
> vm_reset() waited for the callback in all 111 races, taking 24 to 86 ms.
> 
> Karl Mehltretter (2):
>   virtio-mmio: synchronize callbacks during device reset
>   virtio_input: stop callbacks before unregistering input device
> 
>  drivers/virtio/virtio_input.c | 8 ++++++--
>  drivers/virtio/virtio_mmio.c  | 6 ++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 3eb40771c00a8488fa6ed2cc1fe203477908bf38
> -- 
> 2.53.0

