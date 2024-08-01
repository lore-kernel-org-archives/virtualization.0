Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79519538D
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515896; cv=none; b=BZApdfLz7ROfL1EfY7u9oEpX+rPodcdzIZqY3TqRg04qQKgu1heErlslRth8ydyOwqReuB0XJP7us0jg1OfNanKS7z2VOjSiDQtacQjpr9ZbVB7HG6atv3CyJVAkTXzfB4wRYVpFCfI5d+6kH8SYSlunwbnESYOgvp61M32KsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515896; c=relaxed/simple;
	bh=qWURU8q2eehi2DoM1j1WnhP4LCxxD26U5ssz2nCeYsQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=lCzQcvzV6zNDt4dMzCsiMUwsYokqB6Wr/XBo0BIhC2shbsbAXsgZTWe2FD0A84whSmDKzkL4LXPHgp/T3/X9LWV7DMD5R0vHZxv3OwbzCDwaxCc542nGHgKtH6cHiBbK0VaRGGH34kt30MJBxxkLLUyuiDzpsQO9EUk/+piyjgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g8iIxoxT; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g8iIxoxT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722515885; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=NVZltom0B0Pttpv0J8vNgmpW8bzuitgaHFisNXxFNhU=;
	b=g8iIxoxTN2oJMFXPSf7lCTay+GeeswsoR4cKYFxAP66T2pPWVULM82Tp/3VxPIHSQSEcNgpQUlvQ/WpK0bsgwjd5Ln3HGIsS4eacQYJD/WgXpxG+zu4Izp6U0fsp6m+104k8p00IV/Cm5gRk0vxODb0Go6gVQbcb+s/pifMlUY0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBtRfL4_1722515881;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtRfL4_1722515881)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 20:38:02 +0800
Message-ID: <1722515836.8565578-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net v3 2/2] virtio-net: unbreak vq resizing when coalescing is not negotiated
Date: Thu, 1 Aug 2024 20:37:16 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 virtualization@lists.linux.dev,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240801122739.49008-1-hengqi@linux.alibaba.com>
 <20240801122739.49008-3-hengqi@linux.alibaba.com>
 <20240801082947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240801082947-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 1 Aug 2024 08:30:44 -0400, "Michael S. Tsirkin" <mst@redhat.com> wr=
ote:
> On Thu, Aug 01, 2024 at 08:27:39PM +0800, Heng Qi wrote:
> > Don't break the resize action if the vq coalescing feature
> > named VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated.
> >=20
> > Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq =
resize")
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Eugenio P=C3=A9 rez <eperezma@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> > v2->v3:
> >   - Break out the feature check and the fix into separate patches.
> >=20
> > v1->v2:
> >   - Rephrase the subject.
> >   - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_c=
md().
> >=20
> >  drivers/net/virtio_net.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index b1176be8fcfd..2b566d893ea3 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3749,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
> >  			err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> >  							       vi->intr_coal_tx.max_usecs,
> >  							       vi->intr_coal_tx.max_packets);
> > -			if (err)
> > +			if (err && err !=3D -EOPNOTSUPP)
> >  				return err;
> >  		}
> > =20
> > @@ -3764,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
> >  							       vi->intr_coal_rx.max_usecs,
> >  							       vi->intr_coal_rx.max_packets);
> >  			mutex_unlock(&vi->rq[i].dim_lock);
> > -			if (err)
> > +			if (err && err !=3D -EOPNOTSUPP)
> >  				return err;
>=20
>=20
> This needs a comment.
>=20

Since both the patch and the comment are small, I will send out the next ve=
rsion
soon and hope to get the understanding of the netdev maintainers.

Thanks.

>=20
> >  		}
> >  	}
> > --=20
> > 2.32.0.3.g01195cf9f
>=20
