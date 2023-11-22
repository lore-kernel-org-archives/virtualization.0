Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C79482E1
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgKniuUK"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07B8D41B49
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 12:50:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07B8D41B49
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LgKniuUK
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uo95CmEOBXUA
	for <virtualization@lists.linux-foundation.org>;
	Wed, 22 Nov 2023 12:50:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 077C641B3E
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 12:50:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 077C641B3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700657399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7CwGgnA5jX9Ulr8vRs5/VIijolfgnKW6FNaANq6NMw=;
	b=LgKniuUK1qMEE26G4bb+UQyvZWVjzjQ+6Ao9XZrVnihGm44Tryt2u1WSXRSRTtBDGWf9Wm
	cFAV6kWmJPbehkpjIdm5joNSQaTNz2jTc4HklDFbvzKCA0eD2Iq2IjgdbghgGkO436hIxU
	zMBptiz0w6oa1Or9pwq6TwU11JR1+M0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-rpRoDnAvPL6WFbjZdlncsw-1; Wed, 22 Nov 2023 07:49:58 -0500
X-MC-Unique: rpRoDnAvPL6WFbjZdlncsw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2c876d239e6so38371121fa.1
        for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 04:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700657397; x=1701262197;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7CwGgnA5jX9Ulr8vRs5/VIijolfgnKW6FNaANq6NMw=;
        b=QypfROPBQ8n2AtYepYTkWkSfv4uCXA4AHxiClXF6rSJe+VHcjJtE79LJ+UVBE8VFy1
         LWPnaf6j2qCJlg/46XbePtWUO+dElYITi24S1AGqUlWODEgdctIiO8Jti8teRDIpTW2v
         F+RQEBOkYjjvVY2OuBYrhiPniVYpa8ZqZtjn5gcDXyCQngZClZWEJcUy77DsMqpKFcfL
         oZ2tzIozriDvbk9JErX96yRkuXV1E7FZf4OBigWkF46pZMHLj651EIWN8Qj2M7yWwGEH
         +zEbVmlSmJLOhTdYHncVV141Eu7UXj9nE+eQOcFT1OQlyKk8iZjKRd8s77DRAl1c2HCI
         6UuQ==
X-Gm-Message-State: AOJu0Yxk30wMob3mwo/+b+fgZKBBIEPyXyRs9Q0+Ai39g5moMx8CpIOO
	v63i5ailMDWZUpPcdkZBL0uLTPPIxwKPVprA2EgfCutAHCVSJHaByZLsdzwX+NI3Y7Xr49SdcMI
	jsNqahwDNehM10MpDeyJK2SvT1co/zrIfKwLSOfw2iA==
X-Received: by 2002:a2e:98c2:0:b0:2c5:2132:24f6 with SMTP id s2-20020a2e98c2000000b002c5213224f6mr1644922ljj.12.1700657397315;
        Wed, 22 Nov 2023 04:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjsqJ2SuGehTUxt/XdTWeav04muk69t7/+AFuoFYCMhKZg56Vp4jkvGQpcnN18Ay8LgHfnHQ==
X-Received: by 2002:a2e:98c2:0:b0:2c5:2132:24f6 with SMTP id s2-20020a2e98c2000000b002c5213224f6mr1644863ljj.12.1700657396682;
        Wed, 22 Nov 2023 04:49:56 -0800 (PST)
Received: from localhost ([90.167.94.248])
        by smtp.gmail.com with ESMTPSA id bg36-20020a05600c3ca400b0040775501256sm2103506wmb.16.2023.11.22.04.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:49:56 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Albert Esteve <aesteve@redhat.com>, Simon Ser <contact@emersion.fr>
Cc: qemu-devel@nongnu.org, zackr@vmware.com, linux-doc@vger.kernel.org,
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
In-Reply-To: <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <-ngmaSLF2S5emYjTBWcLRNzvJRoe_eZ-Nv9HQhE6ZLuK8nIE2ZbfVh2G2O2Z41GoIFIRpts0ukEtFXUx8pNAptmrZBhlXxaQGykx_qCZ_9k=@emersion.fr>
 <CADSE00KW4+hpbAbZAusBngq5FYSa067wYJCGeetqngWRJaD9Kg@mail.gmail.com>
Date: Wed, 22 Nov 2023 13:49:55 +0100
Message-ID: <87y1eqc5qk.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Albert Esteve <aesteve@redhat.com> writes:

Hello,

[...]

>
>> > Mutter patch:
>> > https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
>>
>> Seems like this link is same as IGT? Copy-pasta fail maybe?
>>
>>
> Ah yes, my bad, this is the correct link:
> https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3337

The mutter chages are already in good shape and the MR has even be
approved by a mutter developer. Any objections to merge the series ?

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

