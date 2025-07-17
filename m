Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5011712
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755789; cv=none; b=CcUh9KU3qQUR+clTp//AMF5oUwun3lBigMHnKfnqhNyJTQU79d6Iaztb0beiJG9YU9vHM2hb/QjnHDgz/W/dEzmsr60ZN1UVXZrOWcvuU0vO0EVMdV3MwfjwrZTNSLOm9rSjclqMlEtO8l0XgQ6sAn2rwZBWsdEk+ACrPLPDfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755789; c=relaxed/simple;
	bh=Wtc/lxX5coOhUl/u4HrUWPOM3H90E0+70wFaxMF7Z0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOU1k4hDhj6JqFIP1OFwkxx5xvPQI7iCUzU14tKMKr/fE495K4w2tlEpp4hJu86B8pX59TYzoK7tZM0Hh12ElXB4VhQ0CTxWVTP90j96cCjhnW3fdDyUTFAPLduqWWQGvDsUbpKnR0sOq6+vH9wxCHP3yCy5cFpcyxky9y982sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrDtgp/l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrDtgp/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752755787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjmlDzzaGZ9rTLi5Kx9j22e46U0IOmOFefScvfSSAnA=;
	b=BrDtgp/lFDpA0KMoJPn4kpTo2B3TOt2ZMyvG087S3e/KJpNM8E2jWwCNFKtre8hytqhuwn
	/OkXhw+AjQzLipF9SH1xgVgTI6kM9TogZvDrDruJW16xbY/sOsgoFmfUEoinql1bkEe8GL
	50xyWmsW8GO3/+yZme8IoHrsItjFFmU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-_HHWAGYZMLuvCRkLCiVpTg-1; Thu, 17 Jul 2025 08:36:24 -0400
X-MC-Unique: _HHWAGYZMLuvCRkLCiVpTg-1
X-Mimecast-MFC-AGG-ID: _HHWAGYZMLuvCRkLCiVpTg_1752755784
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e8bb626b2b3so990704276.1
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 05:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752755784; x=1753360584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjmlDzzaGZ9rTLi5Kx9j22e46U0IOmOFefScvfSSAnA=;
        b=MhFrLs92I0xOt/tvQPOQCo+LFEelE4mMWWAB0F+WjDDkRr+MFyv3AAihIVsm0cpk74
         0bq7TSiwwJo6fzVc3Ty8AS7asf3urGPJ8disrvBTGL/gfzCRpyjiDzR4nsOHe2r9PpPm
         xJEZ7PUqP7H0RnpvzBLi1N+pxNkaesQEHfJ7qkPcrOmGUxTNQQAMfryn9JYstk3H9EzF
         oSUm4z6xI9CRds9fZA8Eaj1UaB6xRG+j9DPX35vBA9umk5/QJIdYHZJhxiJhyCrT0+aU
         pk3wH01Sg2cLXHtB5DXEbUgr9bcyk8sjY05RC2I7CyKimO7gEQgyXxZYD7eTfU0HRxoU
         4iBg==
X-Forwarded-Encrypted: i=1; AJvYcCV8gnAxobQLE/YS/sME3N/NAm4pAqSKezbS4rJNW1aaeC4s8KhMlxGEWZY0kJTYCxM39YveFrGJqNvmZY+vHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzX4r+2tNhJPTubuoEaPj9v0N0ivzdR+2iFj9GiLWcl/neTXiXu
	Oo2iVOsMf4e83ytwxiGTH3khmyu5i+/kmT7oBMddsHj03eaHc1wiGIHQeR0b6NftK3eDM4txFxx
	5GeFYiUusxF5pRq4dCqOpkNRVyLLYvJVffuphGL7EjXqkO0PwP/mWwWvXQEOJp8/CM98RqXVb2n
	ZbcfGZEDML8MzV2LYW0LLHJ204QKyCr62cWAfymPM5rR8=
X-Gm-Gg: ASbGncsUsRxxSLUL1T2QTJ/PM91jwuPNQnz8wv8bcQJpmoORvNFcMoMZcORkKpdFZAK
	J9EC2HhMYnIG4K9Q3TTVtAVaDRqHA58YQrMTXrPs0UCusgtBu+NpRx3DIMYOYBf3ZCF3UZR+KAU
	oapAEvDCqIKTdD/lLExhFw
X-Received: by 2002:a05:6902:248c:b0:e8b:bd51:f499 with SMTP id 3f1490d57ef6-e8c56d62b9bmr2917309276.15.1752755783728;
        Thu, 17 Jul 2025 05:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmzgzsBFJaqPrJKGrgO7xxomhF5mMyGas/UFwKiQJ4GPBsQUpF11VlQotlrI8QAyk5b0oSkOjaa9152R8A3Zc=
X-Received: by 2002:a05:6902:248c:b0:e8b:bd51:f499 with SMTP id
 3f1490d57ef6-e8c56d62b9bmr2917267276.15.1752755783217; Thu, 17 Jul 2025
 05:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250717090116.11987-1-will@kernel.org> <20250717082741-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250717082741-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Jul 2025 14:36:12 +0200
X-Gm-Features: Ac12FXzyUippo4ZuOkqcubjMy-uJlrmKG3BS-ASFjib8nJb-gGmmbC75MdR5_BE
Message-ID: <CAGxU2F6Jt0zT==4KfqCnC2nhptypZaEjOYt7ufeYDWdm-c3uJA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] vsock/virtio: SKB allocation improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F5_cPdyVVBjrTmgNiN2K4RhIix4kuUJVT69C_W9YiUU_1752755784
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Jul 2025 at 14:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 17, 2025 at 10:01:07AM +0100, Will Deacon wrote:
> > Hi all,
> >
> > Here is version four of the patches I previously posted here:
> >
> >   v1: https://lore.kernel.org/r/20250625131543.5155-1-will@kernel.org
> >   v2: https://lore.kernel.org/r/20250701164507.14883-1-will@kernel.org
> >   v3: https://lore.kernel.org/r/20250714152103.6949-1-will@kernel.org
> >
> > There are only two minor changes since v3:
> >
> >   * Use unlikely() in payload length check on the virtio rx path
> >
> >   * Add R-b tags from Stefano
> >
> > Cheers,
> >
> > Will
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> Who's applying them, me?

It's pretty much only about virtio/vhost, so I think yours is the right tree.

I completely reviewed it, so it can go for me.

Thanks,
Stefano

