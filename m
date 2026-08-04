Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946F3EA973
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813780; cv=none; b=rJmTA6EdQ644CjqjEBi8ZsVQHZtJgBlwoe7JUvq+942b9knUvmBt9l/+pfdLg8LS1ga3K9DcGQ0lZ+tFjIjDTi4BB+3W5RdKdnlFnWCz38FnsFADrnuz+o2SQ8299V3Z64tlMihmZ947iwreZwaUVFS6Zkpae6y+7MW3L0j6jQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813780; c=relaxed/simple;
	bh=69QDEITHOpPOWzQ3L59hQQJy9vD1zUTDGKiwsGWVBos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=stfZPTQNVE0u11/b1jJtCF58+7qcwEVC+pBn6t4GReAZjpr9iS03Lf3C/E+80HXW8WS8ftPs4N9FzBebknWVaLct3f1crfFbzBL+HWPnZb0jPox6bUlQpHNLBhnDSBY6TvjTGTWkrvWIFPfBmoZKENMrqu06ea4jyWSVounrGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hg+uMTeZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hg+uMTeZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785813777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L3UKhKneDgKdYIrEhObF1uoqht+Qy/GPjJ3FBr2XU/w=;
	b=hg+uMTeZnX1iUYIW3KLQFrcraEyrN5vDTEzYRkQ9xuzL55mYtOnkVXM6kYvSFjZ/yVApDa
	Xj2+WVvLJRXmKuG0jdLa9MRlav4WmcuKRJ1VLSRMVaA252v8hf+BTqbJvInWAZYbPnh77j
	qZi/TnN/YGaWlYFOHKHNnkQtJKKEBeo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-5nZDCSO0MgOiCL6l4qTE2A-1; Mon, 03 Aug 2026 23:22:56 -0400
X-MC-Unique: 5nZDCSO0MgOiCL6l4qTE2A-1
X-Mimecast-MFC-AGG-ID: 5nZDCSO0MgOiCL6l4qTE2A_1785813775
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c160b9c0676so272026966b.0
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 20:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785813775; x=1786418575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3UKhKneDgKdYIrEhObF1uoqht+Qy/GPjJ3FBr2XU/w=;
        b=OjMc6nksmJ5IKydWQDg70P1YwYHKn3b9E/6QApCszhq8Ugi06BYtq+y30E0OLYYsDG
         nf103QnzxnMPJHuzWYvMupbhBbhTG5PK7XLbaKWFbcZq/JgefTa+wqxOBq4koauk6xeI
         qSeN8XTsmETJLsWMatKATCb+xB6Pko9O4HGONJgZ7q8Pr2mk7yuxbF4h2IUMbhtkIWx7
         pIwj3RMdkomVN5LY0IyRcySMPduGyc8YOqdDeeUCbSGObYzOU0pYHr7FhbYca1jPgisf
         83YTPdxNdIZrbQWYo4+5RQ9fBKT6PkxEOkqbxqO62JcfyRgvQVZsF4MxClZU7tz+XyaW
         W2bA==
X-Forwarded-Encrypted: i=1; AHgh+RqQjIFb1w6x2GjBm0I0LVBB4DCwfMcv+nwXQaCgHSceW7jV7HtGKHE7SIoZSHkIemqlZBXHb3bBQkokzdJMXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz47y/7VhuoC7XFf/RnkV2+OGc3UjrDopwmamBFl8R60mRy4mS
	ms+/C+vhqFZP25TDHXapmTP01J2yxdJ6Ct3mbUCwlAm2pSBDpBj/txoILLojsQx44ApiaUiUMM7
	VcGMLAaEXlHVJ4GFLKtBXNMuZFFu1QkqBRbvoEuZTMl9SA4J+u6w6VNTH9SeaupABjFmN
X-Gm-Gg: AR+sD105VLBHFZbbpNxQaA2iW5a3wbBCImlkhp+hBuBKtxhkd7o5lnEO/aLGrXHlMwR
	iAGlrolOGEDyyBTjrhkgkFUueu7xDXdezHlmR1cc0hJFEoX8G2I59ez3fFm2UVmPwpR9MnG7gl6
	izG2Mb/Xox9xgV2VV7iIDMe+m7WOq5A5yuzVu5t1DYIesEXnAw45XaTpRWjMBGdny0DmxE/MTAF
	TLurt1lOE19BV2x5vL2SPiPQqsvf4CA7k2IjuhWXSowGDK6YiX926pTXN5DQo/fsP3kDBIA8wlD
	+WCDShtuCAq78j+hgi3n6sAKKRKzCOGFq152cKZc/OgVAlShPCh8TaiPu5cul0CVcGLK
X-Received: by 2002:a17:906:6d54:b0:c15:deea:a178 with SMTP id a640c23a62f3a-c1fe80cad0dmr826567766b.25.1785813774968;
        Mon, 03 Aug 2026 20:22:54 -0700 (PDT)
X-Received: by 2002:a17:906:6d54:b0:c15:deea:a178 with SMTP id a640c23a62f3a-c1fe80cad0dmr826566666b.25.1785813774501;
        Mon, 03 Aug 2026 20:22:54 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b387sm596422666b.2.2026.08.03.20.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:22:52 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:22:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: michael.christie@oracle.com, jasowangio@gmail.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2] vhost-scsi: flush backend after device ioctls
Message-ID: <20260803232144-mutt-send-email-mst@kernel.org>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <20260724060919.1569170-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260724060919.1569170-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TIwFbGzlFCpubgKPnsrWMwKLRQC38AY8-LMfWpKcM2Y_1785813775
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2026 at 02:09:19PM +0800, Jia Jia wrote:
> vhost-scsi translates guest response descriptors into userspace iovecs
> when commands are submitted.  Target-core completes those commands
> asynchronously, so VHOST_SET_MEM_TABLE can replace the memory table while
> an in-flight command still retains response iovecs translated through the
> old table.
> 
> If the old mapping is reused after VHOST_SET_MEM_TABLE returns, command
> completion can write the response to an unrelated userspace object.
> 
> Flush the vhost-scsi backend after vhost_dev_ioctl() handles a device
> ioctl.  This waits for in-flight commands that can still use the old
> response iovecs before the ioctl returns.
> 
> Changes in v2:
> - Shorten the changelog and remove investigation details.

fyi changelog should go after ---


can you pls answer mike's question on v1?
Also pls do not post v2 as response to v1

> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/scsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c5..c3e8f1a0b2d4 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2424,10 +2424,11 @@ vhost_scsi_ioctl(struct file *f, unsigned int ioctl, unsigned long arg)
>  	default:
>  		mutex_lock(&vs->dev.mutex);
>  		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
> -		/* TODO: flush backend after dev ioctl. */
>  		if (r == -ENOIOCTLCMD)
>  			r = vhost_vring_ioctl(&vs->dev, ioctl, argp);
> +		else
> +			vhost_scsi_flush(vs);
>  		mutex_unlock(&vs->dev.mutex);
>  		return r;
>  	}
>  }
> -- 
> 2.43.0

