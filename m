Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194DA45976
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817922; cv=none; b=IBrrfPbjkBAidmF8LWd4gZnUcyMhYHUs7uJmXey+t3DuxrMxAa8MLZjD3ZE0As963Z1sZm4ERGoFtc/i/kZ6JC6YVS5r4j7AbsLck5YU+dC3CwSuoqcNZVFXdRT9/jQPUucG8G4V1MUqjbTxWidgOKJqz6kQYm1LOWOqgJP0lRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817922; c=relaxed/simple;
	bh=NbHJh6RRHy684SrYZUNu5LAFgHVtJvGwtoD+uECKw/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZEnnXzq0MXkBC11T/VTxSWiLFN7g6TNCfcEkQ9Zm2WAeiEKF7rkOHqR+p/W6m1S8dnSKClzsyakJwAERPYt/sWVQQlzDKV2sagSrDvTJpyq+IGp+090mdvGAOvw0BkLPBmX836y/1IH7L8aVVsW3koeeRwWAjWtm/OQ+sMR3TUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/+zNoir; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/+zNoir"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721817919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xn9TfjA6NiXJtkfI9W0qDv8xc0kKr5AGDpzztiNdZF8=;
	b=f/+zNoir7q3ec9uNbgGLVK5+ga8apF+0F8lY6k9A6SExxZ6h9fr0osa0LA3QntherMSYhb
	9sxf+0V2teuV0bjo5r8JfpR6WgJQ614WMgTCSrtptZm0C5oEsfXaJinFtb45u1FJRi/Ihz
	GUlmFRGUUWq37cAlQLpcBMEvQ+x+Drg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-Jqt06VpWPiCI8HoydEChxg-1; Wed, 24 Jul 2024 06:45:18 -0400
X-MC-Unique: Jqt06VpWPiCI8HoydEChxg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-368665a3fdfso3577289f8f.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 03:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721817917; x=1722422717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn9TfjA6NiXJtkfI9W0qDv8xc0kKr5AGDpzztiNdZF8=;
        b=VaWH/iu0d3Hwl0Q74RYGB1sHvimVSzRLrIHqsbRWIGjgYfoj6/U3VzvBJ5yd13Egsd
         TSiD2TA6wBnyBpTN3NprvcHWVXo84mfsCHjgw0wmRah1EsqENyIo861Ik31sY9NPmlmp
         gJDSIi15J1GM/Og/YtDWKmzBHd93Tbhx2gZKnSCeQmnWidZwV7pvGhW8sYSe+zULSE1L
         v/JPgIyoJGLaRkQy8Y0gDt0vO1lN7b0dM8lSZV/FyayeFedWSGu8km6Rb4ocxa/gcVBs
         h8IO2fK8Mi4tfphlh9DaxIJ5ZnIPZoOMPnsARgEgcs/Fa3XKNEIhc88zwWRJKTnA9/dD
         D/uw==
X-Forwarded-Encrypted: i=1; AJvYcCVqLcAF3wyow6GIiuWX94RGzLsJWqDfMwl7Ed45lSj8bXs13kABdSq1cHEVHOOpHXviZTOFANxk8UMUTaqMJ9kiIoVcm3XrOJGPi99FvE0=
X-Gm-Message-State: AOJu0Yz9QAq862dWee1/+mYHPMV8IJRrgJYtieKKwb3aC3VGYcJcHeAT
	EJLvaFmGwbyL5Bjt7vaIc8Rdhd7eu3JZ9Vio47lW/MDmiTzecquS77etWtZyobCu+jGe+YS1KJC
	sdSD08m4V+bda8y0zHJuGdK0ELQ4AtyqMmPXdBIK+em1voj5jboiJFmRKffhw4T4O
X-Received: by 2002:adf:eb82:0:b0:367:8a3e:c127 with SMTP id ffacd0b85a97d-369f5bb57ddmr1076829f8f.63.1721817917282;
        Wed, 24 Jul 2024 03:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeiMpsWcqeCFCR3YjRVhYw58gnKNcIGwvJmtVpjFuFH/aFmGbZKpc7S+Um/rqoZCaNJ3M9OQ==
X-Received: by 2002:adf:eb82:0:b0:367:8a3e:c127 with SMTP id ffacd0b85a97d-369f5bb57ddmr1076804f8f.63.1721817916632;
        Wed, 24 Jul 2024 03:45:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:6083:a67a:e8a9:2855:2683])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ed580sm13850744f8f.112.2024.07.24.03.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 03:45:16 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:45:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/virtio:Fix the wrong format specifier
Message-ID: <20240724064459-mutt-send-email-mst@kernel.org>
References: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240724074108.9530-1-zhujun2@cmss.chinamobile.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2024 at 12:41:08AM -0700, Zhu Jun wrote:
> The unsigned int should use "%u" instead of "%d".
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

which matters why?

> ---
>  tools/virtio/ringtest/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
> index 5a18b2301a63..e471d8e7cfaa 100644
> --- a/tools/virtio/ringtest/main.c
> +++ b/tools/virtio/ringtest/main.c
> @@ -276,7 +276,7 @@ static void help(void)
>  	fprintf(stderr, "Usage: <test> [--help]"
>  		" [--host-affinity H]"
>  		" [--guest-affinity G]"
> -		" [--ring-size R (default: %d)]"
> +		" [--ring-size R (default: %u)]"
>  		" [--run-cycles C (default: %d)]"
>  		" [--batch b]"
>  		" [--outstanding o]"
> -- 
> 2.17.1
> 
> 

