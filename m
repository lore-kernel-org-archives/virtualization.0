Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0A3A63F6
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128026; cv=none; b=NX1nOA6VatLX1zGu5a5vskddR8s94D7du0PYRRmlC6zUQ9ZLwQqFvmn5G7xiS6P0DxYlD1Qo6Oy1V1pZ37W8m1JLk7KI2oXODolqQz9WPg5JkhQt5krJ6nXWml+54EJSMX9u7wVI4ElNDme/HiF1cJ/Pp51j/lHMnKJeZ1MWp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128026; c=relaxed/simple;
	bh=CODahucms7FU+ajr6yfoXd+/f3zUSL7qZ8te0PZ0yHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO/rVuSMB1E0K12C36hfJrBasLZ4exatMap57puofQFe80+R8bdo82AHAfJthoVBlsd88YtF2A+xfIWb78dozKtsInzKbKo4eeVVgzninqJGRfcVlc/wGxiI4UsB2pXclfW8TEsXpobEWyzbv7bvqeOu7HCseVtBfw9ek5DvauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeDAn5Kx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeDAn5Kx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770128024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgTtkunK/minAcJLOcxYBdVOCWo3KaWlbKJlMlPjxeM=;
	b=BeDAn5KxX7pFlcF2+1Fm6CPpVkXe3aQEqFb20aMuIn6DDdlo/2VMaN13x2zIHQHTjnM2qF
	7/wuQHLMM+5Y7Hewb1KQrgdkTOcS/3+LKwqkKFYKZnWznPNtAjvshPhACX+zwhE7jZwRjm
	A6pss+yE0OmUHV0NdfWkfw+zXpYr3j8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-MGc8o1CmMJ-jR07leBlUvg-1; Tue, 03 Feb 2026 09:13:41 -0500
X-MC-Unique: MGc8o1CmMJ-jR07leBlUvg-1
X-Mimecast-MFC-AGG-ID: MGc8o1CmMJ-jR07leBlUvg_1770128020
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-794e8cc5525so22323207b3.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 06:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770128020; x=1770732820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgTtkunK/minAcJLOcxYBdVOCWo3KaWlbKJlMlPjxeM=;
        b=SMgAJKl0TGaH4CeqZ0KvmQR4dkArq7dGBRXr3cn5rb33q2tk+xNmd6iedaS3iPoyDX
         CR6DWZrLqXd4zKRQP+bzdqwYSYYodRQAYVdeRSKy4iuTznYK+Zpe3fumsDiJtvZhHIwW
         dshd4TMEHvk7DxnWhtr78FkxkQi4fPwBXWWiDYrOaqeCMrvGW2dv/w04eIrEY1kMZh+h
         ayFxd3YHrDTsjedMYcOjbc8SYA++huTIG18sjGQ95WopOEkzw7L+fcNb617fkXMfzuMH
         OtMZgWFQzMuiOy4cEDSOkI4g3O2qop4ayGKZpLyixZrg4YKAOJilCBsM+fciNYa8mUoC
         A94A==
X-Forwarded-Encrypted: i=1; AJvYcCUZD0mwkhVLGwiCw0S2hX5vXx2xivTvCPu0DghM3vqzn+6i0bTOd3W+EYUEY+FkCl2IB9gcm3ych/nAE28GPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaoANvQhLkdXRl6gceCqo1syBh2SN3i3lDs1Brx0t8k1VUfiMT
	MYp8l2qeQyrjYRelNi9UyCuImObnsh3IxJO60wgvOwm7vJXMfA5yS+QzKXYy1kBZPsHniVkR2B3
	LuBWuRsrLdFo3+f0Z71z5LmEw+2rwRFPljAC0WTrFqCnEGZnmVRbEtPBu0XHvXZl8leHyfx0PQs
	YL6pJLdyudR2ekpGOxfHOuRVKnFNuj01bL4KQpS17mG18=
X-Gm-Gg: AZuq6aK98ICxJLl/9HLha0yOl8JW9v3PLGC6J0psN7ypG0/qCCAFQmWokJitUSipq5z
	sxS4BV+KeUGPo5NzHG2GQEE5I907ZON5/7FkYmVP/g5DistuY7F3QnYczeIYPXW7SEdrJRp6vc7
	8uobqegKeDTqA5pnGsjHRnVmZ8wcLpqNKSN1gzJ8FLgV2LKMt/uRLhwWchPsWvadI9TA==
X-Received: by 2002:a05:690c:7107:b0:794:dac2:89ce with SMTP id 00721157ae682-794dac2a6e0mr59335687b3.21.1770128020455;
        Tue, 03 Feb 2026 06:13:40 -0800 (PST)
X-Received: by 2002:a05:690c:7107:b0:794:dac2:89ce with SMTP id
 00721157ae682-794dac2a6e0mr59335437b3.21.1770128020060; Tue, 03 Feb 2026
 06:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202095940.1358613-1-arnd@kernel.org> <20260202095940.1358613-2-arnd@kernel.org>
 <CAJaqyWeJs4u6G46gEg=-G6o3u6LsgzVC03fTGR=O_qd_HujLuw@mail.gmail.com>
 <30db98bd-8361-46f5-aec1-ffbc4e8574dd@app.fastmail.com> <20260202114412-mutt-send-email-mst@kernel.org>
 <34d3ce77-84b2-476c-a678-e092831041ae@app.fastmail.com> <20260203053142-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260203053142-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Feb 2026 15:13:03 +0100
X-Gm-Features: AZwV_Qj7eSPoSL5T_E-5g00qMHmRpplnLg8urFGIDRYqlBbJpmLqSVY4oDeUZ-o
Message-ID: <CAJaqyWeZes2nUFQNaq5NmXN7127eh+bNFQbB7yX73TuZ0=xRng@mail.gmail.com>
Subject: Re: [PATCH 2/2] vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Marco Crivellari <marco.crivellari@suse.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jiIXzzkSnz3q9cUSrZovGLjQ7SFj5G0ooQTYashKMJI_1770128020
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 11:35=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Feb 02, 2026 at 11:54:17PM +0100, Arnd Bergmann wrote:
> > On Mon, Feb 2, 2026, at 17:45, Michael S. Tsirkin wrote:
> > > On Mon, Feb 02, 2026 at 12:59:03PM +0100, Arnd Bergmann wrote:
> > >
> > > I think .compat_ioctl would be cleaner frankly. Just look at
> > > all the ifdefery. And who knows what broken-ness userspace
> > > comes up with with this approach. Better use the standard approach.
> >
> > Sent now.
> >
> > I'm not sure it's much better because there is quite a bit of
> > code duplication, and reducing that would be a larger rework.
>
> yes but on the flip side, we can put it all inside ifdef CONFIG_COMPAT
> (which this code did not do, but should IMHO).
>
> > It may be best to hold off on patch 2 for the coming merge window
> > since the compat ioctl code has apparently always been broken for
> > x86 here.
>
> And it needs testing.
>
> > I hope we can at least get patch 1/2 merged along with the
> > new code though, otherwise it would get a lot harder to sort
> > it out properly, with the v2 struct members overlapping the
> > old padding fields.
> >
> >      Arnd
>
> Along with it or no, surely before the release.
> Given 32 on 64 with this apparently has been broken forever,
> I will merge this just based on even you did not bother testing compat, I=
 am
> inclined to say I am merging this but not rebasing because
> of this.
>
> Oh and we got lucky this didn't leak kernel stack info.
>
> Eugenio, note for the future: please help make sure UAPI
> structs do not have hidden padding.
>

Sure. I'm trying to find an automatic way to check for this but with
no luck :(. Arnd, did you use some tool for this or you just found it
by visual inspection? I'm trying pahole and -Wpadded but the output
includes a lot of struct not related to uapi.

I guess it is possible to filter it with some clang or awk machinery,
but I'm asking in case I avoid developing something already existing.

Thanks!

