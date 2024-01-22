Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08453A1BB
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918925; cv=none; b=fKoZFDZlX4VIwuofgHAZ7yUhRveC90bS1X9XOjGp/AlTZ9YaoENvkt2zZYHH7WTIXpiV/tnOuWVUMaRT4KI0yQMibdIWgQlyOG6Q9ASObj/c5TEhNGfGrw3oy2RceR7amsXkZAM8sik8jy+wqsoAYvD/Z6sja6gDq+XivPZBLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918925; c=relaxed/simple;
	bh=bWDVLHiEXkota/aGMAny+2TNqX/Ql+/MLRYCOPs96YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JihioD2hJkpP9X+JM8CD9ZIIMWKuMq64EMel2+vr04a2/mEJTj2OIYWIYgo+67T/dXosl5oJQpjd6YH59lXgrSRm+FT4I+31ZIQTDPTCSSUKZCXc+ClUn+O4q6K9SEaVGzb2R2gWXLy74czDHKO3iMRC7LYqwhS91U2j8k8fkJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfsdGzbO; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfsdGzbO"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42763415E2
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:22:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42763415E2
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HfsdGzbO
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id esSoXNBrGQzp
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 10:22:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 84B4F415C3
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:22:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84B4F415C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705918921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwPGvN028Z5tPxDaLaEbu18L6ma6HHW3iDZUupdgZD0=;
	b=HfsdGzbOfpPddnglrusnd2eqDuXu0ToarxtrEahOlmYUnEOHRe8fCOexhhXZe7iegKtIRH
	FF7SzGWyMg5PJRI31DsSF6Zpv6YZKCh4JXfjIr3lKtQNYoSADlWne1AXdNmDSXRLqgq+af
	hkIPyG0WpJcn0nZo7bI+MXRH+ZeFttY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-zpP1_il3MQeIOHIHKbBjqw-1; Mon, 22 Jan 2024 05:21:55 -0500
X-MC-Unique: zpP1_il3MQeIOHIHKbBjqw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50eaa1a0e31so2281635e87.2
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 02:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918913; x=1706523713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwPGvN028Z5tPxDaLaEbu18L6ma6HHW3iDZUupdgZD0=;
        b=gkOLy/gQ3TMwg/QSWKDq2tUMJPfb7FBw2AoV/cqcKCq/ko8/dKxu6tppS6kSHZ7tOz
         7gOn+IkUUge0oR7rkq3e/uJeEU+r5pAUbEOkLTKDubBN/+fB3FRQuW655qGmVTPXMjLC
         q3gGOTeB8C6HIfsadFYZrHDSYCQMfvxsLNp1lw0NW4zr1O6ugLYJja0e4ZJHk7thMYQC
         rmzu3uWVE3caJBiMa5izV8nqFGdqptGcPBLPeUMCnztlcvd7gT2Pto40Hv5wtMevr5lZ
         lpLpmIa0mn6SwuEyz8WmA5R6JL3v3OOQ/L8qj9lzOiWX/Vl17BMIsUYIlkgYbdc/PxCy
         3VQQ==
X-Gm-Message-State: AOJu0YzQ4jxzzB5e0iWdx9ijnTiFazKzhv8klWWWbqs0eqdIzEJL3bER
	35xcQeYeGs/8VtRA7NJDrV3plGw50XFeTaYIUCGwOor+LUjtcYQ22WZEb2e1T6SaMMv/vWGRsYK
	vA2LO6PnNStPP4lDnFd6Mg9/zCK8OlpEyKGTlEQkVJAYWW7/pVjsWCsSZZ5m62Bgt2SngHl9OdZ
	ISk+s=
X-Received: by 2002:ac2:5ff0:0:b0:50e:efc4:a318 with SMTP id s16-20020ac25ff0000000b0050eefc4a318mr1261141lfg.64.1705918913697;
        Mon, 22 Jan 2024 02:21:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi1995SJjifeXa2VfBTVYgXMiN3lDe07cDVtgpWOi5nt1c/FA3p+x4EsTfhyhrn/vLVrIFhw==
X-Received: by 2002:ac2:5ff0:0:b0:50e:efc4:a318 with SMTP id s16-20020ac25ff0000000b0050eefc4a318mr1261135lfg.64.1705918913380;
        Mon, 22 Jan 2024 02:21:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-71.business.telecomitalia.it. [87.12.25.71])
        by smtp.gmail.com with ESMTPSA id q9-20020aa7d449000000b0055a898c3156sm2930603edr.11.2024.01.22.02.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:21:52 -0800 (PST)
Date: Mon, 22 Jan 2024 11:21:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH V1] vdpa_sim: reset must not run
Message-ID: <mhnsrwlvqjeftu5aa77iaowdk2wrq366yofjchbn5fwchgcbna@kcjtoj46fawi>
References: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 17, 2024 at 11:23:23AM -0800, Steve Sistare wrote:
>vdpasim_do_reset sets running to true, which is wrong, as it allows
>vdpasim_kick_vq to post work requests before the device has been
>configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_OK
>is set.
>
>Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index be2925d0d283..6304cb0b4770 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
> 		}
> 	}
>
>-	vdpasim->running = true;
>+	vdpasim->running = false;
> 	spin_unlock(&vdpasim->iommu_lock);
>
> 	vdpasim->features = 0;
>@@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>
> 	mutex_lock(&vdpasim->mutex);
> 	vdpasim->status = status;
>+	vdpasim->running = (status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;
> 	mutex_unlock(&vdpasim->mutex);

Should we do something similar also in vdpasim_resume() ?

I mean something like this:

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index be2925d0d283..55e4633d5442 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -520,7 +520,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
         int i;

         mutex_lock(&vdpasim->mutex);
-       vdpasim->running = true;
+       vdpasim->running = (vdpasim->status & VIRTIO_CONFIG_S_FEATURES_OK) != 0;

         if (vdpasim->pending_kick) {
                 /* Process pending descriptors */

Thanks,
Stefano

