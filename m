Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533F1C4332F
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 16:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E4600400D9;
	Thu, 13 Jan 2022 16:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FIMiymKOgbF0; Thu, 13 Jan 2022 16:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2DE8F40133;
	Thu, 13 Jan 2022 16:05:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0616C002F;
	Thu, 13 Jan 2022 16:05:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BC6AC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 16:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1371C60B14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 16:05:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dPqQDFULoWif
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 16:05:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7459C6076A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642089951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMP5V6IIJzefWd2gyk8a8aMEx8ssEhjQKcu5NcxyEzo=;
 b=K8xQl/r+1LF/7EPH8DRguyoZFZQVJbbdHkylrvnFtoJr7Sh3QiKsyoCbyxf38nyObHT0yk
 X8G4SX8lQ9BzPQDy+Hu4uW8iiJJ2BzqOap4mJot5xg3rSYgZwcVqmmQHiAxE+Ft/cWH8cW
 RrkdeGxTwm4Lb4G84mUN4w/r7fMkdDA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-2AuvKbIXNKiJYyvpAV-Wpg-1; Thu, 13 Jan 2022 11:05:49 -0500
X-MC-Unique: 2AuvKbIXNKiJYyvpAV-Wpg-1
Received: by mail-ed1-f70.google.com with SMTP id
 h11-20020a05640250cb00b003fa024f87c2so5791689edb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 08:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pMP5V6IIJzefWd2gyk8a8aMEx8ssEhjQKcu5NcxyEzo=;
 b=PwtQTTPEfRPv6G4ZmVjTKCwiVTfeHcK/3UQJKKvMiTCOEZSxeL3RNJIs6WdRNsckyG
 sn1mMze7foVv4FgHr9vjWGa35ibnxiIAexghWRiQgPt2La0CMP57CheO74ELZnNTqHM9
 N37orUaF/GMLC92OU9XSZLnsEwfjnYe/h9j5Na/6mZ5/pgpboFCj+gfuQfP7CGgDKY+q
 WiaaQUnnCY7iO2D7bnw5+wEw05FF+Fj7xJ6GIdxWui60KSgnxJJ0r3vF0Jmm1hWx9XkS
 Es1tNmS/r60q/XgAcQ/7z8EUSf+ApNQV+W7S7F4AyBPp9VKi0KvJM+eV4URgp0UseSXg
 aGIw==
X-Gm-Message-State: AOAM530ff9Aao08A9ggxAny9YLMoZSH9tpciK+EAVSMeLw0CTr6J5B56
 IJisepmpRQ1WeW8phPsX2KpyjI64SN6eAsfmgn0bcKAyjsmgIWzIHDp5y4wNHdcAmQtTzL/+Bmm
 uOBmKWrw+JtTKoUhKIU7bqCPCR9fMVVEvUHllLMOhng==
X-Received: by 2002:aa7:df18:: with SMTP id c24mr4817278edy.164.1642089948518; 
 Thu, 13 Jan 2022 08:05:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3pzQgWFbNJYbAAeR1DJUYSp+AERU5tSgP/iptt6EhUsQbH6QvqAghcwb32Rc2kr3RUAkf/Q==
X-Received: by 2002:aa7:df18:: with SMTP id c24mr4817254edy.164.1642089948288; 
 Thu, 13 Jan 2022 08:05:48 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id z16sm1438618edm.49.2022.01.13.08.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jan 2022 08:05:47 -0800 (PST)
Date: Thu, 13 Jan 2022 11:05:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220113110506-mutt-send-email-mst@kernel.org>
References: <20220113145642.205388-1-sgarzare@redhat.com>
 <20220113101922-mutt-send-email-mst@kernel.org>
 <20220113154301.qd3ayuhrcjnsaim7@steredhat>
MIME-Version: 1.0
In-Reply-To: <20220113154301.qd3ayuhrcjnsaim7@steredhat>
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

On Thu, Jan 13, 2022 at 04:44:47PM +0100, Stefano Garzarella wrote:
> On Thu, Jan 13, 2022 at 10:19:46AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 13, 2022 at 03:56:42PM +0100, Stefano Garzarella wrote:
> > > In vhost_enable_notify() we enable the notifications and we read
> > > the avail index to check if new buffers have become available in
> > > the meantime. In this case, the device would go to re-read avail
> > > index to access the descriptor.
> > > 
> > > As we already do in other place, we can cache the value in `avail_idx`
> > > and compare it with `last_avail_idx` to check if there are new
> > > buffers available.
> > > 
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > I guess we can ... but what's the point?
> > 
> 
> That without this patch if avail index is new, then device when will call
> vhost_get_vq_desc() will find old value in cache and will read it again.
> 
> With this patch we also do the same path and update the cache every time we
> read avail index.
> 
> I marked it RFC because I don't know if it's worth it :-)
> 
> Stefano

Pls include info like this in commit log. Thanks!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
