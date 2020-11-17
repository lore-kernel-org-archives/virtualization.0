Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84025C5519F
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 16:40:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B4E217A0
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 16:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdLNpNQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B4E217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 41F6A8700B;
	Tue, 17 Nov 2020 16:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1kUDDsc2msz; Tue, 17 Nov 2020 16:40:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A96A587011;
	Tue, 17 Nov 2020 16:40:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DB5CC0891;
	Tue, 17 Nov 2020 16:40:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6301CC07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5010D87011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DIITrudpHwO7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:40:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 963B68700B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 16:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605631253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PrtrctB9G5pEBnZheqS7Drb5ElIcN9MmGROgGZcsg40=;
 b=NdLNpNQ9gfUKEYJzQS1epA20e9JF7J4BQGBjrMCvtbORHQux8SKxoNwatP0WUoYmg/7nvd
 usVUEajWpxRxMBt9aLfi1CahNFkM4obZYEmMLyQhy93hr1oymLvqEYiVrk5DikhQqETv0o
 LCndprbQsCehPlDop0gompKHr6Uvgvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-QV2m57Y7MBm9bV8zp4uIdg-1; Tue, 17 Nov 2020 11:40:48 -0500
X-MC-Unique: QV2m57Y7MBm9bV8zp4uIdg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91A2A80364C;
 Tue, 17 Nov 2020 16:40:47 +0000 (UTC)
Received: from localhost (ovpn-115-113.ams2.redhat.com [10.36.115.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B1A35D9CC;
 Tue, 17 Nov 2020 16:40:43 +0000 (UTC)
Date: Tue, 17 Nov 2020 16:40:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 00/10] vhost/qemu: thread per IO SCSI vq
Message-ID: <20201117164043.GS131917@stefanha-x1.localdomain>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: fam@euphon.net, linux-scsi@vger.kernel.org, mst@redhat.com,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============4374777133597383951=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4374777133597383951==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fqIB0bRxfTYxTb/F"
Content-Disposition: inline

--fqIB0bRxfTYxTb/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 05:18:59PM -0600, Mike Christie wrote:
> The following kernel patches were made over Michael's vhost branch:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=3Dvh=
ost
>=20
> and the vhost-scsi bug fix patchset:
>=20
> https://lore.kernel.org/linux-scsi/20201112170008.GB1555653@stefanha-x1.l=
ocaldomain/T/#t
>=20
> And the qemu patch was made over the qemu master branch.
>=20
> vhost-scsi currently supports multiple queues with the num_queues
> setting, but we end up with a setup where the guest's scsi/block
> layer can do a queue per vCPU and the layers below vhost can do
> a queue per CPU. vhost-scsi will then do a num_queue virtqueues,
> but all IO gets set on and completed on a single vhost-scsi thread.
> After 2 - 4 vqs this becomes a bottleneck.
>=20
> This patchset allows us to create a worker thread per IO vq, so we
> can better utilize multiple CPUs with the multiple queues. It
> implments Jason's suggestion to create the initial worker like
> normal, then create the extra workers for IO vqs with the
> VHOST_SET_VRING_ENABLE ioctl command added in this patchset.

How does userspace find out the tids and set their CPU affinity?

What is the meaning of the new VHOST_SET_VRING_ENABLE ioctl? It doesn't
really "enable" or "disable" the vq, requests are processed regardless.

The purpose of the ioctl isn't clear to me because the kernel could
automatically create 1 thread per vq without a new ioctl. On the other
hand, if userspace is supposed to control worker threads then a
different interface would be more powerful:

  struct vhost_vq_worker_info {
      /*
       * The pid of an existing vhost worker that this vq will be
       * assigned to. When pid is 0 the virtqueue is assigned to the
       * default vhost worker. When pid is -1 a new worker thread is
       * created for this virtqueue. When pid is -2 the virtqueue's
       * worker thread is unchanged.
       *
       * If a vhost worker no longer has any virtqueues assigned to it
       * then it will terminate.
       *
       * The pid of the vhost worker is stored to this field when the
       * ioctl completes successfully. Use pid -2 to query the current
       * vhost worker pid.
       */
      __kernel_pid_t pid;  /* in/out */

      /* The virtqueue index*/
      unsigned int vq_idx; /* in */
  };

  ioctl(vhost_fd, VHOST_SET_VQ_WORKER, &info);

Stefan

--fqIB0bRxfTYxTb/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+z/QoACgkQnKSrs4Gr
c8hlxAgAt5dzFMEBdSdRp7hlgZgQqjlbY0sBm70KpODN/xBzs8Q2v0wdnoQb31pX
hxrxuWMrrEyu0RPvaCbTZNhTnyU58Eo12Ydeh4DQ+nlJYrk6c91aXU1ii6PvxQDd
xJNaxUljcMW36zNpL1Qy7BISbEkh2kRCyPmV9OmDhlmGDJfZg0kGlRorga+q9HrJ
mI/kS2ajFdXy/9ovk38seIcHJRxpWawgN/ORuV5YX8D/y/O7Gb5Cc+l0Ai6Pe5At
pYjhIw428VQjyQg/L9zGM8oF+llegHH2V7MUfvqFOFRN45JR6bblohEt7x3TrS2j
U3ufXEGBhhwEEII1h6f2QaC6YUeyuQ==
=uA/X
-----END PGP SIGNATURE-----

--fqIB0bRxfTYxTb/F--


--===============4374777133597383951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4374777133597383951==--

