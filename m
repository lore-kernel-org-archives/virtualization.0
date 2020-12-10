Return-Path: <SRS0=lZ9m=FO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C9CC433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 11:57:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C10D23D5A
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 11:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C10D23D5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 81675868C6;
	Thu, 10 Dec 2020 11:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0YEXERS1E3+x; Thu, 10 Dec 2020 11:57:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5C3FA868B8;
	Thu, 10 Dec 2020 11:57:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BA78C0FA7;
	Thu, 10 Dec 2020 11:57:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71DE1C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5F9EA868C4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wPliJPJyl57m
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:57:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A7A8C868B8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607601469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+gQ9iINAWDXR5JwO1kT+v2+a0wsEJwps06F6jliWiHg=;
 b=DAW1g+CzcU3QHaEKuM5kxTDvNAa6W0SfgptrhwUrPHxL6ob9HH+yYU2zON3G+apDjLHIL1
 NqD8EOTsjJJ7YqKC84rAiAtMJ2FUr7vbWlk5G2VKqBaBuUyMHzvpfYq7bQAYaRbpc6Rxe3
 bA5hVgv9LcQ9q0ZrblmFAJCqJrh81qM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-uuDY_b2UP4KRLbhduxHdtQ-1; Thu, 10 Dec 2020 06:57:46 -0500
X-MC-Unique: uuDY_b2UP4KRLbhduxHdtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A6F1005513;
 Thu, 10 Dec 2020 11:57:43 +0000 (UTC)
Received: from localhost (ovpn-113-62.ams2.redhat.com [10.36.113.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48B0C5C67A;
 Thu, 10 Dec 2020 11:57:29 +0000 (UTC)
Date: Thu, 10 Dec 2020 11:57:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC PATCH 16/27] virtio: Expose virtqueue_alloc_element
Message-ID: <20201210115729.GI416119@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-17-eperezma@redhat.com>
 <20201208082552.GT203660@stefanha-x1.localdomain>
 <CAJaqyWdN7iudf8mDN4k4Fs9j1x+ztZARuBbinPHD3ZQSMH1pyQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdN7iudf8mDN4k4Fs9j1x+ztZARuBbinPHD3ZQSMH1pyQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Daniel Daly <dandaly0@gmail.com>,
 virtualization@lists.linux-foundation.org, Liran Alon <liralon@gmail.com>,
 Eli Cohen <eli@mellanox.com>, Nitin Shrivastav <nitin.shrivastav@broadcom.com>,
 Alex Barba <alex.barba@broadcom.com>,
 Christophe Fontaine <cfontain@redhat.com>, Lee Ballard <ballle98@gmail.com>,
 Lars Ganrot <lars.ganrot@gmail.com>, Rob Miller <rob.miller@broadcom.com>,
 Howard Cai <howard.cai@gmail.com>, Parav Pandit <parav@mellanox.com>,
 vm <vmireyno@marvell.com>, Salil Mehta <mehta.salil.lnk@gmail.com>,
 Stephen Finucane <stephenfin@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Sean Mooney <smooney@redhat.com>, Jim Harford <jim.harford@broadcom.com>,
 Dmytro Kazantsev <dmytro.kazantsev@gmail.com>, Siwei Liu <loseweigh@gmail.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Michael Lilja <ml@napatech.com>,
 Max Gurtovoy <maxgu14@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4564759401190206331=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4564759401190206331==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Content-Disposition: inline

--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 07:46:49PM +0100, Eugenio Perez Martin wrote:
> On Tue, Dec 8, 2020 at 9:26 AM Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> >
> > On Fri, Nov 20, 2020 at 07:50:54PM +0100, Eugenio P=E9rez wrote:
> > > Specify VirtQueueElement * as return type makes no harm at this momen=
t.
> >
> > The reason for the void * return type is that C implicitly converts voi=
d
> > pointers to pointers of any type. The function takes a size_t sz
> > argument so it can allocate a object of user-defined size. The idea is
> > that the user's struct embeds a VirtQueueElement field. Changing the
> > return type to VirtQueueElement * means that callers may need to
> > explicitly cast to the user's struct type.
> >
> > It's a question of coding style but I think the void * return type
> > communicates what is going on better than VirtQueueElement *.
>=20
> Right, what I meant with that is that nobody uses that feature, but I
> just re-check and I saw that contrib/vhost-user-blk actually uses it
> (not checked for more uses). I think it is better just to drop this
> commit.

contrib/vhost-user-blk doesn't use hw/virtio/virtio.c. The code is
similar and copy-pasted, but you are free to change this file without
affecting vontrib/vhost-user-blk :).

I still think it's clearer to make it obvious that this function
allocates an object of generic type or at least the change is purely a
question of style and probably not worth making.

Stefan

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/SDSgACgkQnKSrs4Gr
c8gBXggAw53QuLAS8n2bgSqAmCJga4/haYpDTp+tcWdB6R0QXZYfoJpiYcwL6Xor
xVRBetMYe7/mi+28pZ8gklFMpXUoxN4ZqJiIfGUXlLzhUaT5nkpvfxqyhnXkf1Hy
GqNiuv+V6U6kEvlVKK5ImLovsDj9xN6Gy80NUSk1a689Z+6qlD6zs21HAGOSpl47
ZsDLjAP6SMiYE6ZTVxvm42vBho0ixxW/ulW1BxlAOzWnukknFQr1Ci5Hl3RMsDmR
TmaccrPr8RgZtRzOVIOT/MhxCxBke95BKC5SQiLeooYIGGr6kIvIfEonTBCgLBkO
06D5WVldB7oAONWscYTRjJzqlKSUIA==
=090p
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--


--===============4564759401190206331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4564759401190206331==--

