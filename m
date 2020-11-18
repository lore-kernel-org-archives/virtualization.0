Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D116C63697
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 11:31:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A622080A
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 11:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVRL7vms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A622080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40C3887036;
	Wed, 18 Nov 2020 11:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tZSOlJAQ93Ai; Wed, 18 Nov 2020 11:31:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 86B0C87032;
	Wed, 18 Nov 2020 11:31:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7E1C0891;
	Wed, 18 Nov 2020 11:31:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22DA7C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A5B5B2034C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A4oDyor2JhCH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:31:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id F18792033E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605699093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4klu/6VLPeehKC0MRm/Zpkk011aelEzsRD3uMBe14/8=;
 b=TVRL7vmsyqEFvGqJvtqjnE35GFo5RqCLFxVCQDTctkeLkTHv107gB3PlvzPEYpKKZzGrgi
 A6PUo5juIkk9XYoyH86PZ4ASvu8JlsPhFCJPUuCz/VoQevVAItweHYAcN7CEyT16yy137+
 KYf7pQohWFDWdc0rFG8eIP1CtMj3Ah8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-S28dO65_M5iUYAS-Hqtjyw-1; Wed, 18 Nov 2020 06:31:30 -0500
X-MC-Unique: S28dO65_M5iUYAS-Hqtjyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FFFF107B293;
 Wed, 18 Nov 2020 11:31:28 +0000 (UTC)
Received: from localhost (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDEE560C43;
 Wed, 18 Nov 2020 11:31:18 +0000 (UTC)
Date: Wed, 18 Nov 2020 11:31:17 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 00/10] vhost/qemu: thread per IO SCSI vq
Message-ID: <20201118113117.GF182763@stefanha-x1.localdomain>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <20201117164043.GS131917@stefanha-x1.localdomain>
 <b3343762-bb11-b750-46ec-43b5556f2b8e@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b3343762-bb11-b750-46ec-43b5556f2b8e@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Content-Type: multipart/mixed; boundary="===============1631459781919418265=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============1631459781919418265==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DEueqSqTbz/jWVG1"
Content-Disposition: inline

--DEueqSqTbz/jWVG1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2020 at 01:13:14PM -0600, Mike Christie wrote:
> On 11/17/20 10:40 AM, Stefan Hajnoczi wrote:
> > On Thu, Nov 12, 2020 at 05:18:59PM -0600, Mike Christie wrote:
> >> The following kernel patches were made over Michael's vhost branch:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=
=3Dvhost
> >>
> >> and the vhost-scsi bug fix patchset:
> >>
> >> https://lore.kernel.org/linux-scsi/20201112170008.GB1555653@stefanha-x=
1.localdomain/T/#t
> >>
> >> And the qemu patch was made over the qemu master branch.
> >>
> >> vhost-scsi currently supports multiple queues with the num_queues
> >> setting, but we end up with a setup where the guest's scsi/block
> >> layer can do a queue per vCPU and the layers below vhost can do
> >> a queue per CPU. vhost-scsi will then do a num_queue virtqueues,
> >> but all IO gets set on and completed on a single vhost-scsi thread.
> >> After 2 - 4 vqs this becomes a bottleneck.
> >>
> >> This patchset allows us to create a worker thread per IO vq, so we
> >> can better utilize multiple CPUs with the multiple queues. It
> >> implments Jason's suggestion to create the initial worker like
> >> normal, then create the extra workers for IO vqs with the
> >> VHOST_SET_VRING_ENABLE ioctl command added in this patchset.
> >=20
> > How does userspace find out the tids and set their CPU affinity?
> >=20
>=20
> When we create the worker thread we add it to the device owner's cgroup,
> so we end up inheriting those settings like affinity.
>=20
> However, are you more asking about finer control like if the guest is
> doing mq, and the mq hw queue is bound to cpu0, it would perform
> better if we could bind vhost vq's worker thread to cpu0? I think the
> problem might is if you are in the cgroup then we can't set a specific
> threads CPU affinity to just one specific CPU. So you can either do
> cgroups or not.
>=20
>=20
> > What is the meaning of the new VHOST_SET_VRING_ENABLE ioctl? It doesn't
> > really "enable" or "disable" the vq, requests are processed regardless.
> >=20
>=20
> Yeah, I agree. The problem I've mentioned before is:
>=20
> 1. For net and vsock, it's not useful because the vqs are hard coded in
> the kernel and userspace, so you can't disable a vq and you never need
> to enable one.
>=20
> 2. vdpa has it's own enable ioctl.
>=20
> 3. For scsi, because we already are doing multiple vqs based on the
> num_queues value, we have to have some sort of compat support and
> code to detect if userspace is even going to send the new ioctl.
> In this patchset, compat just meant enable/disable the extra functionalit=
y
> of extra worker threads for a vq. We will still use the vq if
> userspace set it up.
>=20
>=20
> > The purpose of the ioctl isn't clear to me because the kernel could
> > automatically create 1 thread per vq without a new ioctl. On the other
> > hand, if userspace is supposed to control worker threads then a
> > different interface would be more powerful:
> >=20

The main request I have is to clearly define the meaning of the
VHOST_SET_VRING_ENABLE ioctl. If you want to keep it as-is for now and
the vhost maintainers are happy with then, that's okay. It should just
be documented so that userspace and other vhost driver authors
understand what it's supposed to do.

> My preference has been:
>=20
> 1. If we were to ditch cgroups, then add a new interface that would allow
> us to bind threads to a specific CPU, so that it lines up with the guest'=
s
> mq to CPU mapping.

A 1:1 vCPU/vq->CPU mapping isn't desirable in all cases.

The CPU affinity is a userspace policy decision. The host kernel should
provide a mechanism but not the policy. That way userspace can decide
which workers are shared by multiple vqs and on which physical CPUs they
should run.

Stefan

--DEueqSqTbz/jWVG1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+1BgUACgkQnKSrs4Gr
c8gQ8gf/W0FT+4mtlnBc1yI9COd4MhYzjWL16Evq9DEgWquUzme1kaqRI7BlJytk
WTMMYhgdHP6+ema9RCf4p53nO5wG+mordaLuyYBiXt0KmhZjZll+rbi/X+FkazQ/
PBTy38MCHBUY0aqtbtLSvEUSWmzDmPsNPGN+QdXbDmYL41n9J8nXlFwhFF+oKAtZ
GnSwDNaMssjd9pQetIQ8voNXguTkfpifUYYpSRZ5nKtrtzT3eQxFUA8Xe6GXE1Rd
1Nx4SjBo7EiQQ4WI83cjGIP8gjX2TQ21dlybNRal1sd++To0lpRy1j1qlm875DVg
WR0YSP5J+YGIAdY/BRQ2w2SY9SBoLg==
=/BhM
-----END PGP SIGNATURE-----

--DEueqSqTbz/jWVG1--


--===============1631459781919418265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1631459781919418265==--

