Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BC3C433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 12:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F48084382;
	Thu, 10 Mar 2022 12:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qi_vLUgYZUYp; Thu, 10 Mar 2022 12:58:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3FFD98143F;
	Thu, 10 Mar 2022 12:58:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CCD5C0012;
	Thu, 10 Mar 2022 12:58:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92252C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72ACE84382
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dAmxyHb4mbJs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:58:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D88B8143F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646917081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pQET2MPPoFWIolLulpf9vgE2ol9UeRG3d/CiXthk1lc=;
 b=SJ2Wmd88gO6+pKr9vLfPbaeaavTZzgnrNRBi4P7bjptKaY96JzAkFAkZRLXg92ZUe8urX1
 RvRI0w7bWDt5v3NYR3VxbINoVad7RNPsV17p5FUqnNV93si0ufaWGkW5sMc7DUGVDQjKJE
 2Ip7EZ8iL3vq6+VUUsOsv6aRAnbBbjI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-ybfsP1MeOHq_Kx5CWEowLg-1; Thu, 10 Mar 2022 07:57:59 -0500
X-MC-Unique: ybfsP1MeOHq_Kx5CWEowLg-1
Received: by mail-wr1-f71.google.com with SMTP id
 a5-20020adfdd05000000b001f023fe32ffso1658056wrm.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 04:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pQET2MPPoFWIolLulpf9vgE2ol9UeRG3d/CiXthk1lc=;
 b=XOfaAAdQ4aCOFfqiDQQrsfH32qEBDKLBaOLF9eDT4UVH9qKHRElAwVrwttvfnF+nB4
 XJolamP1seG4yEUtZW+a4wbkKhFxtGXAbxIcH3KrunbP8eAWTvrEuHTyBrpCFk6eZbyk
 ipjDQbZ70mNrNTjKlJaTAoEIYgfvDYVkaZY///4MxQWiHQ/cUnM3czRxNuHo1GTxSm5O
 yNVvyU2fm7nR3HDXG995V6iBGJ7RHdQYOdAAV03v9niFVccbel91X2qhx2X3VsyONCl2
 i5Ok8tHIq+lRQeyz3uR8ZqtOAeEvKodv6r+GXYFJo3ZEbtKtHNgDAqjCajThII2LdPRI
 Cshg==
X-Gm-Message-State: AOAM530ce7xQki3RkanjqIFBIdAq8txrYuTpAeGsPFzK9Cy8xTgRdkVX
 RRrIv6R2bhhbdafpmqw4dqIoI/g53EKB1Ytain6BsufrX17hRSLZMQXozfXgKaKJ8t3RSG/j7KW
 BOCP5PWiaUqVcv1mZJxO93sbewpkvz4LW6UtoA4eSyQ==
X-Received: by 2002:a5d:5846:0:b0:203:6b34:37af with SMTP id
 i6-20020a5d5846000000b002036b3437afmr3679526wrf.58.1646917078730; 
 Thu, 10 Mar 2022 04:57:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNy/izqOOZPKvRpP+GlT6cO3sQtQvas8NEWLfQ+g6cahHLf6mWcq6HAOBus4EAcYOUh56YBg==
X-Received: by 2002:a5d:5846:0:b0:203:6b34:37af with SMTP id
 i6-20020a5d5846000000b002036b3437afmr3679501wrf.58.1646917078395; 
 Thu, 10 Mar 2022 04:57:58 -0800 (PST)
Received: from redhat.com ([2.53.27.107]) by smtp.gmail.com with ESMTPSA id
 u4-20020adfed44000000b0020373d356f8sm4119668wro.84.2022.03.10.04.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 04:57:57 -0800 (PST)
Date: Thu, 10 Mar 2022 07:57:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiyong Park <jiyong@google.com>
Subject: Re: [PATCH 0/2] vsock: cycle only on its own socket
Message-ID: <20220310075554-mutt-send-email-mst@kernel.org>
References: <20220310125425.4193879-1-jiyong@google.com>
MIME-Version: 1.0
In-Reply-To: <20220310125425.4193879-1-jiyong@google.com>
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

On Thu, Mar 10, 2022 at 09:54:23PM +0900, Jiyong Park wrote:
> Hi Stefano,
> 
> As suggested [1], I've made two patches for easier backporting without
> breaking KMI.
> 
> PATCH 1 fixes the very issue of cycling all vsocks regardless of the
> transport and shall be backported.
> 
> PATCH 2 is a refactor of PATCH 1 that forces the filtering to all
> (including future) uses of vsock_for_each_connected_socket.
> 
> Thanks,
> 
> [1] https://lore.kernel.org/lkml/20220310110036.fgy323c4hvk3mziq@sgarzare-redhat/


OK that's better. Pls do include changelog in the future.

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> Jiyong Park (2):
>   vsock: each transport cycles only on its own sockets
>   vsock: refactor vsock_for_each_connected_socket
> 
>  drivers/vhost/vsock.c            | 3 ++-
>  include/net/af_vsock.h           | 3 ++-
>  net/vmw_vsock/af_vsock.c         | 9 +++++++--
>  net/vmw_vsock/virtio_transport.c | 7 +++++--
>  net/vmw_vsock/vmci_transport.c   | 3 ++-
>  5 files changed, 18 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 3bf7edc84a9eb4007dd9a0cb8878a7e1d5ec6a3b
> -- 
> 2.35.1.723.g4982287a31-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
