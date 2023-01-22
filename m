Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F5DC25B4E
	for <virtualization@archiver.kernel.org>; Sun, 22 Jan 2023 10:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 01CEC400CF;
	Sun, 22 Jan 2023 10:23:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01CEC400CF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+RxrJaG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QmuUeNl8zc4v; Sun, 22 Jan 2023 10:23:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D7B7400E7;
	Sun, 22 Jan 2023 10:23:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D7B7400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 597E1C0033;
	Sun, 22 Jan 2023 10:23:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59E0DC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2726841517
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2726841517
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d+RxrJaG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DjX_82iYOkbD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:23:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9039341506
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9039341506
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674383032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vp4nDruEit5hTFxTjTpKC1ydXnGDFdRa2R0+xR8TkNY=;
 b=d+RxrJaGACwDWxQevYeg72s5qe1a2KytczAM+FccY1OvjRLtRK640e1w3MpMnHgPgWOEBa
 sQhDh5OEzBtT/6ZXhdpfehvMtS3gCQaV20n21qL9RbwvA1XBn6MrkMEi5T/0jra4Sw5hPO
 YLKK9Bs9bUbJuUrXx1daG4WU8Gal54Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-208-nTxtMLT0NPe2KLN-RMNk-A-1; Sun, 22 Jan 2023 05:23:50 -0500
X-MC-Unique: nTxtMLT0NPe2KLN-RMNk-A-1
Received: by mail-ej1-f72.google.com with SMTP id
 gn31-20020a1709070d1f00b0087024adbba2so6181076ejc.20
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 02:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vp4nDruEit5hTFxTjTpKC1ydXnGDFdRa2R0+xR8TkNY=;
 b=5VXcd+TGBOmutRDJHQ/Bp014NEA7TRVHTY+JISBcIoe06v+PURth3qEH5mvPpOrJeg
 CYPwBjiJ0OyZsxIs0xEWUNqQ0BpKAWNH3/cH7TU+FGDOHDCiLbf+a8uhslD4emiFLpyY
 K5vqHr0Hp4fUqIWMz1YFMdMjS3Tp20S+DUJo+hbMxJMNK5MD9+PS3bamfL5c2L6DgmOi
 XxyQSSqmI05ap0M7FoQ6NQQcQsQkb+vBcgyCdmesPwB1GBmtcH2QpLHCqQ2B01j2sLz9
 lvy9CSCCsPKIcdCUGBZ8FK4JA7OtP2wmS8bPgB1tWz8L6sACw5AQTHhWB7+1nHZhTLhP
 GYKg==
X-Gm-Message-State: AFqh2ko+uGKpx7bCPVJwUWThLobGsbK8v5wamYAF0D17QV/3/XuNwQP2
 m5TYcoXHRNY4zUNgb3fhxrwZVYhTVj7jP9R3XmmN1hDW748EnpV3EMUCEC4huohe0U3ROlaP2Yk
 UcAlyFfQ7B3e+9pFDf/nCj4Y5lf5pk8Q5TwSTxDBnwg==
X-Received: by 2002:a17:906:71a:b0:7c1:6344:84a with SMTP id
 y26-20020a170906071a00b007c16344084amr22442680ejb.5.1674383029673; 
 Sun, 22 Jan 2023 02:23:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsJYsSlxdKNdkV3k0zZFAQEWMBIP57WsNsog63A1Utnn4PhgD2R94CsSnVpUciaRFnFvrZD5Q==
X-Received: by 2002:a17:906:71a:b0:7c1:6344:84a with SMTP id
 y26-20020a170906071a00b007c16344084amr22442658ejb.5.1674383029366; 
 Sun, 22 Jan 2023 02:23:49 -0800 (PST)
Received: from redhat.com ([2.52.149.29]) by smtp.gmail.com with ESMTPSA id
 y19-20020a1709060a9300b0084debc351b3sm17314670ejf.20.2023.01.22.02.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jan 2023 02:23:48 -0800 (PST)
Date: Sun, 22 Jan 2023 05:23:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/4] virtio_net: vdpa: update MAC address when it is
 generated by virtio-net
Message-ID: <20230122052211-mutt-send-email-mst@kernel.org>
References: <20230122100526.2302556-1-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230122100526.2302556-1-lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cindy Lu <lulu@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Gautam Dawar <gautam.dawar@xilinx.com>
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

On Sun, Jan 22, 2023 at 11:05:22AM +0100, Laurent Vivier wrote:
> When the MAC address is not provided by the vdpa device virtio_net
> driver assigns a random one without notifying the device.
> The consequence, in the case of mlx5_vdpa, is the internal routing
> tables of the device are not updated and this can block the
> communication between two namespaces.
> 
> To fix this problem, use virtnet_send_command(VIRTIO_NET_CTRL_MAC)
> to set the address from virtnet_probe() when the MAC address is
> randomly assigned from virtio_net.
> 
> While I was testing this change I found 3 other bugs in vdpa_sim_net:
> 
> - vdpa_sim_net sets the VIRTIO_NET_F_MAC even if no MAC address is
>   provided. So virtio_net doesn't generate a random MAC address and
>   the MAC address appears to be 00:00:00:00:00:00
> 
> - vdpa_sim_net never processes the command and virtnet_send_command()
>   hangs in an infinite loop. To avoid a kernel crash add a timeout
>   in the loop.
> 
> - To allow vdpa_sim_net to process the command, replace the cpu_relax()
>   in the loop by a schedule(). vdpa_sim_net uses a workqueue to process
>   the queue, and if we don't allow the kernel to schedule, the queue
>   is not processed and the loop is infinite.

I'd split these things out as opposed to a series unless there's
a dependency I missed.

All this reminds me of
https://lore.kernel.org/r/20221226074908.8154-5-jasowang%40redhat.com

how is this patch different/better?
Pls also CC people involved in that original discussion.

Thanks!

> Laurent Vivier (4):
>   virtio_net: notify MAC address change on device initialization
>   virtio_net: add a timeout in virtnet_send_command()
>   vdpa_sim_net: don't always set VIRTIO_NET_F_MAC
>   virtio_net: fix virtnet_send_command() with vdpa_sim_net
> 
>  drivers/net/virtio_net.c             | 21 +++++++++++++++++++--
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  6 ++++++
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.0
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
