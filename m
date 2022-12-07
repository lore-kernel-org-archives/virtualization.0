Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD66C3A5A7
	for <virtualization@archiver.kernel.org>; Thu,  8 Dec 2022 14:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F73A8207A;
	Thu,  8 Dec 2022 14:42:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F73A8207A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q+qI4RDK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QbBffMw7QTo1; Thu,  8 Dec 2022 14:42:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C9D038207C;
	Thu,  8 Dec 2022 14:42:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9D038207C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F3BCC0033;
	Thu,  8 Dec 2022 14:42:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEE57C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 14:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 902E541916
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 14:42:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 902E541916
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q+qI4RDK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g4pNKrEuSaeH
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 14:42:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AFFFA41914
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AFFFA41914
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Dec 2022 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670510557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=su2lUkDQHUFhv4VEOGFPuQBsnBPEcF90Y1ekpqoV0HM=;
 b=Q+qI4RDKxmalTL2JTLjZewurOlQGW15N+mFq1fM5pI/rTlXUn2mgmACYPmF0mQyIxcNmbN
 oEwvtMvdjLJuou35BkHcvBfxaoJDqXhczCWkATT8Q7BU0FE5FJyab62/wag1XDSNrMfQi1
 2gdvZfidfXEx77lEQTJDbJCvRQcwjYg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-wesRoOmrMEuqHAmp1RPsVw-1; Thu, 08 Dec 2022 09:42:33 -0500
X-MC-Unique: wesRoOmrMEuqHAmp1RPsVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B1388039AC;
 Thu,  8 Dec 2022 14:42:33 +0000 (UTC)
Received: from localhost (unknown [10.39.194.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D76B2492B05;
 Thu,  8 Dec 2022 14:42:31 +0000 (UTC)
Date: Wed, 7 Dec 2022 16:47:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: axboe@kernel.dk
Subject: Re: [PATCH 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE after
 polling I/O is finished
Message-ID: <Y5EJ+6qtsy8Twe/q@fedora>
References: <20221206141125.93055-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20221206141125.93055-1-suwan.kim027@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: linux-block@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 pbonzini@redhat.com, Suwan Kim <suwan.kim027@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3564401268835443095=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3564401268835443095==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TLPWbvavsl8s4xu9"
Content-Disposition: inline


--TLPWbvavsl8s4xu9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2022 at 11:11:24PM +0900, Suwan Kim wrote:
> Driver should set req->state to MQ_RQ_COMPLETE after it finishes to proce=
ss
> req. But virtio-blk doesn't set MQ_RQ_COMPLETE after virtblk_poll() handl=
es
> req and req->state still remains MQ_RQ_IN_FLIGHT. Fortunately so far there
> is no issue about it because blk_mq_end_request_batch() sets req->state to
> MQ_RQ_IDLE. This patch properly sets req->state after polling I/O is fini=
shed.
>=20
> Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> ---
>  drivers/block/virtio_blk.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 19da5defd734..cf64d256787e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -839,6 +839,7 @@ static void virtblk_complete_batch(struct io_comp_bat=
ch *iob)
>  	rq_list_for_each(&iob->req_list, req) {
>  		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
>  		virtblk_cleanup_cmd(req);
> +		blk_mq_set_request_complete(req);
>  	}
>  	blk_mq_end_request_batch(iob);
>  }

The doc comment for blk_mq_set_request_complete() mentions this being
used in ->queue_rq(), but that's not the case here. Does the doc comment
need to be updated if we're using the function in a different way?

I'm not familiar enough with the Linux block APIs, but this feels weird
to me. Shouldn't blk_mq_end_request_batch(iob) take care of this for us?
Why does it set the state to IDLE instead of COMPLETE?

I think Jens can confirm whether we really want all drivers that use
polling and io_comp_batch to manually call
blk_mq_set_request_complete().

Thanks,
Stefan

--TLPWbvavsl8s4xu9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmORCfsACgkQnKSrs4Gr
c8jzcwgAkqjCxjdTMpgQ9FJr1zb/9w4oIKfPrLRFiS8+aZrjF4PSgH6iISADo6LN
y5jC+JbJI9HImldIbxcJ3VBzA4Vbp6gJZv/NolxztP0Vnc/1EPCQDy1j8hoJzm7u
G7jLL2iIkQEyr4IChxEtJMrLRmNz9Lqj2dcKdLTPNGInlgUspVDKjbdjN+rfHOHg
bGG0GDreFzM+8ZuGghcJMeeUb+fUjbJd4oLyxwROhZlBD+LU8nG0KRZ1L/phGIN3
sPihNVo5okhFsDBqCqIPgGiouSpN/fsfQJV+spkFPbm2kbuURlFVQZZJSV1wZ1rn
19xu2Y5NAnew/RxTYo7OflRvnC0ISQ==
=U0Ee
-----END PGP SIGNATURE-----

--TLPWbvavsl8s4xu9--


--===============3564401268835443095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3564401268835443095==--

