Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F7FC433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 11:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 766CA40276;
	Wed,  2 Feb 2022 11:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zXJQ42e0ZOvx; Wed,  2 Feb 2022 11:14:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1FE044026B;
	Wed,  2 Feb 2022 11:14:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3731C0011;
	Wed,  2 Feb 2022 11:14:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2303BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 11:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BCF340276
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 11:14:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id laBbnDmsaYXS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 11:14:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 559804026B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643800478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GKi4fqp9T90PFymDadhmgce6wMt0VwHShO7jEqza5eU=;
 b=cIQ14hFJscbkytrZ1ecO31pDACZYvII60Qt2pHqVVCIfmxmVFI18xHg4bmdAc6Ph9KaT8p
 7Y5DGB78oMH0+ibrhQbLr3DP+KADOCGyCxOH9XA1T+uvmJr4QwS2chmKXIse5b+XZF3XM9
 eEZ4iwkqQW2XnGJgznA7Mqc39w2fcTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-dFIjoGhpNNqu9IWq3WKPLA-1; Wed, 02 Feb 2022 06:14:36 -0500
X-MC-Unique: dFIjoGhpNNqu9IWq3WKPLA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E9DC8145E0;
 Wed,  2 Feb 2022 11:14:35 +0000 (UTC)
Received: from localhost (unknown [10.39.194.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D9B110840C8;
 Wed,  2 Feb 2022 11:14:31 +0000 (UTC)
Date: Wed, 2 Feb 2022 11:14:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v3] vhost: cache avail index in vhost_enable_notify()
Message-ID: <Yfpnlv2GudpPFwok@stefanha-x1.localdomain>
References: <20220128094129.40809-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220128094129.40809-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: multipart/mixed; boundary="===============7209482290225045229=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============7209482290225045229==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fuCjJKl+rhQI04HL"
Content-Disposition: inline


--fuCjJKl+rhQI04HL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 28, 2022 at 10:41:29AM +0100, Stefano Garzarella wrote:
> In vhost_enable_notify() we enable the notifications and we read
> the avail index to check if new buffers have become available in
> the meantime.
>=20
> We do not update the cached avail index value, so when the device
> will call vhost_get_vq_desc(), it will find the old value in the
> cache and it will read the avail index again.
>=20
> It would be better to refresh the cache every time we read avail
> index, so let's change vhost_enable_notify() caching the value in
> `avail_idx` and compare it with `last_avail_idx` to check if there
> are new buffers available.
>=20
> We don't expect a significant performance boost because
> the above path is not very common, indeed vhost_enable_notify()
> is often called with unlikely(), expecting that avail index has
> not been updated.
>=20
> We ran virtio-test/vhost-test and noticed minimal improvement as
> expected. To stress the patch more, we modified vhost_test.ko to
> call vhost_enable_notify()/vhost_disable_notify() on every cycle
> when calling vhost_get_vq_desc(); in this case we observed a more
> evident improvement, with a reduction of the test execution time
> of about 3.7%.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3
> - reworded commit description [Stefan]
> ---
>  drivers/vhost/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..07363dff559e 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, str=
uct vhost_virtqueue *vq)
>  		       &vq->avail->idx, r);
>  		return false;
>  	}
> +	vq->avail_idx =3D vhost16_to_cpu(vq, avail_idx);
> =20
> -	return vhost16_to_cpu(vq, avail_idx) !=3D vq->avail_idx;
> +	return vq->avail_idx !=3D vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);

This changes behavior (fixes a bug?): previously the function returned
false when called with avail buffers still pending (vq->last_avail_idx <
vq->avail_idx). Now it returns true because we compare against
vq->last_avail_idx and I think that's reasonable.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fuCjJKl+rhQI04HL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmH6Z5YACgkQnKSrs4Gr
c8hzcAf+JA1nvAfB9vXnXaEvnqavzXy0JQP6jb39LJJcY+fOuScye2bC2h+EYGJk
+KItlNdztAg4O9VE6Tp9ufuyr7703+VHDMyD3JJlYlEhnzVMWcC7CF3xq8S9tQQF
qV7wuXSciwoLHzMeqCtnNvjw5JeNQd5f6I33gESvqIKg+CxIsKpuWdqFPB+YLRtn
KP2AwsbzDplPauvcs7iSeTii6q0S8TUe4Xxb+m/Ph8nESlST15G5TOA22+KCQU7h
gjLk5rf0LMZjYkLi7TTDGUSfBGDmQtyY2cE8GhAxhnbkeMh0LQSXTnvrtIJcS5TB
R8OcYI7Dk00alFycjUdq9M002b/KiA==
=Qrnr
-----END PGP SIGNATURE-----

--fuCjJKl+rhQI04HL--


--===============7209482290225045229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7209482290225045229==--

