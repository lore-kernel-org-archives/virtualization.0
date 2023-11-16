Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD0FBF2
	for <virtualization@lists.linux.dev>; Thu, 16 Nov 2023 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IF5q+L3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700120781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LD5mFa7Ljzodyl4DGNnE3tN04HrOGXS/NNuwBDagln8=;
	b=IF5q+L3HxoIL5LMhKUeQ4nAzfcXRLnSDvfjItIJKEy2iETyxWV03Nb9CWpMXGIL+Rnv8Lc
	R2+cB1Qn31kzls3hVmsQZ+zgoUZlSbO3BUhcTERAbQ1YUO7BPmKBhMI6LATeEEiuouOccE
	EpzSQpH5v1YKSxcJVl3qq9/FgWqQZsg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-J2y-Rr7FPkGcmzlz_jPOfw-1; Thu, 16 Nov 2023 02:46:17 -0500
X-MC-Unique: J2y-Rr7FPkGcmzlz_jPOfw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4090181eec2so2834915e9.1
        for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 23:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700120776; x=1700725576;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LD5mFa7Ljzodyl4DGNnE3tN04HrOGXS/NNuwBDagln8=;
        b=li7hnv/A4cUMzLAnqEYYSp2C0y/EGa730m1SKksSChLFtt0s0tf/r1Qs5pZvCKCYRM
         DmAOTB2jgYVS5iDa8aivugyEQ5Mr+8LQ2qt4DJ3jVt6aPcJNGd2zYNSU6pV4/eFggQ/G
         z05krvoHacsIyAyuqZDRGnw8tMRBNE7q8Nzx8VHOQwPx/1GGomy1BmCvWgII2uX/0laT
         OU1KPSzDIW+/xfOJt3dRWCyBhEXRmrix1k1nGAlqHoY/vW6Iar823xoOpvA/spI0kWzC
         WwdWd/JorV9Jlol8S/YvzJ2h5EFgBLG8db5kMWSRcHrARXlIKAdWZYxt0m7i3P05u/un
         KV3A==
X-Gm-Message-State: AOJu0Yx/OjHCGUr9A8BmcJoyq+xTw4kc05t1kvomHIUwroht8I6c/oSD
	+Ur2Pz3JdOnjN1y5aMU2dFJKYG+dUgr+DgVpvStmtFyVvfU5+w/gtA79f95YYMAVu+nSGWBPBto
	3j32A/8dQheAZCmSfVM7NCCESgJs=
X-Received: by 2002:a05:600c:1d93:b0:406:3977:eccd with SMTP id p19-20020a05600c1d9300b004063977eccdmr11516329wms.33.1700120776415;
        Wed, 15 Nov 2023 23:46:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNCg5qd5AbZ0tYK0uFvI/J3tJ++zfJ/l5opv0/UGjSHKkjb6Zp4IdC4i38tjSPgJYq49xhdQ==
X-Received: by 2002:a05:600c:1d93:b0:406:3977:eccd with SMTP id p19-20020a05600c1d9300b004063977eccdmr11516314wms.33.1700120776005;
        Wed, 15 Nov 2023 23:46:16 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b0040772138bb7sm2455636wmq.2.2023.11.15.23.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 23:46:15 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Zack Rusin <zackr@vmware.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "olvaffe@gmail.com"
 <olvaffe@gmail.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
 "nunes.erico@gmail.com" <nunes.erico@gmail.com>, "airlied@redhat.com"
 <airlied@redhat.com>, "pekka.paalanen@collabora.com"
 <pekka.paalanen@collabora.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "belmouss@redhat.com" <belmouss@redhat.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "daniel@ffwll.ch"
 <daniel@ffwll.ch>, "gurchetansingh@chromium.org"
 <gurchetansingh@chromium.org>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "airlied@gmail.com" <airlied@gmail.com>, Linux-graphics-maintainer
 <Linux-graphics-maintainer@vmware.com>, "contact@emersion.fr"
 <contact@emersion.fr>
Subject: Re: [PATCH v2 0/5] drm: Allow the damage helpers to handle buffer
 damage
In-Reply-To: <a16a61582f90a5b490fb7681b44864a4801c830a.camel@vmware.com>
References: <20231115131549.2191589-1-javierm@redhat.com>
 <a16a61582f90a5b490fb7681b44864a4801c830a.camel@vmware.com>
Date: Thu, 16 Nov 2023 08:46:14 +0100
Message-ID: <87o7fu5eex.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Zack Rusin <zackr@vmware.com> writes:

Hello Zack,

> On Wed, 2023-11-15 at 14:15 +0100, Javier Martinez Canillas wrote:

[...]

>>
>> Changes in v2:
>> - Add a struct drm_plane_state .ignore_damage_clips to set in the plane's
>>   .atomic_check, instead of having different helpers (Thomas Zimmermann).
>> - Set struct drm_plane_state .ignore_damage_clips in virtio-gpu plane's
>>   .atomic_check instead of using a different helpers (Thomas Zimmermann).
>> - Set struct drm_plane_state .ignore_damage_clips in vmwgfx plane's
>>   .atomic_check instead of using a different helpers (Thomas Zimmermann).
>
> The series looks good to me, thanks for tackling this. I'm surprised that we don't

Thanks. Can I get your r-b or a-b ?

> have any IGT tests for this. Seems like it shouldn't be too hard to test it in a
> generic way with just a couple of dumb buffers.
>

Yes, I haven't looked at it but also think that shouldn't be that hard.

> z

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

