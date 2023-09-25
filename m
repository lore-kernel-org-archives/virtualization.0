Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C7FCE79A1
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 21:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6832541B6E;
	Mon, 25 Sep 2023 21:19:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6832541B6E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DSXGvchS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J7zHSVE2BIz4; Mon, 25 Sep 2023 21:18:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B76741993;
	Mon, 25 Sep 2023 21:18:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B76741993
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13A86C0039;
	Mon, 25 Sep 2023 21:18:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE08C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 21:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C954441725
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 21:18:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C954441725
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DSXGvchS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aAyXeiIqk4xA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 21:18:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA7D441723
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 21:18:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA7D441723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695676733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjbIZt/PW2FzwWrzcgpL9MX8MGpM8dB4UgR9ohho57s=;
 b=DSXGvchSXloAdIWlkB3xSw4DVcdQcdTuWhfyPXywJm7b0hy2U2mQBBpvdUy/+1qIGrFmGS
 DmEGB5gpMfWeYxOylqJhH0EY01ftv/rK+C9qD+tYAbXu0BPDUs3HVobUrCTImstn03s4vE
 xMU/Z06qu0FV8CZy6ojt+6CguDXYOB4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-VVU9vKFBNsa0kL8oPRzKCQ-1; Mon, 25 Sep 2023 17:18:38 -0400
X-MC-Unique: VVU9vKFBNsa0kL8oPRzKCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE19229AB415;
 Mon, 25 Sep 2023 21:17:12 +0000 (UTC)
Received: from localhost (unknown [10.39.194.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40C93140273D;
 Mon, 25 Sep 2023 21:17:12 +0000 (UTC)
Date: Mon, 25 Sep 2023 17:17:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3] io_uring: fix IO hang in io_wq_put_and_exit from
 do_exit()
Message-ID: <20230925211710.GH323580@fedora>
References: <20230908093009.540763-1-ming.lei@redhat.com>
 <58227846-6b73-46ef-957f-d9b1e0451899@kernel.dk>
 <ZPsxCYFgZjIIeaBk@fedora>
 <0f85a6b5-3ba6-4b77-bb7d-79f365dbb44c@kernel.dk>
 <ZPs81IAYfB8J78Pv@fedora>
 <CACGkMEvP=f1mB=01CDOhHaDLNL9espKPrUffgHEdBVkW4fo=pw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvP=f1mB=01CDOhHaDLNL9espKPrUffgHEdBVkW4fo=pw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
 mst@redhat.com, io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, virtualization@lists.linux-foundation.org,
 Pavel Begunkov <asml.silence@gmail.com>,
 Chengming Zhou <zhouchengming@bytedance.com>
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
Content-Type: multipart/mixed; boundary="===============1164856541508652674=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============1164856541508652674==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HDPsBeSpl2khZZyk"
Content-Disposition: inline


--HDPsBeSpl2khZZyk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 03:04:05PM +0800, Jason Wang wrote:
> On Fri, Sep 8, 2023 at 11:25=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wr=
ote:
> >
> > On Fri, Sep 08, 2023 at 08:44:45AM -0600, Jens Axboe wrote:
> > > On 9/8/23 8:34 AM, Ming Lei wrote:
> > > > On Fri, Sep 08, 2023 at 07:49:53AM -0600, Jens Axboe wrote:
> > > >> On 9/8/23 3:30 AM, Ming Lei wrote:
> > > >>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> > > >>> index ad636954abae..95a3d31a1ef1 100644
> > > >>> --- a/io_uring/io_uring.c
> > > >>> +++ b/io_uring/io_uring.c
> > > >>> @@ -1930,6 +1930,10 @@ void io_wq_submit_work(struct io_wq_work *=
work)
> > > >>>           }
> > > >>>   }
> > > >>>
> > > >>> + /* It is fragile to block POLLED IO, so switch to NON_BLOCK */
> > > >>> + if ((req->ctx->flags & IORING_SETUP_IOPOLL) && def->iopoll_queu=
e)
> > > >>> +         issue_flags |=3D IO_URING_F_NONBLOCK;
> > > >>> +
> > > >>
> > > >> I think this comment deserves to be more descriptive. Normally we
> > > >> absolutely cannot block for polled IO, it's only OK here because i=
o-wq
> > > >
> > > > Yeah, we don't do that until commit 2bc057692599 ("block: don't mak=
e REQ_POLLED
> > > > imply REQ_NOWAIT") which actually push the responsibility/risk up to
> > > > io_uring.
> > > >
> > > >> is the issuer and not necessarily the poller of it. That generally=
 falls
> > > >> upon the original issuer to poll these requests.
> > > >>
> > > >> I think this should be a separate commit, coming before the main f=
ix
> > > >> which is below.
> > > >
> > > > Looks fine, actually IO_URING_F_NONBLOCK change isn't a must, and t=
he
> > > > approach in V2 doesn't need this change.
> > > >
> > > >>
> > > >>> @@ -3363,6 +3367,12 @@ __cold void io_uring_cancel_generic(bool c=
ancel_all, struct io_sq_data *sqd)
> > > >>>           finish_wait(&tctx->wait, &wait);
> > > >>>   } while (1);
> > > >>>
> > > >>> + /*
> > > >>> +  * Reap events from each ctx, otherwise these requests may take
> > > >>> +  * resources and prevent other contexts from being moved on.
> > > >>> +  */
> > > >>> + xa_for_each(&tctx->xa, index, node)
> > > >>> +         io_iopoll_try_reap_events(node->ctx);
> > > >>
> > > >> The main issue here is that if someone isn't polling for them, the=
n we
> > > >
> > > > That is actually what this patch is addressing, :-)
> > >
> > > Right, that part is obvious :)
> > >
> > > >> get to wait for a timeout before they complete. This can delay exi=
t, for
> > > >> example, as we're now just waiting 30 seconds (or whatever the tim=
eout
> > > >> is on the underlying device) for them to get timed out before exit=
 can
> > > >> finish.
> > > >
> > > > For the issue on null_blk, device timeout handler provides
> > > > forward-progress, such as requests are released, so new IO can be
> > > > handled.
> > > >
> > > > However, not all devices support timeout, such as virtio device.
> > >
> > > That's a bug in the driver, you cannot sanely support polled IO and n=
ot
> > > be able to deal with timeouts. Someone HAS to reap the requests and
> > > there are only two things that can do that - the application doing the
> > > polled IO, or if that doesn't happen, a timeout.
> >
> > OK, then device driver timeout handler has new responsibility of coveri=
ng
> > userspace accident, :-)

Sorry, I don't have enough context so this is probably a silly question:

When an application doesn't reap a polled request, why doesn't the block
layer take care of this in a generic way? I don't see anything
driver-specific about this.

Driver-specific behavior would be sending an abort/cancel upon timeout.
virtio-blk cannot do that because there is no such command in the device
specification at the moment. So simply waiting for the polled request to
complete is the only thing that can be done (aside from resetting the
device), and it's generic behavior.

Thanks,
Stefan

> >
> > We may document this requirement for driver.
> >
> > So far the only one should be virtio-blk, and the two virtio storage
> > drivers never implement timeout handler.
> >
>=20
> Adding Stefan for more comments.
>=20
> Thanks
>=20

--HDPsBeSpl2khZZyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUR+NYACgkQnKSrs4Gr
c8hthggAo7vnKS8HByNvkS1ugVClotOiaetq0qx9G2Zsn0tcVpMLqIFVlkGu/JEn
dQPdQvRynTp5Jl98V9I6XYHRrit5J3ZlnNG7QcHlwR83L6TGvieu2MyCfK8jxtJJ
r3xZKt3BX+Kl3b5iVPSFsTC5J7DV7IgysGUxooZxLCRiJuqH/QyiBWxriWZn/ffv
mPKR4tGhfcYlOVg5KxjIGeWhX7Q2Xd33TrkFAB++mnEeCxCFTGIMi0UMAWxp8rmb
UgjGQoyEHRyko1BICncTwPCySFxM0PEiHtUvSK9/XBqPYjYXHPyEBpIU3Xhf6KvO
6j6PqRghCqs5CXiteW0wBE1i05dClg==
=d074
-----END PGP SIGNATURE-----

--HDPsBeSpl2khZZyk--


--===============1164856541508652674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1164856541508652674==--

