Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F33E462
	for <virtualization@lists.linux.dev>; Mon,  4 Mar 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559927; cv=none; b=sF/cTlUzSck3a5qvTKAQ3hNnWKRREt84m8i41GskHuHNcwBMSIsb7UA75b8vm4SltuTF0hcn6n+MM6Kh9ky/VMwhbSW7v0j1UH9enivYJm+rGCFSiKt2ZTWPROzNR/x2rfmeDwAE1ka6f3bHyw4eP4p3nS8vT0z3qZAFCAxtYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559927; c=relaxed/simple;
	bh=Vogrl90LPvlwp2Ghw/yIzr9IKjNdfq8ALbuzUCNGjqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BN8XS3akaYafwzDYsEybEMmow7gsf9bfqRKy8+uO63Zn8B9hns/M3JE5mh0KLp9gvl3JWemrX9xupkbzQSc+vYBz2rtnUvBvwzvoQ6Iob8NEhwBbTws+DFK/FqFjiJ051ob3o8z1yfRamTaCGiAitqpY3aqIZHlusd70e+/bBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TpKdf3B0Sz1Q9mN;
	Mon,  4 Mar 2024 21:43:02 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 414801A016E;
	Mon,  4 Mar 2024 21:45:22 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 21:45:21 +0800
Received: from dggpemm500008.china.huawei.com ([7.185.36.136]) by
 dggpemm500008.china.huawei.com ([7.185.36.136]) with mapi id 15.01.2507.035;
 Mon, 4 Mar 2024 21:45:21 +0800
From: wangyunjian <wangyunjian@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>
CC: Paolo Abeni <pabeni@redhat.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"bjorn@kernel.org" <bjorn@kernel.org>, "magnus.karlsson@intel.com"
	<magnus.karlsson@intel.com>, "maciej.fijalkowski@intel.com"
	<maciej.fijalkowski@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, xudingke
	<xudingke@huawei.com>, "liwei (DT)" <liwei395@huawei.com>
Subject: RE: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
Thread-Topic: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
Thread-Index: AQHaajYcNkJKJoTBfEqyMPzDlwSi+bEgpeYAgAIJPRD//5RegIAFWUkg
Date: Mon, 4 Mar 2024 13:45:21 +0000
Message-ID: <ffbe60c2732842a3b81e6ae0f58d2556@huawei.com>
References: <1709118356-133960-1-git-send-email-wangyunjian@huawei.com>
 <7d478cb842e28094f4d6102e593e3de25ab27dfe.camel@redhat.com>
 <223aeca6435342ec8a4d57c959c23303@huawei.com>
 <20240301065141-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240301065141-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Friday, March 1, 2024 7:53 PM
> To: wangyunjian <wangyunjian@huawei.com>
> Cc: Paolo Abeni <pabeni@redhat.com>; willemdebruijn.kernel@gmail.com;
> jasowang@redhat.com; kuba@kernel.org; bjorn@kernel.org;
> magnus.karlsson@intel.com; maciej.fijalkowski@intel.com;
> jonathan.lemon@gmail.com; davem@davemloft.net; bpf@vger.kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org=
;
> virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>; liwei (DT=
)
> <liwei395@huawei.com>
> Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy support
>=20
> On Fri, Mar 01, 2024 at 11:45:52AM +0000, wangyunjian wrote:
> > > -----Original Message-----
> > > From: Paolo Abeni [mailto:pabeni@redhat.com]
> > > Sent: Thursday, February 29, 2024 7:13 PM
> > > To: wangyunjian <wangyunjian@huawei.com>; mst@redhat.com;
> > > willemdebruijn.kernel@gmail.com; jasowang@redhat.com;
> > > kuba@kernel.org; bjorn@kernel.org; magnus.karlsson@intel.com;
> > > maciej.fijalkowski@intel.com; jonathan.lemon@gmail.com;
> > > davem@davemloft.net
> > > Cc: bpf@vger.kernel.org; netdev@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>;
> > > liwei (DT) <liwei395@huawei.com>
> > > Subject: Re: [PATCH net-next v2 3/3] tun: AF_XDP Tx zero-copy
> > > support
> > >
> > > On Wed, 2024-02-28 at 19:05 +0800, Yunjian Wang wrote:
> > > > @@ -2661,6 +2776,54 @@ static int tun_ptr_peek_len(void *ptr)
> > > >  	}
> > > >  }
> > > >
> > > > +static void tun_peek_xsk(struct tun_file *tfile) {
> > > > +	struct xsk_buff_pool *pool;
> > > > +	u32 i, batch, budget;
> > > > +	void *frame;
> > > > +
> > > > +	if (!ptr_ring_empty(&tfile->tx_ring))
> > > > +		return;
> > > > +
> > > > +	spin_lock(&tfile->pool_lock);
> > > > +	pool =3D tfile->xsk_pool;
> > > > +	if (!pool) {
> > > > +		spin_unlock(&tfile->pool_lock);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	if (tfile->nb_descs) {
> > > > +		xsk_tx_completed(pool, tfile->nb_descs);
> > > > +		if (xsk_uses_need_wakeup(pool))
> > > > +			xsk_set_tx_need_wakeup(pool);
> > > > +	}
> > > > +
> > > > +	spin_lock(&tfile->tx_ring.producer_lock);
> > > > +	budget =3D min_t(u32, tfile->tx_ring.size, TUN_XDP_BATCH);
> > > > +
> > > > +	batch =3D xsk_tx_peek_release_desc_batch(pool, budget);
> > > > +	if (!batch) {
> > >
> > > This branch looks like an unneeded "optimization". The generic loop
> > > below should have the same effect with no measurable perf delta - and
> smaller code.
> > > Just remove this.
> > >
> > > > +		tfile->nb_descs =3D 0;
> > > > +		spin_unlock(&tfile->tx_ring.producer_lock);
> > > > +		spin_unlock(&tfile->pool_lock);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	tfile->nb_descs =3D batch;
> > > > +	for (i =3D 0; i < batch; i++) {
> > > > +		/* Encode the XDP DESC flag into lowest bit for consumer to
> differ
> > > > +		 * XDP desc from XDP buffer and sk_buff.
> > > > +		 */
> > > > +		frame =3D tun_xdp_desc_to_ptr(&pool->tx_descs[i]);
> > > > +		/* The budget must be less than or equal to tx_ring.size,
> > > > +		 * so enqueuing will not fail.
> > > > +		 */
> > > > +		__ptr_ring_produce(&tfile->tx_ring, frame);
> > > > +	}
> > > > +	spin_unlock(&tfile->tx_ring.producer_lock);
> > > > +	spin_unlock(&tfile->pool_lock);
> > >
> > > More related to the general design: it looks wrong. What if
> > > get_rx_bufs() will fail (ENOBUF) after successful peeking? With no
> > > more incoming packets, later peek will return 0 and it looks like
> > > that the half-processed packets will stay in the ring forever???
> > >
> > > I think the 'ring produce' part should be moved into tun_do_read().
> >
> > Currently, the vhost-net obtains a batch descriptors/sk_buffs from the
> > ptr_ring and enqueue the batch descriptors/sk_buffs to the
> > virtqueue'queue, and then consumes the descriptors/sk_buffs from the
> > virtqueue'queue in sequence. As a result, TUN does not know whether
> > the batch descriptors have been used up, and thus does not know when to
> return the batch descriptors.
> >
> > So, I think it's reasonable that when vhost-net checks ptr_ring is
> > empty, it calls peek_len to get new xsk's descs and return the descript=
ors.
> >
> > Thanks
>=20
> What you need to think about is that if you peek, another call in paralle=
l can get
> the same value at the same time.

Thank you. I have identified a problem. The tx_descs array was created with=
in xsk's pool.
When xsk is freed, the pool and tx_descs are also freed. Howerver, some des=
cs may
remain in the virtqueue'queue, which could lead to a use-after-free scenari=
o. Currently,
I do not have an idea to solve this concurrency problem and believe this sc=
enario may
not be appropriate for reusing the ptr_ring.

Thanks

>=20
>=20
> > >
> > > Cheers,
> > >
> > > Paolo
> >

