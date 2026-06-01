Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C23537EE
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309830; cv=none; b=mbkeg15sZrJhFqH0hFWAsRZ3a9bHXfAhwNnHULVmArDYtfd41vc6fvSU4IpjzpOY9lKkVn0RM04M8GuJv+xGZ2q59UJBQaitzeu+hXmipW3/An4ILnfnIURWcXxpCjnJ6sDiPH83qQKTAyFogE9cyDhA57uV6e0RbQmpK0A2vnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309830; c=relaxed/simple;
	bh=QwPby8X/UWc3SSFrtbajyvQr/e6eT36Z4APpEAoWVYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H9w9YYgVyHHzyrJlOxPNXLtzpl4P4iKjFpdx06GUdlrm9zujYwheYiRJq6296S7JaYGUrgtC/1Wh8ovsMuOK/hwxMR33+GTLyJWBDsKptt0RPRiBXO8o1QHePS566RhB0ir3zGcOdVX7f+D8zEzAsDXJZMJwexmn950ORWgPmus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQm6PenR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQm6PenR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m5PnIUHVz9ACSP+/e7SnC4cD1TL+Z3tg4EIuDM06718=;
	b=GQm6PenRqlHE5fwAvh+yBpQ2UAw1QmnxoIow7O6zDOsku8TzYA8QdOyu3j6l42Q8L6yizA
	5a51IR6zIJR1uWwRz+k2MmEajcFk0WuFqy9wnSqKh5LCcXCM5yv89TPmlIFNRY2FRoVaWv
	s6u9HfZ18Lg58gep2XyVg2OvnJBRT1w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-vTzB4LSBOwGMnRsRqMKd4Q-1; Mon, 01 Jun 2026 06:30:27 -0400
X-MC-Unique: vTzB4LSBOwGMnRsRqMKd4Q-1
X-Mimecast-MFC-AGG-ID: vTzB4LSBOwGMnRsRqMKd4Q_1780309826
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49049100a40so61802305e9.2
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 03:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309826; x=1780914626;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5PnIUHVz9ACSP+/e7SnC4cD1TL+Z3tg4EIuDM06718=;
        b=FAgc9x4vO2n4JEwRSr60ldYstdPXddh+r8WP0VQ54A+R/IiOVU5HQlSQENkD0M9qwq
         +rV8EywI5DURa21PRB//GhqyZfmpIvqBtpW/eh6yE7/boZw/pXpS+Xyh0zO8I9hfSxQS
         iARzc91SmHnz3kYwi8hnNBvQxxBMVNE/ro3Cv90EjHdZKSeaHtiQ/j5QwrPmI8VBM6Al
         /zzPL/zFw8xerMSW9HEOirFY3BZ/b2yvlXln1aM2ZllfRKclC1xJNKUJeMQewz5Vs3bX
         rQ2wcZli/pCHDGQBlH1r+zGoEoCOQHrCeNFdzfKY9LNRW7OSRuqYlO/OQ2SpcTQ6Lg5c
         Y3KA==
X-Forwarded-Encrypted: i=1; AFNElJ9oEvxDbnhTeXfcLQjapFwCTJtEhQjkzQbQ+TgDSzLqZjh2wIEZpcqcZDqeS2HXmaCJdTBWH2qs2+moDuQsJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKFPPfnk3BfBTxpSfM693l7SZVXbGDy7XdTTME95Y2hNYoY3La
	Bz+KnDpgSgmWO0AE7PRRdMEBtd2rs5FpF5SvetmosXKLoleYeIu2p8ldhhryHI7RZ7u5CTRDdsF
	iK2THlrrJdpw5waosgvMwXOjMLOg4KMIHt3ExRmnZ81r/oiXCZta2PkxPvpzeVrYJGUjk
X-Gm-Gg: Acq92OGV+LWp4tawX4Q0xFxx74yc4BV9V1k6oO6hiCaItdT/x+i7EUUO1LrJy7MGgTC
	3PPwypCjV5BFRzPJQ7qR1gKumU9CIbFS/U3hGago6UIB6Ib2bof7dWQOv29ivTSGffbn6McG8ke
	Q5zKX/FQZ0vzkIqKK7RMIQ+kazkUi3nIED7YwVTcG7oQJ8lKr+fowgydf2f7CshYUH42l8QlOyH
	33/ohHOwqVPQue3bhNP2jES3stqLRacUWWnq2GL6BqXbxfK8fUPQosXXafdADMkU1MOG/UAWX7X
	5XlvPQClah5Wpq2VUGRy/kkF+FhbsbvVOvBhMXgjBhUJ+zvPxWdPMnCegfmjh8WT3xtfFgFbZDg
	nMNgQur5XFeLZe9i+yoIhFnhfHPd8Ra1p5hHEw3SboEeHJUh5OEc0beizpKg3viM1E+3jnWSJpG
	fS5iG0IkO9vf/2qt4=
X-Received: by 2002:a05:600c:8582:b0:490:51e9:deba with SMTP id 5b1f17b1804b1-490a293b7c1mr147144795e9.27.1780309826064;
        Mon, 01 Jun 2026 03:30:26 -0700 (PDT)
X-Received: by 2002:a05:600c:8582:b0:490:51e9:deba with SMTP id 5b1f17b1804b1-490a293b7c1mr147143955e9.27.1780309825482;
        Mon, 01 Jun 2026 03:30:25 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490adb4381csm24027695e9.3.2026.06.01.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:30:24 -0700 (PDT)
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
Subject: Re: [PATCH v4 10/10] drm/vmwgfx: Remove unused field struct
 vmwgfx_du_update_plane.old_state
In-Reply-To: <20260530185716.65688-11-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-11-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:30:23 +0200
Message-ID: <878q8ylfi8.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: znWeNn9qBLJi_-YbWCC7bXpfkKXaGPoyl-Rhs5cD8bA_1780309826
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Plane updates no longer require the old plane state. Remove the field
> from struct vmwgfx_du_update_plane and fix all callers.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

