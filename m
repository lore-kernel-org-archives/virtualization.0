Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41C19258E
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659390; cv=none; b=AkjIM9l5eaQ9/5ZNdG1bvE0K880sO9ApSPy+2s6MvVeJ2JYaaQt/jhdagrwg9/bpkTaejZsrrCvG87iersG/I68QsjW8piEfujwjXFA6TJ50Gha5cw7D5xZ4ZoUVJujvPZjVYPhxpj7Jc+CxnVLBo/t7QSe8kZRK1eh2i3r/ORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659390; c=relaxed/simple;
	bh=FJmm1WgaUGtVr0255+qylffWIZyP0RAouYyXZJ8u+RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXMiTsneB8eQCPQcyDIMUmKMP8DlUKe74QzwYbNrYqa7OPe1vUeMTqZXdCRtPDj/fqIW+OYT7GWJ/1j8KUXFWfm7/vbYaQXNXoaMeF94OQbfoU9F5mFQ0yLkzD8uXF5p3uYz/ZVgqyOe8rDnVZvOEfOEdls96/iUMso3z8D5NVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJkqjGAa; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJkqjGAa"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B33140179
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 05:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zVsWNyHwGrXl for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Apr 2025 05:49:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3E4F640065
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E4F640065
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iJkqjGAa
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3E4F640065
	for <virtualization@lists.linux-foundation.org>; Thu,  3 Apr 2025 05:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743659386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGOUCwnLFb2DGhe7rL9rPyM+h3AAwNQ0nyeu269GqgE=;
	b=iJkqjGAabwADo0npyI9GT5/ERDKeyKrI9BdS0uPDP1Wk+CFb3EOSG/QK356iYdNpzkb4kv
	P/72fkhSNcdDXjiMw4rT7GKsy/n//PTrINvaqnlntORoXw4ihicAs5V5adh75EEbqbLYof
	xNysITLLU4YcsBfy1F05+YPsB7XMBuM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Yq_z_tEKO_qIdb6ElQ_Esg-1; Thu, 03 Apr 2025 01:49:45 -0400
X-MC-Unique: Yq_z_tEKO_qIdb6ElQ_Esg-1
X-Mimecast-MFC-AGG-ID: Yq_z_tEKO_qIdb6ElQ_Esg_1743659384
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac3e0c13278so38358466b.1
        for <virtualization@lists.linux-foundation.org>; Wed, 02 Apr 2025 22:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743659384; x=1744264184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGOUCwnLFb2DGhe7rL9rPyM+h3AAwNQ0nyeu269GqgE=;
        b=A2OV80W2rpV56wLf1LlPQfk0KsPOlBFnr+lU/nKiTNjBauVUlt3ezS+sRyEBbypFxc
         JL6iZlN5ltHjG9HUeMZAu7rf/gxhps4Pksx4joJ/qVK0rdOqJvxtMF7ZH9BrV0FLACmd
         qqN2oGZpaaHMC83RdnGrkUA6gCAcvT//5n1qUT3+eJAIvYEIdGLoTIFocZn3eJmi/kz2
         T40J9KQLpQ8xfhpsBZ6jqSPSVR0EuxmHF9gJzF47r6kAtTMFdbzFz1hM4t9Y2PMlk306
         CWVwqWKhIZV0wF0dY9i5X4K+/62bOmCK6+nFkfAL12Ro+9wW6Jwy+e9duQSsxo5wfpQt
         tKeA==
X-Forwarded-Encrypted: i=1; AJvYcCXBrvLiK/r89lwE4d1K3Qg/MHw2QAC20hANCFyApkxEvmP+vBT3HjiSbKWuftBlWxK03ukNe+L/Y8lDpkIz2g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YygPj6EdksM+mtKgF9XeOKyp52vrwgN18CeckxJWKg/8l7k4o81
	D/gG46W73GUCLSz3gy505HovhEoAC3nyJKE3X9udyMR8lh8a/bkhVBaFe4d7+NUsuxJYntOVjOQ
	oeP4KV3IYGb5vzqXzSFNk/TEo7W5McMLEYqOqbbh1Kc6FebJ+/WHtFnczVjWZC25QgdQ2R+RDGn
	vI/jbLVz084K5ydmo/heLm3rQF7d6sneRE++olBcIKtfyKRFqXpsxk9Q==
X-Gm-Gg: ASbGncsXfJ7pd0eFuIuEndGg4RO1IQ7gh2K+8+I9L5gEvn1djwGIkJkY/9DJfrJeOBj
	WqiuJU4sFADSji58Hwm4TeLfqCaMU6AXbSw2EcYzztp+7stLSdnLa93DvffGm2k1yoTipBkdBLA
	==
X-Received: by 2002:a17:907:9693:b0:abf:6a53:2cd5 with SMTP id a640c23a62f3a-ac738bee1bfmr1738562066b.48.1743659384213;
        Wed, 02 Apr 2025 22:49:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz4yBfQlsL4mjZciTzHbBn7fCLVHD6K77EGTEFJy1FS/52vh/BwGXdtwiiQaNJWcmUiMtg7i216HCs0W4l6Ao=
X-Received: by 2002:a17:907:9693:b0:abf:6a53:2cd5 with SMTP id
 a640c23a62f3a-ac738bee1bfmr1738558866b.48.1743659383835; Wed, 02 Apr 2025
 22:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-9-lulu@redhat.com>
 <3zmkrimo2nghk42iatj4tuhfb7qrxx235srleuavi4at5dsv26@zj6wqgj7hj62>
In-Reply-To: <3zmkrimo2nghk42iatj4tuhfb7qrxx235srleuavi4at5dsv26@zj6wqgj7hj62>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 3 Apr 2025 13:49:06 +0800
X-Gm-Features: ATxdqUEbovQ8ttG-mQdSdHhj7EeYF7BEzCWN7RY_HyZJvUnN6Z_zvqXd3kASYjA
Message-ID: <CACLfguX7FJXdMi7CGxyDR+CtkHdgQOXm7T4fO6hBsFJ0Wa-2WA@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _cgoyMbziKO9ni-jXCv_CRL6SnNPPhP0h7cKay5ksjU_1743659384
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:21=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Mar 28, 2025 at 06:02:52PM +0800, Cindy Lu wrote:
> >Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> >to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> >When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> >is disabled, and any attempt to use it will result in failure.
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/Kconfig | 15 +++++++++++++++
> > drivers/vhost/vhost.c |  3 +++
> > 2 files changed, 18 insertions(+)
>
> IMHO this patch should be squashed with "[PATCH v8 6/8] vhost: uapi to
> control task mode (owner vs kthread)".
>
> It might break the bisection to support an ioctl, and after a few
> commits enable or disable it depending on a kernel configuration.
>
> >
> >diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> >index b455d9ab6f3d..e5b9dcbf31b6 100644
> >--- a/drivers/vhost/Kconfig
> >+++ b/drivers/vhost/Kconfig
> >@@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >         If unsure, say "N".
> >
> > endif
>
> nit: there is a mix of tabs and spaces in the next block, should we
> fix it?
>
sure ,will fix this
Thanks
Cindy
> >+
> >+config VHOST_ENABLE_FORK_OWNER_IOCTL
> >+      bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> >+      default n
> >+      help
> >+        This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allo=
ws
> >+        userspace applications to modify the thread mode for vhost devi=
ces.
>    ^
>    tabs
>
> >+
> >+          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to =
`n`,
> >+          meaning the ioctl is disabled and any operation using this io=
ctl
> >+          will fail.
> >+          When the configuration is enabled (y), the ioctl becomes
> >+          available, allowing users to set the mode if needed.
>    ^
>    spaces
> >+
> >+        If unsure, say "N".
>    ^
>    tabs
>
will fix this
Thanks
Cindy
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index fb0c7fb43f78..568e43cb54a9 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> >+
> >+#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >               u8 inherit_owner;
> >               /*inherit_owner can only be modified before owner is set*=
/
> >@@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned=
 int ioctl, void __user *argp)
> >               r =3D 0;
> >               goto done;
> >       }
> >+#endif
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> >--
> >2.45.0
> >
>

