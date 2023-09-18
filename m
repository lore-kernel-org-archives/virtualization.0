Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29132CD37B0
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 12:50:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A953781E81;
	Mon, 18 Sep 2023 12:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A953781E81
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I1/EF4TC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dxLJAEew_5lQ; Mon, 18 Sep 2023 12:50:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2CAA081E21;
	Mon, 18 Sep 2023 12:50:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2CAA081E21
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FA92C0039;
	Mon, 18 Sep 2023 12:50:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE7F1C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 12:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A9FC418E8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 12:50:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A9FC418E8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=I1/EF4TC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OfRWKy8NjMnC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 12:50:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B09B9418D7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 12:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B09B9418D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695041415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CEQqSlWB5iN4GuzRRQx0AqTTb5cOZLoq5svJf8PzKVg=;
 b=I1/EF4TCYQaNkXhvD7qlmoC/SWGOeHKDX0BOw89BPOeeMdj9wObyOIso0v/XD9v5okAi0b
 TMxF+iUTn2qkfc2fGZfZBDZ9lW+/dqXWazXw2tND2VEEtH7C+98YHJ/5h6LnSoStNnrT44
 bPgP8npIqMU0S5d2G8Iy9VEFi4fAlw0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-JLn8Q3hLPIy5J2OPnDsYuw-1; Mon, 18 Sep 2023 08:50:14 -0400
X-MC-Unique: JLn8Q3hLPIy5J2OPnDsYuw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76ef92fadefso603305685a.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 05:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695041414; x=1695646214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEQqSlWB5iN4GuzRRQx0AqTTb5cOZLoq5svJf8PzKVg=;
 b=l44TMpLJR+xaT6PiJNqcnleH3dZoUCLm9mc12NBYTWNW/j1RWu8tBnWVTdoYTDMqF3
 0+8sx5LSJE0xzFoxALZDZMmq3WItRCGj0u4zEHGFQnRkWNNCrUCppWqgwJF9aWuPCRby
 sqyZ8Ufami16bMMJvC4je+V3XqHrI85hR8UZMT0KXeb/0VQRgCZiI01QjcvQP6tB3y3+
 NlLNvxG/n5YKhIkq0yS9IrHoKm4GIvzwhDkW38yCA4x2jtx9JZg9ev5zGDo6fJgRJXrH
 LZrVtDgUzXLezD+5mmSAdr1V6zhYPxDYW0I0DPhP1GCdiJGnwA5gKtSqyV5f0JkKRJ+w
 7tIA==
X-Gm-Message-State: AOJu0YxuQe7kZkjHXPHalT++YJpjtaGxbeerO7hA0uqP5yXuBOq0Vb0a
 zD9OwUta66cTCVy44qNWoGb7hbiCHRDSk2UHMOSMp/1m3AmL6DMCu9YAhBZd/GdGVXxSf0Era7l
 SIrvjlB6xTb58p+tCJg2eb1xzJ2Z0YPS13OjMk9/aJA==
X-Received: by 2002:a05:620a:3882:b0:767:954:a752 with SMTP id
 qp2-20020a05620a388200b007670954a752mr7439371qkn.73.1695041413865; 
 Mon, 18 Sep 2023 05:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9TKs7icWb1phO/bVGBoVdZHvcWFAxCSS0tqtIaZEIZZxjH/ojh4x/vq7/QDkT4CyOT2czvg==
X-Received: by 2002:a05:620a:3882:b0:767:954:a752 with SMTP id
 qp2-20020a05620a388200b007670954a752mr7439359qkn.73.1695041413664; 
 Mon, 18 Sep 2023 05:50:13 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a05620a038900b007713659adeasm3130938qkm.63.2023.09.18.05.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 05:50:13 -0700 (PDT)
Date: Mon, 18 Sep 2023 14:50:09 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [virtio-comment] virtio-sound linux driver conformance to spec
Message-ID: <ZQhHgTxoUAnfYaiC@fedora>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <CABgObfbXsHN6=ZmL0s+mtCypXs11LNECECO3Uud_J6PMr+JwNA@mail.gmail.com>
 <CAAjaMXbjRn27fpZHK982m4MyJGXWQTR99WHPAZQfcun+pe3GBw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAjaMXbjRn27fpZHK982m4MyJGXWQTR99WHPAZQfcun+pe3GBw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
 Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, Sep 13, 2023 at 06:58:30PM +0300, Manos Pitsidianakis wrote:
> Hello Matias,
> 
> Please show and refer to code snippets from the kernel tree that you
> think are related to your question. It'd help us make sure we all talk
> about the same thing.
> 

In this discussion, I am referring to the way in which the virtio-sound
driver is manipulating buffers that have been consumed by the device,
e.g., used-ring in the tx queue. My understanding is the driver builds a
ring-buffer that is shared with the user application in the guest. As
soon as the device returns a buffer to the used ring, the driver puts
the request in the available ring again. This is my understanding from
sound/virtio/virtio_pcm_msg.c#L324. The user application updates the
content of the buffer at sound/virtio/virtio_pcm_msg.c#L322, but this
task is deferred by using schedule_work(). The update of the buffer may
happen once the buffers are already in the available ring.

Thanks, Matias.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
