Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153C3C433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 14:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9BBD94019C;
	Mon, 14 Mar 2022 14:48:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HWdUt-HNqUe9; Mon, 14 Mar 2022 14:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E4B3440185;
	Mon, 14 Mar 2022 14:48:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAB38C0033;
	Mon, 14 Mar 2022 14:48:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAECCC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 14:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBA6881919
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 14:48:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZfAJ9vEJrIcw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 14:48:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 029BF81911
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647269293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GMiQH1LonPMifl6a0QGWi66yOtSeKNsLnwJKGhjtJ4=;
 b=IgLHMk1Pv5z4uJtVpYYfKcMC/RwnzHxReXEB/WhxropQDucRsh3yUlT8HI1l0GpeZcqRVw
 2V2LwMatElvJUCBTfCFtOMUp+7jPIAVKPmKyw04nvm5nkTxpVioNcoKYn+/wRam+E4XjU8
 Zkh3UHmQ7yIN5oAfNfi689+xeda72qU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-_AiYtbFCNPSqn4Ye0dIA2g-1; Mon, 14 Mar 2022 10:48:10 -0400
X-MC-Unique: _AiYtbFCNPSqn4Ye0dIA2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07DEA85A5BC;
 Mon, 14 Mar 2022 14:48:09 +0000 (UTC)
Received: from localhost (unknown [10.39.195.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 93ACDC33260;
 Mon, 14 Mar 2022 14:48:08 +0000 (UTC)
Date: Mon, 14 Mar 2022 14:48:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
Message-ID: <Yi9Vp3+wkpH8VMNU@stefanha-x1.localdomain>
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <Yi82BL9KecQsVfgX@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: linux-block@vger.kernel.org, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org, mst@redhat.com
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
Content-Type: multipart/mixed; boundary="===============7880965702752320243=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============7880965702752320243==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m9x06S17g2qlOLVa"
Content-Disposition: inline


--m9x06S17g2qlOLVa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2022 at 09:33:08PM +0900, Suwan Kim wrote:
> On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> >=20
> > =E5=9C=A8 2022/3/11 =E4=B8=8B=E5=8D=8811:28, Suwan Kim =E5=86=99=E9=81=
=93:
> > > diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/vir=
tio_blk.h
> > > index d888f013d9ff..3fcaf937afe1 100644
> > > --- a/include/uapi/linux/virtio_blk.h
> > > +++ b/include/uapi/linux/virtio_blk.h
> > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > >   	 * deallocation of one or more of the sectors.
> > >   	 */
> > >   	__u8 write_zeroes_may_unmap;
> > > +	__u8 unused1;
> > > -	__u8 unused1[3];
> > > +	__virtio16 num_poll_queues;
> > >   } __attribute__((packed));
> >=20
> >=20
> > This looks like a implementation specific (virtio-blk-pci) optimization=
, how
> > about other implementation like vhost-user-blk?
>=20
> I didn=E2=80=99t consider vhost-user-blk yet. But does vhost-user-blk also
> use vritio_blk_config as kernel-qemu interface?
>=20
> Does vhost-user-blk need additional modification to support polling
> in kernel side?

I think QEMU's --device vhost-user-blk-pci will work with this patch
series because QEMU passes the struct virtio_blk_config from the
vhost-user-blk server to the guest. If a new vhost-user-blk server
supports num_poll_queues then the guest will see the config field.

However, the new feature bit that was discussed in another sub-thread
needs to be added to hw/block/vhost-user-blk.c:user_feature_bits[] and
QEMU needs to be recompiled.

Stefan

--m9x06S17g2qlOLVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmIvVacACgkQnKSrs4Gr
c8gNdAf/QqaaX2nmChWxko1xxMTk7lYZ5ul9IpAj5Thd3yrP/UoXspWLVgNJ0DJE
wJGOkll8hsc7/vGALzp7Z3d1ZOnridtMXJvFnsSLzVdLvP7EjKuJ62RdrWZIrezd
Gf52L9Lq1C4UOekVfz2Lv6Sap4ELCLn8xhfkWK1ktb8qMNmsFKl1jXaBpTfZpGUO
17+/oi2P0upSgFN9sYN4hjgnFspCiEJgrTloYpuPCKPkkw+Lh7fu5HTGtF9UiXWN
y5QZqhqTj0jvvLgDZPTazWvr5XPmIACjiSV4w+khaJV3OWDk+EoDgugVzbLiCoFO
rNxlQlEYNOmg6tFXYKg/VduyB5N+LQ==
=L947
-----END PGP SIGNATURE-----

--m9x06S17g2qlOLVa--


--===============7880965702752320243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7880965702752320243==--

