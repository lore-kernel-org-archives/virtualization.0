Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47C282E1
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726703; cv=none; b=c+4SIbwJaiqnCsQx2IwogXTTjAcBvFWBHQNO1ZvRLU5G/wgejahvZQPrstvd84poTOIGYl51kNUaiavs1l+W51Q0/46ZDjW2HusJKSDQ61NeNFFyYFH9zaCg1Is9+g/SAVrso4+k6yAJ0fCo62vahehoj5ZNsrdyU+ZjbeJBbec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726703; c=relaxed/simple;
	bh=crI2KdpBxTyiOor4cigyt5k0bB0F42uVbGkqQawR4mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TElLUTEdJ64Xr2y7iJ7YM29L7ve7p8J1XJ7/ywM0WdT6h3uLYKDKZtS/fvbbXvULw3Nq5WEEvrMi30GpHWpBN4NoAez39eBQ1g5f0xSXzltzb/+pdwUb42avZDExFLYo+f9cOqa2GE9uk7g9Sf0nUi4CsLytaOqtqi6BH5ZrXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpMkRE8L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpMkRE8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750726700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crI2KdpBxTyiOor4cigyt5k0bB0F42uVbGkqQawR4mQ=;
	b=UpMkRE8LsWLrrlFloShblYPj2PWrXMHwPDHA4l9gJepeemcIvuodSoDqnthKsTDQ8v+dQ6
	BZ/QBJdxExtX0F/HsbXjl0JkRXi9CaSmZ1nJk4wiLacBJrWtZQNjpdSDHfk7RAsBDybco2
	uKkJeosaS2sLHtm8zgMy2wdCg2UClAI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-mrbrsAKjOmGMfjBvHIRDcA-1; Mon, 23 Jun 2025 20:58:19 -0400
X-MC-Unique: mrbrsAKjOmGMfjBvHIRDcA-1
X-Mimecast-MFC-AGG-ID: mrbrsAKjOmGMfjBvHIRDcA_1750726698
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-315af08594fso2479271a91.2
        for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 17:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750726698; x=1751331498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crI2KdpBxTyiOor4cigyt5k0bB0F42uVbGkqQawR4mQ=;
        b=MZ9Ox4bgUn17L0dtfageo7lg1lgfkyHpY8sHoEJr/c090wu4xGiw+/3OUqa6tXUdYH
         u1XEr6NHgeemZVXB7QEXN5gra5tTM9aH9sNXf5Kte0QIbNpQQxLmd5StFXDLMbjQBPvh
         oFAsvu5eL2MO094TB/kdw21Hjdt7TpR2+VTUKNbQE3Nnt8QBIrIOjS+lOv46fjBYK9ka
         EOwYFvBHiDjBULU1HFn8SskTbmxB+RTHFx5Nv6YzBW6Ly/nZonIzq19RU2VWIzhEg02X
         Z8Lt5KDuq2be0qj8SdmGoOHgg0h2PT8h2mgA7vFCK9wjA7yw/Aw68mIay2zbigpOYXMP
         jkOA==
X-Forwarded-Encrypted: i=1; AJvYcCUYBwj31HyJZuofQbj5/srgI4WUvwXyRu3XH/6xw9B/kTtho8FrtApKPz78sle15m7EGe+1p1hYdcsZ0Oqy8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YypGtq6cOIhl43aow8M6IUPteCAO3B1J98eTstFttQdP/Ut0fNU
	mME3DK6X9tLWgHvsi1EyLhmZzi+zoadO6ItIQUaaBcHUTHkDL35YNsVe+ubEadymxFlOLdt14Tb
	yjvkf4rmBJYOoY4HwD2QBZ9iPi91nICw7HDriXqoO+2Kv5280rMQ5vAeZqys+pu9m1QD1dDPZC2
	k0peYarec5C3pGOckrOmxUE8AL3pL5quex22uAUIdeNhg=
X-Gm-Gg: ASbGnctfBVOPdnVr1Lhtg3bw5GpfidYGAmBZeMuSBtmdsHRrsrex2CjG3dk4KOPE2PX
	L4wUNPHeDKyOLiLJrK47tIDyTJHj07tRn+2678pzEpibn2T9WsQ/K2BZNDOobAUWsOfWM07QCoT
	t7oxZW
X-Received: by 2002:a17:90b:4cc2:b0:311:abba:53c0 with SMTP id 98e67ed59e1d1-3159d64288cmr23065999a91.9.1750726698214;
        Mon, 23 Jun 2025 17:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0TL53ZDwgeSV+DD2GcU3jEI4r/eDHq4FmfUZ/GvS4kXkq5suNbkCfKDj/NwxqjwgnsrCmWvLCvjsuEvH74OU=
X-Received: by 2002:a17:90b:4cc2:b0:311:abba:53c0 with SMTP id
 98e67ed59e1d1-3159d64288cmr23065951a91.9.1750726697619; Mon, 23 Jun 2025
 17:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612083213.2704-1-jasowang@redhat.com>
In-Reply-To: <20250612083213.2704-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Jun 2025 08:58:05 +0800
X-Gm-Features: AX0GCFtX40pdquUIKQa4dMm29AUMnV2mY-tckRUEDH3MEDY23niQa4wXLvV7Jxg
Message-ID: <CACGkMEsphawodd-9XTg8KfYotdLri-3cuSV67F23AOscAHQs6g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tun: remove unnecessary tun_xdp_hdr structure
To: mst@redhat.com, kuba@kernel.org, pabeni@redhat.com
Cc: eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, jasowang@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, davem@davemloft.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4w58B4YP4U-_XjfsoKW_RHpWs6ia64VfvoG1u-2APA0_1750726698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:32=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> With f95f0f95cfb7("net, xdp: Introduce xdp_init_buff utility routine"),
> buffer length could be stored as frame size so there's no need to have
> a dedicated tun_xdp_hdr structure. We can simply store virtio net
> header instead.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

Hello maintainers:

Are we ok with this series?

Thanks

