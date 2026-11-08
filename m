Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794160194;
	b=P2ZwQ9647rRR63aLfc9j7yKqKQS7cVLuFSgqEpoP5DSDlE1Cf6DQAQ7n4E8uKs4TcIAZ
	 VJZtCR6/0Y1jJQfTwq3iEQCjcYY8idUgJkmLoStgrrAuddj20H5FA4FyQhhB+cLAh8yDO
	 mGQ3+R6+3cOZmZ1KZzdsrhg/WjUqxP3NYA+Ub4nhfSPY2ARqdpC87xpC4fobVUan4dER6
	 AVRNL9as+MXAOOLAqJEJ72ToDaBp8sbGCsYlM0458r2Yd5l6VWQ104AfRDVQSYLsnKAjO
	 z32lBnvYtWV1l+rGBFyFVXXx7LGHz/18OvSeig+/gz1p9LK4ftbhJuw3cN5dTJMHOmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794160194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YNiehuW6/mNVKtbNxoeEnmyBceg6t5EyN85qQs1A8n8=;
	b=OvU6Bev4x0ZKBjYQr6Gx7VD9cXWFeNE3ZOPUVviIyoiFZqZRynxrrLw0FTX2SqAvnfER
	 fI2JaVAU42XEOrDVPbeA65hi21E1HjsqkqFCh91BwdIJtpZfrvlao3MYZXtuXieibATNk
	 7TCOF8XmAMcGBEk6znczNrUkk6JH+1v8Vk6MJTtnbAhwasqOjTna0XixfS0UXX3TsFiEQ
	 yvrncRrW1Bdup8hYx1+FrYR2o7gyP4creeFqHfryu0nbSkHOZwsm8+scwAqQ0/AURllz8
	 SuEHL5hEedkD1uA3jk/XAhzv0S2zcK4b2005I/iZzT2Oh9TTV1Bq2IjzItzdvclqfAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Cf0V/+qN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C3606A31C
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cf0V/+qN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FEE1F0089F;
	Sun,  8 Nov 2026 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794160194;
	bh=YNiehuW6/mNVKtbNxoeEnmyBceg6t5EyN85qQs1A8n8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cf0V/+qNAhdlKz8Ir8fqLGsTXwh/Rev1uQGvqtGT19/bFank2azqu/PwTKbY3q2p6
	 mNSHTPKfmWBWQQkpAtvib+w3KzYJt2XO+0g6LTGD2ixQVUo9/4p0YaiWuwuGn6y1gG
	 O5rgxX8NINlbUWiMlp+Q1/hCr5TmSbbA1wCP5SXYlrIb+idpXfHbo5C0pZzVRTZcUe
	 Y4Hd1fsZRCgvBnnJK3SIqNTzt7uxZ+tS/i/ra+EjFo94DQ6aYUX3pMzAOX8xGURuLC
	 zaZM5wus4P3Lqrc2Yn0b20+Vtbn030vU98avyzsm7Y2CtQOs7LzyVYRF7ahjqtVwqy
	 /x/WPz7VxDcNw==
Message-ID: <sashiko-outbox-203892@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] spi: virtio: move teardown to .remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108-spi_virtio_remove-v1-1-fda5f0996290@valla.it>
References: <20261108-spi_virtio_remove-v1-1-fda5f0996290@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 17:49:53 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] spi: virtio: virtqueue kick before DRIVER_OK in
  virtio_spi_restore() [1]
--

commit 30a7d01f20f6ab641d59ca6ce3ddf0209bd0408f
Author: Francesco Valla <francesco@valla.it>

spi: virtio: move teardown to .remove()

This commit replaces devm-managed controller registration and virtqueue
cleanup with an explicit .remove() callback so the virtio device is reset
before the virtio core checks its status during teardown.

> diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
> index 26f9711c99b39..2eeb79ff5aa26 100644
> --- a/drivers/spi/spi-virtio.c
> +++ b/drivers/spi/spi-virtio.c
[ ... ]
> @@ -347,21 +345,26 @@ static int virtio_spi_probe(struct virtio_device *v=
dev)
>  	if (ret)
>  		return dev_err_probe(&vdev->dev, ret, "Cannot setup virtqueues\n");
> =20
> -	/* Register cleanup for virtqueues using devm */
> -	ret =3D devm_add_action_or_reset(&vdev->dev, virtio_spi_del_vq, vdev);
> -	if (ret)
> -		return dev_err_probe(&vdev->dev, ret, "Cannot register virtqueue clean=
up\n");
> -
>  	virtio_device_ready(vdev);
> =20
> -	/* Use devm version to register controller */
> -	ret =3D devm_spi_register_controller(&vdev->dev, ctrl);
> -	if (ret)
> +	ret =3D spi_register_controller(ctrl);
> +	if (ret) {
> +		virtio_spi_del_vq(vdev);
>  		return dev_err_probe(&vdev->dev, ret, "Cannot register controller\n");
> +	}
> =20
>  	return 0;
>  }
> =20
> +static void virtio_spi_remove(struct virtio_device *vdev)
> +{
> +	struct spi_controller *ctrl =3D dev_get_drvdata(&vdev->dev);
> +
> +	spi_unregister_controller(ctrl);
> +
> +	virtio_spi_del_vq(vdev);
> +}
> +
>  static int virtio_spi_freeze(struct device *dev)
>  {
>  	struct spi_controller *ctrl =3D dev_get_drvdata(dev);

[Severity: High]
This problem wasn't introduced by this patch, but can virtio_spi_restore()
kick the virtqueue before VIRTIO_CONFIG_S_DRIVER_OK is set [1]?

drivers/spi/spi-virtio.c:virtio_spi_restore() {
	...
	ret =3D virtio_spi_find_vqs(vdev->priv);
	if (ret) {
		dev_err(dev, "problem starting vqueue (%d)\n", ret);
		return ret;
	}

	ret =3D spi_controller_resume(ctrl);
	...
}

Unlike virtio_spi_probe(), which calls virtio_device_ready() before
exposing the controller, virtio_spi_restore() calls
spi_controller_resume() without marking the device ready first:

CPU0                              CPU1 (kworker)
virtio_spi_restore()
  virtio_spi_find_vqs()
  spi_controller_resume()
                                  virtio_spi_transfer_one()
                                    virtqueue_kick()  <-- before DRIVER_OK
  virtio_device_ready()

Unblocking the SPI message pump wakes the kworker to process queued
transfers and kick the virtqueue before the resume path returns to set
DRIVER_OK, violating the virtio specification and risking dropped SPI
transfers or a broken device state on resume. Calling
virtio_device_ready(vdev) before spi_controller_resume(ctrl) would avoid
this.

[1] https://sashiko.dev/#/bug/linux-82cf02b8-4add-4c6f-b6da-ae25c86bd2bf

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-spi_virtio=
_remove-v1-1-fda5f0996290@valla.it?part=3D1
