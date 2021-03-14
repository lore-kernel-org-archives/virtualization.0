Return-Path: <SRS0=/wY+=IM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225C2C433E0
	for <virtualization@archiver.kernel.org>; Sun, 14 Mar 2021 08:27:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9187264EBE
	for <virtualization@archiver.kernel.org>; Sun, 14 Mar 2021 08:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9187264EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D35DC6EB4D;
	Sun, 14 Mar 2021 08:27:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z78bxRpB8Xcz; Sun, 14 Mar 2021 08:27:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CE4560585;
	Sun, 14 Mar 2021 08:27:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5A1C000B;
	Sun, 14 Mar 2021 08:27:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E41D8C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Mar 2021 08:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDBD383E55
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Mar 2021 08:27:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tr9vm6OuxtSd
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Mar 2021 08:27:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A79A83E3B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Mar 2021 08:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615710424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFza66MGjkmqcb+P+WR/8xxm8S5ZeuJzJsDH9rg8ne8=;
 b=ifEwcLL2q/el+NHJEC6eI7TX3Qzt0iBKVzNC0lEXvs1F9LXe1PJ+UfRYujqEgrAv8uGb7o
 8gMsmWMWSrbyLUGCm6uwlpWpP09Y1EcrUGxpBzuzpyBOFYN5+ZWX5UiUyq9sPebriEoWa+
 y5BfEYFEdGoHZtrwCCDude0MCg/JVcw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-of3NRYPRN66mbaxmacuFtg-1; Sun, 14 Mar 2021 04:27:02 -0400
X-MC-Unique: of3NRYPRN66mbaxmacuFtg-1
Received: by mail-wr1-f69.google.com with SMTP id 75so13399579wrl.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Mar 2021 00:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GFza66MGjkmqcb+P+WR/8xxm8S5ZeuJzJsDH9rg8ne8=;
 b=k7K91awpeCqYb9Grph6vchheI6Ga8o5Ed3sfhxB2B45jMrBMHp5IwAD9ddfiydogjU
 kuGZf1f9pjEjc5Lb13Df4xg3198E7MryNDI7avaO/y9PB+3qQD2ncAoj/w5facoDYMj3
 j8rmrqwaCddRtiCDshKxtGotsmo2jfK2phk5dEgz4cJ2K/E6HIrUtKCp+AbcEkpuf9Ty
 rHNqKuXnHBLKBAszFUMd03zKK2VBmVzrc7OvZIpX2j+Ak6m8Vh9Y44G6Vrz7A7uZCL4T
 arBkN0tm0QHDno8LWxD6FqhYsEnpF8gw4iX9odKyjYWnAK8yEatosKhn1sWpx1ffJuLZ
 RMGA==
X-Gm-Message-State: AOAM531itlMr9dgxO4xl/IZFoNS5xuOZ9F2HzowmVOhSjuCpkBNAaXKc
 eGRZ2U+FRoMvaCD/t51SraxYpx8MgRH9UbiEFVD2WFgVJ0GQ8rAiisNzLAjA7ynLYyZU+OZwCCj
 V97R7zpfXAqbR5Y1+o1ta+2Csi4uDOwZDm8h5Zl/6PA==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr22029673wrw.351.1615710421273; 
 Sun, 14 Mar 2021 00:27:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKnWuLs8sfVuJDUXO5TPsB2edZfCWoKeglFZEVvuQNi26qHIwmjHiiKDOZdYcyfL+oBUHyaw==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr22029667wrw.351.1615710421144; 
 Sun, 14 Mar 2021 00:27:01 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id c9sm14807528wrr.78.2021.03.14.00.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Mar 2021 00:27:00 -0800 (PST)
Date: Sun, 14 Mar 2021 04:26:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] virtio-mmio: read[wl]()/write[wl] are already
 little-endian
Message-ID: <20210314041749-mutt-send-email-mst@kernel.org>
References: <20210309224313.956065-1-laurent@vivier.eu>
 <20210311104414-mutt-send-email-mst@kernel.org>
 <a8a0b68c-d36d-c675-3c6d-d4fca996fdfd@vivier.eu>
MIME-Version: 1.0
In-Reply-To: <a8a0b68c-d36d-c675-3c6d-d4fca996fdfd@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sat, Mar 13, 2021 at 06:10:29PM +0100, Laurent Vivier wrote:
> Le 11/03/2021 =E0 16:44, Michael S. Tsirkin a =E9crit=A0:
> > On Tue, Mar 09, 2021 at 11:43:13PM +0100, Laurent Vivier wrote:
> >> read[wl]()/write[wl] already access memory in little-endian mode.
> > =

> > But then they convert it to CPU right? We just convert it back ...
> =

> In fact the problem is in QEMU.
> =

> On a big-endian guest, the readw() returns a byte-swapped value, This mea=
ns QEMU doesn't provide a
> little-endian value.
> =

> I found in QEMU virtio_mmio_read() provides a value with byte-swapped byt=
es.
> =

> The problem comes from virtio_config_readX() functions that read the valu=
e using ldX_p accessors.
> =

> Is it normal not to use the modern variant here if we are not in legacy m=
ode?
> =

> I think we should have something like this in virtio_mmio_read (and write=
):
> =

> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -112,15 +112,28 @@ static uint64_t virtio_mmio_read(void *opaque, hwad=
dr offset, unsigned size)
> =

>      if (offset >=3D VIRTIO_MMIO_CONFIG) {
>          offset -=3D VIRTIO_MMIO_CONFIG;
> -        switch (size) {
> -        case 1:
> -            return virtio_config_readb(vdev, offset);
> -        case 2:
> -            return virtio_config_readw(vdev, offset);
> -        case 4:
> -            return virtio_config_readl(vdev, offset);
> -        default:
> -            abort();
> +        if (proxy->legacy) {
> +            switch (size) {
> +            case 1:
> +                return virtio_config_readb(vdev, offset);
> +            case 2:
> +                return virtio_config_readw(vdev, offset);
> +            case 4:
> +                return virtio_config_readl(vdev, offset);
> +            default:
> +                abort();
> +            }
> +        } else {
> +            switch (size) {
> +            case 1:
> +                return virtio_config_modern_readb(vdev, offset);
> +            case 2:
> +                return virtio_config_modern_readw(vdev, offset);
> +            case 4:
> +                return virtio_config_modern_readl(vdev, offset);
> +            default:
> +                abort();
> +            }
>          }
>      }
>      if (size !=3D 4) {

Sounds reasonable ...


> And we need the same thing in virtio_pci_config_read() (and write).

We already have it, see below.

> And this could explain why it works with virtio-pci and not with virtio-m=
mio with the big-endian guest:
> =

> with virtio-pci the bytes are swapped twice (once in virtio-mmio and then=
 in virtio-pci), so they
> are restored to the initial value, whereas with direct virtio-mmio they a=
re swapped only once.
> =

> Thanks,
> Laurent

virtio pci does this: modern accesses use:

	virtio_pci_device_read

static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
                                       unsigned size)
{
    VirtIOPCIProxy *proxy =3D opaque;
    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
    uint64_t val =3D 0;

    if (vdev =3D=3D NULL) {
        return val;
    }

    switch (size) {
    case 1:
        val =3D virtio_config_modern_readb(vdev, addr);
        break;
    case 2:
        val =3D virtio_config_modern_readw(vdev, addr);
        break;
    case 4:
        val =3D virtio_config_modern_readl(vdev, addr);
        break;
    }
    return val;
}


while legacy accesses use:

	virtio_pci_config_read

static uint64_t virtio_pci_config_read(void *opaque, hwaddr addr,
                                       unsigned size)
{
    VirtIOPCIProxy *proxy =3D opaque;
    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
    uint32_t config =3D VIRTIO_PCI_CONFIG_SIZE(&proxy->pci_dev);
    uint64_t val =3D 0;
    if (addr < config) {
        return virtio_ioport_read(proxy, addr);
    }
    addr -=3D config;

    switch (size) {
    case 1:
        val =3D virtio_config_readb(vdev, addr);
        break;
    case 2:
        val =3D virtio_config_readw(vdev, addr);
        if (virtio_is_big_endian(vdev)) {
            val =3D bswap16(val);
        }
        break;
    case 4:
        val =3D virtio_config_readl(vdev, addr);
        if (virtio_is_big_endian(vdev)) {
            val =3D bswap32(val);
        }
        break;
    }
    return val;
}


the naming is configing but there you are.

virtio_pci_config_read is also calling virtio_is_big_endian.

        =

static inline bool virtio_is_big_endian(VirtIODevice *vdev)
{       =

    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
        assert(vdev->device_endian !=3D VIRTIO_DEVICE_ENDIAN_UNKNOWN);
        return vdev->device_endian =3D=3D VIRTIO_DEVICE_ENDIAN_BIG;
    }   =

    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
    return false;
}       =

            =


I note that
virtio_is_big_endian is kind of wrong for modern config accesses since it
checks guest feature bits - config accesses are done before features are
acknowledged.
Luckily this function is never called for a modern guest ...
It would be nice to add virtio_legacy_is_big_endian and call that
when we know it's a legacy interface.


-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
