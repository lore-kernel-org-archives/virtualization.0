Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5040C47096
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 15:30:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7689D613EE
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 15:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7689D613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E5ED607F9;
	Thu,  3 Jun 2021 15:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyQFjZhWCn6I; Thu,  3 Jun 2021 15:30:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5AD66068B;
	Thu,  3 Jun 2021 15:30:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C73F3C000E;
	Thu,  3 Jun 2021 15:30:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A07B0C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 793BF606B3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fUiuB3psDkWn
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:30:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C886D6068B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622734239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/S1XKe/GM4qQZl4GJJ8xfCrJIwaECIza2brwo279Qw4=;
 b=M/mKjZRoYATaNBkHiGXBgk6uANfBUm7n8oN7S5nUJby/4ZaTCsGhRda8LVv0jgYWMeNhkg
 OHwja5lw6Y2xcWYw9uFiE0kZ4mVWbMoN7Y5lJDt7IQMM8BJegn3zSpmvnl+Zf56mdsKaCy
 IiOrxp7BFmot9jMPFRdMvdwB5pIZNTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-KdW-98JTOBmvLj354ZUpbg-1; Thu, 03 Jun 2021 11:30:36 -0400
X-MC-Unique: KdW-98JTOBmvLj354ZUpbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96FD780EDB3;
 Thu,  3 Jun 2021 15:30:34 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE1CE10016FC;
 Thu,  3 Jun 2021 15:30:26 +0000 (UTC)
Date: Thu, 3 Jun 2021 16:30:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] virtio_blk: blk-mq io_poll support
Message-ID: <YLj1kUiTTlLm5HwU@stefanha-x1.localdomain>
References: <20210520141305.355961-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210520141305.355961-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
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
Content-Type: multipart/mixed; boundary="===============2773966893972661487=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============2773966893972661487==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B/OddBweazIqrPeI"
Content-Disposition: inline


--B/OddBweazIqrPeI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 03:13:02PM +0100, Stefan Hajnoczi wrote:
> This patch series implements blk_mq_ops->poll() so REQ_HIPRI requests can=
 be
> polled. IOPS for 4k and 16k block sizes increases by 5-18% on a virtio-blk
> device with 4 virtqueues backed by an NVMe drive.
>=20
> - Benchmark: fio ioengine=3Dpvsync2 numjobs=3D4 direct=3D1
> - Guest: 4 vCPUs with one virtio-blk device (4 virtqueues)
> - Disk: Intel Corporation NVMe Datacenter SSD [Optane] [8086:2701]
> - CPU: Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz
>=20
> rw          bs hipri=3D0 hipri=3D1
> ------------------------------
> randread    4k 149,426 170,763 +14%
> randread   16k 118,939 134,269 +12%
> randread   64k  34,886  34,906   0%
> randread  128k  17,655  17,667   0%
> randwrite   4k 138,578 163,600 +18%
> randwrite  16k 102,089 120,950 +18%
> randwrite  64k  32,364  32,561   0%
> randwrite 128k  16,154  16,237   0%
> read        4k 146,032 170,620 +16%
> read       16k 117,097 130,437 +11%
> read       64k  34,834  35,037   0%
> read      128k  17,680  17,658   0%
> write       4k 134,562 151,422 +12%
> write      16k 101,796 107,606  +5%
> write      64k  32,364  32,594   0%
> write     128k  16,259  16,265   0%
>=20
> Larger block sizes do not benefit from polling as much but the
> improvement is worthwhile for smaller block sizes.
>=20
> Stefan Hajnoczi (3):
>   virtio: add virtioqueue_more_used()
>   virtio_blk: avoid repeating vblk->vqs[qid]
>   virtio_blk: implement blk_mq_ops->poll()
>=20
>  include/linux/virtio.h       |   2 +
>  drivers/block/virtio_blk.c   | 126 +++++++++++++++++++++++++++++------
>  drivers/virtio/virtio_ring.c |  17 +++++
>  3 files changed, 123 insertions(+), 22 deletions(-)

Christoph and Jens: Any more thoughts on this irq toggling approach?

Stefan

--B/OddBweazIqrPeI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC49ZEACgkQnKSrs4Gr
c8j34Af+OlGHrPFOu/uCty4kQUK2eoLVfirmODk3dZSTw9dI349E+luWFSE+dOyn
UJL1cKCs3Cw8jgwiUkzjt/lSMlpmjvQiqGmJCxfC+0Z+mkinpthhhK5G7DlSFTQl
BoQ+h64/9rU7rXXP4jJarxNV/LAu2jXPBL2pypG8UfGSB6wPFdcd/01ftiKLbkZE
ja044LxlD84TUn3sgtGRtH5MupRE7k/izZMYmyBlWLE/vH4DySVhvA6kwGWeAD82
dClnQ/TiFkvkf7GM4CvdX+PZ2f+sGpa4dPJ7LUJOz6RxpdUo+fW7loKm1zu5IyO9
/qF7ys9OUNREOxR9hiWtpcE+2V/HBA==
=/ihk
-----END PGP SIGNATURE-----

--B/OddBweazIqrPeI--


--===============2773966893972661487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2773966893972661487==--

