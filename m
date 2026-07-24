Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3E376A0C
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886515; cv=none; b=XasC61jbkTVRhP5vEa3emZ/DO+ag4EhIg1DFKKX8LOKSN1nqcSIexn/BHlzAc0cQ37OXvj8NiEBcZGQpRbTMO8fLBHLKniVWtWN+/RVZz0Tu/wS5AOsY4n9fKBeemU3gXq9gLddv9setjsGkHZ+UsrF19q2/FaZc1/tofTXPvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886515; c=relaxed/simple;
	bh=5ICWunDTkGMGVkKNALCNEIjakGUt0nFKsNj4GaNHAO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZNwFAoZFWhBcaQCVgl4EM/vuW8qEJt06CzlJAYbR3PSiSoY1cDdQN7e5Ow2ATXf5mWX25IEot0eyTFL8/Juu9dTbf3Nz7i0NtzcKtSDdjwLi+dc6ZHyzjj4NCHyd0IBTEIeUlDfK2ZTfvqaRF2L4IMlhpQ7Oskb776x2APSk/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2Hd742Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2Hd742Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784886512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lye0uSP0lGb3OjfxvYX+ADbIclougKZytkoLCvARVzo=;
	b=T2Hd742QL0KScf0Sj39MmVDBrWHdWuItrUxwzpffQ4fJwig90H5hwPL0O4O/xx9CZi1E2q
	LLs/nlBF4ZYEg9ygwwr7+cMg8u5YFSq/g28IwgNKTTHi+L7+Kg14oKIKrT9y7Y65br54ie
	AKKSCNvDwzHRSzmG55xDcdWPouCERDk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-fkmjM_idNWuTU2vNgNTWXA-1; Fri, 24 Jul 2026 05:48:31 -0400
X-MC-Unique: fkmjM_idNWuTU2vNgNTWXA-1
X-Mimecast-MFC-AGG-ID: fkmjM_idNWuTU2vNgNTWXA_1784886510
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f7039fa59so257389f8f.1
        for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 02:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886510; x=1785491310;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lye0uSP0lGb3OjfxvYX+ADbIclougKZytkoLCvARVzo=;
        b=gHytabtzxQzY2EjILfGayVnmdxumKOw5yhFzekN8flQrqexNN0hZeS4KJXKHPryz7H
         7QgI/sqscyz/02B8i0E5e3nlOgm/3FZTo3YLM+nrXIitDoxuJe2TTeUABHtO7YhPqWJ0
         0xRukkX1cpaN3RkjcF93sMJ9r6O/gKoiwJiMtX5/agriwa7/+j0pKGrCW0xE+wQz4jG8
         4KUQhatYu48O1lAN0iYfCwa9T/f1MlhYWGjxtiXqPqx+uehXIxxaokQdv7FMErFloS+N
         Z1p0vWGkPbnQ0BCcMa5f0vxAK+yyA8U79VItvSBM0SSyaEdUvyNo7v2iMz37WE/WlTpo
         rNag==
X-Forwarded-Encrypted: i=1; AHgh+RqAU7Oidyp6GtrbS5WZfdQIg30SF5LAAsMjmzFDKI4rEclEfTX3E/An10P8WzxH9aX/NP50eiHKz4KjprVaGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyI3iUSmPykrQcMGOWma6QZ4IBzi4c+fjp6u8w/yMxFjr/QSoSV
	pW6MeOFjmJiTsw4W0OEKeole9KXynUNqdLjLt5JXUWUaDK4XIkm/zyCz9SgJ+rC1T61gcanh25W
	rWwtch7WZjloDyUNjwQWDPfyW/ecoiuEevh/I3Qi4q3AaY+eb2QXmJ1jPDCI+lYTrJf5J
X-Gm-Gg: AR+sD104VcOLs79YtBHxOYSeIHmutQQoxm8UHr6oRxpbKdw3V10NstaEPp1uF5ZAUA/
	eBOeE2Ree2t5pcYsNvJJ3I0lIxwJoDcjFW6KVxyfCa/PdJzLG7IcwAizLaxUELPIgwg0yUw5MjA
	SNSwhsH7iaEVKKahoCVxWCORqOZorqcfBOjGEHuNthKtH2Ri75Ddac2jND3f9KGJkHy5OSwtr00
	1SJoq634fbBfwwvzXWAf/sydm3kuemQZF0JNS2XNyG2jkrNhz8zRH3AraOd8ffLctNBJafZkPH9
	j3bn0IIgPTqL8PEHVuW8fE6OsgU0dKkV1+EyX53VUSmW3EiAKy26nQ4TpCNA81kNslV9Gkf/aso
	fB/LU2R/Ke6eN/7+WeaN5Ww==
X-Received: by 2002:a05:6000:2212:b0:47f:9ac6:c9bc with SMTP id ffacd0b85a97d-47f9ac6cb55mr1147490f8f.2.1784886509769;
        Fri, 24 Jul 2026 02:48:29 -0700 (PDT)
X-Received: by 2002:a05:6000:2212:b0:47f:9ac6:c9bc with SMTP id ffacd0b85a97d-47f9ac6cb55mr1147441f8f.2.1784886509191;
        Fri, 24 Jul 2026 02:48:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fa9sm24509592f8f.20.2026.07.24.02.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:48:28 -0700 (PDT)
Date: Fri, 24 Jul 2026 05:48:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com,
	virtualization@lists.linux.dev,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH 2/3] hw/virtio: Implement vhost_log_start and
 vhost_log_stop
Message-ID: <20260724054712-mutt-send-email-mst@kernel.org>
References: <20260724093759.810108-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260724093759.810108-1-xiongwm2026@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sqNyEDL5fAPD5FCgAeSnqkjt7nsYBkfbOt1HAYSp5wQ_1784886510
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2026 at 05:37:58PM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> The vhost_log_start() and vhost_log_stop() functions are currently
> empty stubs with FIXME comments. Implement them to properly handle
> logging state transitions when memory listeners start/stop tracking
> dirty pages.
> 
> This is needed for proper dirty page logging during live migration.

Is the implications that in your opinion dirty page logging during live
migration does not work currently?

> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  hw/virtio/vhost.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1234567890ab..fedcba098765 4321006
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1297,16 +1297,32 @@ static void vhost_log_stop(MemoryListener *listener,
>      }
>  }
>  
> +static void vhost_migration_state_changed(void *opaque, int state, void *data)
> +{
> +    struct vhost_dev *dev = opaque;
> +    Error **errp = data;
> +
> +    if (state == MIGRATION_STATUS_ACTIVE) {
> +        /* Migration started - enable logging */
> +        if (dev->log_enabled && dev->vhost_ops->vhost_set_log_dev) {
> +            dev->vhost_ops->vhost_set_log_dev(dev, true);
> +        }
> +    } else if (state == MIGRATION_STATUS_COMPLETED ||
> +               state == MIGRATION_STATUS_FAILED) {
> +        /* Migration finished - disable logging */
> +        if (dev->log_enabled && dev->vhost_ops->vhost_set_log_dev) {
> +            dev->vhost_ops->vhost_set_log_dev(dev, false);
> +        }
> +    }
> +}
> +
>  static void vhost_log_start(MemoryListener *listener,
>                              MemoryRegionSection *section,
>                              int old, int new)
>  {
> -    /* FIXME: implement */
> +    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> +                                         memory_listener);
> +    /* Enable dirty page tracking for this section */
> +    dev->log_enabled = true;
>  }
>  
>  static void vhost_log_stop(MemoryListener *listener,
>                             MemoryRegionSection *section,
>                             int old, int new)
>  {
> -    /* FIXME: implement */
> +    struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> +                                         memory_listener);
> +    /* Disable dirty page tracking for this section */
> +    dev->log_enabled = false;
>  }
>  
>  /* The vhost driver natively knows how to handle the vrings of non

