Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ED9C05027
	for <virtualization@archiver.kernel.org>; Fri, 20 Jan 2023 12:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB6AC81E0A;
	Fri, 20 Jan 2023 12:59:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB6AC81E0A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WC1OyKRq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o9svBT_hMsPt; Fri, 20 Jan 2023 12:59:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F34A81BE3;
	Fri, 20 Jan 2023 12:59:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F34A81BE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DE95C0033;
	Fri, 20 Jan 2023 12:59:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15F66C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1F3560EAA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:59:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1F3560EAA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WC1OyKRq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lsW0q4VHcwU8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:59:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2873660D61
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2873660D61
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674219593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNMmaz9aXWp8dmmkUCqryhR5pSgcfts2GGGLwXQogAg=;
 b=WC1OyKRqYeDwGGQCYp9X13NZZkrk7GRyJpsDRNxBIcv0PFAh2dk4DchDxQZgPvoGZeDkVE
 cZIyRKPLnpC3i5XHdHh3uUgEEO1hgp0Szvkyssfg4rQ9N3MUJZek7Di7MuiAJ48/KBDUJr
 RTNQNEfkj7BeeZPuCoY72YFYmJSYvqM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-miXZd5i7POOq1ojnjSfVHg-1; Fri, 20 Jan 2023 07:59:50 -0500
X-MC-Unique: miXZd5i7POOq1ojnjSfVHg-1
Received: by mail-wm1-f72.google.com with SMTP id
 k34-20020a05600c1ca200b003db30c3ed63so1112292wms.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Jan 2023 04:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNMmaz9aXWp8dmmkUCqryhR5pSgcfts2GGGLwXQogAg=;
 b=WNpHlIzOFaucMCVbmmqqf17vkdwsldnVs00aSo1ct6oSMNb/DeKuKHgotU/vzL7rgv
 YRVcwWfXX5MTuIISvDMp85kKqrbWT/scwPah4wW7uxAAWaR6OUFLGrBDpDl6l74ZmrG1
 lnjmYOy4NqmIKKxN0SVrpxHWCy0C5fxSlJOKRghtlU0U8Ivf+hzizSnci+yT+jWLH+ln
 FOkbiLU+8i9eeRVZXxiqLzjLMEqkBT5h5OmlPIkrgiA2uQDV9iEQCHv4a2GSxrAGoLib
 84QRK4u723pTdgrZ4CSxwOdiWogvlJf67rmI0JjhL3kNfWRhUhlx30iOXvfu6A4PVfGB
 slyg==
X-Gm-Message-State: AFqh2krXHnJ3ncHqEwyA5Wd41oRZcGJjwiZfBLiSLi1788RLLsfy/0QP
 f9SeJ1HT76KtQlQ6XGt05ql4FBo0eEGDeYMTIIWqEzpgLtfNorOCIS/RAJC8RSTreexhNiIYxSN
 f9fNDL7XG301ruZqh+JHl4NPlIv6MjO9UbUsX3VFdnA==
X-Received: by 2002:a05:600c:3d98:b0:3d6:ecc4:6279 with SMTP id
 bi24-20020a05600c3d9800b003d6ecc46279mr10350555wmb.27.1674219588936; 
 Fri, 20 Jan 2023 04:59:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt1rDVbBpQ3DlhTm2hQw+6Fpr2BkmomVLr2yMXKq89LfWNXBSPNtUsMb6Cu3+DBPqxwVx4taw==
X-Received: by 2002:a05:600c:3d98:b0:3d6:ecc4:6279 with SMTP id
 bi24-20020a05600c3d9800b003d6ecc46279mr10350535wmb.27.1674219588688; 
 Fri, 20 Jan 2023 04:59:48 -0800 (PST)
Received: from redhat.com ([2.52.19.29]) by smtp.gmail.com with ESMTPSA id
 k16-20020a7bc410000000b003d99469ece1sm2181710wmi.24.2023.01.20.04.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jan 2023 04:59:48 -0800 (PST)
Date: Fri, 20 Jan 2023 07:59:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <20230120075729-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elena.reshetova@intel.com, kirill.shutemov@linux.intel.com
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

On Thu, Jan 19, 2023 at 03:57:17PM +0200, Alexander Shishkin wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The ADD_PORT operation reads and sanity checks the port id multiple
> times from the untrusted host. This is not safe because a malicious
> host could change it between reads.
> 
> Read the port id only once and cache it for subsequent uses.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


I suspect anyone worried about this kind of thing already uses a bounce
buffer. No?  The patch itself makes the code more readable, except maybe
for the READ_ONCE thing.


> ---
>  drivers/char/virtio_console.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index f4fd5fe7cd3a..6599c2956ba4 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1563,10 +1563,13 @@ static void handle_control_message(struct virtio_device *vdev,
>  	struct port *port;
>  	size_t name_size;
>  	int err;
> +	unsigned id;
>  
>  	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
>  
> -	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
> +	/* Make sure the host cannot change id under us */
> +	id = virtio32_to_cpu(vdev, READ_ONCE(cpkt->id));
> +	port = find_port_by_id(portdev, id);
>  	if (!port &&
>  	    cpkt->event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
>  		/* No valid header at start of buffer.  Drop it. */
> @@ -1583,15 +1586,14 @@ static void handle_control_message(struct virtio_device *vdev,
>  			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
>  			break;
>  		}
> -		if (virtio32_to_cpu(vdev, cpkt->id) >=
> -		    portdev->max_nr_ports) {
> +		if (id >= portdev->max_nr_ports) {
>  			dev_warn(&portdev->vdev->dev,
>  				"Request for adding port with "
>  				"out-of-bound id %u, max. supported id: %u\n",
>  				cpkt->id, portdev->max_nr_ports - 1);
>  			break;
>  		}
> -		add_port(portdev, virtio32_to_cpu(vdev, cpkt->id));
> +		add_port(portdev, id);
>  		break;
>  	case VIRTIO_CONSOLE_PORT_REMOVE:
>  		unplug_port(port);
> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
