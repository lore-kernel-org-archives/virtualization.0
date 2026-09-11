Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AEB381E85
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161628; cv=none; b=i2+RiqOKpWYkW2/Jay7GDDHqgsxq6IhSPofCTzROVRP7mwXGJOs5e/fdtnwHfLX0iR/6mV7Er5z50Trc3uib5y8ZBOXwBEe1udXWm7E1O8u/vvAmpEU5wwK2LsZUxdPl15otuFz6WuXc+FkNVwrTOqzqnj3b9wURGic4DM4LTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161628; c=relaxed/simple;
	bh=X/a1c9AObFT16Ev2KwOXO/4lc4TSMFYD1lfCIyt6wWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DHt/G3HL2SxoIfDexI7bX9l+0otjTuj7pWianrU9WKiQWEsmfMY18EuU0bI6c0oT0lXHQyeiBGgxMSXnleazIog2xH8sM67vKj4yqiT3yJm0axGcbXwpgrYf37VfSJNeW2XCh1aZSEyvfAqrWCGf9GPgP3dm51+wUn3RQyXxmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6Xk/qtR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6Xk/qtR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789161625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rraEjiiy4l51ce5bMczYGMJpLu6aXZqS301wSkD3/b0=;
	b=c6Xk/qtR0xhCxqq7c1aQnLpEJJsObY1SWStlbZgUs8SYKOTYNB1b60lM03+rdlCcokkOL1
	9G36uBpoAZUnuAenJq/aSa51SJ4iVTwTig4jqnJYjeil1qb6DJipJBPL6UUNSZSHUSyW3I
	J065Vk7/0ImdiedCOA7FtHi8Kv/Ds5M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-1NASnEkxPRmfJ_t4uaAEAg-1; Fri, 11 Sep 2026 17:20:24 -0400
X-MC-Unique: 1NASnEkxPRmfJ_t4uaAEAg-1
X-Mimecast-MFC-AGG-ID: 1NASnEkxPRmfJ_t4uaAEAg_1789161623
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495689bfcc8so9493105e9.1
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 14:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161623; x=1789766423;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rraEjiiy4l51ce5bMczYGMJpLu6aXZqS301wSkD3/b0=;
        b=Fu37PP0lPuDl6XOtd95BdwegLqohWiKJpC2BYFdNTh11uFa6e8lF8WDkbHFlDAu/Xu
         RZwsxWFx+IXIOBFPyR/8mOLEVLr2qI+67VAp/D6WnWTCrMoCIIrhh0QaKIjn/V5tMWH0
         q/alq2nIkjZ7CkNJDffovHQPVI/vUhFcD+S3DD+33wRduTZ9ETbofeZ09zNheZw7WumB
         u5zzT8lsAjUNTt+Pj42p8orOa+Cy9VIH09e0r06BFDe2XRmUgDytEOD5JbVhs7jlxaAE
         oOXjhiw74cujX1J26gv5XYPZNk8EmaLE+OO63G3N9bgELYgkYZPoiK2uJoE97rsLzTJU
         41lQ==
X-Gm-Message-State: AFuF++nCXI8IeAUFIF7TCcQuVdpO2OvS94f3q47D1EjPVRiLFP+HarMz
	OS3lHQRB7OLdZApnDGJwqHRxkDo5y/ZH/XAqys3oyqUD0FQH2Hl/5fjto2U+y4O83uPTsMwGbZw
	HFlNk0WikgtkTRZMyUVILKsk+5slDffhllUDRVXPxMonAXiSCqcQwimWg+12B9gpPQkc/wdO4DE
	MJRD3AexTSHEhKvd7sOyWgI/nJZgLb5rRwE7psDcz8nzc82g==
X-Gm-Gg: AYBFou0oE/jcBjLHyffu2jV1GSn8qCeo9IhRwDOdskS6W2K1Q2Cec0K4UOSUB1n/if0
	vP61zBzgaBx5widioIEtoLux6CxPWPfdlEtc1OM4/XRWdNI1FhICysKwBCw73osj4UbEnmzipzz
	2M8u6f/XdIb3VnmgHdSnwD3nWUq2fhf3Dj+H5OHjrbMpQ1XHLFJwhIGglFiauDydg5caVpyn9Q0
	55oOae3716vsjvMhMswQMldaWfsDwxXIp4n/dUpfvDOAuXjun/sGubdjsRkz6GQv0rtvQFB2y3N
	JcPBMfKbPxVqgPqT4HEvqmdLJgrNdQieYd/rPUu3H1Q4N2v16YoeWrWNXpwLQmi3qF0=
X-Received: by 2002:a05:600c:3ba9:b0:49c:fa21:e73e with SMTP id 5b1f17b1804b1-49e619c0558mr82101685e9.20.1789161623227;
        Fri, 11 Sep 2026 14:20:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba9:b0:49c:fa21:e73e with SMTP id 5b1f17b1804b1-49e619c0558mr82101405e9.20.1789161622739;
        Fri, 11 Sep 2026 14:20:22 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e636f7fa2sm86381105e9.15.2026.09.11.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:20:22 -0700 (PDT)
Date: Fri, 11 Sep 2026 17:20:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtualization@lists.linux.dev
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	jiri@resnulli.us, kmehltretter@gmail.com, sashiko-bot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] virtio_pci_legacy: drop callback sync on reset
Message-ID: <572661b65eebb784652e5843944d284bbceb2954.1789160982.git.mst@redhat.com>
References: <cover.1789160982.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1789160982.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mDDlHLRQ3I6ZzdV2FQ7pAhyvWyuMNVf6rQqrmbuUGPk_1789161623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The virtio core now synchronizes callbacks after reset,
so the legacy PCI transport no longer needs to do it itself.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes v2->v3: split from v2 patch 2 (legacy part only)

 drivers/virtio/virtio_pci_legacy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..8115aa39e01e 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
 	vp_legacy_get_status(&vp_dev->ldev);
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
-- 
MST

