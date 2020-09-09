Return-Path: <SRS0=pGqY=CS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067FAC43461
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 02:07:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8986A20758
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 02:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMd6+B8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8986A20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B52886E62;
	Wed,  9 Sep 2020 02:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ffme1OIl8W6; Wed,  9 Sep 2020 02:07:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 00BC986DF0;
	Wed,  9 Sep 2020 02:07:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE487C0859;
	Wed,  9 Sep 2020 02:07:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 313C4C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2703D8709D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5vUGgXNhKKek
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:06:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0CA0287097
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 02:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599617216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hetGJHzKmQX4NCLO2RauAhNQ86rD2R/wYZkTPA6dH3k=;
 b=aMd6+B8TWld8j39JpVqCnbQdH0u/z7Wo3BLgwYP1txKVxjW/WcrK0Vuv7iOxaCWnyeelZy
 niVTghSJ9uB5/k9IZ4zRq2wQ76rvhLQi5a4jJjp4+Z9D4cjMF+f/9/U/bcPRMNDHYJaQSp
 fQDlXTScaeaE980RfQN4Q4Agcmx/QuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-SA-GsSztMSGKQP9QCaubLg-1; Tue, 08 Sep 2020 22:06:53 -0400
X-MC-Unique: SA-GsSztMSGKQP9QCaubLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EBC2824FAB;
 Wed,  9 Sep 2020 02:06:52 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 064127E8CD;
 Wed,  9 Sep 2020 02:06:51 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id DFC2118095FF;
 Wed,  9 Sep 2020 02:06:51 +0000 (UTC)
Date: Tue, 8 Sep 2020 22:06:50 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Message-ID: <1815785246.16284907.1599617210463.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200907110335.GA121033@mtl-vdi-166.wap.labs.mlnx>
References: <20200907075136.GA114876@mtl-vdi-166.wap.labs.mlnx>
 <507166908.16038290.1599476003292.JavaMail.zimbra@redhat.com>
 <20200907110335.GA121033@mtl-vdi-166.wap.labs.mlnx>
Subject: Re: [PATCH] vdpa/mlx5: Setup driver only if VIRTIO_CONFIG_S_DRIVER_OK
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.30]
Thread-Topic: vdpa/mlx5: Setup driver only if VIRTIO_CONFIG_S_DRIVER_OK
Thread-Index: NIGZWNwiAp0eeznMYcEYZRw78nk6JA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



----- Original Message -----
> On Mon, Sep 07, 2020 at 06:53:23AM -0400, Jason Wang wrote:
> > 
> > 
> > ----- Original Message -----
> > > If the memory map changes before the driver status is
> > > VIRTIO_CONFIG_S_DRIVER_OK, don't attempt to create resources because it
> > > may fail. For example, if the VQ is not ready there is no point in
> > > creating resources.
> > > 
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5
> > > devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 9df69d5efe8c..c89cd48a0aab 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1645,6 +1645,9 @@ static int mlx5_vdpa_change_map(struct
> > > mlx5_vdpa_net
> > > *ndev, struct vhost_iotlb *
> > >  	if (err)
> > >  		goto err_mr;
> > >  
> > > +	if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +		return 0;
> > > +
> > 
> > I'm not sure I get this.
> > 
> > It looks to me if set_map() is called before DRIVER_OK, we won't build
> > any mapping?
> > 
> What would prevent that? Is it some qemu logic you're relying upon?

Ok, I think the map is still there, we just avoid to create some
resources.

> With current qemu 5.1 with lack of batching support, I get plenty calls
> to set_map which result in calls to mlx5_vdpa_change_map().
> If that happens before VIRTIO_CONFIG_S_DRIVER_OK then Imay fail (in case
> I was not called to set VQs ready).

Right, this could be solved by adding the batched IOTLB updating.

Thanks

> 
> > 
> > >  	restore_channels_info(ndev);
> > >  	err = setup_driver(ndev);
> > >  	if (err)
> > > --
> > > 2.26.0
> > > 
> > > 
> > 
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
