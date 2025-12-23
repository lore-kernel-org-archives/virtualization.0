Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1A1E5B64
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452746; cv=none; b=g0p4dM3MevzHSNlLMxiexGHjFqIq7NvCWNWefuEwr4s+pQayfhNTzzq44eyTTteSvsthY9WaXnwwDMIWrmwtp3UZTphp3LyB8pIi7Inw8i0VGalZ31h3f7rPg6bILo3Ua6dJ/Oh76RDlgVco9y2s1UmMNucxYR0wxEpANpu/mI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452746; c=relaxed/simple;
	bh=DTodI1MZvkchrk+G0XCOJ8q+7vGUEdY5mPbp3QX/j7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=feL226FJBBKwAzDJMJ/E9zJoEIzip5RIdvJdeoiHDu6diTYW0MRn2/5Cr+1zTtK67jgdZWUfo1Mh70096Q9gxpGt9EcvbpguWe9p/0kW04P42poj2fWCIUO0L2aO6UyM6U08WM6CkSLk8NaWxLoDEk363pG4yeZpBVzPGuae4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7ACpjAW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7ACpjAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766452742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTodI1MZvkchrk+G0XCOJ8q+7vGUEdY5mPbp3QX/j7M=;
	b=g7ACpjAWeaofAY0TE4+q2xmb1FwGOyPF5TUY76+biwaokgCUPhTm5Zvz9b+B/THlXEUKPI
	ahMq+cWj7TBbKwFZx7cxYMXU9pvkx7pVnPQnocRDkaMqxFh37wPby3XryETrHI6TwNue0t
	54YRg1gacpyWJIGuGBT1njv3iSov+50=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-yxYvSQ6IO6a7zdiqMZPCFg-1; Mon, 22 Dec 2025 20:19:01 -0500
X-MC-Unique: yxYvSQ6IO6a7zdiqMZPCFg-1
X-Mimecast-MFC-AGG-ID: yxYvSQ6IO6a7zdiqMZPCFg_1766452740
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c5d203988so9467799a91.3
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 17:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766452740; x=1767057540;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTodI1MZvkchrk+G0XCOJ8q+7vGUEdY5mPbp3QX/j7M=;
        b=CH5K/9sk7J90+LwNB0mZvHfcDHtLizDkBUYQNTPMnczazi5o+LNdS7HsDdJJ/o9fey
         XU9VRiEIEhsU0sO61ESmJJB/c42XppfipGOcLdiSyQ8GDdSYb3opIuE203cWkz4Oo2gC
         C2behDxPT7aSqTYdVEzd7lRvHlvMXWJqP7EM62Fy3A/JGaQCCMbtwWhQrg+N3dffnP/5
         Ce6O7Fm9QjhQKOx3O1L3G4gcHDnmHqydSJM2XewOnrYwLY33g22OendwHLr29NqM6fla
         t10/qjvTUU6CyzoLBLRl40HL4DkVqQmFVITAhiYwZP3TcroVDoKnEQ/Jiqu1t9Lk3d/l
         v5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjQTiBnParuwIy4/f+lQqYemio1qm2G3vrdFeJocwH2b8HRIMuGLV0za11jeXbNBF8RlZ1IC29SoBKtNvVVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxefL88yGhidtRS6cFhF6u0N0ATIXvqpPUuNpfT6jbw/0Z4vPZ
	jJeRSRuglP2AfkzELg+TeWWSS8foIUnEfmaURndFOa3PkfH/qliRUrdwHKv/ExzTw6dESm3AjuD
	vibsO6/MXG9xiC3smkfR7MzZP16s7QKG55R84jP94acbR0MHIUvSds1MripOEBE5xXGm5oR5wtT
	QFTaxUrK4R7MEHkTFlMkCuoO+2mulWlMF4gB4Jw7y9YU0=
X-Gm-Gg: AY/fxX5elBB7jm1Gfx/XXaQKJCsPsbCdbV8lyitr0pSHqv/5O8QmqZYWKPIcAl1F3lZ
	IpjSrjdrP2Yw5NtKjEXXGnJUdYH67JnQ2rB2wdt1yQvc2QELidyWvZ98lHuy7VAOZPOPGZEHqJL
	ZB3cdmdzLth9dH676MJPESO1rjg1Pk7LNecVgmpIwLit9ECxbI3+8+d1ztMA6Gv/iRu24=
X-Received: by 2002:a17:90a:8c87:b0:341:b5a2:3e7b with SMTP id 98e67ed59e1d1-34e9212f341mr7925169a91.4.1766452740001;
        Mon, 22 Dec 2025 17:19:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHcWKYqj/ntPEhhK5Mb83KMIx3HoI1cz8gSCTtoaWzh/buXasofasb9dwpRcqtmMjZreu9i9G2Y+BiWqdzVts=
X-Received: by 2002:a17:90a:8c87:b0:341:b5a2:3e7b with SMTP id
 98e67ed59e1d1-34e9212f341mr7925157a91.4.1766452739605; Mon, 22 Dec 2025
 17:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251125070838.70736-1-jasowang@redhat.com>
In-Reply-To: <20251125070838.70736-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Dec 2025 09:18:47 +0800
X-Gm-Features: AQt7F2oICIHpSYWtU89Im0tHIKEUPdjZChnnJatBYcNbjdrQvxQg_EfXiCF7W40
Message-ID: <CACGkMEtjvycsK0JJ0G89SRr3FTHgaMTU9nRZNqqv7=yxiTqgAw@mail.gmail.com>
Subject: Re: [PATCH V9 00/19] virtio_ring in order support
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nTqC3ob-cN3aFSuy1r5x-QEeakbSd1nDLtt5cMw85WU_1766452740
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hello all:
>
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implemented on top.
>
> Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
> vhost-net/testpmd on the host.
>
> Changes since V8:
>
> - Rebase to vhost.git linux-next branch
> - Fix issue when indirect descriptor is disabled
> - use UINT_MAX instead of vq->num to indicate no batching is pending
> - Tweak the comments for used_entry
> - Various coding style tweaks and typo fixes
> - Try to use in_order varianet in in_order ops

Michael, any chance to make this for this merge window?

Thanks

