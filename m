Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB93CAA49
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172638; cv=none; b=jE5PC9Eef0Wqdw8TlKtQKV4lZLeGYfACPD7hbb2ExeDPFQ7gqswbHKwZx7BanX3fng9iI7EHIGV4pCNpFjCjHAMMEPAgGuVsXxJ+j+rXWDUuK92dT7n3GphJD/VkUelXcUVmu4sOC13J6o329OXPOVWDhAatNtLg/erm4ctryR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172638; c=relaxed/simple;
	bh=oPMscQPT7Ovr3uXegR35yeYCHSRNMFL4voLy9Xybado=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pJ/fC7DvzgzHiZbqOInoknVnZ7RRxXao8X6fkaImjdp7fM7Mk+mcBGO87jRVaXrm+dx6TXxSn6OHpnv02RQWGtaL3py+kdq6mXjVfJLDQyfHDpeqRvB8U/i0xvjlPr4neBOlNR7QH9FDsjwjomlv/BHct6OmhYR1K/fXc41mkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWqqg/qE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWqqg/qE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQRyqUjYEtr0y/u9/sXosv9fI09dOaWuwDl+f7MSICU=;
	b=fWqqg/qEEOeBhLTiXQh5WxsmVoRKTGr1GVdI4gJB/RA9tyWt61Ta7r5+D5i885hdF+V7hr
	b/+HE/ZO+JeZQG2lviWKUE/MbIKl66dSoE1DSNNFfYGYdYwL5xSyeSzlkRfNcD7R6XQ/NB
	RjtD+vlnBM15QU09C0/DzgBpVCzYt54=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-1XUgMtaZPm-zu8nGGhjojQ-1; Thu, 11 Jun 2026 06:10:35 -0400
X-MC-Unique: 1XUgMtaZPm-zu8nGGhjojQ-1
X-Mimecast-MFC-AGG-ID: 1XUgMtaZPm-zu8nGGhjojQ_1781172634
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490dad70f95so22702445e9.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 03:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172634; x=1781777434;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQRyqUjYEtr0y/u9/sXosv9fI09dOaWuwDl+f7MSICU=;
        b=g1WeOWK2gfKtYw+6+3dhyaIcMYdNI+LtwrieIp5uPRt/L1iTPZ0UQKHVJ/5GcVWQU6
         7QYAPEnCkir8pu8R+9ZLglw+CDI12CzxVAqGJTfbAeYJ3Xvyh0KP8g49KPyxas39+54V
         +ccIklDl74JkixWGSrS/p8E/YTvamymdvAGCCgLpA7FLZitancZwyyhxA0OMLKndLOsD
         nsxR3yOOnwl251WGyIO1db0GfUJE33h1FgXej5f6b1yore+JxLIJHj2ID37kA93UGjvx
         tgJUVZmRxh8IylFtlPtkYVaDPT0TMWi1soP+QUrOkJJSGPmHH1FPh238WtrBP7Ck6lvd
         ibGA==
X-Forwarded-Encrypted: i=1; AFNElJ+gwV9/nsvH9dH+5oIf1aUIPCkGpDRy+J/aXZk0e5AAVhR6nnGjPrupFerAjQNFJIWhYQTfX2a0G82KQ7GdJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi+BpBscWK55PkRO2AfxNsieIpYES0Wbgz4GEq2+ofySEThYZp
	r2qzMDrXnuOmBBCACOePWMcLekx3gJ414Hmx72LHezqMTnWML7/UcuwIOIDr8/wo16GocOA87k6
	w5EgmLQ9f8PF7dfe/hr/9JN9T/22s6dHUConBp9GuFC9pBaja6pmILO/uhWvWYZyHJaQY
X-Gm-Gg: Acq92OH+Byrvd0dbPgICftuyJJ4IKcWTx/DHl5xcV7IkYklyGScCpTg8qB7jThv558V
	wutVSkW039M9fJyHaZRX+H55s7kAIPDOz9eXwMBN1o/GaYxXHwsX2JqRVOiGgvOyM2/FxbGaNn2
	B3CNlbm2EXBJiJdY+JQCoB5dESBe5RokMLu4LA6Q0NGmkWbuVUjVU1CftQDB0z+54THm/s4Cgzv
	/5AXQ8a7IF1j5nTXKryUj36aDQbKtZs5PLCpsposCZDdD3+NyXltEr5qSZES3hBtmY628LnE7Cz
	bCRe5opnZuD37No2U9UTPQUBjvfrBrfmhEh2Irm0WsVIIF35SCW02RVdBtUI1+AZmicHM9lECcX
	jyoJTcmNLi3/+hTmrE2b/+kxU+Z2DjbFMgDE64N1EWeJXyJAimSBQR+/S7Fc75O00MmOcDkC7Lx
	0EKk8qjnfDApIEqzU=
X-Received: by 2002:a05:600c:4685:b0:490:e1e6:8988 with SMTP id 5b1f17b1804b1-490e55dc1damr31237475e9.7.1781172633823;
        Thu, 11 Jun 2026 03:10:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4685:b0:490:e1e6:8988 with SMTP id 5b1f17b1804b1-490e55dc1damr31236645e9.7.1781172633469;
        Thu, 11 Jun 2026 03:10:33 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52ac9aasm38076025e9.4.2026.06.11.03.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:10:32 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Zack Rusin <zackr@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 01/15] drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-2-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-2-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:10:31 +0200
Message-ID: <87y0gl5qw8.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hL5aMlP-C99qclJPdeHVV1mUo9dwNOCoA-kLBfkBKoI_1781172634
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
>
> Test the flag in DCN code and do a full update in DCN code if it has
> been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. This driver does
> not do that, but DRM's damage iterator will soon rely on the flag.
> Therefore supporting it here as well make sense for consistency.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

I don't think that a Fixes tag is correct here? Your patch series
is changing the 'struct drm_plane_state.ignore_damage_clips' and
the changes make sense, but definitely isn't a fix in my opinion.

Having said that, the change look good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

