Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E9DC433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 14:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 392C540386;
	Thu, 10 Mar 2022 14:14:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fXHTYFQ3jH88; Thu, 10 Mar 2022 14:14:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC7A440457;
	Thu, 10 Mar 2022 14:14:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4B03C0012;
	Thu, 10 Mar 2022 14:14:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B759AC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 14:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A630860E48
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 14:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lP6o3Y6uCe8Y
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 14:14:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD7B660D6F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646921669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Go8Xs3nn4xJMSXzgfTAf+aN/PVriO9262aZwriGw3dc=;
 b=NPceDar1sWqiekTXuGLuFB+oTVw539lwEzzsgoG3Alqvx5B/v9kVc6xQG9OlR9dNihChPL
 m6qdMJg4dCxgeLQmghj1HlsJcD97TZTZCO07bNWlhFu3Etk/I3yOrubL578owiFlvI2Svs
 BNUoWhE1vU3B6WWtXXVKcOl45y52tTI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-uvw_veqQM0q5iTtlHE44rA-1; Thu, 10 Mar 2022 09:14:27 -0500
X-MC-Unique: uvw_veqQM0q5iTtlHE44rA-1
Received: by mail-wr1-f70.google.com with SMTP id
 y13-20020adfee0d000000b001f1fa450a3dso1742881wrn.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 06:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Go8Xs3nn4xJMSXzgfTAf+aN/PVriO9262aZwriGw3dc=;
 b=Olu3IIQ+MrE1TYCrAq0GYouVC3OAVo3/Fly7PbkO1PprmbzRiKDvJBSyjaWts0U+KZ
 owNSSXqimOv59m8iTJc51PdynLBlelhCxjwv5UlnBjFZBpdbsh4McbGu8baCtSBA6qKF
 MUjYm9BWJqov+VqS7h6D21iM7MH1YIVN5EjyLSpaqVX4PilFwCdpSUoKRYGxtNLeNhqO
 seKXEGxmRfK+y+aL9eeTL6aE57PEXkXB4OPEtzOxClGaTBfy/0lMG08t4ni0Y5/R5F2j
 HwevrlBAsWiWUdJmGEoUgnBu41+1oWNBfZNRDrl3UxL4vYO1vGxpegQOGbqlOjb8piMK
 qorg==
X-Gm-Message-State: AOAM530D/iZGBfpd+MYCuFfgGVQdqgXsp7UdgPnkdYnw66XIoAN1CGGa
 C4bWE7NwnjNIA3e0/j6vG2BUgFaJSYqWX2H0ant6ZVm36ajKv+JArxZoS+yBPAfBN7f8dYzL4t7
 Ex8MfBIJ1AbfoYsNBckybY6W178WD7iyviEuqzgQqfQ==
X-Received: by 2002:a7b:c759:0:b0:389:82c6:ac44 with SMTP id
 w25-20020a7bc759000000b0038982c6ac44mr11566466wmk.168.1646921664192; 
 Thu, 10 Mar 2022 06:14:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJrE6GOOprlJAb2464K/jVRkVAPfidu7mYv+i734cs8hDz4HbESzpyS0sW35U1EuqGVJzrQw==
X-Received: by 2002:a7b:c759:0:b0:389:82c6:ac44 with SMTP id
 w25-20020a7bc759000000b0038982c6ac44mr11566447wmk.168.1646921663950; 
 Thu, 10 Mar 2022 06:14:23 -0800 (PST)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 e18-20020adfdbd2000000b001e4bbbe5b92sm4687989wrj.76.2022.03.10.06.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 06:14:23 -0800 (PST)
Date: Thu, 10 Mar 2022 15:14:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jiyong Park <jiyong@google.com>
Subject: Re: [PATCH v3] vsock: each transport cycles only on its own sockets
Message-ID: <20220310141420.lsdchdfcybzmdhnz@sgarzare-redhat>
References: <20220310135012.175219-1-jiyong@google.com>
MIME-Version: 1.0
In-Reply-To: <20220310135012.175219-1-jiyong@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: adelva@google.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 10, 2022 at 10:50:11PM +0900, Jiyong Park wrote:
>When iterating over sockets using vsock_for_each_connected_socket, make
>sure that a transport filters out sockets that don't belong to the
>transport.
>
>There actually was an issue caused by this; in a nested VM
>configuration, destroying the nested VM (which often involves the
>closing of /dev/vhost-vsock if there was h2g connections to the nested
>VM) kills not only the h2g connections, but also all existing g2h
>connections to the (outmost) host which are totally unrelated.
>
>Tested: Executed the following steps on Cuttlefish (Android running on a
>VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
>connection inside the VM, (2) open and then close /dev/vhost-vsock by
>`exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
>session is not reset.
>
>[1] https://android.googlesource.com/device/google/cuttlefish/
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Jiyong Park <jiyong@google.com>
>---
>Changes in v3:
>  - Fixed the build error in vmci_transport.c
>Changes in v2:
>  - Squashed into a single patch
>
> drivers/vhost/vsock.c            | 3 ++-
> include/net/af_vsock.h           | 3 ++-
> net/vmw_vsock/af_vsock.c         | 9 +++++++--
> net/vmw_vsock/virtio_transport.c | 7 +++++--
> net/vmw_vsock/vmci_transport.c   | 5 ++++-
> 5 files changed, 20 insertions(+), 7 deletions(-)

It seems okay now, I ran my test suite and everything seems to be fine:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
