Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E09EC001E0
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 08:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C7C02403B8;
	Mon, 23 Oct 2023 08:23:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7C02403B8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hd9/wnNe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yN-y0u18vuL7; Mon, 23 Oct 2023 08:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD15041184;
	Mon, 23 Oct 2023 08:23:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD15041184
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA733C008C;
	Mon, 23 Oct 2023 08:23:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ED22C0DDD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 08:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C099160D67
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 08:23:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C099160D67
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20230601 header.b=hd9/wnNe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rWgs21xXauLq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 08:23:07 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87DC660B9F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 08:23:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87DC660B9F
Received: by mail-lf1-x141.google.com with SMTP id
 2adb3069b0e04-507c5249d55so4207655e87.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 01:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698049384; x=1698654184;
 darn=lists.linux-foundation.org; 
 h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yILl0/y7g1lM4NMlXc0rK5OqjDqsDZrg7ur6TMfehp0=;
 b=hd9/wnNefDAKBNOUTR3Ol77SI8oEqvq7nsv9y7DjcnszegVsaKQ4HAeirsbXkFwIWV
 dE88hYxNK7hBiFN4N/5S41k1ktQB851YnODA1AWqZF7vPOtdYGnPGkf1sqZ6fUe8i83a
 TgRte4C0QrvT1Pcaq2Ybj6KMih+RIEioHsM0WLRdl6/UggfhApIiTu+M2u94ZNvz2dL0
 6gTLRqafqONqPaOwrgDZ+sMfTYE2O65/d9JKTffKxP4KHyR6pUSQgngBGwiWLYXnwtwN
 kdFTJpH9u0VaMKP9pkp9+V9EhUSxdk55IRIHDyCCIlO6HOPfFQn6bmW8ApbzCJugmJB5
 K/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698049384; x=1698654184;
 h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yILl0/y7g1lM4NMlXc0rK5OqjDqsDZrg7ur6TMfehp0=;
 b=saBAVRt5QqnCb37uIer5MZoA8D7X3+0hF0h3ADiLIgg/63bKdqRf46Oq2CC0LbulAh
 zdUvy/Z2uP3vg3d+O1zQNJUIHy8ZCKwkugJKQMVHEqSfEuvRUeGCtwL1YzaIE/nfLCy2
 Mf3wESzUkhZrZLwamCmgJCWQ3CdqNCzEk6GozBXG23CBDkd5ysF5hA3HLPGMSgb8Y7+S
 EMsTDEXZk2hOjg4xXm0TkVHGB+iMOvF2PFF1OLy+aT+vQ3X1B7PPNQqNgvEq9rKM8csv
 t+7R4zILmBqDuaiZPznalPYbX3LSDEu7WkjBjjibV02BBQlqUnZGfHr5JQIojR0okio1
 WmBQ==
X-Gm-Message-State: AOJu0YyODhEGjo0PXABAD9MY+auqlmMa3iGq52sOxelZPYte0Ndakbjd
 DGfuky4kTo9ouSaA+mKREUE=
X-Google-Smtp-Source: AGHT+IHfLv2FTvbtP+XDfCQMq0/4gQd56gQXMbgJziOzy1KkvTPqQfj0aDzIIvyqse8I9pxQmKfFcw==
X-Received: by 2002:a05:6512:5c3:b0:500:cb2b:8678 with SMTP id
 o3-20020a05651205c300b00500cb2b8678mr5314280lfo.40.1698049383921; 
 Mon, 23 Oct 2023 01:23:03 -0700 (PDT)
Received: from eldfell ([194.136.85.206]) by smtp.gmail.com with ESMTPSA id
 u25-20020ac258d9000000b004f85d80ca64sm1608145lfo.221.2023.10.23.01.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 01:23:03 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:23:00 +0300
From: Pekka Paalanen <ppaalanen@gmail.com>
To: Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v6 9/9] drm: Introduce documentation for hotspot properties
Message-ID: <20231023112300.732e18fa@eldfell>
In-Reply-To: <20231023074613.41327-10-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
 <20231023074613.41327-10-aesteve@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: linux-doc@vger.kernel.org, qemu-devel@nongnu.org, banackm@vmware.com,
 virtualization@lists.linux-foundation.org, David Airlie <airlied@gmail.com>,
 mombasawalam@vmware.com, iforbes@vmware.com, Jonathan Corbet <corbet@lwn.net>,
 javierm@redhat.com,
 VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 David Airlie <airlied@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 dri-devel@lists.freedesktop.org, spice-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Matt Roper <matthew.d.roper@intel.com>, contact@emersion.fr,
 linux-kernel@vger.kernel.org, krastevm@vmware.com,
 Rob Clark <robdclark@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 zackr@vmware.com
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
Content-Type: multipart/mixed; boundary="===============7907818630509789583=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============7907818630509789583==
Content-Type: multipart/signed; boundary="Sig_/BqH+LEjYZrs8=tT7kXjXoDd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/BqH+LEjYZrs8=tT7kXjXoDd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Oct 2023 09:46:13 +0200
Albert Esteve <aesteve@redhat.com> wrote:

> From: Michael Banack <banackm@vmware.com>
>=20
> To clarify the intent and reasoning behind the hotspot properties
> introduce userspace documentation that goes over cursor handling
> in para-virtualized environments.
>=20
> The documentation is generic enough to not special case for any
> specific hypervisor and should apply equally to all.
>=20
> Signed-off-by: Zack Rusin <zackr@vmware.com>


Hi,

the below doc text:

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq


> ---
>  Documentation/gpu/drm-kms.rst |  6 ++++
>  drivers/gpu/drm/drm_plane.c   | 58 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
> index a0c83fc481264..158cdcc9351f9 100644
> --- a/Documentation/gpu/drm-kms.rst
> +++ b/Documentation/gpu/drm-kms.rst
> @@ -577,6 +577,12 @@ Variable Refresh Properties
>  .. kernel-doc:: drivers/gpu/drm/drm_connector.c
>     :doc: Variable refresh properties
> =20
> +Cursor Hotspot Properties
> +---------------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_plane.c
> +   :doc: hotspot properties
> +
>  Existing KMS Properties
>  -----------------------
> =20
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 1dc00ad4c33c3..f3f2eae83cca8 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -230,6 +230,61 @@ static int create_in_format_blob(struct drm_device *=
dev, struct drm_plane *plane
>  	return 0;
>  }
> =20
> +/**
> + * DOC: hotspot properties
> + *
> + * HOTSPOT_X: property to set mouse hotspot x offset.
> + * HOTSPOT_Y: property to set mouse hotspot y offset.
> + *
> + * When the plane is being used as a cursor image to display a mouse poi=
nter,
> + * the "hotspot" is the offset within the cursor image where mouse events
> + * are expected to go.
> + *
> + * Positive values move the hotspot from the top-left corner of the curs=
or
> + * plane towards the right and bottom.
> + *
> + * Most display drivers do not need this information because the
> + * hotspot is not actually connected to anything visible on screen.
> + * However, this is necessary for display drivers like the para-virtuali=
zed
> + * drivers (eg qxl, vbox, virtio, vmwgfx), that are attached to a user c=
onsole
> + * with a mouse pointer.  Since these consoles are often being remoted o=
ver a
> + * network, they would otherwise have to wait to display the pointer mov=
ement to
> + * the user until a full network round-trip has occurred.  New mouse eve=
nts have
> + * to be sent from the user's console, over the network to the virtual i=
nput
> + * devices, forwarded to the desktop for processing, and then the cursor=
 plane's
> + * position can be updated and sent back to the user's console over the =
network.
> + * Instead, with the hotspot information, the console can anticipate the=
 new
> + * location, and draw the mouse cursor there before the confirmation com=
es in.
> + * To do that correctly, the user's console must be able predict how the
> + * desktop will process mouse events, which normally requires the deskto=
p's
> + * mouse topology information, ie where each CRTC sits in the mouse coor=
dinate
> + * space.  This is typically sent to the para-virtualized drivers using =
some
> + * driver-specific method, and the driver then forwards it to the consol=
e by
> + * way of the virtual display device or hypervisor.
> + *
> + * The assumption is generally made that there is only one cursor plane =
being
> + * used this way at a time, and that the desktop is feeding all mouse de=
vices
> + * into the same global pointer.  Para-virtualized drivers that require =
this
> + * should only be exposing a single cursor plane, or find some other way
> + * to coordinate with a userspace desktop that supports multiple pointer=
s.
> + * If the hotspot properties are set, the cursor plane is therefore assu=
med to be
> + * used only for displaying a mouse cursor image, and the position of th=
e combined
> + * cursor plane + offset can therefore be used for coordinating with inp=
ut from a
> + * mouse device.
> + *
> + * The cursor will then be drawn either at the location of the plane in =
the CRTC
> + * console, or as a free-floating cursor plane on the user's console
> + * corresponding to their desktop mouse position.
> + *
> + * DRM clients which would like to work correctly on drivers which expose
> + * hotspot properties should advertise DRM_CLIENT_CAP_CURSOR_PLANE_HOTSP=
OT.
> + * Setting this property on drivers which do not special case
> + * cursor planes will return EOPNOTSUPP, which can be used by userspace =
to
> + * gauge requirements of the hardware/drivers they're running on. Advert=
ising
> + * DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT implies that the userspace client=
 will be
> + * correctly setting the hotspot properties.
> + */
> +
>  /**
>   * drm_plane_create_hotspot_properties - creates the mouse hotspot
>   * properties and attaches them to the given cursor plane
> @@ -237,7 +292,8 @@ static int create_in_format_blob(struct drm_device *d=
ev, struct drm_plane *plane
>   * @plane: drm cursor plane
>   *
>   * This function enables the mouse hotspot property on a given
> - * cursor plane.
> + * cursor plane. Look at the documentation for hotspot properties
> + * to get a better understanding for what they're used for.
>   *
>   * RETURNS:
>   * Zero for success or -errno


--Sig_/BqH+LEjYZrs8=tT7kXjXoDd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmU2LWQACgkQI1/ltBGq
qqc9jg/+O49j7A2awfs+aCc+PJsIXZzo6/vpt0Axrl++SGV6BNXjwSGNNGddCUQE
rZNaWJK3+JBbIqpk9fGz+kNUM1G3UJ5HCveIbl1lCetewGdeJGumMV7gB6/VnK32
zPDon8yBLibA0vHIZHeVp/7ELBNWzPy4XSt3FyOE0dLCen7xukneyZy8bCPpXfR3
bXr7kJV/N2XgZl7MgLRNOMnj/okbJ4dWzD4qUR7Pe8EC0zZ/pBlk7gMfQWeNk1Yl
UmFUix99PDTf3x8BaI22sD9hUg7qkSp1Tf4GtndKyrG5atgYJ61t+1HUAEg8oCJ4
eMH5umZhmm956T7/q7YTv+s3KkyOADQ1tK1ePOSB6I3uM1FF/LqnpzxFQgu11z3O
cl5q1crqZORm+3Sa6X9J7EAFNZzW8+9WD+qgQeuc1o2/mFplmL/fzs/OzkzhTCik
cZVkAFnIykWSoZSka9eG/Xt205wTTBgc0wgryr5OpRr50DCdLr+FfklNM4YLmcqU
ReoL1MWdDPcDtj7t6eaYXTa67kSQaSO/JSbz60cQ9Tt+Rhod6K6MtLFRyTIvFTYj
rISYdRD8Q4Pr8I96vlFXMUsy5hs8amyx5yrWHPWMp+7arZxUbSwupaaRFmTtAiSr
pJCgOmQFFHP+nAbRemAx1+TfNde21rdHuu4ud5Nq3p4ZnzY/taQ=
=75Es
-----END PGP SIGNATURE-----

--Sig_/BqH+LEjYZrs8=tT7kXjXoDd--

--===============7907818630509789583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7907818630509789583==--
