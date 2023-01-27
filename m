Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51457C38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 11:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD20D4012B;
	Fri, 27 Jan 2023 11:02:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD20D4012B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EUYqqrYc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id neJU5wHJPIKD; Fri, 27 Jan 2023 11:02:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5A3CA417C2;
	Fri, 27 Jan 2023 11:02:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A3CA417C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0812CC0032;
	Fri, 27 Jan 2023 11:02:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35928C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02B7E41CE5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02B7E41CE5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EUYqqrYc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VR3HFsIxN-0n
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:02:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C15BC41CE4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C15BC41CE4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674817371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M3zXIeNDbVEYsNZMd35a+KmGHR0oWBBKX2t8c6pdmTU=;
 b=EUYqqrYcWkEFLfoFmkOGCKM02hfTB/hUVZzGq0d3+oydtKMXClj69msIf9XuJRsx8zke2g
 eJYCuAq+DC6PcFuc/RWuucfd45MtLW91mGWLaK5UyNsv4hp4fRAKutrG6hyWxaasi/sJCY
 uO1ViTk9/SGCdcW/WLDl/HtfdCmqbr4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-67GYx-w8NI2bM2JOG9QoAw-1; Fri, 27 Jan 2023 06:02:50 -0500
X-MC-Unique: 67GYx-w8NI2bM2JOG9QoAw-1
Received: by mail-ed1-f69.google.com with SMTP id
 l17-20020a056402255100b00472d2ff0e59so3350087edb.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 03:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3zXIeNDbVEYsNZMd35a+KmGHR0oWBBKX2t8c6pdmTU=;
 b=pTnmETnnVGD1BtXMFys8CfQVL0ST3tUlNBncFiA+R9jT2Kc1M53TxFEXw4xgHZe9Zc
 9FQs8w9c6S75sbE9gEiWwu4UtFbO5uu7p1PurzRLTXN68WncrCfNSvHz4293FNL1yw77
 qMiaWRjVdVsLtWILns+5mpU28nIWM6oyskqFfs4KHqC1iyIb0NgnhrU9g+qxYU9+WsXo
 ZDy7mYa+K+JbQrzUG0CX6RhmbD5RXK1HAfugtR3ErZX1DsU2vPqqJAToQfeUnIq0JjXD
 pFCDMZLQVN62Q5RwgFb9IZ7LAE9Bj6lrnvKTJX9ZqTqVl8dSPkgP4LWwin/TVotUzX/f
 gUrw==
X-Gm-Message-State: AO0yUKXAGImrr3bOMgWcO53ODyRYyU7qFg7Ei5npKLH1hZhRuX6202+f
 2EdS1m4o+QdCDCJQST3he7GEx2MUhcle/GD4MLq+fpBBjjGeC+2eRKpibobEzpse8I/Ps2k3z0n
 htkl8HvNmVpgwGfgMychsJW5ELwciX0hIL/G30PFhtw==
X-Received: by 2002:aa7:cf93:0:b0:4a2:11c5:44f8 with SMTP id
 z19-20020aa7cf93000000b004a211c544f8mr777388edx.4.1674817369163; 
 Fri, 27 Jan 2023 03:02:49 -0800 (PST)
X-Google-Smtp-Source: AK7set8PiWQ9xvT7KQIyI66NVLLiZYQ81dkyQmfw+yrGfEARBdCHZXQ0VuwCg2F2/d1GqcgtuR2Ukg==
X-Received: by 2002:aa7:cf93:0:b0:4a2:11c5:44f8 with SMTP id
 z19-20020aa7cf93000000b004a211c544f8mr777366edx.4.1674817368972; 
 Fri, 27 Jan 2023 03:02:48 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 j25-20020a50ed19000000b004a20fa1c659sm412845eds.82.2023.01.27.03.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 03:02:48 -0800 (PST)
Date: Fri, 27 Jan 2023 06:02:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <20230127055944-mutt-send-email-mst@kernel.org>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
 <Y8lfz8C5uvx2w4fC@kroah.com> <87ilh2quto.fsf@ubik.fi.intel.com>
 <Y8mSs68JfW6t4mjl@kroah.com> <87a62eqo4h.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
In-Reply-To: <87a62eqo4h.fsf@ubik.fi.intel.com>
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

On Thu, Jan 19, 2023 at 10:13:18PM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > Then you need to copy it out once, and then only deal with the local
> > copy.  Otherwise you have an incomplete snapshot.
> 
> Ok, would you be partial to something like this:
> 
> >From 1bc9bb84004154376c2a0cf643d53257da6d1cd7 Mon Sep 17 00:00:00 2001
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Date: Thu, 19 Jan 2023 21:59:02 +0200
> Subject: [PATCH] virtio console: Keep a local copy of the control structure
> 
> When handling control messages, instead of peeking at the device memory
> to obtain bits of the control structure,

Except the message makes it seem that we are getting data from
device memory, when we do nothing of the kind.

> take a snapshot of it once and
> use it instead, to prevent it from changing under us. This avoids races
> between port id validation and control event decoding, which can lead
> to, for example, a NULL dereference in port removal of a nonexistent
> port.
> 
> The control structure is small enough (8 bytes) that it can be cached
> directly on the stack.

I still have no real idea why we want a copy here.
If device can poke anywhere at memory then it can crash kernel anyway.
If there's a bounce buffer or an iommu or some other protection
in place, then this memory can no longer change by the time
we look at it.

> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Amit Shah <amit@kernel.org>
> ---
>  drivers/char/virtio_console.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 6a821118d553..42be0991a72f 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1559,23 +1559,24 @@ static void handle_control_message(struct virtio_device *vdev,
>  				   struct ports_device *portdev,
>  				   struct port_buffer *buf)
>  {
> -	struct virtio_console_control *cpkt;
> +	struct virtio_console_control cpkt;
>  	struct port *port;
>  	size_t name_size;
>  	int err;
>  
> -	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
> +	/* Keep a local copy of the control structure */
> +	memcpy(&cpkt, buf->buf + buf->offset, sizeof(cpkt));
>  
> -	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt->id));
> +	port = find_port_by_id(portdev, virtio32_to_cpu(vdev, cpkt.id));
>  	if (!port &&
> -	    cpkt->event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
> +	    cpkt.event != cpu_to_virtio16(vdev, VIRTIO_CONSOLE_PORT_ADD)) {
>  		/* No valid header at start of buffer.  Drop it. */
>  		dev_dbg(&portdev->vdev->dev,
> -			"Invalid index %u in control packet\n", cpkt->id);
> +			"Invalid index %u in control packet\n", cpkt.id);
>  		return;
>  	}
>  
> -	switch (virtio16_to_cpu(vdev, cpkt->event)) {
> +	switch (virtio16_to_cpu(vdev, cpkt.event)) {
>  	case VIRTIO_CONSOLE_PORT_ADD:
>  		if (port) {
>  			dev_dbg(&portdev->vdev->dev,
> @@ -1583,21 +1584,21 @@ static void handle_control_message(struct virtio_device *vdev,
>  			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
>  			break;
>  		}
> -		if (virtio32_to_cpu(vdev, cpkt->id) >=
> +		if (virtio32_to_cpu(vdev, cpkt.id) >=
>  		    portdev->max_nr_ports) {
>  			dev_warn(&portdev->vdev->dev,
>  				"Request for adding port with "
>  				"out-of-bound id %u, max. supported id: %u\n",
> -				cpkt->id, portdev->max_nr_ports - 1);
> +				cpkt.id, portdev->max_nr_ports - 1);
>  			break;
>  		}
> -		add_port(portdev, virtio32_to_cpu(vdev, cpkt->id));
> +		add_port(portdev, virtio32_to_cpu(vdev, cpkt.id));
>  		break;
>  	case VIRTIO_CONSOLE_PORT_REMOVE:
>  		unplug_port(port);
>  		break;
>  	case VIRTIO_CONSOLE_CONSOLE_PORT:
> -		if (!cpkt->value)
> +		if (!cpkt.value)
>  			break;
>  		if (is_console_port(port))
>  			break;
> @@ -1618,7 +1619,7 @@ static void handle_control_message(struct virtio_device *vdev,
>  		if (!is_console_port(port))
>  			break;
>  
> -		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
> +		memcpy(&size, buf->buf + buf->offset + sizeof(cpkt),
>  		       sizeof(size));
>  		set_console_size(port, size.rows, size.cols);
>  
> @@ -1627,7 +1628,7 @@ static void handle_control_message(struct virtio_device *vdev,
>  		break;
>  	}
>  	case VIRTIO_CONSOLE_PORT_OPEN:
> -		port->host_connected = virtio16_to_cpu(vdev, cpkt->value);
> +		port->host_connected = virtio16_to_cpu(vdev, cpkt.value);
>  		wake_up_interruptible(&port->waitqueue);
>  		/*
>  		 * If the host port got closed and the host had any
> @@ -1658,7 +1659,7 @@ static void handle_control_message(struct virtio_device *vdev,
>  		 * Skip the size of the header and the cpkt to get the size
>  		 * of the name that was sent
>  		 */
> -		name_size = buf->len - buf->offset - sizeof(*cpkt) + 1;
> +		name_size = buf->len - buf->offset - sizeof(cpkt) + 1;
>  
>  		port->name = kmalloc(name_size, GFP_KERNEL);
>  		if (!port->name) {
> @@ -1666,7 +1667,7 @@ static void handle_control_message(struct virtio_device *vdev,
>  				"Not enough space to store port name\n");
>  			break;
>  		}
> -		strncpy(port->name, buf->buf + buf->offset + sizeof(*cpkt),
> +		strncpy(port->name, buf->buf + buf->offset + sizeof(cpkt),
>  			name_size - 1);
>  		port->name[name_size - 1] = 0;
>  
> -- 
> 2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
