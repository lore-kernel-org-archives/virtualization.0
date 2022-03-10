Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CD6C433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 12:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2140840948;
	Thu, 10 Mar 2022 12:59:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tjNZ9Sg5R_Lb; Thu, 10 Mar 2022 12:59:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B0A6E408B5;
	Thu, 10 Mar 2022 12:59:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87E70C0012;
	Thu, 10 Mar 2022 12:59:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F6B6C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40E2D60EBC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JwR1xBInkQ4h
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:59:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AEA360B43
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646917162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hwCuIDSsPjX4AERceBeOtiMJvDAZVLHVVFLuVfFYlm4=;
 b=BH7O8ZkaqBXBI7e5a3Sg3UozcHA2L49+QDlxMCk/J9NROom0uIwsARykkzgXjmPEmIt11F
 x4ptZDV896fqck7OOBNx5OC9KIIJpthVmdqbYwMdT0G8mTNs7uihjFnPl+iabfYzPjVYID
 +56C70l3Qu11nbD9suc/eO/nBxSS8MI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-16VICh3GNT6H1qcPl5Tupg-1; Thu, 10 Mar 2022 07:59:21 -0500
X-MC-Unique: 16VICh3GNT6H1qcPl5Tupg-1
Received: by mail-wm1-f72.google.com with SMTP id
 14-20020a05600c028e00b003897a4056e8so2248290wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 04:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hwCuIDSsPjX4AERceBeOtiMJvDAZVLHVVFLuVfFYlm4=;
 b=BJMO1e8nXxoyaEjvYQAn6tWVbwdO50dVOKQARCrCD9ir+gUm7a2stlGExqOZmuGGk2
 Oir8UDR+Yaz/YvL5Rt507AOEp9rK4YbTl5yEQwdfyq/HeMamKCPMrcapPmcJbXxP0dHK
 ezmDxsK31nxIhrNDyXyl8+kamU1Jt/cIAS1hFfkhQW/QhBZptJ4oWaiubkCuslo5iG49
 qX0RZp/zBPsJgYG8lv/Hw9alaZwIJIsVyZIHA8wmZBQXb3RUW9FGCM2n/wdBFFUZcdXE
 7gAOqC3bcf+VF0TtH/KG41i4K2Fjiih/J8pxTf9in+RkrbuBYGLv7H1ak1qSyIo8YcFf
 Vh/g==
X-Gm-Message-State: AOAM531sRDujryJL0kS+FwVXxTwXvxpQxP4iy9EWrrHRdJ93E69nnbKV
 oYWGHL8Y4JcONe8L4HFSPYz+QOSMo+7TIBZdOL9n+IbxuGamutxt1uhG9jGEU3Zc8yS42jQvZSu
 eC88jciQmqeeZ3xv4tIatLsHzP+hmKd9ndJUV2T9LQA==
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id
 c10-20020adfe74a000000b001f025cb3ad5mr3347338wrn.231.1646917159909; 
 Thu, 10 Mar 2022 04:59:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4qf2SKWvXQvwoAB9Gh/FK48f8OJZe69JH0iUoqd3J7EpB6Fi2Yt+tJIwgM/gUJZtaibSlQA==
X-Received: by 2002:adf:e74a:0:b0:1f0:25cb:3ad5 with SMTP id
 c10-20020adfe74a000000b001f025cb3ad5mr3347324wrn.231.1646917159674; 
 Thu, 10 Mar 2022 04:59:19 -0800 (PST)
Received: from redhat.com ([2.53.27.107]) by smtp.gmail.com with ESMTPSA id
 n7-20020a05600c3b8700b00389a6241669sm8676255wms.33.2022.03.10.04.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 04:59:19 -0800 (PST)
Date: Thu, 10 Mar 2022 07:59:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiyong Park <jiyong@google.com>
Subject: Re: [PATCH 0/2] vsock: cycle only on its own socket
Message-ID: <20220310075854-mutt-send-email-mst@kernel.org>
References: <20220310125425.4193879-1-jiyong@google.com>
 <20220310075554-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220310075554-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: adelva@google.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, kuba@kernel.org, davem@davemloft.net
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

On Thu, Mar 10, 2022 at 07:57:58AM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 10, 2022 at 09:54:23PM +0900, Jiyong Park wrote:
> > Hi Stefano,
> > 
> > As suggested [1], I've made two patches for easier backporting without
> > breaking KMI.
> > 
> > PATCH 1 fixes the very issue of cycling all vsocks regardless of the
> > transport and shall be backported.
> > 
> > PATCH 2 is a refactor of PATCH 1 that forces the filtering to all
> > (including future) uses of vsock_for_each_connected_socket.
> > 
> > Thanks,
> > 
> > [1] https://lore.kernel.org/lkml/20220310110036.fgy323c4hvk3mziq@sgarzare-redhat/
> 
> 
> OK that's better. Pls do include changelog in the future.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Hmm actually I think I have a better idea. Hang on.

> 
> 
> > Jiyong Park (2):
> >   vsock: each transport cycles only on its own sockets
> >   vsock: refactor vsock_for_each_connected_socket
> > 
> >  drivers/vhost/vsock.c            | 3 ++-
> >  include/net/af_vsock.h           | 3 ++-
> >  net/vmw_vsock/af_vsock.c         | 9 +++++++--
> >  net/vmw_vsock/virtio_transport.c | 7 +++++--
> >  net/vmw_vsock/vmci_transport.c   | 3 ++-
> >  5 files changed, 18 insertions(+), 7 deletions(-)
> > 
> > 
> > base-commit: 3bf7edc84a9eb4007dd9a0cb8878a7e1d5ec6a3b
> > -- 
> > 2.35.1.723.g4982287a31-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
