Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB68158538
	for <virtualization@lists.linux.dev>; Tue, 16 Dec 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844024; cv=none; b=IEX7YAD9AopBl58aQgZe2gdOVoyDqnA2MfpA8u9BxGSAO6rsP3YoXqxXqjKwWgkfPH6fsUVIRlqfeytujNwzQ+jhClvgLTItYf6IurgI0qkppIeOXuz/QXTtOfuK4JvjXpArWshPjA/H21SG9gpd9fOCmI9TfTuGwo341yPTgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844024; c=relaxed/simple;
	bh=bozqr7ST7ZDLJLFdBwcqvBek5ZHWUh5MQd7q5BnWU6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gg9r8eTyFiO0QZPS9BdzSBhJZK33fSYB8dhXxlhdIWUS7Q0OUH2qnF51FYaajTAR69eZ9iuvACW6aKlO6fTNVh85CgcNcPEQrw2nyJFt5wsSV8NO2SpZyIwGlBebOTV9v4nhTQD0FlICGUKkhw7jD5ttMv/1pnxp34+6zq50vuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf4TjojB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf4TjojB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0ac29fca1so19413145ad.2
        for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 16:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765844022; x=1766448822; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJXH/uiRoHhuih5/I2ODx7WhEy17OS2PU1TLwkzpYUE=;
        b=Yf4TjojBTYQYavd/u+3FhPap9FHBvcxz1Lm8n4id9j7GPAFpM15g3b9k8mgwgJL/Np
         vEkNRkUFPAf08tp+uSzuJBYcaBfiIjqqW9Zy1nyXzwyi04P7nFgP3tY+HWijIwnYKHRQ
         Dq+H1f/rDtMneN217eXoXD7yTz4bD84N7ANy0XeZEp4Angt2UXsHKJOdfPncmAq8CLPJ
         kQMbd94oeGa896RDcerUSrmrbVuLlKVWBhue/uF+x0OtPDXW1jEzJQYHA1Fk4e9Bnar1
         oFkXuXQ+axkP3t2B+D9cQi2m92+yy0yDbNeM65BVoctX0B714lppmWUtimjgpRsqd5ss
         h++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765844022; x=1766448822;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJXH/uiRoHhuih5/I2ODx7WhEy17OS2PU1TLwkzpYUE=;
        b=sEHy1qgv8/zldBf7xAU6oc+gVQ8/iZsp3RIQFO7xYEaqO/DA6zO9dxmN4pvr2fSafa
         ucPJDqUxA/LI3O3j+ER/Ww/96zFXQoNt5+ef8Pdo/r27TcmU1LQ0PDgRxIycQJklQjmt
         +7DBppS3SgkjMVi5d/BqU9PgMtrNUwGZRMY4NEbCYJmhsYQJWw7Ftdeezk8zoAiSRApb
         sZg+cC5eL6n7Y2oo+OmJpbhAr0p4UahEls9orXGqx8vL/SfPJsf555NMoXd0qlGYXfRh
         XWH1Zm/62idERYsRJFg1J/X+LQj+dlXrw5wld1UUVeXS8YxsBn4GL0Dr11IAdJgpQNUg
         Oaiw==
X-Forwarded-Encrypted: i=1; AJvYcCU8SL2EWfymBH9puWvn6wD4VuTziUyuxAtBIy5fjBtYitvdd6MFMnlbO7uvESKBgNkThsNPikNOJTWTVEPnOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywur3BxPbSTCwMV6u5jx0ItbHdI+7tYtgbebjdGuEyCFYSuvv7C
	c0tJeOFPCAOeO0iTYVpyWbKQBba2tl8+G+LF5INkDLZBqU1edztvFJsM
X-Gm-Gg: AY/fxX4aGeFoYDY0+kCVsXSfFPTcBUMoOuxT/6VfSuahmp6NtFXaH2NeVKLhfDM4GsZ
	DUj7T8dmlPX1W4cHoYepXX/IVyiiDpGNKzzl4TQAtKXxXOqY3ZCY7keJBCvSTA/CYZAQRZyW2Gi
	z7NwU64uTudFQNAyxglGi7qHWjc82qOGXZO/+R0f/QFB2WMvniVk6wE4MVvJdxRwP0lLy6kZVdk
	3xPkxL2DhFQTjS/1NFH6Q9IWxEBgOmoz0l+6jvR5XoHJ2YD8uDvJxat3tgf+nzmdHrgDFecNUJQ
	LOv+UuSWy9hQLeJS8nBiZ89FAGmyaplV+od+vAE3eM12yPyZcawEnRoVR2r+raWiNZPwetY8bPQ
	ME5JuzyxqvxkSrLdI9IAmv6CVZaB/zWxHmq2MP+HXq4JizAuvKGpNEOWmXL6+hqdQPkSUzCLIXs
	PqwxhLalrb0HQ=
X-Google-Smtp-Source: AGHT+IEYHxljoowlccUR3ZGnI0jRpnLa3q1pwIE+8h2j0uQOtBvo2oRc6kvkq5/jnfF3cQXciNwmiw==
X-Received: by 2002:a17:902:f691:b0:2a0:cb8d:2ed6 with SMTP id d9443c01a7336-2a0cb8d3232mr55756685ad.51.1765844022398;
        Mon, 15 Dec 2025 16:13:42 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0bb39db53sm61431625ad.11.2025.12.15.16.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:13:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6914940B7D27; Tue, 16 Dec 2025 07:13:39 +0700 (WIB)
Date: Tue, 16 Dec 2025 07:13:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: kernel-doc comment with anonymous macro?
Message-ID: <aUCkM-lRUmIMAh6N@archie.me>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ePZY92H6X+PJnKhA"
Content-Disposition: inline


--ePZY92H6X+PJnKhA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

=2E/scripts/kernel-doc reports warning on include/linux/virtio.h:

Info: include/linux/virtio.h:16 Scanning doc for struct virtqueue
Info: include/linux/virtio.h:139 Scanning doc for struct virtio_device
Warning: include/linux/virtio.h:183 struct member 'VIRTIO_DECLARE_FEATURES(=
features' not described in 'virtio_device'
Info: include/linux/virtio.h:217 Scanning doc for struct virtio_driver
Warning: include/linux/virtio.h:183 struct member 'VIRTIO_DECLARE_FEATURES(=
features' not described in 'virtio_device'
1 errors

struct virtio_device is defined as:

struct virtio_device {
	int index;
	bool failed;
	bool config_core_enabled;
	bool config_driver_disabled;
	bool config_change_pending;
	spinlock_t config_lock;
	spinlock_t vqs_list_lock;
	struct device dev;
	struct virtio_device_id id;
	const struct virtio_config_ops *config;
	const struct vringh_config_ops *vringh_config;
	const struct virtio_map_ops *map;
	struct list_head vqs;
	VIRTIO_DECLARE_FEATURES(features);
	void *priv;
	union virtio_map vmap;
#ifdef CONFIG_VIRTIO_DEBUG
	struct dentry *debugfs_dir;
	u64 debugfs_filter_features[VIRTIO_FEATURES_U64S];
#endif
};

where VIRTIO_DECLARE_FEATURES() is an anonymous macro.

What can I do to fix the warning?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ePZY92H6X+PJnKhA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaUCkLwAKCRD2uYlJVVFO
o08dAQDbC7alvU33oTxteMC8zuSbEpk8Mo09KJzmJO79S9BT7QD/QR5gP7Iu+J7Z
A6NJ/m764eLB+H1ZShwy14XdcZI+aQg=
=XdjH
-----END PGP SIGNATURE-----

--ePZY92H6X+PJnKhA--
