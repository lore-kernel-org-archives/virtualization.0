Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A08378D98
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166596; cv=none; b=PI70KUmc6FdZhTmVCj0GXYrloiG/X5FYrYCc65dU24XWVaqtP066Qm9QwVztuKyovH4fgS5RYgmpQl/dy2KsNa21rh/hOlj9qcYTDMfzta+VzPRvQLi71ezdLtamOcCE7KX3+7b8qVkNE2d4o4DmJQYNsw9Hw+Hf9494/Yz2Anw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166596; c=relaxed/simple;
	bh=whvvN/CFOrH7RKQ7/X6y05Xcv0qmS303mrgZsYhKQmM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cPWk0HcHPQKiKAielJIl5M1FsAjTWXBJConCA8/XhqET+LkxMEsnaloLN/FqgtnjALVq1YpoAqBZJlvKdD3MFhrS8qmpt75ImUzCrkf78Pktfv6SL2PL3J9+M2dMeWat63Z34a6rDrZRpSoebWEjDGVtRD4NQxURxd0rwEGAmWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9sS7cII; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9sS7cII"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef5146b56so424491f8f.0
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781166591; x=1781771391; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m+l1JvRvpuhT+IO3ofm3vlIHgC92Wn7wBaCPOWtqMNM=;
        b=H9sS7cII/Kmyii/rP91hUy2EBbySFZfMsw9CGaXRhWJJFIx3w8Gh+/DICsLPIk4EOW
         IqFrX1LfqW1F/1SdCMvNYmv1wBEQwbUxsOl4egXlr3Snmsq54YsA16OnOOYxhBLSCTzb
         x6Wefg1aaUecpV6DhmO8F8LEXfkVdQhlDGUyIAisqR39XfXp7p+XaVfdCmAXw/dCpsAH
         CODxU1TQwBhCx1RRyHAZKXtg1f2cfitR2E3/Gg9kcXE7266CwVRFKJzDANyQDEEsjx/K
         lbHX0vrb21hfQwQEArB9zhweuP4XSX5z3x7zHm5D/TxJqesriJaFyaZeSmUQhug/lyx2
         Vbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166591; x=1781771391;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+l1JvRvpuhT+IO3ofm3vlIHgC92Wn7wBaCPOWtqMNM=;
        b=Qy+d18r2oAVi3DCytQc8kKjG1TGJSJbpGN3EvIrcmFmkr7Q5Cj2uW1mTe+E8KhzuFA
         1/NiqfwSOzCJj7I9nEeXMxqNEDeeis+BMxONz4z6yVAA7eHGmkUv/aJ5g42yD/6KVSF6
         lVzxy9vQB0z5stFru/tCKpClhV6Ob0j34QcxBecj9UP+ReZrz/qqXn8WkxBTALYlCJSa
         ZMf0tQfXJxLskynVwrq0tBuEYr6O9fkYrU10Y/m77yjcwGsCxZ7oJBawyz7D7VcnCeiy
         tX8MTu3dW6++ca1HXsBGddYJaOeDgMZocjKvO9Pp7SfgakA/YJgVtmP6MdM9XnrPJe/A
         W5QQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pD/JA4usHhbcxl08CX1sS6K38O36dleKjDQdWeFTvzSanyc3syBtQQ9yR6na6uAcDe3Rv02zY1XKNaIWx0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjMBb9sdHqKWENFpwrcBXWUf968aUQMDMCwKlJ4BuPB5ZthnOj
	a8364snoWhJwF2mLiRw6KfJmmo/27hJxcX84LFdoM9wg0eJgBkeIiIdv
X-Gm-Gg: Acq92OGww6tzdu/wpSR6uCT2lfShTkTG6Dtr5sEg+0yXvWL2kPaEDikPLNY157bzu6+
	qUePhqvv2Egkx0AUQj6UwJD1Xr0Qp+u+KrQMw5+C4I0q5H+J6h9HxeLs4Yyt3qTvAXRPaOG3AQV
	mBWAkgK9Fp1q+dvagW1ghMA9qAVd+fb9msZGnphrjIQyTx29gv/5F/LS0j9lTaisfJ/tI/1MkdS
	+TibuvVhWIOu58aiUYnPDGWT8bfHIPzoF0w9JcT64QFyMsqydasWP60gnTBLBl2J+Z6ARmugWyq
	WG8OyuPlmJrY2JMWmi8OlU22sY0b39JbxzRluVMlANKc64CgMlkYnqm6Pr/8d7gYUPF8eDxS4UD
	eReOVAjZ5KoeIEyzsapJOZBXdiekHvclBSwLhZ8wjWxolka1A/WLbIB7QcviPARiyR3brRRV5/s
	EZRBRfxDIllVx9C8q45EakO9qW7hyfYsO5gwT2qLBmL/IhfEPdyidvDjBRWMeARp6LWuCl
X-Received: by 2002:a05:6000:4606:b0:45e:f387:77a0 with SMTP id ffacd0b85a97d-46067c36a3fmr2166645f8f.31.1781166591495;
        Thu, 11 Jun 2026 01:29:51 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm87367171f8f.5.2026.06.11.01.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:29:51 -0700 (PDT)
Message-ID: <831dca185e55f56a14c0c580ab33ce84361eb67b.camel@gmail.com>
Subject: Re: [PATCH RESEND] virtio_console: read size from config space
 during device init
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rusty Russell
 <rusty@rustcorp.com.au>, 	virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jun 2026 10:29:50 +0200
In-Reply-To: <20260611033747-mutt-send-email-mst@kernel.org>
References: <20260223-virtio-console-fix-v1-1-0cf08303b428@gmail.com>
	 <20260610030318-mutt-send-email-mst@kernel.org>
	 <dce7a3af2e8fd674d842efe7e21abb4644248155.camel@gmail.com>
	 <20260611033747-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2026-06-11 at 03:38 -0400, Michael S. Tsirkin wrote:
> [...]
> > >=20
> > > Wait a second. Why is there this rproc test here?
> > > Was not in the original code and commit log says nothing about it.
> > >=20
> >=20
> > Previously, this code was in config_work_handler(), which was never
> > called for rproc_serial (it's scheduled from config_intr(), which is
> > the config_changed handler only for virtio_console).
> >=20
> > Now update_size_from_config() is called unconditionally from
> > virtcons_probe(), so it will be called for rproc_serial too, which
> > doesn't have the F_SIZE feature.
>=20
> So why not test it?=C2=A0

The virtio_console driver implements two similar but distinct virtio
devices: VIRTIO_ID_CONSOLE and VIRTIO_ID_RPROC_SERIAL. Although some of
the implementation code is shared, the devices are different. In
particular, rproc_serial doesn't support multiport nor any of the tty
specific features. This means that the relevant feature bits are not
valid for this device and must not be tested.

I have to admit though that I don't quite understand what the
RPROC_SERIAL device is supposed to be used for. It was added by commit
1b6370463e88b0c1c317de16d7b962acc1dab4f2, which describes it as "a
simple serial connection driver called VIRTIO_ID_RPROC_SERIAL (11) for
communicating with a remote processor in an asymmetric multi-processing
configuration". It seems that it was never standardized, as the virtio
spec only says that its ID is reserved.

> What does "not a valid feature" mean?

I copied the "not a valid feature" comment form other instances in the
same file where a feature is tested, e.g. in resize_console():

	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
	if (!is_rproc_serial(vdev) &&
	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
	  hvc_resize(port->cons.hvc, port->cons.ws);


Best regards,
Filip Hejsek
> >=20
