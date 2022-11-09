Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C60EC433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 03:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AE9AD403FB;
	Wed,  9 Nov 2022 03:33:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE9AD403FB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OJt+9Oy/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rjTSWgkGl97T; Wed,  9 Nov 2022 03:33:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55ACD402D4;
	Wed,  9 Nov 2022 03:33:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55ACD402D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D466C0033;
	Wed,  9 Nov 2022 03:33:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 936A3C0033
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A9F960E6B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:33:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A9F960E6B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OJt+9Oy/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0vRBIwL6H2SP
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:33:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A575D60E67
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A575D60E67
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667964779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ivtonRD5aoz1CKIuTlgMyAr3i3s0X8AlSd+W+AfcZ24=;
 b=OJt+9Oy/j/wxzYrHEndw2bk46xNKKgaANj6mDdM2u1oN3PFssfu1Cvrv+K9BXZHWr2GLMB
 v02ePlnRPzqNZV39kZswizeQBT1yD6bQDtIgzmyJ+MD9L7yWKzQz9WZTLhgfICor3Cu56r
 CoL3WWGGic6Y9jNfi+AMRo0YaFx9tkU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470-ycsXmrbYPCOxg3G9mxpfLg-1; Tue, 08 Nov 2022 22:32:58 -0500
X-MC-Unique: ycsXmrbYPCOxg3G9mxpfLg-1
Received: by mail-oo1-f70.google.com with SMTP id
 q6-20020a4a3006000000b0049eab9167aeso3615011oof.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 19:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ivtonRD5aoz1CKIuTlgMyAr3i3s0X8AlSd+W+AfcZ24=;
 b=0ZKqEgQAWd89WIC1/uyzAFOxTipT7Mu2UtElAAWwH19UFfHbVxVMTl2dx8km2wOs6a
 wRh3q/ZKpIEpwZ1fv6/7ZuWGp3qaDX24zYn06keBlRXKM09PoIA0mpUFy8sd2m0aUxk7
 CgDcKOfFHAp0UIJzyFSBRdjOABLHQG5XeNfxmApfy6QwG7bhp1TcCabHLu/zm5Yk8ca7
 iN5Dnm9h8cFOUKPczUWaSYbCOrzGuUpgt5niVSECks0jlswHJ4oLG9CFReL9JYtXdYQy
 FfIwjxBFkyDxjpTtBHKIUHwGSSjPYhitxqJp0x+6ivDEuMdvluQdlXMZwV4MCfkJwE8w
 inEg==
X-Gm-Message-State: ACrzQf1sU9+etwdgjaq0GTbUFSPs5tDpnxHY0oYWwgjlZgGbzXFDtkcm
 F5vTC6MmtsfNmyu0dTCEY7LOKuRDPWBSqF8LEfAQe9mkibM1JgPdL0goy3PF3Ya9dXK/fsibGFl
 WvWFNIH/Z4ngM0h2e/DLTBGVUW1Io4oO5+bOxDok8M6N/8Z4Bklrb5Im35w==
X-Received: by 2002:a05:6870:9595:b0:132:7b3:29ac with SMTP id
 k21-20020a056870959500b0013207b329acmr761470oao.35.1667964777581; 
 Tue, 08 Nov 2022 19:32:57 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5M8878AGpCqTVOaVFaPL3HZWvPRD0v5I0xFnMjQ8KJ1iwAp/N5riXwSLa+mgg2JddtpNM0glIl1LS7stO0moc=
X-Received: by 2002:a05:6870:9595:b0:132:7b3:29ac with SMTP id
 k21-20020a056870959500b0013207b329acmr761468oao.35.1667964777388; Tue, 08 Nov
 2022 19:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20221108101705.45981-1-yuancan@huawei.com>
In-Reply-To: <20221108101705.45981-1-yuancan@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Nov 2022 11:32:45 +0800
Message-ID: <CACGkMEsce-TUjC+2H-jaky8=8A+r0sgF2Ti27Hr2YDmKeDpUHw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vsock: Fix error handling in vhost_vsock_init()
To: Yuan Can <yuancan@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 davem@davemloft.net
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

On Tue, Nov 8, 2022 at 6:19 PM Yuan Can <yuancan@huawei.com> wrote:
>
> A problem about modprobe vhost_vsock failed is triggered with the
> following log given:
>
> modprobe: ERROR: could not insert 'vhost_vsock': Device or resource busy
>
> The reason is that vhost_vsock_init() returns misc_register() directly
> without checking its return value, if misc_register() failed, it returns
> without calling vsock_core_unregister() on vhost_transport, resulting the
> vhost_vsock can never be installed later.
> A simple call graph is shown as below:
>
>  vhost_vsock_init()
>    vsock_core_register() # register vhost_transport
>    misc_register()
>      device_create_with_groups()
>        device_create_groups_vargs()
>          dev = kzalloc(...) # OOM happened
>    # return without unregister vhost_transport
>
> Fix by calling vsock_core_unregister() when misc_register() returns error.
>
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Signed-off-by: Yuan Can <yuancan@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> Changes in v2:
> - change to the correct Fixes: tag
>
>  drivers/vhost/vsock.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 5703775af129..10a7d23731fe 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -959,7 +959,14 @@ static int __init vhost_vsock_init(void)
>                                   VSOCK_TRANSPORT_F_H2G);
>         if (ret < 0)
>                 return ret;
> -       return misc_register(&vhost_vsock_misc);
> +
> +       ret = misc_register(&vhost_vsock_misc);
> +       if (ret) {
> +               vsock_core_unregister(&vhost_transport.transport);
> +               return ret;
> +       }
> +
> +       return 0;
>  };
>
>  static void __exit vhost_vsock_exit(void)
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
