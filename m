Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0266EC433FE
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 13:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95C698317B;
	Fri, 14 Jan 2022 13:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2QJoUs27hMz0; Fri, 14 Jan 2022 13:40:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4A7FE83E11;
	Fri, 14 Jan 2022 13:40:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F53CC002F;
	Fri, 14 Jan 2022 13:40:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BEBFC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5731D40500
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KOhU7KYOkrBu
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:40:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65B0A403A5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642167648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kIY3gZLZkDvyIuN4E1WV5yUkfGDdChIOt3WJ/TVBqGs=;
 b=e9tOtW3EF6WPDJJPrrGdHJw/vMK1uckMT8IZP2TxodWh0UnjxceZfp3vkGnp1Ho82Bsdw/
 IzpsfhMlqtxIGrRrT8L9Oq7oZ8gT98Y8YNCipkxN0ssLG4wJoRxBAGy5s90CYsdAwdRlgW
 L6YYHlQSJv79bmex3vWSrePrwaYijy0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-mgzQqgR6NEeblpLnPsQJ3Q-1; Fri, 14 Jan 2022 08:40:45 -0500
X-MC-Unique: mgzQqgR6NEeblpLnPsQJ3Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 m8-20020a056402510800b003f9d22c4d48so8361838edd.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 05:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kIY3gZLZkDvyIuN4E1WV5yUkfGDdChIOt3WJ/TVBqGs=;
 b=1Sqpb49+Dl7J5gkO97CG52Bj0YPfuyInsmGMdA/wxqyUcwsIr+oqtpnch6YLF2vVmb
 +0gD19SRiGNP0BrDd3tzHcgh24cpOUQAYVFhzo78xQhlzh9ebLb2TUzflLyzGCcOH/hE
 Z9sBN4LbFgdc6X1toDpxw0oEu073dR46opIYXThZJ6p+UD8AfVB92OGAjtGgE0741X1v
 abgBsqO5ckUS4SrIsYiG8lNL7PB2b84uA4bIU7MO+PgPUgAeWyQdqoNCfKp/CUKaftDa
 TGTiNe+/qR7lHwHCHOGey5bADAmQlUnOq56ObxzC/Lbezn2BOfwhvb+WJoOmI9nkat3d
 w6xg==
X-Gm-Message-State: AOAM533KtFNvAc99BPXi+1BgFy4LDhcM/aAQ/wcZgfKv0pYy+R4v+DN1
 5Y8ympXl10S+HKlCiVrmLjoAx2dPkK7HLihN9mS/T6Zj4c5Bsos/ZWFYMVKaeE1chGdWNWQrMMr
 cmo9QsBjDOvjluxRgv+rNXl5JjqQoy/NES3eJpzX+/A==
X-Received: by 2002:a50:e79a:: with SMTP id b26mr9036454edn.341.1642167644025; 
 Fri, 14 Jan 2022 05:40:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2fVFvhVy+pmPWHeYWUSOIG58hk1uWTDrKAAI8J1+CadDXmJiQxrYFzLWCmLzTDxfKAupkRA==
X-Received: by 2002:a50:e79a:: with SMTP id b26mr9036435edn.341.1642167643845; 
 Fri, 14 Jan 2022 05:40:43 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id qa35sm1854925ejc.67.2022.01.14.05.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 05:40:43 -0800 (PST)
Date: Fri, 14 Jan 2022 08:40:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v1] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220114084016-mutt-send-email-mst@kernel.org>
References: <20220114090508.36416-1-sgarzare@redhat.com>
 <20220114074454-mutt-send-email-mst@kernel.org>
 <20220114133816.7niyaqygvdveddmi@steredhat>
MIME-Version: 1.0
In-Reply-To: <20220114133816.7niyaqygvdveddmi@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On Fri, Jan 14, 2022 at 02:38:16PM +0100, Stefano Garzarella wrote:
> On Fri, Jan 14, 2022 at 07:45:35AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Jan 14, 2022 at 10:05:08AM +0100, Stefano Garzarella wrote:
> > > In vhost_enable_notify() we enable the notifications and we read
> > > the avail index to check if new buffers have become available in
> > > the meantime.
> > > 
> > > We are not caching the avail index, so when the device will call
> > > vhost_get_vq_desc(), it will find the old value in the cache and
> > > it will read the avail index again.
> > > 
> > > It would be better to refresh the cache every time we read avail
> > > index, so let's change vhost_enable_notify() caching the value in
> > > `avail_idx` and compare it with `last_avail_idx` to check if there
> > > are new buffers available.
> > > 
> > > Anyway, we don't expect a significant performance boost because
> > > the above path is not very common, indeed vhost_enable_notify()
> > > is often called with unlikely(), expecting that avail index has
> > > not been updated.
> > > 
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > ... and can in theory even hurt due to an extra memory write.
> > So ... performance test restults pls?
> 
> Right, could be.
> 
> I'll run some perf test with vsock, about net, do you have a test suite or
> common step to follow to test it?
> 
> Thanks,
> Stefano

You can use the vhost test as a unit test as well.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
