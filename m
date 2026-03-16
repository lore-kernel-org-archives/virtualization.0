Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612639A066
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669464; cv=none; b=rhzSULV1hEFkyYq2M2qZIxQuApox7yQxH0A9XX7WnLihm1pANnUUn/HEP/WfE4/pe6vBf/TKFB6OIeuUQ940z+WeeV/FqjGZqQneDRTpn81cpE2zHui8O8lLN2gPq7dby6DO4iJowUTGRLlpgnbplelaVbeMKbQzbGRG+KVHPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669464; c=relaxed/simple;
	bh=P5eHDYZ8LlWXr6c8qhb7Gx1nUKD9WeEG+F9QIlpgDWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FPZFvtmLDVTatr1rLoKQv6JZ49EpfPbL3X6P7ReblXqbDFj3/Vcmb7Ib85h5PXwGFVvGt3o97iwTR2tmh/W5wPInM5cFBrSa2uFNqQdFYzoZ0bpXn3fEnMlx8Pg/gKBsEW1ykB8aZMgLO99RvPWL3ogfI+2/Ih+BZ+BWpOxpXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4fZGql6wnJzrbrD;
	Mon, 16 Mar 2026 21:57:23 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4fZGqk6SskzrbrD;
	Mon, 16 Mar 2026 21:57:22 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 13F67AE35;
	Mon, 16 Mar 2026 21:57:19 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 16 Mar
 2026 21:57:22 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Mon, 16 Mar 2026 21:57:22 +0800
From: Zhud <zhud@hygon.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"willemb@google.com" <willemb@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, Jing Li <lijing@hygon.cn>, Zhiwei Ying
	<yingzhiwei@hygon.cn>
Subject: RE: [PATCH net-next v2] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Thread-Topic: [PATCH net-next v2] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Thread-Index: AQHctRWZ2ojSo6zfekKUjfvJ+iW5wbWwWqSAgACMBDD//43AAIAAnuoQ//+OZQCAAIguYA==
Date: Mon, 16 Mar 2026 13:57:22 +0000
Message-ID: <4e3ce2d6120545719a286d3daafbef38@hygon.cn>
References: <20260316072152.910857-1-zhud@hygon.cn>
 <20260316051327-mutt-send-email-mst@kernel.org>
 <607818aba89a44d88afa213f39611451@hygon.cn>
 <20260316063139-mutt-send-email-mst@kernel.org>
 <a82cd6088e554fe1bb3daa6ad3df18dc@hygon.cn>
 <20260316092707-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260316092707-mutt-send-email-mst@kernel.org>
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

 > On Mon, Mar 16, 2026 at 12:57:00PM +0000, Zhud wrote:
> > > On Mon, Mar 16, 2026 at 10:18:04AM +0000, Zhud wrote:
> > > > > Thanks! Yes something to improve:
> > > > >
> > > > > On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> > > > > > Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which
> > > > > > indicates the device supports dynamic control of guest
> > > > > > offloads, it does not necessarily mean the device supports
> > > > > > specific hardware GRO
> > > features.
> > > > > >
> > > > > > If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK
> > > > > > (such as TSO4, TSO6, or UFO) are present in
> > > > > > vi->guest_offloads_capable, the device effectively lacks the ha=
rdware
> capability to perform GRO.
> > > > >
> > > > > So what is the user-visible problem this is trying to address?
> > > >
> > > > A key concern is that once a user enables NETIF_F_GRO_HW via
> > > > ethtool, they might manually disable software GRO (ethtool -K eth0
> > > > gro off) assuming the hardware is now handling the aggregation.
> > >
> > > Thanks!
> > > Sorry could you be even more specific please?
> > > Is this a theoretical concern or did some users encounter this?
> > > Note that NETIF_F_GRO_HW is best effort anyway: e.g.
> > > it can apply only to TCPv6 and v4 will still need software.
> >
> > This might not be the best example, but I want to draw an analogy to
> > show how this hardware offload capability can be misleading. For
> > instance, if I enable GRO_HW expecting to see lower CPU usage when
> > receiving packets, but it doesn't happen, that would be very confusing.
>=20
> It still can happen if hardware does not offload the specific traffic, ye=
s?

Yes, of course, but there's still a difference between "best-effort" and "n=
o-effort." Right?

>=20
> > > > Secondly, while we haven't encountered a specific hardware failure
> > > > yet, enabling a hardware offload feature that the DPU does not
> > > > physically support introduces the risk of undefined hardware
> > > > behavior
> > >
> > > This would be a major concern but I don't get it - how would one trig=
ger this?
> > > It seems that guest_offloads_capable only includes offloads actually =
supported.
> >
> > You're absolutely right. Upon rechecking the code,
> > virtnet_set_features already ensures that only bits within
> vi->guest_offloads_capable are sent to the device.
> > Thank you for pointing that out.
> >
> > > > > >
> > > > > > So, making NETIF_F_GRO_HW conditional on these feature bits
> > > > > > ensures the stack does not enable an unsupported hardware
> > > > > > offload
> > > configuration.
> > > > >
> > > > > I guess the assumption is that without this, something enables
> > > > > such a config? Which stack is this and what happens then?
> > > > >
> > > >
> > > > Sorry for the confusion, let me clarify the intent.
> > > > The 'stack' here refers to the ethtool interface and the netset (io=
ctl/netlink)
> path.
> > >
> > >
> > > A bit more detail about the specific set of commands that leads to
> > > confusion in the commit log would be helpful.
> >
> > > Thanks!
> > >
> > > > >
> > > > > > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > > > > > Signed-off-by: Di Zhu <zhud@hygon.cn>
> > > > >
> > > > > judging by this, has something to do with LRO?
> > > > >
> > > > > > ---
> > > > > > /* v2 */
> > > > > >   -make the modified logic clearer
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 6 ++++--
> > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c
> > > > > > b/drivers/net/virtio_net.c index
> > > > > > 72d6a9c6a5a2..b233c99925e9 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_de=
vice
> *vdev)
> > > > > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > > > >  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > > > >  		dev->features |=3D NETIF_F_GRO_HW;
> > > > > > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS=
))
> > > > > > -		dev->hw_features |=3D NETIF_F_GRO_HW;
> > > > > >
> > > > > >  	dev->vlan_features =3D dev->features;
> > > > > >  	dev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > > > > NETDEV_XDP_ACT_REDIRECT |
> > > > > > @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_d=
evice
> *vdev)
> > > > > >  	}
> > > > > >  	vi->guest_offloads_capable =3D vi->guest_offloads;
> > > > > >
> > > > > > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS=
)
> &&
> > > > > > +	    (vi->guest_offloads_capable &
> GUEST_OFFLOAD_GRO_HW_MASK))
> > > > > > +		dev->hw_features |=3D NETIF_F_GRO_HW;
> > > > > > +
> > > > > >  	rtnl_unlock();
> > > > > >
> > > > > >  	err =3D virtnet_cpu_notif_add(vi);
> > > > > > --
> > > > > > 2.34.1
> > > > > >
> > > > >
> > > >
> > >
> >
>=20


