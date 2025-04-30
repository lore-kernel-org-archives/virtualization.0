Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0721ADAB
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004216; cv=none; b=dX+ehuvMihac4CW4KtANOkeR4PRnGYz38orz11WiLOxwKJGRkmn/ut9xR4ZI61y5UmBL9QjJUm9r0HdfWEVaXkfRIrk+PUUJ5wsh1+Gofni3Bkpk8S0MAQsK5uu2MJd9GdYctZYUS/ZN1vQDP4tz9Wbmz91AEjzZyvR1PpdjLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004216; c=relaxed/simple;
	bh=igMUEO2jdAMJa66FnKgZHk74FDW367SkId7b0Aj61PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dzRf55vRqhcnuFSA7e7PC6xE0tBjo+DS88vnYyk7WpyHuSjfRUhyFnB2rC2p1t4ziOBqrRshYwYu2ZOrB4Q2IbNoKJIcRgaYutXfvQCqoa8uRYmDxqCah6HxfRYE2/VMSyLJD6e+8X34H0ReNUpeARS16T/9gD5AsoeDHwox53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4kYwgVh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4kYwgVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746004213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RBM8h9GXkd4oRheqBQptKlBrFr1ALhS3777dATJTzNQ=;
	b=N4kYwgVh1m05hL0ewz737lPHK6imuCEIm49pHySaVIeQXcoG6Frf6JT7ZSmGvX8qIuKLfk
	k6DmFKUPQt+dbBvi4pQ1RWnE6AfiaLWPnbyZOeSy1L/nGIqnJQAzGsTH9ApjKp1JAcLqEV
	AbwL16RpBIaxjVnQ24NIlCCargOxa18=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-L53QTQntNx-XzUhIO3sJBg-1; Wed, 30 Apr 2025 05:10:11 -0400
X-MC-Unique: L53QTQntNx-XzUhIO3sJBg-1
X-Mimecast-MFC-AGG-ID: L53QTQntNx-XzUhIO3sJBg_1746004210
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acb5a03afdcso572538566b.3
        for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 02:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746004209; x=1746609009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBM8h9GXkd4oRheqBQptKlBrFr1ALhS3777dATJTzNQ=;
        b=Mo/0eRiWUvr5VvmP86aEccaXmHD33TEN1EFF2zHo2eUv5uRdu4tGoNBZTzKGTwy/8L
         jyS7KVV0dB1WsUs2QnvaY4mz9AJM+slljUZXeAmXWti08w2aaVHDTQofvmFssl7zPAG4
         lkW502Ltyh81n3ki6mOIl6qLGJSfCod4crJPYksykIj8+7xxIMpWEWfBrsrZiTqcwnEO
         6SFwmOGZNeBKIZnCS0ujBTne9LaiY2oQ13uEQL0gCr7HQyGm7iQzxdvnufpN/sFJlDZF
         shoUXtxgazu7BonKIusLbvmjbz6TCsC6D3Zfdvs5Zz4akY2VA87q9lVXLHDE0mgH/ZKd
         hbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBwMx6QCTWKmpFaT3S7UEcyOtk+iS/ArKQ5qvKOdspRzxWxPofO0ZnSfaAYmS32WL3HcTbhY3h4dnGQtxOjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxANWmEz098T+WLM5gWwrj5pKv1DZti9tBpBW7xn/rs0C2zhqGe
	dKBowNycgX/I0CXi17DSbX3UfwtJSs5ia1Z1DeQqihZHf0/5SF3mJDCaft1ktllYPFYm+uteLm7
	ze1Tjdtt7vQGp9SmqC5PrcWva6tZdI5qOOGzWRz5Pu+KmULOoRUmQMAILhkWxsljr
X-Gm-Gg: ASbGncsNqp/Yn6pY7Zc2MUwiRdYCMWwvdZeIxKsaAhE3lhWDFcTYcI2WhlTZsIPVhEu
	YrDWXpVstDnoYmsPvlZIDLKhlLH6BhtlkjDglSIHMu316VW04jAnc8yKiWS8c4Y4/yw6ISZaMFj
	DZFE85R5i4jkbrjXSlk0o8OnLci/mVRygUCkNq+T3MtjkKsen0Ph7aw0YCsUH2hZr5puKnHoNr0
	EWB8m5vS8XVJZc97DFZ/bvqTsS1x6JW8I0Z8SFvFx13dhgjfIFT8zXNhkujd+MqRlkdBz0EoOXU
	Fdx8WQNDL34inV7b6Q==
X-Received: by 2002:a17:907:7b82:b0:aca:aeb4:9bd6 with SMTP id a640c23a62f3a-acedc574a4cmr220066566b.10.1746004209570;
        Wed, 30 Apr 2025 02:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBMPamEhDPbDLqOXiGcIZesC1dmK+7e+0MqQ1tv9XUC/crH+ZQmawf9DLNdOJwg2QfTaPusw==
X-Received: by 2002:a17:907:7b82:b0:aca:aeb4:9bd6 with SMTP id a640c23a62f3a-acedc574a4cmr220063766b.10.1746004208996;
        Wed, 30 Apr 2025 02:10:08 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acebe7a4ee8sm313299266b.74.2025.04.30.02.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:10:08 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:10:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, jasowang@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 13/21] vhost_task: fix vhost_task_create()
 documentation
Message-ID: <n2c3bjkh4jbzm2psd4wfrxzf5wdzv2qihcnds5apfgfyrojhyd@l6p47teppn62>
References: <20250429235233.537828-1-sashal@kernel.org>
 <20250429235233.537828-13-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250429235233.537828-13-sashal@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xlF4qQHBqyeJScK2TmXznBkqxurR80GDYVp0j0NxIBU_1746004210
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Apr 29, 2025 at 07:52:25PM -0400, Sasha Levin wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>[ Upstream commit fec0abf52609c20279243699d08b660c142ce0aa ]
>
>Commit cb380909ae3b ("vhost: return task creation error instead of NULL")
>changed the return value of vhost_task_create(), but did not update the
>documentation.
>
>Reflect the change in the documentation: on an error, vhost_task_create()
>returns an ERR_PTR() and no longer NULL.
>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>Message-Id: <20250327124435.142831-1-sgarzare@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Sasha Levin <sashal@kernel.org>
>---
> kernel/vhost_task.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

It looks like 6.6 doesn't contain commit cb380909ae3b ("vhost: return 
task creation error instead of NULL") so I think we should not backport 
this.

BTW, this is just a fix for a comment, so not a big issue if we backport 
or not.

Thanks,
Stefano

>
>diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
>index 8800f5acc0071..0e4455742190c 100644
>--- a/kernel/vhost_task.c
>+++ b/kernel/vhost_task.c
>@@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
>  * @arg: data to be passed to fn and handled_kill
>  * @name: the thread's name
>  *
>- * This returns a specialized task for use by the vhost layer or NULL on
>+ * This returns a specialized task for use by the vhost layer or ERR_PTR() on
>  * failure. The returned task is inactive, and the caller must fire it up
>  * through vhost_task_start().
>  */
>-- 
>2.39.5
>

