Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6478EC433E0
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:44:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E7DF2075D
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Axx4j12o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7DF2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2835287F73;
	Tue,  4 Aug 2020 14:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qFVif1J00jXc; Tue,  4 Aug 2020 14:44:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7058B87F71;
	Tue,  4 Aug 2020 14:44:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51FA3C0051;
	Tue,  4 Aug 2020 14:44:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BF33C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 70EE087F73
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eiMm1+U-YJze
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:44:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CE19E87F71
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596552291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0qQRP6FVPdcWxTvN3l6bnjm2x6UvPqdNJFTqbZG61E=;
 b=Axx4j12onfDhJZsOfVnKjbtVCasuL9DxopB/YTSYkNdXsB0l7ekRLPYwy6RM9gyC19XLMt
 sT4cuTnWQjJ/sFraWxZrQ6Owe6+/GTNommOP/IZsJjAhciVPhBgUCLZ+f9t8YYNHCsq1G1
 7lLdW/NUrQigRd99mp2UHFg2tniCYMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-zTJjV6pBNTK9yFuI5a2tmQ-1; Tue, 04 Aug 2020 10:44:49 -0400
X-MC-Unique: zTJjV6pBNTK9yFuI5a2tmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 564DB8BB686;
 Tue,  4 Aug 2020 14:44:48 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 731771001B2B;
 Tue,  4 Aug 2020 14:44:47 +0000 (UTC)
Date: Tue, 4 Aug 2020 16:44:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 14/24] virtio_net: correct tags for config space fields
Message-ID: <20200804164444.5174452d.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-15-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-15-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, 3 Aug 2020 16:59:37 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Tag config space fields as having virtio endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_net.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 19d23e5baa4e..27d996f29dd1 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -87,19 +87,19 @@ struct virtio_net_config {
>  	/* The config defining mac address (if VIRTIO_NET_F_MAC) */
>  	__u8 mac[ETH_ALEN];
>  	/* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
> -	__u16 status;
> +	__virtio16 status;
>  	/* Maximum number of each of transmit and receive queues;
>  	 * see VIRTIO_NET_F_MQ and VIRTIO_NET_CTRL_MQ.
>  	 * Legal values are between 1 and 0x8000
>  	 */
> -	__u16 max_virtqueue_pairs;
> +	__virtio16 max_virtqueue_pairs;
>  	/* Default maximum transmit unit advice */
> -	__u16 mtu;
> +	__virtio16 mtu;
>  	/*
>  	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
>  	 * Any other value stands for unknown.
>  	 */
> -	__u32 speed;
> +	__virtio32 speed;

Hm... VIRTIO_NET_F_SPEED_DUPLEX can only be negotiated if VERSION_1 has
also been negotiated; I think this should be __le32?

>  	/*
>  	 * 0x00 - half duplex
>  	 * 0x01 - full duplex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
