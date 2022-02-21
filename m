Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD46C433EF
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 13:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04D62404BE;
	Mon, 21 Feb 2022 13:59:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id woTF-Xrfd9nt; Mon, 21 Feb 2022 13:59:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6B9F540117;
	Mon, 21 Feb 2022 13:59:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38C3EC001A;
	Mon, 21 Feb 2022 13:59:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 596C7C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 13:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38EB340435
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 13:59:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iYTMr4UWKp9c
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 13:59:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D76540117
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645451977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSVIW7WKSNU5PqfuEaIi9kuilnpf4QQg552O4p0c0vg=;
 b=Vokr/A4fohDcKbA6ZR0nwGtofkFZt+UdAxvewAbmPgr7KnQUK+eBVNj/l+nLxvtj9Hf0X+
 8o/vSAYnOHMb8P73LsckGMivAk3jiEPsrGWBC7OYMiGsCsPyiRRz55W2dnQZkMAKaOl5Up
 sw/AxxIgkslViqRai2fxVEC+utoqSNE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-CWKfK2oiP_ehYacC_xXGaA-1; Mon, 21 Feb 2022 08:59:36 -0500
X-MC-Unique: CWKfK2oiP_ehYacC_xXGaA-1
Received: by mail-wr1-f72.google.com with SMTP id
 g11-20020adfa48b000000b001e57dfb3c38so7414564wrb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 05:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RSVIW7WKSNU5PqfuEaIi9kuilnpf4QQg552O4p0c0vg=;
 b=5LupcK3u4r4dkvzRkDqpxUBCvwRcq/aqNj9/+cbuvolSwx1ncQ1XrhTcBj4wIc3nYb
 uFVEojGFxpjKsYoPuh8QzEufS3RUwkEopuebG0ysinGCDzHtpN0jIQKYlElEjis0oRNl
 gLQpSoltd9LOaDET2ipJP48QaU4IIbZvATwdU3V6CXVHDVi7Qn1OeIB2Cyx4LAFCKi65
 9t71cSE39f5PFy8hIP6cHxAME/9iFlZMLtv8LTmI1bQK5rX4oz7czvth5FYpSshCsbGI
 1LHZOYwfQcjvHrVOP1xmx3CZs6iIQ34zp7hWqMzWl7dLRzOuGbwbhskSNJh2J7J/Ysy7
 JOxQ==
X-Gm-Message-State: AOAM532770ykDV5rs0qO00iLxidUIbCdS6dxzqBLeFRXYJu8897+RlFI
 USzyXgZVze1ReE6f3OkfDNfWYbQMZs0qlth6DmlVRRESDGjUMDWDOxpf+/3w5ioOyejzAUpN0gb
 vcmGudXy2DqNE/7Drr3d5/S79ySfkRK2DKAgCJFBBfw==
X-Received: by 2002:adf:9f4a:0:b0:1e3:1c28:c298 with SMTP id
 f10-20020adf9f4a000000b001e31c28c298mr15464354wrg.233.1645451975139; 
 Mon, 21 Feb 2022 05:59:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFnMEd+AorTKgUxxWlJ80t1TpsoeHG7oT0Zc9X8kQornxrzt1FVqy8lGYBIKPsefgfErXU1w==
X-Received: by 2002:adf:9f4a:0:b0:1e3:1c28:c298 with SMTP id
 f10-20020adf9f4a000000b001e31c28c298mr15464328wrg.233.1645451974972; 
 Mon, 21 Feb 2022 05:59:34 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id i13sm13512139wrp.87.2022.02.21.05.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 05:59:34 -0800 (PST)
Date: Mon, 21 Feb 2022 14:59:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <CAGxU2F6aMqTaNaeO7xChtf=veDJYtBjDRayRRYkZ_FOq4CYJWQ@mail.gmail.com>
References: <20220221114916.107045-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220221114916.107045-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Hillf Danton <hdanton@sina.com>, kvm <kvm@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 21, 2022 at 12:49 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
> ownership. It expects current->mm to be valid.
>
> vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
> the user has not done close(), so when we are in do_exit(). In this
> case current->mm is invalid and we're releasing the device, so we
> should clean it anyway.
>
> Let's check the owner only when vhost_vsock_stop() is called
> by an ioctl.
>
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vhost/vsock.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reported-and-tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
