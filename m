Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6B1A5B9D
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872057; cv=none; b=Ya+yXr+eZuMEin8KriQ+PyqYf7aLzZVa0YfLcgcRFWxdU5SS5VRs7+JZIDt+L0XMfHB0GFMf62tq1uQg7rNnmKY/D3Uhw4S9esbJ2F4NOf2kMQQ8rnjqy6LVVLaKko/DRomKOCrPrPTT/fcw6sLtVzkUgt/2sbegcdcOYQFqz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872057; c=relaxed/simple;
	bh=U0jjFOIRPE2pVoUMIlyB9h7+kH8XE4j8UQpdjONzyjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZyeSn9DApWxFOuwgo28PN1ZQagE7vqU2Sgrmjqyp+gBdINbh6Sn4v4qpIDOOsUVWWfAEOM1W/AUaY5cO/cxwND+4B29TF+1xG8Ve8OvXF+y25/6fSx1lUWwTsKVQewbCo5DxE6AHM8wsvqjoeJK57x279QYPfTizxvxVRgrZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmJSZHwR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmJSZHwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756872054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0jjFOIRPE2pVoUMIlyB9h7+kH8XE4j8UQpdjONzyjE=;
	b=UmJSZHwR5CYaLmI4vKNd5wAVcPl1OysAUtPK/DffvAYAVhrSc14imCYyZ0FUsNMLrvOoJ4
	M6+XKgTtAUVjiHs43oetMbCA8lWHJvwvwpn5PP5PWow0b2dF32pDsIPJMqTfi2LiOiWLpC
	Me9XItxhqIW7shlfzGSYJy/uT5JES9s=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-iIhvRGoTNCipC_Wr_Lr3Dg-1; Wed, 03 Sep 2025 00:00:53 -0400
X-MC-Unique: iIhvRGoTNCipC_Wr_Lr3Dg-1
X-Mimecast-MFC-AGG-ID: iIhvRGoTNCipC_Wr_Lr3Dg_1756872053
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2490768ee5fso40613895ad.3
        for <virtualization@lists.linux.dev>; Tue, 02 Sep 2025 21:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872052; x=1757476852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0jjFOIRPE2pVoUMIlyB9h7+kH8XE4j8UQpdjONzyjE=;
        b=lB1RACT+axr+uuUoMWDuS4JhguSI7eD8zfhCIk/JRSUoZxboDXoOF5LGr+/3s9s6sK
         Mvw1ijuzITY+NiKitgiQvOlTGMaCdBzcWeKWEFofvEuefyutnGK4UM2AIqRkQY9bYA48
         E4FI8yMZ+++9lF8raOAUlaSC5Z+RjJYlSgZ/OZSxUmrGh5U7r6wdxh7eqytpCtbcfQ3A
         4QGQns6BOF5jLXDF2UfECYNEmRgoWk/y+iVYSo2E0f6I23eJLZBVRLQtRl0eBPPetiUj
         c82tf5PFc9iCeiwazSRgV5VueN1D9KleccmPqJ7m3qYCETgA8+GR3FuF1y2NA9elL8j1
         UhGg==
X-Forwarded-Encrypted: i=1; AJvYcCWT8/DuFDZtJ7Yjvxfbb56lZu9tZrpm+ipZllesquMuAPcaUmYHKzzoboZK6nkBvtM5yXeSK4OAF8jcNYy8TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyy53kX98IziQpieoJEkicaGvzSgKYk4wfCGKzXOX9ugaO8a2T9
	wApOn6jj/49ophVlQTP+8Ml2zbc5iB71wgCyORhjz2AmcYm+DebRY3/8G+03n1pUfUB94Y7XqO6
	TjigQG3z7Wj28i/SwbU2GRohp1ACaxYpJTwDyvbZew9OquPxwQy8LBBV+GA1qXdXGVwHRgIdGd/
	/FUFOr4OfvJLOCC+SYSW0YSwuhn6xMrQPim/QSeARbaavyT5R6AW8faQ==
X-Gm-Gg: ASbGncu4ITXdvzfv1LMoN991AoUtAk/HgXRJkT0DIkomI5r0Tiu4kikeva3pTwWpcDX
	ro1po4ubMPB73JgIyPYNNIjChFe3OZWdzfYykBxTyuyT4P1L4NEdNir6bFSYjgW50z48gyIX/5X
	+6Ib+JFc7eaC0yJP3XXVA7rQ==
X-Received: by 2002:a17:903:1ab0:b0:246:76ed:e25d with SMTP id d9443c01a7336-24944b15b8cmr169377715ad.50.1756872052074;
        Tue, 02 Sep 2025 21:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5aB6Qqxj9qWYTbp0SCLMQoviI6dY5kYYbJnZhA2Hm84dGyl7OdRCsvBI+vTe21NUsYwxF2ONdt98uJqVn0hA=
X-Received: by 2002:a17:903:1ab0:b0:246:76ed:e25d with SMTP id
 d9443c01a7336-24944b15b8cmr169377215ad.50.1756872051574; Tue, 02 Sep 2025
 21:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20250902080957.47265-1-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 12:00:40 +0800
X-Gm-Features: Ac12FXzvemknOpwKY7V_bPmSMDz5x5JOaUgCJhdjwkkYam90CI_kt2z3omxI2R8
Message-ID: <CACGkMEviyLXU46YE=FmON-VomyWUtmjevE8FOFq=wwvjsmVoQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, mst@redhat.com, eperezma@redhat.com, 
	stephen@networkplumber.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S1JH46TwqgWs2j9iQohQi9rOKcAId_BclQw5exYNgy4_1756872053
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 4:10=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This patch series deals with TUN/TAP and vhost_net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> patch series, the associated netdev queue is stopped before this happens.
> This allows the connected qdisc to function correctly as reported by [1]
> and improves application-layer performance, see benchmarks.
>
> This patch series includes TUN, TAP, and vhost_net because they share
> logic. Adjusting only one of them would break the others. Therefore, the
> patch series is structured as follows:
> 1. New ptr_ring_spare helper to check if the ptr_ring has spare capacity
> 2. Netdev queue flow control for TUN: Logic for stopping the queue upon
> full ptr_ring and waking the queue if ptr_ring has spare capacity
> 3. Additions for TAP: Similar logic for waking the queue
> 4. Additions for vhost_net: Calling TUN/TAP methods for waking the queue
>
> Benchmarks ([2] & [3]):
> - TUN: TCP throughput over real-world 120ms RTT OpenVPN connection
> improved by 36% (117Mbit/s vs 185 Mbit/s)
> - TAP: TCP throughput to local qemu VM stays the same (2.2Gbit/s), an
> improvement by factor 2 at emulated 120ms RTT (98Mbit/s vs 198Mbit/s)
> - TAP+vhost_net: TCP throughput to local qemu VM approx. the same
> (23.4Gbit/s vs 23.9Gbit/s), same performance at emulated 120ms RTT
> (200Mbit/s)
> - TUN/TAP/TAP+vhost_net: Reduction of ptr_ring size to ~10 packets
> possible without losing performance
>
> Possible future work:
> - Introduction of Byte Queue Limits as suggested by Stephen Hemminger
> - Adaption of the netdev queue flow control for ipvtap & macvtap

Could you please run pktgen on TUN as well to see the difference?

Thanks

