Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB3C433EF
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 14:41:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983C063219
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 14:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 983C063219
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 540C8401B9;
	Tue, 16 Nov 2021 14:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PowW9LJ43Pqc; Tue, 16 Nov 2021 14:41:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1F7D40189;
	Tue, 16 Nov 2021 14:41:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85BB5C002E;
	Tue, 16 Nov 2021 14:41:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4C58C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2FE7401B9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:41:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jIa-mDNL_RfV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:41:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D261240189
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637073685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AfHc271RXOUnz4mYvex1noJIxI7ZHKxUfmBIzMbPzoE=;
 b=iPAQuoLAgIFKF32cXr6pC+7DmO4BOT/c3Bx82OAq8x68XvsDlEgFPzF+f6hwfm7Ruix08k
 w2GRV1Jg/CCbPIciXFdJojbgGu8e3PiPjIdKOvxO0VMFaI0cPi378OnqZvuWh9SOgEGfIQ
 +2i682iPuNB42P85Te9OqXaV5rcMOjc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-aQ-P2LrdN4SImlVhLX0aQw-1; Tue, 16 Nov 2021 09:41:24 -0500
X-MC-Unique: aQ-P2LrdN4SImlVhLX0aQw-1
Received: by mail-ed1-f72.google.com with SMTP id
 m8-20020a056402510800b003e29de5badbso17361782edd.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 06:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AfHc271RXOUnz4mYvex1noJIxI7ZHKxUfmBIzMbPzoE=;
 b=Vnn6ObCuLXiAiRgP0yD6yEeYCqAEJTiV6OuuteDv1l2xLyN1v2OzEwc8hAu7mIE1WX
 JdKcSKvogtP0HxanOikUn4OkaAJOOXkSAIeKpZaNm99BkP8JKyhGdFJekhoXaHKmZv26
 6uYgXY9dzrYAzMjtTJPfytOd/N1CNJyzUJNvyMlDTKS3Kj96mkmrgM0UTN5Xefm6p9tN
 0iNvOVZ1ZxaaihlRv96cN8lU0jEK8+vaPL7nvDeCDRIVDOeShfFKZ5eSVMi6qcE739+E
 We3B90ceHz8L3AazbTHIIJmTSyUhHphUZr8/z4txTfw0nGPUoulXuUPVLBo/Noic5lS6
 6hCg==
X-Gm-Message-State: AOAM531ImUlc2qvLKWEvn/7VOdL21IB4peLFugCsyRQy/RKnDBVMdoSF
 ITxwBAkUUM7cIhOo9IFkH3VghzDgcOkHnnvchE71kJ478W5PF6Kj89KT0qMSls4Ze9xy3R4Bhlx
 kFPu43gvBQrld5wzjngN7sANP+cdied5lkprTT+PKvQ==
X-Received: by 2002:a50:f18a:: with SMTP id x10mr10933212edl.193.1637073683466; 
 Tue, 16 Nov 2021 06:41:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB2sbwGvYxWKbC+UMKYgg2LVMQ3q254bvGdk6QiC2h+UbWm6XEbEkZoXht5LV0mMQvzs1Y0Q==
X-Received: by 2002:a50:f18a:: with SMTP id x10mr10933184edl.193.1637073683291; 
 Tue, 16 Nov 2021 06:41:23 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id hv13sm8368872ejc.75.2021.11.16.06.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 06:41:22 -0800 (PST)
Date: Tue, 16 Nov 2021 15:41:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Ryabinin <arbn@yandex-team.com>
Subject: Re: [PATCH 1/6] vhost: get rid of vhost_poll_flush() wrapper
Message-ID: <20211116144119.56ph52twuyc4jtdr@steredhat>
References: <20211115153003.9140-1-arbn@yandex-team.com>
MIME-Version: 1.0
In-Reply-To: <20211115153003.9140-1-arbn@yandex-team.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 15, 2021 at 06:29:58PM +0300, Andrey Ryabinin wrote:
>vhost_poll_flush() is a simple wrapper around vhost_work_dev_flush().
>It gives wrong impression that we are doing some work over vhost_poll,
>while in fact it flushes vhost_poll->dev.
>It only complicate understanding of the code and leads to mistakes
>like flushing the same vhost_dev several times in a row.
>
>Just remove vhost_poll_flush() and call vhost_work_dev_flush() directly.
>
>Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
>---
> drivers/vhost/net.c   |  4 ++--
> drivers/vhost/test.c  |  2 +-
> drivers/vhost/vhost.c | 12 ++----------
> drivers/vhost/vsock.c |  2 +-
> 4 files changed, 6 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>index 28ef323882fb..11221f6d11b8 100644
>--- a/drivers/vhost/net.c
>+++ b/drivers/vhost/net.c
>@@ -1375,8 +1375,8 @@ static void vhost_net_stop(struct vhost_net *n, struct socket **tx_sock,
>
> static void vhost_net_flush_vq(struct vhost_net *n, int index)
> {
>-	vhost_poll_flush(n->poll + index);
>-	vhost_poll_flush(&n->vqs[index].vq.poll);
>+	vhost_work_dev_flush(n->poll[index].dev);
>+	vhost_work_dev_flush(n->vqs[index].vq.poll.dev);
> }
>
> static void vhost_net_flush(struct vhost_net *n)
>diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
>index a09dedc79f68..1a8ab1d8cb1c 100644
>--- a/drivers/vhost/test.c
>+++ b/drivers/vhost/test.c
>@@ -146,7 +146,7 @@ static void vhost_test_stop(struct vhost_test *n, void **privatep)
>
> static void vhost_test_flush_vq(struct vhost_test *n, int index)
> {
>-	vhost_poll_flush(&n->vqs[index].poll);
>+	vhost_work_dev_flush(n->vqs[index].poll.dev);
> }
>
> static void vhost_test_flush(struct vhost_test *n)
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 59edb5a1ffe2..ca088481da0e 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -245,14 +245,6 @@ void vhost_work_dev_flush(struct vhost_dev *dev)
> }
> EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
>
>-/* Flush any work that has been scheduled. When calling this, don't hold any
>- * locks that are also used by the callback. */
>-void vhost_poll_flush(struct vhost_poll *poll)
>-{
>-	vhost_work_dev_flush(poll->dev);
>-}
>-EXPORT_SYMBOL_GPL(vhost_poll_flush);
>-
> void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> {
> 	if (!dev->worker)
>@@ -663,7 +655,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
> 	for (i = 0; i < dev->nvqs; ++i) {
> 		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
> 			vhost_poll_stop(&dev->vqs[i]->poll);
>-			vhost_poll_flush(&dev->vqs[i]->poll);
>+			vhost_work_dev_flush(dev->vqs[i]->poll.dev);

Not related to this patch, but while looking at vhost-vsock I'm 
wondering if we can do the same here in vhost_dev_stop(), I mean move 
vhost_work_dev_flush() outside the loop and and call it once. (In 
another patch eventually)

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
