Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345B3B1A1
	for <virtualization@lists.linux.dev>; Fri, 22 Nov 2024 02:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732241095; cv=none; b=bii93o3nnNbXBKTtk7cnk0+JuET0/bExliPBDukI1tJcpykmDSKS53ZyGDgiY8zbMWUescI75wg9EJekJV4VSLLUuKTUFzOot/ghRT5mvl299IIrAw3cOP5fVIGNpKWFuRzdupv1EnASop+xDn9a3pBl6QmieKyB7AU1lJoly8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732241095; c=relaxed/simple;
	bh=Z2WdGSZptbI/TwwziVtEgRXhgFZuivmxmo3Efxk+zuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjV/CEorH5T1kbj+NxzDRmFwN2nvt9eamKrR9HzSWuQzHnx53CEhjUAHJPGAdfcl2Vxav3sZYVzcbPMVc9SfWCanwJdBsB0cA1BhqJeOB3XepGqNvagHQv1p+V96e0mGMY2MWhdDVCUKXa8rS4lQWh6BQyncbxPIgwJLVRbTYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmIcGnHh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmIcGnHh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732241092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6u4jknaKda2pPeAj+1LeY7wkXaxwhRiQhTbZjxkGTg=;
	b=UmIcGnHh5TPLFRYECVlYlvkMSPucHAnEcNOTQ5xiOQlHxS8Qe/B2xbLbQ0rpOtI4mZ0B4U
	wIilbBntEUeMj4el0fZ8tI39gQrVPl2NcyXLsxeeFeKleFWcWQspkuW0fwXXahmw1mJeqX
	wqUlm3m/+yhEIe+2WVK6aOTzw9msN08=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-BE-PFncvMLmjj7xiCTfbTg-1; Thu, 21 Nov 2024 21:04:51 -0500
X-MC-Unique: BE-PFncvMLmjj7xiCTfbTg-1
X-Mimecast-MFC-AGG-ID: BE-PFncvMLmjj7xiCTfbTg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ea396ba511so1853893a91.3
        for <virtualization@lists.linux.dev>; Thu, 21 Nov 2024 18:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732241090; x=1732845890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6u4jknaKda2pPeAj+1LeY7wkXaxwhRiQhTbZjxkGTg=;
        b=rJXzMyy1WOBDoykEOu+C5pf2i2S/ZQIYPknr+0BuQ9EuzYgFdDJDkK3gmmNkyv/Ny9
         tO1tf6ncNkRX2oYVo/W0aeSVeS+BqbnC3d2WolKXLZukZn3kQKkyD7QzcQWVjOtFSTqG
         iuCRy0zV5007Rf/5dZ590WZN11UuX6d0mZ35ZvKPv4hdZEPGX29hJ8wtH94fYypAtgfu
         WfAd0BA4zzHJbhBgn0qd9tTk9+6Myf3vPXZ/GAsYae2AjHmBezFnBI6Ir9HE/fkRIEQm
         034PTz8X+qgrGT0xQj9oAXWtxIi71YuhgySJZzoOTpw5QWMCa8atSF1HxaKhLg1Gogkw
         A2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWeduWAHiLLGKVmE0t6qh/r5eBHssn+hqb2LMQQJi3puOG/5YS8FDxotJ2f6y3b64kYTDW85GZGS0b7UEVU+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFcmIs0pqyCD+SyIPz97XGgI8m/meR9C4kVsKwbXfAeAdQnYG8
	zySQ6EOxT/nUyFMdOpZ3zOUYCD5nox7MgL63cQ6QswSBBMtfF7VIFjffyvJFKfC4c9Af+N8F/Kl
	GbfcBMxi6i6ZoqJWYYt1XneCRI+IG+e9L7Br45PngnpZ3e71k+ikzglyqpIrNGA7hUyVrKqLMPx
	kA33HbOuOGSxRYqabCwJBQn3WcITOzEyoGBBJ3Hr8=
X-Gm-Gg: ASbGncttc4DHBkdBxeXqjLbd1ZB2dujs9wolb7I/SH3ePud+kgcHfei7/V0xW8RYwxS
	efZjjURXRoDe/WXSq00jO1B6+NjC6SQ==
X-Received: by 2002:a17:90b:2f4c:b0:2ea:2a8d:dd2c with SMTP id 98e67ed59e1d1-2eb0e868034mr1095851a91.36.1732241090039;
        Thu, 21 Nov 2024 18:04:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT5gQZn2OzgKMIi4e1UDo+WMu/JUBQC9thuJdngk1k2cuJOxbkSo/JhdkERIwyiAZqgUiea7i/EaDawnzBta0=
X-Received: by 2002:a17:90b:2f4c:b0:2ea:2a8d:dd2c with SMTP id
 98e67ed59e1d1-2eb0e868034mr1095821a91.36.1732241089581; Thu, 21 Nov 2024
 18:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241119074238.38299-1-xieyongji@bytedance.com>
In-Reply-To: <20241119074238.38299-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Nov 2024 10:04:37 +0800
Message-ID: <CACGkMEtzSKiMgEzZg3o4nugqqMt9DDXZKZ_LkfrbqpfVDQy4aQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: relicense under GPL-2.0 OR BSD-3-Clause
To: Yongji Xie <xieyongji@bytedance.com>
Cc: maxime.coquelin@redhat.com, hemant.agrawal@nxp.com, mst@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hVGkgdy-sjld3L6nUmt1PLMN7yy5atmXy59imhGSWAw_1732241090
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 3:43=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com=
> wrote:
>
> Dual-license the vduse kernel header file to dual
> GPL-2.0 OR BSD-3-Clause license to make it possible
> to ship it with DPDK (under BSD-3-Clause) for older
> distros.
>
> Signed-off-by: Yongji Xie <xieyongji@bytedance.com>
> ---
>  include/uapi/linux/vduse.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index 11bd48c72c6c..68a627d04afa 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-=
Clause) */
>  #ifndef _UAPI_VDUSE_H_
>  #define _UAPI_VDUSE_H_
>
> --
> 2.39.3 (Apple Git-146)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

