Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EFE6D50A
	for <virtualization@lists.linux.dev>; Fri,  1 Mar 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303112; cv=none; b=isiB7pbocnQKJdSAzGkSux/inXzon1v92E5aD/9yt6jKNdZ2uG/sLV14Pr5BXuKx61iAZ61GU0WxJpu1hMMj9ri+XXDtR/Y9kQi9s8kkQ2HZPdR9CmipFXh1FZRZjhFUI5MsDGehT6i8iAQ7tYGaaIU6Oe9pdZmQrnXHcqOoltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303112; c=relaxed/simple;
	bh=5okDwi/k7eo0OHcemxFpOE6en8LVkUhW41Fp8q/pG3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diIYHyO2SOmSw29lpmZV1Odjv0MBr+q/nm2tplY9o4IG75nHY/5RF5u50nKcpF7sBsJXFCmFyXSW/375d9F3afrpwDfxx+vOYlXxkwnZToTHnDoyQZ2la4vLovkwmL03xsyvv56nSCFX55Pe8OkrFvHolPdIGQhEGyzRd0N21v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=C77EK4+B; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="C77EK4+B"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so552097766b.0
        for <virtualization@lists.linux.dev>; Fri, 01 Mar 2024 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709303109; x=1709907909; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5okDwi/k7eo0OHcemxFpOE6en8LVkUhW41Fp8q/pG3A=;
        b=C77EK4+Ba1Ykt3Uxnr1zFfCXlgxScgQsVadfjzvxQtjbIVcA0lYc9sAt73WG0jkTr7
         6KYEjhzdaYoVdhq/5NPHeLhtAd0bYFsW1a1+Nd2Dx5tWdeozM9VOQqhn7wXwuShk03el
         wQlT0VfZIs26xgWCoDDobmgnJ7k5NablDztps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709303109; x=1709907909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5okDwi/k7eo0OHcemxFpOE6en8LVkUhW41Fp8q/pG3A=;
        b=gG4yu7yjPSuJNvbRcz45OW82cmcq46AzQW+wiSAbdf0aB8XEfE98/tm0SY7m+U28LW
         9EgiGTk5IFIUktoj/j0ReBCO1tQUhte8zj/MclzdIMSV8TDLdewnXrVeeBxazBk0EFWT
         m0ahfl38om+CrybFc4o1Lzz4IgLxiESH+Ad/iG7SNj0T63Ej11/YP9kvCr9qP6LDD3M0
         Dr3WyNO6jZm+TtDraEHk724XgQuX4lagbvPo/Cr8FMtU11uqv+F3+6NmP8MdNzwgvKgg
         2smxaarZd2SWt0vI5f0CxpzqBI8zwWS8ccX875DcPxJ3J3YWg6iy2KUJBaC9NXUGEMwG
         KKFA==
X-Forwarded-Encrypted: i=1; AJvYcCXH5W5XDtGmA36ihoXMrYQpWa070KmEok/KCocGf02MCxAeWPHJOasuHCug0qEG++mqfmjJxMCTsq9fipHBHbj4BkRy4FvAfKcVYj+YrOk=
X-Gm-Message-State: AOJu0Yw/TAMMblVrc2UB6M7+lzcVZ5+MXjVRQpyg/EMIUg3GdAR68ENc
	yHD3w9NrOfSZEMkHA4aF/R91FLLUwjBo0JyfLGiy8e81CzFKA/LxH1t0w8U3TZocYiElM9M//aF
	BdQ+SEjAkiukQ55dNJI1m9hAYm996XNUC78qULw==
X-Google-Smtp-Source: AGHT+IEhsrgq0r/5TG+8I3i+pYsCJeZ2wHcCwGUln1tbl6e7l4aRJSB0dinot2MdM9HMgBMP+IXw43g0gohie9KCMdg=
X-Received: by 2002:a17:906:5ad0:b0:a44:806f:ad56 with SMTP id
 x16-20020a1709065ad000b00a44806fad56mr1493961ejs.11.1709303109066; Fri, 01
 Mar 2024 06:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240228144126.2864064-1-houtao@huaweicloud.com> <20240228144126.2864064-4-houtao@huaweicloud.com>
In-Reply-To: <20240228144126.2864064-4-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 1 Mar 2024 15:24:57 +0100
Message-ID: <CAJfpegsSHfO6yMpNAxaZVMvLNub_Kv5rhZQaDuJHNgHpWhpteg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] virtiofs: factor out more common methods for argbuf
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Benjamin Coddington <bcodding@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 15:41, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Factor out more common methods for bounce buffer of fuse args:
>
> 1) virtio_fs_argbuf_setup_sg: set-up sgs for bounce buffer
> 2) virtio_fs_argbuf_copy_from_in_arg: copy each in-arg to bounce buffer
> 3) virtio_fs_argbuf_out_args_offset: calc the start offset of out-arg
> 4) virtio_fs_argbuf_copy_to_out_arg: copy bounce buffer to each out-arg
>
> These methods will be used to implement bounce buffer backed by
> scattered pages which are allocated separatedly.

Why is req->argbuf not changed to being typed?

Thanks,
Miklos
