Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC712B87
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719367095; cv=none; b=LwFXPe2zAEZ0WeOA7JVm3P5R2neHFzc9nH8587ORxIxeu5Tsmf0YIcwhYD752GePl4PuVB32rY/L4XM/0bqf+tpdLNWuCB6zac91NIFe7tUHHnEFXHbNF+zoebFVGPEMHnu5sEd9wTXK/GnU2y6YFuI1liwlj8zFGTqpqpJbgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719367095; c=relaxed/simple;
	bh=zWTR1vyMVVMzJwH8R93Ew8aAOmNeGZMlUxUVANDOSQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZIE/YL6uao6i6QTu5RvP8zQXnUewOTE4a47rBzl+zZPDv55kVs/yzt+UiFOOHdDS7JrHH3UIFmOuXMcno7eHNVnyUP1dZVV9puv3dtOP9OAdRQRs9QsXtJwRak9fMbo4Gm8o7wD1yQMRh+8H6yK6oXE8sg+svUMyNER+V0PT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GW2NDDOd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GW2NDDOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719367093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWTR1vyMVVMzJwH8R93Ew8aAOmNeGZMlUxUVANDOSQI=;
	b=GW2NDDOdsB+EwULYAcdW9rGmY1CyPuhkZ5atXGlii8LSvTxyQbY0XIWckjBTgitePIr0gG
	Hz3AC3/pm7X+sCmTyyZa5/nerNcnuhgluODEiG5TNAHratIQfr8/EWhd5OHp4kkph8CZXn
	WLaS0nozxiVSRxA4VlK232/NBDsImC8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-yi6L2oCdPzuibVpyq638vw-1; Tue, 25 Jun 2024 21:58:11 -0400
X-MC-Unique: yi6L2oCdPzuibVpyq638vw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c89d926550so3102468a91.2
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 18:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719367090; x=1719971890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWTR1vyMVVMzJwH8R93Ew8aAOmNeGZMlUxUVANDOSQI=;
        b=wI+vJ4IM9WlszfTTZcXAhi+EW4N5WkWtfMgsiscUQ0erAyvOXQrb4twMAtTvbWTnjO
         NEgqNdHkjxdMYzT2nsDGpOi4oTF/GmZcldkJK+zy4eNH4u1gkYhJqAbLXmfJXVKh1VEm
         FGMXcDmzFwO/vKOKeRSjgQDNg8M1VwxO7ni9CnV6Kxv5Ac63VrD62nonSeRPDWV5+YOz
         dAELdvqV0KvdPsNg9aFWgGXbUHI6t2PFCbEB+tLAtt1zC9V3ehPmBF2K6fOSyDZ9ETCw
         EXIwmMP2CMOY3y/fxdWVHuvLDksrujJ04oNfA7tHIfpnArTR+xRyhiVAeo/KhgH/DBE6
         /WDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtO7V1TV376OjDXUmbi9/PQKEBSqIQvGN67PL5n6wENgf4sYh2i4SZpSHnVI/6SG1LMr4HY8qNmIb8tk9ZMNJx5FNC1NfeaflpR/aDuJQ=
X-Gm-Message-State: AOJu0YwfkqKA66JjR2lGA5lPKB7+I/o0oGPohgiKbI6QSx7dDAJONo+O
	4R4MEx2Rqf3XRC6sPkIvGNxGMz4S0ZUnhAMH1xb0PARbbU4QGZRTuj0bq2CkQbYv4j48zKsdl6Y
	KFEGs+4TTwq/PwnWjtdngwBJBt6Bhy5vEG+qJnWJBBQw55bQ1ie9O7EVs9Y9UsK7tEYabInbSMA
	pKsAozJX9MbxIEnRrHRzVcvinzphjXC1KXEH+4v0o=
X-Received: by 2002:a17:90b:1d87:b0:2bd:7e38:798e with SMTP id 98e67ed59e1d1-2c8612751c1mr7199498a91.28.1719367090324;
        Tue, 25 Jun 2024 18:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB6KboL7MhJ0JTwwWTxldeBEg5zl9FqhRziQpOhbKHYwMrQ+dftittxiaKI4yyaAOr7b7BfpkVUQ4MKdBxcOQ=
X-Received: by 2002:a17:90b:1d87:b0:2bd:7e38:798e with SMTP id
 98e67ed59e1d1-2c8612751c1mr7199483a91.28.1719367089803; Tue, 25 Jun 2024
 18:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240625184043.10658-1-sahanb@bu.edu> <20240625154900-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625154900-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jun 2024 09:57:56 +0800
Message-ID: <CACGkMEvwAiQA6=TWExoioAaC+KFehBTo48L26g7eXwerUsOyKA@mail.gmail.com>
Subject: Re: [PATCH] virtio-pci: PCI extended capabilities for virtio
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sahanlb <sahanb@bu.edu>, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	drepper@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 6:50=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 02:39:37PM -0400, sahanlb wrote:
> > PCI legacy configuration space does not have sufficient space for a dev=
ice
> > that supports all kinds of virtio structures via PCI capabilities. This=
 is
> > especially true if one were to use virtio drivers with physical devices=
.
> > Link: https://par.nsf.gov/servlets/purl/10463939
> > A physical device may already have many capabilities in the legacy spac=
e.
> >
> > This patch adds support to place virtio capabilities in the PCI extende=
d
> > configuration space and makes the driver search both legacy and extende=
d
> > PCI configuration spaces.
> >
> > Add new argument to vp_modern_map_capability to indicate whether mappin=
g
> > a legacy or extended capability.
> > Add new function virtio_pci_find_ext_capability to walk extended
> > capabilities and find virtio capabilities.
> >
> > Modify vp_modern_probe to search both legacy and extended configuration
> > spaces.
> > If virtio_pci_find_capability fails to find common, isr, notify, or dev=
ice
> > virtio structures, call virtio_pci_find_ext_capability.
> >
> > Notify virtio structure can get mapped either in vp_modern_probe or in
> > vp_modern_map_vq_notify. Add new attribute 'notify_ecap' to
> > struct virtio_pci_modern_device to indicate whether the notify capabili=
ty
> > is in the extended congiguration structure.
> >
> > Add virtio extended capability structures to
> > "include/uapi/linux/virtio_pci.h".
> > Format for the extended structures derived from
> > Link: https://lore.kernel.org/all/20220112055755.41011-2-jasowang@redha=
t.com/
> >
> > This patch has been validated using an FPGA development board to implem=
ent
> > a virtio interface.
> >
> > Signed-off-by: sahanlb <sahanb@bu.edu>
>
>
> Thanks for the patch! As any UAPI change, this one has to also
> be accompanied by a spec patch documenting the capabilities.

Maybe start from one or my previous work like:

https://lists.oasis-open.org/archives/virtio-dev/202201/msg00013.html

Thanks

