Return-Path: <SRS0=lZ9m=FO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA815C433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 11:56:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF6323D5A
	for <virtualization@archiver.kernel.org>; Thu, 10 Dec 2020 11:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF6323D5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 077D1868C0;
	Thu, 10 Dec 2020 11:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o0fzvI6Quz9k; Thu, 10 Dec 2020 11:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C9B1486670;
	Thu, 10 Dec 2020 11:56:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0B49C0FA7;
	Thu, 10 Dec 2020 11:56:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CFF3C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 13899868B8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:56:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Auc3tLz4vnBs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:56:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 46A2C86670
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Dec 2020 11:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607601359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MucEp2q9Z+8tlAqhqnNq4svdhUxR95XxXhNV9vCD9Kw=;
 b=L2QwYC2LHZRYpVurznZ4Pcg5X2/FgZiqmeWPISmAERIpz/fmidHpR6BcDGw4ppILwOx06/
 Ip/TWiu4e60NEuTI9wNdev7twlV9Rm0ZHzv7XlNj9bUUIwR7eSOwdHJstJE/Qod7fRXk8N
 XJYtTY2zaeNaX/3g/YfX6rGsWKRveug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-Iu-oSkLwM9qwB-9bm14vaA-1; Thu, 10 Dec 2020 06:55:55 -0500
X-MC-Unique: Iu-oSkLwM9qwB-9bm14vaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14D46100C605;
 Thu, 10 Dec 2020 11:55:52 +0000 (UTC)
Received: from localhost (ovpn-113-62.ams2.redhat.com [10.36.113.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 568F419C78;
 Thu, 10 Dec 2020 11:55:48 +0000 (UTC)
Date: Thu, 10 Dec 2020 11:55:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC PATCH 13/27] vhost: Send buffers to device
Message-ID: <20201210115547.GH416119@stefanha-x1.localdomain>
References: <20201120185105.279030-1-eperezma@redhat.com>
 <20201120185105.279030-14-eperezma@redhat.com>
 <20201208081621.GR203660@stefanha-x1.localdomain>
 <CAJaqyWf13ta5MtzmTUz2N5XnQ+ebqFPYAivdggL64LEQAf=y+A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWf13ta5MtzmTUz2N5XnQ+ebqFPYAivdggL64LEQAf=y+A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Content-Type: multipart/mixed; boundary="===============1494170749395678311=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1494170749395678311==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline

--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 07:41:23PM +0100, Eugenio Perez Martin wrote:
> On Tue, Dec 8, 2020 at 9:16 AM Stefan Hajnoczi <stefanha@gmail.com> wrote=
:
> > On Fri, Nov 20, 2020 at 07:50:51PM +0100, Eugenio P=E9rez wrote:
> > > +        while (true) {
> > > +            int r;
> > > +            if (virtio_queue_full(vq)) {
> > > +                break;
> > > +            }
> >
> > Why is this check necessary? The guest cannot provide more descriptors
> > than there is ring space. If that happens somehow then it's a driver
> > error that is already reported in virtqueue_pop() below.
> >
>=20
> It's just checked because virtqueue_pop prints an error on that case,
> and there is no way to tell the difference between a regular error and
> another caused by other causes. Maybe the right thing to do is just to
> not to print that error? Caller should do the error printing in that
> case. Should we return an error code?

The reason an error is printed today is because it's a guest error that
never happens with correct guest drivers. Something is broken and the
user should know about it.

Why is "virtio_queue_full" (I already forgot what that actually means,
it's not clear whether this is referring to avail elements or used
elements) a condition that should be silently ignored in shadow vqs?

Stefan

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/SDMMACgkQnKSrs4Gr
c8g6rQgAoyNP4PVcZp9IjF/ZpHcUkbIw8vq2zHMVYynE086IcL4SufcLEwnibkyk
6zkRHz9diZrDtE8JiVVDCgd335nP1fB5Gc6QtuTy6TP03GFD7jRCBtFuWZz0zPNJ
EhBn7yQGyh2MI6U5qE4cIZso2KQO0KxgU/TGSMcwY5dErD/LvDh+WZBIUVqpJvem
5/uSCeSkVXyHIwMzsTYV770Ja7yiiOeNSsODlonzy7GfBg05wnh7SCtVbyiKcvTF
n4KEqDQyurGvMZg4tExPxNL04bu9AAPvdK1QGjAfPdufdAPllV4xfiUEI5sOM9l1
N3hvUjX/foOV3ccIX3dyrNyRIa/mgA==
=x9KI
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--


--===============1494170749395678311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1494170749395678311==--

