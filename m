Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F4D515
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018801; cv=none; b=KHyNYwe+zxjvT5NVvdy9RW5ddqfcwcSkDC8Gvsf/Te0fzKuJ1DjU8QrPaSHBKsK8LrkJc4VqUsTSkIxmUpem740Ausz1LugGBbM3bIi0ag7KAATewT+OyguNytpt+M7NRGE6BYCGbQ2p/A5CxmMMF/TnyLbq3Xz2EXWpASE0Il0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018801; c=relaxed/simple;
	bh=megv8kjqooQLM1LiiG/kSBFGq/XM7K7Yev+NGYD2q24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4d+Ncp93bPllbuwpobYA42LPWNwXEDM5LBoWULPzEFMh07jOT2fZ1a3XzZGsoHgYbYq9PFvASA7uXep5ezjhMQt1uzMnuSXvVJxKj2XnFNCsjJzWPhqGeocM70/1MYgC2u2j8xWdmr6NpQzFKhJggGjuU69Nl9eeUJU7wpiFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwFsJy/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwFsJy/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761018799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=megv8kjqooQLM1LiiG/kSBFGq/XM7K7Yev+NGYD2q24=;
	b=KwFsJy/X3tYf+Mq/nq1qcWEfmfHyFpGRuj1/Mfw8vHKlBysiFu8GubM6BPa4Ob/zu/Kn1A
	P5mohyLXsXtzkM+sg9ZM6jCW17+Guuv8h/3SP+WPCrXia0uVmT9fXQw+eYqzS1OGIzHmV/
	b3Fr2STyhftFFCEHz4EDvUL0Zlw/LvM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-R0IQnwBVNM6oBEyhnOkLPw-1; Mon, 20 Oct 2025 23:53:17 -0400
X-MC-Unique: R0IQnwBVNM6oBEyhnOkLPw-1
X-Mimecast-MFC-AGG-ID: R0IQnwBVNM6oBEyhnOkLPw_1761018797
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b55443b4114so3099850a12.2
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 20:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018796; x=1761623596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=megv8kjqooQLM1LiiG/kSBFGq/XM7K7Yev+NGYD2q24=;
        b=wmt4Nwa2IW/r2EPaWUuBhyK7bZ9U5Ihc5UOSXFQsj+rCNsdxb0LLfIcgcclZ920Gdp
         hR+l+D8swmzoRHQY5gZdJh1DIcZlUF3bR4v61d6pxnVP0fAzyz493XEQUkx9AZ3U0HSk
         gGc6ud4q5RIGPA66a1gowjq3rOGTEAUORzIE1/DhkI2HeMOZlJ612FTYJ3oPoz8EdDHF
         FuDtVzS/SiP592pnHqdszOjvYIl2sLXa2wGu9hRj2aGfQM16NVHknDerQD59Y/Fq6Xh+
         gXFpaluJaqSgTbixecvcWs4ZMOMmer9YhuUSuzKr074GNQKya5Sc1HDG5qfdemT3/6N0
         gxtw==
X-Forwarded-Encrypted: i=1; AJvYcCXYijZja8NN6Payi9p3jdVAY6Pi6JVFh3MXdag0cpJpWe3rX4tBriFH9XTbZrgenvXna7hW1YW5hu4DFVS3AA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYHgDmloWDRYKR2EplnPjuAyhs3NBJ3L+HSqa5pCMpuelpv8sX
	jYKSBC1GTK9Yqs97oOD0OC3wFW/Z1wpXz2VEu/etJGcZCBkifGFRikQpiMVjrdpnNGjOggkf3pL
	DwLM4mBT6hmUDBClHprnWB9GYaWx8E/7eDRdw3hqD76j45lTar07HJo02wIr+DDeWOw90EQc9oz
	BCKE5d10VDhiHF1kaCmAKh/Nue4qHL4CQzN8bbqhgcC6c=
X-Gm-Gg: ASbGnctu80il46r4Pml2VO/MFuQLXFWbiKg9Fc0sPFNJ7CvgCz/3e5jpICzAYg8dFK/
	A6qOmHrcDSfQu9b7rAlhX9/BOYIAn+aeszQLM8EI+YgTNX9f4QGMI/GRLWvVoowv5O7fgVsZWSe
	rmGXPSg2fq8ocd6nZ62GnMxzW4bo8vOZtUtTLN5545YSgTI7AbMsWdJk5G
X-Received: by 2002:a17:90a:ec8b:b0:32e:a10b:ce48 with SMTP id 98e67ed59e1d1-33bcf86c996mr22095234a91.12.1761018796676;
        Mon, 20 Oct 2025 20:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi63QOhdHl4+reIhpkfkeZ3DFMCEMmLNOYUhqCbJ0GGlA69CO3fwpDd+0dlzdH1WDw4MmaLl9VyqbUS+6tor4=
X-Received: by 2002:a17:90a:ec8b:b0:32e:a10b:ce48 with SMTP id
 98e67ed59e1d1-33bcf86c996mr22095216a91.12.1761018796279; Mon, 20 Oct 2025
 20:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-13-jasowang@redhat.com>
 <20251020121235-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020121235-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:53:04 +0800
X-Gm-Features: AS18NWBgdkWVsfyCxmNXmG3s1Y-9ydjIcrYq3r5CHZCpP7XV_l0SWs9P9nh4UAA
Message-ID: <CACGkMEuXrVnO_TdVrw5JRFeBaGgW0U_KEWMcktj4JtBgNH9VPg@mail.gmail.com>
Subject: Re: [PATCH V8 12/19] virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gIp79L_Ukw6C5rriwq5RFMYLUgkg_7m2bO3PgDvLluE_1761018797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 03:09:56PM +0800, Jason Wang wrote:
> > Switch to use unsigned int for virtqueue_poll_packed() to match
> > virtqueue_poll() and virtqueue_poll_split() and ease
>
> and to ease
>
> > the abstraction
> > the virtqueue ops.
>
> of the virtqueue ops
>
>

Fixed.

Thanks

