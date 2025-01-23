Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B911C5D7E
	for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617260; cv=none; b=Gb2DFboyyLqcyU+QAaPuP31Y95NZnd0vV/ctw7ZKfkA1Z0oGz1fxbd7OkLFmCQftWxSvOF3LeXSJQkcC0n3XmsNqyeI6zipO2YoxPk6sCArP3akv5KmvzawBZMTCHYdYE6I7bYB2ajznMj5GIngm2TZmZex3EdpgyhZgMw6dx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617260; c=relaxed/simple;
	bh=rs6V2RNFRSU7Ve/TlCDqWVo7idRb6m8c3aDkwTAIPk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLFj7RjM3/amAbbG1EnkWXtKnG+fZVbx/aLxus1RDAigYBHFoO4Kk9UEEvCuRSxg239HibLykQQXRPrIeXlljv4e+3x6NmRLhZ6mwFWWwJ5KyaSnsCHxLpjDqg9a7JYVaUCVSy/k2ZlIqumF0EOIKv1ACXCZUZkDhS2fwgbAZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDCSyjkF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDCSyjkF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737617257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rs6V2RNFRSU7Ve/TlCDqWVo7idRb6m8c3aDkwTAIPk8=;
	b=WDCSyjkFTTQnhhL/ad96+svY0/bE2qlB4NIoK3KWSKQNRcylvxzXQF7ak4ot1OqziV9gN9
	Z+s26E2vKAtWIVUcQ5ohY0FUOL3bxv3qk8uzqI1398/D373qmR0yCAHWy63HViW+cxk3UN
	7AcLLjUSMp+YieF/tUTrOZ9iYfEFBHc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-Sy-rq4exNiKYXZxa5hI8BA-1; Thu, 23 Jan 2025 02:27:34 -0500
X-MC-Unique: Sy-rq4exNiKYXZxa5hI8BA-1
X-Mimecast-MFC-AGG-ID: Sy-rq4exNiKYXZxa5hI8BA
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e580dbfee3eso1317343276.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 23:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737617254; x=1738222054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs6V2RNFRSU7Ve/TlCDqWVo7idRb6m8c3aDkwTAIPk8=;
        b=ZB+dfzfK+JAZ6PYWALGwZ9fBMTtTIbJi+o7OuzDKt6AkHMA+2NkIwWcFxAozbWS2cr
         w0sg5DHHUpNoREbSoSPIZHr24MYmcXlbwguiswQillHi/USovFW7g3Wn6GRaZhf5aGh4
         WPccJRq9Cxi9KCsJ30LGHqIPQFLuS1jHxgDqtt1NIFIzU6TVWYAdyRD97klOx0aUREOE
         rYhyA/PioHBy1w3WKyRp3u9daUTUwIS5QHNFS0Ufnza4aGmfbCkIzidfajGEdIFmJZN9
         701LCrJcR0Srb5+isRTsrdbx0Qh5O1eI6pfX8BZmM7MR9Kao8ksH8DDtmOJqEh9etLWg
         iSJw==
X-Forwarded-Encrypted: i=1; AJvYcCUwGOs4RNt91WjDLW8gpJjSnIa4VzptCLvclPXx6HDKHY8rzgkiYjxRDK2wSy1H2TF4OUGf/aQ3isp3xx5aDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoYcOeFIdmpT+ZUxq6YpH8Bxv+Um5sTbnCHRiKjH43oMd0an/r
	V9XjtuEVC2Or95ZkhCgd5B25oUU5n1ezg3DWskoS1l742O6VJ2c9l4DssJi2a4lcK9Yaw/t+35d
	fRwDaxdLUWvKsY3/+V0pupRV0kDTC1kfgTd13YketDeYKZCPa9Q8qBMQ5HaV3dlE7ym6hWln16n
	ytMpBKXQyS5fYaSi0Ab1orHVyMCI8Csw2v/c8AaG0=
X-Gm-Gg: ASbGncs43/mS1v/QUmJqAHEnYB+8M1TDFMLNVsCWgsA7NKajKgWh6VOmmUOxa5O0+du
	4dxa11V0O1St6O1tWcG+QAYqQkqZMObgxpKMu2W4y9SALJ79QjA==
X-Received: by 2002:a05:6902:1148:b0:e58:d62:1057 with SMTP id 3f1490d57ef6-e580d621318mr6312281276.32.1737617253798;
        Wed, 22 Jan 2025 23:27:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4ebAYMiIEKFUvXD6lUe6QE2LjlUAXDLNKNlZnqmA2wAiCE/8DxNlO2tgSIKo9jD8iZ6HR+FeWUntjzrrSfGw=
X-Received: by 2002:a05:6902:1148:b0:e58:d62:1057 with SMTP id
 3f1490d57ef6-e580d621318mr6312273276.32.1737617253577; Wed, 22 Jan 2025
 23:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121103346.1030165-1-eperezma@redhat.com> <20250122154908.GB178738@fedora>
 <CACGkMEtdMzr1chpneCTnpjHFKaN5YSZbsVjSLtHSt+ULpUHG4g@mail.gmail.com>
In-Reply-To: <CACGkMEtdMzr1chpneCTnpjHFKaN5YSZbsVjSLtHSt+ULpUHG4g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 23 Jan 2025 08:26:57 +0100
X-Gm-Features: AbW1kvaoqRy9X1ptwkc9cMXsOkb5Cxyx2OlGEcIuIcZAFXzxm9QY96DkWTpZZdY
Message-ID: <CAJaqyWdC-Tte+ao6pk22fq-mUym8C9guQFThSnG5gMxWNqWyXw@mail.gmail.com>
Subject: Re: [PATCH] vduse: add virtio_fs to allowed dev id
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Hanna Reitz <hreitz@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, German Maglione <gmaglione@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oPoCvu8SyooMNFStej67cbeqK4gfdkwF-LyOn99S_7Q_1737617254
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 2:50=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jan 22, 2025 at 11:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> >
> > On Tue, Jan 21, 2025 at 11:33:46AM +0100, Eugenio P=C3=A9rez wrote:
> > > A VDUSE device that implements virtiofs device works fine just by
> > > adding the device id to the whitelist.
> >
> > The virtiofs DAX Window feature might require extra work. It is not
> > widely enabled though, so must virtiofs devices will work fine with jus=
t
> > virtqueue and configuration space support.
>
> +1.
>
> The DAX Window may help to reduce the bounce buffer copying and fit
> for the case where an AI application just accesses one single large
> file.
>
> We need to consider implementing this via VDUSE.
>
> Thanks
>
>

I thought DAX can only be applied in the VM case. Is it possible to
apply it using virtio_vdpa?

Is it possible to detect that the device is trying to use DAX so it
fails the negotiation?

