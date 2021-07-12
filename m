Return-Path: <SRS0=5hAK=ME=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA9EC07E99
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 09:34:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F4D6101D
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 09:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F4D6101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28C59833CB;
	Mon, 12 Jul 2021 09:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id brq0-ca-I4x6; Mon, 12 Jul 2021 09:34:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F10BC833C6;
	Mon, 12 Jul 2021 09:34:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0B44C001A;
	Mon, 12 Jul 2021 09:34:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6BADC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 09:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BEEDE833CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 09:34:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fwgv7vc-v3KM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 09:34:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00965833C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626082450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gdA+S+3YSWLYResZwMQhyDJvMFxlp9J0PZNAibvseEU=;
 b=JfvjU43sHnBIjOa1AuqoLRvy//hmxa2k6QxBLumg8bent0n2dKvz2cosFK4GwVZGK0kFub
 wvJ4PWyVE14LXSYBVB5nw3yg0iyOGE1gZQKu10C2Vv/HryrImOPQV2a/gA0c5qxuhapvGC
 v0EJHu9WQxn585D23RFDyZCx5oFBLvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-DsTtSTTPN3Oc37bTxBzuIg-1; Mon, 12 Jul 2021 05:34:08 -0400
X-MC-Unique: DsTtSTTPN3Oc37bTxBzuIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7F0E800D62;
 Mon, 12 Jul 2021 09:34:06 +0000 (UTC)
Received: from localhost (ovpn-112-230.ams2.redhat.com [10.36.112.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98C5B604CF;
 Mon, 12 Jul 2021 09:34:02 +0000 (UTC)
Date: Mon, 12 Jul 2021 10:34:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Wenchao Hao <haowenchao@huawei.com>
Subject: Re: [bug report]scsi: drive letter drift problem
Message-ID: <YOwMiYRmGYskOn7A@stefanha-x1.localdomain>
References: <7ae2293e-71a9-f68e-0bfb-b4a70ecf493e@huawei.com>
MIME-Version: 1.0
In-Reply-To: <7ae2293e-71a9-f68e-0bfb-b4a70ecf493e@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Wu Bo <wubo40@huawei.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linfeilong@huawei.com,
 Zhiqiang Liu <liuzhiqiang26@huawei.com>, yuzhanzhan@huawei.com,
 Paolo Bonzini <pbonzini@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============8371287030649352699=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8371287030649352699==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fuPUrc/TQtUWERHW"
Content-Disposition: inline


--fuPUrc/TQtUWERHW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 12, 2021 at 12:47:05PM +0800, Wenchao Hao wrote:
> We deploy two SCSI disk in one SCSI host(virtio-scsi bus) for one machine,
> whose ids are [0:0:0:0] and [0:0:1:0].
>=20
> Mostly, the device letter are assigned as following after reboot:
> [0:0:0:0] --> sda
> [0:0:1:0] --> sdb
>=20
> While in rare cases, the device letter shown as following:
> [0:0:0:0] --> sdb
> [0:0:1:0] --> sda
>=20
> Could we guarantee "sda" is assigned to [0:0:0:0] and "sdb" is assigned to
> [0:0:1:0] or not?
> If we can, then how?

Is there a stable ID that you can use in /dev/disk/by-*?

Stefan

--fuPUrc/TQtUWERHW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDsDIkACgkQnKSrs4Gr
c8hdnQf/Rs2fRaJYaSbQa32JKf0l4C/g6F+qFtbfnjBx97dzW6wb0+PPyavNMGmp
tWbISz6bIz3StkRv8oOstrJA1px9caorIZJTvXXBf036EJFtnOuZq9HF1enjybNw
RLFknEaavVlj6ay2ZkdxkIwCjGJtUcU/U6lXFGrWkwqScP6TOmhnV+l7nkcH74Kq
lffTF6TC6rqGMQNVpPzK4PueRMSuBzWL4TAol61w9o6pwGYnxCObOnQIF4QGj6cE
LKY89s8dbJG8SEN1LkUrqsd9NkV9Kd4lT67QEJd/qoWCBXFmL4mbF+ceJ5B0kL13
RM9O4ybPKVXqiWhprpNon4qvBfwo3w==
=0+Ee
-----END PGP SIGNATURE-----

--fuPUrc/TQtUWERHW--


--===============8371287030649352699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8371287030649352699==--

