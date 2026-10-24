Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792824347;
	b=CcCZaPkfX5vhnWJYKLl0bDWDE9wsGXV1GxemHjzRRE/ANxKpuLwFdLdFyYhBwy7/v45g
	 2SZF5u5a7ozpwNoEGrXgdfMjlGvYiza4uGvRvPjlnDnTi4osa//k/3+S3l0ZPpC08WxSf
	 GB6fq5sMIMBZJ2WKVDhj9eP5hQtBwP/2aYOFB8EB/9eAJcxdnLfVTme0EF1XdDlwmZAQb
	 W16Mvsu/T0Qd8E4ugN/mWuKr/z9z8YmjO+P/z2aSuRcAOdxXM7fuy5szF7bahttaLIqLF
	 fl/koU9Uji3hJigJKWQMFXp2juebyzshfLuTUqAwpmQzXRQV5GFqHNkz33fHdvOkWPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792824347;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
	b=SFolIjjrhiPtJup2I+5906grWyXs6LLaIM5GMBLol5H3HCqQzosj32AtE3LGVyKYPIJl
	 PjECbUXjuhfrv+rfxGTFSDsdvg7mYC/gbGeijWBkx5TY0WcACKF1H5axwVxzYQj9xOONi
	 MRX3KXxUSIU1MkjaJ5+fVN0D1/63Ru60+nLsvY8qfLj9wyeLy+x70/pCkkZIC4tsNSuF6
	 i+CJrtilywAi+uoQ0xzt87+u2w1lP1Iju3ofRbdvfIxXV55uf21/tgyafhb7eFzalQZm7
	 AsGqr5THPZPso5v6DDkutaeRWe+Ho2SqA9l5elFoISKT1kwGZq4uj6FtPgFrf6MgDQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T7+vrpj7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA3606A320
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 06:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40DA3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T7+vrpj7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792824346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
	b=T7+vrpj7S76ce9Leg450qxqwAGfKOdzcByHEMCV2ibOIWLV0Yf7gD14ZuUBcMx3cU1tDZY
	WLJqw0EE4QarMyVMIOeb36TbJh2m0iESBEV+83oJd4cmLyZ3HxzepY8WGIrk/uY1jFr2Fc
	GudSOUYsVOhkCkZuEmh801195QyymVw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-w4fMIR1tMTqAT2E3CFWKUA-1; Sat, 24 Oct 2026 02:45:44 -0400
X-MC-Unique: w4fMIR1tMTqAT2E3CFWKUA-1
X-Mimecast-MFC-AGG-ID: w4fMIR1tMTqAT2E3CFWKUA_1792824343
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1e489f97fso15161945e9.0
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 23:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792824343; x=1793429143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VZkrS3h3QtN2lN0JtRWstJekBxv3Yb3xF/ujHnm2w/E=;
        b=j6U4Fufzm1pW4eANPVp1fidLXYiL8R+kwKhcH7O4eIbLypUbNjstEGg7v/zCH+UOHC
         VDVZKvc1mdUllesbsUuslYNakmtBmQlYwRklIAUkROhrOa3/W+Q3WiJOgHjEVLElLxxK
         0r/Mm/n5IfBTUi69276bD1/sUwwClmhSFZ9/KWyDdsmuFgJnwG5tKvhW8G6F3FYiJhU6
         zHBMvWLHBGl6cfiKCJS6bULFstqdZN3KsS6AMZaXbeCf/lyOYGtqW0JIV/UBJI2RFGNv
         0h7Yb75Wa1PMKpdfW7jMbrdwI71wfRtReqxHDmmpUn6nPn0VTumCsCWPiCR0WhNryPk3
         0qvg==
X-Forwarded-Encrypted: i=1; AKwUvBza0WIeM1qnozVthcXIWZHT81neN9fpIbUzar+awky08g52J0J+9Y02V0P8VqUBvNqJkAf0/ujh3k7wI9gECw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLB/NBCOh8nFkPYUvbUGsJR1Lkv/PeUUwjB0cdxrTp57z5tMRe5
	r4JhPdPJ3W0l1Ba4HUcMHatp0HSsU+vjrTbJyxOvQyYDzFOkt/Op6o94mMjrMT9cK+QES+Hbrx9
	NeUR+wsCCV0jPJb0KTRN8FXf09r4fsAXer6BFrVpzEbVOpramLhSTZDBIqrsTpThex5or
X-Gm-Gg: AYBFou00riJivJfEeF4Vca+j5UD5em9Mm+S/XFjpzIlx0ivt3+G40bPseuBC6lZBDr7
	Skmp8O63sn3ocpdcoNfLfiPx4u5iJxzVXz9av6gxZXpPCckRvgqBdtxmkUdRCr0NpblH5RjATop
	GIEqTqXptTawpzkKOOWGVJmwMBOXhc6yvCaW8sdRO/275K0u12aicbeRPqZ0jOVsqHobujiF5Km
	PfwGT1yCbL6cjL79UAOF+VCIae5RqoZeMRpUT3BhC9UYGCgSojATK2etg2RNG+IkiLHBwh3OZyp
	AzlxuoDqFX4kp7fUwCRnaEG8We+STjXJvU2BjC+gvQaJfJlQbN9TBrC3BceKGwWCp4Q/ne4=
X-Received: by 2002:a05:600c:3487:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a35ac8c231mr16890825e9.9.1792824343203;
        Fri, 23 Oct 2026 23:45:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3487:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a35ac8c231mr16890615e9.9.1792824342728;
        Fri, 23 Oct 2026 23:45:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73f6:2400:30a8:9e33:7d82:c035])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359f3e00asm63050615e9.0.2026.10.23.23.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:45:41 -0700 (PDT)
Date: Sat, 24 Oct 2026 02:45:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guikun Yang <yangguikun19@qq.com>
Cc: Jason Wang <jasowang@redhat.com>, Eugenio Perez <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: initialize the whole negotiated RX vnet header
Message-ID: <20261024024028-mutt-send-email-mst@kernel.org>
References: <tencent_803981983647D9F9444561A4227F138C600A@qq.com>
 <20261023080824-mutt-send-email-mst@kernel.org>
 <tencent_E3543FCAC26722EA3D15F87B69C4C769D905@qq.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <tencent_E3543FCAC26722EA3D15F87B69C4C769D905@qq.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y33_ewwT2d3zpIiqUO0waHzYxUtnms9iZEAk12eOmnI_1792824343
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Oct 24, 2026 at 10:11:01AM +0800, Guikun Yang wrote:
> On Fri, Oct 23, 2026 at 08:13:22AM -0400, Michael S. Tsirkin wrote:
> > Which backend did you use? Sounds like you did not set
> > TUN_VNET_TNL_SIZE or did not set TUNSETOFFLOAD?
> > That's the issue then.
> 
> The backend is a tap device attached via the normal tun path:
> TUNSETIFF (IFF_TAP|IFF_NO_PI, no IFF_VNET_HDR),

Ah, no IFF_VNET_HDR *with* vhost. That's a weird combination.

> then
> VHOST_NET_SET_BACKEND on the RX vq.
> 
> I re-ran the repro with TUNSETOFFLOAD declared before attaching the
> backend, listing every offload bit the interface understands:
> 
> 	TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
> 	TUN_F_USO4 | TUN_F_USO6 |
> 	TUN_F_UDP_TUNNEL_GSO | TUN_F_UDP_TUNNEL_GSO_CSUM
> 
> TUNSETOFFLOAD succeeds (0 is returned, so tun accepted all of them,
> including the UDP tunnel GSO bits).  The result is unchanged:
> 
> 	features[0] = 0x108000000, features[1] = 0xa   (tunnel bits on)
> 	VHOST_SET_FEATURES_ARRAY ok
> 	TUNSETOFFLOAD ok
> 	--- RX buffer first 32 bytes (initially all 0xAA) ---
> 	hdr: 00 00 00 00 00 00 00 00 00 00 01 00
> 	     aa aa aa aa aa aa aa aa aa aa aa aa     <-- offsets 12..23
> 	     33 33 00 00 ...
> 
> Offsets 12..23 still contain the stale 0xAA fill.
> 
> The reason is that vhost_net_set_features() computes vhost_hlen purely
> from the feature bits passed via VHOST_SET_FEATURES(_ARRAY):
> 
> 	hdr_len = ... sizeof(struct virtio_net_hdr_v1_hash_tunnel) when
> 	           HOST/GUEST_UDP_TUNNEL_GSO is set ...
> 	if (test_bit(VHOST_NET_F_VIRTIO_NET_HDR))
> 		vhost_hlen = hdr_len;
> 
> TUNSETOFFLOAD only updates tun->set_features and the tap device's
> wanted_features; it does not feed back into the vhost feature bits or
> into vhost_hlen.  handle_rx() then writes vhost_hlen bytes of the
> virtio-net header into the guest buffer while handle_tx() / the GSO
> path never touches those 12 bytes for a header vhost itself built.
> 
> I could not find TUN_VNET_TNL_SIZE anywhere in 7.3.0-rc7 or in

Apologies. TUN_VNET_TNL_SIZE is an internal macro that header size
is set it. TUNSETVNETHDRSZ is what I meant.

> linux-next (drivers/net/tun.c, drivers/vhost/net.c, include/uapi/linux/
> if_tun.h, include/uapi/linux/vhost.h) — is that an interface from a
> tree/series I'm missing?  If it is meant to gate vhost_hlen I'd be
> happy to re-test with it.
> 
> Meanwhile the stale 12 bytes are observable with a plain tun backend
> that has declared full tunnel offload support, so I believe the patch
> (Zero-initialize the largest header layout and copy vhost_hlen bytes)
> is still needed.  Happy to re-test under whatever backend setup you
> had in mind.
> 
> Best,
> Guikun Yang


I have in mind simply disabling this combo: vhost + !IFF_VNET_HDR)

I'll research a bit whether anything anywhere could reasonably
use it.

Can you reproduce any problem *with* IFF_VNET_HDR?

-- 
MST

