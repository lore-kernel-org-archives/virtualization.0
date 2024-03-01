Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71796BFC8
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 10:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290470; cv=none; b=F8LwyPTckSa+7iL16VfKm2a+G/FUoaYjIffcogvLLYD7iiZeHhnhN94bkKMrjEqhlW6vxTeSI4SjMUDNpIBjJFfPuJk7xspYZEQUvJmzISW6PQhchb1hKm+10H0H1Jn0NmC4ZTBIfaij2Vmz3vylVWRwdE7pppZ4zdNZKUoqWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290470; c=relaxed/simple;
	bh=9yUqjRiZDnW0sxFymCG3HhyOZ20gbsK/kpqIlF8AEuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHDNktBVrqAP+MgO8yydwICRNCguuJucuyONCYb160/GK0FvzFtp1FrQOmwYdfZSBvx3n0UXkOzNfYBv44wa2KkdVIGQJDWVYgAeCVTKs0gQikm5IUSzpPk0DEY4xsfEpTngwScBgt6+22hgLqSTINm/aMHzvCGWQoYFWLdoFWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbXWPtcx; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbXWPtcx"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70D8F830C0
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 10:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7TMGWkLylfol
	for <virtualization@lists.linux-foundation.org>;
	Fri,  1 Mar 2024 10:54:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=kraxel@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AD2F1830B8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD2F1830B8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SbXWPtcx
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD2F1830B8
	for <virtualization@lists.linux-foundation.org>; Fri,  1 Mar 2024 10:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709290466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tjGEhzuhFUDcE6IMM+mL5TlbxL3v8+X2s2hqXwmwqxI=;
	b=SbXWPtcxN+a6zd9haYCWECMiKI4nbaCLpyUR87U1vosZ/T3o4bOpvInHS+p+x1C31yTNnv
	GYOZ57eD0Ou1RkozsfSOp51P4WDUIbj8UaiVfJMxHthV0aVWUjD3i2XeQeqdjjBVUcvD6T
	JeMpJszpUuGEI0Zjc0JhbAroV2F0kFw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-b4NeP0x0OrKwLhGq2lOl_g-1; Fri, 01 Mar 2024 05:54:21 -0500
X-MC-Unique: b4NeP0x0OrKwLhGq2lOl_g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1CCB106CF91;
	Fri,  1 Mar 2024 10:54:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C7014492BE8;
	Fri,  1 Mar 2024 10:54:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6AB671800DFF; Fri,  1 Mar 2024 11:54:18 +0100 (CET)
Date: Fri, 1 Mar 2024 11:54:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Aleksandr Burakov <a.burakov@rosalinux.ru>
Cc: Dave Airlie <airlied@redhat.com>, 
	virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] drm/qxl: fix NULL dereference in qxl_add_mode
Message-ID: <oprbqmdpjzhjwuqypqfdnirl44drvrhlaiounos44ywdbiustm@myk6llv5chlv>
References: <20240301085511.23298-1-a.burakov@rosalinux.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301085511.23298-1-a.burakov@rosalinux.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Fri, Mar 01, 2024 at 11:55:11AM +0300, Aleksandr Burakov wrote:
> Return value of a function 'drm_cvt_mode' is dereferenced without
> checking for NULL but drm_mode_create() in drm_cvt_mode() may
> return NULL value in case of memory allocation error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
> index a152a7c6db21..447532c29e02 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -236,8 +236,10 @@ static int qxl_add_mode(struct drm_connector *connector,
>  		return 0;
>  
>  	mode = drm_cvt_mode(dev, width, height, 60, false, false, false);
> -	if (preferred)
> +	if (preferred && mode)
>  		mode->type |= DRM_MODE_TYPE_PREFERRED;
> +	else
> +		return 0;
>  	mode->hdisplay = width;

That doesn't fix the NULL pointer dereference in case "preferred" is
false.

I'd suggest "if (!mode) return 0" instead.

