Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F66C433E0
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 10:20:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44BF20780
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 10:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44BF20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E5CF870A9;
	Mon,  4 Jan 2021 10:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EZiITTDUk9Be; Mon,  4 Jan 2021 10:19:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A77128709F;
	Mon,  4 Jan 2021 10:19:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CFC5C0893;
	Mon,  4 Jan 2021 10:19:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE2BC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 10:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EBF63859E6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 10:19:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDmA1gwC2cRv
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 10:19:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 45FD985507
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 10:19:56 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id a6so17943967wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jan 2021 02:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cshuBm7yB0Z3cSiR7jcnuEYzCYnzDpnl22WbZG/ju9A=;
 b=M3Ngc5/MMNzyhU8I5x5YBEM7KEyJ85Y0XLmLQEYrJWsFHN5N8VXe8Z5MPFYwnuMrMi
 Hx/9Mpra2YpHPrZqELXd73hWlIY1XRevN88LOhXt/adUP5lVVlBhj5VnV87P+RePmuu3
 /TxKZ1oCnspXNA+t3jR/wrELwh2BuSY7bWFn2E/79tRNqFoewT5tm7XidnRDq7zPg7Q2
 khd0qeLDq3dGyBhVMs4alfzPYBZOOpeshQQ1oolYQHB4q8SS84uIKrKeG5sjd96cYb9M
 3166FELfa+cTzCd1qV4jEU6jT4zvv7+XkmPr/gbsNiRm2SPSO8V58fKTXkJR8anaqW2Q
 W6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cshuBm7yB0Z3cSiR7jcnuEYzCYnzDpnl22WbZG/ju9A=;
 b=rT+1nkK4NN5rZYm8/JphF5wyR4mROe2b5bLPp2Vl9XYdWEDrTXVSmUeaA5huH0aNRd
 j2jmUe4gJwMDekhNN1dFi4v7iwj75HXhLLlLW/XnhoEh1zIabWVL4YzUhLXnZ4sYFt2o
 jhcbUjsYUwR3ZXVxBZk6vzYRJf+mns1nKzgrdq7PCo+pqPLsxctwtgEiwpuEnGUgZ+52
 /XAndL3+ExB13pMU1xdlpnwZeYxU2tP71RR68Up/NehCWE1qXdw0RcF5Iix4n3ef/7Dd
 jvncbuf+8EAU3L1cOoIjTPqoz8dkmXq676CZqX10LPHb0ePcinjATOW8ifBgcBKXiZNh
 74hg==
X-Gm-Message-State: AOAM531ofKsIQ5h04RVqKe4IMwl0iTd/g2uSR5RZhNbUFyOWSeEeZbMb
 6PyQRrUsVWbVEXjNn6D/abw=
X-Google-Smtp-Source: ABdhPJwOuLImjmAuXi0UyWjGYMZg6gZNFDNyltiw/uCmka2l2gwaY0RUZ3EWHJG5F8u9t7/5Zt9cRw==
X-Received: by 2002:a1c:e246:: with SMTP id z67mr26166545wmg.166.1609755594674; 
 Mon, 04 Jan 2021 02:19:54 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b9sm35686661wmd.32.2021.01.04.02.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jan 2021 02:19:53 -0800 (PST)
Date: Mon, 4 Jan 2021 10:19:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2] vhost/vsock: add IOTLB API support
Message-ID: <20210104101952.GA344891@stefanha-x1.localdomain>
References: <20201223143638.123417-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201223143638.123417-1-sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============6634530218064821065=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6634530218064821065==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2020 at 03:36:38PM +0100, Stefano Garzarella wrote:
> This patch enables the IOTLB API support for vhost-vsock devices,
> allowing the userspace to emulate an IOMMU for the guest.
>=20
> These changes were made following vhost-net, in details this patch:
> - exposes VIRTIO_F_ACCESS_PLATFORM feature and inits the iotlb
>   device if the feature is acked
> - implements VHOST_GET_BACKEND_FEATURES and
>   VHOST_SET_BACKEND_FEATURES ioctls
> - calls vq_meta_prefetch() before vq processing to prefetch vq
>   metadata address in IOTLB
> - provides .read_iter, .write_iter, and .poll callbacks for the
>   chardev; they are used by the userspace to exchange IOTLB messages
>=20
> This patch was tested specifying "intel_iommu=3Dstrict" in the guest
> kernel command line. I used QEMU with a patch applied [1] to fix a
> simple issue (that patch was merged in QEMU v5.2.0):
>     $ qemu -M q35,accel=3Dkvm,kernel-irqchip=3Dsplit \
>            -drive file=3Dfedora.qcow2,format=3Dqcow2,if=3Dvirtio \
>            -device intel-iommu,intremap=3Don,device-iotlb=3Don \
>            -device vhost-vsock-pci,guest-cid=3D3,iommu_platform=3Don,ats=
=3Don
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg09077.html
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>=20
> The patch is the same of v1, but I re-tested it with:
> - QEMU v5.2.0-551-ga05f8ecd88
> - Linux 5.9.15 (host)
> - Linux 5.9.15 and 5.10.0 (guest)
> Now, enabling 'ats' it works well, there are just a few simple changes.
>=20
> v1: https://www.spinics.net/lists/kernel/msg3716022.html
> v2:
> - updated commit message about QEMU version and string used to test
> - rebased on mst/vhost branch
>=20
> Thanks,
> Stefano
> ---
>  drivers/vhost/vsock.c | 68 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 3 deletions(-)

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl/y68gACgkQnKSrs4Gr
c8jFlggAxynl8f/xErtZe/4q3P7uG8fRfOuje/XSlmzcxtlgQOv+t7r/vKjWzGwb
ZJ52k6PN1dlbuQHyBf1TDre9nNqW17YteqL+em0hfvynsHV6WREOpJPLnVcbOWkF
/vMadG9PxDkagfVN7ZOEzeLewJM4ZxAjYaZe9ADM2aq6MoxhiC4oCICmOK2UBbu3
t/bVIhCL/cZs0nMO5cGfpz8u0ZenAiVPsXmbEiynMhhFd1pNWu1XsB6BGqJgZ4oJ
1BvYrA3RWKmvq/EK15JIKzHJrNuP5mh0bGrWKXOj4ubUTRYnjVMWfwtfDpjKUlGB
W77zh8Sm5xfKTDndtPmChInD+yd2iQ==
=9iMg
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

--===============6634530218064821065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6634530218064821065==--
