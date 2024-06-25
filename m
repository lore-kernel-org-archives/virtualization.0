Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587D117BA7
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278861; cv=none; b=dkTky86YMe9/nyF/vLOxao4JnRaDaB77p6j7F1nzO57AxNlL2W9+k2D5J/U02S9JFT1KEWMnDIcsZ9QFmWqA1rFyt0a8lZEsXtSrrmBrDyrMSwCrJZ6F7laLX8ht7TqJ5oYDma5pXGpdEW2ljzDq94fzCcXGt2aSWPu6jeH6vG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278861; c=relaxed/simple;
	bh=lcl3kjOcrdpnrmRC0LXidWtYMWMJGh7ncjegY8IrIMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fukf2vlDRmzAjQqaVmIaEpju5qSThW9DuMITTFlF6uoGYHA/JuFo67n0bNFx2128i3d5hi9eDqZTQh5bdbwia8aDnCNm4dbCdF/5mP/DbJEiUWNKL9sM8FnhUYtKuncelVb3RJIA2QdWGAJlpe2uQ57RXKUUj0ozV663o4PW/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLLw/Fb4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLLw/Fb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719278859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDFjTk1JNql5tI0ia7WLJKWDIsw4M/msf+eUvs8c+NU=;
	b=TLLw/Fb4n2MmXNypIA6il6kLfDWpuhFzpXwfviWIefBXaB94PGHe4PW08PHm6c1snwMrzd
	Kgnvl/mhqHXzNh1tQh3lA9tAm0hOm3kRhIIgLRQSnWjnr0rxhUmWYe+GHTfirjLtRrMz26
	CzEGkEKeiKkY7lzA7ZT4OnI/+UQNQak=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-HzkAALdPPc-OvqDhIgtA1w-1; Mon, 24 Jun 2024 21:27:37 -0400
X-MC-Unique: HzkAALdPPc-OvqDhIgtA1w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c7a8fa8013so6407660a91.2
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 18:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719278856; x=1719883656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDFjTk1JNql5tI0ia7WLJKWDIsw4M/msf+eUvs8c+NU=;
        b=t3Mmaf6fOYTPBabiI6V8XP8ImQ77jw/tuRpQgItYJmR9feHJ8W6NVi3dX4BaCG0ZWk
         FwcXr/Hag0pA5qzlxHXWUCh0NNau6b9l/x+ytCSCkqsx9fQNt8rStGjiT8G9bW3WrNg9
         j5srw5VGbY7Y3214qKqLIxJ1Rmk6HF48eEXTWQ06hQLydtRjEHEuD7FStzaJQu6yfLbp
         +c/bkK4GhKl9J1jjcQF/Od+6FCvfSeILGdsiokL9xhaumYzOua5EvXZElWLpb9ZwFcj2
         bSl3F+oKhNtGG2TVBrzWdcMQuTARwzIEX6IDAIkjwdYIqz5STguJLd8iU0syEmhneFOf
         hvVw==
X-Forwarded-Encrypted: i=1; AJvYcCXasImpm3obuUMkXnijQPinTOqNeN/3f4Gj6D9xRSYWk4w9FDbTvr1nqAA2+chsWWfAbhZTnKDzjkXz9OK7kUQnpTeeahXJ8AfZturAb6Q=
X-Gm-Message-State: AOJu0Ywg4jU9Wraw1cq2OuYo4hFeU5ulPFpsIo73L2YEj3yO26GWEcA8
	kiLXV3rdjAX9D29cJDUZHWrMCda6lD0uQSZQVR0q3SJf/L6mijRCZmnkV4vjSoWIEYGN6vrtS3V
	LUXf5s1L1Z4nTaGXC+rPFQQgEBrztfYRLyQbTZBaqVhCTNyqiylwQjHZsHiGhSEkMBTpRRqmlSE
	B2Zp7b3nwAuPsIZiE21RZmiDS5eMC5i+HJ4dDBGlw=
X-Received: by 2002:a17:90b:1d12:b0:2bd:d42a:e071 with SMTP id 98e67ed59e1d1-2c8582751e7mr5923454a91.30.1719278856337;
        Mon, 24 Jun 2024 18:27:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQX2v15J9HasbiG0qxwS3EwVOrcoFzC3/3pPPii8IU1Bz65W2MeXYkxKpAHQTcsOIIa9X2YAdalqVNZACS8Rs=
X-Received: by 2002:a17:90b:1d12:b0:2bd:d42a:e071 with SMTP id
 98e67ed59e1d1-2c8582751e7mr5923433a91.30.1719278855823; Mon, 24 Jun 2024
 18:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com> <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com> <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
 <1718877195.0503237-9-hengqi@linux.alibaba.com> <20240620060816-mutt-send-email-mst@kernel.org>
 <20240620061109-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620061109-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 09:27:24 +0800
Message-ID: <CACGkMEtacpgHvD7GLysXWm7_CybhgyJYx=AMAX+jk6+G4wqW8Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 6:12=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jun 20, 2024 at 06:10:51AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 20, 2024 at 05:53:15PM +0800, Heng Qi wrote:
> > > On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Thu, Jun 20, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.ali=
baba.com> wrote:
> > > > > >
> > > > > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@r=
edhat.com> wrote:
> > > > > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct vi=
rtnet_info *vi)
> > > > > > > >
> > > > > > > >     /* Parameters for control virtqueue, if any */
> > > > > > > >     if (vi->has_cvq) {
> > > > > > > > -           callbacks[total_vqs - 1] =3D NULL;
> > > > > > > > +           callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > > > > > >             names[total_vqs - 1] =3D "control";
> > > > > > > >     }
> > > > > > > >
> > > > > > >
> > > > > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > > > > this will cause irq sharing between VQs which will degrade
> > > > > > > performance significantly.
> > > > > > >
> > > > >
> > > > > Why do we need to care about buggy management? I think libvirt ha=
s
> > > > > been teached to use 2N+2 since the introduction of the multiqueue=
[1].
> > > >
> > > > And Qemu can calculate it correctly automatically since:
> > > >
> > > > commit 51a81a2118df0c70988f00d61647da9e298483a4
> > > > Author: Jason Wang <jasowang@redhat.com>
> > > > Date:   Mon Mar 8 12:49:19 2021 +0800
> > > >
> > > >     virtio-net: calculating proper msix vectors on init
> > > >
> > > >     Currently, the default msix vectors for virtio-net-pci is 3 whi=
ch is
> > > >     obvious not suitable for multiqueue guest, so we depends on the=
 user
> > > >     or management tools to pass a correct vectors parameter. In fac=
t, we
> > > >     can simplifying this by calculating the number of vectors on re=
alize.
> > > >
> > > >     Consider we have N queues, the number of vectors needed is 2*N =
+ 2
> > > >     (#queue pairs + plus one config interrupt and control vq). We d=
idn't
> > > >     check whether or not host support control vq because it was add=
ed
> > > >     unconditionally by qemu to avoid breaking legacy guests such as=
 Minix.
> > > >
> > > >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> > > >     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > >     Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > Yes, devices designed according to the spec need to reserve an interr=
upt
> > > vector for ctrlq. So, Michael, do we want to be compatible with buggy=
 devices?
> > >
> > > Thanks.
> >
> > These aren't buggy, the spec allows this.

So it doesn't differ from the case when we are lacking sufficient msix
vectors in the case of multiqueue. In that case we just fallback to
share one msix for all queues and another for config and we don't
bother at that time.

Any reason to bother now?

Thanks

> >  So don't fail, but
> > I'm fine with using polling if not enough vectors.
>
> sharing with config interrupt is easier code-wise though, FWIW -
> we don't need to maintain two code-paths.
>
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > > > So no, you can not just do it unconditionally.
> > > > > > >
> > > > > > > The correct fix probably requires virtio core/API extensions.
> > > > > >
> > > > > > If the introduction of cvq irq causes interrupts to become shar=
ed, then
> > > > > > ctrlq need to fall back to polling mode and keep the status quo=
.
> > > > >
> > > > > Having to path sounds a burden.
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > [1] https://www.linux-kvm.org/page/Multiqueue
> > > > >
> > > > > > >
> > > > > > > --
> > > > > > > MST
> > > > > > >
> > > > > >
> > > >
>

