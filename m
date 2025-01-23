Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ABB70815
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597046; cv=none; b=VwQBNpkbvo55dVRMIysldGkKcLEc5pHRKiNKSpaSoPP6So7an1pa3OiAXSeP/f2FIAUn+y6I8ewyWfba8UJaeV6fnOKynzFwSOHtzDwG9FX/FEfliSaKGmckn0b1sPwjWPG6ewItZ+/IrNzHNVqbsjaJwGvjTODzlJBI8kvX2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597046; c=relaxed/simple;
	bh=3n3H+7iyk6t4XY2vTe1ZAQYm+AXFTnWWxoR2QRS87BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnPfFB0bpPuazNubyjv7SOPG9frhRJAp8lpXp8m2zDDQUkliP4N51KV81o3+jA9tbTtXzi0khqmyURkTcVqgdgg9cmu/K9lgTKt43EU4RQ3UidsB2TsiswKR1GdNsHVtokFkm43M1RY/XdBdCyQmsFXDOoVCqz6/odXU+zag65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EocR3Scg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EocR3Scg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737597043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3n3H+7iyk6t4XY2vTe1ZAQYm+AXFTnWWxoR2QRS87BA=;
	b=EocR3ScgbkVXVpbB+QWfTVN10WjpQ97m3zLEzOO3BdLywu8vZQtP4UgwhNbyGGdutNskLs
	uQzOEM/QdmFvzmj4IuoyB54rcNdbVqhoWjbD26uQF/5gDbpQIv1g27EWyynK589H097zyf
	cpwtfN/2/yWXHYomeT8FAmT075ffZzw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-B_3D5MDPMZaSqz99pfo1vQ-1; Wed, 22 Jan 2025 20:50:11 -0500
X-MC-Unique: B_3D5MDPMZaSqz99pfo1vQ-1
X-Mimecast-MFC-AGG-ID: B_3D5MDPMZaSqz99pfo1vQ
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21650d4612eso9297425ad.2
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 17:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737597010; x=1738201810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3n3H+7iyk6t4XY2vTe1ZAQYm+AXFTnWWxoR2QRS87BA=;
        b=M6yNYTTX4IWcpeXdEvOrGvXym/TkzEG0hbbEkXA4wSkxgizf7+DoJL1hpxRU70rrgI
         YWRCWr16JvntshP7vcV4zfBpRwV8qmN6estONfxVNYoZZFkwc9v4+zq+sbOOxFt7XGPG
         2H0Nn9DcZTsBmj0gqZSyIZcsRKScm84qAa9BgyBwaumWtOlVk08MF/WsrjtA3+oJTvcH
         B4Bc8FwecQs7FLREilgVHvM9j6CVW1CdLgfcmEBKWptuAes3n0eGelP8rr576+KA0AvC
         yXy7eN5joWwmDPdDYWUTrg7Tu5glBqx/yoJQgX1S6ejvaKzOU8rMQYs5kBEKl1QbQp79
         cFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdUBNkLVicDOQ30NE1ALhe1x5NABoPcnKiUFkFiGSpjP/XX1e7k6DlOxQS1vnMzUfsXBpvRcWEqNRWIaMiKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPNgh4Al+YuEBWPfPHW8zsj1fGDL1Z5J33YKg3P3GG80piTnFs
	VBIEYZyzR9lTigNA0ZZ3zK53kf3Rbao8B9OfwnYJrTy6ikcCIbrY10e5k6fFrxDAIbnI3Xf1LlI
	EOkns3+lyhx3EPVjR/qrdWz4qv0WvV9r3HVkWlurRQuK8sp22BiW40e20+XK2X/GeFfYPYE2ADp
	CPhzZceo8K58gj4kkpkyGNac6pJF4uKCvmCnpZmIc=
X-Gm-Gg: ASbGncv9BOI5Se3fZzEDE2930Uz0eibI7F54lwOeCWm3wZDoOsATuYVwAI4SHsdqTvu
	I8zvGdIXbECcq/H/w10XlUHezY5n+WE2mwM1v1V8Paoi77gd6oA==
X-Received: by 2002:a05:6a20:258c:b0:1dc:790e:3bd0 with SMTP id adf61e73a8af0-1eb214a0923mr37096965637.15.1737597008380;
        Wed, 22 Jan 2025 17:50:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEV177w+G+Dx2GnHIQbUn/6A0i9Y+/AsYFRY6ZPRmEtlKzDhEFsiQiAW5PWlPi97pcw0eF5UrYgYVJWVWkWTpA=
X-Received: by 2002:a05:6a20:258c:b0:1dc:790e:3bd0 with SMTP id
 adf61e73a8af0-1eb214a0923mr37096936637.15.1737597007937; Wed, 22 Jan 2025
 17:50:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121103346.1030165-1-eperezma@redhat.com> <20250122154908.GB178738@fedora>
In-Reply-To: <20250122154908.GB178738@fedora>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Jan 2025 09:49:56 +0800
X-Gm-Features: AbW1kvaie1-Dpyu6eD1OrTjn9Roc4UODiWG8hjuxAhkCGoPMeybHxILnPwu_oko
Message-ID: <CACGkMEtdMzr1chpneCTnpjHFKaN5YSZbsVjSLtHSt+ULpUHG4g@mail.gmail.com>
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, mst@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hanna Reitz <hreitz@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	German Maglione <gmaglione@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OlKCEswNELA8spLi8iU0fHAXTmPJxbm8Njh3np6C8TU_1737597010
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 11:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio P=C3=A9rez wrote:
> > A VDUSE device that implements virtiofs device works fine just by
> > adding the device id to the whitelist.
>
> The virtiofs DAX Window feature might require extra work. It is not
> widely enabled though, so must virtiofs devices will work fine with just
> virtqueue and configuration space support.

+1.

The DAX Window may help to reduce the bounce buffer copying and fit
for the case where an AI application just accesses one single large
file.

We need to consider implementing this via VDUSE.

Thanks


>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

