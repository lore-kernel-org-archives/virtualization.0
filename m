Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43B5C7EE2A
	for <virtualization@archiver.kernel.org>; Thu,  1 Jun 2023 18:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D83C61375;
	Thu,  1 Jun 2023 18:26:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D83C61375
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hnP9O9Mt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7NUvV90osRV8; Thu,  1 Jun 2023 18:26:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8970B611C3;
	Thu,  1 Jun 2023 18:26:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8970B611C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E333C0037;
	Thu,  1 Jun 2023 18:26:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47D8CC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 18:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 104CA61375
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 18:26:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 104CA61375
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RZQ73WIQbbVk
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 18:26:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A2B7611C3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A2B7611C3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685643970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UB5DP6hKRv4BImg28I4vQ2evipVOBrSLQWEwIud0vis=;
 b=hnP9O9MtxVMJvaIBOfItPfcU7WYS8gdi0+/zf4FlikB3b7Pdqyoj+uPNzJcKoqnDX4lHnP
 M4Q54k7P5WIDz3PyqTcYko+4IQ6lc8YgfQ1gBgd0m2Un8ABHiZnKN+jWEFmFogkMpoLNcm
 y8BYhbwuYqb1De899MzykYTHyM2UFd0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-KoUTb2vZMl-RuNoLT9WuTw-1; Thu, 01 Jun 2023 14:26:07 -0400
X-MC-Unique: KoUTb2vZMl-RuNoLT9WuTw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAD683C00088;
 Thu,  1 Jun 2023 18:26:06 +0000 (UTC)
Received: from localhost (unknown [10.39.192.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AAB4492B00;
 Thu,  1 Jun 2023 18:26:05 +0000 (UTC)
Date: Thu, 1 Jun 2023 14:26:04 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Subject: Re: [PATCH V2] virtio-fs: Improved request latencies when Virtio
 queue is full
Message-ID: <20230601182604.GB1622695@fedora>
References: <20230531171031.1424338-1-peter-jan@gootzen.net>
 <ZHedgNu89LoiW4sZ@redhat.com>
 <02ad6a48-6db7-fab5-721e-2d940d4a664a@gootzen.net>
 <ZHey45k+V8sP2F6l@redhat.com> <20230601140850.GF1538357@fedora>
 <07667704-3409-3ad8-6944-b485369e5022@gootzen.net>
MIME-Version: 1.0
In-Reply-To: <07667704-3409-3ad8-6944-b485369e5022@gootzen.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: miklos@szeredi.hu, Vivek Goyal <vgoyal@redhat.com>,
 virtualization@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============8085842423756083886=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============8085842423756083886==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hJtfDjgq0Bn2HfKR"
Content-Disposition: inline


--hJtfDjgq0Bn2HfKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 04:49:06PM +0200, Peter-Jan Gootzen wrote:
> On 01/06/2023 16:08, Stefan Hajnoczi wrote:
> > On Wed, May 31, 2023 at 04:49:39PM -0400, Vivek Goyal wrote:
> >> On Wed, May 31, 2023 at 10:34:15PM +0200, Peter-Jan Gootzen wrote:
> >>> On 31/05/2023 21:18, Vivek Goyal wrote:
> >>>> On Wed, May 31, 2023 at 07:10:32PM +0200, Peter-Jan Gootzen wrote:
> >>>>> When the Virtio queue is full, a work item is scheduled
> >>>>> to execute in 1ms that retries adding the request to the queue.
> >>>>> This is a large amount of time on the scale on which a
> >>>>> virtio-fs device can operate. When using a DPU this is around
> >>>>> 40us baseline without going to a remote server (4k, QD=3D1).
> >>>>> This patch queues requests when the Virtio queue is full,
> >>>>> and when a completed request is taken off, immediately fills
> >>>>> it back up with queued requests.
> >>>>>
> >>>>> This reduces the 99.9th percentile latencies in our tests by
> >>>>> 60x and slightly increases the overall throughput, when using a
> >>>>> queue depth 2x the size of the Virtio queue size, with a
> >>>>> DPU-powered virtio-fs device.
> >>>>>
> >>>>> Signed-off-by: Peter-Jan Gootzen <peter-jan@gootzen.net>
> >>>>> ---
> >>>>> V1 -> V2: Not scheduling dispatch work anymore when not needed
> >>>>> and changed delayed_work structs to work_struct structs
> >>>>>
> >>>>>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
> >>>>>  1 file changed, 17 insertions(+), 15 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> >>>>> index 4d8d4f16c727..a676297db09b 100644
> >>>>> --- a/fs/fuse/virtio_fs.c
> >>>>> +++ b/fs/fuse/virtio_fs.c
> >>>>> @@ -45,7 +45,7 @@ struct virtio_fs_vq {
> >>>>>  	struct work_struct done_work;
> >>>>>  	struct list_head queued_reqs;
> >>>>>  	struct list_head end_reqs;	/* End these requests */
> >>>>> -	struct delayed_work dispatch_work;
> >>>>> +	struct work_struct dispatch_work;
> >>>>>  	struct fuse_dev *fud;
> >>>>>  	bool connected;
> >>>>>  	long in_flight;
> >>>>> @@ -202,7 +202,7 @@ static void virtio_fs_drain_queue(struct virtio=
_fs_vq *fsvq)
> >>>>>  	}
> >>>>> =20
> >>>>>  	flush_work(&fsvq->done_work);
> >>>>> -	flush_delayed_work(&fsvq->dispatch_work);
> >>>>> +	flush_work(&fsvq->dispatch_work);
> >>>>>  }
> >>>>> =20
> >>>>>  static void virtio_fs_drain_all_queues_locked(struct virtio_fs *fs)
> >>>>> @@ -346,6 +346,9 @@ static void virtio_fs_hiprio_done_work(struct w=
ork_struct *work)
> >>>>>  			dec_in_flight_req(fsvq);
> >>>>>  		}
> >>>>>  	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(=
vq)));
> >>>>> +
> >>>>> +	if (!list_empty(&fsvq->queued_reqs))
> >>>>> +		schedule_work(&fsvq->dispatch_work);
> >>>>>  	spin_unlock(&fsvq->lock);
> >>>>>  }
> >>>>> =20
> >>>>> @@ -353,7 +356,7 @@ static void virtio_fs_request_dispatch_work(str=
uct work_struct *work)
> >>>>>  {
> >>>>>  	struct fuse_req *req;
> >>>>>  	struct virtio_fs_vq *fsvq =3D container_of(work, struct virtio_fs=
_vq,
> >>>>> -						 dispatch_work.work);
> >>>>> +						 dispatch_work);
> >>>>>  	int ret;
> >>>>> =20
> >>>>>  	pr_debug("virtio-fs: worker %s called.\n", __func__);
> >>>>> @@ -388,8 +391,6 @@ static void virtio_fs_request_dispatch_work(str=
uct work_struct *work)
> >>>>>  			if (ret =3D=3D -ENOMEM || ret =3D=3D -ENOSPC) {
> >>>>>  				spin_lock(&fsvq->lock);
> >>>>>  				list_add_tail(&req->list, &fsvq->queued_reqs);
> >>>>> -				schedule_delayed_work(&fsvq->dispatch_work,
> >>>>> -						      msecs_to_jiffies(1));
> >>>>
> >>>> Virtqueue being full is only one of the reasons for failure to queue
> >>>> the request. What if virtqueue is empty but we could not queue the
> >>>> request because lack of memory (-ENOMEM). In that case we will queue
> >>>> the request and it might not be dispatched because there is no compl=
etion.
> >>>> (Assume there is no further new request coming). That means deadlock?
> >>>>
> >>>> Thanks
> >>>> Vivek
> >>>>
> >>>
> >>> Good catch that will deadlock.
> >>>
> >>> Is default kernel behavior to indefinitely retry a file system
> >>> request until memory is available?
> >>
> >> As of now that seems to be the behavior. I think I had copied this
> >> code from another driver.=20
> >>
> >> But I guess one can argue that if memory is not available, then
> >> return -ENOMEM to user space instead of retrying in kernel.
> >>
> >> Stefan, Miklos, WDYT?
> >=20
> > My understanding is that file system syscalls may return ENOMEM, so this
> > is okay.
> >=20
> > Stefan
>=20
> Then I propose only handling -ENOSPC as a special case and letting all
> other errors go through to userspace.
>=20
> Noob Linux contributor question: how often should I send in a new revisio=
n of
> the patch? Should I wait for more comments or send in a V3 with that fix =
now?

You can send v3. If it were a long patch series with multiple
maintainers then maybe allowing the others additional time for review
would avoid churn, but in this case I think it's fine to send the next
revision.

Stefan

--hJtfDjgq0Bn2HfKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR44rwACgkQnKSrs4Gr
c8hOsAf+L06q8guG3q6akY9xh9yFYPbWaafMV0zEG9zMyn3CRfVGWmcqUBAbO/0T
NRY9tOvHnsqtVD0AsZ1fK8PNVxaKOMrmPBxqqRqgS/NJlPWdrAI20Ns4nFGfDHdq
M4dLdumtXMq/3B3e+LigX97I7ZEVYiEsLBwoyhAETIqVNcHYOQT8VZQUY2/oOqGT
bGtBx/cdbf8bZs8cN/izBhYsAys3nDcR0Ik3N3oZOnpezsVDSQMbVLs7AHHTStYd
oB36QouPJcDpJz9UtPNtgb/R3Q/pUU00npkLSaMBNE329/FY7rJmG+rFkGERCQIi
Fs59/8MUlkIf9u0/j33SKf4lkeeb2Q==
=OVUB
-----END PGP SIGNATURE-----

--hJtfDjgq0Bn2HfKR--


--===============8085842423756083886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8085842423756083886==--

