Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3E199E91
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877285; cv=none; b=TB5dyGVgqTPL25bJue+ztp5Kp7t//1/K7Is7qK3aNYqTqyhTVt7MN4qhQXeAAgzP+YK3vuH2DOpbbbIrxVmmNz14qn7Jg9jjOkY9yQB47n+4IbEsShKtGcAzxSOa5HpBiHZdl3DUBRE19ivIl3DC/U6MZrAKlrr0UWL0zBH0mmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877285; c=relaxed/simple;
	bh=mfuiQNx4Y08gEmqvHzCsbcy3fnFUSlA+uYcce/ogIdk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=OCTU+euoG+UnHfIOKsAk9yrJNZWvORzXmkydqaBekYb1jWeDN983zVg8KDLR3+U6QUKdIIDfNwxiZ6HhJ6bDjqUpxVQB/FuCy4QtsOaWKyTZsV64+mXgWPMtQE7xQPQmj7Aqf2gOkTC9Dm2MELCd0RgXtmi7FNvi8sBIxR9doKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZNwiLZnn; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZNwiLZnn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718877281; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=IrEzfHdY3vnVmYLJx8eUcBUjvCBRCehaYVOpTDQCsH0=;
	b=ZNwiLZnnApq2oi1uAMaoQClE3ndlUYDplz8xibh4fjGdcuRnj5+Vg5y4zyh4B7qRHFgCU31aonmFq2bNeheSFc+V4QO+L5RjbRdNzgeuMREDtIxNCISpFMWbsR0Mpy2yQq0F/K1ZnX0tQlC/uEK/+Bi7f0hVynstlZrDJibfb9w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8rEzli_1718877280;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8rEzli_1718877280)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 17:54:41 +0800
Message-ID: <1718877195.0503237-9-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Date: Thu, 20 Jun 2024 17:53:15 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
 <20240619171708-mutt-send-email-mst@kernel.org>
 <1718868555.2701075-5-hengqi@linux.alibaba.com>
 <CACGkMEv8jnnO=S3LYW00ypwHfM3Tzt42iuASG_d4FAAk60zoLg@mail.gmail.com>
 <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
In-Reply-To: <CACGkMEtryWEbe-07-7GWyntGN+f-sL+uS0ozN0Oc6aMemmsYEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 20 Jun 2024 16:26:05 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 4:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Jun 20, 2024 at 3:35=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > On Wed, 19 Jun 2024 17:19:12 -0400, "Michael S. Tsirkin" <mst@redhat.=
com> wrote:
> > > > On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> > > > > @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_=
info *vi)
> > > > >
> > > > >     /* Parameters for control virtqueue, if any */
> > > > >     if (vi->has_cvq) {
> > > > > -           callbacks[total_vqs - 1] =3D NULL;
> > > > > +           callbacks[total_vqs - 1] =3D virtnet_cvq_done;
> > > > >             names[total_vqs - 1] =3D "control";
> > > > >     }
> > > > >
> > > >
> > > > If the # of MSIX vectors is exactly for data path VQs,
> > > > this will cause irq sharing between VQs which will degrade
> > > > performance significantly.
> > > >
> >
> > Why do we need to care about buggy management? I think libvirt has
> > been teached to use 2N+2 since the introduction of the multiqueue[1].
>=20
> And Qemu can calculate it correctly automatically since:
>=20
> commit 51a81a2118df0c70988f00d61647da9e298483a4
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Mon Mar 8 12:49:19 2021 +0800
>=20
>     virtio-net: calculating proper msix vectors on init
>=20
>     Currently, the default msix vectors for virtio-net-pci is 3 which is
>     obvious not suitable for multiqueue guest, so we depends on the user
>     or management tools to pass a correct vectors parameter. In fact, we
>     can simplifying this by calculating the number of vectors on realize.
>=20
>     Consider we have N queues, the number of vectors needed is 2*N + 2
>     (#queue pairs + plus one config interrupt and control vq). We didn't
>     check whether or not host support control vq because it was added
>     unconditionally by qemu to avoid breaking legacy guests such as Minix.
>=20
>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>     Signed-off-by: Jason Wang <jasowang@redhat.com>

Yes, devices designed according to the spec need to reserve an interrupt
vector for ctrlq. So, Michael, do we want to be compatible with buggy devic=
es?

Thanks.

>=20
> Thanks
>=20
> >
> > > > So no, you can not just do it unconditionally.
> > > >
> > > > The correct fix probably requires virtio core/API extensions.
> > >
> > > If the introduction of cvq irq causes interrupts to become shared, th=
en
> > > ctrlq need to fall back to polling mode and keep the status quo.
> >
> > Having to path sounds a burden.
> >
> > >
> > > Thanks.
> > >
> >
> >
> > Thanks
> >
> > [1] https://www.linux-kvm.org/page/Multiqueue
> >
> > > >
> > > > --
> > > > MST
> > > >
> > >
>=20
