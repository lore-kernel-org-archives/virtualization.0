Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388450;
	b=04SqWmSPcAMtMe+EE2bW6YsMvETI78wQ7jBFVjaJaO/BOOnRHFJU0+3mReJLS+g0SC0n
	 kvl85G5dvXNjAyN/68UO8fY+KSjhlgZ99KDJwqm3p+ppQ65J4zs89SeL686bhVXRXlXP2
	 yZkIBBxP+wIztA9ye+DBx5WLXpShqMmJp0AxqZt8y/Z0zLgbqCHmKnDlpH1PmWANWBu7i
	 Y4WwEEufRfeDvRQz7jxXstV0Vcags4+WPVnNm7h00+eOeEgEG9A12rxWZ1WBpQeRoYE4g
	 u9KdriBpIJA8n8Mewt5OUnWoSYrhxSfjSos3wcH3rezcvejTSgCgecrL5BDTBdsN+lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nI1Nu5oqP6mshXiPgsRA+948M1F3pxJdBRCWfI34fK4=;
	b=DQ4NOEFry3bi+2cBYNB+W5O5Y4JotKbMZC5ejAZYcYk8/08EsjvvzRGvFGGoABoUNIFH
	 P+tWkbpvknBVWyYyFLcjaQdb0fMZnH+WeE9CK04b5ZDdMOdCGfKtzzzpr6yAs6ZIiYiYv
	 nWtVHy5R4skVmP6XsfapXy4zMdBRx/M5gnyt5S7WCE66XeROCJUGg4Npr2VjsPWl9H+gb
	 5LLLtZnuNQeb4aJQlGKoJrmDCGrZ4L36sZXTANi1l2dm0llNaWi0/NCX6ndO2P5oiumdA
	 ymtLNNqU66wcui1kii+fYtjTDPVHBDfsv5c75Hqn/qUARD68pUNnN5FNBhVhthXMvNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="b8ttzLJ/";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83712606A327
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 09:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83712606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=b8ttzLJ/
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so18852965e9.3
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 01:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794388448; x=1794993248; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nI1Nu5oqP6mshXiPgsRA+948M1F3pxJdBRCWfI34fK4=;
        b=b8ttzLJ/41KZ9+d8r3onFuKvrFj3X8Xg8b6TBDgNULBdJTV6YgNzdnT0OueV6yyk7x
         VPmj453nXPG20rQDqVL/Unp7QBakL6ovWJqoAJWxq08KQGreoXod8zf9Sz6h5+YYQdQK
         OfsLRVs0tIyDaFDve0U6ymSMhs/PbEyK3ULpIDmu8KQzb9gy237jsQI7oxiTfmMcGVzx
         DMJXoUHLd5xLyADQF+HyOThcNRu+qFiLpdqka61a8icT5HEdRk1+ozLWcrV5+eupaYSs
         yNh1h0YdOC+ZqyfZMmxy9ap8DvODHJkMMvXkAb54cH/g+KZXx5jYNfob06nKXfkhp0u2
         kjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794388448; x=1794993248;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nI1Nu5oqP6mshXiPgsRA+948M1F3pxJdBRCWfI34fK4=;
        b=gCs+Y+wSemi7U2G4RMZLKiEGTdvq9+HvA7Sr8HRMIivIIlAQSr76oS+3A2IkJvG0HI
         UdHl0EpHhPjOREnFx7cdiJED/tbC8EQOHpCMydFjutH+ojF8adQc78Vu02jRUCJR9Fys
         EXJ/AbWL1QfGfwCa4wZBQJnw2qHp7i3YNeDSM6E/yb6lrF3j6KuECWhfOWbmQwQLesIi
         iGTn0BvyFedq6irq8Wirnp1qtKJQ28o3BZkuQSikmJfiCOwgA5QkWferNQvv9XY/X9jz
         0ID0mRWcjxn8MseVY5KTKBYeA+TJ2xtZ2VW6a25p3jq/S3RWGNQu9I29aWKdeEYJDuFP
         KleA==
X-Forwarded-Encrypted: i=1; AL+hErFWMrZ2cPuToaEg9dLhi3211a58qLBM3RQg9EQ0+7S+HFNydnhi6CN+OpC/nizq5+yGaL7a+Q1aTCPcAk1IJw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+GK+cAJcnldzRvMBXqJRg/o/i6jQIRw6OuLD6adSx5AcpGqBCR
	cc7hu9cezOG9yEx69lS0kum/oMoe0mSv48b3go5XSIjHJ2J82ng6eY832Vv33Lx1g5Ht89RcQhC
	WqZE0HoQ=
X-Gm-Gg: AYBFou2GMYfDhwZ60Y69JAsEnU2RJMQBTWxBwe1O7AR/P14JNAw8CR6byVGv9xX1GCP
	Z5lpRAmGOQlT/MnbArTvRhf3X26J+bpdHo2qXWh5PV5B5QB8S8Q3WLLAOo/GWTGICCmJPmha+E4
	jjIf+rStO+D6KbIoVgrvRzp8Qhrz1bDSfR7LT41udcS1LXHfgOOUq8leYll04U3Q+PbYPW4Uz9f
	oEtUG+NG4yDtBqF6qpdTskoDF7zvNjUxPYEKJSayoW209Rw1wVnN2Dgogu1iX4OLf27nvYJCI0V
	udpp+vgEw+7GTQl2vuMVorwK6Dp871Otc2wgR2Rx2nDwPWN83pFWPr5Byhqohn/YSnzxnF+SpRZ
	fu7xLCIexaShDXWSu6aN3PLfAIi+FZmoCeqs0D91ZTVJhVR6KukYGKtG8VFzqPt/h1yHEV2oDQ6
	vu7+aVzMbGvnGsKDpQKfiDqlTMFsSyiYY2AHJyrYR1ZSBTiy8riniRfhsR6WHM05XJeRKezwi9+
	rk/GSnR8pr/tacZKlujv1v/zd+HVHCQY5xXsfy5p7dST7AVgqtO4lTAry9DYfklA0Gcoo+r21Y+
	l5eihVsObvZgeZuzUSXfl4h+05gqEDlUvlW/RjWb2zaFol7MjUstkY7CfbjnAm2J8kAc/dz4Fl1
	HPtb276/tcUNtA4s=
X-Received: by 2002:a05:600c:46cd:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4ba0931c26emr28211945e9.4.1794388447836;
        Wed, 11 Nov 2026 01:14:07 -0800 (PST)
Received: from localhost (p200300f65f19a90460510dd506fc51af.dip0.t-ipconnect.de. [2003:f6:5f19:a904:6051:dd5:6fc:51af])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4ba08ddbe68sm75389965e9.0.2026.11.11.01.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:14:07 -0800 (PST)
Date: Wed, 11 Nov 2026 10:14:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] virtio-pci: Drop inclusion of
 <linux/mod_devicetable.h>
Message-ID: <avQxWzMfc2LSe5tS@monoceros>
References: <fc69191474ffd49d50d7e39b13dfe6586f4d3f75.1783354857.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6yep7a5w7zky2a3b"
Content-Disposition: inline
In-Reply-To: <fc69191474ffd49d50d7e39b13dfe6586f4d3f75.1783354857.git.u.kleine-koenig@baylibre.com>


--6yep7a5w7zky2a3b
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] virtio-pci: Drop inclusion of
 <linux/mod_devicetable.h>
MIME-Version: 1.0

Hello,

On Mon, Jul 06, 2026 at 06:22:08PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> Among the different device id structures <linux/virtio_pci_legacy.h>
> only uses struct virtio_device_id. Include <linux/device-id/virtio.h>
> instead of <linux/mod_devicetable.h> to provide that which is more
> lightweight and doesn't introduce that many dependencies.
>=20
> The users of <linux/virtio_pci_legacy.h> also don't rely on this header
> to provide the full plethora of definitions. (There are only
> drivers/vdpa/alibaba/eni_vdpa.c and drivers/virtio/virtio_pci_common.c
> using pci_device_id and these include <linux/pci.h> which is enough to
> get it.)
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
> Hello,
>=20
> note that <linux/device-id/virtio.h> only exists since v7.2-rc2, so make
> sure your base is new enough when applying this patch.

In case you postponed applying this patch because of that, I think it's
safe to assume that <linux/device-id/virtio.h> now exists in the
relevant tree.

The patch still applies fine to next-20261110, can you please apply it?

Best regards
Uwe

>  include/linux/virtio_pci_legacy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/virtio_pci_legacy.h b/include/linux/virtio_pci=
_legacy.h
> index a8dc757d0367..96a9523e985d 100644
> --- a/include/linux/virtio_pci_legacy.h
> +++ b/include/linux/virtio_pci_legacy.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_VIRTIO_PCI_LEGACY_H
>  #define _LINUX_VIRTIO_PCI_LEGACY_H
> =20
> -#include "linux/mod_devicetable.h"
> +#include <linux/device-id/virtio.h>
>  #include <linux/pci.h>
>  #include <linux/virtio_pci.h>
> =20
>=20
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> --=20
> 2.55.0.11.g153666a7d9bb
>=20

--6yep7a5w7zky2a3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr0MdsACgkQj4D7WH0S
/k6+8Af/fMctPCPv7wvA1pqIlIT+UTjDxO/i06yrzmiAS8yPqOtDcZjGSLjj8yha
UFdXvQnef0+gVAoqnmN3RJxuFXNdA4l0imPwwk1NxGcBxIhTo6gu1NWzk7qOLE96
PjCAn+bjQ3gIOhANvNOhXk1h/320pDX6KVfzQIaS8s1mDlwKuoMvLcpDmwEWQRoV
7S04l8gIvHysN44Ls4DMrmpSz2vfso0mTlu60gWovRVZIgALmeQnWiwihKueRcF6
KiIvOQ7tMf3q4zcl2bnr0aegR62xB9YEAbjEepCPaAPu+ZFnV1z7xRLOpPzrbuXw
PtYe4FMTRYy6uifnqplP14kU2PDAQA==
=+7ve
-----END PGP SIGNATURE-----

--6yep7a5w7zky2a3b--
