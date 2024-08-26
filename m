Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D8582890
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653332; cv=none; b=kLo/pDNZupQ7IEuXHiRzfu9SwgoZ0UByNMiVDqSkYz9up7PoeoZz5pV9cOpDxVsQBEcxPdL7paI2n81XzKHYcsCho9PZjVxD1N3IWh4XYtbpwDcWT4aLJfSHthsKFD+E/C4m/PIjBerIZL2t0+LhOLDIanmEgTMICp1P4yt2wEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653332; c=relaxed/simple;
	bh=W/orvY4d+MyuUZyg5aYI8nCoBLSyyGylJt1UrQHKaeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKsnPrBzT7ZJHM79yKtKSO/WzKfpd0XoILErd09K5OL4LRzv/xir/bR/io9wQwKocbJ/9AHAuqVeuL2/iYj0BNwbE8s6fEb58HU9Qizf2sIjWZ0qhhSesE58IKcIvq1Cy6vLS3+r1SuOHXwrLzyGF0L1kXqHPuDhEdhROg9BhOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kaax4KJ3; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kaax4KJ3"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F24D4015F
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 06:22:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UbYbhKOcZkxd for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Aug 2024 06:22:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A42364013D
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A42364013D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kaax4KJ3
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A42364013D
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 06:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/orvY4d+MyuUZyg5aYI8nCoBLSyyGylJt1UrQHKaeI=;
	b=Kaax4KJ3J+lp2GoD4OFIWkgUFi5aByLoYan8LHjEkMCaEqmBCAq3AqpXuorMAJLH+Pl7mv
	ZSgio3Kn4FfkNH65VFtuZ5sSC8fo7/Ju9os8HdXdNt9/y/0PLpgGm/8m1BNJroT5PO5xsB
	69TOnWqcKWdRsIolJYaUURbrMEB7xDA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-RJdqe37ONuGBcdMUODTsCg-1; Mon, 26 Aug 2024 02:22:05 -0400
X-MC-Unique: RJdqe37ONuGBcdMUODTsCg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d3c976e426so4914097a91.1
        for <virtualization@lists.linux-foundation.org>; Sun, 25 Aug 2024 23:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653324; x=1725258124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/orvY4d+MyuUZyg5aYI8nCoBLSyyGylJt1UrQHKaeI=;
        b=RuNJfPJkO4rIxXJ4tacYyhPAXDKIQ2VjH/3gwyQhyU+/he8i3cL41y9aj4TZEXwWuL
         xyXfrsxpWm2TUiAHOSUi0WtTdfoWRlTbkhRIFi3L3CXA80ufp5zfFhEqH3QGT+2upSwR
         pI1VjuTnvdlyja7Uodk7SRMTtxwh8QzSqyxYiW9StY1aQSIdhXSJhS1UYKv14mq5TFpb
         EIxfodAeQj39sQhEszeL1efwv0foOXsxDl+/lvY8QKMZunnkMhGRYJDJXxwTkxKan6Qw
         0JXA4OQIH2u1ZYE13O0JWM7G6TiNX0IAfF88SYU+cJdeovSlmI1uFWur7iaCXHdYJqZr
         AypA==
X-Forwarded-Encrypted: i=1; AJvYcCWSykv0bkeAJEfZb7eLmmbUvQhjKtV5ugpQU9zVfIeIDJOXhF8wvCs25L/pTppXFr0dN2sYqFNRueJkr1MUnw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxDPcoWeiFaLGSberTUeMXsryFpUty2jTItkBSTKxSUDVrgXwAD
	Ihiwuh23/XMrvGRcVBCZyLAUrRGyhLk8B85m5vcK4rYANLR7U5bY5RjoKxFrKe1Snp0GYJAqZA3
	q+pgAQwbFSm90jLH31DPF/8qJPX6FIRxzKRcNkFMYgDPxl+qXAY2wsdIu2IZ/DdWBeHdd/H+8Xw
	8gTYCCix1ya3WadtvrqHbP5xtjBYfx1/j48cyPNAhMnxz/LjNIk1QAqQ==
X-Received: by 2002:a17:90a:4d83:b0:2cf:28c1:4cc2 with SMTP id 98e67ed59e1d1-2d646bb9cd8mr11652458a91.3.1724653324441;
        Sun, 25 Aug 2024 23:22:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXJfj3XOMNpAgzpAtxdEftGfG0TOD+eVj11eYPkpG+vQJ2vtmQv/QzmjFQVGtWIG7U3tOa7tJOLAWR+r5s2LU=
X-Received: by 2002:a17:90a:4d83:b0:2cf:28c1:4cc2 with SMTP id
 98e67ed59e1d1-2d646bb9cd8mr11652440a91.3.1724653323932; Sun, 25 Aug 2024
 23:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
 <ZsV17ACIEelIQuKx@infradead.org>
In-Reply-To: <ZsV17ACIEelIQuKx@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:21:52 +0800
Message-ID: <CACGkMEv=cQqXeLdsM1ivOFvUcG+-eOOwHE_BVQmF_scbqYxUpg@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Christoph Hellwig <hch@infradead.org>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:07=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Aug 19, 2024 at 05:27:33PM +0800, Cindy Lu wrote:
> > Add a new UAPI to support setting the vhost device to
> > use kthread mode. The user space application needs to use
> > VHOST_SET_USE_KTHREAD to set the mode.

I think we need a better name. Probably something like
VHOST_INHERIT_OWNER or others (not a native speaker)

> > This setting must
> > be set before VHOST_SET_OWNER is set.
>
> Usage of an API is a complete kernel internal detail that has absolutely
> no business being exposed to applications.
>
> What is the application visible behavior that the API use is the proxy
> for?

Vhost used to be created by kthreadd but some recent patches change it
to behave like being froked by the owner. So the various attributes
that interhit from the parent has been changed (scheduling and
namespace etc).

Thanks

>
>

