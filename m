Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5637C433F5
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 14:33:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7323A61BF5
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 14:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7323A61BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CA80607F0;
	Tue, 16 Nov 2021 14:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8jQrxyTLJqX; Tue, 16 Nov 2021 14:33:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BA72E605EB;
	Tue, 16 Nov 2021 14:33:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89ED6C002E;
	Tue, 16 Nov 2021 14:33:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21F4FC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0106C40412
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:33:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Z81RVbHvh76
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:33:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2603401B2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 14:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637073210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e5bI5miZtE31XzDT/uNmoUa6s8KHDiRkZC5V/D8t8c4=;
 b=UOYRE8exzC2Dbx6acKkzgOvYsnzDcRN2RBqllD0V7i/svsQ36DT6kPnDtuuesk6+5GMaRJ
 DjoG1FXPfUc4bnl+dP+1Mmp/J/Uo0JAoPzp7q5vJhA1pNoyyDNm4O0wxiC6HZAGIgKR92u
 AHTGxg4wx/jOnI3fiaM0BeXQXbWKp6U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-WetUyzD4PJS7PQvgLhXWtA-1; Tue, 16 Nov 2021 09:33:28 -0500
X-MC-Unique: WetUyzD4PJS7PQvgLhXWtA-1
Received: by mail-ed1-f69.google.com with SMTP id
 v22-20020a50a456000000b003e7cbfe3dfeso5199672edb.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 06:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e5bI5miZtE31XzDT/uNmoUa6s8KHDiRkZC5V/D8t8c4=;
 b=AeXMDuYsjW0n7ilRWJ5S90vjmkLxedmpnoYV4tVuAkYvx6stloQcFZ4lVCGdnOAony
 bB/0JBMfPj+gU0qc4n7RgKBFRnjlMndMAQgUZJZ+rWgeMrtZjdsvUtWH1qC6//hBBiJR
 ontAZbus3O5fWiV8tqBYrJc1V31YPF/0g38XAPIjV9wKkN1v39m3g7TmYysqfbjkdea4
 wqk4ccX7qB4N+goo2on3CWwWsE6pwBTGUVTA/tPiKYS06hMRWAdtvFEdzpx+wbUU/G+3
 +y+6uq7OJFXvWJ6GDbXmsKl92Ejh7dU4KDRtWpEmrTLXvKYtBv4ldLSe7qO/icrSf5AK
 ZH8w==
X-Gm-Message-State: AOAM533TXBmZAmm16oAz5+tpxCWAUi74BrMlHd6XVh7avfgJxtwtLgOO
 8eZ1E8rvHEstTbmkZ+7pk4c2/M5XU6mOwmLaig/3sOp1rZ1bVIzL+WXKbZktPpYLIo2P8huGtGR
 Rrh+3qmr5o7V6kQHo3N1PNreyuML3za+QgtpT/goPog==
X-Received: by 2002:a05:6402:4255:: with SMTP id
 g21mr10631422edb.256.1637073207831; 
 Tue, 16 Nov 2021 06:33:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwc5owemSfBUpNeotKB3UAbjc+AN7gGsaiauGNpfHdqICsObV5qFX6XIBKC3Eh9ctsxyL6amg==
X-Received: by 2002:a05:6402:4255:: with SMTP id
 g21mr10631390edb.256.1637073207612; 
 Tue, 16 Nov 2021 06:33:27 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id jx10sm4918812ejc.102.2021.11.16.06.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 06:33:27 -0800 (PST)
Date: Tue, 16 Nov 2021 15:33:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Ryabinin <arbn@yandex-team.com>,
 Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/6] vhost: get rid of vhost_poll_flush() wrapper
Message-ID: <20211116143323.g7c27u2ho4vpp4cp@steredhat>
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

Adding Mike since these changes could be relevant for "[PATCH V4 00/12] 
vhost: multiple worker support" [1] series.

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

We should remove also the declaration in vhost.h:

--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -45,7 +44,6 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
                      __poll_t mask, struct vhost_dev *dev);
  int vhost_poll_start(struct vhost_poll *poll, struct file *file);
  void vhost_poll_stop(struct vhost_poll *poll);
-void vhost_poll_flush(struct vhost_poll *poll);
  void vhost_poll_queue(struct vhost_poll *poll);
  void vhost_work_dev_flush(struct vhost_dev *dev);


> void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> {
> 	if (!dev->worker)
>@@ -663,7 +655,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
> 	for (i = 0; i < dev->nvqs; ++i) {
> 		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
> 			vhost_poll_stop(&dev->vqs[i]->poll);
>-			vhost_poll_flush(&dev->vqs[i]->poll);
>+			vhost_work_dev_flush(dev->vqs[i]->poll.dev);
> 		}
> 	}
> }
>@@ -1712,7 +1704,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> 	mutex_unlock(&vq->mutex);
>
> 	if (pollstop && vq->handle_kick)
>-		vhost_poll_flush(&vq->poll);
>+		vhost_work_dev_flush(vq->poll.dev);
> 	return r;
> }
> EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 938aefbc75ec..b0361ebbd695 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -711,7 +711,7 @@ static void vhost_vsock_flush(struct vhost_vsock *vsock)
>
> 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++)
> 		if (vsock->vqs[i].handle_kick)
>-			vhost_poll_flush(&vsock->vqs[i].poll);
>+			vhost_work_dev_flush(vsock->vqs[i].poll.dev);
> 	vhost_work_dev_flush(&vsock->dev);
> }
>
>-- 
>2.32.0
>

The rest LGTM.

Thanks,
Stefano

[1] 
https://lore.kernel.org/virtualization/20211104190502.7053-1-michael.christie@oracle.com/

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
