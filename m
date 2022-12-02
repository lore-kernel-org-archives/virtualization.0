Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010ADC4332F
	for <virtualization@archiver.kernel.org>; Fri,  2 Dec 2022 10:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75B6560BC4;
	Fri,  2 Dec 2022 10:03:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 75B6560BC4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h0u4/AbG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8u867BbyXzKw; Fri,  2 Dec 2022 10:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 819BB60B83;
	Fri,  2 Dec 2022 10:03:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 819BB60B83
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 564A0C0033;
	Fri,  2 Dec 2022 10:03:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1FB3C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Dec 2022 10:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D0DC60BC4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Dec 2022 10:03:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D0DC60BC4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e7RduCiWIzyv
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Dec 2022 10:03:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E556A60B83
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E556A60B83
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Dec 2022 10:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669975410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9awmabG6XvbNEKd1oVF0XKSctjBCIkEyRVzKA78FSM=;
 b=h0u4/AbGsy0qmFLyEFn4dbqh1xwayqg2OuVW0x5KZ3aN63kGCHxjy+oQGpm8jka5xJiX0D
 xaPGS+CASFjSmtEB09mKF3AWwO2pxxwCtOrUB2JHqZYcBzG7Lq5vSmongcZ1goxz8mmE0m
 g0xGseYTQDvKHuapAdVahNvN0ywpmV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-rEs6BL0WOBqsLmhbeAV2qA-1; Fri, 02 Dec 2022 05:03:29 -0500
X-MC-Unique: rEs6BL0WOBqsLmhbeAV2qA-1
Received: by mail-wr1-f71.google.com with SMTP id
 y5-20020adfc7c5000000b002423fada7deso663339wrg.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Dec 2022 02:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9awmabG6XvbNEKd1oVF0XKSctjBCIkEyRVzKA78FSM=;
 b=krp3rwBU9bBmLVVBiEURi94k0HxoHHSRMV+aSqCxWGdxhlyB7m0VOz3iObCAILn4I5
 VVu6iq3BpTFr2Rq/v00GIlK3iKPNYOof8VwkNQ+LMLc9CUAXRg69gAyyh6Eo1r8c8oG+
 VHOG0PcWJhSUdx66lcA0+0aUjkxOpm7lr/Tnccp6W/alCqxe9E/oBkBJTylQlFiQxt0g
 pz30pg8dbhNkXIyAH5EIc0x3q3aBHZa0t/5LYy/3rj2LcaeLmqI1kOxKVuOk1Q0PqpH3
 2oqB7M/xhduO+KL8Dj5keZNYKMgda/4sn2JvreBFrqyzfrWmBc/qsS86r76ZpL3G+6Nr
 DK7w==
X-Gm-Message-State: ANoB5pk22MVZ1yPqaEXxD7BB0uFur+U3yqgmIwNr0hMowduah6tmtWST
 292R2byM8O6qhksyHLivC9JXnJdDYGGWjNpRdoBeC+aMP5SN95KxEV6QNyMwzEcHgMg7CDjWIsr
 i6Ge5bpKODzjRE3CNK2WbzAqcwJcU7y2Al2GyzQ7Xfw==
X-Received: by 2002:adf:dbcd:0:b0:242:1294:5174 with SMTP id
 e13-20020adfdbcd000000b0024212945174mr16694584wrj.249.1669975408254; 
 Fri, 02 Dec 2022 02:03:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6QQzz2WQf7FwPPGbf38zlKpQ+ep18wbfi3hGdiVjM24Y7h+bdOIA1f/rLK+OFoxrrZJquhlw==
X-Received: by 2002:adf:dbcd:0:b0:242:1294:5174 with SMTP id
 e13-20020adfdbcd000000b0024212945174mr16694570wrj.249.1669975408027; 
 Fri, 02 Dec 2022 02:03:28 -0800 (PST)
Received: from redhat.com ([2.52.16.138]) by smtp.gmail.com with ESMTPSA id
 w6-20020adfec46000000b0022efc4322a9sm6895537wrn.10.2022.12.02.02.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Dec 2022 02:03:27 -0800 (PST)
Date: Fri, 2 Dec 2022 05:03:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v4 4/6] uapi/linux/virtio_net.h: Added USO types.
Message-ID: <20221202050230-mutt-send-email-mst@kernel.org>
References: <20221201223332.249441-1-andrew@daynix.com>
 <20221201223332.249441-4-andrew@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20221201223332.249441-4-andrew@daynix.com>
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

On Fri, Dec 02, 2022 at 12:33:30AM +0200, Andrew Melnychenko wrote:
> Added new GSO type for USO: VIRTIO_NET_HDR_GSO_UDP_L4.
> Feature VIRTIO_NET_F_HOST_USO allows to enable NETIF_F_GSO_UDP_L4.
> Separated VIRTIO_NET_F_GUEST_USO4 & VIRTIO_NET_F_GUEST_USO6 features
> required for Windows guests.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/uapi/linux/virtio_net.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 6cb842ea8979..cbc631247489 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -57,6 +57,10 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
> +#define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
> +#define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
> +#define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
> +

for consistency pls don't add an empty line here.

>  #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
>  #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
>  #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
> @@ -130,6 +134,7 @@ struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
>  #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
>  #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
> +#define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4& IPv6 UDP (USO) */
>  #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
>  	__u8 gso_type;
>  	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
