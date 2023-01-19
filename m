Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07BDC00A5A
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 15:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B55161170;
	Thu, 19 Jan 2023 15:20:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B55161170
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HEcAfPBm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sp5234zBC9Od; Thu, 19 Jan 2023 15:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E59A360AD8;
	Thu, 19 Jan 2023 15:20:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E59A360AD8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2635C0032;
	Thu, 19 Jan 2023 15:20:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7727BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 458DA401B1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:20:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 458DA401B1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=HEcAfPBm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Glq0p6OK4Ih6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:20:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DFE040102
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DFE040102
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:20:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B08D9616D5;
 Thu, 19 Jan 2023 15:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A6CC433F0;
 Thu, 19 Jan 2023 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1674141650;
 bh=Z93Mar8UW12+jdRSu1d1fZyY1H/c6Y49D8CTkfdzgSs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HEcAfPBm/7BVmv/yV865KTwPnKS5UGMl1qdsOR8KJ3rDL2pc52tEBsXD2CXJz2m5x
 VLLZ/zfEEBXJNFVj+0qP0nbXmi7h6AZ4lLhRK91qBWmMrVQqemGuGn17/aPClEyE60
 WBgDaw4IMYW4W4JgLmjwwW14n3Qt+Puypnj07mUE=
Date: Thu, 19 Jan 2023 16:20:47 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 2/6] virtio console: Harden port adding
Message-ID: <Y8lfz8C5uvx2w4fC@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-3-alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 mst@redhat.com, Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, elena.reshetova@intel.com,
 kirill.shutemov@linux.intel.com
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

Why READ_ONCE()?

And how can it change under us?  Is the message still under control of
the "host"?  If so, that feels wrong as this is all in kernel memory,
not userspace memory right?

If you are dealing with memory from a different process that you do not
trust, then you need to copy EVERYTHING at once.  Don't piece-meal copy
bits and bobs in all different places please.  Do it once and then parse
the local structure properly.

Otherwise this is going to be impossible to actually maintain over
time...

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
