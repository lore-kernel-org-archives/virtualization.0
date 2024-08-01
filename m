Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B33ECF
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492585; cv=none; b=B/Ac8pSqM3qNzIXw/En8xQ3UpytMlGoJoEzkGV9QHkt9XtIL19mQWRCuSz/l+sXnPANE3mTIZgzTL+Yiv9YGhC3yS7p55dEhr5evIf4KqoQh+O0BybGdnLqCjYB/8XpxAjZb+EJLt0jQKrCWp6s2WNkz3GjTJ4FP54W1AOcfnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492585; c=relaxed/simple;
	bh=k9T9EYRAowwp1dNZKg6r/9QvFhaJ1+1cYLS1xDNixUM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=IVQAd9l7jISswWRIUtHEKgwnRg6Y3wvD7xfpq4+Ob+DGpTfeO/6a/eosAZlrOqyydJK7lDUiW26Wul4bRCqpIukqTaSPXVHJcStmn+N9aItxZ5RzamKNMGsqJN1o3FyFRjyZdFyp5S+Nc03cIzZbde+LwCUUgZil3WWuLdmaFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=enQ6FSGE; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="enQ6FSGE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722492580; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=WsSIOlFcoYYt4baJ34rOD3K8h8fOuLuNR7VQFEhP1uQ=;
	b=enQ6FSGEvdoE5U8K4mz3vmiB5CoarkBkkco2VHZzpFiOJIM/9lrtuZFPk0sCf+u/XxoZ/7ejCc/Kew+Ha4sAHP4lNH/t/bVHMik4sExbX6KZDMOpoxV3fyW7W4vds62EV1PogB43NnZNDchP/Y9snDILV/F9BwI2SXyNoHJlZkM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBoT2kL_1722492578;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBoT2kL_1722492578)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 14:09:39 +0800
Message-ID: <1722492463.6573224-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net v2] virtio-net: unbreak vq resizing when coalescing is not negotiated
Date: Thu, 1 Aug 2024 14:07:43 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 =?utf-8?q?EugenioP=C3=A9rez?= <eperezma@redhat.com>
References: <20240731120717.49955-1-hengqi@linux.alibaba.com>
 <20240731081409-mutt-send-email-mst@kernel.org>
 <1722428723.505313-1-hengqi@linux.alibaba.com>
 <20240731084632-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240731084632-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 31 Jul 2024 08:46:42 -0400, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Wed, Jul 31, 2024 at 08:25:23PM +0800, Heng Qi wrote:
> > On Wed, 31 Jul 2024 08:14:43 -0400, "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
> > > On Wed, Jul 31, 2024 at 08:07:17PM +0800, Heng Qi wrote:
> > > > >From the virtio spec:
> > > >=20
> > > > 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> > > > 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> > > > 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> > > >=20
> > > > The driver must not send vq notification coalescing commands if
> > > > VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of cou=
rse
> > > > applies to vq resize.
> > > >=20
> > > > Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for=
 vq resize")
> > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Acked-by: Eugenio P=C3=A9 rez <eperezma@redhat.com>
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > > v1->v2:
> > > >  - Rephrase the subject.
> > > >  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_v=
q_cmd().
> > > >=20
> > > >  drivers/net/virtio_net.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 0383a3e136d6..2b566d893ea3 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -3658,6 +3658,9 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(s=
truct virtnet_info *vi,
> > > >  {
> > > >  	int err;
> > > > =20
> > > > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > >  	err =3D virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> > > >  					    max_usecs, max_packets);
> > > >  	if (err)
> > > > @@ -3675,6 +3678,9 @@ static int virtnet_send_tx_ctrl_coal_vq_cmd(s=
truct virtnet_info *vi,
> > > >  {
> > > >  	int err;
> > > > =20
> > > > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > >  	err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> > > >  					    max_usecs, max_packets);
> > > >  	if (err)
> > > > @@ -3743,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_d=
evice *dev,
> > > >  			err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> > > >  							       vi->intr_coal_tx.max_usecs,
> > > >  							       vi->intr_coal_tx.max_packets);
> > > > -			if (err)
> > > > +			if (err && err !=3D -EOPNOTSUPP)
> > > >  				return err;
> > > >  		}
> > > >
> > >=20
> > >=20
> > > So far so good.
> > >  =20
> > > > @@ -3758,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_d=
evice *dev,
> > > >  							       vi->intr_coal_rx.max_usecs,
> > > >  							       vi->intr_coal_rx.max_packets);
> > > >  			mutex_unlock(&vi->rq[i].dim_lock);
> > > > -			if (err)
> > > > +			if (err && err !=3D -EOPNOTSUPP)
> > > >  				return err;
> > > >  		}
> > > >  	}
> > >=20
> > > I don't get this one. If resize is not supported,
> >=20
> > Here means that the *dim feature* is not supported, not the *resize* fe=
ature.
> >=20
> > > we pretend it was successful? Why?
> >=20
> > During a resize, if the dim feature is not supported, the driver does n=
ot
> > need to try to recover any coalescing values, since the device does not=
 have
> > these parameters.
> > Therefore, the resize should continue without interruption.
> >=20
> > Thanks.
>=20
>=20
> you mean it's a separate bugfix?

Right.

Don't break resize when coalescing is not negotiated.

Thanks.

>=20
> > >=20
> > > > --=20
> > > > 2.32.0.3.g01195cf9f
> > >=20
>=20
