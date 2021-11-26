Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07118C433EF
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 08:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98E6C4040F;
	Fri, 26 Nov 2021 08:53:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yEW6O0JUg5IR; Fri, 26 Nov 2021 08:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3C72D40132;
	Fri, 26 Nov 2021 08:53:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22412C001E;
	Fri, 26 Nov 2021 08:53:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36B5CC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 252D060668
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:53:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HeM3ig7bS0Xs
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:53:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 131AB60683
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637916826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CaUZGIbLdBQv+xSVNcxZeXO0Rrr3XbXIVmiKg++vUEg=;
 b=TLfIlXUKKGWG5IZgcZS2olj1a8r+/+C9pXmGT5EGDj4Q4GDdk/BEFY/lPNl/CnrGwrEse2
 Jkm9EodrRLQblIYZHEB2Fjkrf5fRe+/+n50bdCYQWbdYMGq6eB8YKvvv/WM8QXU/G2p/LC
 SdYT70muxtwCRvCFMg1yLAFpDXNJCls=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-33AS7ViANr2Nq091c7uEBg-1; Fri, 26 Nov 2021 03:53:44 -0500
X-MC-Unique: 33AS7ViANr2Nq091c7uEBg-1
Received: by mail-ed1-f71.google.com with SMTP id
 bx28-20020a0564020b5c00b003e7c42443dbso7422205edb.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 00:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CaUZGIbLdBQv+xSVNcxZeXO0Rrr3XbXIVmiKg++vUEg=;
 b=TPin/qGOdZ/vl2Yv9PhkWgge4zac34Y7RTDiDrS/AxcvpqBMcQhUQ+0SeG8resj4r/
 tSiKuakmJyvDIgsXbYgPTfvsIauunOCDsAnfP0n8IgeEhJMtjaWheLyo1XplZOhwqQTD
 M6vjk541CNACwWBJMrskD41EeWxeTVQ96LfwqfYE4QhFX8Kx1oYLHBhgjh+Es0KsRNiT
 wcTuIxXk1+vp2cgoCMXYPgRP4bgkjK3xEVmBLOA9IvRRLek/a7zGjPvbQDM0a3ubkkVk
 xLvDBj0LaV2WtPrg+s4wN5WuITF+PL8hApH6fmJZESF2paGEmimjpSuL16Ce6vCqBwVa
 SnqA==
X-Gm-Message-State: AOAM530JvWGB8Bs4CSxFUTR+P133yrSUHzSBu6g/1d2duG/K/oAM4SRA
 gGtBsVR8LUBDWmj0e/7WZR6tvYr1X4XEXf5P6uiGfJRHGEC20Gkf3gPYtrHhBEzIamaTHGLMtL9
 o0//Y8eyb/Tf7VIudB/OpLE8tg9+pfNrb3P9SMS2gtg==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr46576154edu.237.1637916823725; 
 Fri, 26 Nov 2021 00:53:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynBNBQYN4uVWk4F98nCH01OPXWR80eaHC0GF284fqeGM0GYz3eAtEIKkZwxdcR6T714EoA9w==
X-Received: by 2002:aa7:dc15:: with SMTP id b21mr46576143edu.237.1637916823589; 
 Fri, 26 Nov 2021 00:53:43 -0800 (PST)
Received: from steredhat (host-79-46-195-175.retail.telecomitalia.it.
 [79.46.195.175])
 by smtp.gmail.com with ESMTPSA id d1sm3608298edn.56.2021.11.26.00.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Nov 2021 00:53:43 -0800 (PST)
Date: Fri, 26 Nov 2021 09:53:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v2] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Message-ID: <20211126085341.wiab2frkcbmkg4ca@steredhat>
References: <20211126011823.1760-1-wei.w.wang@intel.com>
MIME-Version: 1.0
In-Reply-To: <20211126011823.1760-1-wei.w.wang@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 davem@davemloft.net, stefanha@redhat.com, mst@redhat.com
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

On Thu, Nov 25, 2021 at 08:18:23PM -0500, Wei Wang wrote:
>The VMADDR_CID_ANY flag used by a socket means that the socket isn't bound
>to any specific CID. For example, a host vsock server may want to be bound
>with VMADDR_CID_ANY, so that a guest vsock client can connect to the host
>server with CID=VMADDR_CID_HOST (i.e. 2), and meanwhile, a host vsock
>client can connect to the same local server with CID=VMADDR_CID_LOCAL
>(i.e. 1).
>
>The current implementation sets the destination socket's svm_cid to a
>fixed CID value after the first client's connection, which isn't an
>expected operation. For example, if the guest client first connects to the
>host server, the server's svm_cid gets set to VMADDR_CID_HOST, then other
>host clients won't be able to connect to the server anymore.
>
>Reproduce steps:
>1. Run the host server:
>   socat VSOCK-LISTEN:1234,fork -
>2. Run a guest client to connect to the host server:
>   socat - VSOCK-CONNECT:2:1234
>3. Run a host client to connect to the host server:
>   socat - VSOCK-CONNECT:1:1234
>
>Without this patch, step 3. above fails to connect, and socat complains
>"socat[1720] E connect(5, AF=40 cid:1 port:1234, 16): Connection
>reset by peer".
>With this patch, the above works well.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Usually fixes for net/vmw_vsock/* are applied through the net tree 
(netdev@vger.kernel.org) that seems not CCed. Please use 
./scripts/get_maintainer.pl next time.

Maybe this one can be queued by Michael, let's wait a bit, otherwise 
please resend CCing netdev and using "net" tag.

Anyway the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
