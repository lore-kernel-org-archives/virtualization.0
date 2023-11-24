Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139031A5A3
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzBRBjPn"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85B01614F8
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:56:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85B01614F8
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KzBRBjPn
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 31SSg-r9ovL5
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 10:56:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E170D614F6
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:56:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E170D614F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700823410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4lIC23ZyZLJj/oYUj3wwJ9PbugdSurQXfcrH9U9VfYw=;
	b=KzBRBjPn75EPFXQmrdZAcao9Prerc8uwlwuXbMKBPGCjHqAFwrB1JkZrJAeZg1yph9BnaJ
	08h9tZxDQmauS9+CeW2UyVdmgWa7XjIN985aA29Idh9PXT6ylSUfRwMAJk+a8i7goanMbW
	6TGGjd8PE0WfJsK2AY05KYadrLIntOQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-4-M0Iy7zOfqnPji5X8sQzQ-1; Fri, 24 Nov 2023 05:56:49 -0500
X-MC-Unique: 4-M0Iy7zOfqnPji5X8sQzQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b310b5453so10942165e9.1
        for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 02:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700823408; x=1701428208;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lIC23ZyZLJj/oYUj3wwJ9PbugdSurQXfcrH9U9VfYw=;
        b=sdwKDH8Jt26P4pVOrnRowi5xMDm1Jur2qpZqjT8CM9H3yW8Cowq8jX/6Y+w+oX8T4h
         rpk37h3pkAxQQZEkGfq1j3u9wqrLzMWkQw+bkYdtJhj9tEySo4oNHSoeYBL+KYrE3FgY
         5TyEM3nVoOvSH4dd0LIG7vA+AwBPLZbsJK9w8fhe781xeTIjriZWrDfaHftvAZQRJtha
         SagonBRs0CzRxJCvTPlhhJR/9yjcSUhJp6Z8suDNeu+bCDQUE1e2CL28S0gr/7QCNtqT
         L0bNI/RmZJzyJIP3fR8lKZs4VfPQio9qq2kVm0BwG7qTZ1JXlPFP3akj+m/29H9rF5pr
         3Rew==
X-Gm-Message-State: AOJu0YxxhrhInK0hC+7D2wdX3t0sTeHwoEFHS7aYzACnY3CzSKoeAc+t
	7nKltAllHZDa/piOF8tMTdGpENhilC+JOPVtCQg5ieB7BBECtI+oCS5/MNlWMYK4Jms57uorq+x
	227FbH2lxiPFRf9RYl8gtToo7XMew0vgb+Ji2Laz59g==
X-Received: by 2002:adf:b1d5:0:b0:32d:aa11:221d with SMTP id r21-20020adfb1d5000000b0032daa11221dmr1609050wra.27.1700823408223;
        Fri, 24 Nov 2023 02:56:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8B1Z5Xh4NJM4v+jFXHb5dS3jyH1zOINaNv+9ttW9vntLWVjkhOG5VMvKimijwhgUpy+ZIgA==
X-Received: by 2002:adf:b1d5:0:b0:32d:aa11:221d with SMTP id r21-20020adfb1d5000000b0032daa11221dmr1609038wra.27.1700823407919;
        Fri, 24 Nov 2023 02:56:47 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i2-20020adffc02000000b00327de0173f6sm4052394wrr.115.2023.11.24.02.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:56:47 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Simon Ser <contact@emersion.fr>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org,
 zackr@vmware.com, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 iforbes@vmware.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Chia-I Wu <olvaffe@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Hans de Goede <hdegoede@redhat.com>, Matt Roper
 <matthew.d.roper@intel.com>, David Airlie <airlied@gmail.com>,
 banackm@vmware.com, Rob Clark <robdclark@gmail.com>, krastevm@vmware.com,
 spice-devel@lists.freedesktop.org, Gurchetan Singh
 <gurchetansingh@chromium.org>, Jonathan Corbet <corbet@lwn.net>, David
 Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mombasawalam@vmware.com, Daniel Vetter
 <daniel@ffwll.ch>, ppaalanen@gmail.com, VMware Graphics Reviewers
 <linux-graphics-maintainer@vmware.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
In-Reply-To: <xUgaKXv4lqgCEWWlB4KRGx-yLXefTg-uXEdXaTqAhOTxC4G7bCILTK9SH6ymdmMMBLooAl3_Kdvl5JXeUA8Hofg9PcCMBhPWhVhnCoxvgqA=@emersion.fr>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr>
 <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
 <87y1eqc5qk.fsf@minerva.mail-host-address-is-not-set>
 <xUgaKXv4lqgCEWWlB4KRGx-yLXefTg-uXEdXaTqAhOTxC4G7bCILTK9SH6ymdmMMBLooAl3_Kdvl5JXeUA8Hofg9PcCMBhPWhVhnCoxvgqA=@emersion.fr>
Date: Fri, 24 Nov 2023 11:56:46 +0100
Message-ID: <87leanctch.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Simon Ser <contact@emersion.fr> writes:

Hello Simon,

> On Wednesday, November 22nd, 2023 at 13:49, Javier Martinez Canillas <javierm@redhat.com> wrote:
>
>> Any objections to merge the series ?
>
> No objections from me :)
>

Perfect, I'll merge this series then to unblock the mutter MR. Thanks again!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

