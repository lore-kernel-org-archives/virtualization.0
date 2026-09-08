Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EF3ACF06
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854287; cv=none; b=X+MsoxUHkCZ9HvKP5dwyl/5NkS7SCUVCmcusS+VRS7WcD6TLVLckyI6cN5SndmFw8CENhwQv8oYd1QhDSYJr4uicJaAZL5Hfp1rVm9UAbsb3h66SvGEMiURbAj3BQiP29/CZMuYv9ciKnmCWJrqw2Bkej4NExjrEWOLy/G0+R/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854287; c=relaxed/simple;
	bh=TdLKtRb4SEvTKzu+KCQUsmzinljqSC9tZozsram1pws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=F3BGlGHX9Wahb0xscuCwYZIvmtShf3oGgF6VfH1bltmTEU8OeU8ODK/tiSaWgbfR06bfAUI1G9EIWiwJgNkqHHlEyf+FzHC3VawSgfeM5dtVAKI3eQmYSj4+GIZgBpwl+GlIZUeVvQ0+wNwkW4syWbXd8t68nAdrzGyaNcVmHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EbYkI2AU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EbYkI2AU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788854284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uLFjRbxpszKYFTPYbV8IRN6QAJXJZc4bP6C5VBeyph4=;
	b=EbYkI2AUU0mtKFpqc3JKIPM3nbSB12scIICErNGM8dGdc8ZioFTgxsaX7L9nhNv6i1O11J
	8J6dFKPDEezJRSDNyGIqmsC+DtzQwa+QfAHzk5fiu4GlnTG06HPqVOdnSid1+lOzpYWb28
	76oaUnJ23lKO308GhHjtlc8ZS/RgjCk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-mU7deYQwMdajYnDAqLL_hw-1; Tue, 08 Sep 2026 03:58:02 -0400
X-MC-Unique: mU7deYQwMdajYnDAqLL_hw-1
X-Mimecast-MFC-AGG-ID: mU7deYQwMdajYnDAqLL_hw_1788854282
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49953abe51fso34362085e9.1
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 00:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788854281; x=1789459081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uLFjRbxpszKYFTPYbV8IRN6QAJXJZc4bP6C5VBeyph4=;
        b=bcPZnle/jZrTLal4ljXvTuXK0g8mKFxqU5MfuXALMMItY5/1AtW40feSPLFTh490xc
         lquYFuRy6qlVTLIz8YiM9DdfmeXJCZd5S1fr1+98WlKbwDEIK+W1nyHwHi7GsWoBioYS
         rdD0/Rg+qgOnEWIhUYGaJW8Mu3xO+835h6EN5/WO6RBpwW4lZtua7d7AdghA0nPEeqy8
         qLpEOy/qMHphq6IIncUhqHbn2YdIbCXWvkQxXW3qp16yCWzAn5HXvJ5CwQwP+PV1YrDQ
         h8QzEARcSEIslXr4mMLSV0R5LQbyP5qiLjQtA6wwzViHYsqw2pqVBxkMWGIuwgeqx+2q
         6CYg==
X-Forwarded-Encrypted: i=1; AKwUvBzASsRkv5dG3cfZkEsKOSxdgeVpvyPIS4SgNyeDo8Xmut9To9KOWSOvlpk6SYsBdwK9lF2i8C9F7dT3M1JG/Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mCjgV6bIeeZKDePPs8NvO4xUtj5iO6Xm93WBQXtWZPRr/Oa9rb
	QiRdTnPanYLsPID/ijkMaM/cRkEWrVsIawwusvG2tdMO7qWCFTtE7XqPANu264iM0P+1Bxi4Zt4
	P7yMrPf3lnBq/sSEhhCXZbXx/scQJnX5LzPQk+NIHMYSumsYWQ3IVlCFNlvnGe53OfoLG
X-Gm-Gg: AYBFou0B7NivtpnP9bW1VobIJb4tlZ/GtBbvS9kiwtA4EZraUUi/7Z45Af/aUyHV9BD
	8bgKouq9ttBr94R1mwj7zCX4Bgrp2HxqN0l3ZqTPz5hXgSOFWgCBZpt5DoCjtEZePBXE7+eKbNr
	LmKq45uhsG/s34A1bofVD+ZjUvUK5LUGqprPMAHbsmQFRV49ZcP3B5C8qnVRfMMoO5XVSaNb3ah
	xsIwQIE6q9hPcX11fgmJcoKuU8wB8xaZTYrY69ZPybhUIAFNXAo8mgAe0jaVwm4Kddmlwi4v+PI
	XpoiVel9IBm41f/ifD1HAr7fJk0VobOD5+5pS4nlx5k1hdpCQVvA+SrDW2EaTdA2753+cxzfvfi
	w44MdQ+7YdQeoC4Xt/93ACEc=
X-Received: by 2002:a05:600c:190d:b0:49d:72d:9ba3 with SMTP id 5b1f17b1804b1-49d072d9bccmr177643645e9.14.1788854281456;
        Tue, 08 Sep 2026 00:58:01 -0700 (PDT)
X-Received: by 2002:a05:600c:190d:b0:49d:72d:9ba3 with SMTP id 5b1f17b1804b1-49d072d9bccmr177643265e9.14.1788854280929;
        Tue, 08 Sep 2026 00:58:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbe5b252sm326431605e9.3.2026.09.08.00.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:58:00 -0700 (PDT)
Date: Tue, 8 Sep 2026 03:57:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linfeng Sun <linfeng.sun.dev@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] vduse: return compat ioctl results directly
Message-ID: <20260908035646-mutt-send-email-mst@kernel.org>
References: <20260908-fix-vduse_dev_compat_ioctl-v1-1-62264d9bfb8d@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260908-fix-vduse_dev_compat_ioctl-v1-1-62264d9bfb8d@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cJdCmUJSFjUbPC67Z9RsKY9BKY8pd5S3kTylV5gr4Hw_1788854282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2026 at 03:31:51PM +0800, Linfeng Sun wrote:
> The compat handler handles VDUSE_IOTLB_GET_FD and VDUSE_VQ_GET_INFO, but
> then calls the native handler. Their different command sizes make native
> dispatch return -ENOIOCTLCMD.
> 
> For GET_FD, this overwrites receive_fd()'s return value after the
> descriptor is installed, leaking one fd per call. Return handled compat
> results directly and use native dispatch only for other commands.
> 
> Fixes: 455a2a1af926 ("vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO")
> Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>

indeed, I will apply.

Cc Arnd.

But ... how was the original patch working then? Arnd, what gives?

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 4dea4d6a3855..49a231bdf948 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1882,11 +1882,11 @@ static long vduse_dev_compat_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  	}
>  	default:
> -		ret = -ENOIOCTLCMD;
> -		break;
> +		return vduse_dev_ioctl(file, cmd,
> +				       (unsigned long)compat_ptr(arg));
>  	}
>  
> -	return vduse_dev_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> +	return ret;
>  }
>  #else
>  #define vduse_dev_compat_ioctl compat_ptr_ioctl
> 
> ---
> base-commit: d7808b37da0a619cf1fa541c2384e783fecc2480
> 
> Best regards,
> -- 
> Linfeng Sun <linfeng.sun.dev@gmail.com>

