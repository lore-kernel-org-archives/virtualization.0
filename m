Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85113CAE81
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172780; cv=none; b=aOPIrpvNWhtaPaNpeWG3MfcUe7zEdzoVYeYsWSKVwtCjHN4BVUlNHTDi5+acHXHtuT3K89jiDLq/BGB/8EPG1mtUU5t1zcwtRz8UnPUcYIp0gWyDm1mov6JRnFZb/clsM+/2HqThvxUZkKNV0l2R3shdJTXn9mzWNO4X05Qg0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172780; c=relaxed/simple;
	bh=JQ5T8Ove8mxcipFoyWUXvQY6lHTB2vT/asE++CDukY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThMQRVZ/zJdVO+QYADDTKtHh3sZTp70z5RFjX2esDbb4SEfN/VA5PLvHsa8eCbTbE2D96h5eyyAbhdJa/K42l4ue3cZpD0K5mbggkAT/8UR87Gn+gTwi2WaN3/Rc0rQNvItXknIgV5E1/l8bqusC/9NYMFum/9hwq7fNxPGjbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5P8aYKS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5P8aYKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
	b=W5P8aYKSblK3mjJytCe0Ph6MGhk/zYy591McbqpHdtgc5kRUjVo6Uibuz314zqoR8ND4AG
	QZ1jdRPlTX1qhVOO9F9cdF8bZ5grbi+hAWRyio/5e2OaC1xV11HkTD+5kOQc+/i2izSCKz
	Lv5uu5PjTZJCM4Xe1rB06/6F5cvl1TA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-LEpOut6GPx6ZJx4go8ljPg-1; Thu, 11 Jun 2026 06:12:56 -0400
X-MC-Unique: LEpOut6GPx6ZJx4go8ljPg-1
X-Mimecast-MFC-AGG-ID: LEpOut6GPx6ZJx4go8ljPg_1781172776
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490bae3a39bso19176195e9.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 03:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172775; x=1781777575;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFYGrtWClhfZ3Q43+mH8yJXNZwovzAkM0JScXulojb8=;
        b=Zi5b6p1ma87m2/LnIfnNl0xcYYs66vgRaZtENymWVjoRicT+4hOFF0G1OoejKYhE9S
         j9Gp75ufpDoJpQ5oiFNkZUxzVv4UtUeT53DG1y/gGs8EQeLy7qHKm4Cq/qjXkhU9vZUc
         vrrGCRE+Ap7fatJIHnMsouBWxfRNHWlPEa7uuiAszbVfsGQwwFoAun/fjp7I7IeO9AKA
         bzQRNlD5VCGmT/zCjpdJ2QJhEqsnowgVYOYLClQ6OfSlARWqJfP43/mdlqsRjlS1Vdh8
         iDWi1HOVtMSDkC17vKRKAmrU+QW2b2EnAqJ6IHYoQxI+953vVcMJ6SSE/XmHL69LAE6K
         ZBlA==
X-Forwarded-Encrypted: i=1; AFNElJ9MVFs5VG9hKzO6JUal7JDRmWF3lge0BNnPNEoloa15fG8a5+/9hVflbthkiUtUrMV8mhybOJCW1OLpilMNgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsGJvZ+BxhrvSZX/nzmLRWskJh0928bYYIZp8WI/D9SX8LWEvk
	mWi3d+oYmmswbJks9W32vgSrce+E36d7rn9oSF3hgwX3E7hFSrmhbOjwCHfINrh3k8M66Kc0doO
	By5SVIi0Lu6JDZrXzana277jvFqhnIe5z+KqIoFkSIhXFF4OD7WUW2rMV04VPtWdeUEhp
X-Gm-Gg: Acq92OEGauJiFUdBcWu7NrtFvMwyTMMACRQ1b3GQOTe8bU/zbvDUqvVJcOnw4bJLsAc
	IRT3iCW05wz5Nh/blykpe61vV6/A10KI/RZ7wEpolFxJ0VkmlxOlL7T9yBU9k0O2eoOD18esaU6
	iFNSec4sSDy4W3RMC4P/HLCAbkHJviqBcNtkUNuSFZ9PCDdD0lZgKIbqePSnRciz43eu8xnN/UJ
	etIaTxplozNizVNUWLcuS4PdfmoSgdOsvV8cTCWDXVYxXYbjViSxoS0SmIGCltxUivc/pBNDnoJ
	ojCTi+/zlIJnKZUBQGM2Q7+B55Y8F5EkjovM3jO5q8MPOKDA5QLYWFSTS88MHoc+jlc/0goj4hz
	kkw6fyPdEXTbCr4RpwRoDr20VwKGtQ8mbnqoxVjtFwx0mqu0Y+0YVPkRT7EOsMmiAOwNg8V859F
	YHJLwzvvh/uYEcZLo=
X-Received: by 2002:a05:600c:c493:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490e5639bf0mr26218505e9.24.1781172775387;
        Thu, 11 Jun 2026 03:12:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490e5639bf0mr26217975e9.24.1781172775016;
        Thu, 11 Jun 2026 03:12:55 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e532c778sm38051805e9.14.2026.06.11.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:12:54 -0700 (PDT)
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
Subject: Re: [PATCH v5 04/15] drm/vmwgfx: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-5-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-5-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:12:53 +0200
Message-ID: <87pl1x5qsa.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EanNuM03H3e5KRbZzLhCEjih0oaeG_rzqVSiGgjJxOA_1781172776
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
>
> Test the flag in the primary ldu plane's atomic_update and do a full
> update if it has been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. Vmwgfx does not
> do that, but DRM's damage iterator will soon rely on the flag. Therefore
> supporting it here as well make sense for consistency.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

