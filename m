Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE32BAF9
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410630; cv=none; b=NmNqOpqGuP87qqNXFVtzPXJO1p/d//hCBRbDqwY6K7gaq3tn9CJblNDhuy2PL/tF5oKEtmQytiBZmC1iRaJtNi5ZD+p96LnIVo2zCy9K8AuNlDsbKFB5BstZJN56l9aGL7YUXNvHj5j10uk0iTdAIJ/3CNnQCKM9YNZA/HGjlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410630; c=relaxed/simple;
	bh=cR3HCkIFNdf5Gn32epuL4lJ22BcY6hMgtll801wHEWo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=LKVVHTfW4DKLXsdfB+0AtWjdUCpvb8y59aQF/wCrzJkjDahPf3gruNiogL4KCEAWyhQomv8sPyG5fSs5W0g67p+n1qPj0MvG2fgos/fZVZ7rWc04C6GeKptkRPsVY4ZJaudhZDcE7pHsYs5oizL7XOhO8Ic5mGHXLpm4UWhcn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rkfPwR6+; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rkfPwR6+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760410624; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=i0jVK9tDIg9IsxCsaGFsBAUEMszAXfkKjs3QSzbgtoM=;
	b=rkfPwR6+bUH8xDIRTbhN9UKTUo+jA+emCXdmbYpoPG5hCshHbeFjdOWSb37AyglMVK89r1lShIZxFMBmfU9TT6XJRTOWFtH5e5XucSjRMv6yJzYbzLd5oc4GlK2ln1a500jPOaGpiTgv1fWrnIgbqt0+yB9/SU3z2J9mZjeNW2c=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wq9ucfr_1760410623 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 10:57:03 +0800
Message-ID: <1760410611.871382-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 0/3] fixes two virtio-net related bugs.
Date: Tue, 14 Oct 2025 10:56:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 Heng Qi <hengqi@linux.alibaba.com>,
 virtualization@lists.linux.dev
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEugrT0K3LcJsPaN6FDncvBgXRLkG6By8scm8PyABF2BUA@mail.gmail.com>
In-Reply-To: <CACGkMEugrT0K3LcJsPaN6FDncvBgXRLkG6By8scm8PyABF2BUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 13 Oct 2025 13:56:58 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 13, 2025 at 10:06=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > As discussed in http://lore.kernel.org/all/20250919013450.111424-1-xuan=
zhuo@linux.alibaba.com
> > Commit #1 Move the flags into the existing if condition; the issue is t=
hat it introduces a
> > small amount of code duplication.
> >
> > Commit #3 is new to fix the hdr len in tunnel gso feature.
> >
> > Hi @Paolo Abenchi,
> > Could you please test commit #3? I don't have a suitable test environme=
nt, as
> > QEMU doesn't currently support the tunnel GSO feature.
>
> It has been there.

Maybe I missed it.

Thanks.


>
> Thanks
>
> >
> > Thanks.
> >
> > Xuan Zhuo (3):
> >   virtio-net: fix incorrect flags recording in big mode
> >   virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
> >   virtio-net: correct hdr_len handling for tunnel gso
> >
> >  drivers/net/virtio_net.c   | 16 ++++++++-----
> >  include/linux/virtio_net.h | 46 ++++++++++++++++++++++++++++++++------
> >  2 files changed, 50 insertions(+), 12 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>
