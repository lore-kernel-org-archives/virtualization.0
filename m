Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647A19AD8B
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804220; cv=none; b=un6MbkhuFDdN228b7FGnjpLx5FMY81DOkiyaUGWkppMjp359QbDEDKDSIcN9Cb5U5bFeDpN43z8t39Sl6ClfAiaOG1Rn+3BYN1s9D6DupPrTIiJzasuD7EFo3t6hN5ZDVgyOyar/iyI1fV034XnXQXg/qM/RTS48DRD7o9R3iJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804220; c=relaxed/simple;
	bh=c63fwpPYn/UC6V1QVCLdZ+6TNv4aJyxhGZnsBQL1Jrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Miujk7gDGqYV+XSrc8c3avFgDeuHKxDju5q0qwhR7RnlMuN+sjv7NG6cXUPta1kT/Nrp+LfjCBkKX1pWzVaQu/ZfsCKEPVilGhuxS/MsGKYbUuOVHq5fLNOFucXzB+zt1qia/sQsL3jBEbiByPNtKpAxmYFJ5GNAzxvbtpOmOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htYWB3m7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htYWB3m7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768804218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c63fwpPYn/UC6V1QVCLdZ+6TNv4aJyxhGZnsBQL1Jrs=;
	b=htYWB3m7V/zsGpOm/7CbDOfRL697XW5em+EE0BgvsveFVr3RFxHWvDvs/pxR0V740QbHdl
	cvKj/GKEbbCykiZ6eLV5aUzXsM4bICUnP3ZSz479DPhoNwUDiQwsQpCA2MVmbhKsZLIbcE
	NqB+L/eXjAa/kjgDb3r8ySGQl/SB3F0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-VLJmMAouPsivbUnvt8ZUKg-1; Mon, 19 Jan 2026 01:30:17 -0500
X-MC-Unique: VLJmMAouPsivbUnvt8ZUKg-1
X-Mimecast-MFC-AGG-ID: VLJmMAouPsivbUnvt8ZUKg_1768804216
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0e952f153so92512765ad.0
        for <virtualization@lists.linux.dev>; Sun, 18 Jan 2026 22:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768804216; x=1769409016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c63fwpPYn/UC6V1QVCLdZ+6TNv4aJyxhGZnsBQL1Jrs=;
        b=jGwyO5aRUxoGhjiiM+HDCxWnUbT00vgHB4ckFSFXlpNYz9kX4d5pxWAcaWbzicDb46
         dzbh9I+uA/+ywxIO151HJ1Ybu2eXQdlaY2cyvMs+1p1ByeLJqjGYu6VWMctO4gpfCkKM
         F53LujdIFh152i2UIOlFOJj5qMCsblT7hi6QRRBcnOq4+6Tg7onhIJiydGwuLx7m7mij
         bsbYHiG0cZN+Nn1lsh8U4A993CZUZe+HZXjKdzEKzyMD3RhDnVk3EVzo8+eyOf632hIe
         eIbV6jO9aDX4OLa7jTk8pBnDFWGVQ7/yrehNGGd0i6dhSOEJelvB+cy2ajr3IE+OtBSo
         Q0dw==
X-Forwarded-Encrypted: i=1; AJvYcCUrGdlIc8hm4P9Rj2OHh+K1qFkt8tqrZrDSD5ueuMACWzhMObT5eOoe2ZyoZPXK05hg9TlO9ueu7gSimzBtWA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4TNg+FTkIuayHgKjHOD49vgDpeBCte4kn8OmriSZLEplNsMhS
	Y305du3uie9HxB7XabzChg2LJm8HcAdJ7g0I6X6Rz86I4bmm59VhjtD+32VQbqRe7p+Ii4YabfI
	LuxQCEeQOpq8q6bZrYMdtWJVqIRU5+saenP5uuNn2UzPc6u2mKU+0SVEOfMyC1xnTZ9CT85vCap
	8qoBM8nzPqI4CgBHS97SSvep5/+BPyaxWUpCu2TGDUfNY=
X-Gm-Gg: AZuq6aKoE4r2B6ke0ufHbcjlTzPVEiFObGDPyd8jpcWRcmqNJeV3eu61G2sZzNNF06s
	LE1wfSbE/KjVWVNA7G/RqxFil5q80vlOzfvtikjj6D8usQ79oWOHMGl+rNUqDx6tMKMx65vlZXP
	ueE4HJO+SIp/ufjUCBV8TMOSWlmRyBoti0MLxtQspAfdQejBndNjkJi7P0fW6AUGBQ63E=
X-Received: by 2002:a17:902:ce10:b0:2a1:14dd:573 with SMTP id d9443c01a7336-2a717554da0mr99790965ad.23.1768804216218;
        Sun, 18 Jan 2026 22:30:16 -0800 (PST)
X-Received: by 2002:a17:902:ce10:b0:2a1:14dd:573 with SMTP id
 d9443c01a7336-2a717554da0mr99790725ad.23.1768804215839; Sun, 18 Jan 2026
 22:30:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260116140455.1560491-1-eperezma@redhat.com> <20260116140455.1560491-6-eperezma@redhat.com>
In-Reply-To: <20260116140455.1560491-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 19 Jan 2026 14:30:04 +0800
X-Gm-Features: AZwV_QhswvAgnDRQeohCzIF6x88mQ3y2LsmFcw7D2hG3eKpSCy27fU2RRURQ2fk
Message-ID: <CACGkMEtn0rdvbnR9PrDY=uHY4=Ng1MTuO0TcVD4yzpbnJa5kCw@mail.gmail.com>
Subject: Re: [PATCH v14 05/13] vdpa: document set_group_asid thread safety
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, virtualization@lists.linux.dev, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FUkisUrpELMypYqvhZ5IZ-RBWxbM5l_xvh84LAME3bk_1768804216
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 10:05=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Document that the function races with the check of DRIVER_OK.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> Requested at
> https://lore.kernel.org/lkml/CACGkMEvXdV4ukZE6xhLL0sSN70G=3DAWVQgpRnH98Fr=
4btzMkK9g@mail.gmail.com/
>
> v12: Reword comment (MST).
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

