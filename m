Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94578C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 14:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D06A461122;
	Wed, 22 Feb 2023 14:32:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D06A461122
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g6wfbpWQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsBrC4bpUR9F; Wed, 22 Feb 2023 14:32:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1DCC461127;
	Wed, 22 Feb 2023 14:32:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DCC461127
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E02A0C0033;
	Wed, 22 Feb 2023 14:32:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBE74C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 14:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A97541039
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 14:32:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A97541039
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g6wfbpWQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5QWycbmh9fzI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 14:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 735DD41032
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 735DD41032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677076343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8OKQj3t8S0pTtjXIJ5z6E2Ald/inmSLj8Dmaw0CJESo=;
 b=g6wfbpWQ3aulEkOYn+BcOLeOId02HOVBk0bfkt0AiWuUjgPeVV4LAqeC39LXoN9y/aO5WM
 bckFFaUB0295iEhmpXirdYn/XtKYjX4FYhN9s/knGiqIUryFgfT7JrJYQf/ldELkt+ss+c
 pBb2ZBj48fNnriiwdUGKBV1NHcwxsUU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-FWfEdfHaMT-Zj8N-gEZCNg-1; Wed, 22 Feb 2023 09:32:22 -0500
X-MC-Unique: FWfEdfHaMT-Zj8N-gEZCNg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC18B181E3F5;
 Wed, 22 Feb 2023 14:32:20 +0000 (UTC)
Received: from localhost (unknown [10.39.195.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DC48492B05;
 Wed, 22 Feb 2023 14:32:18 +0000 (UTC)
Date: Wed, 22 Feb 2023 09:32:16 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Subject: Re: virtio-fs: adding support for multi-queue
Message-ID: <Y/YncAV/7H+vzNCy@fedora>
References: <2fd99bc2-0414-0b85-2bff-3a84ae6c23bd@gootzen.net>
 <Y+KqY3Nse0pVhd3X@fedora> <Y+KsVhIR9aEoSdRu@redhat.com>
 <Y+LDUmWyXCdPIriB@fedora> <Y+LJMwo/K2CHdaPc@redhat.com>
 <9babf0e8-19c3-bb1b-39f8-c755fdc57c8d@gootzen.net>
 <Y+N8x5kIe3pAaeUj@fedora>
 <82ddafee-7548-e7bd-2f41-24ce9251aa25@gootzen.net>
MIME-Version: 1.0
In-Reply-To: <82ddafee-7548-e7bd-2f41-24ce9251aa25@gootzen.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: German Maglione <gmaglione@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Jonas Pfefferle <JPF@zurich.ibm.com>, Vivek Goyal <vgoyal@redhat.com>,
 miklos@szeredi.hu
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
Content-Type: multipart/mixed; boundary="===============4572256673956295480=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============4572256673956295480==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5plz32DEjUIEOTyp"
Content-Disposition: inline


--5plz32DEjUIEOTyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 05:29:25PM +0100, Peter-Jan Gootzen wrote:
> On 08/02/2023 11:43, Stefan Hajnoczi wrote:
> > On Wed, Feb 08, 2023 at 09:33:33AM +0100, Peter-Jan Gootzen wrote:
> > >=20
> > >=20
> > > On 07/02/2023 22:57, Vivek Goyal wrote:
> > > > On Tue, Feb 07, 2023 at 04:32:02PM -0500, Stefan Hajnoczi wrote:
> > > > > On Tue, Feb 07, 2023 at 02:53:58PM -0500, Vivek Goyal wrote:
> > > > > > On Tue, Feb 07, 2023 at 02:45:39PM -0500, Stefan Hajnoczi wrote:
> > > > > > > On Tue, Feb 07, 2023 at 11:14:46AM +0100, Peter-Jan Gootzen w=
rote:
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > >=20
> > > > > > [cc German]
> > > > > >=20
> > > > > > > > For my MSc thesis project in collaboration with IBM
> > > > > > > > (https://github.com/IBM/dpu-virtio-fs) we are looking to im=
prove the
> > > > > > > > performance of the virtio-fs driver in high throughput scen=
arios. We think
> > > > > > > > the main bottleneck is the fact that the virtio-fs driver d=
oes not support
> > > > > > > > multi-queue (while the spec does). A big factor in this is =
that our setup on
> > > > > > > > the virtio-fs device-side (a DPU) does not easily allow mul=
tiple cores to
> > > > > > > > tend to a single virtio queue.
> > > > > >=20
> > > > > > This is an interesting limitation in DPU.
> > > > >=20
> > > > > Virtqueues are single-consumer queues anyway. Sharing them between
> > > > > multiple threads would be expensive. I think using multiqueue is =
natural
> > > > > and not specific to DPUs.
> > > >=20
> > > > Can we create multiple threads (a thread pool) on DPU and let these
> > > > threads process requests in parallel (While there is only one virt
> > > > queue).
> > > >=20
> > > > So this is what we had done in virtiofsd. One thread is dedicated to
> > > > pull the requests from virt queue and then pass the request to thre=
ad
> > > > pool to process it. And that seems to help with performance in
> > > > certain cases.
> > > >=20
> > > > Is that possible on DPU? That itself can give a nice performance
> > > > boost for certain workloads without having to implement multiqueue
> > > > actually.
> > > >=20
> > > > Just curious. I am not opposed to the idea of multiqueue. I am
> > > > just curious about the kind of performance gain (if any) it can
> > > > provide. And will this be helpful for rust virtiofsd running on
> > > > host as well?
> > > >=20
> > > > Thanks
> > > > Vivek
> > > >=20
> > > There is technically nothing preventing us from consuming a single qu=
eue on
> > > multiple cores, however our current Virtio implementation (DPU-side) =
is set
> > > up with the assumption that you should never want to do that (concurr=
ency
> > > mayham around the Virtqueues and the DMAs). So instead of putting all=
 the
> > > work into reworking the implementation to support that and still incu=
r the
> > > big overhead, we see it more fitting to amend the virtio-fs driver wi=
th
> > > multi-queue support.
> > >=20
> > >=20
> > > > Is it just a theory at this point of time or have you implemented
> > > > it and seeing significant performance benefit with multiqueue?
> > >=20
> > > It is a theory, but we are currently seeing that using the single req=
uest
> > > queue, the single core attending to that queue on the DPU is reasonab=
ly
> > > close to being fully saturated.
> > >=20
> > > > And will this be helpful for rust virtiofsd running on
> > > > host as well?
> > >=20
> > > I figure this would be dependent on the workload and the users-needs.
> > > Having many cores concurrently pulling on their own virtq and then
> > > immediately process the request locally would of course improve perfo=
rmance.
> > > But we are offloading all this work to the DPU, for providing
> > > high-throughput cloud services.
> >=20
> > I think Vivek is getting at whether your code processes requests
> > sequentially or in parallel. A single thread processing the virtqueue
> > that hands off requests to worker threads or uses io_uring to perform
> > I/O asynchronously will perform differently from a single thread that
> > processes requests sequentially in a blocking fashion. Multiqueue is not
> > necessary for parallelism, but the single queue might become a
> > bottleneck.
>=20
> Requests are handled non-blocking with remote IO on the DPU. Our current
> architecture is as follows:
> T1: Tends to the Virtq, parses FUSE to remote IO and fires off the
> asynchronous remote IO.
> T2: Polls for completion on the remote IO and parses it back to FUSE, puts
> the FUSE buffers in a completion queue of T1.
> T1: Handles the Virtio completion and DMA of the requests in the CQ.
>=20
> Thread 1 is busy polling on its two queues (Virtq and CQ) with equal
> priority, thread 2 is busy polling as well. This setup is not really
> optimal, but we are working within the constraints of both our DPU and
> remote IO stack.

Why does T1 need to handle VIRTIO completion and DMA requests instead of
T2?

Stefan

--5plz32DEjUIEOTyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmP2J3AACgkQnKSrs4Gr
c8iK1Qf/YhA4nioX1FwTvISeIQMkywISYTB/HirQzmboUAeHU+Zh9NKc0J+xst0W
dlXdMm70u4vu9MVZAzmXiPIRiUPPCmsjofdcRkHXE6K2xHPu32Xq3ujQ9OGd7Yts
a9qBnBUTag5CztInUz/GF8Haz7OPkZO+oCRZ+uDsFuHHHnMbP6FniAdwrhz2sUGL
V2QjRyXDmRTPYQk7zAFAg1qI871/R9L6Ct0zxPQKK9PiL6EFTLbRMWa3uJWW2yg0
HQKv4G8FTqjlSENBoDujgqMZY26Gu60xsRVhR3Qv3J7ZNxioRRE7HMnDyNrqajiq
AhAUVPANqIicZUyQiUaXPTA2Y2skNQ==
=b2mk
-----END PGP SIGNATURE-----

--5plz32DEjUIEOTyp--


--===============4572256673956295480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4572256673956295480==--

