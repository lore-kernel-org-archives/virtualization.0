Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A71C433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 12:23:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D8D60F26
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 12:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87D8D60F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 43301400E4;
	Tue, 14 Sep 2021 12:23:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KK14QmptdUfm; Tue, 14 Sep 2021 12:23:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 77347400DE;
	Tue, 14 Sep 2021 12:22:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56EEFC000F;
	Tue, 14 Sep 2021 12:22:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B28CC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 12:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54DF9400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 12:22:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wIGVMbc8fQyf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 12:22:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 226A6400DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631622175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=crCMDIQfbcqlNNuWe8wMVzG0binTQZ+93JYNDaWlRUQ=;
 b=KH7Vml8bFo6kt7Fr8VHfkZMT8ehjI7s00CCICT65AWHCULNgEc1j3pojlmz4t9aCFA2muQ
 HK2NWuoAj4d0LUK/MAdsX+NSr1+o7m5yWNLWMH39699fSXd8jw69/7fMuh8qaJWlmJX5cx
 /E1oMFhSYytOHjeQrBompDyyg699QgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-A_E-DCZaMKK9c-ke32RRYw-1; Tue, 14 Sep 2021 08:22:54 -0400
X-MC-Unique: A_E-DCZaMKK9c-ke32RRYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ED355074C;
 Tue, 14 Sep 2021 12:22:53 +0000 (UTC)
Received: from localhost (unknown [10.39.192.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA1F60C7F;
 Tue, 14 Sep 2021 12:22:48 +0000 (UTC)
Date: Tue, 14 Sep 2021 13:22:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: avoid preallocating big SGL for data
Message-ID: <YUCUF7co94CRGkGU@stefanha-x1.localdomain>
References: <20210901131434.31158-1-mgurtovoy@nvidia.com>
 <YTYvOetMHvocg9UZ@stefanha-x1.localdomain>
 <692f8e81-8585-1d39-e7a4-576ae01438a1@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <692f8e81-8585-1d39-e7a4-576ae01438a1@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Content-Type: multipart/mixed; boundary="===============0642381637274856732=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============0642381637274856732==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aGmDvTLAe56x7DHM"
Content-Disposition: inline


--aGmDvTLAe56x7DHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 05:50:21PM +0300, Max Gurtovoy wrote:
>=20
> On 9/6/2021 6:09 PM, Stefan Hajnoczi wrote:
> > On Wed, Sep 01, 2021 at 04:14:34PM +0300, Max Gurtovoy wrote:
> > > No need to pre-allocate a big buffer for the IO SGL anymore. If a dev=
ice
> > > has lots of deep queues, preallocation for the sg list can consume
> > > substantial amounts of memory. For HW virtio-blk device, nr_hw_queues
> > > can be 64 or 128 and each queue's depth might be 128. This means the
> > > resulting preallocation for the data SGLs is big.
> > >=20
> > > Switch to runtime allocation for SGL for lists longer than 2 entries.
> > > This is the approach used by NVMe drivers so it should be reasonable =
for
> > > virtio block as well. Runtime SGL allocation has always been the case
> > > for the legacy I/O path so this is nothing new.
> > >=20
> > > The preallocated small SGL depends on SG_CHAIN so if the ARCH doesn't
> > > support SG_CHAIN, use only runtime allocation for the SGL.
> > >=20
> > > Re-organize the setup of the IO request to fit the new sg chain
> > > mechanism.
> > >=20
> > > No performance degradation was seen (fio libaio engine with 16 jobs a=
nd
> > > 128 iodepth):
> > >=20
> > > IO size      IOPs Rand Read (before/after)         IOPs Rand Write (b=
efore/after)
> > > --------     ---------------------------------    -------------------=
---------------
> > > 512B          318K/316K                                    329K/325K
> > >=20
> > > 4KB           323K/321K                                    353K/349K
> > >=20
> > > 16KB          199K/208K                                    250K/275K
> > >=20
> > > 128KB         36K/36.1K                                    39.2K/41.7K
> > I ran fio randread benchmarks with 4k, 16k, 64k, and 128k at iodepth 1,
> > 8, and 64 on two vCPUs. The results look fine, there is no significant
> > regression.
> >=20
> > iodepth=3D1 and iodepth=3D64 are very consistent. For some reason the
> > iodepth=3D8 has significant variance but I don't think it's the fault of
> > this patch.
> >=20
> > Fio results and the Jupyter notebook export are available here (check
> > out benchmark.html to see the graphs):
> >=20
> > https://gitlab.com/stefanha/virt-playbooks/-/tree/virtio-blk-sgl-alloca=
tion-benchmark/notebook
> >=20
> > Guest:
> > - Fedora 34
> > - Linux v5.14
> > - 2 vCPUs (pinned), 4 GB RAM (single host NUMA node)
> > - 1 IOThread (pinned)
> > - virtio-blk aio=3Dnative,cache=3Dnone,format=3Draw
> > - QEMU 6.1.0
> >=20
> > Host:
> > - RHEL 8.3
> > - Linux 4.18.0-240.22.1.el8_3.x86_64
> > - Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz
> > - Intel Optane DC P4800X
> >=20
> > Stefan
>=20
> Thanks, Stefan.
>=20
> Would you like me to add some of the results in my commit msg ? or Tested=
-By
> sign ?

Thanks, there's no need to change the commit description.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Stefan Hajnoczi <stefanha@redhat.com>

--aGmDvTLAe56x7DHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFAlBcACgkQnKSrs4Gr
c8irGwgAifRcb8J6P8Ki4ql4+nWOw59zpPqBsh8+wmslHwj+5Sj5x040BOGESY6V
peZCMYgqgdWV7Ckgyd/4Er+L85wo41zn7+ylsi/NqkRVnZBg7HgRTiLL7GbBX8Zz
eLYIqr4aFpRE93y/RAFbnPTU4cEGK8GnhdbLgODHrnmg+VQ8DT9Lb0Ov/1UqcB5i
+EWw4mLhlDAHOcuz0YQpiGTbKe9kvTnwTjZh+DmMi4FjH6xnyEYCq4JfFmkVLC3Q
H7TgCz5EQ5QzXDVsMR7HmYPcU0s0Fofq1dlexF2Fx7riubX7oIn6+UZnSh+XxLlL
2lswIFATfoBLB4VfjgimVUD51zOt2w==
=QoZd
-----END PGP SIGNATURE-----

--aGmDvTLAe56x7DHM--


--===============0642381637274856732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0642381637274856732==--

