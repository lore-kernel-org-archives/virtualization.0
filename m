Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1321EA7F4
	for <virtualization@lists.linux.dev>; Sat, 27 Dec 2025 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766876284; cv=none; b=G7iiq3d/MQx4K95bPcV33jN0ZvSZsntFIbrqRRsC8mgaC+EpszGg/fIvYRLc73T4Z1AaXOoMvNGdMwfZZMiUq4Oim9W4/XNLwfh1uDCbxwP6Tb0hm8HzXWW0uvXN6j3tSRmBj6AYDthhiUACzOdSRGPoVkRTPuFIDu+s2lwl6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766876284; c=relaxed/simple;
	bh=CPNbx3FNSa5Au+Ot9CDRPIT60sy7MYuZfYJ6jxmopGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSdjvMtGg/TtUFoOSsBcN2Px++Tc1NYtAHSpNv9Rytg201OY625a4rZOFrzzQtOQd3ZjLpAN2C8CxPwGlPbT1OqhSLzexBvDi9Z8FYvpSl7hZ9e/ULFT+tnivsScdI3GmphjfKut+vY2xmK+iUoOFsFiPboRocuYDhXHthpYA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgxAApRK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgxAApRK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso9352338b3a.0
        for <virtualization@lists.linux.dev>; Sat, 27 Dec 2025 14:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766876282; x=1767481082; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ut8bGj0ZaEBjPKvyaFOSnRAFySfPCDnWxIP7+yNuQAY=;
        b=bgxAApRKFw1DMv+2NZaT/uRnNy7hmluDqP+MK0oO1dlVmaR7IOYoR7qmv98oT1bHoC
         /ilrh0J/45tZ5Z23+Ne3IvcuctNRmsSgZQoAlVI6VaFwixakGkowgLRVSAqLUXxZ/EJr
         MY/dar2pjG8BlrbOqnlbiGNpq590gHkYMf4K8ZwtRP5OI9mDnMrFd/g5iQGtCxoKnGw7
         GwyQr7vv+/RQUmzsWlq32/dN7hj21QGtYMHu9WtC/vFvjEqCa/CuJnVI7rMHvx6RaSCb
         sWb4NymqhYWlZMUsWO7IwnRrbrgTe2Q4nBRxXpiHtJlW9+Ik9naOZUkkmy90tkAI9jmP
         8Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766876282; x=1767481082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut8bGj0ZaEBjPKvyaFOSnRAFySfPCDnWxIP7+yNuQAY=;
        b=eggu9vlG25OXdxsTLxDIAFhjKlxpT89n7YnHi2Oofu+lMQHqXgJUOPfmAE4zfpMy6s
         5xNOalGGJGCRGKoo2dLZriHyCBRzGAqbOxyOUkvuS51/SeIb2O8n2JuPIU/290pjs+Q2
         j6gy4620Xw2QYz25/c7Fs4l7WuZvzs4EbpXSiqEV308XLtJmUNNwmpKzrXzy1q78cKpi
         hcPmerRjt+W/EzTazpCDr0OjXsPdHQxZDbM8A1cA1njLbEq5wjn7xRFR8ho40p6ltYU4
         7BG6aOTEMPkJMs6rYE2a9XIYok+qrRyiEip7Z8FwvxaZPkfWE2GGohliHUXkJkJwTrLr
         1p+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT3BvtMNcAhV4W04KD2ydvV007unpaFqBZezTBf6d36H57CjazNy8s+OsHKJmrtSvuAT6wA4qn5l2q+3UZqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyR7mtjfMu4kjOQL7h9o/yExDgmGSUpx3qb7br6AqpW4CZXiEF/
	QNApnOORsj8k5FQYwXvbruWEQYI7GgA+UU6/qidY9KwmiZf7pDQeHn/e
X-Gm-Gg: AY/fxX7J5+DJDjqXnJtUjV+j3XLYbycEjH0nHUVLiIu6So9Ld3y3E7+dDGeeJ9Idjwm
	GG8Gr7Mw1dxJUTHJS+Dnu1zBWlHu4shITe+CSQkDT6utW/Qz4uBWZsMHEXn6KVgb6DiMfH4IC8R
	Fu4N1YMVS6yMUBE4i76T61yTIhLz3bnspRXa/tb2zwRDk7L0MHdeXWFRW5IDTQdCvfTjdRXk6FR
	yHPU5GMehGzZUPp/qWsz9cAdKjwQ/YD0DEgbQPzKdGVW0g1wuxZyIazF9rvvTw8l3BuceFgjV0o
	/On3GH8UkUwzN+QxNOeJtuWM+mMlDZzBoB6K0GrJvImIwssp7zMWcM4HpfHUH3Gkj5nxt/2cQ+9
	DrCBT6zi4uTiwQRVC7QEJQqz7OduqQMvEDirACLBfwjpFtZHlBjwheWpMT1BbD9XLeveqpDzZH+
	86TO306JJNc9w=
X-Google-Smtp-Source: AGHT+IHjfI1M1Rj69qk7Hqd9Aoaxae6/tIHy5AXkjNdKS9vO0/6nnUKGn2YbryJF8wDUrLvD87q/Tg==
X-Received: by 2002:a05:6a00:ad8a:b0:7b8:8185:c23b with SMTP id d2e1a72fcca58-7ff657a302emr25449837b3a.10.1766876281942;
        Sat, 27 Dec 2025 14:58:01 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cea1sm25865287b3a.45.2025.12.27.14.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 14:58:00 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id E9124409AD45; Sun, 28 Dec 2025 05:57:57 +0700 (WIB)
Date: Sun, 28 Dec 2025 05:57:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH v2] virtio: Describe @map and @vmap members in
 virtio_device struct
Message-ID: <aVBkdccdls3fbY6s@archie.me>
References: <20251219031647.25264-1-bagasdotme@gmail.com>
 <20251226140725-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ry7TUuIYCpWy070v"
Content-Disposition: inline
In-Reply-To: <20251226140725-mutt-send-email-mst@kernel.org>


--Ry7TUuIYCpWy070v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 02:13:00PM -0500, Michael S. Tsirkin wrote:
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 132a474e59140a..68ead8fda9c921 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -150,11 +150,13 @@ struct virtio_admin_cmd {
> >   * @id: the device type identification (used to match it with a driver=
).
> >   * @config: the configuration ops for this device.
> >   * @vringh_config: configuration ops for host vrings.
> > + * @map: configuration ops for device's mapping buffer
>=20
> there's no "mapping buffer" that needs configuration.
> the type tells it all:
>  * struct virtio_map_ops - operations for mapping buffer for a virtio dev=
ice
>=20
>=20
> >   * @vqs: the list of virtqueues for this device.
> >   * @features: the 64 lower features supported by both driver and devic=
e.
> >   * @features_array: the full features space supported by both driver a=
nd
> >   *		    device.
> >   * @priv: private pointer for the driver's use.
> > + * @vmap: device virtual map
>=20
> this one is not a "virtual map" either.
> more a "device or domain used for mapping memory"

Thanks for the suggestions! I'll apply them in v3 (should be out in Monday).

--=20
An old man doll... just what I always wanted! - Clara

--Ry7TUuIYCpWy070v
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaVBkcQAKCRD2uYlJVVFO
owSaAQCrqGuASetVj71LFJszVWxe+/optVC08SzwLuyV0FkX/wD/W0Po9fxNKPBX
Q0FE4SMFTaZH95+5YEls/X3Bub41wgc=
=MqGf
-----END PGP SIGNATURE-----

--Ry7TUuIYCpWy070v--
