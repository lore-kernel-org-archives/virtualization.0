Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3494239BFE6
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309671; cv=none; b=bclBBfLDnhpyqiT7MynHQzM/IdtmIiVZfaOJyT416FROoUeHl5F3CaUiMwluH0RXv4Pci8jdrAmmCwDK5nix0cLpdyQcS7j5O9X8c+BQm/zycPF90UQekvoOpQtK492eAXHD0VEACzomAqXa05lXrZQPyv+lTg8p4yd9IK2Ze3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309671; c=relaxed/simple;
	bh=SAgXIx89304YyTe8+6UMLZsSBSUvLSpMqzKtolzE27s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D3jbA27e7DO/dLV73HZ9POZOPdMYsbUQ+2Mgd+3loIy53fusZt0eIzemf6q1MpnpLK+Yk8uNjdHjy/3UI/PNkuNqOGQIAhn7ht6Gh/GMCCiGmCchtf4dCVDujXoffh/dnJ8CaSfzeO1ZFvypaveGCxUd1KR2kFRvUAQnvAOsxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkvFyqP6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkvFyqP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hD1h4dJE66yskCwSbjuaF026xxijLvV5fH5oqPl0EUY=;
	b=bkvFyqP64A7n9sXJfArZ7i8OGrLfKXxra9KhXKMyfpmWJ7xxVn5sTqFRrpye7PI9IeKvpm
	0VmnIhtndI/P35aPmJXQMKCohP0M1fdwhHP3TZA015VWaVMHy1JUAM9ssoWIbhZlZyPuVd
	DQ8lw9fAaga3E6dgu1bey4L7XuzyI2E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-StGj9yTxP4WswKmiMNKc_w-1; Mon, 01 Jun 2026 06:27:48 -0400
X-MC-Unique: StGj9yTxP4WswKmiMNKc_w-1
X-Mimecast-MFC-AGG-ID: StGj9yTxP4WswKmiMNKc_w_1780309667
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49045243094so124586955e9.2
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 03:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309667; x=1780914467;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD1h4dJE66yskCwSbjuaF026xxijLvV5fH5oqPl0EUY=;
        b=eHo8nWii1TlP8LFJyxE8apKl2jupExt0T1vanTo0VwHrseid3mPR2+c/glgzDEQ1u5
         86pAdOeEJf0tto3rd7LSE8q8ZWqX2DdrPqEmabhf0d43YJDA6I4YfIm8TeRYt7kaZuAh
         TU+rLn2HZHs3Vzo2Jk29bj9WDJw0GgUXqYCkTp986hGOlADcxzaUBkzE+sW9vf/5db0U
         /zlieR+HCG1zYPuf6eU19Ke3btC7HjDGZpLlF/Cn+nrbiPl2ryq3BgJPHpQAGtwhCSJ0
         rKzS8/Pt9n+FsORB2bL5/l0dl/swc2Whw1zcMK3fblI+qCpHGZmigID7NOALWSqSgTxw
         ho9g==
X-Forwarded-Encrypted: i=1; AFNElJ8nuIa9VOC4Mkp+kZyT09ZLsJu7vBvffsM2nNt5BMchIjUjdUWtys8zHMbOl5Hg2s1WrcixfAPNQtLhnCrZ6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqSwS+wTqgMsbHFDH6MmwT2LB+aY4vQTI1xjVB7lQfQJs5gy/m
	R7O66z/Nt8nESm9NnRkcx2JdPNRYzgmCJXqMmbW7l7wEKI/nbq6VPk8bbOtZwc3FuaIFSzFYnA3
	GGNF9wltRFtLi85QYn/S81VnBvuwzk+M2nULhijn6wjMvZil5w4dkg9cdERj6kdwfKr7J
X-Gm-Gg: Acq92OHje7aoDzTtUWBtvI0dEmkOKD8uStd8AdSnOXORA86eRG9SriHxgjjKwC3MX4/
	iPY371XcGtg+gkeAz9vTgH95TVVnmPAFvFe4UAtnqh9Ddu0MZHC1yq3ForpLLU6EvguI+NFXC1D
	3BCxPjQivG3nRNH2kgEAt4tANNpDuapVzo42gNB3JuhRB0e8K17RvSEsL3GPuvf8lXZb6eFNVIk
	Y9FBIwHlWk9zqThkSIvbz1uO9lj582cYLsmQFmG07jBm0AScmyMun3cnS9oRO1TlP+0iPmb8/El
	TR2Fnm9jwmJDzUswqP19FIVQh1IEhNiAP1tx3c9t5zstArvHqHceJ5VJkrfH50dd82VxZhUkg8f
	/YXHOliio3EafXp/fytyomh1AYWXwhg2sYmK4YdeeSmQAzzszID92Ltxfy5aundBoVKT/Ptpuwe
	xuPOXKb01RGghpiq4=
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490a2933355mr153783225e9.12.1780309666750;
        Mon, 01 Jun 2026 03:27:46 -0700 (PDT)
X-Received: by 2002:a05:600c:a111:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490a2933355mr153782735e9.12.1780309666314;
        Mon, 01 Jun 2026 03:27:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef32fabcasm23690022f8f.0.2026.06.01.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:27:45 -0700 (PDT)
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
Subject: Re: [PATCH v4 06/10] drm/damage-helper: Test src coord in
 drm_atomic_helper_check_plane_damage()
In-Reply-To: <20260530185716.65688-7-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-7-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:27:44 +0200
Message-ID: <87jysilfmn.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DqsEtxKhRpYNgaCROyssGZoh6NzfXuTAkxMhR_3u-1A_1780309667
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Planes require a full update if the source coordinates change across
> atomic commits. Evaluate this during the atomic-check and set the flag
> ignore_damage_clips in the plane state, if so. Remove the check from
> drm_atomic_helper_damage_iter_init().
>
> This will help with removing the old state from the atomic-commit phase
> and simplify atomic_update helpers a bit.
>
> Several unit tests check against the change of the src coordinate. Drop
> them as they do no longer serve a purpose. If the src coordinate changes
> across commits, atomic helpers will set the plane state's
> ignore_damage_clips flag, for which a separate unit test exists.
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

