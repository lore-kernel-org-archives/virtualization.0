Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A6168DA
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944550; cv=none; b=tndH3QEoGDHtWhupOtp3bistlYdhM9qTdYg4OybFa+umfl5qXUb0An2aRCspC3uVStsJDp8b9VAuGGGcQe2ko/Uo6HvWJlt2KUaIKiJYUc2sX3ahBItHYnr4jP2YaaW793EJPNv7ekmfxLkUFHqlvt43T/iSeFfx4VxdAUdNYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944550; c=relaxed/simple;
	bh=5TmukUoN3OqViIZSgckxwOaFaXhvahwdFF1GZRjk2XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7Yv+Ri+11TXrUSCHEQLKOcBSvI0RzlMjz2uln/1b0qDSzzrKVfDsvKYA4H76Q9zn3glVgTtP0wZ5RhkQel5lDreJi3/m2lpeafNUsUlrykCorpXC0/Q0WQHipT2WrCQ/mp5lOnFmnSiyLrw5cTmGKFFdn/JY/vc2Ic9tsnHdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cly3TL1X; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cly3TL1X"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2705dd4ba64so412434fac.3
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724944547; x=1725549347; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FRirlb6wvvKBJEvpGg/PBmMNU4ZDQpov8zWQVHUhVVE=;
        b=Cly3TL1XneuYzwYaF1Dtevjy7SvyyXQZuV2l2DQHJ6tZfKJYHcEVDRx5PSSilis/je
         KSBKZaQJSmU/I5Kn6wkmACiRWh6b4arrtvuTUGC38vJPw99Rq825BeW7+48JIutB5yRS
         kFB5Tc7TnGoFqeoZNbaeMZulBbXYX6JEfY3XKF84vM2JT5P+oMQn5UC2emtex3dTkNoS
         cOEDAP+rOqYeKV4nELR61BVME7kbqwXhvRUw9AauMPqy0TdlIhWowHo//H+19M9vtdwt
         5J5CFKFwbFlYBX4kcZ8rITEdPUEi5NbfsrYwJDAUyxzPd8JDA1cVoM79+Me8jjp0Ll04
         6jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944547; x=1725549347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRirlb6wvvKBJEvpGg/PBmMNU4ZDQpov8zWQVHUhVVE=;
        b=EotRWbncbFxmhSuycN1w4s9QTnqyNXi1Nl/u8zvojTDdOXeA6LjKBeDtfXLsZzY0oP
         AKqgz5afIl2mvsV6VdfjhfODIEcwpvOmsGVrMtFcpjVasnBr7YX/UDym4+Cf8N+6jLUW
         IscNamhvUItfifv056DrHTH7R0mycC7xDVRwaVYLjDQrCBHx0Of5SpVdi6FSXjiXD57t
         IN8xszT2H5Qnj203Rv4UiXkclP2cB++MH74nRFLSEfHAHuTCozOEF9pWV4ksSYzQQvnG
         AnFPhw7w/ns1CUPy2Md8xL30VzwvF0+vXJq+Rb+5M7QiUAzjx70LOjupj2q1e/C24pfp
         exRA==
X-Gm-Message-State: AOJu0YwIZIeg9uufCtMKVOONDNCVkb8CwU0yTqEAhF/BIzwBYrquOls7
	Ic5AakrRABvAsw78pDZbM4xNeJzmDR1g/yAyrt3sCM84YoFK1Az87NYlIrlRxXL2fQprVGJ7GFW
	/mvsUFsxRju59bZXF9dR8xS01EKY=
X-Google-Smtp-Source: AGHT+IEmDAAEp6aILEts2ZQokWen4qdf4maZMNl5CZILfDzYorhaJtj0RtTgC+Siv3QhBB5D/pUU+iRfGQYH8lu3gJ4=
X-Received: by 2002:a05:6870:82a6:b0:259:ae64:9234 with SMTP id
 586e51a60fabf-277900be218mr3667675fac.13.1724944547243; Thu, 29 Aug 2024
 08:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240829143757.85844-1-sgarzare@redhat.com>
In-Reply-To: <20240829143757.85844-1-sgarzare@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 29 Aug 2024 11:15:34 -0400
Message-ID: <CAJSP0QW3WN2Z-x5Y8TnyA_Rq-ok9VgG1YSUzYPDCrav7Phx6Hw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add virtio-vsock driver in the VIRTIO CORE section
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 11:01, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> The virtio-vsock driver is already under VM SOCKETS (AF_VSOCK),
> managed pricipally with the net tree, and VIRTIO AND VHOST
> VSOCK DRIVER. However, changes that only affect the virtio part
> usually go with Michael's tree, so let's also put the driver in
> the VIRTIO CORE section to have its maintainers in CC for changes
> to the virtio-vsock driver.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 878dcd23b331..6dcea63f396e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24218,6 +24218,7 @@ F:      include/linux/vdpa.h
>  F:     include/linux/virtio*.h
>  F:     include/linux/vringh.h
>  F:     include/uapi/linux/virtio_*.h
> +F:     net/vmw_vsock/virtio*
>  F:     tools/virtio/
>  F:     tools/testing/selftests/drivers/net/virtio_net/
>
> --
> 2.46.0
>
>
