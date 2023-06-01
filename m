Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F89C77B7A
	for <virtualization@archiver.kernel.org>; Thu,  1 Jun 2023 14:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC04241B34;
	Thu,  1 Jun 2023 14:09:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC04241B34
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HYy6Lkb7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dq-g33Ke3fQt; Thu,  1 Jun 2023 14:09:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CDF3040260;
	Thu,  1 Jun 2023 14:09:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDF3040260
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AC10C0037;
	Thu,  1 Jun 2023 14:09:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B901C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 14:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D4FD402FE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 14:09:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D4FD402FE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KwZlfp_tnN-S
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 14:09:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53F2840260
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53F2840260
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685628538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nt3LBlaZgH65weGFOEqEHPcduo0HbVvVBDmP/VI0Mc8=;
 b=HYy6Lkb7E/Wbzoil4y+kGCrQcgxHvqq3kUQ0ItYG314OD4FhrGcX4Xej+N0oPGl9K+Jzfv
 EECXSIxFbHoQi9SAMJqSVn2ZapEqxfb/afxdbuEoIm63mSEjuRCr+8K5eA+2ct4YQI1YW8
 mxhEwJ9SzT3it4Q3VWMO40xdndA6N6E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-ggc-ISIJONmiLbgGaIho3g-1; Thu, 01 Jun 2023 10:08:54 -0400
X-MC-Unique: ggc-ISIJONmiLbgGaIho3g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E7AD8030D2;
 Thu,  1 Jun 2023 14:08:52 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A72C0492B00;
 Thu,  1 Jun 2023 14:08:51 +0000 (UTC)
Date: Thu, 1 Jun 2023 10:08:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH V2] virtio-fs: Improved request latencies when Virtio
 queue is full
Message-ID: <20230601140850.GF1538357@fedora>
References: <20230531171031.1424338-1-peter-jan@gootzen.net>
 <ZHedgNu89LoiW4sZ@redhat.com>
 <02ad6a48-6db7-fab5-721e-2d940d4a664a@gootzen.net>
 <ZHey45k+V8sP2F6l@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ZHey45k+V8sP2F6l@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: miklos@szeredi.hu, virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============5281876527783185721=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============5281876527783185721==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W6EtD3ojVX5LCvDy"
Content-Disposition: inline


--W6EtD3ojVX5LCvDy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 04:49:39PM -0400, Vivek Goyal wrote:
> On Wed, May 31, 2023 at 10:34:15PM +0200, Peter-Jan Gootzen wrote:
> > On 31/05/2023 21:18, Vivek Goyal wrote:
> > > On Wed, May 31, 2023 at 07:10:32PM +0200, Peter-Jan Gootzen wrote:
> > >> When the Virtio queue is full, a work item is scheduled
> > >> to execute in 1ms that retries adding the request to the queue.
> > >> This is a large amount of time on the scale on which a
> > >> virtio-fs device can operate. When using a DPU this is around
> > >> 40us baseline without going to a remote server (4k, QD=3D1).
> > >> This patch queues requests when the Virtio queue is full,
> > >> and when a completed request is taken off, immediately fills
> > >> it back up with queued requests.
> > >>
> > >> This reduces the 99.9th percentile latencies in our tests by
> > >> 60x and slightly increases the overall throughput, when using a
> > >> queue depth 2x the size of the Virtio queue size, with a
> > >> DPU-powered virtio-fs device.
> > >>
> > >> Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
> > >> ---
> > >> V1 -> V2: Not scheduling dispatch work anymore when not needed
> > >> and changed delayed_work structs to work_struct structs
> > >>
> > >>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
> > >>  1 file changed, 17 insertions(+), 15 deletions(-)
> > >>
> > >> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > >> index 4d8d4f16c727..a676297db09b 100644
> > >> --- a/fs/fuse/virtio_fs.c
> > >> +++ b/fs/fuse/virtio_fs.c
> > >> @@ -45,7 +45,7 @@ struct virtio_fs_vq {
> > >>  	struct work_struct done_work;
> > >>  	struct list_head queued_reqs;
> > >>  	struct list_head end_reqs;	/* End these requests */
> > >> -	struct delayed_work dispatch_work;
> > >> +	struct work_struct dispatch_work;
> > >>  	struct fuse_dev *fud;
> > >>  	bool connected;
> > >>  	long in_flight;
> > >> @@ -202,7 +202,7 @@ static void virtio_fs_drain_queue(struct virtio_=
fs_vq *fsvq)
> > >>  	}
> > >> =20
> > >>  	flush_work(&fsvq->done_work);
> > >> -	flush_delayed_work(&fsvq->dispatch_work);
> > >> +	flush_work(&fsvq->dispatch_work);
> > >>  }
> > >> =20
> > >>  static void virtio_fs_drain_all_queues_locked(struct virtio_fs *fs)
> > >> @@ -346,6 +346,9 @@ static void virtio_fs_hiprio_done_work(struct wo=
rk_struct *work)
> > >>  			dec_in_flight_req(fsvq);
> > >>  		}
> > >>  	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(v=
q)));
> > >> +
> > >> +	if (!list_empty(&fsvq->queued_reqs))
> > >> +		schedule_work(&fsvq->dispatch_work);
> > >>  	spin_unlock(&fsvq->lock);
> > >>  }
> > >> =20
> > >> @@ -353,7 +356,7 @@ static void virtio_fs_request_dispatch_work(stru=
ct work_struct *work)
> > >>  {
> > >>  	struct fuse_req *req;
> > >>  	struct virtio_fs_vq *fsvq =3D container_of(work, struct virtio_fs_=
vq,
> > >> -						 dispatch_work.work);
> > >> +						 dispatch_work);
> > >>  	int ret;
> > >> =20
> > >>  	pr_debug("virtio-fs: worker %s called.\n", __func__);
> > >> @@ -388,8 +391,6 @@ static void virtio_fs_request_dispatch_work(stru=
ct work_struct *work)
> > >>  			if (ret =3D=3D -ENOMEM || ret =3D=3D -ENOSPC) {
> > >>  				spin_lock(&fsvq->lock);
> > >>  				list_add_tail(&req->list, &fsvq->queued_reqs);
> > >> -				schedule_delayed_work(&fsvq->dispatch_work,
> > >> -						      msecs_to_jiffies(1));
> > >=20
> > > Virtqueue being full is only one of the reasons for failure to queue
> > > the request. What if virtqueue is empty but we could not queue the
> > > request because lack of memory (-ENOMEM). In that case we will queue
> > > the request and it might not be dispatched because there is no comple=
tion.
> > > (Assume there is no further new request coming). That means deadlock?
> > >=20
> > > Thanks
> > > Vivek
> > >=20
> >=20
> > Good catch that will deadlock.
> >=20
> > Is default kernel behavior to indefinitely retry a file system
> > request until memory is available?
>=20
> As of now that seems to be the behavior. I think I had copied this
> code from another driver.=20
>=20
> But I guess one can argue that if memory is not available, then
> return -ENOMEM to user space instead of retrying in kernel.
>=20
> Stefan, Miklos, WDYT?

My understanding is that file system syscalls may return ENOMEM, so this
is okay.

Stefan

--W6EtD3ojVX5LCvDy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR4pnIACgkQnKSrs4Gr
c8jqRAgAvwjZAtUHIOz+weUMptKc5XQ8EG9RsupPJeGqLZ2dY1SlzbxinajYk/YM
a6sXR5rQFSpIpG/1PV+M80p/oRc2Va8IyyYJmcmm4zjPsymOLZDT0W4zH/N24K8v
qfPICzy48hp0bzzaIEfMhMrIjXfsNqEUcBWFhDOzwL621ldXFr7+lZ8ofGVNEGT2
qml9xvUpnYfjmZeQq8izttWLngPXk7EK/7/TrLC/+SoCWnnzHRJQJAyCgMZRiDcG
0ZF6AdOeE2lAGV3UN0g+GRLu/fLc4V8lJYMljBIbScFZW1ibe98RR1Q4JQ4zJ9d6
b4AuXpelK3LR12IqqXJJlCjdVo8g7g==
=NFfY
-----END PGP SIGNATURE-----

--W6EtD3ojVX5LCvDy--


--===============5281876527783185721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5281876527783185721==--

