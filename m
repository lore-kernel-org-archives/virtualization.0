Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F226FD84
	for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753632; cv=none; b=f1XwC+0927eWgfMh+43cMwp7crKPNUFeINGjMuCsiRLvUKj9OTe4k/pge10oFmg3+cT8o8wUOsQMQ+BHEKsVSafeYTCWGqVd4IL+Dx/3D0ML2nPD4O+Ab/Xe3Qo/mvxARzZ0VBGlzoMr+SEb8HH9AaeXkbOgwEeWJ2lDhKi/OLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753632; c=relaxed/simple;
	bh=vvamKXaXonTikm8G6IDKp730/CDhnoJ0Mk8W9T1Ok3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Czff6f+S91LUTxJ7zBUKLrwpjeT4ZA0ui/0Ypm8D16tHTbzCxPbDxmN8RIbBK8U81lGtFD5Aeqkka6uz88rF9BaO4PXvySYiBu/8Y30ql7r5lyLj60yQJ4/j/MMb28Bwbv+n1FjDyQhJVBKNVJovMUOXWGiHDuj5Tr+hGkyJnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVcn6z3J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVcn6z3J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740753629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roUwxiS7ulymLcFa2pyWvjdc3Ih5JRuvNyvUztd1mhM=;
	b=gVcn6z3JcRZWRskEt7X1f5GOFAnIJ37MARcvvtH2FJQNg8NfyXf1HQksltonaPNyiGeIsz
	9qTF5Dfu5cbtw9vD9XJmSvycBW+jkcQf9xWtKRMGul6K5jx0G6adM/0HMdJE6QJySrh6mg
	xb9+i8KjIZoUKFXjbjVeqE6XbVFvXI4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-aIt_EOSaOlC1EgHJS1fjDw-1; Fri, 28 Feb 2025 09:40:28 -0500
X-MC-Unique: aIt_EOSaOlC1EgHJS1fjDw-1
X-Mimecast-MFC-AGG-ID: aIt_EOSaOlC1EgHJS1fjDw_1740753627
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ab7f6f6cd96so242633666b.2
        for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 06:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740753627; x=1741358427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roUwxiS7ulymLcFa2pyWvjdc3Ih5JRuvNyvUztd1mhM=;
        b=lYJsBNhzYwxdjaypEmpyraBW+kKqEk5alGHXx8zBpUNFOYt95Tjp0xJbnkW2ei8sAh
         30tW/riNCkLigXHNB9HZPSj2j+6co1S3/6SbXyP/Q6fdLzolyHIDKHZC3dXi7xhj61tF
         lcAjyADkMqTqM/A2yeAHytvOErvDlHL3PT0hOFarBdmNMzd5gLywx1zCnQRp+6ybvVPQ
         HMfTmFh0Hhxg7yEr89vYgh46EF1mT9GPOsDKGQbchlN5gRhsnyCFfMI4N3VTz7juFF3G
         GDPzbXib0PL4NU6PSUiuonU+KVdiajfh4EX68OOo2JTWkrPrQRgKXR+NSR3PJmrh0Jeb
         MNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrHZDxIjFKw7H7at/5IAYTqiwELJ6f26DJUNmgcaZHNtQdjDkUFrBOVbjV/4OAI86fLdALuwQrSBQ9PVHAUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuOjVVAhfTPhp4d+HR4nuuvHTr3wXTHkC5NR/sE1dpmyM6AtFa
	EjRAhgztGLXU63Sf20hphhmEmcOEcIzlIRxtPZHINBn4bT9UPYqrwpj3dbX7pwXvt6M83GqRFtR
	WHdJwF95LsBGcq0ejWw75PeJgOLV/ko56F6T0GtnJHbJ9nnY5qMWKdg49Ifcfx4ROI5TYPsz+WG
	jW6rtMfJRjqUQSn4U4j4Z6D2KFzJoL/WYX+sFVrhs=
X-Gm-Gg: ASbGncsHbVrAmRP+wemCRHrXf0HG4B4LAmy7e1zUcOUX4s1asxdfPuqyPJdt59ugltn
	OQNjimFJjb2OMCjye8aLqSH8KQ9mfc3hCtc0rzhU0+Zq/87g21c4z/pVwdhWgVCJENMc9KBAcUg
	==
X-Received: by 2002:a17:907:3fa8:b0:ab7:e16:aab7 with SMTP id a640c23a62f3a-abf25fb677fmr319208966b.13.1740753627005;
        Fri, 28 Feb 2025 06:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPegDg6tPejCUZgBS9Oz611YYT0gOXJGrHO0Mf3Y3+5jBs88zw4q+EJl75v4x09O8dKVdC8oCD4tipkFYJN9I=
X-Received: by 2002:a17:907:3fa8:b0:ab7:e16:aab7 with SMTP id
 a640c23a62f3a-abf25fb677fmr319205966b.13.1740753626613; Fri, 28 Feb 2025
 06:40:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250227185017.206785-1-jdamato@fastly.com>
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 28 Feb 2025 22:39:47 +0800
X-Gm-Features: AQ5f1Jri6SSnIUB3TA8bZTF7aUJK_L13tJvV7_Fad3fng_j3YX1IbMDftxVWDPk
Message-ID: <CAPpAL=xpdFVfFMzU7qQM=YGJvEyhSPyUDfrt2FyWx61BJgHjMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/4] virtio-net: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, kuba@kernel.org, mst@redhat.com, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: apKm1b0ynrTnTob8LlytOlprz5j86s1bsj1ZEKlKHp0_1740753627
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I also tested this series of patches v5 with virtio-net regression
tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Feb 28, 2025 at 2:50=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Greetings:
>
> Welcome to v5. Patches 1, 2, and 4 have no functional changes only
> updated tags. Patch 3 was refactored as requested by Jason. See the
> changelog below and the commit message for details.
>
> Jakub recently commented [1] that I should not hold this series on
> virtio-net linking queues to NAPIs behind other important work that is
> on-going and suggested I re-spin, so here we are :)
>
> As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> correctly elides the TX-only NAPIs (instead of printing zero) when the
> queues and NAPIs are linked.
>
> As per the discussion on the v4 [3], patch 3 has been refactored to hold
> RTNL only in the specific locations which need it as Jason requested.
>
> See the commit message of patch 3 for an example of how to get the NAPI
> to queue mapping information.
>
> See the commit message of patch 4 for an example of how NAPI IDs are
> persistent despite queue count changes.
>
> Thanks,
> Joe
>
> [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
> [3]: https://lore.kernel.org/netdev/CACGkMEv=3DejJnOWDnAu7eULLvrqXjkMkTL4=
cbi-uCTUhCpKN_GA@mail.gmail.com/
>
> v5:
>   - Patch 1 added Acked-by's from Michael and Jason. Added Tested-by
>     from Lei. No functional changes.
>   - Patch 2 added Acked-by's from Michael and Jason. Added Tested-by
>     from Lei. No functional changes.
>   - Patch 3:
>     - Refactored as Jason requested, eliminating the
>       virtnet_queue_set_napi helper entirely, and explicitly holding
>       RTNL in the 3 locations where needed (refill_work, freeze, and
>       restore).
>     - Commit message updated to outline the known paths at the time the
>       commit was written.
>   - Patch 4 added Acked-by from Michael. Added Tested-by from Lei. No
>     functional changes.
>
> v4: https://lore.kernel.org/lkml/20250225020455.212895-1-jdamato@fastly.c=
om/
>   - Dropped Jakub's patch (previously patch 1).
>   - Significant refactor from v3 affecting patches 1-3.
>   - Patch 4 added tags from Jason and Gerhard.
>
> rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fas=
tly.com/
>   - patch 3:
>     - Removed the xdp checks completely, as Gerhard Engleder pointed
>       out, they are likely not necessary.
>
>   - patch 4:
>     - Added Xuan Zhuo's Reviewed-by.
>
> v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.=
com/
>   - patch 1:
>     - New in the v2 from Jakub.
>
>   - patch 2:
>     - Previously patch 1, unchanged from v1.
>     - Added Gerhard Engleder's Reviewed-by.
>     - Added Lei Yang's Tested-by.
>
>   - patch 3:
>     - Introduced virtnet_napi_disable to eliminate duplicated code
>       in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
>       refill_work as suggested by Jason Wang.
>     - As a result of the above refactor, dropped Reviewed-by and
>       Tested-by from patch 3.
>
>   - patch 4:
>     - New in v2. Adds persistent NAPI configuration. See commit message
>       for more details.
>
> v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly=
.com/
>
> Joe Damato (4):
>   virtio-net: Refactor napi_enable paths
>   virtio-net: Refactor napi_disable paths
>   virtio-net: Map NAPIs to queues
>   virtio_net: Use persistent NAPI config
>
>  drivers/net/virtio_net.c | 95 ++++++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 28 deletions(-)
>
>
> base-commit: 7fe0353606d77a32c4c7f2814833dd1c043ebdd2
> --
> 2.45.2
>

