Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87730BF68
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339034; cv=none; b=WZiAdrri/icNIurfAUm+o0NAFbN/p6z989sul8FlkaGs2nSbZ1fCe7I/qNyItf9vEEQ130QRhxmiL5jYii3c+F3nO/EhvNc9l1j0R23Dxlv5E0vIy/76ZvKhBPMolgatiOf4ZuDXXSOP21HE/PzP5ewzdRSYfsRgaYpgFt/Ukk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339034; c=relaxed/simple;
	bh=SctI5nL9w6nD1CkeTPygc0eg5Cq42shMYT/8E3NzTw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=A+ukczwtCNmrFvkRn81fhS6oxCaveuUd3vZHK4uoXWocxA0IvVJCx+pd7XBW3mJgxyRq5l7Z8T6uJ4QOH11pA76C0sgwqMxQR84n6ngUisfJc3XXBrOW7vCuXB9ZZiGYwVFYR/KkVpIFF3prykkOCDZm96sk/J4tHyzBVEojkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hA3UECLB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hA3UECLB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782339032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLK07udfOGaPeFwrW6OYgWQxt14q957X4zDxurj3Eis=;
	b=hA3UECLBQTeFRFLx33OqhR7Hmz1Dy13oVNcU90ZCf6z9DSQfdy6UkhWKe5pG/ZsDHlCU0P
	lmzNKm0aC019zB7LFbrMLW/INcX4AfLKgPuU8BMT6Vda0dbZn1PTnFTwMQhhKIs4OazL+W
	0PYawAIG08erm2UyD1Upit/FKNq9fas=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-GEVGI5c0N0CH03YsU442rQ-1; Wed, 24 Jun 2026 18:10:28 -0400
X-MC-Unique: GEVGI5c0N0CH03YsU442rQ-1
X-Mimecast-MFC-AGG-ID: GEVGI5c0N0CH03YsU442rQ_1782339028
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46cffa7200bso306624f8f.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 15:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782339027; x=1782943827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLK07udfOGaPeFwrW6OYgWQxt14q957X4zDxurj3Eis=;
        b=HnHfTdhw/WtORizCSmYgCYSfXFTI5Vfe3iUYHmsvCyFe9bhTxUcFEPF1rY/Zi5OKY8
         xa/FO4OoPG2Dx2kq790O6L9C7J14WW87FVwTe7rNGNgCQZ5eDM3i5bUQPI2D3/wcABo1
         0rwQfbgXllOVgfyQCn/r7aRGp6a0aC5F7Ik0quOrQ7Xi/7eZBeTTIAA2sGk+HohZ6sqD
         7/40Qh+Nfju4hEZJ3uc/gcmtNsAJHHN0nhm7BvEo+K1tWXbc9QdW0n471WAPnQm9Pzxq
         xIRyLmZju9vFaf6fRWDP5TmtW+GI+yGuvZ7RITaqGDxmCdd9reZ3q2M5p8oDOrV4S9ql
         bqHw==
X-Forwarded-Encrypted: i=1; AHgh+RpNN7XKKPKzI0m+zD1SsS7g04fpWbZ4mEPuWVJKje5nECABg4PLYaT2fzg9AhlAnhBSPmz9mClkgOKk0w60JA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWs+Na/CTHxO1c0XAuvVUYesRMXJlHPqzhThGtbIn4Msqwk49e
	qND+2Bpunr0dkf02LSxbrSDdTIH/DwG9QP0AhZFOOkGzwh+zeZcoiNEC9GiV9iyPiPAjTrWGf7i
	RaKxq6O1ZilgaubvfVG58cyGl12MI1kQ9ZnHTA1tbMQulWKbNjlUrAIkAsMER09CDGP4q
X-Gm-Gg: AfdE7cmZvtRmTzMpKON7JQI5vn1KdqLtCOjwwaQWigETLi3YOptuY7P8oPy+6I+O6CN
	hmBEiab9lrdVRVarXDHEKJ88Cz3OT2xznFt0761o1l9/wp/kbWe5P2FcH5/hL6kkz8HuhkFqNmw
	qzRN2dOWk21Zj5oAE0EyD6a3OSCX/6oJU1Z3D8EWJ79ECR76YmbEbdk3/kIwWXAS7aX72CLJhl1
	yhJRHufLggEq+Xl+gG+HXQ/yo1X1Ecs/QKVArIDJBL2yDyrbare5MDd3sEOd8BekTmfoFRJoQwY
	ouA/W/FIaHGm5S7TtmNZRAYgGMG2yygUCET36kdU3vHq0GnxjvwjYF1Djg1QLZGX13MLOVMNUKA
	U2dSOltHchH5cFa93iLpraCYjmJ4qovfG
X-Received: by 2002:a05:6000:2887:b0:463:1d06:ab33 with SMTP id ffacd0b85a97d-46a80f5c6edmr17065686f8f.27.1782339027400;
        Wed, 24 Jun 2026 15:10:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2887:b0:463:1d06:ab33 with SMTP id ffacd0b85a97d-46a80f5c6edmr17065639f8f.27.1782339026847;
        Wed, 24 Jun 2026 15:10:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22c680fasm10122841f8f.34.2026.06.24.15.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 15:10:26 -0700 (PDT)
Date: Wed, 24 Jun 2026 18:10:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Message-ID: <20260624181012-mutt-send-email-mst@kernel.org>
References: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: er1_wCO19UWdhB53nlR3QfMijmMHRlIJQOAxzo_LsEE_1782339028
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2026 at 03:02:02PM -0700, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. On 32-bit systems,
> where unsigned long is narrower than u64, that addition can overflow and
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the unsigned long page-count calculation.
> 
> Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and
> vhost_vdpa_pa_unmap()")

still 2 lines?

> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
> Changes in v4:
> - Keep the Fixes tag on one line.
> - Add Michael's Acked-by tag.
> 
> Changes in v3:
> - Add the Fixes tag.
> 
> Changes in v2:
> - Clarify that the overflow is on 32-bit systems.
> - Drop the unrelated memlock check change.
> 
>  drivers/vhost/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa..38b28ed3d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>  	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long page_offset;
>  	u64 start = iova;
>  	long pinned;
>  	int ret = 0;
> @@ -1114,7 +1115,13 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	if (perm & VHOST_ACCESS_WO)
>  		gup_flags |= FOLL_WRITE;
> 
> -	npages = PFN_UP(size + (iova & ~PAGE_MASK));
> +	page_offset = iova & ~PAGE_MASK;
> +	if (size > ULONG_MAX - page_offset) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +
> +	npages = PFN_UP(size + page_offset);
>  	if (!npages) {
>  		ret = -EINVAL;
>  		goto free;
> -- 
> 2.54.0

