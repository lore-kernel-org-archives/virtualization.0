Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2758FC678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 14:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A417E404F7;
	Wed,  8 Mar 2023 14:07:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A417E404F7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RgVDlV8x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1IZzuyBHqEvv; Wed,  8 Mar 2023 14:07:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2D83A40C84;
	Wed,  8 Mar 2023 14:07:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D83A40C84
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04786C0071;
	Wed,  8 Mar 2023 14:07:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83BB2C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49CD860E3F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:07:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 49CD860E3F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RgVDlV8x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9CCJoj0X14-9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:07:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 454AB60C09
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 454AB60C09
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678284440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V6cnINXPKnD2lG8vxbE8F7RlXvTWARojvYuwDfsphHk=;
 b=RgVDlV8xhnONZDDJqmGIv5wGxz6lR64KO7h7ojewT+tzQzXU3UzJANZ6y8G8hNUQsHJ9jE
 u1MwZVjHZ42n3hFBPmguFRtuUgRXzaX6GNuoeERABbgmtCrCDgK/pJH7Jsq+DuyDWgZECe
 Q0aIHR29MLHA0dhWwweT5Dc/CiYki9w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-rMAQiYIINVyGxFUmo4hpUA-1; Wed, 08 Mar 2023 09:07:16 -0500
X-MC-Unique: rMAQiYIINVyGxFUmo4hpUA-1
Received: by mail-qt1-f197.google.com with SMTP id
 l2-20020ac87242000000b003bfecc6d046so9150982qtp.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Mar 2023 06:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678284429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6cnINXPKnD2lG8vxbE8F7RlXvTWARojvYuwDfsphHk=;
 b=8AA/sQHu5zQ4Y6JDY9aMC1qZjgbJ4yewf6utpsVlYNUXAuXAdgK9aTMUfgjKdQC4Ep
 fdUbJzqeDyqmxIMZQkhGKYrPT6gGLI2c1ZvDwsKmVJxVF+uvF8FfLLlbJEqm/hNBOqdk
 Pr4L6zVfVxshaOrLaKsCqJw5iEwQVt/wKSYr0l3XWvW2iAM54H6XqDrU9uoeSDKnQZBO
 8Jv6hFxsjNMj4x2+Q0FDiZ9MPLhoAwtlvC667BTaSudMlflTDfpYUGQhBW0QVN8dkWrh
 HVQB/ni0lD5jtOJCFcNu6mL5nMhZ3l6vQ7jtmDTZrpKdfOyUSl8N9Qv+95pIWBnBl9Vo
 VR8w==
X-Gm-Message-State: AO0yUKVf+F4Xje4/OJRMsdPl0Y9BUS8lwrL3Vw88j/XWgjcNV3KLd7TO
 mmX+N8bCPTHZZUOnKgy4Gko/xlNWru+Nwyon+LCIGHGvWKE0veMh4fZPW07IGU4SQ/YwEoIdkS+
 ZkLSjVl/xvaQBHQnnvj5vuLi0E7t5r/S7LS0H82YHzg==
X-Received: by 2002:a05:622a:514:b0:3b9:bc8c:c213 with SMTP id
 l20-20020a05622a051400b003b9bc8cc213mr38252435qtx.30.1678284429137; 
 Wed, 08 Mar 2023 06:07:09 -0800 (PST)
X-Google-Smtp-Source: AK7set+bnIm7lfXZMPMGp+YTM6UrwsXhtqFanRzxTP/WHmpltxuwqtKd97gRjNlbA6Fwv+mkWztPJw==
X-Received: by 2002:a05:622a:514:b0:3b9:bc8c:c213 with SMTP id
 l20-20020a05622a051400b003b9bc8cc213mr38252394qtx.30.1678284428852; 
 Wed, 08 Mar 2023 06:07:08 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 x185-20020a3763c2000000b0073baa5ec0besm11506824qkb.115.2023.03.08.06.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Mar 2023 06:07:08 -0800 (PST)
Date: Wed, 8 Mar 2023 15:07:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] virtio: Reorder fields in 'struct virtqueue'
Message-ID: <20230308140704.jsggcp4g3tz7vhxu@sgarzare-redhat>
References: <8f3d2e49270a2158717e15008e7ed7228196ba02.1676707807.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
In-Reply-To: <8f3d2e49270a2158717e15008e7ed7228196ba02.1676707807.git.christophe.jaillet@wanadoo.fr>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

On Sat, Feb 18, 2023 at 09:10:31AM +0100, Christophe JAILLET wrote:
>Group some variables based on their sizes to reduce hole and avoid padding.
>On x86_64, this shrinks the size of 'struct virtqueue'
>from 72 to 68 bytes.
>
>It saves a few bytes of memory.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>---

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>Using pahole
>
>Before:
>======
>struct virtqueue {
>	struct list_head           list;                 /*     0    16 */
>	void                       (*callback)(struct virtqueue *); /*    16     8 */
>	const char  *              name;                 /*    24     8 */
>	struct virtio_device *     vdev;                 /*    32     8 */
>	unsigned int               index;                /*    40     4 */
>	unsigned int               num_free;             /*    44     4 */
>	unsigned int               num_max;              /*    48     4 */
>
>	/* XXX 4 bytes hole, try to pack */
>
>	void *                     priv;                 /*    56     8 */
>	/* --- cacheline 1 boundary (64 bytes) --- */
>	bool                       reset;                /*    64     1 */
>
>	/* size: 72, cachelines: 2, members: 9 */
>	/* sum members: 61, holes: 1, sum holes: 4 */
>	/* padding: 7 */
>	/* last cacheline: 8 bytes */
>};
>
>After:
>=====
>struct virtqueue {
>	struct list_head           list;                 /*     0    16 */
>	void                       (*callback)(struct virtqueue *); /*    16     8 */
>	const char  *              name;                 /*    24     8 */
>	struct virtio_device *     vdev;                 /*    32     8 */
>	unsigned int               index;                /*    40     4 */
>	unsigned int               num_free;             /*    44     4 */
>	unsigned int               num_max;              /*    48     4 */
>	bool                       reset;                /*    52     1 */
>
>	/* XXX 3 bytes hole, try to pack */
>
>	void *                     priv;                 /*    56     8 */
>
>	/* size: 64, cachelines: 1, members: 9 */
>	/* sum members: 61, holes: 1, sum holes: 3 */
>};
>---
> include/linux/virtio.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>index 6ac2655500dc..9439ae898310 100644
>--- a/include/linux/virtio.h
>+++ b/include/linux/virtio.h
>@@ -35,8 +35,8 @@ struct virtqueue {
> 	unsigned int index;
> 	unsigned int num_free;
> 	unsigned int num_max;
>-	void *priv;
> 	bool reset;
>+	void *priv;
> };
>
> int virtqueue_add_outbuf(struct virtqueue *vq,
>-- 
>2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
