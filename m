Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30937C77B76
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 21:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8AC1400EF;
	Mon, 24 Apr 2023 21:09:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8AC1400EF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZfnipAAC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dkLKYCoeLtDV; Mon, 24 Apr 2023 21:09:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 03903404BF;
	Mon, 24 Apr 2023 21:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03903404BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3CDBC0036;
	Mon, 24 Apr 2023 21:09:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09504C0036
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF257408B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:09:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF257408B9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZfnipAAC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5rZboP2s3WyK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:09:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FE9940864
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FE9940864
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 21:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682370570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2DIw9E0DWGPudpd861Kjkn+cGauwIMc/nQBn5q2geI=;
 b=ZfnipAACu4Y+gzAn8d8ChCn6ivRv5P8CFPPDnUw4QPFOp46ex7utZuTQrGGnbnMzI4nV5G
 AQ4xFXzF+OvzLmUczXsGgOQeCOfuvPb3W27YLcLa3W+6jpmMME5Ts2wFU6CGObB1n/H9jT
 04exScTtKAmNrBYOnkBfWq0Jv4AUzVE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-DdPgIOy3NB-sAcl9AOJpxA-1; Mon, 24 Apr 2023 17:09:29 -0400
X-MC-Unique: DdPgIOy3NB-sAcl9AOJpxA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2f625d521abso2667208f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 14:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682370568; x=1684962568;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l2DIw9E0DWGPudpd861Kjkn+cGauwIMc/nQBn5q2geI=;
 b=D+9uWYGHzxL3oYVvLiNQqTbSdzkjjANyzZP6g/CN0FfmqpBadveqpzl7CsKZpQkfNP
 XvshnfzX6VVxwJCODepIeNIbngrCtbUEuiNw1b/CEqzCcrsvADxkgSmuzAkvh/FAQHCv
 vsY+U0sgoAOPV5qhtQQR/n3AtZnTvX94wig+jRiLRimkzmFNtxf+FL6lkolERxGx5UY7
 1RI1A1Bltv0T1uIqoIfaF3wyDpCcyTs2P4CBxXNPI2MJPLrvAvD+XAyRTq5uR5ayB4rz
 tT+vfRoN4wfASPDQvxmi1/KYmotwWmr0oRrC+ZnTA4WSa7uEjG1Y5pXXFZxRGwA6nxVc
 Ap4g==
X-Gm-Message-State: AAQBX9eq38fJ6uxbpqMzGm1mS2O1lQhNi1Vbr0EuP7q9uPO0q/zdekLd
 e1pgZsBqaavErmjGbfCMPe5V1Sxc+2dV8d/r/tWSiDagpZZZmTB4kiKEmkjOKVdVzMfbYCt2rQb
 ubwEuhELQAJEVlocP4zYBuZRz7qd3qzNpouDeeadA/A==
X-Received: by 2002:a5d:404e:0:b0:2f8:2d4:74ef with SMTP id
 w14-20020a5d404e000000b002f802d474efmr10698168wrp.43.1682370568254; 
 Mon, 24 Apr 2023 14:09:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350YHMM9T0V0+QlHyo0phBynPWZ5d4SFmalLRfzRfQMsm6PgmZ6pd6ITCa8CU1e9IDifaQL432g==
X-Received: by 2002:a5d:404e:0:b0:2f8:2d4:74ef with SMTP id
 w14-20020a5d404e000000b002f802d474efmr10698158wrp.43.1682370567918; 
 Mon, 24 Apr 2023 14:09:27 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 j14-20020adfea4e000000b002fc3d8c134bsm11560929wrn.74.2023.04.24.14.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Apr 2023 14:09:27 -0700 (PDT)
Date: Mon, 24 Apr 2023 17:09:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: virtio-can: cleanups
Message-ID: <20230424170901-mutt-send-email-mst@kernel.org>
References: <20230424-modular-rebate-e54ac16374c8-mkl@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20230424-modular-rebate-e54ac16374c8-mkl@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, Paolo Abeni <pabeni@redhat.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Harald Mommer <harald.mommer@opensynergy.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 "David S . Miller" <davem@davemloft.net>,
 Wolfgang Grandegger <wg@grandegger.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Apr 24, 2023 at 09:47:58PM +0200, Marc Kleine-Budde wrote:
> Address the topics raised in
> =

> https://lore.kernel.org/20230424-footwear-daily-9339bd0ec428-mkl@pengutro=
nix.de
> =

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

given base patch is rfc this should be too?

> ---
>  drivers/net/can/Makefile        |  4 +--
>  drivers/net/can/virtio_can.c    | 56 ++++++++++++++-------------------
>  include/uapi/linux/virtio_can.h |  4 +--
>  3 files changed, 28 insertions(+), 36 deletions(-)
> =

> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index e409f61d8e93..19314adaff59 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -17,8 +17,8 @@ obj-$(CONFIG_CAN_AT91)		+=3D at91_can.o
>  obj-$(CONFIG_CAN_BXCAN)		+=3D bxcan.o
>  obj-$(CONFIG_CAN_CAN327)	+=3D can327.o
>  obj-$(CONFIG_CAN_CC770)		+=3D cc770/
> -obj-$(CONFIG_CAN_C_CAN)		+=3D c_can/
>  obj-$(CONFIG_CAN_CTUCANFD)	+=3D ctucanfd/
> +obj-$(CONFIG_CAN_C_CAN)		+=3D c_can/
>  obj-$(CONFIG_CAN_FLEXCAN)	+=3D flexcan/
>  obj-$(CONFIG_CAN_GRCAN)		+=3D grcan.o
>  obj-$(CONFIG_CAN_IFI_CANFD)	+=3D ifi_canfd/
> @@ -30,7 +30,7 @@ obj-$(CONFIG_CAN_PEAK_PCIEFD)	+=3D peak_canfd/
>  obj-$(CONFIG_CAN_SJA1000)	+=3D sja1000/
>  obj-$(CONFIG_CAN_SUN4I)		+=3D sun4i_can.o
>  obj-$(CONFIG_CAN_TI_HECC)	+=3D ti_hecc.o
> -obj-$(CONFIG_CAN_XILINXCAN)	+=3D xilinx_can.o
>  obj-$(CONFIG_CAN_VIRTIO_CAN)	+=3D virtio_can.o
> +obj-$(CONFIG_CAN_XILINXCAN)	+=3D xilinx_can.o
>  =

>  subdir-ccflags-$(CONFIG_CAN_DEBUG_DEVICES) +=3D -DDEBUG
> diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> index 23f9c1b6446d..c11a652613d0 100644
> --- a/drivers/net/can/virtio_can.c
> +++ b/drivers/net/can/virtio_can.c
> @@ -312,13 +312,12 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_=
buff *skb,
>  	struct scatterlist sg_in[1];
>  	struct scatterlist *sgs[2];
>  	unsigned long flags;
> -	size_t len;
>  	u32 can_flags;
>  	int err;
>  	netdev_tx_t xmit_ret =3D NETDEV_TX_OK;
>  	const unsigned int hdr_size =3D offsetof(struct virtio_can_tx_out, sdu);
>  =

> -	if (can_dropped_invalid_skb(dev, skb))
> +	if (can_dev_dropped_skb(dev, skb))
>  		goto kick; /* No way to return NET_XMIT_DROP here */
>  =

>  	/* Virtio CAN does not support error message frames */
> @@ -338,27 +337,25 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_=
buff *skb,
>  =

>  	can_tx_msg->tx_out.msg_type =3D cpu_to_le16(VIRTIO_CAN_TX);
>  	can_flags =3D 0;
> -	if (cf->can_id & CAN_EFF_FLAG)
> +
> +	if (cf->can_id & CAN_EFF_FLAG) {
>  		can_flags |=3D VIRTIO_CAN_FLAGS_EXTENDED;
> +		can_tx_msg->tx_out.can_id =3D cpu_to_le32(cf->can_id & CAN_EFF_MASK);
> +	} else {
> +		can_tx_msg->tx_out.can_id =3D cpu_to_le32(cf->can_id & CAN_SFF_MASK);
> +	}
>  	if (cf->can_id & CAN_RTR_FLAG)
>  		can_flags |=3D VIRTIO_CAN_FLAGS_RTR;
> +	else
> +		memcpy(can_tx_msg->tx_out.sdu, cf->data, cf->len);
>  	if (can_is_canfd_skb(skb))
>  		can_flags |=3D VIRTIO_CAN_FLAGS_FD;
> +
>  	can_tx_msg->tx_out.flags =3D cpu_to_le32(can_flags);
> -	can_tx_msg->tx_out.can_id =3D cpu_to_le32(cf->can_id & CAN_EFF_MASK);
> -	len =3D cf->len;
> -	can_tx_msg->tx_out.length =3D len;
> -	if (len > sizeof(cf->data))
> -		len =3D sizeof(cf->data);
> -	if (len > sizeof(can_tx_msg->tx_out.sdu))
> -		len =3D sizeof(can_tx_msg->tx_out.sdu);
> -	if (!(can_flags & VIRTIO_CAN_FLAGS_RTR)) {
> -		/* Copy if not a RTR frame. RTR frames have a DLC but no payload */
> -		memcpy(can_tx_msg->tx_out.sdu, cf->data, len);
> -	}
> +	can_tx_msg->tx_out.length =3D cpu_to_le16(cf->len);
>  =

>  	/* Prepare sending of virtio message */
> -	sg_init_one(&sg_out[0], &can_tx_msg->tx_out, hdr_size + len);
> +	sg_init_one(&sg_out[0], &can_tx_msg->tx_out, hdr_size + cf->len);
>  	sg_init_one(&sg_in[0], &can_tx_msg->tx_in, sizeof(can_tx_msg->tx_in));
>  	sgs[0] =3D sg_out;
>  	sgs[1] =3D sg_in;
> @@ -895,8 +892,8 @@ static int virtio_can_probe(struct virtio_device *vde=
v)
>  	priv->tx_putidx_list =3D
>  		kcalloc(echo_skb_max, sizeof(struct list_head), GFP_KERNEL);
>  	if (!priv->tx_putidx_list) {
> -		free_candev(dev);
> -		return -ENOMEM;
> +		err =3D -ENOMEM;
> +		goto on_failure;
>  	}
>  =

>  	INIT_LIST_HEAD(&priv->tx_putidx_free);
> @@ -914,7 +911,6 @@ static int virtio_can_probe(struct virtio_device *vde=
v)
>  	vdev->priv =3D priv;
>  =

>  	priv->can.do_set_mode =3D virtio_can_set_mode;
> -	priv->can.state =3D CAN_STATE_STOPPED;
>  	/* Set Virtio CAN supported operations */
>  	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_BERR_REPORTING;
>  	if (virtio_has_feature(vdev, VIRTIO_CAN_F_CAN_FD)) {
> @@ -968,11 +964,10 @@ static int virtio_can_probe(struct virtio_device *v=
dev)
>  	return err;
>  }
>  =

> -#ifdef CONFIG_PM_SLEEP
>  /* Compare with m_can.c/m_can_suspend(), virtio_net.c/virtnet_freeze() a=
nd
>   * virtio_card.c/virtsnd_freeze()
>   */
> -static int virtio_can_freeze(struct virtio_device *vdev)
> +static int __maybe_unused virtio_can_freeze(struct virtio_device *vdev)
>  {
>  	struct virtio_can_priv *priv =3D vdev->priv;
>  	struct net_device *ndev =3D priv->dev;
> @@ -996,7 +991,7 @@ static int virtio_can_freeze(struct virtio_device *vd=
ev)
>  /* Compare with m_can.c/m_can_resume(), virtio_net.c/virtnet_restore() a=
nd
>   * virtio_card.c/virtsnd_restore()
>   */
> -static int virtio_can_restore(struct virtio_device *vdev)
> +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
>  {
>  	struct virtio_can_priv *priv =3D vdev->priv;
>  	struct net_device *ndev =3D priv->dev;
> @@ -1020,7 +1015,6 @@ static int virtio_can_restore(struct virtio_device =
*vdev)
>  =

>  	return 0;
>  }
> -#endif /* #ifdef CONFIG_PM_SLEEP */
>  =

>  static struct virtio_device_id virtio_can_id_table[] =3D {
>  	{ VIRTIO_ID_CAN, VIRTIO_DEV_ANY_ID },
> @@ -1037,18 +1031,16 @@ static unsigned int features[] =3D {
>  static struct virtio_driver virtio_can_driver =3D {
>  	.feature_table =3D features,
>  	.feature_table_size =3D ARRAY_SIZE(features),
> -	.feature_table_legacy =3D NULL,
> -	.feature_table_size_legacy =3D 0,
> -	.driver.name =3D	KBUILD_MODNAME,
> -	.driver.owner =3D	THIS_MODULE,
> -	.id_table =3D	virtio_can_id_table,
> -	.validate =3D	virtio_can_validate,
> -	.probe =3D	virtio_can_probe,
> -	.remove =3D	virtio_can_remove,
> +	.driver.name =3D KBUILD_MODNAME,
> +	.driver.owner =3D THIS_MODULE,
> +	.id_table =3D virtio_can_id_table,
> +	.validate =3D virtio_can_validate,
> +	.probe =3D virtio_can_probe,
> +	.remove =3D virtio_can_remove,
>  	.config_changed =3D virtio_can_config_changed,
>  #ifdef CONFIG_PM_SLEEP
> -	.freeze =3D	virtio_can_freeze,
> -	.restore =3D	virtio_can_restore,
> +	.freeze =3D virtio_can_freeze,
> +	.restore =3D virtio_can_restore,
>  #endif
>  };
>  =

> diff --git a/include/uapi/linux/virtio_can.h b/include/uapi/linux/virtio_=
can.h
> index de85918aa7dc..f59a2ca6ebd1 100644
> --- a/include/uapi/linux/virtio_can.h
> +++ b/include/uapi/linux/virtio_can.h
> @@ -35,7 +35,7 @@ struct virtio_can_config {
>  struct virtio_can_tx_out {
>  #define VIRTIO_CAN_TX                   0x0001
>  	__le16 msg_type;
> -	__le16 length; /* 0..8 CC, 0..64 CAN=ADFD, 0..2048 CAN=ADXL, 12 bits */
> +	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
>  	__le32 reserved; /* May be needed in part for CAN XL priority */
>  	__le32 flags;
>  	__le32 can_id;
> @@ -50,7 +50,7 @@ struct virtio_can_tx_in {
>  struct virtio_can_rx {
>  #define VIRTIO_CAN_RX                   0x0101
>  	__le16 msg_type;
> -	__le16 length; /* 0..8 CC, 0..64 CAN=ADFD, 0..2048 CAN=ADXL, 12 bits */
> +	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
>  	__le32 reserved; /* May be needed in part for CAN XL priority */
>  	__le32 flags;
>  	__le32 can_id;
> -- =

> 2.39.2
> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
