Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443C1465BE
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433817; cv=none; b=c5cZ1rnk7QGT2hOfAvlVoHk/kpV+/vVf/wVHHI6hqRXOEZjAEOTu629n3xPZy/1Gt9/uLw2UOx+KCLglp43nga9wJXYC2P2H2lZJcZe6VwOG6eukaYCtGjuI1fWe0LVwizTWUUW0sROdI60AucdqeE5HLtpphqSVv7ZSyOEc06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433817; c=relaxed/simple;
	bh=OH2ShnHEXp6QIBWqQU9TKbwoctuyTjnv30roqIIS++A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q2Yu9dPUacYMnjxR3i3B3iWgDVpNVHcdqFEcakS/ns1MWEKV8eVI6oIsHnV0Vg1QwDDQJEH3FRlgyaCt9zHoQaJWp02w2C+yUWCU8DX9c5/0z7vnBwA/VwXyIsKFYLdFUy905il/9p06YN3IUgvpwrEBYXkKBxxJFRRb523mN10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqMTMCjF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqMTMCjF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725433813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AqXFL8n+dIt4khrh0GH2lSLGcp3WuiAgJkmy4j+JgOg=;
	b=OqMTMCjFB3UG8B/6qEc2s3e4Fd+Q8IedlBlAKklHaRUFL2hpHwZ0xQBSZMVGJh7gpKTA9P
	NI91VTMRWfV+7aUCy5HvbSN9XH3EPWT7r/SZsNW60xbm6L/qtPI8DZWsQ0FopU6ZhhMVav
	zHXyzWiFrOinB4vAkNBzLT2YC42cbhg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-9QkQgp4WMpOZavV647xCRw-1; Wed,
 04 Sep 2024 03:10:08 -0400
X-MC-Unique: 9QkQgp4WMpOZavV647xCRw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10D631955D44;
	Wed,  4 Sep 2024 07:10:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AF171956048;
	Wed,  4 Sep 2024 07:10:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 0F4FA1800639; Wed,  4 Sep 2024 09:10:04 +0200 (CEST)
Date: Wed, 4 Sep 2024 09:10:04 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2 1/2] drm/virtio: Defer the host dumb buffer creation
Message-ID: <pbp4kpu2wh25fu54huu62cuydlw5qhhp2r3akx6e6ipff32rrr@yra7qtiub5jr>
References: <20240903075414.297622-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240903075414.297622-1-jfalempe@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

> -	} else {
> -		virtio_gpu_cmd_create_resource(vgdev, bo, params,
> -					       objs, fence);
> -		virtio_gpu_object_attach(vgdev, bo, ents, nents);
> +	} else if (params->dumb) {
> +		/* Create the host resource in virtio_gpu_user_framebuffer_create()
> +		 * because the pixel format is not specified yet
> +		 */
> +		bo->ents = ents;
> +		bo->nents = nents;
> +		bo->deferred = true;
>  	}

else {
	return -EINVAL;
}

I think this should not happen, because non-dumb buffers are only
created with virgl being active.  Nevertheless we should catch this
case and return an error, maybe even have a WARN_ONCE() there.

Otherwise looks good to me, so with that fixed:

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

