Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4E215F7D
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023202; cv=none; b=p8kQhmaeVaD7cz9CTDGN+yi95/wzarVYwhcwRczKXGGF57lxVUlbyDDReTXycvXacDbpievuwSjzLlph9CzBmTD07e7df8OPtYzv+Eqarob3GUXNPldOD1iEPYgNRoJSOMeMTZTh2vdUMqVN9zm49EAZwMJNSkY2S1eLUSvDABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023202; c=relaxed/simple;
	bh=Kqke1zXRTdE0PHPb+71qhUA9lMSBTCX8sSQVT4I2Ut4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KFOhIAcSWboH5VeKVYv/7ffdfccL72o87x3lOynQBfISKXX9ZujGGuRG+dxGt1HPQVqM2u32UokFjKzTYooZr8YvyDrlxDRjhrWiJQ4/eaj7YR8HlKwMqQy1UlHBMj6ZdZ1QjbV/9hFuRIShoonMM8r/K7y4QTWMrbYWH+N9cg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAGSqzCe; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAGSqzCe"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D93F60842
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 17:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fJS_XwHHCyRH for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Mar 2025 17:33:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A2734605FF
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2734605FF
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QAGSqzCe
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A2734605FF
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Mar 2025 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741023197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=riX1iNIQhseaZsPbJjiHdH5ZxszgBUyrqDQWObE9EXo=;
	b=QAGSqzCe1ir92rMZd2fBt+C+zuirk+G/6LRPAP2UvnQ6I8RASUkiomPI/0AzBqj2ZM5n4u
	Q9SCaF8wrIE046n3cDDkwLIdno16iOHj7i4sJc9Ipr0lXYEEZhd80wBYlLzMx3WxavthHF
	7FXi4X9TJgq4Q8rGhW0lp21BaopEIVA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-cljPc2cKPZK8-ZgCQPZhUw-1; Mon, 03 Mar 2025 12:33:16 -0500
X-MC-Unique: cljPc2cKPZK8-ZgCQPZhUw-1
X-Mimecast-MFC-AGG-ID: cljPc2cKPZK8-ZgCQPZhUw_1741023195
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390f3652842so1720359f8f.1
        for <virtualization@lists.linux-foundation.org>; Mon, 03 Mar 2025 09:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023195; x=1741627995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riX1iNIQhseaZsPbJjiHdH5ZxszgBUyrqDQWObE9EXo=;
        b=D5tz5ZuMCbHIdM7LHB4sQIgYnnPmeaMGvogES/sIIL7Ceov1IWtzvEBQJ5WRoxZ5rU
         logTJg4xZafRBfoWOFhy6zjjsAPRPJ9cyk3sAVM5sAsreviJCQcaPzJYCdVzlQSJZKsW
         aWvmtITFLuIdcZiflhgnghOkhKHMRJJ71IFI8goNmvN77Fz9pvpUiqtMkdexz5vDdj4I
         G1kVgxUvhPzKty6hItDaGyPpo0x9hCzcmaNBdy4asxDqM90Z1SHsKnCDL0WbQRe+MJpY
         XXiVqEIxwohKEIQPhs1xf/FsnlAO+gqfC1/PS3gpDaitcFfr5StvTpC/A51bvIJ9Fcbg
         lI6A==
X-Forwarded-Encrypted: i=1; AJvYcCX6vzPah/dM+vNKacA3PSo+/PgGw0eNHJFU6UlvmegNTPxQuP3+hRzRzcN6e5C9D9Lu4AjiaGZyy0/gFn1+Ng==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyMolJxPpEpzDQKNc61Ope3IV7j0az2FJQUdPkYFzn+qicdkWxD
	yk4jHlnggUINZxBvs9qn/9XC5OdV4ShwHc7KYKBGfRfHce51+OCix0ysFJiLgJPIa/9I5GXtbkO
	UdAhHbOmwrl32w3fo66YuFUIVhwG0WGzDgwmegKeybcrphF9JWmk3L27q+PyMfUL/MxMprbO0Mo
	i+HS8=
X-Gm-Gg: ASbGncsK7eo9HlNY19jAtZ+tgLaqbCpb0ABzzhc9KiA+xkfcfy5q1EljeEApP0loA7M
	Egh89OGQYd+EMzF95FpkUoBvIUExggllRO0eJF5LlczOlHagnXwEIIgULNzP2TAmCOgxsbjVPNg
	6Sc1Nj2P4JKcYKEK+IaK6QZAbQFMuNgYKpClm+Y4VbSOamZ9wINQq6aL5UD5NQD6/MQfrEdXxy0
	jNGlAiMz3B/J/amdvonP3zOMbn2/XqW80MqCSFCUkgap4hCKMn7TNEvfMc4scYHz73Le1TxinYD
	UGox4t0sIw==
X-Received: by 2002:a5d:6da3:0:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-390ec7c8eb6mr11963050f8f.5.1741023195328;
        Mon, 03 Mar 2025 09:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0GmDlZsbzQlj1pj5FfLVE18PQfmrSwJDhwqCdM5eQRgnv/LJj6Wq+AmT8QxKX5JIr/1sNZA==
X-Received: by 2002:a5d:6da3:0:b0:390:e9ea:59a with SMTP id ffacd0b85a97d-390ec7c8eb6mr11963001f8f.5.1741023194570;
        Mon, 03 Mar 2025 09:33:14 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1514:ea00:6409:9e94:fe6f:3eb6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db6csm15218056f8f.91.2025.03.03.09.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:33:14 -0800 (PST)
Date: Mon, 3 Mar 2025 12:33:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250303122619-mutt-send-email-mst@kernel.org>
References: <20250302143259.1221569-1-lulu@redhat.com>
 <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NYMUM50oDYMPU73I9Y9D5q-kU11tXzd_zMJGFg83Ra0_1741023195
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> On Sun, Mar 2, 2025 at 10:34 PM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > is disabled, and any attempt to use it will result in failure.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/Kconfig | 15 +++++++++++++++
> >  drivers/vhost/vhost.c | 11 +++++++++++
> >  2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >           If unsure, say "N".
> >
> >  endif
> > +
> > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > +       default n
> > +       help
> > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
> > +         userspace applications to modify the thread mode for vhost devices.
> > +
> > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
> > +          meaning the ioctl is disabled and any operation using this ioctl
> > +          will fail.
> > +          When the configuration is enabled (y), the ioctl becomes
> > +          available, allowing users to set the mode if needed.
> > +
> > +         If unsure, say "N".
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index fb0c7fb43f78..09e5e44dc516 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >                 r = vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >         if (ioctl == VHOST_FORK_FROM_OWNER) {
> >                 u8 inherit_owner;
> >                 /*inherit_owner can only be modified before owner is set*/
> > @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >                 r = 0;
> >                 goto done;
> >         }
> > +
> > +#else
> > +       if (ioctl == VHOST_FORK_FROM_OWNER) {
> > +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', return error */
> > +               r = -ENOTTY;
> > +               goto done;
> > +       }

why do we need this? won't it fail as any other unsupported ioctl?

> > +#endif
> > +
> >         /* You must be the owner to do anything else */
> >         r = vhost_dev_check_owner(d);
> >         if (r)
> > --
> > 2.45.0
> 
> Do we need to change the default value of the inhert_owner? For example:
> 
> #ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> inherit_owner = false;
> #else
> inherit_onwer = true;
> #endif
> 
> ?

I feel it is best to keep the default consistent.
All the kconfig should do, is block the ioctl.


> Other patches look good to me.
> 
> Thanks
> 
> >

