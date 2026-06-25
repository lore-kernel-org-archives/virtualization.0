Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBBA26ED25
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407325; cv=none; b=lKNF76zy7wO451RiRZyZoju1WF+ZbAH6N9ALnqrqTAP7DaBiJIfRfH4JgcdQNv2vrUR1M0hXAzfmrkcZZsS/YzYdjTfMa2H2HVkcsWE6OOdWJvh/w+PbeLTawV6YcN6EMvzNIGaaBJkFvVL3WrkGyvfaNeHOiCe7wWblCOYAMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407325; c=relaxed/simple;
	bh=nmtoyZopcrvDa9Je5mQkIAnzsF4/HXum8f9yf35NCkQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ipo0zeyQxLRsE73L7UwFvJRosNuT1HfBBgv0cBQSWDoXH77Y1MZZQOaqbGF5ue8dxMwZ8hcBqIzG8wy9+M8NlQd9xJTqRwh5B8tbgrEwxtF4S/UksK2f11gObJQ2xT1rsiW2fEOoPHCyhKCz1b29XxlE83N5D1V1lBf8MVji7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--natsu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OzytUWzA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--natsu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OzytUWzA"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37df6354960so42949a91.2
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 10:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782407322; x=1783012122; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lga7Yq072G4mYoR4ZYRzQRKAQbvBlbeEWBDVrXci4B0=;
        b=OzytUWzAzkjSQC+gHHdMPxE63uZcrnAsLsD0AKur6FoXjAvaiq3+zfLByn4AjneA7k
         UiHbI5ckdivQiFjhH2VBwquJpRX+dQGnNlaYxhNcW/nGWPxB6NqE/o7hNB0RKj1sg1W4
         zjDgU+2YM55grHg3c4oMNaxSV6zZI+jEK4NfSLGC1n0YjOmFXdYdvpQ2ekkrUXPaI69V
         dxMveuWURyiwJs4Va8Nfy3jYdkPsY6uAh4OFIeAv+j6nxHx/CWKEIGTP+86uLN8oQQFa
         ky+6OPp66BODVmUN3EnynWosL8Kcv+s6rzXqvpAw41vlrBPgiff8rKgzlZ9AQxxgRQaI
         ccGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782407322; x=1783012122;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lga7Yq072G4mYoR4ZYRzQRKAQbvBlbeEWBDVrXci4B0=;
        b=BodFcOzEU4td8n7wAqbOq7BLedKMUrGfo6NfXEJM7fE+oh/5VItdpxQNabNMNBgRWg
         I94yZzZQ7BHnSKvPfSa32lLiaFWViaWeNweKHJnz5sMKty14zN6QEuWAPzQAaY2uxZ4k
         adZqHnbuteWedIhDf2YP6+1gG9Nn6ifMtHJUAZdeSpuGzf9/d4UUkFMNzzUQpv6S+5gw
         h1ypUsdRCvOQ8IDdXGZHDWl/RuEhbVwtYsfNG3LbNE5aOtiNbmMdiU77HlFr4yrV+nv5
         iyuZuDeTP5ygUSkufye8B77tqYWa2yc7AGRKnUV3XPbZYe/xjEy7+jOMAqQADPca2HCx
         W5Og==
X-Forwarded-Encrypted: i=1; AHgh+Rowja74oU9OOhCcRHoq1NQF+M2nQAemnXEH3HjF4QyMeD+sOEwnT8LOFpCjJgnIUICNgw2NIwBndtAGfRhR9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf63MbUiWuel63ro6Sw/KO7VP/yn8eGdNj/0e8atiMq4uwzXVH
	AtpOmw61xCLqVHpiC55vQg/xSJhZB3wI6VEnyIq4cFMnMfj8MmhF4kdmQptqpQJfJYKZCMPmdM4
	L4Q==
X-Received: from pgbn20.prod.google.com ([2002:a63:5914:0:b0:c8b:1d37:c0f6])
 (user=natsu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:180b:b0:36d:ee3b:fcae
 with SMTP id 98e67ed59e1d1-37dfa1b664cmr3246028a91.6.1782407322191; Thu, 25
 Jun 2026 10:08:42 -0700 (PDT)
Date: Thu, 25 Jun 2026 10:08:28 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625170828.3335431-1-natsu@google.com>
Subject: [PATCH] drm/virtio: Don't detach GEM from a non-created context
From: Jason Macnak <natsu@google.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Macnak <natsu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
Don't attach GEM to a non-created context in gem_object_open()")
to virtio_gpu_gem_object_close() to avoid trying to detach
a resource that was never attached due to a context
never being created when context_init is supported.

Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default param if context_init is supported")
Cc: <stable@vger.kernel.org> # v6.14+
Signed-off-by: Jason Macnak <natsu@google.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 435d37d36034..66c3f6f74e9c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 	if (!vgdev->has_virgl_3d)
 		return;
 
-	objs = virtio_gpu_array_alloc(1);
-	if (!objs)
-		return;
-	virtio_gpu_array_add_obj(objs, obj);
+	if (vfpriv->context_created) {
+		objs = virtio_gpu_array_alloc(1);
+		if (!objs)
+			return;
+		virtio_gpu_array_add_obj(objs, obj);
 
-	virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
-					       objs);
+		virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
+						       objs);
+	}
 	virtio_gpu_notify(vgdev);
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

