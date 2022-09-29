Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9A4C04A95
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AF9B419E2;
	Thu, 29 Sep 2022 07:00:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AF9B419E2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Il5V+K0Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sFm2t3GkBG1B; Thu, 29 Sep 2022 07:00:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 923C0419D8;
	Thu, 29 Sep 2022 07:00:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 923C0419D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67C41C0032;
	Thu, 29 Sep 2022 07:00:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19B7DC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3F25819D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:00:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D3F25819D2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Il5V+K0Q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pSr_-OZghb8y
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:00:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C93681771
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C93681771
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664434819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=siVqAVCemr3NKP1W8qdwtDUtzgPJwy1cV7KpGtWXqJw=;
 b=Il5V+K0Qd061c0hZAmecUk4GCsjzbwQg+g3zvIjQFJ6AlxpL+6D981N4rbuWZUbgAS3ZAi
 fbAbDxnYRKGJdvRBK9Var5XJiq1SnZ8QTlIZpWJK/dan9uswikOcPyJ6pWveE9gvkRqDIX
 /39zEbp8AGqjzgw/9/qbW46HDTMClwE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-385-PBoT8UVVMP2xOFjEO367Jw-1; Thu, 29 Sep 2022 03:00:17 -0400
X-MC-Unique: PBoT8UVVMP2xOFjEO367Jw-1
Received: by mail-wr1-f69.google.com with SMTP id
 i1-20020adfa501000000b0022cd1e1137bso156886wrb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=siVqAVCemr3NKP1W8qdwtDUtzgPJwy1cV7KpGtWXqJw=;
 b=i990DmluhehWkCon10QTL/Vy9DzC29Nf4LTkKXo+PCAMduCQbhVwaHDYyjuwRlUtA4
 4hQ1R3Xp1kuCGJYtrZ+vRjT5YKE0ffctBuCC5aC5xpljo/0142ENghW3GOpyODCjAgm7
 bQUm3fJ2H47CrP1zl1sfYlY8PaR09xHbFsa5N9GtGzBDDzuR8z5iSK2p5xVaFzAB4kQd
 L730PQTUmbuWk8LE+fFhpuBhpsDVbLNgTnvi24PF/Gdfbii/GMvhEMEP5ndljZuBwPra
 2JA0RotPzEAbEFUAqnN9wL24Q2tE3gOLeiRsi9YJGMbziggpWTWxW3l1NHYSS7U3bOFW
 E1mA==
X-Gm-Message-State: ACrzQf3SI7Gt4KWRk50nBpYd+0x8hMWfv/7gZeI9qdygmu0OcGWu2q4s
 W++prm7P9Pxr6uHBKPGNDh9l2nE9U7GlTNlOZqJ+Nw6xRcUvSEQE0M48OjaOFebG8UifcP5jbmT
 OeXbiuuECFH161bmI4vEiLjLr0maBPEZvYUdTqPU+6w==
X-Received: by 2002:adf:fb50:0:b0:22a:e4e9:a6b3 with SMTP id
 c16-20020adffb50000000b0022ae4e9a6b3mr980594wrs.467.1664434816657; 
 Thu, 29 Sep 2022 00:00:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Evcri6XbqauFOm2LZgvV3/+osg0i+bYVRABZfrHmkdTJzc7KusTw0CxXeXlGDXMd4NT2c9A==
X-Received: by 2002:adf:fb50:0:b0:22a:e4e9:a6b3 with SMTP id
 c16-20020adffb50000000b0022ae4e9a6b3mr980575wrs.467.1664434816424; 
 Thu, 29 Sep 2022 00:00:16 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 2-20020a05600c228200b003a6a3595edasm3528412wmf.27.2022.09.29.00.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 00:00:15 -0700 (PDT)
Date: Thu, 29 Sep 2022 03:00:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavinl@nvidia.com>
Subject: Re: [PATCH v6 0/2] Improve virtio performance for 9k mtu
Message-ID: <20220929025946-mutt-send-email-mst@kernel.org>
References: <20220914144911.56422-1-gavinl@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220914144911.56422-1-gavinl@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, sridhar.samudrala@intel.com,
 jesse.brandeburg@intel.com, virtualization@lists.linux-foundation.org,
 stephen@networkplumber.org, loseweigh@gmail.com, netdev@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net
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

On Wed, Sep 14, 2022 at 05:49:09PM +0300, Gavin Li wrote:
> This small series contains two patches that improves virtio netdevice
> performance for 9K mtu when GRO/ guest TSO is disabled.
> 
> Gavin Li (2):
>   virtio-net: introduce and use helper function for guest gso support
>     checks


series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

this is net-next material


> ---
> changelog:
> v4->v5
> - Addressed comments from Michael S. Tsirkin
> - Remove unnecessary () in return clause
> v1->v2
> - Add new patch
> ---
>   virtio-net: use mtu size as buffer length for big packets
> ---
> changelog:
> v5->v6
> - Addressed comments from Jason and Michael S. Tsirkin
> - Remove wrong commit log description
> - Rename virtnet_set_big_packets_fields with virtnet_set_big_packets
> - Add more test results for different feature combinations
> v4->v5
> - Addressed comments from Michael S. Tsirkin
> - Improve commit message
> v3->v4
> - Addressed comments from Si-Wei
> - Rename big_packets_sg_num with big_packets_num_skbfrags
> v2->v3
> - Addressed comments from Si-Wei
> - Simplify the condition check to enable the optimization
> v1->v2
> - Addressed comments from Jason, Michael, Si-Wei.
> - Remove the flag of guest GSO support, set sg_num for big packets and
>   use it directly
> - Recalculate sg_num for big packets in virtnet_set_guest_offloads
> - Replace the round up algorithm with DIV_ROUND_UP
> ---
> 
>  drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
