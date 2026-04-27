Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34E242D6C
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777252831; cv=none; b=QYYycTSNnh4XOmwQEhAzxeVqHa1nIIPNQkD3CF4b7+pTQnn/kmeqUL3xspwTNtf/kzJcPgiu3ypBxw560xFwUXUigv8wO+Vjlhq8KFjTrjBMriCScQRuqCPKKROZYH8YRFbf1e/0t9z4pWRPhbs0ODC0+f0tPF/hBnKoxEDiItg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777252831; c=relaxed/simple;
	bh=Zjzdaa+iqErjWQGjyzGKktS3EtjxsXtYQ5Fyk+10zek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmQ+IX5VBuuykpvF//tRodBNof7o8qsbNhcVXi6DLFT+6nrmoSccqfxIbcbb031ZbLeyfOTmeBSIQjJaPLg/LE3cG753se+5CffSmnRxB20KuFhuTSohJnCX8KeFa6kBoXBqYVOSGP16ZtMNMA0C/v8ruyL9OTbUq7C+pmtfoJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgVjxeUi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgVjxeUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777252829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zjzdaa+iqErjWQGjyzGKktS3EtjxsXtYQ5Fyk+10zek=;
	b=HgVjxeUiBHG3FiU9M4GnJfZfsjzTSZXwZQ/C5i8xaevK2OqpmOAVdCOJ/1EMw7H3MG6dpr
	lzx0KnZV/i74Lz1cgojzibN/HdgMt3etLmOrkKyL0IgFZxxR/SuwJK57EJW/UvU0DGSXzQ
	lHeNaC6Bl1NMbpl8MmfK49VNbPXc4vc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-3VmOmSqnPHmKcaVBKSNuYw-1; Sun, 26 Apr 2026 21:20:25 -0400
X-MC-Unique: 3VmOmSqnPHmKcaVBKSNuYw-1
X-Mimecast-MFC-AGG-ID: 3VmOmSqnPHmKcaVBKSNuYw_1777252825
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35842aa350fso18944212a91.0
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 18:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777252824; x=1777857624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zjzdaa+iqErjWQGjyzGKktS3EtjxsXtYQ5Fyk+10zek=;
        b=l8u1uVu6l1oLQN67ERc52Oo/YugWEn5kobSt/Ilnn0QPhuueWO956JPuklSP8tSs6+
         ASwqtF7ZEhzAjx5jbwQyOJ9LA2eke1yy3DRhrwO1bvDITS7jlsNHSjPokupC6jHc0gyb
         r0e1pQS1GYqEqmb46D6TmaRib770YY7MtiLgDYKbJ3Dhigaawlk/+J3Tbz7Lunejde0c
         UmW1ol5pXIFQtyIDhh4en6RIup7UjlapSYFcHCFWFyxgvwaGlUx6A4bgupPbPwqSIGDx
         VDj5yu4OrKEYYWE3/hBLcRl62RcT5+ZrDDTYVExs39zbs4+NxhMN4xqXDzvklwQljJhw
         Og4g==
X-Forwarded-Encrypted: i=1; AFNElJ8/KAs0njdQnsckrKZJHDGawAo1X77flQYdI4TNHP9VJmWxRar+4hJ02svdrL6TQ+TZGDnkA9M4gUaHOc7uYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBFzylRkZTKFWdRpWriObxJPs8M5hyGCpxobLK2f7WND99nbQo
	ne0xX1Exrhmhds/TQBG4i7RbWAIKNxU6Wk8k13D0hvR89//cxtHaCnkaelpBEfIz85Gzq6++mZV
	+5Yp2Woc7QRcoKtZD8DSIz+w7k28jIfExCoWZQRZCLPElhCt9X2YS05SjkxVvgwRkK9Zq9SVQ9/
	zsWpl1JXjg0YdDyq47dZbR8XLfGtuAm2rbMXf0FIZVQ5E=
X-Gm-Gg: AeBDieupZxei06ni2ZwokRDygBWOhIF8oKCcrnZeQ15K1VeJqj6dxhOEPZOXXNVQK/7
	bJ+4utXfINC6MJfceKmcUlEzNLeGAiKNR4tnLxwAppCh5dsT4VteuaJkZqWNl8tIb7PZfueRjYJ
	Z3VMQENt2k9zHPea9KoUtjo5hlwyDxXEyaH4ioZeX5N6ZZBHuKtiUIJMiagP50cIh2G3s9/9SA3
	86VYv4inBPqAUpa0A==
X-Received: by 2002:a17:90b:4fc4:b0:35d:a861:36de with SMTP id 98e67ed59e1d1-3614049efb7mr43829109a91.24.1777252824566;
        Sun, 26 Apr 2026 18:20:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc4:b0:35d:a861:36de with SMTP id
 98e67ed59e1d1-3614049efb7mr43829081a91.24.1777252824091; Sun, 26 Apr 2026
 18:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424104703.2619093-1-johan@kernel.org> <20260424104703.2619093-2-johan@kernel.org>
In-Reply-To: <20260424104703.2619093-2-johan@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Apr 2026 09:20:11 +0800
X-Gm-Features: AQROBzByxzHj5L4h64zLuCZs1Plejk9ZI5o7RkG58uEO2PL4BTg0k6kqzmgQfKc
Message-ID: <CACGkMEsoRA5W2oOyFs=4tGv_RjKr7XnqZ=pQTzjX3yjTto_WoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa_sim_blk: switch to dynamic root device
To: Johan Hovold <johan@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -UjHvh0Kr_pFWSg-gOhLn5j0NZ1tnaUfq-Ujt5wTUGo_1777252825
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 6:48=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> Driver core expects devices to be dynamically allocated and will, for
> example, complain loudly when no release function has been provided.
>
> Use root_device_register() to allocate and register the root device
> instead of open coding using a static device.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

