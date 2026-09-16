Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC33347BC4;
	Wed, 16 Sep 2026 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596365; cv=none; b=X6WXVdgULII3kP5B/K3o2EmFP/22XRKHJPyhyuqQfP15sShZi+Se038P4hq3ujx5TrbEivxjYnxMVr4zulj7Zvth/peHgv8zQYR64BFpsaOrQzaAt2gXP73TCKJjZ03qSznERyU19XGdW2haytnbJl4tWs2Y7O2lwZHsOpnxHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596365; c=relaxed/simple;
	bh=Xb4MKcnaALu2Rd/YZIsSOYVPfGEWIQJNk4HWg4lMdaw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N3qqeDi17AbYX8axaJPMbt7tibOhRy/+x/2QYuManFjeFDusTaPk4/4H05reRaK3V84Lkv+q2blsw/7kYDimP/H8U77R6yW9JeQFXw4VCIQtRQYLJ255ibApxQxcxBRYFaHjmSKqohcHTHki5pDws3165YDXSpl/ANSwwZEGBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djcfwnSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djcfwnSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08551F000FF;
	Wed, 16 Sep 2026 22:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596354;
	bh=+12P79pT3iD9dGsIfn0ExlhQE/WvzcLpi21fFxB7ZUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=djcfwnSaNN2sB1JenlgMwVl/UH/ObokPVO9OZdSla0LSlTgmcexdAr0/88piCjcqp
	 PguO0EV6EjzRb0TuGlu5ACblIXunSSGXH5kCVsAQiBc/h4w1+SxFDXmfXFvMTWv4rO
	 2wIPdtdNd2o1gi1Ev34JxAuCI1Xk5vGOalqXWRi8bvTFPpNEad3aW0Uv1DQdq9hEn+
	 Gz/sdiOzJS5pub0t8bjNpuJAJr8iWXzT40ixCuTdMCGu/5wPeVtEoxECpTqzTeIKBg
	 568Lohg22hj0Y+mNhDghIlRA6BgoGSh5usD2ri7JiC23BBHgchg8ssCHPfTM84HkLl
	 jNuMJQRD9cWOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/12] remoteproc: imx_rproc: always use
 non-blocking mailboxes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: Frank.Li@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, imx@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260916-remoteproc_virtio_map-v1-10-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-10-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:05:53 +0000
Message-Id: <20260916220553.A08551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] remoteproc: stack use-after-free in imx_rproc_kick() due to non-bl=
ocking mailbox
--

commit c47129240ff337ab849e03d40342b679177d2bcf
Author: Francesco Valla <francesco@valla.it>

remoteproc: imx_rproc: always use non-blocking mailboxes

This commit changes the imx_rproc mailbox to non-blocking mode to prevent
sleeping during kick operations, aligning the behavior with other remoteproc
drivers. It also removes the close-reopen action on the mailboxes during
restart and shutdown.

> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rpro=
c.c
> index 745ce52cd8226..100440328f92e 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
[ ... ]
> @@ -877,7 +877,7 @@ static void imx_rproc_rx_callback(struct mbox_client =
*cl, void *msg)
>  	queue_work(priv->workqueue, &priv->rproc_work);
>  }
> =20
> -static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)
> +static int imx_rproc_xtr_mbox_init(struct rproc *rproc)
>  {
>  	struct imx_rproc *priv =3D rproc->priv;
>  	struct device *dev =3D priv->dev;
> @@ -900,7 +900,7 @@ static int imx_rproc_xtr_mbox_init(struct rproc *rpro=
c, bool tx_block)
> =20
>  	cl =3D &priv->cl;
>  	cl->dev =3D dev;
> -	cl->tx_block =3D tx_block;
> +	cl->tx_block =3D false;

[Severity: High]
With the mailbox permanently changed to asynchronous/non-blocking mode,
mbox_send_message() will now return immediately without waiting for
transmission to complete.

Does this cause a stack use-after-free when the remote processor is kicked?
Looking at imx_rproc_kick():

static void imx_rproc_kick(struct rproc *rproc, int vqid)
{
	...
	__u32 mmsg;
	...
	mmsg =3D vqid << 16;
	err =3D mbox_send_message(priv->tx_ch, (void *)&mmsg);
	...
}

Because mmsg is allocated on the stack, queuing its pointer for asynchronous
transmission means the mailbox framework could dereference the pointer and
read garbage from the destroyed stack frame after imx_rproc_kick() returns.
This could crash the remote core or disrupt IPC.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D10
