Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268D0C77B75
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 14:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7654660B9E;
	Tue, 23 May 2023 14:54:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7654660B9E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i+51YwHQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2_GQINOOFY0Q; Tue, 23 May 2023 14:54:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 09CC760BA9;
	Tue, 23 May 2023 14:54:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 09CC760BA9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA726C0035;
	Tue, 23 May 2023 14:54:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFACEC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 14:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABF6C40B54
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 14:54:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABF6C40B54
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i+51YwHQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d86PC50hONG2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 14:54:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2C4B40A8B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2C4B40A8B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684853655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XzmSpxQsa2CTLr4rwU0KMIUjwE1e290Moluru4LsCWQ=;
 b=i+51YwHQqeDuhjq6wbuiMqh/tMYVpy5JjTUjGzq5XkzJKlefDUaxb1UThcXE8/i2qCKsIq
 L4T7Q/qMowrXwCFB51w2hgSDd4hETqNeorCe2RoaFEF9GE0eFlT3WFEaMq7ubYm6gZfmRh
 Gru6Ai0WMpC2N4oojBWVRRUKCevKOvY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-mUSSqk5HM5eMLmKx9zzTeA-1; Tue, 23 May 2023 10:54:14 -0400
X-MC-Unique: mUSSqk5HM5eMLmKx9zzTeA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30634323dfeso3187445f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 07:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684853652; x=1687445652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzmSpxQsa2CTLr4rwU0KMIUjwE1e290Moluru4LsCWQ=;
 b=hO34ZYW5eSM0GuWqqMODMbJPmRX2i6ppS+uIqXaEA0Cv7U3Comp6jhrgbGh+JLPGSX
 ZxLzqJVf0B/2n1oeJ9c1YBTNAWlGIf1KGU/BJH8SSf/MaWfcLEyU9x+TYK9hKhbrQGL2
 ++XJUly6dLdgO2EI+KCLm9tk7BScXQ8cFNNopijP3tSHPySuPxnHtzjQgYoU0jIKb5py
 zYBB0bHcFGBCtchVn7GPmvW82QjwdYK+31a5jDnH574iniSEj39uZqtuVHQbPfnxlKVS
 0htdHDKuko3MhMjZepRLe7vkvOQNKIi68kX7z0Url4t9i0SPDO3jHXxEdVXO6AU43u2z
 BMJQ==
X-Gm-Message-State: AC+VfDxTFXPRyMEVeoD/OGqY4bnucpCAYCa9mcpt9yIeQiWrx1KHnYwW
 ueKqi2ce+d3b9QPLd601LDO8WLYs/8vKrLeDSysoV5vu5pvl9A9xnC/xhxJvRudnik3HY6/WzdU
 poldWK8yYNXyd4gJFWsKsbHVrTw9FBolxh/m3EMkMeg==
X-Received: by 2002:a5d:4707:0:b0:306:31e0:964 with SMTP id
 y7-20020a5d4707000000b0030631e00964mr9243302wrq.55.1684853652814; 
 Tue, 23 May 2023 07:54:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4s9KcYtaMvwy+5Pq6aNhocIKn4SglN2/iLOvifbgaQZ0TrNWZdT1Hfp3EtsXRoATqppHcvZw==
X-Received: by 2002:a5d:4707:0:b0:306:31e0:964 with SMTP id
 y7-20020a5d4707000000b0030631e00964mr9243289wrq.55.1684853652535; 
 Tue, 23 May 2023 07:54:12 -0700 (PDT)
Received: from sgarzare-redhat ([89.42.5.88]) by smtp.gmail.com with ESMTPSA id
 g9-20020adffc89000000b002e5ff05765esm11359411wrr.73.2023.05.23.07.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 07:54:12 -0700 (PDT)
Date: Tue, 23 May 2023 16:54:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Prathu Baronia <prathubaronia2011@gmail.com>
Subject: Re: [PATCH] vhost: use kzalloc() instead of kmalloc() followed by
 memset()
Message-ID: <5kn47peabxjrptkqa6dwtyus35ahf4pcj4qm4pumse33kxqpjw@mec4se5relrc>
References: <20230522085019.42914-1-prathubaronia2011@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20230522085019.42914-1-prathubaronia2011@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, May 22, 2023 at 02:20:19PM +0530, Prathu Baronia wrote:
>Use kzalloc() to allocate new zeroed out msg node instead of
>memsetting a node allocated with kmalloc().
>
>Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
>---
> drivers/vhost/vhost.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index a92af08e7864..579ecb4ee4d2 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2575,12 +2575,11 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
> /* Create a new message. */
> struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
> {
>-	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>+	/* Make sure all padding within the structure is initialized. */
>+	struct vhost_msg_node *node = kzalloc(sizeof(*node), GFP_KERNEL);
> 	if (!node)
> 		return NULL;
>
>-	/* Make sure all padding within the structure is initialized. */
>-	memset(&node->msg, 0, sizeof node->msg);

the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 	node->vq = vq;
> 	node->msg.type = type;
> 	return node;
>
>base-commit: 4d6d4c7f541d7027beed4fb86eb2c451bd8d6fff
>-- 
>2.34.1
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
