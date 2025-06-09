Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202CD3A1DB
	for <virtualization@lists.linux.dev>; Mon,  9 Jun 2025 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749433849; cv=none; b=XHcXHjS7AMVNpVHj5SxW0ykRfWngZnm1CRc+dJ2+8VRIP0TrVY/oC7v6s8uPnU0Tj7RMSZhkmmuS1nQgp9eLmlWLXO+b3LL5kjpRRVmmporvkCDOzceJACZ5QgINPfkjv/SYvdY2ufPYe00gOhLUeejuRz6jJ31ixAhzL/AajJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749433849; c=relaxed/simple;
	bh=rTcppCIZ/D5M7oo+6qtZJGHgazXjvpGituGxD9zReBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQZrVPvb9/PZl/9GeNzkMLtfurOWIpQRih/nx0qrcqKK5uRALsi7wkNLavccKTY4ufQWlp62Hq09ig+PlEGfsEEzEPt0O+3GwPlS1anEOUtzJ/RrNMjrQPN8YaIEEw85zW9Cp4eWqvzJMoB1rhcup7NTlR9FkuY+N8v58+pZBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5p8cuAs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5p8cuAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749433845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FjPWKEc2bS/5hBRFVg6S0OJbWFLjXguqy/hbBcildo=;
	b=H5p8cuAsdhKFQ71/o5uxO5jJJx3/jL37r7D5/KdCk/U9GymjjrQWYv0BpFbRX0p7gJQ7aJ
	LpMamqk2cvtDM1U8/Ra0kIX/xCG/y0/BXocizPyBpcEDtjEIo6suCqQXZJ5AQP8tbKs0VH
	V6uWjq1NAVGUaB2I87alAlLVN75JlIU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53--oSNNF7YOwOOTT764Scehw-1; Sun, 08 Jun 2025 21:50:42 -0400
X-MC-Unique: -oSNNF7YOwOOTT764Scehw-1
X-Mimecast-MFC-AGG-ID: -oSNNF7YOwOOTT764Scehw_1749433842
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-312436c2224so5873561a91.0
        for <virtualization@lists.linux.dev>; Sun, 08 Jun 2025 18:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749433841; x=1750038641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FjPWKEc2bS/5hBRFVg6S0OJbWFLjXguqy/hbBcildo=;
        b=oA8Y5tb1nWt2Zx3quhyKjC4FWQlyviz1Ehoa7RA9Dd8NqbgjTJHEIjtxQXWFfBWrZJ
         sZonNpM86KdSUYYeNEFMPaW1HUJ5v8rpMHA4MR2asfOjv11vn1Y87wvP0hiR9/liMO40
         /bZsuoszqN4mEX8M1RZXU9Y5njMigUpSvRXjK0t0KJlChBM6cfukF44gUXmOPmOyttDW
         1Mz0S5oz+CrHhANinx7W7CT+5c0MgTNfYqM8i2xi9fTk1WrOHSGAD6n2GAtM+u7WeSMy
         pLBCuGyhVdi1j7+YAE1ruD+wkTn6JiXmJyGl+vGy690TYBq99FBWhGODtrW3zm14qJsI
         cRrA==
X-Forwarded-Encrypted: i=1; AJvYcCV+PAAcTo5tzxZkBTIgz7OZDQweaQf9YGOyw7yjyBM0X/AYy9Hsnxdl3fj1cs//aPCbppiZhtzx6thSl5+M0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YynzExSs7Ze5CeAIujpgbzBLXS2N5gHput+JKOpF6bRTXoUJ0BD
	jASnS/xCemWMkbcpmcxsYQ5lenR+VCdskdQR/icqWyzprklKLcZ4pv0P7BymeuKjGRkTr2vo5PF
	ob3UdYE0Reeuibexw5VlGAVCWKeudII/fxd0Iv9kOpkIiKqf4fP5sntToIuq5A2ZagVRosQyU/o
	ooH5olBTLsT/f1zSugGskSEFM3kCMok3H9LJUMPff+2jE=
X-Gm-Gg: ASbGnculu5nBMpEifRkiwjlghIJPwNu4wJ0snIo0pH5gGkBTTBqTnMo4uSRpfkWmmCF
	qRvxsUhNgnGKxjgXycillPCA4sVauEQ5SBLHQK0dn2VJ9hoknpM8TYC/wl/gtu9dp1Bp6PA==
X-Received: by 2002:a17:90b:3851:b0:313:1ea2:a577 with SMTP id 98e67ed59e1d1-313470736cbmr15285247a91.29.1749433841517;
        Sun, 08 Jun 2025 18:50:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6pp2fQYQ2n+yTpzYsGHW/c2XvZSyIUZCd8baZop0tHCWiQwNqQ1C9mHhJ56k+4d9YTAyBn2udsehNABU/EPI=
X-Received: by 2002:a17:90b:3851:b0:313:1ea2:a577 with SMTP id
 98e67ed59e1d1-313470736cbmr15285210a91.29.1749433841138; Sun, 08 Jun 2025
 18:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-2-eperezma@redhat.com>
 <CACGkMEsw2taXgW11na2CFK6W03c=x=wMn3iwNZPypgPkeSU06Q@mail.gmail.com>
In-Reply-To: <CACGkMEsw2taXgW11na2CFK6W03c=x=wMn3iwNZPypgPkeSU06Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Jun 2025 09:50:29 +0800
X-Gm-Features: AX0GCFuNQJJ-DIs0eRhXcctHrWWyy18SfCITsj_ozn0KtbMD5uFOzvN8tqxvLiY
Message-ID: <CACGkMEvinV7Zd+xddnxcerFbw_c+RZypkeD5HaN8=g6+peZvMQ@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8w-R3Upo0KjF-91y_cFZKHrw6o4DlPDEevhbuHmF5tQ_1749433842
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > This allows to define all functions checking the API version set by the
> > userland device.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> It might be worth clarifying how it works.
>
> For example,
>
> 1) would VDUSE behave differently or if it's just some new ioctls
> 2) If VDUSE behave differently, do we need a ioctl to set the API
> version for backward compatibility?

Speak too fast, there's a VDUSE_SET_API_VERSION actually.

I think we need to think if it complicates the migration compatibility or n=
ot.

> 3) If it means a brunch of new ioctls, could userspace just probe the
> new ioctls instead?
>
> Thanks

Thanks

>
> > ---
> >  include/uapi/linux/vduse.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index 68a627d04afa..9a56d0416bfe 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -10,6 +10,10 @@
> >
> >  #define VDUSE_API_VERSION      0
> >
> > +/* VQ groups and ASID support */
> > +
> > +#define VDUSE_API_VERSION_1    1
> > +
> >  /*
> >   * Get the version of VDUSE API that kernel supported (VDUSE_API_VERSI=
ON).
> >   * This is used for future extension.
> > --
> > 2.49.0
> >

