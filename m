Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F336C636CC
	for <virtualization@archiver.kernel.org>; Wed,  8 Feb 2023 10:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 100324047D;
	Wed,  8 Feb 2023 10:43:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 100324047D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=in3Inu9/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tb9V2i14qtxn; Wed,  8 Feb 2023 10:43:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DF6194042F;
	Wed,  8 Feb 2023 10:43:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF6194042F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0B8BC0033;
	Wed,  8 Feb 2023 10:43:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 659B8C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 10:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 343284012D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 10:43:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 343284012D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=in3Inu9/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2JC092cCD-xM
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 10:43:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89FAC401D5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 89FAC401D5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 10:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675853007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yExCIAXzYXzr7SpOUE7u3093mT0JtrfTIuMURFJs4g=;
 b=in3Inu9/gvtxdB4eg4/5F+oQXIOW8kqN8tGXM6A6vlOIJ3xR8RCYDzpx+E0flud1DSLkbg
 HhgFBBnkS4QnR2e/Vd3EnmPSlz6GN31x+ZjurKDv+jQhQaMSkbe2sg6NXk8T3gE6OZsiFJ
 6h+0aPHmk+wajUtpYKgpJ91Snb7xGd4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-Xb7_ClBeODaSah0Deh2npQ-1; Wed, 08 Feb 2023 05:43:23 -0500
X-MC-Unique: Xb7_ClBeODaSah0Deh2npQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 987DB3815F64;
 Wed,  8 Feb 2023 10:43:22 +0000 (UTC)
Received: from localhost (unknown [10.39.195.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0B9618EC2;
 Wed,  8 Feb 2023 10:43:21 +0000 (UTC)
Date: Wed, 8 Feb 2023 05:43:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Subject: Re: virtio-fs: adding support for multi-queue
Message-ID: <Y+N8x5kIe3pAaeUj@fedora>
References: <2fd99bc2-0414-0b85-2bff-3a84ae6c23bd@gootzen.net>
 <Y+KqY3Nse0pVhd3X@fedora> <Y+KsVhIR9aEoSdRu@redhat.com>
 <Y+LDUmWyXCdPIriB@fedora> <Y+LJMwo/K2CHdaPc@redhat.com>
 <9babf0e8-19c3-bb1b-39f8-c755fdc57c8d@gootzen.net>
MIME-Version: 1.0
In-Reply-To: <9babf0e8-19c3-bb1b-39f8-c755fdc57c8d@gootzen.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
Content-Type: multipart/mixed; boundary="===============6908296002666475499=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============6908296002666475499==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="okGVqUBGafwBdoqA"
Content-Disposition: inline


--okGVqUBGafwBdoqA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 09:33:33AM +0100, Peter-Jan Gootzen wrote:
>=20
>=20
> On 07/02/2023 22:57, Vivek Goyal wrote:
> > On Tue, Feb 07, 2023 at 04:32:02PM -0500, Stefan Hajnoczi wrote:
> > > On Tue, Feb 07, 2023 at 02:53:58PM -0500, Vivek Goyal wrote:
> > > > On Tue, Feb 07, 2023 at 02:45:39PM -0500, Stefan Hajnoczi wrote:
> > > > > On Tue, Feb 07, 2023 at 11:14:46AM +0100, Peter-Jan Gootzen wrote:
> > > > > > Hi,
> > > > > >=20
> > > >=20
> > > > [cc German]
> > > >=20
> > > > > > For my MSc thesis project in collaboration with IBM
> > > > > > (https://github.com/IBM/dpu-virtio-fs) we are looking to improv=
e the
> > > > > > performance of the virtio-fs driver in high throughput scenario=
s. We think
> > > > > > the main bottleneck is the fact that the virtio-fs driver does =
not support
> > > > > > multi-queue (while the spec does). A big factor in this is that=
 our setup on
> > > > > > the virtio-fs device-side (a DPU) does not easily allow multipl=
e cores to
> > > > > > tend to a single virtio queue.
> > > >=20
> > > > This is an interesting limitation in DPU.
> > >=20
> > > Virtqueues are single-consumer queues anyway. Sharing them between
> > > multiple threads would be expensive. I think using multiqueue is natu=
ral
> > > and not specific to DPUs.
> >=20
> > Can we create multiple threads (a thread pool) on DPU and let these
> > threads process requests in parallel (While there is only one virt
> > queue).
> >=20
> > So this is what we had done in virtiofsd. One thread is dedicated to
> > pull the requests from virt queue and then pass the request to thread
> > pool to process it. And that seems to help with performance in
> > certain cases.
> >=20
> > Is that possible on DPU? That itself can give a nice performance
> > boost for certain workloads without having to implement multiqueue
> > actually.
> >=20
> > Just curious. I am not opposed to the idea of multiqueue. I am
> > just curious about the kind of performance gain (if any) it can
> > provide. And will this be helpful for rust virtiofsd running on
> > host as well?
> >=20
> > Thanks
> > Vivek
> >=20
> There is technically nothing preventing us from consuming a single queue =
on
> multiple cores, however our current Virtio implementation (DPU-side) is s=
et
> up with the assumption that you should never want to do that (concurrency
> mayham around the Virtqueues and the DMAs). So instead of putting all the
> work into reworking the implementation to support that and still incur the
> big overhead, we see it more fitting to amend the virtio-fs driver with
> multi-queue support.
>=20
>=20
> > Is it just a theory at this point of time or have you implemented
> > it and seeing significant performance benefit with multiqueue?
>=20
> It is a theory, but we are currently seeing that using the single request
> queue, the single core attending to that queue on the DPU is reasonably
> close to being fully saturated.
>=20
> > And will this be helpful for rust virtiofsd running on
> > host as well?
>=20
> I figure this would be dependent on the workload and the users-needs.
> Having many cores concurrently pulling on their own virtq and then
> immediately process the request locally would of course improve performan=
ce.
> But we are offloading all this work to the DPU, for providing
> high-throughput cloud services.

I think Vivek is getting at whether your code processes requests
sequentially or in parallel. A single thread processing the virtqueue
that hands off requests to worker threads or uses io_uring to perform
I/O asynchronously will perform differently from a single thread that
processes requests sequentially in a blocking fashion. Multiqueue is not
necessary for parallelism, but the single queue might become a
bottleneck.

> > Sounds good. Assigning vqs round-robin is the strategy that virtio-net
> > and virtio-blk use. virtio-blk could be an interesting example as it's
> > similar to virtiofs. The Linux multiqueue block layer and core virtio
> > irq allocation handle CPU affinity in the case of virtio-blk.
>=20
> The virtio-blk use the queue assigned by the mq block layer and virtio-net
> the queue assigned from the net core layer correct?

Yes.

> If I interpret you correct, the round-robin strategy is done by assigning
> cores to queues round-robin, not per requests dynamically round-robin?

Yes, virtqueues are assigned to CPUs statically.

> This is what I remembered as well, but can't find it clearly in the source
> right now, do you have references to the source for this?

virtio_blk.ko uses an irq_affinity descriptor to tell virtio_find_vqs()
to spread MSI interrupts across CPUs:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/block/virtio_blk.c#n609

The core blk-mq code has the blk_mq_virtio_map_queues() function to map
block layer queues to virtqueues:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/blo=
ck/blk-mq-virtio.c#n24

virtio_net.ko manually sets virtqueue affinity:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/virtio_net.c#n2283

virtio_net.ko tells the core net subsystem about queues using
netif_set_real_num_tx_queues() and then skbs are mapped to queues by
common code:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net=
/core/dev.c#n4079

Stefan

--okGVqUBGafwBdoqA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmPjfMcACgkQnKSrs4Gr
c8g9SAgAhER/VqCAXNFu0MCuwDZrhz37ElcYjfxErHmPl93LaQIotiCZgbNnNdEn
hLO4wJvx5eiScTT2Q5naytN/cBP31k4SblPp6mE2z5GJI2YRbT4TG3F+QuZFNS62
5RBMlaEcW2JoS2XH+z73+aNQOKoEamtYuLnlucmGVX1F8gOEoVWXkOziOwB1Q57U
c7bJzO7yc71oahE1TCYEMIMIDRucnzAzKoyNI6gmmAVabmjg31zuCuhxsVsWZQKa
9y7QhiNgze/0pBo0EeRfUx8BNQRMDoMkx2TEOf97qzs0edqtkE8eoX5HhYs2Oa0n
xGb1t1tgYo16c8ClmF3gnJR9G8jhYg==
=u6I2
-----END PGP SIGNATURE-----

--okGVqUBGafwBdoqA--


--===============6908296002666475499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6908296002666475499==--

