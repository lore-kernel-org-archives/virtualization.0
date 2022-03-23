Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30908C433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 22:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 966E4404A0;
	Wed, 23 Mar 2022 22:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XG5Ra-bTQUC1; Wed, 23 Mar 2022 22:37:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C965D400E6;
	Wed, 23 Mar 2022 22:37:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1E8EC0012;
	Wed, 23 Mar 2022 22:37:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCD08C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 22:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BDD68419DF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 22:37:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TizeXTMUiOPJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 22:37:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF843419CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 22:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648075039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCO9kWmcJK/zqnHuqkvNPWBBfJrDpoSVizCjP9r818U=;
 b=STYULCXmu/mInbQuHjB3Hebp8QDOz8lWt+82ULzjkkFzptNBQancCg53TG7hCfX32rCKFK
 mnhatWTPJ+f7A3R7hGndq8117VMSuCuLJjhnUSXuRM9RZlxzrnku4vTyvsIDRvdJWJLo1e
 8gzSqk6U/hLqGYMoaLWjQCxi2uPXNlo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-1Si_uQfPP1K86h63D1ViKQ-1; Wed, 23 Mar 2022 18:37:17 -0400
X-MC-Unique: 1Si_uQfPP1K86h63D1ViKQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 o10-20020a1c4d0a000000b0038c6e5fcbaeso1020008wmh.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 15:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GCO9kWmcJK/zqnHuqkvNPWBBfJrDpoSVizCjP9r818U=;
 b=ubMkiOXzlfzWhpylMbRQgFMXSlEOMMM8AMuoaCX/lMA4E2maM9AVWx6NZd+V/uJGLk
 xM0a/FTk1paj6Wlb9+veJOzbdRDQ/rdpGEPtUjZeqVn28Hf/MsFoW/rgCTtjonIbiVKv
 HMzNGk7xvZYY6ofww6MqHP+qkVzaZBUwa7wQqN3uLv0YSVPNL+wpUIS5UWmFqN5fqtRC
 5MGZUVIlsfPsmwdiGVYUvpofVUlyvZc34GZf3CfiyKtXucBc4Ij+CfQ6EzTprAHB261r
 CLAIaypHdF6EjbY/TR7YFR/ApI4xVWV28eNMi8SXNXQUznsT/xrRQpMYNJGGe5UtupCg
 nHYw==
X-Gm-Message-State: AOAM5336S/mgEwQ2C2E3Fql27a3Rgt+KzpBcf95LrdHoxR3kDjFruhvo
 VMM21ykgt1NISe/PdsbwI8q+3IXtCE8mvElAaMEOlgIfwi+DFCQMEghmQvPH/w6zPmx7kUBsCLy
 lTcqsJ9uFfDAGUgAy5OD95+8Kk4WLm31zodoeBWWpvw==
X-Received: by 2002:adf:9dc3:0:b0:205:7bf0:669f with SMTP id
 q3-20020adf9dc3000000b002057bf0669fmr1944323wre.4.1648075036542; 
 Wed, 23 Mar 2022 15:37:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf4BMQJkf+iGF0bxSMIgVNRplbXP5vi6oAc/EcslZHs0qUwYj6/T80KpKvYkRJT0LDAxm8Pw==
X-Received: by 2002:adf:9dc3:0:b0:205:7bf0:669f with SMTP id
 q3-20020adf9dc3000000b002057bf0669fmr1944308wre.4.1648075036322; 
 Wed, 23 Mar 2022 15:37:16 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 a18-20020a05600c349200b0038ca453a887sm4944273wmq.19.2022.03.23.15.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 15:37:15 -0700 (PDT)
Date: Wed, 23 Mar 2022 18:37:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net v3 0/3] vsock/virtio: enable VQs early on probe and
 finish the setup before using them
Message-ID: <20220323183657-mutt-send-email-mst@kernel.org>
References: <20220323173625.91119-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220323173625.91119-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Asias He <asias@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>
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

On Wed, Mar 23, 2022 at 06:36:22PM +0100, Stefano Garzarella wrote:
> The first patch fixes a virtio-spec violation. The other two patches
> complete the driver configuration before using the VQs in the probe.
> 
> The patch order should simplify backporting in stable branches.


Series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> v3:
> - re-ordered the patch to improve bisectability [MST]
> 
> v2: https://lore.kernel.org/netdev/20220323084954.11769-1-sgarzare@redhat.com/
> v1: https://lore.kernel.org/netdev/20220322103823.83411-1-sgarzare@redhat.com/
> 
> Stefano Garzarella (3):
>   vsock/virtio: initialize vdev->priv before using VQs
>   vsock/virtio: read the negotiated features before using VQs
>   vsock/virtio: enable VQs early on probe
> 
>  net/vmw_vsock/virtio_transport.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
