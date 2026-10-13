Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56E3EA97E
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886672; cv=none; b=ApruPl4zwALwNA26unRBXeeCLBtT8SN8q6HPvMhbdgDSbUvQFHnAzwFwKBxJHQuGPXhg+Pin24WV3zvMMBP5psealVbrV8x0QWAVSsJbTojDDDWUtIkn1Z0p+CuoMvbdyO6XySH2JBffSgHltkme3m4ygsWcrRANNfLyYVj6V7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886672; c=relaxed/simple;
	bh=mIerHSoA0UPEkltbp9WWAtUXDdAGlSICZDdSK7TN0Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AhyuLvHbtteE/WeOezkczVXEFILjXkUMF1asAWXVe1iRBIMFN2VlW9IMN6EbyHSprsFMUUydVQNxAhf1HzntH72QurQPhbYWuCFVeDakZ+VBvAu7RCfdOLq4tf/W4rgnqkzLjtmpr/slsQriEVEl6Mk2dVLvohMtMU0Iq9AQx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoQeNOv6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoQeNOv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791886670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQm+7FhyHN6+IiGzitNgRTZSKN6UAw4IPMrNRyYA++I=;
	b=hoQeNOv6aULh/9QEeCfQ0ehKbAoFVJs09vHbUFncSxR9fiKdv6NBATz+x4KTyG5oJmW1Rc
	6O/1oujaHjsFiid2YAFPdu+lENtlsVosIfaMPTNSyKkPZsdHpo1JunbAYbe+IIaLZmnTu2
	pGP4LfVABcBKLX7Lc+DZPHq93PaMBXA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-oOF3Hjz7O6GwC1G0If8R3Q-1; Tue, 13 Oct 2026 10:17:48 +0000
X-MC-Unique: oOF3Hjz7O6GwC1G0If8R3Q-1
X-Mimecast-MFC-AGG-ID: oOF3Hjz7O6GwC1G0If8R3Q_1791886668
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c54e690c5so1994886f8f.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 03:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791886668; x=1792491468;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQm+7FhyHN6+IiGzitNgRTZSKN6UAw4IPMrNRyYA++I=;
        b=oHw87T3t1cnfmvAeF2PrMqmlDuDNVTX/6Wuib5z8E7vKUfTaT3rewrF/j492GpONEq
         afuUSVhJXYPlslt/c5MAhGVMukq3PVWXVhqLpP0ITnk223Cc2sb/0HbAaW99IwyfKfn6
         d8Ux70+1wekEbFpkFy6A5Li/2CE4pvdHOG76/0NlLaq42snKxwqpgX8Ol7a9LGUiMjEz
         054ZJdBpehh6N0Wnx/X0VriQO4j9E3+/muqiRfLghIR6ibyTqE2a325SD5iBymmOPu0Q
         1wSHWs2zMrxzM+dyUhMCaRhVidP4hVaKEhQ5KbVzU5toeemjsD0kpBsQdA6T/47oNSb8
         uOKw==
X-Forwarded-Encrypted: i=1; AKwUvBxCB3n65MvC3AL1ZMAZKmlup5KXVlY/R68T/NXOzEPanGQdlCTaZZPXssd1JKr1yWalaTS8vVdNZ0BlhV0IdQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJPXzjXrXWTW2SLARe/XTg90D+ESeibdpsvzJtZwRGiOZSa7Fa7
	aT76YgF2Cm+gMA21f57V7yUjyIIW5MKZw0/PjUNbXr3n4+Rs8kn7EDkm9dOMUo5xIn8JJ86pLCP
	Xf4NeSeAn2pZRGJC1JTOJe+567Yx6Bqln/ZidnRjS4XgVL3kmbTCKK6FeVFyBZLBRz+4+
X-Gm-Gg: AYBFou3QgXg3hzZWXtiBW7abReDd7r0ZUSwKepulRLYiaeK4G+B85zDiFQPig727D1F
	PK/TrYmjKk3SWqchHrCtH285tVfKSDYZSNUOm6oJD/Qx+K9J+g+9Y66vJcNrq4xM4PAgyplsy/Y
	5akWyd1uRk9kaxdDbbj3lI3dHaE/y0Md/Kfslj99n1LMdElcJBWlFV8P+H19gboZh3/jgBtMooW
	efRLG3EXIRVgBV8+aMsaVNuExCAS15abSEgYvkTIrl9ZRVdeL5YjRNBrTaeH/eJC70PlRa/59xh
	EEqxl+OgL1tsYeaF+DGaZg9pNz41dplZbRRtyUTOs3eWGV5rBqZsM98JgfRyeTtI1MU5FA==
X-Received: by 2002:a05:6000:470f:b0:48b:74b:4ce1 with SMTP id ffacd0b85a97d-48dbad00328mr20458006f8f.32.1791886667593;
        Tue, 13 Oct 2026 03:17:47 -0700 (PDT)
X-Received: by 2002:a05:6000:470f:b0:48b:74b:4ce1 with SMTP id ffacd0b85a97d-48dbad00328mr20457934f8f.32.1791886667017;
        Tue, 13 Oct 2026 03:17:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc5e0asm4276759f8f.50.2026.10.13.03.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:17:46 -0700 (PDT)
Date: Tue, 13 Oct 2026 06:17:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
Message-ID: <20261013061724-mutt-send-email-mst@kernel.org>
References: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y6m9QtOAA2qUyL-f_7FS2GaPgL_FA7sMrf1dlL4BjQ0_1791886668
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2026 at 12:58:08PM -0700, Bobby Eshleman wrote:
> I've been reviewing vsock via lore+lei for a while now.
> 
> Finally adding myself as a formal reviewer, since vsock will continue
> being stuck with me for the foreseeable future.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>


Bobby's doing a stellar work.

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8d3c..cc1341f6e15c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28840,6 +28840,7 @@ F:	virt/lib/
>  VIRTIO AND VHOST VSOCK DRIVER
>  M:	Stefan Hajnoczi <stefanha@redhat.com>
>  M:	Stefano Garzarella <sgarzare@redhat.com>
> +R:	Bobby Eshleman <bobbyeshleman@meta.com>
>  L:	kvm@vger.kernel.org
>  L:	virtualization@lists.linux.dev
>  L:	netdev@vger.kernel.org
> @@ -29145,6 +29146,7 @@ F:	drivers/media/test-drivers/vivid/*
>  
>  VM SOCKETS (AF_VSOCK)
>  M:	Stefano Garzarella <sgarzare@redhat.com>
> +R:	Bobby Eshleman <bobbyeshleman@meta.com>
>  L:	virtualization@lists.linux.dev
>  L:	netdev@vger.kernel.org
>  S:	Maintained
> 
> ---
> base-commit: 8e2fbe0e75d38690d551456658194c632933cb57
> change-id: 20261012-add-maintainers-bc6e8a6fa68b
> 
> Best regards,
> -- 
> Bobby Eshleman <bobbyeshleman@meta.com>

