Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9C3C46467
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 11:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 60C7540134;
	Mon, 16 Jan 2023 11:12:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60C7540134
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YQIT1efE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dbPT2sMNdmZP; Mon, 16 Jan 2023 11:12:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C9F36401CA;
	Mon, 16 Jan 2023 11:12:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9F36401CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99DE9C0032;
	Mon, 16 Jan 2023 11:12:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A36CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 11:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D04D60769
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 11:12:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D04D60769
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YQIT1efE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e4r-p6NJthIX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 11:12:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1236605A0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1236605A0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 11:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673867534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xk0ru0w9+e9EAkvTNXaYhN64TcjBSGHtatyySaOd8KM=;
 b=YQIT1efElICsjZff5Tkzo6Pc1Zj+u9kb4jbdLLhsdLU2AEpSBatEYcZm2fMfi5uP2NW7si
 NpOBprpJDGC82OtC342OAaydJAONkDTP5ickep41brS1zJNgOiKfldeekKLzT01TOzckck
 NrdfiEyrFyg5I32aH86lU0H8uGXeBq0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-HTrIm_oFPX2ADlPgpIjzvw-1; Mon, 16 Jan 2023 06:12:13 -0500
X-MC-Unique: HTrIm_oFPX2ADlPgpIjzvw-1
Received: by mail-qk1-f200.google.com with SMTP id
 bj28-20020a05620a191c00b007068d8b5051so186588qkb.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 03:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xk0ru0w9+e9EAkvTNXaYhN64TcjBSGHtatyySaOd8KM=;
 b=tIb9Vc/dP5DQaF4dGnT6XUidYecPoCs8KJ6js2GU/uxSbJOVd22upnP2+y6lCl76Mm
 eQiggbg4N3gxnv6x1nOgPGjsrLwTV7DRFpLgnTykRBMOuSdJbdF7atVipPOuCZ2sUEPB
 SmqM4sdZr2LrIWzIIX+ls81Ho/+OqrEj4sswG+s52A/YFZVOsTJRRnbuObDzFKPHh8HC
 lTHK3nSQ8qAaPzxXwDy0g/kpI03h+Cjz4kwyhxsLkqTziAqDgICSPby0qsn6aqpeIemw
 dxqIpH6WxqLIdrvWDU4fcnmSayNu+F8s0gblnvcqaB7pzQUn4858F0f4Sue+wW3EBSXY
 LsTA==
X-Gm-Message-State: AFqh2krAarsYy7AGSv4JY7UJP5gn516R1ZZfaEGBrVJAAwfmgYcq4cMr
 MevDyXeaJQK4/yQSMfDjNBaebr+9hQebSQY7pyaMLj6pBxYF5aQFc6WwDM/OzcnoR8YH3J1huHp
 AvElSRKhVbZ+d3Kk+1mUp2VQWyZi7Kk2S1gvNMS4jAg==
X-Received: by 2002:a05:622a:4a15:b0:3af:b6bd:aba7 with SMTP id
 fv21-20020a05622a4a1500b003afb6bdaba7mr35212432qtb.43.1673867533201; 
 Mon, 16 Jan 2023 03:12:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvUnYT51VUVH61+cDwTfIaOq8om38/xZLMDlzmwknNhKAsbceeU8IOMbufPUB8nUrZ/3z1C8A==
X-Received: by 2002:a05:622a:4a15:b0:3af:b6bd:aba7 with SMTP id
 fv21-20020a05622a4a1500b003afb6bdaba7mr35212399qtb.43.1673867532964; 
 Mon, 16 Jan 2023 03:12:12 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-72.retail.telecomitalia.it.
 [79.46.200.72]) by smtp.gmail.com with ESMTPSA id
 do26-20020a05620a2b1a00b0070648cf78bdsm3938908qkb.54.2023.01.16.03.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jan 2023 03:12:12 -0800 (PST)
Date: Mon, 16 Jan 2023 12:12:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net-next v10] virtio/vsock: replace virtio_vsock_pkt with
 sk_buff
Message-ID: <20230116111207.yxlwh4jlejtn4ple@sgarzare-redhat>
References: <20230113222137.2490173-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230113222137.2490173-1-bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Fri, Jan 13, 2023 at 10:21:37PM +0000, Bobby Eshleman wrote:
>This commit changes virtio/vsock to use sk_buff instead of
>virtio_vsock_pkt. Beyond better conforming to other net code, using
>sk_buff allows vsock to use sk_buff-dependent features in the future
>(such as sockmap) and improves throughput.
>
>This patch introduces the following performance changes:
>
>Tool: Uperf
>Env: Phys Host + L1 Guest
>Payload: 64k
>Threads: 16
>Test Runs: 10
>Type: SOCK_STREAM
>Before: commit b7bfaa761d760 ("Linux 6.2-rc3")
>
>Before
>------
>g2h: 16.77Gb/s
>h2g: 10.56Gb/s
>
>After
>-----
>g2h: 21.04Gb/s
>h2g: 10.76Gb/s
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>---
>Changes in v10:
>- vhost/vsock: use virtio_vsock_skb_dequeue()
>- vhost/vsock: remove extra iov_length() call
>- vhost/vsock: also consider hdr when evaluating that incoming size is
>  valid
>- new uperf data

Tests seem fine!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
