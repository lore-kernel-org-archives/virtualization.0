Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39022AF05
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkBq32wE"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72A2860B23
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 16:28:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72A2860B23
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XkBq32wE
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7g1dGstD7yKC
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 16:28:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 56B6F60B06
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 16:28:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56B6F60B06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699979317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zT55sICneOruB98vZghCPIaAQzAuT2+qJvhhUcjEcFU=;
	b=XkBq32wEBh2K4uBSL0gBD4FbCaIaLCkSfXN9oHb7Gi8BKTYLsKuMNqtuHEg8wcmLjclaEM
	BfAjOt8gVbwC7n2iE91LCm4EKwZQayNeFx8BVSqaCrLbETAl+lBX8x2vvTdL0E3C5bRF+7
	TQOzKaQlNXZJYpfs/3JFnmkeUVFzSME=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-77lUGISKO02s5bTt6TjkSQ-1; Tue, 14 Nov 2023 11:28:36 -0500
X-MC-Unique: 77lUGISKO02s5bTt6TjkSQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b6cb6a1a7fso5707620b6e.2
        for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 08:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699979315; x=1700584115;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zT55sICneOruB98vZghCPIaAQzAuT2+qJvhhUcjEcFU=;
        b=I9Rm+XkgFnC1yl67H5ywrDE2WVlvrpkthvdtAP8A6DDet8wJ0FQMfD/52IdFn2sAXq
         +gX2I3bHG0ruxMdRquIFrAUYuHfdRvnsscrkRqVGqKO2JCn+tl/bGATyHRN7QIBjZvWh
         m38Ng+tYTyamknP9ddgrTaSges+MDGTjLKPsh7ijPoAbc0T8jnVduEgPBhrqCrrMW7MD
         dRqu38B2aci1Lj7dw2wJrmUDdYnJ3S0BgiXfYcTTO2LS3MjkbfqLGarwOcHpEpmrx/uX
         EZOeupWYHR8WTdw3bZbEmQv5LyFzuLpnhkcWwHzqSLvSzhDMzlvq4kJJTYjaNH+LkVw1
         dFRQ==
X-Gm-Message-State: AOJu0Ywwfz5dnl0eKSp0v48q7seGaOuA7Nwc24ru11YDQAVaNFg6dfl8
	UCPxD9TTl6W5dMrYdkOO7o4W9PDrgT0f8NN/AcgsOoCnNZRHRG0HvImR9bI+keGcZHxc9wMqkR6
	YMQaQkEETutE7RIfK+iCiShLsCPjlR9ZpQh5LBCU5Eg==
X-Received: by 2002:a05:6808:1b13:b0:3b6:db1b:67be with SMTP id bx19-20020a0568081b1300b003b6db1b67bemr12820743oib.16.1699979315535;
        Tue, 14 Nov 2023 08:28:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCs4OZHiYJNQd+EbwIGjg3wDC1a9KzyEDPS/n5hkAeLDacLMu9zBSwKsOA9Yp+3SBU3M3l2g==
X-Received: by 2002:a05:6808:1b13:b0:3b6:db1b:67be with SMTP id bx19-20020a0568081b1300b003b6db1b67bemr12820694oib.16.1699979314953;
        Tue, 14 Nov 2023 08:28:34 -0800 (PST)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id t26-20020a05620a005a00b0077263636a95sm2768517qkt.93.2023.11.14.08.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:28:34 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Cc: Simon Ser <contact@emersion.fr>, Sima Vetter <daniel.vetter@ffwll.ch>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, Maxime Ripard
 <mripard@kernel.org>, Bilal Elmoussaoui <belmouss@redhat.com>, Erico Nunes
 <nunes.erico@gmail.com>, Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, VMware Graphics Reviewers
 <linux-graphics-maintainer@vmware.com>, Zack Rusin <zackr@vmware.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/6] drm: Allow the damage helpers to handle buffer damage
In-Reply-To: <9296c184-22c1-4d71-8b11-2d26f49a5790@suse.de>
References: <20231109172449.1599262-1-javierm@redhat.com>
 <9296c184-22c1-4d71-8b11-2d26f49a5790@suse.de>
Date: Tue, 14 Nov 2023 17:28:32 +0100
Message-ID: <87wmuk5mfj.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier
>
> Am 09.11.23 um 18:24 schrieb Javier Martinez Canillas:
>> Hello,
>> 
>> This series is to fix an issue that surfaced after damage clipping was
>> enabled for the virtio-gpu by commit 01f05940a9a7 ("drm/virtio: Enable
>> fb damage clips property for the primary plane").
>> 
>> After that change, flickering artifacts was reported to be present with
>> both weston and wlroots wayland compositors when running in a virtual
>> machine. The cause was identified by Sima Vetter, who pointed out that
>> virtio-gpu does per-buffer uploads and for this reason it needs to do
>> a buffer damage handling, instead of frame damage handling.
>
> I'm having problem understanding the types of damage. You never say what 
> buffer damage is. I also don't know what a frame is in this context.
>
> Regular damage handling marks parts of a plane as dirty/damaged. That is 
> per-plane damage handling. The individual planes more or less 
> independent from each other.
>
> Buffer damage, I guess, marks the underlying buffer as dirty and 
> requires synchronization of the buffer with some backing storage. The 
> planes using that buffer are then updated more or less automatically.
>
> Is that right?
>

In both cases the damage tracking information is the same, they mark
the damaged regions on the plane in framebuffer coordinates of the
framebuffer attached to the plane.

The problem as far as I understand is whether the driver expects that
to determine the area that changed in the plane (and a plane flush is
enough) or the area that changed since that same buffer was last used.

> And why does it flicker? Is there old data stored somewhere?
>

It flickers because the framebuffer changed and so the damage tracking
is not used correctly to flush the damaged areas to the backing storage.

This is my understanding at least, please Sima or Simon correct me if I
got this wrong.

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

