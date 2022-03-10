Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BA3C433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 15:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56B568438F;
	Thu, 10 Mar 2022 15:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5ZvsJlNR4xJ; Thu, 10 Mar 2022 15:28:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F4112841BC;
	Thu, 10 Mar 2022 15:28:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBE18C001D;
	Thu, 10 Mar 2022 15:28:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D733C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08E488424B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:28:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M7OG3WRxHa2L
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:28:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A33B9841BC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646926091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OxmhgsYDn7lN+Q9MYhLi71z6xn1cSXOJwJ0aQe2hQ+o=;
 b=fFDNr+4kJOQNUZWw3nlANWxlo0S28OzjLYFWaXqBAiYqUygeq/ij4Yd1u4VyLqvYEOnqRV
 02BL+uGt6h0wOV89aQaa+g+bpsVbSvU5jJ3k4R38dC4QN7FgBYME5WNiFsenvbnkUMJ3hp
 On+Rb+wIcIeuP0y2Ke+d26mP2moH5D4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-KieqO7xuMeWSoLYsk-ox4w-1; Thu, 10 Mar 2022 10:28:09 -0500
X-MC-Unique: KieqO7xuMeWSoLYsk-ox4w-1
Received: by mail-wr1-f72.google.com with SMTP id
 t8-20020adfa2c8000000b001e8f6889404so1808243wra.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 07:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OxmhgsYDn7lN+Q9MYhLi71z6xn1cSXOJwJ0aQe2hQ+o=;
 b=A79AEly724E1sbwOzQny8xq4XE08R4S0zG2udaiNgOgdrWvJGE81mjsflrUrQwvASv
 CWaa2OK37+KPmEX0HaUqKB8ofZNp++tBEfkJ01GfbR+d+k4oVE2X6BKuD0rBSurC351Y
 RKMP9eshgH9kbbt7A63kt2pW3IHNAYCnp6Q20rrdAGaMN3cPM2mX0XBxYzG/TiFmzLf8
 yjB84fmccF9ntTn0ZIptM4cIxzSLVUW6zQrbtubqJMmJOPjPKu8uz7XgW1s3ndmnPncL
 bUHLAMwfxyUbzY8Wnzpk/5F1Nmb6WeET9jJyFKSdkt65TsNTP2z8dBSQBLdtS027jngF
 AMHw==
X-Gm-Message-State: AOAM5311O+PO6JAhIovjho3399/60xf5+/zteGQXieZa8A/tx6WMbSKX
 f78aoZH1WSWxVSEHPDjpgbswrvBQTMJKdaIkHawIeliB2yufo+ibkGSVEtt4MMGQB/cZh8ABP5u
 E71zapi0NtANBdjLin7h4SHYuP5Ctl6X0hoFHajTkSA==
X-Received: by 2002:adf:d1c2:0:b0:1f1:f89a:24ba with SMTP id
 b2-20020adfd1c2000000b001f1f89a24bamr4024600wrd.515.1646926087874; 
 Thu, 10 Mar 2022 07:28:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvVyRWRHj93/hZgey9ZXI65IZxEXwz2fuNHtQ5iBMjN5xH2pI0mLBomxlME5TCxbw4FP1ESQ==
X-Received: by 2002:adf:d1c2:0:b0:1f1:f89a:24ba with SMTP id
 b2-20020adfd1c2000000b001f1f89a24bamr4024578wrd.515.1646926087550; 
 Thu, 10 Mar 2022 07:28:07 -0800 (PST)
Received: from redhat.com ([2.53.27.107]) by smtp.gmail.com with ESMTPSA id
 x14-20020adfffce000000b001f1dfee4867sm5998858wrs.99.2022.03.10.07.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 07:28:06 -0800 (PST)
Date: Thu, 10 Mar 2022 10:28:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v3] vsock: each transport cycles only on its own sockets
Message-ID: <20220310102636-mutt-send-email-mst@kernel.org>
References: <20220310135012.175219-1-jiyong@google.com>
 <20220310141420.lsdchdfcybzmdhnz@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220310141420.lsdchdfcybzmdhnz@sgarzare-redhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: adelva@google.com, Jiyong Park <jiyong@google.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Thu, Mar 10, 2022 at 03:14:20PM +0100, Stefano Garzarella wrote:
> On Thu, Mar 10, 2022 at 10:50:11PM +0900, Jiyong Park wrote:
> > When iterating over sockets using vsock_for_each_connected_socket, make
> > sure that a transport filters out sockets that don't belong to the
> > transport.
> > 
> > There actually was an issue caused by this; in a nested VM
> > configuration, destroying the nested VM (which often involves the
> > closing of /dev/vhost-vsock if there was h2g connections to the nested
> > VM) kills not only the h2g connections, but also all existing g2h
> > connections to the (outmost) host which are totally unrelated.
> > 
> > Tested: Executed the following steps on Cuttlefish (Android running on a
> > VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
> > connection inside the VM, (2) open and then close /dev/vhost-vsock by
> > `exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
> > session is not reset.
> > 
> > [1] https://android.googlesource.com/device/google/cuttlefish/
> > 
> > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > Signed-off-by: Jiyong Park <jiyong@google.com>
> > ---
> > Changes in v3:
> >  - Fixed the build error in vmci_transport.c
> > Changes in v2:
> >  - Squashed into a single patch
> > 
> > drivers/vhost/vsock.c            | 3 ++-
> > include/net/af_vsock.h           | 3 ++-
> > net/vmw_vsock/af_vsock.c         | 9 +++++++--
> > net/vmw_vsock/virtio_transport.c | 7 +++++--
> > net/vmw_vsock/vmci_transport.c   | 5 ++++-
> > 5 files changed, 20 insertions(+), 7 deletions(-)
> 
> It seems okay now, I ran my test suite and everything seems to be fine:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Thanks,
> Stefanoc

Thanks!
Acked-by: Michael S. Tsirkin <mst@redhat.com>

Not a new regression so I think we should take this in the next cycle,
let's be careful here especially since previous version was not even
build-tested by the contributor.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
