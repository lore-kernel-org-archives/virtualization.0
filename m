Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F05143C48
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930743; cv=none; b=N77Ic2w5Es6y6sqKfppA+i6NgeR65yWoHMKkJe+Q9IFPACKS5gDCOqxmHRkk64BFfpgFhFwy5QGWLlfVSPCBcViOpTivyS8DKGI1ipcJYMn6+h6WfxMtLeh20F67+tzo2Zlclw+8mNV+QQ6jzrrgMIzWm2DSTi+oCL5gJwBKwCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930743; c=relaxed/simple;
	bh=PmFXyGv9ORkds1kmwcp/v+wglJVZcoPaTmT0j8rNGkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5Szbc5TEv58EykEIer+rb/VrgSo39yOtCP8eG6vfzbFJNZgQRpJtTIbChv3DdPdthA6NhOScebJ8jfonwEakl5YWEBSi3pVfTnwHQ3/LBYHWvZVXUbZsG0KLW9VjoSc2TsG1jw9dSFzh6AKNhAp+/RQ1TqhULFg1kkaKVrEkgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mn9PKEjP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn9PKEjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713930740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmFXyGv9ORkds1kmwcp/v+wglJVZcoPaTmT0j8rNGkw=;
	b=Mn9PKEjPujTOkUV0ei0eKsZpRseijEy+HhoCaNsxPtDg8D8f2FzI8iISj1sBzbezpZBqb0
	Bm2TpxDG/m3/QrSUaT3k0FqJyhnP7aG2QrI4xxdSYAmyYilRfD7fC4dDyuvOEDyFAW36YD
	ixUAg8l6RXhY9FlySRfz5mdpKgeTtXE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-PQl_ce_QNBK5rQGg7owW6w-1; Tue, 23 Apr 2024 23:52:19 -0400
X-MC-Unique: PQl_ce_QNBK5rQGg7owW6w-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5f7c0bb1b95so417344a12.0
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 20:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713930738; x=1714535538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmFXyGv9ORkds1kmwcp/v+wglJVZcoPaTmT0j8rNGkw=;
        b=EKgdIstQ/NoUjkfJyDkr7FiQoR3giIZI8n6Vs82i9BmtBG8BlLZtNAutJLxqE47Ho9
         LiH4AAlCMWBnCR1jGdyEvGGDkDCBrp1gIFVAII1j3nyoBpQ5QCKSfFyjeg99NrQLHuaA
         OVQAsfsokqNUyuqyWGLG4r18m0wV/mK71a70dZGUUwRmXanNUAasR0zIaUZaVxNZgz6C
         sd1qN6f+GxG6X9Vbc8h92BzF9E4nk+TNanGGFfInjAtDzK6Ja7EFsT7uHKkLR9nfHQL4
         Q4h+WGG5Dxmx0wEdh6JXqLDN7t6cbT0/jWSVoUR6Fvdas25pUgY8CoMp7JE9/ZuQ8DGB
         GNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVuHejE//XGfFPVUdzKaymbSRdKhXNWmGr1lj0Al9jTsS+Jfb+znS1nIvBwv36Av4LV4epFILEN+/xi4myb+mDnFH0+1/vKA1SId23vz0=
X-Gm-Message-State: AOJu0YwSUUi3XdoAx+mM2G3q+qmjgq4NobYiFIv4r4xQkQusdLK5Y26g
	oByIdrtQr0PuUC+cfashk23vIIQXsbhM9vrzT8XqXLdE6ETaV8riugzTG/V4CPAVuWK1WbHIoM7
	tLF48IKVJWpGLVt1hX+mT24OGB5YR9yz+0CMFRhkiJKLuFdz5GX3KQU1Orq7QThJlDGaPy+AxsW
	9F/ercv65cqYUusXFuNmvzRQIy305woYwWl7g8g7Y=
X-Received: by 2002:a17:90a:5513:b0:2a5:be1a:6831 with SMTP id b19-20020a17090a551300b002a5be1a6831mr6312911pji.19.1713930738068;
        Tue, 23 Apr 2024 20:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFLrt3g5mDa/U40wi6cTIapOPrwgf/9zjhcS2nWoXd7w7CUZDb45+Ebxt0xxbOVlMJuued25HbftoqyRRiNhs=
X-Received: by 2002:a17:90a:5513:b0:2a5:be1a:6831 with SMTP id
 b19-20020a17090a551300b002a5be1a6831mr6312888pji.19.1713930737759; Tue, 23
 Apr 2024 20:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com> <20240423113141.1752-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240423113141.1752-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 11:52:06 +0800
Message-ID: <CACGkMEv5di6XvjbgSq2Qz1f_SBK-sTiCyTRer8CvoMkuAWkaaw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/8] virtio_net: device stats helpers support
 driver stats
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> In the last commit, we introduced some helpers for device stats.
> And the drivers stats are realized by the open code.
> This commit make the helpers to support driver stats.
> Then we can have the unify helper for device and driver stats.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

