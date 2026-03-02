Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966EE425CC1
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474135; cv=none; b=rQBhLbUS21VlzP+Yc8I0BMtBpTHdhFg2yr24kVNzqBdY1cEOn8VvyUSPoIbAndBHx6uglK55JgqrfrvY/RGpsmrUXTtE0FoN4+7VLlCF60IJDkA1BYJOY+VeSV9MwTTgFKszIEjWkcC6xr7HN/s2dA3O/3+grnYaZHs6oOQMdkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474135; c=relaxed/simple;
	bh=peR5Zc8Y4ObVAhfCSybvnP/nGrD+OkxEkgiCzbx1kUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmvqYw4CO9yS12/SWh/tMGjPHktI2xR4LqsVzU4saySoDfMy7ZWsK7aKrx3nVoeOVALs82FP76O59bJNZ2W1nZUheesF7BUsMk4m2Faa+rJhkcku+IXhPGzK1rAyKnRPcqLBemnAt0EiAJa9QgmFK7nanH6oWCOt3J+DwASq+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx7UI-0000h1-Lh; Mon, 02 Mar 2026 18:55:22 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx7UE-003Q09-1S;
	Mon, 02 Mar 2026 18:55:19 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6BD1B4F5684;
	Mon, 02 Mar 2026 17:55:19 +0000 (UTC)
Date: Mon, 2 Mar 2026 18:55:19 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-can@vger.kernel.org, virtualization@lists.linux.dev, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
Message-ID: <20260302-idealistic-puffin-of-valor-b23733-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <aZRB7Reu/D6HvRcb@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ctag23wbpxqdtfo"
Content-Disposition: inline
In-Reply-To: <aZRB7Reu/D6HvRcb@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: virtualization@lists.linux.dev


--7ctag23wbpxqdtfo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10] can: virtio: Add virtio CAN driver
MIME-Version: 1.0

On 17.02.2026 11:24:45, Matias Ezequiel Vara Larsen wrote:
> +static void virtio_can_start(struct net_device *ndev)
> +{
> +	struct virtio_can_priv *priv =3D netdev_priv(ndev);
> +	u8 result;
> +
> +	result =3D virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_STAR=
T);
> +	if (result !=3D VIRTIO_CAN_RESULT_OK)
> +		netdev_err(ndev, "CAN controller start failed\n");

propagate the error value and evaluate it in the caller

[...]

> +static void virtio_can_stop(struct net_device *ndev)
> +{
> +	struct virtio_can_priv *priv =3D netdev_priv(ndev);
> +	struct device *dev =3D &priv->vdev->dev;
> +	u8 result;
> +
> +	result =3D virtio_can_send_ctrl_msg(ndev, VIRTIO_CAN_SET_CTRL_MODE_STOP=
);
> +	if (result !=3D VIRTIO_CAN_RESULT_OK)
> +		dev_err(dev, "CAN controller stop failed\n");

propagate the error value and evaluate it in the caller

> +
> +	priv->busoff_pending =3D false;
> +	priv->can.state =3D CAN_STATE_STOPPED;
> +
> +	/* Switch carrier off if device was connected to the bus */
> +	if (netif_carrier_ok(ndev))
> +		netif_carrier_off(ndev);
> +}

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7ctag23wbpxqdtfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaXPBAAKCRDMOmT6rpmt
0sNKAQDbTjYRHJWn25iPrwKX+WuFCeZM8bwBGFpoul6nh9Za/AD+NP2ZTRereYFv
vtQKECmg5LxIRzUYoXi14AnYJ7aoNwM=
=x/53
-----END PGP SIGNATURE-----

--7ctag23wbpxqdtfo--
