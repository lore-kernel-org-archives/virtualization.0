Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9B3C32774
	for <virtualization@archiver.kernel.org>; Tue, 23 Aug 2022 19:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A82540866;
	Tue, 23 Aug 2022 19:14:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A82540866
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ckJt+eIA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id If1I1dF_rfvY; Tue, 23 Aug 2022 19:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09494402E7;
	Tue, 23 Aug 2022 19:14:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09494402E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2157C0033;
	Tue, 23 Aug 2022 19:14:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F4DFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 19:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFC82402E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 19:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFC82402E7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NGHTp3h_PwA1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 19:14:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 363F8402E0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 363F8402E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 19:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661282054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lf4lftfoYaSkjrGheHP3w/cy0mbiwD/FcUC/oTLQSG8=;
 b=ckJt+eIAMNSNE8aNCEjn8Y9Rz13rpZA1E2k+5kYgjIWrFun5A7WeX7XEJkunyFstZcaTol
 R3icQOUlBJAX7vB1KSAjp1Tx7LAXxjW8wdzoXn98i2I6H04NoOWIINceX4feWVYvCRFshg
 Dw3ngI6Rzc1lQrkxgKr3mBs4Oj40IYw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-4g7CuzW_Mrue8FfFDcjs-g-1; Tue, 23 Aug 2022 15:14:13 -0400
X-MC-Unique: 4g7CuzW_Mrue8FfFDcjs-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 700411C13941;
 Tue, 23 Aug 2022 19:14:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2A032166B26;
 Tue, 23 Aug 2022 19:14:11 +0000 (UTC)
Date: Tue, 23 Aug 2022 15:14:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v4 0/9] vsock: updates for SO_RCVLOWAT handling
Message-ID: <YwUnAhWauSFSJX+g@fedora>
References: <de41de4c-0345-34d7-7c36-4345258b7ba8@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <de41de4c-0345-34d7-7c36-4345258b7ba8@sberdevices.ru>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
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
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============8348426708844167758=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8348426708844167758==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MY0QU7bnoDA4DEoQ"
Content-Disposition: inline


--MY0QU7bnoDA4DEoQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 19, 2022 at 05:21:58AM +0000, Arseniy Krasnov wrote:
> Hello,
>=20
> This patchset includes some updates for SO_RCVLOWAT:
>=20
> 1) af_vsock:
>    During my experiments with zerocopy receive, i found, that in some
>    cases, poll() implementation violates POSIX: when socket has non-
>    default SO_RCVLOWAT(e.g. not 1), poll() will always set POLLIN and
>    POLLRDNORM bits in 'revents' even number of bytes available to read
>    on socket is smaller than SO_RCVLOWAT value. In this case,user sees
>    POLLIN flag and then tries to read data(for example using  'read()'
>    call), but read call will be blocked, because  SO_RCVLOWAT logic is
>    supported in dequeue loop in af_vsock.c. But the same time,  POSIX
>    requires that:
>=20
>    "POLLIN     Data other than high-priority data may be read without
>                blocking.
>     POLLRDNORM Normal data may be read without blocking."
>=20
>    See https://www.open-std.org/jtc1/sc22/open/n4217.pdf, page 293.
>=20
>    So, we have, that poll() syscall returns POLLIN, but read call will
>    be blocked.
>=20
>    Also in man page socket(7) i found that:
>=20
>    "Since Linux 2.6.28, select(2), poll(2), and epoll(7) indicate a
>    socket as readable only if at least SO_RCVLOWAT bytes are available."
>=20
>    I checked TCP callback for poll()(net/ipv4/tcp.c, tcp_poll()), it
>    uses SO_RCVLOWAT value to set POLLIN bit, also i've tested TCP with
>    this case for TCP socket, it works as POSIX required.
>=20
>    I've added some fixes to af_vsock.c and virtio_transport_common.c,
>    test is also implemented.
>=20
> 2) virtio/vsock:
>    It adds some optimization to wake ups, when new data arrived. Now,
>    SO_RCVLOWAT is considered before wake up sleepers who wait new data.
>    There is no sense, to kick waiter, when number of available bytes
>    in socket's queue < SO_RCVLOWAT, because if we wake up reader in
>    this case, it will wait for SO_RCVLOWAT data anyway during dequeue,
>    or in poll() case, POLLIN/POLLRDNORM bits won't be set, so such
>    exit from poll() will be "spurious". This logic is also used in TCP
>    sockets.
>=20
> 3) vmci/vsock:
>    Same as 2), but i'm not sure about this changes. Will be very good,
>    to get comments from someone who knows this code.
>=20
> 4) Hyper-V:
>    As Dexuan Cui mentioned, for Hyper-V transport it is difficult to
>    support SO_RCVLOWAT, so he suggested to disable this feature for
>    Hyper-V.
>=20
> Thank You

Hi Arseniy,
Stefano will be online again on Monday. I suggest we wait for him to
review this series. If it's urgent, please let me know and I'll take a
look.

Thanks,
Stefan

> Arseniy Krasnov(9):
>  vsock: SO_RCVLOWAT transport set callback
>  hv_sock: disable SO_RCVLOWAT support
>  virtio/vsock: use 'target' in notify_poll_in callback
>  vmci/vsock: use 'target' in notify_poll_in callback
>  vsock: pass sock_rcvlowat to notify_poll_in as target
>  vsock: add API call for data ready
>  virtio/vsock: check SO_RCVLOWAT before wake up reader
>  vmci/vsock: check SO_RCVLOWAT before wake up reader
>  vsock_test: POLLIN + SO_RCVLOWAT test
>=20
>  include/net/af_vsock.h                       |   2 +
>  net/vmw_vsock/af_vsock.c                     |  33 +++++++-
>  net/vmw_vsock/hyperv_transport.c             |   7 ++
>  net/vmw_vsock/virtio_transport_common.c      |   7 +-
>  net/vmw_vsock/vmci_transport_notify.c        |  10 +--
>  net/vmw_vsock/vmci_transport_notify_qstate.c |  12 +--
>  tools/testing/vsock/vsock_test.c             | 108 +++++++++++++++++++++=
++++++
>  7 files changed, 162 insertions(+), 17 deletions(-)
>=20
>  Changelog:
>=20
>  v1 -> v2:
>  1) Patches for VMCI transport(same as for virtio-vsock).
>  2) Patches for Hyper-V transport(disabling SO_RCVLOWAT setting).
>  3) Waiting logic in test was updated(sleep() -> poll()).
>=20
>  v2 -> v3:
>  1) Patches were reordered.
>  2) Commit message updated in 0005.
>  3) Check 'transport' pointer in 0001 for NULL.
>=20
>  v3 -> v4:
>  1) vsock_set_rcvlowat() logic changed. Previous version required
>     assigned transport and always called its 'set_rcvlowat' callback
>     (if present). Now, assignment is not needed.
>  2) 0003,0004,0005,0006,0007,0008 - commit messages updated.
>  3) 0009 - small refactoring and style fixes.
>  4) RFC tag was removed.
>=20
> --=20
> 2.25.1

--MY0QU7bnoDA4DEoQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmMFJwIACgkQnKSrs4Gr
c8hfpwgAq+JCoPsR72mnMAiJ64hEeR7VU4PB29fifgVsNdmttit01L8f3u3rwcJg
aOcR8aXEJUbQJAcQxrN9nslgW+L9L6UzDUaKGNzWXK4f3a+CBXFA0zMRnJY6/n0l
vyYbjXb2DqlDhpC/PwjcmQ9QSrcMA35wXqYcIH1AXrk7i1poAM0IzjsTnVr7i8TQ
C8D8wkDEzHrQRLjdBN0zrQsIvbVByhkFYF/QhQJBr/rNJokjX9JdkOb5fmAWuedB
GxktTsPfLFov5AIdgtcBhRD5iNeJyLsNh5YIULcweMdbpV3DWRr1umpPk/yzjcD5
77HdnXIblY58tqlO1bC9+eMpMTVhRw==
=OvOp
-----END PGP SIGNATURE-----

--MY0QU7bnoDA4DEoQ--


--===============8348426708844167758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8348426708844167758==--

