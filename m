Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3097041834B
	for <virtualization@lists.linux.dev>; Mon,  7 Sep 2026 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815403; cv=none; b=tKEbaUXM9LX3bWBDwgPQG61PLIzPrDAJ8UU4GZPwut5LtmImxGUHXB7/0uuSSOA8xZuaBt+WWz8ijSbhMctJkR9OSfwgfE3gm0m04VcYEDagNXrIivJ96ipxCraw6M1rinBHkeDxr4Gljs63ZcmWT42A81LD/2qiO7kByJeGBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815403; c=relaxed/simple;
	bh=fOcgRzp+AkDsXO3kxiBG3fa0WOrkhLtbxHvF3DDw9Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tv35kxmNq7yK4rdGoIewMtNE1xAuVSJaDvS9Mw++gRp0S9ABgty9ygBvZpxyc2r0AJbNm6gVOF5YZh4kB+40taprambBOyv4TBZX3C+4JKdLKg9probtnV8b+zrT6xCJgzbTRO2+CFszy9E7XUBEDr8hoWXGJUa5dVxjUfb3ImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ges3/SVW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ges3/SVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788815399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuVXo6f9Z1spKRdlImVETM3b3qRtGRWXee9cH9hEi4U=;
	b=ges3/SVWE4Ts89l/Qj4GDA62YM5nH/14wTb1iUriY3oDHxwaLxIlzIhKbFBwgT19BrPIrh
	KP9UAnHWGyuGJheHLcnP0/mpmUIqooxKCDkwx36U6G257A8+IJj4TpTHNTq6YbsmkSSn/q
	AazXyYnTJf9uZqZ/ZlvVn2yI1NziEng=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-_p36ToZzOMyOl86nP76L3Q-1; Mon,
 07 Sep 2026 17:09:53 -0400
X-MC-Unique: _p36ToZzOMyOl86nP76L3Q-1
X-Mimecast-MFC-AGG-ID: _p36ToZzOMyOl86nP76L3Q_1788815391
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D3701801200;
	Mon,  7 Sep 2026 21:09:50 +0000 (UTC)
Received: from [100.91.157.188] (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0FA15B1;
	Mon,  7 Sep 2026 21:09:42 +0000 (UTC)
Message-ID: <fea78e29-a3a8-48d2-9353-48a94d3a1649@redhat.com>
Date: Mon, 7 Sep 2026 23:09:39 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] drm/panic: Return from screen_user if display is
 too small
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, geert@linux-m68k.org, rdunlap@infradead.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260902121930.597222-1-tzimmermann@suse.de>
 <20260902121930.597222-8-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260902121930.597222-8-tzimmermann@suse.de>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 4Cc7MkO9_PToeFk--3A1lfaNJ8B8G-8g9a3y_1_1aWc_1788815391
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 14:13, Thomas Zimmermann wrote:
> Return an error if the display is too small to display at least a
> single character. If the panic handler cannot display any message
> it does at least not destroy the current output, which might help
> with identifying the problem.
> 
> This change duplicates the logic from screen_kmsg output.

Thanks, it looks good to me.

maybe add a check also for font->height > sb->height

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/drm_panic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index f597ef04c5bc..c317afc76669 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -486,7 +486,7 @@ static int draw_panic_screen_user(struct drm_scanout_buffer *sb, u32 fg_color, u
>   	struct drm_rect r_screen, r_logo, r_msg;
>   	unsigned int msg_width, msg_height;
>   
> -	if (!font)
> +	if (!font || font->width > sb->width)
>   		return -EINVAL;
>   
>   	fg_color = drm_draw_color_from_xrgb8888(fg_color, sb->format->format);

