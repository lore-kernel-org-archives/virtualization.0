Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3DEC77B7F
	for <virtualization@archiver.kernel.org>; Wed,  3 May 2023 08:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA8D0610C3;
	Wed,  3 May 2023 08:01:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA8D0610C3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=QJ7+ozXb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l2gWr_Sl92-m; Wed,  3 May 2023 08:01:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01BB160B04;
	Wed,  3 May 2023 08:01:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01BB160B04
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF540C0036;
	Wed,  3 May 2023 08:01:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F090CC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 08:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C888440125
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 08:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C888440125
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=QJ7+ozXb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cVrcbnQLD2Pp
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 08:01:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90C764011F
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90C764011F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 May 2023 08:01:23 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2a8bb726210so49016151fa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 May 2023 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683100881; x=1685692881;
 h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=aC5JTQzavwe1IpCo8NCgQ6eNbVp0oKweu2nb0GoUyrI=;
 b=QJ7+ozXbcgO8CCQtRst8f/e3e1p2/+V2OIG3eKWpYwv94gcuX0JomMeYBhyCrp9aEB
 tGRmWkyLNqii612vys+J6zPwBwEReqxyD8i+b5KmBKeTeDw+nH5WNXSNJyIIFOE69oSJ
 rmmHjMmDh4uD91pafBrSTTyNRa7RdTqV96FZM8fzjrHBEV9xqFAeHLW+dzwkNd/1QhQF
 SVi8hVsl2jsxl59jXD8LrxXBjm0r0vlZAImrBwn/CqgLQUQUSgsRNYsX9hLGx96IepFN
 +x6r4JEVmMp8VBcVXB+DOXUhqKWwjK92XAFoxBzi1Met2HTdZXq+miAHK6qwDCmI0J6x
 R0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683100881; x=1685692881;
 h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aC5JTQzavwe1IpCo8NCgQ6eNbVp0oKweu2nb0GoUyrI=;
 b=kjbVW5sj0UqHVSFDG2TM8S1hh5c92VzehdoyUiTr3Gr1SHirZkOAuSBZxZKmhQNQ/k
 n7/qXF6I2sNcZli/4ow4i7DkWNDLxjUXnwiI8lQ1VdMP6Fcpxy8sSE7lLXME6aN3EWtl
 krHS/QRvnnoYVpmOaRzc7OMGZrzgDHfKxnu70xPRVsitSua5dpmSBx9BiWzUs3aQDqvP
 vp2umy4/jC6KmsmMEzqeMR+5kPEHyc02RsmUPuYJgt2FSBIHlB18ygRmVTszzWP0DwD7
 52GGCGj4KuoYvagSMf+dILoSM1RywhTL/L8HzuMWNnqwlPqYBjzEnKrc0c/xZVMOTPJr
 kiaw==
X-Gm-Message-State: AC+VfDwt2nLM8VsqihvL7G3kjzWKz1ooN/MSOiGN/JdsOuqHPZwThgsD
 bKA9yBbqvLSxeRRp/GPTDn0=
X-Google-Smtp-Source: ACHHUZ69Pr0CUvY4Nm5MCiaVA88rmsDAKz/1z9qhu2lK8333DnsmKk6eadZqrF2EueM9rbVwBohoug==
X-Received: by 2002:a2e:864d:0:b0:298:9fb5:9f20 with SMTP id
 i13-20020a2e864d000000b002989fb59f20mr5633682ljj.26.1683100880988; 
 Wed, 03 May 2023 01:01:20 -0700 (PDT)
Received: from eldfell ([194.136.85.206]) by smtp.gmail.com with ESMTPSA id
 z8-20020a2e7e08000000b002a777ce224dsm5806800ljc.138.2023.05.03.01.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 May 2023 01:01:20 -0700 (PDT)
Date: Wed, 3 May 2023 11:01:16 +0300
From: Pekka Paalanen <ppaalanen@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v2 1/8] drm: Disable the cursor plane on atomic contexts
 with virtualized drivers
Message-ID: <20230503110116.54c5b3d7@eldfell>
In-Reply-To: <87y1m5x3bt.fsf@minerva.mail-host-address-is-not-set>
References: <20220712033246.1148476-1-zack@kde.org>
 <20220712033246.1148476-2-zack@kde.org>
 <YvPfedG/uLQNFG7e@phenom.ffwll.local>
 <87lei7xemy.fsf@minerva.mail-host-address-is-not-set>
 <0dd2fa763aa0e659c8cbae94f283d8101450082a.camel@vmware.com>
 <87y1m5x3bt.fsf@minerva.mail-host-address-is-not-set>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "hdegoede@redhat.com" <hdegoede@redhat.com>,
 "airlied@linux.ie" <airlied@linux.ie>,
 "belmouss@redhat.com" <belmouss@redhat.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "gurchetansingh@chromium.org" <gurchetansingh@chromium.org>,
 Martin Krastev <krastevm@vmware.com>,
 Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
 Zack Rusin <zackr@vmware.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "spice-devel@lists.freedesktop.org" <spice-devel@lists.freedesktop.org>,
 "airlied@redhat.com" <airlied@redhat.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Jonas =?UTF-8?B?w4VkYWhs?= <jadahl@gmail.com>,
 Maaz Mombasawala <mombasawalam@vmware.com>
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
Content-Type: multipart/mixed; boundary="===============9059501473392104684=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============9059501473392104684==
Content-Type: multipart/signed; boundary="Sig_/Aanyz/d7FPDr+yADOKDullE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Aanyz/d7FPDr+yADOKDullE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 03 May 2023 09:48:54 +0200
Javier Martinez Canillas <javierm@redhat.com> wrote:

> Zack Rusin <zackr@vmware.com> writes:
>=20
> > On Tue, 2023-05-02 at 11:32 +0200, Javier Martinez Canillas wrote: =20
> >> !! External Email
> >>=20
> >> Daniel Vetter <daniel@ffwll.ch> writes:
> >>  =20
> >> > On Mon, Jul 11, 2022 at 11:32:39PM -0400, Zack Rusin wrote: =20
> >> > > From: Zack Rusin <zackr@vmware.com>
> >> > >=20
> >> > > Cursor planes on virtualized drivers have special meaning and requ=
ire
> >> > > that the clients handle them in specific ways, e.g. the cursor pla=
ne
> >> > > should react to the mouse movement the way a mouse cursor would be
> >> > > expected to and the client is required to set hotspot properties o=
n it
> >> > > in order for the mouse events to be routed correctly.
> >> > >=20
> >> > > This breaks the contract as specified by the "universal planes". F=
ix it
> >> > > by disabling the cursor planes on virtualized drivers while adding
> >> > > a foundation on top of which it's possible to special case mouse c=
ursor
> >> > > planes for clients that want it.
> >> > >=20
> >> > > Disabling the cursor planes makes some kms compositors which were =
broken,
> >> > > e.g. Weston, fallback to software cursor which works fine or at le=
ast
> >> > > better than currently while having no effect on others, e.g. gnome=
-shell
> >> > > or kwin, which put virtualized drivers on a deny-list when running=
 in
> >> > > atomic context to make them fallback to legacy kms and avoid this =
issue.
> >> > >=20
> >> > > Signed-off-by: Zack Rusin <zackr@vmware.com>
> >> > > Fixes: 681e7ec73044 ("drm: Allow userspace to ask for universal pl=
ane list
> >> > > (v2)") =20
> >>=20
> >> [...]
> >>  =20
> >> > > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> >> > > index f6159acb8856..c4cd7fc350d9 100644
> >> > > --- a/include/drm/drm_drv.h
> >> > > +++ b/include/drm/drm_drv.h
> >> > > @@ -94,6 +94,16 @@ enum drm_driver_feature {
> >> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * synchronization of command submis=
sion.
> >> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> > > =C2=A0=C2=A0=C2=A0=C2=A0 DRIVER_SYNCOBJ_TIMELINE=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D BIT(6),
> >> > > +=C2=A0=C2=A0=C2=A0 /**
> >> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * @DRIVER_VIRTUAL:
> >> > > +=C2=A0=C2=A0=C2=A0=C2=A0 *
> >> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * Driver is running on top of virtual ha=
rdware. The most significant
> >> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * implication of this is a requirement o=
f special handling of the
> >> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * cursor plane (e.g. cursor plane has to=
 actually track the mouse
> >> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * cursor and the clients are required to=
 set hotspot in order for
> >> > > +=C2=A0=C2=A0=C2=A0=C2=A0 * the cursor planes to work correctly).
> >> > > +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> > > +=C2=A0=C2=A0=C2=A0 DRIVER_VIRTUAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D BIT(7), =20
> >> >=20
> >> > I think the naming here is unfortunate, because people will vonder w=
hy
> >> > e.g. vkms doesn't set this, and then add it, and confuse stuff compl=
etely.
> >> >=20
> >> > Also it feels a bit wrong to put this onto the driver, when really i=
t's a
> >> > cursor flag. I guess you can make it some kind of flag in the drm_pl=
ane
> >> > structure, or a new plane type, but putting it there instead of into=
 the
> >> > "random pile of midlayer-mistake driver flags" would be a lot better.
> >> >=20
> >> > Otherwise I think the series looks roughly how I'd expect it to look.
> >> > -Daniel
> >> >  =20
> >>=20
> >> AFAICT this is the only remaining thing to be addressed for this serie=
s ? =20
> >
> > No, there was more. tbh I haven't had the time to think about whether t=
he above
> > makes sense to me, e.g. I'm not sure if having virtualized drivers expo=
se "support
> > universal planes" and adding another plane which is not universal (the =
only
> > "universal" plane on them being the default one) makes more sense than =
a flag that
> > says "this driver requires a cursor in the cursor plane". There's certa=
inly a huge
> > difference in how userspace would be required to handle it and it's way=
 uglier with
> > two different cursor planes. i.e. there's a lot of ways in which this c=
ould be
> > cleaner in the kernel but they all require significant changes to users=
pace, that go
> > way beyond "attach hotspot info to this plane". I'd like to avoid appro=
aches that
> > mean running with atomic kms requires completely separate paths for vir=
tualized
> > drivers because no one will ever support and maintain it.
> >
> > It's not a trivial thing because it's fundamentally hard to untangle th=
e fact the
> > virtualized drivers have been advertising universal plane support witho=
ut ever
> > supporting universal planes. Especially because most new userspace in g=
eneral checks
> > for "universal planes" to expose atomic kms paths.
> > =20
>=20
> After some discussion on the #dri-devel, your approach makes sense and the
> only contention point is the name of the driver feature flag name. The one
> you are using (DRIVER_VIRTUAL) seems to be too broad and generic (the fact
> that vkms won't set and is a virtual driver as well, is a good example).
>=20
> Maybe something like DRIVER_CURSOR_HOTSPOT or DRIVER_CURSOR_COMMANDEERING
> would be more accurate and self explanatory ?
>=20
> > The other thing blocking this series was the testing of all the edge ca=
ses, I think
> > Simon and Pekka had some ideas for things to test (e.g. run mutter with=
 support for
> > this and wayland without support for this in at the same time in differ=
ent consoles
> > and see what happens). I never had the time to do that either.
> > =20
>=20
> I understand that every new feature needs tests but I fail to see why
> the bar is higher for this feature than others? I would prefer if this
> series are not blocked due some potential issues on hypothetical corner
> cases that might not happen in practice. Or do people really run two or
> more compositors on different console and switch between them ?

I have no recollection at all about what was talked about this, but in
certain virtualized cases you will always have two display systems
simultaneously:
- the guest display system which uses the nested KMS driver in the
  guest VM, which presents to
- a VM viewer application on the host, which presents via Wayland to
- the host display system which uses a hardware KMS driver.

Maybe it was more like that to test?


Thanks,
pq

> >> Zack, are you planning to re-spin a v3 of this patch-set? Asking becau=
se
> >> we want to take virtio-gpu out of the atomic KMS deny list in mutter, =
but
> >> first need this to land.
> >>=20
> >> If you think that won't be able to do it in the short term, Bilal (Cc'=
ed)
> >> or me would be glad to help with that. =20
> >
> > This has been on my todo for a while I just never had the time to go th=
rough all the
> > remaining issues. Fundamentally it's not so much a technical issue anym=
ore, it's
> > about picking the least broken solution and trying to make the best out=
 of a pretty
> > bad situation. In general it's hard to paint a bikeshed if all you have=
 is a million
> > shades of gray ;)
> > =20
>=20
> Agreed. And I believe that other than the driver cap name, everyone agrees
> with the color of your bikeshed :)
>=20


--Sig_/Aanyz/d7FPDr+yADOKDullE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmRSFMwACgkQI1/ltBGq
qqeTkRAAni4ZKBVkfh3TIaK/YQ9NppBuzwrD9KFeTZJwL1M12ON1GZmJe07XU+5a
nfzMmwEtb0p37eBo5bWhdlIhg43VzYUe9BG/DGgEaXTU70YbjYGEjVsAqEl+luCa
r1a/s7ppN+xRYmGcCPVKBl8iP1Bah+MxCPFtCGF2JESR4n3hJmrRmZYMQJnGF5DD
A7sZLBFraYKNH5CVYH8dpoEZrk5l/TJy1IaL4WcBaNDe+4CZa8K3oDax/aRIAwUf
/0TKw9VePlcJWWNzFXfca4QzUjxhcJG+HufW9WGoqXOJqg7hrjHrzPTvEUQzHPQe
1UcgPBy6uQf8T9oOB7VHr0PgfN4CYo6zsr62ePG7QrLNyho0WdK1V429a/QTcbxw
kAg7vHDvnboeBMbwLWUu+V1bMkSkXHIhHFoERtNhDLuEXDlwXW/d7xcL09FI4JVw
ivpdC96SvOTXfJ0kiKO1vTwS4XnAvm9Xt50ZbWFgYbNEkMUWk+RsLqrhOcwR9D27
8vXUmEvswiYy/SkQTPBfga3O+qaUOmKsIOss6uiGrNqqYAhIs/qvhsE2Wo62mdXJ
e/+iJN0f9XOCZOcLxO8kiVfAazsDwNrykqwZH5+PDVRwprzJTsoyUA6ntsk8ffl5
RDjNj0dlakfwyYr6iywbu+BUb74ZsG8YODK7FfvQzIJyd0QcR9c=
=d+Q9
-----END PGP SIGNATURE-----

--Sig_/Aanyz/d7FPDr+yADOKDullE--

--===============9059501473392104684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9059501473392104684==--
