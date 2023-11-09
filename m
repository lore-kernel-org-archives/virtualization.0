Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677DEC8
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3lKFeph"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ABD16131E
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 17:25:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1ABD16131E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A3lKFeph
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sUPXXV5dNT55
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 17:25:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FFE561313
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 17:25:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FFE561313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699550715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0steN0/ACKFTtJOvpHMkiOMUe7bddz5OgwOILeHxPA=;
	b=A3lKFepho4J9ud6CksUrN6W8KfjvDWtpH1672v52zjROYN3hirks6cJeXFy4UpDLMxWMTC
	m59ylLX8seMAaUkjETiRouUcsHYpDs+3XlPo8p7ugxUn8odV7fRMUKPU2mYJZJhzATm5s5
	LXp+JSBZ/O+UKr0gCwk7+u+pzrXGPys=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-jCwectlSMlWVFGCimh6ajg-1; Thu, 09 Nov 2023 12:25:13 -0500
X-MC-Unique: jCwectlSMlWVFGCimh6ajg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079c865541so1061901e87.3
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Nov 2023 09:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550712; x=1700155512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0steN0/ACKFTtJOvpHMkiOMUe7bddz5OgwOILeHxPA=;
        b=n2EfZ1DRkIY+LvIfYfh5BjdPxCakyGmKGvYI+BlRj9DcESvRQZBXrfEJbTh/bUaaL/
         whfl+CS0Q9+wDorhxRNK9yWn0I3l2DkYpVQcQER4YQlbKvDZiwe6ES0WqIVnRkr2rhe0
         PLTn8gYDq7L55pNh+D8BsdZMvfS4n2lohfSeeymAozeUgVeboMcO5wO3uFgNNWVXve6M
         EJUtE4cR7RUadc4CRX9BozaPET2pIADra75xpS273ncmogkZHF/jgaxwdBPhTr+N/aE5
         eAQE9nMQfrdfxOpuEyjlvP4EVx6QwTwD3J9enccbKNHzzfr8CK7HvY88Q6I8XWYF9K0x
         p+ew==
X-Gm-Message-State: AOJu0YyV+KKYcr2FgTTFQjbSWsKJGhg/Md4vrCY5KWyyUO/Iz8AxslO8
	81MGaCPNOvoJ+b4fWfIbOczC6Gun71i06wxtL/vbGafE5tDpMCvxZ67IoSGrOdLgsCWEJIEhwsu
	sJMZVRRxrwvAOe7QAF9M0m93AImyfPN8qGZrqgK2qoA==
X-Received: by 2002:a19:e007:0:b0:507:b935:9f5f with SMTP id x7-20020a19e007000000b00507b9359f5fmr1877869lfg.24.1699550712276;
        Thu, 09 Nov 2023 09:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENtuNNft+jXRPbq2qJhlZT81jWdLguxD1V9O4aFnQJMyc+8VWIMEbR49N4zRWK0Yg8oNcUMw==
X-Received: by 2002:a19:e007:0:b0:507:b935:9f5f with SMTP id x7-20020a19e007000000b00507b9359f5fmr1877857lfg.24.1699550712088;
        Thu, 09 Nov 2023 09:25:12 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f15-20020a056000128f00b00323293bd023sm135806wrx.6.2023.11.09.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:11 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Simon Ser <contact@emersion.fr>,
	Sima Vetter <daniel.vetter@ffwll.ch>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Maxime Ripard <mripard@kernel.org>,
	Bilal Elmoussaoui <belmouss@redhat.com>,
	Erico Nunes <nunes.erico@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	stable@vger.kernel.org,
	nerdopolis <bluescreen_avenger@verizon.net>,
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH 3/6] drm/virtio: Use drm_atomic_helper_buffer_damage_merged() for buffer damage
Date: Thu,  9 Nov 2023 18:24:37 +0100
Message-ID: <20231109172449.1599262-4-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109172449.1599262-1-javierm@redhat.com>
References: <20231109172449.1599262-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The driver does per-buffer uploads. It needs to use the damage helper that
handles buffer damages, rather than the helper that handles frame damages.

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/virtio/virtgpu_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a000..1adfd9813cde 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -183,7 +183,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		return;
 	}
 
-	if (!drm_atomic_helper_damage_merged(old_state, plane->state, &rect))
+	if (!drm_atomic_helper_buffer_damage_merged(old_state, plane->state, &rect))
 		return;
 
 	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
-- 
2.41.0

