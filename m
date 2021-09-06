Return-Path: <SRS0=ZzT7=N4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C148CC433EF
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 15:10:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5461060F6E
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 15:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5461060F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 153A8403AE;
	Mon,  6 Sep 2021 15:10:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vf20e3ksUIBM; Mon,  6 Sep 2021 15:09:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 94195402FA;
	Mon,  6 Sep 2021 15:09:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B83EC001D;
	Mon,  6 Sep 2021 15:09:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52F82C001B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 15:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 417104015C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 15:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YDa_Gz7SBXug
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 15:09:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDEF940109
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630940993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LtzKtGWwneehAKg1xWNa623mlHCBRfhPPDg8mcw7gGc=;
 b=Vx641pYmlMsSHDUnzpXFiK4EHl8t8V1UN9V5M8G/uoTIPWKJPbOXiSGdeoDaWFFJi5IBTz
 R4Gog/8cAuXip4+7ipZofE0ZAKzsVC6TNanuswSfgFTY9BtZSysjlNiFd5sX1dgdnlLfUW
 E4TByBs3Chq+5GnRN1oDGLiTWXNZaBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-6mgB8yRaOjSX0P74duZTvw-1; Mon, 06 Sep 2021 11:09:52 -0400
X-MC-Unique: 6mgB8yRaOjSX0P74duZTvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0DB0107ACCA;
 Mon,  6 Sep 2021 15:09:50 +0000 (UTC)
Received: from localhost (unknown [10.39.194.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB8CE60861;
 Mon,  6 Sep 2021 15:09:46 +0000 (UTC)
Date: Mon, 6 Sep 2021 16:09:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: avoid preallocating big SGL for data
Message-ID: <YTYvOetMHvocg9UZ@stefanha-x1.localdomain>
References: <20210901131434.31158-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210901131434.31158-1-mgurtovoy@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 mst@redhat.com, israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, oren@nvidia.com
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
Content-Type: multipart/mixed; boundary="===============4504278321138237196=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4504278321138237196==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="csgk6nvMjmlrDHYP"
Content-Disposition: inline


--csgk6nvMjmlrDHYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 01, 2021 at 04:14:34PM +0300, Max Gurtovoy wrote:
> No need to pre-allocate a big buffer for the IO SGL anymore. If a device
> has lots of deep queues, preallocation for the sg list can consume
> substantial amounts of memory. For HW virtio-blk device, nr_hw_queues
> can be 64 or 128 and each queue's depth might be 128. This means the
> resulting preallocation for the data SGLs is big.
>=20
> Switch to runtime allocation for SGL for lists longer than 2 entries.
> This is the approach used by NVMe drivers so it should be reasonable for
> virtio block as well. Runtime SGL allocation has always been the case
> for the legacy I/O path so this is nothing new.
>=20
> The preallocated small SGL depends on SG_CHAIN so if the ARCH doesn't
> support SG_CHAIN, use only runtime allocation for the SGL.
>=20
> Re-organize the setup of the IO request to fit the new sg chain
> mechanism.
>=20
> No performance degradation was seen (fio libaio engine with 16 jobs and
> 128 iodepth):
>=20
> IO size      IOPs Rand Read (before/after)         IOPs Rand Write (befor=
e/after)
> --------     ---------------------------------    -----------------------=
-----------
> 512B          318K/316K                                    329K/325K
>=20
> 4KB           323K/321K                                    353K/349K
>=20
> 16KB          199K/208K                                    250K/275K
>=20
> 128KB         36K/36.1K                                    39.2K/41.7K

I ran fio randread benchmarks with 4k, 16k, 64k, and 128k at iodepth 1,
8, and 64 on two vCPUs. The results look fine, there is no significant
regression.

iodepth=3D1 and iodepth=3D64 are very consistent. For some reason the
iodepth=3D8 has significant variance but I don't think it's the fault of
this patch.

Fio results and the Jupyter notebook export are available here (check
out benchmark.html to see the graphs):

https://gitlab.com/stefanha/virt-playbooks/-/tree/virtio-blk-sgl-allocation=
-benchmark/notebook

Guest:
- Fedora 34
- Linux v5.14
- 2 vCPUs (pinned), 4 GB RAM (single host NUMA node)
- 1 IOThread (pinned)
- virtio-blk aio=3Dnative,cache=3Dnone,format=3Draw
- QEMU 6.1.0

Host:
- RHEL 8.3
- Linux 4.18.0-240.22.1.el8_3.x86_64
- Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz
- Intel Optane DC P4800X

Stefan

--csgk6nvMjmlrDHYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmE2LzkACgkQnKSrs4Gr
c8h0BwgAnbP4VYJvt1ymf6H3ou32GEjNCtPjI7bpZsFivdUH3cKc8D40PTEQpNdH
2IN5O1F+JbNjqckTcJO5RtUZujOiGC3wgb5SQC9rZ6Tvle5z9Hkm/wQLcEKGPKxC
bM6p2ZRqItdlIbmNzPxclcFfq9Xd9mSlhKIysn0qcc11fRPgK2PKyKk5TZDsm5fu
BoIp38N9hPv9s2MdwXqxESc0RAQPOXSDxM/oj+Kf1ExFWqYCMlvvvpKodQNox4V7
wxO6Tri40eHD2naacYZZkgTErx2ZTWgbTKuOnUh/0h9+Q6SP+JELQ1BJ3aOp0y8b
L6ksEBt6PDlMsUM3pgtGapKP0Q+5Dw==
=yo6I
-----END PGP SIGNATURE-----

--csgk6nvMjmlrDHYP--


--===============4504278321138237196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4504278321138237196==--

