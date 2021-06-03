Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F89C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 10:45:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E239613D6
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 10:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E239613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C559D605E9;
	Thu,  3 Jun 2021 10:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9xtTtC46p6qP; Thu,  3 Jun 2021 10:45:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65D64600D4;
	Thu,  3 Jun 2021 10:45:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D169C000D;
	Thu,  3 Jun 2021 10:45:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77543C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:45:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 620EB405C4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Quntg3Xs22hg
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:45:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E78D5405C2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 10:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622717111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DKnh0uyhdKqoboJLkz1MQbf+CPgU8STex9vsGZAVttw=;
 b=dy08ISs5m4KXakVAwg7VzUy1nzqERUxt+RyIHtaSApPtVJwaSiRJXbo8cbsqwxkTlPo/SY
 tLZWjru+Dy1S1K2XyidNtV3eHTS2TXbUJhN5y4KYmeP1ryQlqr5NuFkwm7MsRiuTbQ8Qgm
 u6QWmsB2oB8wh00ZwNB+FVYN6rCTuDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-rgmo3ZBUPgyy8riSHYsp3g-1; Thu, 03 Jun 2021 06:45:08 -0400
X-MC-Unique: rgmo3ZBUPgyy8riSHYsp3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A950801817;
 Thu,  3 Jun 2021 10:45:07 +0000 (UTC)
Received: from localhost (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01FB350F89;
 Thu,  3 Jun 2021 10:45:02 +0000 (UTC)
Date: Thu, 3 Jun 2021 11:45:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 3/9] vhost: modify internal functions to take a
 vhost_worker
Message-ID: <YLiyrRdeD6vQ2VXc@stefanha-x1.localdomain>
References: <20210525180600.6349-1-michael.christie@oracle.com>
 <20210525180600.6349-4-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210525180600.6349-4-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 pbonzini@redhat.com
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
Content-Type: multipart/mixed; boundary="===============3623419014651007940=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--===============3623419014651007940==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F7RAaeNOJ2iI4bk5"
Content-Disposition: inline


--F7RAaeNOJ2iI4bk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 01:05:54PM -0500, Mike Christie wrote:
> -void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> +static void vhost_work_queue_on(struct vhost_work *work,
> +				struct vhost_worker *worker)
>  {
> -	if (!dev->worker)
> -		return;
> -
>  	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>  		/* We can only add the work to the list after we're
>  		 * sure it was not in the list.
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
> -		llist_add(&work->node, &dev->worker->work_list);
> -		wake_up_process(dev->worker->task);
> +		llist_add(&work->node, &worker->work_list);
> +		wake_up_process(worker->task);
>  	}
>  }
> +
> +void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)

When should this function still be used? A doc comment contrasting it to
vhost_work_queue_on() would be helpful. I would expect callers to switch
to that instead of queuing work on dev->workers[0].

>  /* A lockless hint for busy polling code to exit the loop */
>  bool vhost_has_work(struct vhost_dev *dev)
>  {
> -	return dev->worker && !llist_empty(&dev->worker->work_list);
> +	int i;
> +
> +	for (i =3D 0; i < dev->num_workers; i++) {
> +		if (!llist_empty(&dev->workers[i]->work_list))
> +			return true;
> +	}
> +
> +	return false;
>  }
>  EXPORT_SYMBOL_GPL(vhost_has_work);

It's probably not necessary to poll all workers:

drivers/vhost/net.c calls vhost_has_work() to busy poll a specific
virtqueue. If the vq:worker mapping is 1:1 or N:1 then vhost_has_work()
should be extended to include the struct vhost_virtqueue so we can poll
just that vq worker's work_list.
>  /* Caller must have device mutex */
>  static int vhost_worker_try_create_def(struct vhost_dev *dev)
>  {
> -	if (!dev->use_worker || dev->worker)
> +	struct vhost_worker *worker;
> +
> +	if (!dev->use_worker || dev->workers)
>  		return 0;
> =20
> -	return vhost_worker_create(dev);
> +	dev->workers =3D kcalloc(1, sizeof(struct vhost_worker *), GFP_KERNEL);

GFP_KERNEL_ACCOUNT so that vhost memory associated with a process (the
one that invoked the ioctl) is accounted? This may get trickier if the
workers are shared between processes.

The same applies for struct vhost_worker in vhost_worker_create().

--F7RAaeNOJ2iI4bk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmC4sq0ACgkQnKSrs4Gr
c8gXxgf6AuE6XADmG7si7aHqwcDMJZ+rEPI+I8QDNKz/fJNr65aBbaPl5xrosoaF
gs7CLIEdNshApxvMrB/2AffUwvv8CJYeWjCGtjKZAi5rjM0V0bVomsUEdDMoFlhy
QijVpTOfdY77vZIsjcDWuDA8wfIni6yfFQ4g4Rpnj86qVROK777vzdKkrywqrdtK
ntxM5SK1kWAiD1ulurJ6CgW3tYy7mVFM4pFwEXWmjm8kUmMe9OyQlll7HjUVsxgT
cLQVsVWa64qyZx2etIJLGiQY7cT/6eI+v+9EmxdqEhnUngdLjpawe+Eld3wTffld
rRDnZF8n/R2P0SZbiEPHzqGxMF0sOw==
=xLx3
-----END PGP SIGNATURE-----

--F7RAaeNOJ2iI4bk5--


--===============3623419014651007940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3623419014651007940==--

