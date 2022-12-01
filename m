Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20276C4332F
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 22:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 977F361112;
	Thu,  1 Dec 2022 22:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 977F361112
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BIMoCMBs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nLlEfQvvlNnp; Thu,  1 Dec 2022 22:33:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 05F7861111;
	Thu,  1 Dec 2022 22:33:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05F7861111
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D502EC0033;
	Thu,  1 Dec 2022 22:33:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2B72C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B644D41080
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B644D41080
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BIMoCMBs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qEUE1CmGjLKO
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:33:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABA1141066
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABA1141066
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669933998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/2O4LegilVsQdyPuKZbJssTZDoZcgdukJ0d/d1p6i90=;
 b=BIMoCMBskBt6lB+bwRtfCrGpaHG5GEgV6YlIRMTfrFjW6EwOEEhRJFvBFSLPGgf8yqcppF
 694/wi4UM30oeRFKJvcAtJHlR/1V4aQcuAAGvLxfzSHH9xT30eFq5GkOlPVybxEv35dRbD
 9Tqgxje/cE/Td+6CNqQQ0xDw3xuB4DA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-356-6oU_qDVsMyKeKrW6ka_YNA-1; Thu, 01 Dec 2022 17:33:17 -0500
X-MC-Unique: 6oU_qDVsMyKeKrW6ka_YNA-1
Received: by mail-wm1-f69.google.com with SMTP id
 i8-20020a1c3b08000000b003d0683389daso3181653wma.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 14:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2O4LegilVsQdyPuKZbJssTZDoZcgdukJ0d/d1p6i90=;
 b=1YRp+2/PyuryeSg/dctFUYUuVPPIPermj2lGOD3Ei73s5uJUvASYFGNIl0aiNfXp4g
 tv+wS7yKHjp+U7iI3HayfdNgs55eKR5McUgeGVQdlzkzqqv2uPMMvhtAxX37BQgN6B08
 uwxtvexqSn/Vi865gOHbmwF3C+hFQ+Vc/IOdsQTdbqyNhFhSgXFizwZaqcu96IOpAxxc
 ZLs0gp+Etr0TG6+cvA2UahfVutoMmhZgPDL1AaUiZShNe6od2lg15NZ8ZL1tcU+xXVkA
 GGwfeXdypWsYvtrhpMED/W8osKgoLqnm9sVMn/DQoTuYUN+VHy6KIb1Dqk1eDKY9NCuC
 1HCw==
X-Gm-Message-State: ANoB5pmWUnD1V2soNTVUDebsd7wQOOKxjNukFbELcqIe/d2uyhtVrWXR
 eYmLbaHcKl9DYox2Usz1zHsBI6SWFHoTpM1z3bPCw86XuXHuVzbPs04v6wVPEHy8deCE/0yQLoM
 JBfkh+Uh3wfoggGmWpHxTEYp8D+yEepyEMqRmoGOuog==
X-Received: by 2002:adf:f60f:0:b0:22e:6564:e987 with SMTP id
 t15-20020adff60f000000b0022e6564e987mr42165686wrp.401.1669933995894; 
 Thu, 01 Dec 2022 14:33:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4SwqSn8+94MC8XNNJvmxjUkYSbcbXFohTxf/WlvTlCWz77FFhQffJ2sV3nppJe5VRZILk7iQ==
X-Received: by 2002:adf:f60f:0:b0:22e:6564:e987 with SMTP id
 t15-20020adff60f000000b0022e6564e987mr42165669wrp.401.1669933995602; 
 Thu, 01 Dec 2022 14:33:15 -0800 (PST)
Received: from redhat.com ([2.52.16.138]) by smtp.gmail.com with ESMTPSA id
 l9-20020a05600c2cc900b003cf9bf5208esm9663857wmc.19.2022.12.01.14.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 14:33:15 -0800 (PST)
Date: Thu, 1 Dec 2022 17:33:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v4 0/6] TUN/VirtioNet USO features support.
Message-ID: <20221201173252-mutt-send-email-mst@kernel.org>
References: <20221201215644.246571-1-andrew@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20221201215644.246571-1-andrew@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 devel@daynix.com, davem@davemloft.net
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

On Thu, Dec 01, 2022 at 11:56:38PM +0200, Andrew Melnychenko wrote:
> Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> Technically they enable NETIF_F_GSO_UDP_L4
> (and only if USO4 & USO6 are set simultaneously).
> It allows the transmission of large UDP packets.
> 
> UDP Segmentation Offload (USO/GSO_UDP_L4) - ability to split UDP packets
> into several segments. It's similar to UFO, except it doesn't use IP
> fragmentation. The drivers may push big packets and the NIC will split
> them(or assemble them in case of receive), but in the case of VirtioNet
> we just pass big UDP to the host. So we are freeing the driver from doing
> the unnecessary job of splitting. The same thing for several guests
> on one host, we can pass big packets between guests.
> 
> Different features USO4 and USO6 are required for qemu where Windows
> guests can enable disable USO receives for IPv4 and IPv6 separately.
> On the other side, Linux can't really differentiate USO4 and USO6, for now.
> For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> In the future, there would be a mechanism to control UDP_L4 GSO separately.
> 
> New types for virtio-net already in virtio-net specification:
> https://github.com/oasis-tcs/virtio-spec/issues/120
> 
> Test it WIP Qemu https://github.com/daynix/qemu/tree/USOv3
> 
> Andrew (5):
>   uapi/linux/if_tun.h: Added new offload types for USO4/6.
>   driver/net/tun: Added features for USO.
>   uapi/linux/virtio_net.h: Added USO types.
>   linux/virtio_net.h: Support USO offload in vnet header.
>   drivers/net/virtio_net.c: Added USO support.
> 
> Andrew Melnychenko (1):
>   udp: allow header check for dodgy GSO_UDP_L4 packets.

I don't see patches except 0 on list.

>  drivers/net/tap.c               | 10 ++++++++--
>  drivers/net/tun.c               |  8 +++++++-
>  drivers/net/virtio_net.c        | 24 +++++++++++++++++++++---
>  include/linux/virtio_net.h      |  9 +++++++++
>  include/uapi/linux/if_tun.h     |  2 ++
>  include/uapi/linux/virtio_net.h |  5 +++++
>  net/ipv4/udp_offload.c          |  3 ++-
>  net/ipv6/udp_offload.c          |  3 ++-
>  8 files changed, 56 insertions(+), 8 deletions(-)
> 
> -- 
> 2.38.1
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
