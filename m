Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218039A067
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309805; cv=none; b=MkkqUkLI3RcmrJzSeEzenUqouIS933UPVUtCYNVr8of89VitRkorTiBeY76/23imJWz9mmGMPoJi6EbNzxU1Oep+gTzlBd2xf9GYtTl4tHsU5qYAdnhqzIltRyWj5yv///AVZTXrmwJLBhRlMoxXy6A+a/32rOW7/R25fgSgUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309805; c=relaxed/simple;
	bh=VfA7dbz78GZzA6BAgS32l4U/g1vSTa0ShMBVln3jJHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JvsU5440t7VTPbnWHuQUAj63gExv2w8rKbVXWmiMxpMsIB0kRb15SmcLzYeJ7Gh71g6OdumczkLZnp+V0bnzNoZrWT0TTYTXllR59H41kjVNRahUcRey2gr1tz9jaDkJSyRcx4FvqE+eQjxhstuKRH4XeqrXBIIkDkVP9kBycCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZX6x9eiB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZX6x9eiB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wi97KWGdJTdWq3IdYpsAWLx4xopc99EofOMqrefmH9Q=;
	b=ZX6x9eiBPV38y8Bjz6hiGqz3TItoF+lCpb9j6fw+st8riYtmvSsQRYg4OF3YhGc+reI/Xa
	348RIHXwT5aIiala50ZB8/GarJFHxjeF16d22Kpbt/FXc+euOfsA53i0Wfv7rAqYmfVuyB
	eR0zxHGFKuRt8YreH7uy9/zLCDPEbBk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-TX_ue1FJM_KAydRj3RPvhg-1; Mon, 01 Jun 2026 06:30:02 -0400
X-MC-Unique: TX_ue1FJM_KAydRj3RPvhg-1
X-Mimecast-MFC-AGG-ID: TX_ue1FJM_KAydRj3RPvhg_1780309801
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49048e21ea7so48964345e9.1
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 03:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309801; x=1780914601;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wi97KWGdJTdWq3IdYpsAWLx4xopc99EofOMqrefmH9Q=;
        b=VRbt2dvGkhA27MfmzhNL6psrm8wKqjkG4YzrN5VJ7wseGQzo9Xy9KQgg46ZG1JbuTd
         BTeCuEpjPtKz6RboQ1yFKg+gwwzi+miw+vth8i00bVDitNYly9Ydttqu+cRSLO8EdO8i
         ITUxT/rdexdTnbtMICy+8pibFpwgWg41OEIcUf+wS+LUCBVCjLPMHYGvAfmgpKFAiyJg
         nx9SM0Ca2+g2muiGO+SQ9BUDkztTFqjv/uzQXXM12jOutRf8359qeSENKRqaNKIzizKO
         NueYNI++JSW7+Krq3WV0Ll0OdKnNCXsfcE0aH1KttOO347iy1YkhFwEID/RzYorzm+JG
         cPow==
X-Forwarded-Encrypted: i=1; AFNElJ9GvkeQn9ZreFgTrszFrRcwGUzypSi2PcLxUNHgFRzIjYP1Tx9XotdAe6lYtGbzt+4g76qRb10v9VgJ8riw3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXokGJqOdgk0l+bpCtmn+bR0uVVopWBurfkmedmVX9qA0l3nXW
	Do2JKV/RtlluJ5WfYG4vq306qwihyzPfdkJlZ9YGMWekWbpE9tNyBCWlr7gWL1tK9hJYH6lKmia
	8TB0Y0k3M92I8UNdlEN4PhGAL1u6aRuPCpZbw7rOKd9mnMCLffYEF0NGM5aB3+VOae5bl
X-Gm-Gg: Acq92OESYTCSgr8xawbrhkDIVC+oQSsdKFPWYwtyR5b3XHHAw0nEoLFdVoDq+9E3Pup
	4cBL7vG1GNoxcs9nHenkxxMWz0LD5FBFXlMpifdJ5LTwRT9tbnTNcEt/lEI8VcIAmOfngV9FHtE
	4PSePLAR0lfz5Z4HQiZcGMqFgNNbqf5UeLNRMnNza3j32Qbh1/EwGViByya7eVYBURSKikNTOYD
	n/i7vU4NHvbsomF8y1BRhMFyOhjUYbE1NekQfA8na5KErsrpJmE36iOz1JYje+g7tPfFvhk4iag
	BnVAeKD8b+Zb18Zy8O6VCZmD/IbpIH23U5EdGp8ezWo/QcYyS5CjJhqpjKPPuvx/hvRDn5+L+VD
	4q3K2YCldPc+Rk6MKEXOCbSyViEX9MVGF88N9UD2Amo0Y8pLcK4mmYFfc/pkiNR/mGoUSI4Xk84
	KgmkqrxSmBrxkN+3w=
X-Received: by 2002:a05:600c:1d0f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490a2a22bb4mr148349795e9.6.1780309800981;
        Mon, 01 Jun 2026 03:30:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490a2a22bb4mr148349225e9.6.1780309800553;
        Mon, 01 Jun 2026 03:30:00 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490af0babdcsm4375085e9.0.2026.06.01.03.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:30:00 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 09/10] drm/damage-helper: Rename state parameters in
 damage helpers
In-Reply-To: <20260530185716.65688-10-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-10-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:29:59 +0200
Message-ID: <87bjdulfiw.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N1fCv4jPdPACSnz52iB0E8-M5ri9hRb8J0daiRjdgM8_1780309801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Rename some of the state parameters of the damage-helper functions to
> align them with each other and other helpers. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

