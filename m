Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332819;
	b=ZBIiJnEpAwgquG6WuU0sd0Mu4nEsxL4szRUuAMIOtcNuEIJDaqDk1Tjbv69yhZ3+k7iD
	 Q8hfKeqwmhG1m/yq+4hiLKRJZWynSvioO1kEjNUoSDRE7ymfOjG+Iz4rEO0lIuuqGez9i
	 fBKYNIJs4Zp9txRh0rwdQfF4yr28avqp+5GMumIB520Jyw+PQjlxxN8Gfhr0WV542kGfr
	 ap88dm/BTm86RKUQXaJP3AJIEPGFHgWdU/JdLvv76SugnVbPaf+viITo1vk37ySxDojL5
	 fveOvqCDG2zHWDs67ZYujdg1OoIQCAAZbaU68zo9n5De+FzbYF6PXbtl/kXKes0GEnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332819;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yvFnNvugq2mYNX7u6LvLolFLh88DRFVKka0rBKunI0o=;
	b=gP3t/E6H6cvqYzQh/2su6tLLSRX5V73W8kLsbwDtxEDvUXRGOlmqPocS2uyoLBDBEBMz
	 lBEXv6HzuYoILMrsdyB0n4ASmXLIcMB0ONW829FxnPwIWbHMrjSObT9QzgN24sLkfEdqq
	 gvvN0XLTALfcuKPyGDldb4l4c003pgv8nQ0UQMQlnqW8z25uc3qz9R7SWW2VzAKw0Lhml
	 UVvaoQ37tjhHHvtDq3q8szMaHqn92RHPlhkG+iOh8Da1Ylu4lx9p5yX7NaNnR4DEG2rvo
	 9Kfs4b+BwPFOVnj94H1ediarh1NoCeJ4oTcwKX8QXellNuOUBHNFc6MikMUIkMZCKhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fpNsYCi0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F64606A320;
	Tue, 10 Nov 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fpNsYCi0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EF71F0089F;
	Tue, 10 Nov 2026 17:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332819;
	bh=yvFnNvugq2mYNX7u6LvLolFLh88DRFVKka0rBKunI0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fpNsYCi0TCSO8ej6y4MbhTZCTmQepJTFObJLAL0c87HHqVdOoFpOK8BlXhg4gHiX1
	 lql3rNN8cMa9GuIt2jJ9887qGblOm5rAlKX0k0CT0BGdVGxHXku3aCnus+UixEKLa7
	 rCK7u9+NLcEohJ7BanBIG96k66A3WZp+kNMRIxLG2WV3Sqxkafn912Bj5igP0scMXj
	 3dkN5WaM7Ugu+ky0dHd5sZDj2OwES0EeGS+LHC59t3kR6O2NYJBCwlv9sd92HP0tBJ
	 11l9w4UCpxDFnfsnnZ2nOchISkpm/Fr5ZfI76zkicmYLIpVm9xHZ7dopJ3dCCTVAHj
	 enIFqKIf/rVEw==
Message-ID: <sashiko-outbox-207511@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: virtio: fix virtqueue use before DRIVER_OK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Seonghyeon Lim" <forfortuna@naver.com>
Cc: virtualization@lists.linux.dev, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261111-virtio-can-ready-v1-1-0b4dd020af0b@naver.com>
References: <20261111-virtio-can-ready-v1-1-0b4dd020af0b@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 17:46:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] can: virtio: RX/TX stall if interrupt fires before
  virtio_can_napi_enable()
--

commit 8c2e9ab878f651e327c76d0ed7de23824865f16e
Author: Seonghyeon Lim <forfortuna@naver.com>

can: virtio: fix virtqueue use before DRIVER_OK

This commit calls virtio_device_ready() before populating the RX virtqueue
in virtio_can_probe() and virtio_can_restore() so that virtqueues are not
notified before DRIVER_OK is set.

> diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> index f67d0bf09681f..ae35a00b784bd 100644
> --- a/drivers/net/can/virtio_can.c
> +++ b/drivers/net/can/virtio_can.c
> @@ -912,6 +912,9 @@ static int virtio_can_probe(struct virtio_device *vde=
v)
>  		err =3D -ENOMEM;
>  		goto on_failure;
>  	}
> +
> +	virtio_device_ready(vdev);
> +
>  	virtio_can_populate_rx_vq(vdev);
> =20
>  	err =3D register_virtio_can_dev(dev);
> @@ -966,6 +969,9 @@ static int __maybe_unused virtio_can_restore(struct v=
irtio_device *vdev)
>  		virtio_can_del_vq(vdev);
>  		return -ENOMEM;
>  	}
> +
> +	virtio_device_ready(vdev);
> +
>  	virtio_can_populate_rx_vq(vdev);
> =20
>  	if (netif_running(ndev)) {

[Severity: High]
Can an RX or TX virtqueue interrupt arriving before
virtio_can_napi_enable() permanently wedge the queue?

virtio_device_ready() unbreaks the virtqueues and sets DRIVER_OK while
priv->napi and priv->napi_tx are still disabled (NAPI_STATE_SCHED is set).
In virtio_can_open(), virtio_can_start() then sends
VIRTIO_CAN_SET_CTRL_MODE_START and sleeps in wait_for_completion() before
calling virtio_can_napi_enable():

drivers/net/can/virtio_can.c:virtio_can_open() {
	...
	err =3D virtio_can_start(ndev);
	if (err) {
		close_candev(ndev);
		return err;
	}

	virtio_can_napi_enable(priv);
}

drivers/net/can/virtio_can.c:virtio_can_rx_intr() {
	struct virtio_can_priv *can_priv =3D vq->vdev->priv;

	virtqueue_disable_cb(vq);
	napi_schedule(&can_priv->napi);
}

CPU0                              CPU1 (virtio interrupt)
virtio_can_restore() / probe()
  virtio_device_ready(vdev)
  virtio_can_populate_rx_vq(vdev)
  virtio_can_open()
    virtio_can_start()
      ...
      wait_for_completion()
                                  virtio_can_rx_intr()
                                    virtqueue_disable_cb(vq)
                                    napi_schedule(&can_priv->napi)
                                      <no-op: NAPI_STATE_SCHED set>
    virtio_can_napi_enable()
      napi_enable(&priv->napi)    <-- clears NAPI_STATE_SCHED;
                                      vq cb stays disabled

Once napi_enable() clears NAPI_STATE_SCHED without scheduling a poll or
re-enabling the virtqueue callback, virtio_can_rx_poll() never runs and RX
is permanently stalled.

Enabling NAPI before virtio_can_start(), or kicking the virtqueues via
virtqueue_napi_schedule() after napi_enable() as virtio-net does in
virtnet_napi_do_enable(), would avoid losing the notification.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-virtio-can=
-ready-v1-1-0b4dd020af0b@naver.com?part=3D1
