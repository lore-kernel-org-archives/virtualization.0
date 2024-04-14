Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F74223741
	for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083712; cv=none; b=PyiSmltF4yjW76kH9VQxGqYCW/NtHtu5ry7aN4p4qgtRoahLxCtiUpKoDw3h9DtlQ7QRjxR4afTwOj8NZeEJooEgyKiWdKFRBRZ9830LNFJCFqABpn+O3JTU2pL6Xj6SAMdjcFHbnqPUGxR1erMjLA4NNV/I0/DG0n1nYtUeWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083712; c=relaxed/simple;
	bh=ZPYqqtyateQAglR+k6OVKvCAe8YRzI/MA8ssd/t5pbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RFcR12sG13AFtaqS+xageCkt4RL38fXFoXp7Wnfuisz2MG8E2ocCeDA3IgR0umTpvlXDqqzOPuVl2jihg0uxIITbYn1UwYDIoAK6HqWzxldNMjjDDr4O+jBwf+qBh5xPtwJI4dkVD3E3uX8LatFCKne9UBAd9M+1R3LBdNePVkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrcFMysy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrcFMysy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713083710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmgfpCrRtCqNbVMsFXJuOmvk/MLLt9gA4dRZP1RBeX4=;
	b=VrcFMysypTOei2Nx+OKdh1UuUdODAWgXQBp5ZKaipGgmQM2dUf2K4+ZhZXPzAthXn0yCsi
	bepF8E951QSn8rrpZkag7YOJMZ0iejCnfUPirF54yOF2Cn5c4gqBrt/QrgS+Za+9YVNF2X
	E2YUfUYxX8tHNOFl9e1w1FjD4/ZII+c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-RWx39nmlNNijFu_p2THKBg-1; Sun, 14 Apr 2024 04:35:08 -0400
X-MC-Unique: RWx39nmlNNijFu_p2THKBg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343d6732721so1350520f8f.2
        for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 01:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713083707; x=1713688507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmgfpCrRtCqNbVMsFXJuOmvk/MLLt9gA4dRZP1RBeX4=;
        b=q47LswCj74M0uGTW5FPlgp0Eh8NBsjH8sW5uPAozdRymy9OFO+vPe5KNlyEiKO3XYx
         5kjdszlB+U3hrt11TXkNEeY3i7gE64xPts4ywcRyVKbvkFPrnLqVd9aG0qRVgc+IvN26
         7rMpvQ9VQcrw/TUFchGNvQ00AXtMuX4ssbNF5ABCCRa5ES1qztTc84aMjr88QgBqJt6A
         uZBxsMlVblH5AVdS/BNCk57fROA9ejGkmyTMBXZcGts110/kRXN1haQ1HcI/CMfzooWV
         VHOkKSLHN5RWHsGlaQzoQiPyFBo+Kv4D5xhbNSdwKY6h5CblNhM+pJVLtDJE+P+fjuRd
         dDgg==
X-Forwarded-Encrypted: i=1; AJvYcCXzYXPOvvifCsMli758vbukZcVQomrIB5Khj0aaM1jE3JMkZlcidCoZyfJ4aQ55mstj4ggmbALuC5g9fhaH8G5FVZEVEAtdFcn1b0o0JUU=
X-Gm-Message-State: AOJu0YyJYz6NyqbsPCRqYOWMJp1INdZ+J742VNUJ0IMyuSMxCxgFRr3U
	x30A8Yy5W0ivDMT+FxEB/Y2jcjAE17Y5EncA7u6CoCoklWAH/OkAKwnr76HALUf2YlMsFi57WF1
	7d9Q4YjoqYKQsCLUm0al1FGxKJdRgyWpL7/1nhl6j8HxOQm9X9OXBrc4ClN07nEpc
X-Received: by 2002:a05:6000:232:b0:345:663f:f0a1 with SMTP id l18-20020a056000023200b00345663ff0a1mr5215821wrz.55.1713083706780;
        Sun, 14 Apr 2024 01:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEud3PzT7Nr9AygoJHk6xDRgJwZJGsPs20hazfYSLls12vM50Lh6SjxqeEIXzgG7uN3p2DHqQ==
X-Received: by 2002:a05:6000:232:b0:345:663f:f0a1 with SMTP id l18-20020a056000023200b00345663ff0a1mr5215809wrz.55.1713083706195;
        Sun, 14 Apr 2024 01:35:06 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe3c9000000b00344a8f9cf18sm8576894wrm.7.2024.04.14.01.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:35:05 -0700 (PDT)
Date: Sun, 14 Apr 2024 04:35:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20240414043334-mutt-send-email-mst@kernel.org>
References: <bd27d4066f7749997a75cf4111fbf51e11d5898d.1705350942.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <bd27d4066f7749997a75cf4111fbf51e11d5898d.1705350942.git.christophe.jaillet@wanadoo.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 15, 2024 at 09:35:50PM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, buInputt the one of

What's buInputt? But?

> ida_alloc_max() is inclusive. So a -1 has been added when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Jason, wanna ack?

> ---
>  drivers/vhost/vdpa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..849b9d2dd51f 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1534,7 +1534,7 @@ static void vhost_vdpa_release_dev(struct device *device)
>  	struct vhost_vdpa *v =
>  	       container_of(device, struct vhost_vdpa, dev);
>  
> -	ida_simple_remove(&vhost_vdpa_ida, v->minor);
> +	ida_free(&vhost_vdpa_ida, v->minor);
>  	kfree(v->vqs);
>  	kfree(v);
>  }
> @@ -1557,8 +1557,8 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
>  	if (!v)
>  		return -ENOMEM;
>  
> -	minor = ida_simple_get(&vhost_vdpa_ida, 0,
> -			       VHOST_VDPA_DEV_MAX, GFP_KERNEL);
> +	minor = ida_alloc_max(&vhost_vdpa_ida, VHOST_VDPA_DEV_MAX - 1,
> +			      GFP_KERNEL);
>  	if (minor < 0) {
>  		kfree(v);
>  		return minor;
> -- 
> 2.43.0

