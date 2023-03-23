Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CE0C6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 09:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99F45614CC;
	Thu, 23 Mar 2023 09:29:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99F45614CC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZAKmfFKN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2M3w-lL40bpt; Thu, 23 Mar 2023 09:29:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3441C60B46;
	Thu, 23 Mar 2023 09:29:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3441C60B46
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18C99C0071;
	Thu, 23 Mar 2023 09:29:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5243AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C438402CA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:29:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C438402CA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZAKmfFKN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xAw4Rv3DFwag
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:29:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31D63400BD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31D63400BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679563755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fH6RVdKUD2qMc5iJ7El8bayWDBifjWMzYWs3C5XGkao=;
 b=ZAKmfFKNfVMwsJwc8+GOAA/JJP8sHbDGummGxCbREMzmw4iyBo/dD8oOU8zdr82LwDqTXF
 QJq4ikwjiHVebQ4aW4SaA+AkJHC8NffVzhCrvwB5ZglD0HFVCagfuh3c+LZveKMOs64Ecr
 gb0cFi95GdreVGubqTOkhhUwv3OoL5o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-ZFaJ46ahNjavWav9t4vWgA-1; Thu, 23 Mar 2023 05:29:13 -0400
X-MC-Unique: ZFaJ46ahNjavWav9t4vWgA-1
Received: by mail-qt1-f198.google.com with SMTP id
 c14-20020ac87d8e000000b003e38726ec8bso4088579qtd.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679563753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fH6RVdKUD2qMc5iJ7El8bayWDBifjWMzYWs3C5XGkao=;
 b=tHhF7JZRlHH7jGYdYRiDHFP5m4b+fWSNA1XKhg7eWYI0oVoGacE9GRKTGP7gxPd5Kw
 3+jQz+7qtsZn5jory3hIXjOPTet9yo0mtErn/FiOhKTy3bBd/5F4s9Ukek+hffAAe5jO
 f2DR1VpUUe8bAdsCPwKxucTpLxfu81Ez14Kt0uE95kn42ZradBbGKq1+7xW5n9zpiJIx
 TnIuH5pZQ7rNXq+sLFlV01QCKEucxgwXgL9HHqMoe99DPdUCxbDeMGJ7A3bm5Vc3DFrM
 tcYzoy8ICOUQj1Vknh2wiwI3NRW66XQ9CEHtRu9yNJ7cvuCzJDPRCDxXwdaq/MvHkZgK
 GpHg==
X-Gm-Message-State: AO0yUKXHptkk+q5GS+i0E4jEj3kekHYi14WUjJ69KCfM8wQDqo0yB0Vz
 4+icRFUEfBAVqY2zOtAsaTK6vsRu8rdg84JByW/t+s88LuUwan9/yvfhLjou6pol5S+hlB06Rzp
 pr+1pj51zYr37fhmL0rHvJIDrQ123y8bX8oGufjlHVg==
X-Received: by 2002:a05:622a:34e:b0:3e1:9557:123c with SMTP id
 r14-20020a05622a034e00b003e19557123cmr9437366qtw.52.1679563753150; 
 Thu, 23 Mar 2023 02:29:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set+dTXZSkoRXA666MxWsVBLAIywm8KzMAVacD1thH1ce+YO4OCqSzCTtD2lH0cRCelCFnUU+cQ==
X-Received: by 2002:a05:622a:34e:b0:3e1:9557:123c with SMTP id
 r14-20020a05622a034e00b003e19557123cmr9437356qtw.52.1679563752860; 
 Thu, 23 Mar 2023 02:29:12 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 o10-20020a05620a228a00b007441b675e81sm12893452qkh.22.2023.03.23.02.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 02:29:12 -0700 (PDT)
Date: Thu, 23 Mar 2023 10:29:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 2/2] virtio/vsock: check argument to avoid no
 effect call
Message-ID: <20230323092905.fpsiiaca2ba2wug3@sgarzare-redhat>
References: <f0b283a1-cc63-dc3d-cc0c-0da7f684d4d2@sberdevices.ru>
 <50bb0210-1ed7-42fb-b5f6-8d97247209b5@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <50bb0210-1ed7-42fb-b5f6-8d97247209b5@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Wed, Mar 22, 2023 at 09:36:24PM +0300, Arseniy Krasnov wrote:
>Both of these functions have no effect when input argument is 0, so to
>avoid useless spinlock access, check argument before it.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 9e87c7d4d7cf..312658c176bd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -302,6 +302,9 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
> 	u32 ret;
>
>+	if (!credit)
>+		return 0;
>+
> 	spin_lock_bh(&vvs->tx_lock);
> 	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (ret > credit)
>@@ -315,6 +318,9 @@ EXPORT_SYMBOL_GPL(virtio_transport_get_credit);
>
> void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
>+	if (!credit)
>+		return;
>+
> 	spin_lock_bh(&vvs->tx_lock);
> 	vvs->tx_cnt -= credit;
> 	spin_unlock_bh(&vvs->tx_lock);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
