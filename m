Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A60F4F1
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718097; cv=none; b=Oc8EHWkPGwcxxcLgC2noIqhu2WPVmBf1803wNeKZ/kH1zDckQpsmsqmPjWvdDU4vH9f6vgWTKETwL1jc1ZmsHdY9r5OUkuh+1Ub1cQ84+oX3dCCUj3/v5H4Q/OGYQesfPRWrIAxp+ERiG99wOlP219PUnchQwfrisb9duSBNlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718097; c=relaxed/simple;
	bh=uf9U689LQfwHZyV8Fy+5Kt9ICYtcnAbwZDvEjFv3Cno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8bEoQhPmEcPK83lUmJwjxkcxwF3PXd3xDzxYr3HjvRCeehHyr1NN98wrt+6WD0qadX0QDkv5HMaENi6HvO6Up3IxIiEVitVQOZ+/ecZ95VvAg4pFDIVzpDl/+SJtl5jjMhhl5OjV/ac2t7tGZcAELNPikHoL+zPvL0hIEUjQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIzULjy7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIzULjy7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761718094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmHtqViYDAk5kSVt0ob5hCkpNRXEzOyG4aGA4egJjIg=;
	b=EIzULjy7pLFSOG+1Au+nFkSzIVnCV9+zwxNgCLfNCKbF2tkruqQZeRp2LqFSwJimu0p/i8
	oDRBebGvwuGEO88K48uucPFKji2vXKaVTPxUlK4EzYk8Epfw4xHKMz0dqQA5yei63Mhe99
	Y7PhJurkDBLK/CkZRazdhRXwnFL8r1E=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-jAST20b3Moi5eUYv9oRcHA-1; Wed, 29 Oct 2025 02:08:11 -0400
X-MC-Unique: jAST20b3Moi5eUYv9oRcHA-1
X-Mimecast-MFC-AGG-ID: jAST20b3Moi5eUYv9oRcHA_1761718090
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5db2b4d6b2dso3147364137.0
        for <virtualization@lists.linux.dev>; Tue, 28 Oct 2025 23:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761718090; x=1762322890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmHtqViYDAk5kSVt0ob5hCkpNRXEzOyG4aGA4egJjIg=;
        b=HS/++xVCYqDcRnogQkT3HgP07GUD6tpE5MBnMFXLXQWnO7BKVWrnswB/enZvzhYwC0
         w+hm765aXBSUWut1XVUMJ2x8092wzPK5Ym2/aw1glaBJaSw+VpAafkCkAIeIS91SOEZL
         uG44TOusKv3ycVeiMqm94F2wnSG9s3VisTdMJJGb9AwJzNqOw9Iq+cylPSxevdy6nE5R
         ggv8Rh6pOlAquDqqb8HP82iWeuU2FsmyTQY2vgB5OhyTpOubcyE9aJIS5NwtuDSauu2z
         y6uFJhS8Xr42K5uIkbN5pGCcRC2JF5ekYEwpJH+HvUF++yA6YmCdy4o3bZ9sAyIOwkN2
         v3hg==
X-Forwarded-Encrypted: i=1; AJvYcCWQdDSddc85aFlmQOUh8rwTVl4HlsND70gji2swy/cigwR4bBVIJNq5OJoUP4ZLBlg7+FpTFFvvAPcnwY4JOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyymlSkyPETOTAw3XeSALEmYKYLvM57J4I/vqAX4mUo+xjj/8vX
	CEojGwV5yBvNSAw2HddYVThkorZM/fnTwFTmI+XiNijEEhQ8IM0vB/mgkGaehtyvKAvxz3cRvR5
	4trKP1J1Ir/NWvNff7g1BgAHX3kFjTwDUwrVoWYR8kSzTxVkNWeZayfDBlecqRSchOdsF7J0B+z
	4rHCaK/FARImhpDNUJWBkkyLLt9lk6vi5MiIqlQ+kyLss=
X-Gm-Gg: ASbGncvsgIEsyp+6H00JDT9wVbPIdmqeea/dTYWN7V886PeethlXlI6xlOFEIJat/Bk
	P4DsAdz5GwBRf0zL8leKGFEaZsXvRijOse5m4C+W+EHqWqefKR9lXe60a7zxhW32cxzLszDTKPR
	LcKAXhcNgmZ1HtxAjTZqhjkw+/E71JclanGczPle95N06eWJ/WI3wDi6n/
X-Received: by 2002:a05:6102:3ec3:b0:52a:c340:11db with SMTP id ada2fe7eead31-5db906710c9mr498299137.27.1761718090446;
        Tue, 28 Oct 2025 23:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXGlyjg4CZDqR6i3uyxN1nwhkbwQKQBVsOx91eo6mjqRW3dyVraIpk0ezKA2S6T8s2TvCJFZVkyLYqVpwpB5k=
X-Received: by 2002:a05:6102:3ec3:b0:52a:c340:11db with SMTP id
 ada2fe7eead31-5db906710c9mr498296137.27.1761718090111; Tue, 28 Oct 2025
 23:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADZSLS0zp9rqP2=vCh8eHVH_U+g+k_8pitV939u9Ls8ZPEMfJQ@mail.gmail.com>
 <zfddiyxykxaoev4wbaxh6ml6czew44k5mt4jsxylpbybnqbs6y@rcfi5dpy5qv4>
 <CADZSLS1KPX6rgCkdDPqqyYC-R3oBWDGb8o26QQXaG5U4R=8zzA@mail.gmail.com>
 <w5oshdtp3wdhydjmh6htwtgb6keyml2teft7ihu277tbktzbp6@mweh7pyfwlrl>
 <CADZSLS0A_EEi46U_zF+ssfgXWqg_YwekwOsCiNTbbKg3ueNhRQ@mail.gmail.com> <y7jhsbztzc5cy75354pauxq7xs6rcnsimhdlnkcd52j4dislke@7gtn5te2uonk>
In-Reply-To: <y7jhsbztzc5cy75354pauxq7xs6rcnsimhdlnkcd52j4dislke@7gtn5te2uonk>
From: Wenli Quan <wquan@redhat.com>
Date: Wed, 29 Oct 2025 14:07:59 +0800
X-Gm-Features: AWmQ_bmhqr9_BIfU8eCCh35Ic8ZYf4meBvYvAN_KgmwWxaJdILvFeQI05g-BkV0
Message-ID: <CADZSLS0RR0DCWKD9QjEPJ2EmwKZBh5ftOCcT13_Hn+mQQz-anQ@mail.gmail.com>
Subject: Re: Host Crash when re-running vDPA device creation script after interruption
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z6UgzcLILTIscGDCUZfdalsfP-yWudEQCDnoQH-ft6Y_1761718090
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:56=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Thu, Jul 10, 2025 at 06:18:39PM +0800, Wenli Quan wrote:
> > On Wed, Jul 9, 2025 at 9:08=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> > >
> > > On Wed, Jul 09, 2025 at 08:59:13PM +0800, Wenli Quan wrote:
> > > > On Wed, Jul 9, 2025 at 6:38=E2=80=AFPM Dragos Tatulea <dtatulea@nvi=
dia.com> wrote:
> > > > >
> > > > > On Wed, Jul 09, 2025 at 05:36:04PM +0800, Wenli Quan wrote:
> > > > > > I am reporting an issue where the host system crashes when re-r=
unning
> > > > > > a script that creates a vDPA device after interrupting its prev=
ious
> > > > > > execution. I am attaching the script for your analysis, as I am=
 unsure
> > > > > > of the exact step causing the crash.
> > > > > >
> > > > > Thanks for catching this Wenli. We'll look into it.
> > > > >
> > > > > > # uname -r
> > > > > > 6.16.0-rc2
> > > > > > # sh vdpa-setup.sh  0000:b5:00.1 1
> > > > > > interrupted by pressing Ctrl+C
> > > > > Could you specify during which stage of the script do you interru=
pt it?
> > > >
> > > > Interrupted after running for a few seconds.
> > > >
> > > I was not yet able to reproduce the issue.
> > >
> > > Could you print out the commands of the debug script so that we can s=
ee
> > > where it was interrupted? set -x should be enough.
> >
> > I tried again many times, just to reproduce once. the following script
> > for your inference. but it doesn=E2=80=99t cause a crash every time.
> >
> Hi Wenli,
>
> Could you try re-running this again please with the latest mainline as I
> was not able to reproduce it.

Sure, I will retest it and update the result here.

Best Regards, wenli

>
> There was a relevant fix [0] recently that might make a difference.
> This was merged as commit
> 6b4be64fd9fe ("net/mlx5e: Harden uplink netdev access against device unbi=
nd")
> in mainline.
>
> [0] https://lore.kernel.org/all/1757939074-617281-2-git-send-email-tariqt=
@nvidia.com/
>
> Thanks,
> Dragos
>

