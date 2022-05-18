Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4341EC433F5
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 04:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D83FF4051E;
	Wed, 18 May 2022 04:10:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zsBzCeV_oUcX; Wed, 18 May 2022 04:10:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 86B0C40515;
	Wed, 18 May 2022 04:10:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56791C0032;
	Wed, 18 May 2022 04:10:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E869C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 04:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D6654051C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 04:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n9Tq4_pbFWKc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 04:10:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFA0140515
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 04:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652847015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+NOVFFIZd9DRh/qXC8inU5DUoXa1hR/cvg4Nz0WouAs=;
 b=DeBVfZoUmOC7BLSv+daLVjIMW3AXrI++NZl4FfVl18Gn9Y9l0XhK0RzOZsyOTfIZfODoV0
 eug8bRgrsm+As6nnqtpbioI2dEnzmkeDUYXMN7tmjkJExRvo17ub6UB3xxRhdZlhlknUXs
 2960qj5wob6V5YXaRr27/md5f/Ezpp8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-7MMe4ZnYObepCe4uPNfaiw-1; Wed, 18 May 2022 00:10:14 -0400
X-MC-Unique: 7MMe4ZnYObepCe4uPNfaiw-1
Received: by mail-lf1-f72.google.com with SMTP id
 z9-20020a0565120c0900b00477a61b93a1so489126lfu.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 21:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+NOVFFIZd9DRh/qXC8inU5DUoXa1hR/cvg4Nz0WouAs=;
 b=vI4mFfY3C3WkB9oPgb5oHy0bQsvF1Furw6EQJ24hlYrOPjZ1t4V8TSOb+PEr8DeXJt
 poVK3pswSYW3Z4mbU4HypbI4wk5qWcFJl30rxLwOgfz5XEVMRs2fa+ZyVm71HiLXR3dT
 e4WsLyD2/Uj8ZWPtJagmF18Zjmqo+8KQHk6hQLpHt/NDHQoUh7lc0S8u86cFFKh3uO38
 aiUK9LFAw+PEqOX+qoGsjM29e+VPPpRzkHEK1S1QNeQO2MlBHWt1P93tOcEB+kCyi3i7
 Nx4cCXnFxobBqAgzqFbdnz0LcrnzY43ajl+I4WLbVnpIw8H6cA68wbyPLXRAd2FaOAOm
 TMkg==
X-Gm-Message-State: AOAM533BcMa8Ewlk1Xbc3wJEJoh8Q7TqUfMkArv3Ovt7+a9ZRR3LMf4H
 lRXWN/rNC3lqJVWX2DO3EFPggMfVrw+CH02fm9X276HtplGH2e4iWGkATzAup4ASHsZV25uarp9
 7IeJi8UCyz0loCWnhiiYDKw2Vvjy+o7KC8z5chJjl7dI8tKhpdR3goRvNWA==
X-Received: by 2002:a05:6512:3e0a:b0:477:b256:56b with SMTP id
 i10-20020a0565123e0a00b00477b256056bmr2426670lfv.587.1652847012541; 
 Tue, 17 May 2022 21:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo7LnwP2KhWd3cqQbJhDB1nD2XDUYc/xI2VSj4Lg3fzncr5rIBmRwqIBBPDJGhkob+9Xm5o+qCmV9M+3IXOIU=
X-Received: by 2002:a05:6512:3e0a:b0:477:b256:56b with SMTP id
 i10-20020a0565123e0a00b00477b256056bmr2426663lfv.587.1652847012356; Tue, 17
 May 2022 21:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220516084213.26854-1-jasowang@redhat.com>
 <20220516044400-mutt-send-email-mst@kernel.org>
 <YoQa4wzy9jSwDY7E@zeniv-ca.linux.org.uk>
In-Reply-To: <YoQa4wzy9jSwDY7E@zeniv-ca.linux.org.uk>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 May 2022 12:10:01 +0800
Message-ID: <CACGkMEvu8eVQ5Sy0675xjhukyPRoCKnTF+t0tpXw6dsexe3v1A@mail.gmail.com>
Subject: Re: [PATCH] vhost_net: fix double fget()
To: Al Viro <viro@zeniv.linux.org.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
 davem <davem@davemloft.net>
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

On Wed, May 18, 2022 at 6:00 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, May 16, 2022 at 04:44:19AM -0400, Michael S. Tsirkin wrote:
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > and this is stable material I guess.
>
> It is, except that commit message ought to be cleaned up.  Something
> along the lines of
>
> ----
> Fix double fget() in vhost_net_set_backend()
>
> Descriptor table is a shared resource; two fget() on the same descriptor
> may return different struct file references.  get_tap_ptr_ring() is
> called after we'd found (and pinned) the socket we'll be using and it
> tries to find the private tun/tap data structures associated with it.
> Redoing the lookup by the same file descriptor we'd used to get the
> socket is racy - we need to same struct file.
>
> Thanks to Jason for spotting a braino in the original variant of patch -
> I'd missed the use of fd == -1 for disabling backend, and in that case
> we can end up with sock == NULL and sock != oldsock.
> ----
>
> Does the above sound sane for commit message?

Yes.

> And which tree would you
> prefer it to go through?  I can take it in vfs.git#fixes, or you could
> take it into your tree...
>

Consider Michael gave an ack, it would be fine if you want to take via
your tree.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
