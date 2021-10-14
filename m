Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A766C433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 02:33:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF02D610E7
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 02:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF02D610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B65AB60896;
	Thu, 14 Oct 2021 02:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iHYkDQYWq0Qw; Thu, 14 Oct 2021 02:33:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5ABAA6084D;
	Thu, 14 Oct 2021 02:33:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34C83C000F;
	Thu, 14 Oct 2021 02:33:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84A45C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B1EB60887
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IvCNk83v8-El
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:33:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C63D96084D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634178789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P9syLy/5lFT2IgnWtiCBBV/6jUpNv+u7xCyBw4FzVlk=;
 b=UPnd6UtfTui5gzIdOM0qZnp5wYHP8yNMDbRrTTUkMcTwmVUdtFOty9c65rohFpZIObWTiv
 mjxTdHPHL904aqbbQWGmycgkHVxD4TP+q2fDJ/bqeJELwL4cnf5fC5V4p2vfulvehiuGfn
 XxKpLCS33sHKridXg77dF/ZbHpsiwdY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-cXwmz_haMQ6kK5_Zk3y6ew-1; Wed, 13 Oct 2021 22:33:08 -0400
X-MC-Unique: cXwmz_haMQ6kK5_Zk3y6ew-1
Received: by mail-lf1-f69.google.com with SMTP id
 c6-20020a05651200c600b003fc6d39efa4so3328380lfp.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 19:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P9syLy/5lFT2IgnWtiCBBV/6jUpNv+u7xCyBw4FzVlk=;
 b=ckCyZ8OGPA9JyvU52LfKdBIN5whJKxZR7pR9v4PB5Lu5HVnHPEeI6zFR6EpPad98SS
 qOAbg4o04UsOgp7QKsez53cFXCUq5LX5lxpJock7AoVFeoSDNZs0q4uCJtjgHIsjNd5s
 AiPinYZ07IINfrKQ1SzIrK64ghs5PDDRr7UZehY+x1K5UbbPRAZSDEg/2EO7dtFhA85+
 j2k6Y4Cp6MnzogiMg75cmQ33eycOUQqxha6wpFVBw5Uiza6l4JeJnvw3PBnTNPyjBAS0
 y747nrqRDJq4Q2wO5Fmt+wlBwEYml5KeXbcoYnGROuxDn8lYGLO9vGZnRDHaVJON7PkR
 8gDg==
X-Gm-Message-State: AOAM533JFejZDH4IksXSM9X9+6Ehjr5r1xrtegG+NifGAV3NbZczIlhD
 Mum3Ee6jRFws8TFxrv1LkGB5mHin5yHUY2q4h3K4ystc/R1KD/sple4aHvaZ/BuPr1DqRufyfGO
 MnaPkGoExq1ToH2rc+Lgm2cfw/5udCqirVRpDP7LxOwG9VUuwHC+qvARmFg==
X-Received: by 2002:a2e:8099:: with SMTP id i25mr3210313ljg.277.1634178787258; 
 Wed, 13 Oct 2021 19:33:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf3YgJ//fIl53fImLAabG4WgjCSQL4ncBCHKGjYUsyRMheyzyU8vNl+89MVuLRmlHLKUWqwEmhcjG6EPGYqPM=
X-Received: by 2002:a2e:8099:: with SMTP id i25mr3210300ljg.277.1634178787098; 
 Wed, 13 Oct 2021 19:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-3-jasowang@redhat.com>
 <20211013060808-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013060808-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Oct 2021 10:32:54 +0800
Message-ID: <CACGkMEvzkomOzeQLEE91v79dRY_CtzUJMHTvUeg3Zt7R1J-QTw@mail.gmail.com>
Subject: Re: [PATCH V2 02/12] virtio: add doc for validate() method
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Oct 13, 2021 at 6:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:52:17PM +0800, Jason Wang wrote:
> > This patch adds doc for validate() method.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> And maybe document __virtio_clear_bit : it says
> "for use by transports" and now it's also legal in the
> validate callback.

Ok, let me do that in v3.

Thanks

>
> > ---
> >  include/linux/virtio.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 41edbc01ffa4..0cd8685aeba4 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -152,6 +152,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
> >   * @feature_table_size: number of entries in the feature table array.
> >   * @feature_table_legacy: same as feature_table but when working in legacy mode.
> >   * @feature_table_size_legacy: number of entries in feature table legacy array.
> > + * @validate: optional function to do early checks
> >   * @probe: the function to call when a device is found.  Returns 0 or -errno.
> >   * @scan: optional function to call after successful probe; intended
> >   *    for virtio-scsi to invoke a scan.
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
