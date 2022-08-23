Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D6DC32772
	for <virtualization@archiver.kernel.org>; Tue, 23 Aug 2022 20:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DD194040B;
	Tue, 23 Aug 2022 20:30:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DD194040B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z9ebQQPS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CdsBk99tOFxn; Tue, 23 Aug 2022 20:30:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6701F4094B;
	Tue, 23 Aug 2022 20:30:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6701F4094B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34FABC0032;
	Tue, 23 Aug 2022 20:30:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8D52C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9981D60BB8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:30:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9981D60BB8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z9ebQQPS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOMGOSD1a7Nh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:30:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB99760BAC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB99760BAC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 20:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661286638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsXMj/6hNU0e5tAGMLQtNIyftNI4ROUnRCyckBUdrAw=;
 b=Z9ebQQPSJ1eVpgTlBNZZ39NAHByV3QYYZ8iiyJFKevZ/ITn6+o4j5xTw8MUHjBnjkhNYEL
 IQJDBaCxqc986wHcx12PvBsF7r7v3XmJUkLUD5iRJ5Tboc1o0UhHyY5KD8RhEOfZUcZgbn
 qlb4qXfubRQivDGP0ilTlKoXMCn5ho8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-KV7nwgpXNDq20QYFR3O9MQ-1; Tue, 23 Aug 2022 16:30:31 -0400
X-MC-Unique: KV7nwgpXNDq20QYFR3O9MQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26964296A603;
 Tue, 23 Aug 2022 20:30:30 +0000 (UTC)
Received: from localhost (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 665021121315;
 Tue, 23 Aug 2022 20:30:29 +0000 (UTC)
Date: Tue, 23 Aug 2022 16:30:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v4 0/9] vsock: updates for SO_RCVLOWAT handling
Message-ID: <YwU443jzc/N4fV3A@fedora>
References: <de41de4c-0345-34d7-7c36-4345258b7ba8@sberdevices.ru>
 <YwUnAhWauSFSJX+g@fedora> <20220823121852.1fde7917@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220823121852.1fde7917@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Cc: Vishnu Dasa <vdasa@vmware.com>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
 "David S. Miller" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============4575624750668074231=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4575624750668074231==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tW4PvRQqQXgDRL/h"
Content-Disposition: inline


--tW4PvRQqQXgDRL/h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2022 at 12:18:52PM -0700, Jakub Kicinski wrote:
> On Tue, 23 Aug 2022 15:14:10 -0400 Stefan Hajnoczi wrote:
> > Stefano will be online again on Monday. I suggest we wait for him to
> > review this series. If it's urgent, please let me know and I'll take a
> > look.
>=20
> It was already applied, sorry about that. But please continue with
> review as if it wasn't. We'll just revert based on Stefano's feedback
> as needed.

Okay, no problem.

Stefan

--tW4PvRQqQXgDRL/h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMFOOMACgkQnKSrs4Gr
c8hvlQgAo4gB0BkrZtfmmojZpiKE6Xq15IttUNkmuyZgxF8sLW3iBu9LtCiQDZU2
6sXR4GxAoAhr3tzo1KsUrMoc/hx2+Io9fLHLVLFZfFgnY52O3ipxSoKB3gE/DTfk
hCpzD4jW7BSIC1WImlqYOZ3kRdhxBxawrEF2hMRSnNS2ewSJJTNsJjrfmb/+te9e
kVb8naCagmAeznr1rOTXC+6xJlCQo9c5swxpxPGOpcFHGv71hxGDvxbvTB6omKXA
Z1sbgS37LGQ8J+gBXFZ8SMDKGC1bnRVVOFsioohZ43oFO0yzjjqqx/2s6+qZUcGH
CPYyhqwKD/oFfY/saOMIHCNnQkNV5w==
=Vfeh
-----END PGP SIGNATURE-----

--tW4PvRQqQXgDRL/h--


--===============4575624750668074231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4575624750668074231==--

