Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A9270EC1
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814153; cv=none; b=VBXdxyRPIkKBCRR8hCZbGubj7UD+jKMMFtqZ+qvH2kaz1jdYeSr6BSjviwCbt1ARpcDiVm1mm2jA3S4eQ+iMrnKLvGYNyGdqGENeU7HHEtVq86y3BMmsYTvn12GThHqTCLj1hRzXOvOO3+22FAQXNFwJxJkt3AW3i1IdgF7R/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814153; c=relaxed/simple;
	bh=fqQSBxOlZJnuHFrFErST1mQ64bzEwVQ1F3XskwMHnXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+i+YcgNHWibEItg1eTV8ulwJJrPb4T9/EgxjqIa9QjdtcxAKCwDfrfb9VW8sRpLOA7t825kUdHJO0idgBFtB9MiGI4rnSR4w3BXB9XE9KzUoP1peaCJwAz1Pg8Z1CPhfY/mHDPl4Sr35bRDSWpbG95n0M0XfsHbwMQadaO26cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhjbCpTZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhjbCpTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761814150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiyL2OA2YNAdRRB+5nVcHVWUWiPtQAfn/t7VDsJNQ+E=;
	b=DhjbCpTZyBNjq0b+EC8IqkPHYOwOgipt2u0l0gOulQejA7+2eYQTPHKv4MNBZpdn+6UygC
	xyStQooihWtbXTqVG+M6AospulznfVdeAeWgBmfYm86GlC5st3MWLHoZDe6xMxr08i9zzw
	MMCsBbLweE/SLom8OZAOdAPkBZ95Z1M=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-wYDXSO6lOq6fSptjwr3jDg-1; Thu, 30 Oct 2025 04:49:08 -0400
X-MC-Unique: wYDXSO6lOq6fSptjwr3jDg-1
X-Mimecast-MFC-AGG-ID: wYDXSO6lOq6fSptjwr3jDg_1761814148
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-554e68b14cbso291989e0c.3
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 01:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814148; x=1762418948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiyL2OA2YNAdRRB+5nVcHVWUWiPtQAfn/t7VDsJNQ+E=;
        b=O8+HHgtUZi2VDntF/WSw/BW6cW1P9IGYEYa1T+rB+CSoiIvRRgdx5wyUEq082udlCB
         k/FIszMOW0NaYGzitD5rZG0XE2WlJShKQN7K/OgXtvgQAfr5qPOC98lhwCYDz4aD6tjh
         YUR6oV3F+T3RdjRbB1AURNQDWe2JLcUA2/H9726rUDFjrb59BCd7fuvpxR/GKkafhxq4
         Am66jQQNpMzBpChn8dhHfhULWlRi6RjCBaBUaUf4kRQRaFbBOpq4gz/um1aQ0c1CTWYB
         pJCT6SGEfbdaYRMi+6Md0QOoxoHqtbA1sxChlAZkOBxb+Yv5nJ0lKSF1ca2dt2kVQnDT
         84jg==
X-Forwarded-Encrypted: i=1; AJvYcCXdb4WM6MzD3eNIY4t3cI1IVXwOHlS4J1nXmp7TfR2vgEelv2UtRHl5NOUqM/5JisKzX3mhjIz1NCkMQYS+nA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0r0He6wqO8eeMHsj8Vnjb7mZzEdPq9qqU7lDmbVic4qt5AbJb
	ydc/8eRlaOXR/T1MPzXUDU+BzPqUMYG3ep53tGywYX6K8r85+Wt6rJo0rLdeSfdHwWKZyMCxOyM
	pyI/Ln8zwZfQTuPO7TwM1m4jMQSDF+Poxv76faaTk7qKhz8min88KEcwAI0y4eKzeN5bKMLweEw
	2J5xeXSFeafvDZ6LODzQ82eB39aZlyep3Lqke1WkS/JeQ=
X-Gm-Gg: ASbGncvmT/y11bQ+5a+WF9eK2r4Wmv6bhIKjRVwn1bTEgNUQJIJQzBr8oceLeEKzFSv
	EbBdxkLaEB8gprHqQ0VbMWr9SSzyxhpCuaBjyRClbfPRqYAH7VtpYYBPLh7Oq1eY+/VCQppC+UD
	rCB8SkuzG0CVQlhE2MVDOe8NtenyVoG6IziEaai3a0ER/3JukHPEWNwE0F
X-Received: by 2002:a05:6102:f10:b0:5db:374f:8b99 with SMTP id ada2fe7eead31-5db906624d6mr1907770137.21.1761814148100;
        Thu, 30 Oct 2025 01:49:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+WCljcFXG5ydfbrxYlPEyAo/Pz8VVviP2Glb40OxQFPWIBiKNqzK9X5R/4oPQ1sIsKfCzs0t2wOTgpOfc8Bw=
X-Received: by 2002:a05:6102:f10:b0:5db:374f:8b99 with SMTP id
 ada2fe7eead31-5db906624d6mr1907764137.21.1761814147726; Thu, 30 Oct 2025
 01:49:07 -0700 (PDT)
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
 <CADZSLS0A_EEi46U_zF+ssfgXWqg_YwekwOsCiNTbbKg3ueNhRQ@mail.gmail.com>
 <y7jhsbztzc5cy75354pauxq7xs6rcnsimhdlnkcd52j4dislke@7gtn5te2uonk> <CADZSLS0RR0DCWKD9QjEPJ2EmwKZBh5ftOCcT13_Hn+mQQz-anQ@mail.gmail.com>
In-Reply-To: <CADZSLS0RR0DCWKD9QjEPJ2EmwKZBh5ftOCcT13_Hn+mQQz-anQ@mail.gmail.com>
From: Wenli Quan <wquan@redhat.com>
Date: Thu, 30 Oct 2025 16:48:56 +0800
X-Gm-Features: AWmQ_bkGwmSsYQMolBIrVokyCC1QhyK30E7yFd_oYDo1evJJGE86tWxvz0zjFjs
Message-ID: <CADZSLS1usmoE7pkW3Nqw6QkCp4sObU0xjRXYhSb1+p1K3vFAEg@mail.gmail.com>
Subject: Re: Host Crash when re-running vDPA device creation script after interruption
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: psJYq2W6ilL_vV9m4abMu1nm4HVBTe6aOYaY0fqgUMk_1761814148
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:07=E2=80=AFPM Wenli Quan <wquan@redhat.com> wrote=
:
>
> On Tue, Oct 28, 2025 at 4:56=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.c=
om> wrote:
> >
> > On Thu, Jul 10, 2025 at 06:18:39PM +0800, Wenli Quan wrote:
> > > On Wed, Jul 9, 2025 at 9:08=E2=80=AFPM Dragos Tatulea <dtatulea@nvidi=
a.com> wrote:
> > > >
> > > > On Wed, Jul 09, 2025 at 08:59:13PM +0800, Wenli Quan wrote:
> > > > > On Wed, Jul 9, 2025 at 6:38=E2=80=AFPM Dragos Tatulea <dtatulea@n=
vidia.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 09, 2025 at 05:36:04PM +0800, Wenli Quan wrote:
> > > > > > > I am reporting an issue where the host system crashes when re=
-running
> > > > > > > a script that creates a vDPA device after interrupting its pr=
evious
> > > > > > > execution. I am attaching the script for your analysis, as I =
am unsure
> > > > > > > of the exact step causing the crash.
> > > > > > >
> > > > > > Thanks for catching this Wenli. We'll look into it.
> > > > > >
> > > > > > > # uname -r
> > > > > > > 6.16.0-rc2
> > > > > > > # sh vdpa-setup.sh  0000:b5:00.1 1
> > > > > > > interrupted by pressing Ctrl+C
> > > > > > Could you specify during which stage of the script do you inter=
rupt it?
> > > > >
> > > > > Interrupted after running for a few seconds.
> > > > >
> > > > I was not yet able to reproduce the issue.
> > > >
> > > > Could you print out the commands of the debug script so that we can=
 see
> > > > where it was interrupted? set -x should be enough.
> > >
> > > I tried again many times, just to reproduce once. the following scrip=
t
> > > for your inference. but it doesn=E2=80=99t cause a crash every time.
> > >
> > Hi Wenli,
> >
> > Could you try re-running this again please with the latest mainline as =
I
> > was not able to reproduce it.
>
> Sure, I will retest it and update the result here.

Hello Dragos

I have re-tested with 6.18.0-rc3+, and the issue could no longer be reprodu=
ced.

Best Regards, wenli
>
> Best Regards, wenli
>
> >
> > There was a relevant fix [0] recently that might make a difference.
> > This was merged as commit
> > 6b4be64fd9fe ("net/mlx5e: Harden uplink netdev access against device un=
bind")
> > in mainline.
> >
> > [0] https://lore.kernel.org/all/1757939074-617281-2-git-send-email-tari=
qt@nvidia.com/
> >
> > Thanks,
> > Dragos
> >

