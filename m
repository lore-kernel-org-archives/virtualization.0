Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECB3FA5CC
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267737; cv=none; b=r64X6LdtNHTFCTy2x8PGGkLJatgVp3lwKQOdnmT6cQDcUr4ZjghG9Q8U2iDvMEs/X/4K4TStG0TL7eAm+iAyvIelEE4hRXvKZDy5UAGmz5Bdm+dbQfIOnJNnA1tL45JvtCiYJHTJWwQVII+tKAek7kd122+75SfOI845Tn1nuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267737; c=relaxed/simple;
	bh=y0dYki0khQoIzJ5pDGE7dLkEYNvAAAodhuXs4S5VuxI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lkk3ZwIvaOyFkIVzzs6lwpJf/LHftuL2VyBVDfHT6gf0o7IvyBZpZnpaFGQwCIha2x0G4kMd/IWbiOnuoG9D89lgZKIcBxMkMoCm6FOgSy+kRiKhb2/hNi3TR/vjr2fJlLoTnfg+gjOUMV0o5vTNOYwrUhMUNon+Ox3xzY5ZKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loYaE+OH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loYaE+OH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAB21F000FF;
	Thu, 24 Sep 2026 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790267735;
	bh=T7dmmUlYLZIDoC5BrYJgQ2j4n5V+NHvKXvf8ayx1iqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=loYaE+OHOJDxr3hEnhji86uOUDFwMjhWcVGN4sD6dG/8rUvSJhhPi/akiuWUwY7Oe
	 zjUtzdzJLlJ/L3fyCJ9P/QtloR10vh152pjzJicmDYeSXiR2dFZdqHoU9b6lwTB5UI
	 magZyUpTWjwOCwXDohu1PmvbrhGaG+1hqRjaLDKWoqKRz4PeX20KyQaH3t7clNS8zz
	 PQB/2HPKX1AjkC8N5wgvrlKFFjRG8FDhluBp0CJ1o5g3aeO+r7GrFQXrgo6VNcHNdo
	 qvh2hMATuIBwotCkZ+KAdedMPa8/FO73Tl4htIsf1xqQ0YTYbkq0W5NhpgP3kReoN4
	 5+3/a4KWuiPrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] virtio-usb: support a guest UDC name prefix from
 the bind event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Skalkin" <igor.skalkin@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260924160907.145405-9-igor.skalkin@oss.qualcomm.com>
References: <20260924160907.145405-1-igor.skalkin@oss.qualcomm.com>
 <20260924160907.145405-9-igor.skalkin@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 16:35:35 +0000
Message-Id: <20260924163535.7BAB21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] usb: virtio_usb: missing sanitization of host-provided UDC name
- [Low] usb: virtio_usb: stale parent device name retained on BIND retry
--

commit b4fd3e9cac2d1567822e6a554abe7a7e1afb42b9
Author: Igor Skalkin <igor.skalkin@oss.qualcomm.com>

virtio-usb: support a guest UDC name prefix from the bind event

This commit allows the host backend to supply a name prefix for a port's UDC
parent platform_device via the bind event. If the prefix is present, it is
used as the parent device's name and to construct the gadget name; otherwis=
e,
it falls back to the generic GADGET_NAME.

> diff --git a/drivers/usb/virtio_usb/device.c b/drivers/usb/virtio_usb/dev=
ice.c
> index ee41ea9d164f1..fedce742f9781 100644
> --- a/drivers/usb/virtio_usb/device.c
> +++ b/drivers/usb/virtio_usb/device.c
> @@ -1369,11 +1369,26 @@ static int virtio_usb_dc_get_endpoint_info(struct=
 virtio_usb_dc *vudc)
>  	return rc;
>  }
> =20
> -static int virtio_usb_dc_parent_create(struct virtio_usb_dc *vudc)
> +static int virtio_usb_dc_parent_create(struct virtio_usb_dc *vudc,
> +				       const unsigned char *udc_prefix)
>  {
> +	size_t prefix_len;
> +	char *parent_name;
>  	int rc;
> =20
> -	vudc->pdev =3D platform_device_alloc(GADGET_NAME, vudc->port);
> +	prefix_len =3D strnlen((const char *)udc_prefix,
> +			     VIRTIO_USB_UDC_NAME_PREFIX_MAX);
> +	if (prefix_len) {
> +		parent_name =3D kasprintf(GFP_KERNEL, "%.*s", (int)prefix_len,
> +					(const char *)udc_prefix);

[Severity: High]
Does this code adequately sanitize the host-provided udc_prefix string?

If a malicious host supplies a string with invalid characters (such as '/'),
passing this unsanitized string directly into kasprintf to construct the pa=
rent
platform device name could trigger a kernel WARN in kobject_add(), which wo=
uld
panic the guest if panic_on_warn is enabled.

> +	} else {
> +		parent_name =3D kstrdup(GADGET_NAME, GFP_KERNEL);
> +	}
> +	if (!parent_name)
> +		return -ENOMEM;
> +
> +	vudc->pdev =3D platform_device_alloc(parent_name, vudc->port);
> +	kfree(parent_name);
>  	if (!vudc->pdev)
>  		return -ENOMEM;

[ ... ]

> @@ -1447,7 +1463,8 @@ static void virtio_usb_dc_event_process(struct virt=
io_usb_event *event)
>  			break;
>  		}
>  		if (!vudc->pdev) {
> -			rc =3D virtio_usb_dc_parent_create(vudc);
> +			rc =3D virtio_usb_dc_parent_create(
> +				vudc, bind_evt->udc_name_prefix);

[Severity: Low]
If a previous BIND event failed later in this function, could vudc->pdev st=
ill
be populated here?

If it was left populated by a prior failed BIND, the new prefix is ignored,
and the parent platform device will retain a stale name from the previous B=
IND
event.

>  			if (rc) {
>  				dev_err(&vusb->vdev->dev,
>  					"Failed to create UDC parent device\n");
> @@ -1456,8 +1473,18 @@ static void virtio_usb_dc_event_process(struct vir=
tio_usb_event *event)
>  				break;
>  			}
>  		}
> -		vudc->gadget.name =3D
> -			kasprintf(GFP_KERNEL, "%s_%d", GADGET_NAME, port_id);
> +		udc_prefix_len =3D
> +			strnlen((const char *)bind_evt->udc_name_prefix,
> +				VIRTIO_USB_UDC_NAME_PREFIX_MAX);
> +		if (udc_prefix_len) {
> +			vudc->gadget.name =3D kasprintf(
> +				GFP_KERNEL, "%.*s_p%d", (int)udc_prefix_len,
> +				(const char *)bind_evt->udc_name_prefix,
> +				port_id);

[Severity: High]
Are there any missing sanitization checks on the host-provided
bind_evt->udc_name_prefix here?

This unsanitized string is used to build the gadget name, which will also be
passed to device registration APIs. Similar to the parent_name, a malicious
host supplying invalid characters can trigger a kernel WARN or panic.

> +		} else {
> +			vudc->gadget.name =3D kasprintf(GFP_KERNEL, "%s_%d",
> +						      GADGET_NAME, port_id);
> +		}
>  		if (!vudc->gadget.name) {
>  			rc =3D -ENOMEM;
>  			kfree(vudc->veps);
> @@ -1480,7 +1507,6 @@ static void virtio_usb_dc_event_process(struct virt=
io_usb_event *event)
>  			break;
>  		}
> =20
> -		//vudc->gadget.dev.init_name =3D gadget_name;
>  		vudc->gadget.dev.parent =3D &vudc->pdev->dev;
>  		rc =3D usb_add_gadget_udc(&vudc->pdev->dev, &vudc->gadget);
>  		if (rc) {
>  			dev_err(&vudc->pdev->dev, "Failed to add udc\n");
>  			kfree(vudc->veps);
>  			vudc->veps =3D NULL;
>  			kfree(vudc->gadget.name);
>  			break;
>  		}

[Severity: Low]
Does this error path fail to unregister vudc->pdev?

By not unregistering vudc->pdev, it is left for the next BIND event to wron=
gly
reuse. This creates a mismatch between the parent device name and the new
gadget name in sysfs on a BIND retry.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924160907.1454=
05-1-igor.skalkin@oss.qualcomm.com?part=3D8
