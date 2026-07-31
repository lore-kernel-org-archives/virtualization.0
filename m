Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABA352010
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 04:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785472935; cv=none; b=EsTUVebGBMCzol9TPE+Km5VXJyCmlZBEmMwHBxfmiDsO5ePS/4tZpzZUGNIYh+UemfIxrWf1AP+yb/FRpvTaA06Q0/C/TL1ibh2URl8BP2GK51EoXneZOaIBml6Dkh+djnwo+hODxMixBbAOrqT3dcQcgPtydapsLesKDnChb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785472935; c=relaxed/simple;
	bh=ZMvyUCyEVG3QAjdzCqMKBgh7MXLqXhHhJWMaYN5xfHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oQAqvbvs9+GpmLDgXa0N9Z3Zj2wPmVyasbRrpZYBoKg+K8komGKdbLjn9nGgWwDlaVRYCIC7/9epGRjzkx7D6gYHdlX109he5p92A+1RAdHHZsHIsLX7FKNne+SNkQZuiP5QwWMvNVTXTxNTrIffH03YW/ajBy8cpjOFiIiq89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kz4qt/gV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz4qt/gV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ce98cb8165so4337785ad.1
        for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 21:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785472934; x=1786077734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UBxrxqOA4cNRIKhpkuQrq3xtaL8oWVG4/TQjb10K0NA=;
        b=kz4qt/gVlhCmuTvY+1Bgz4bM1Zdzk2loxjSG1678FeTRmaihlWBnM7XydGPHHzYIty
         y4Nb9ZJMeZGgi3Jph6GsDU5yDPBVoTGbvIXHCN0u1ak/w3UeTN3/cJkNlSO2hxT6BwC5
         Q5USVmJbBA0GmfE+AwjJpHbMe0Fg68ihjHO10jiTUx7JThMo719L+oCT9cKZsC7lNMj8
         yV9QPhOqX3CXen4cNhIMae74WamqObNYTaSa8x3/ZjhxldMRyRO55q8khTT79yLyCQXU
         VziP9lwlnL0yQ8WCYUaqi54m/dp7NLvWLz7t6O+7a0d87Ti3ZvteZdjTXjOS/ntt1pjY
         a4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785472934; x=1786077734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UBxrxqOA4cNRIKhpkuQrq3xtaL8oWVG4/TQjb10K0NA=;
        b=UDIaqsmhufBZUM8vl1G2HUd7AGxRLjFizaHbmZdj04tqONTDO1+lpd+MrHSQTQzHCh
         iH6Gy38FIcfMK+NvTDpMKgmBp7HgtVdXrlVIYliTAdlWf5brVZYCS6lIxcf6b+tj7Gml
         JRDKBUgEXcXcqCVBi0sXB6a2+Ev7gQS4N85O66+inC44J7QypvwsPfuK0wjXEdHfmkhi
         Ros33fymVt9R3oKO7nYRaeTy0Ms2LYCAiAMCdX1QGgwp209JUN3yYT8SlhfI7oJPsWxL
         lkRHRtwY0AM2WICqwEUZ3yhxLwMOp0ZZ+3D1d6HypJjBVJPD9eR6ez2s6xc1CJp+PC6k
         mz5A==
X-Forwarded-Encrypted: i=1; AHgh+RqyO0DzsOc9gfwxIczpswCxKdZWdl3DX+oQlY26yMuDRA8RsIjC6+19RhuaTzWfvomQ3FTL4r+hYmXaoF4ahg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBm0B/CmigmC5or+BIm4KdNQVzm7CiDNrr0Hgkmz0tq4zMuguB
	N0aIfj6CxS+6S0i5EgJn73RVIic4cryRQhJXBen0cNZS2ZKy3yCgOKp1
X-Gm-Gg: AR+sD12YXxrm0b/d2GrXXul6CcTp23uM4Y6ioX5F9uaBK9J9wH2yNGhqgHIGnMZ4Wcp
	6/8USv9VjTVDbQkMdSPtexOeAqoucygvYXYUQJG1XF4MH4jInbh4XmGTDzwuxSokY38MyytHtdP
	H7ewboVlc583+thiFgqbvkqRUH/2ORB+SKUMNok4Q200W0GnGZAJummc1WSBMNLsnmqF6z3WaFt
	e8PFvejChm++FFbAhmO0XW/Kg/tu+m/TJNjE0he8hTGYjU44guzx72V2qcA0Vg9ASXWzzx/dD2A
	ufrMvcHo+3UlRzPxauYWVGnT/Oy4u8XCduuLWsTNsMwUwZhk4kHn4mgHc39yTBFqoO9hi9t18Qv
	LhFIxlHszZfUI2te9SY2JFj8YpLUZC+kN4sDQN16XBLXMnanYABl3jreh9pVykO0m7ZT+7e6wKu
	DXubFr30Xl7BFa8Q66NChFXtWMrnb22g/eDTsY5N6hXGtyIbX0tcKZ33sFgbLlvd0=
X-Received: by 2002:a17:902:ceca:b0:2cc:ac15:ff4c with SMTP id d9443c01a7336-2d047d5481cmr4191885ad.8.1785472933339;
        Thu, 30 Jul 2026 21:42:13 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c93dsm765243eec.8.2026.07.30.21.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 21:42:12 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM changes
Date: Fri, 31 Jul 2026 12:41:45 +0800
Message-Id: <20260731044145.1734317-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730104857-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 30, 2026 at 10:51:15AM -0400, Michael S. Tsirkin wrote:
> I don't know if this will break anything. Why not just blow
> out the iotlb? kernel will rebuild it if it needs it afterwards
> for some reason.
>
> This part you are fixing is harmless. Let's make it a separate patch
> and document the motivation.

Thanks.

Yes, I considered discarding the IOTLB before choosing -EBUSY. My
hesitation was not about whether it could eventually be rebuilt, but
that doing so would no longer be only a control-plane validation
change. It would modify translation state directly used by running
virtqueues.

The minimum synchronization I had in mind was roughly:

  vhost_vsock_set_features(features):
      mutex_lock(dev.mutex)

      if (!(features & ACCESS_PLATFORM) && dev.iotlb):
          lock all vq.mutex in index order

          old = dev.iotlb
          dev.iotlb = NULL

          for each vq:
              vq.iotlb = NULL
              reset vq.meta_iotlb
              vq.acked_features = features

          unlock all vq.mutex
          vhost_iotlb_free(old)

      ...

      mutex_unlock(dev.mutex)

The switch has to be serialized against all active VQs. My hesitation
was that this turns VHOST_SET_FEATURES into a datapath synchronization
point: the ioctl may wait for in-flight kick handlers, and rebuilding
an empty IOTLB may stall queues on misses until the translations are
restored. If stopping or flushing the device is also required, the
disruption is larger than a normal feature update.

I was not sure whether VHOST_SET_FEATURES is expected to impose that
cost on a running device, or whether userspace should quiesce it first.
That is why I chose -EBUSY for v1. If synchronization with active VQs is
the intended behavior here, I can rework the patch accordingly.

I will also split the existing-IOTLB preservation change into a
separate patch and document its motivation.
