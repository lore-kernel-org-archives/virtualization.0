Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E46C004D4
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 15:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD8FB400D9;
	Thu, 19 Jan 2023 15:18:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD8FB400D9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=RstmJ0ot
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MDTILwE4qmJg; Thu, 19 Jan 2023 15:18:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 64758401B1;
	Thu, 19 Jan 2023 15:18:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64758401B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DBB6C0032;
	Thu, 19 Jan 2023 15:18:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09410C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E463941B7C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:17:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E463941B7C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=RstmJ0ot
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jt0gwtqOSsfo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:17:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF1C041A4D
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF1C041A4D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 15:17:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0510561C3D;
 Thu, 19 Jan 2023 15:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAA2C433F0;
 Thu, 19 Jan 2023 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1674141476;
 bh=d+RJax+gn4iXgWIKUImZxLaGkCJ5L1Iboau8yyzzzoo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RstmJ0otBERnHgKaLfZmAkGg1CCZYd56wwtN40ndpz9lrPOBCMIOFK0CJYHfOmfso
 jc3mcT/BcLQShASUz3WUg/Z3vIokxDEnAY70iKfutYE4SC/aE7ClvHFkairLaXiNX8
 pB3vIyr8m2N79vEUrntQW9d/xfLWYhM83obdtkZg=
Date: Thu, 19 Jan 2023 16:17:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1 1/6] virtio console: Harden multiport against invalid
 host input
Message-ID: <Y8lfHKz08EVeNa5o@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-2-alexander.shishkin@linux.intel.com>
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

On Thu, Jan 19, 2023 at 03:57:16PM +0200, Alexander Shishkin wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> It's possible for the host to set the multiport flag, but pass in
> 0 multiports, which results in:
> 
> BUG: KASAN: slab-out-of-bounds in init_vqs+0x244/0x6c0 drivers/char/virtio_console.c:1878
> Write of size 8 at addr ffff888001cc24a0 by task swapper/1
> 
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.15.0-rc1-140273-gaab0bb9fbaa1-dirty #588
> Call Trace:
>  init_vqs+0x244/0x6c0 drivers/char/virtio_console.c:1878
>  virtcons_probe+0x1a3/0x5b0 drivers/char/virtio_console.c:2042
>  virtio_dev_probe+0x2b9/0x500 drivers/virtio/virtio.c:263
>  call_driver_probe drivers/base/dd.c:515
>  really_probe+0x1c9/0x5b0 drivers/base/dd.c:601
>  really_probe_debug drivers/base/dd.c:694
>  __driver_probe_device+0x10d/0x1f0 drivers/base/dd.c:754
>  driver_probe_device+0x68/0x150 drivers/base/dd.c:786
>  __driver_attach+0xca/0x200 drivers/base/dd.c:1145
>  bus_for_each_dev+0x108/0x190 drivers/base/bus.c:301
>  driver_attach+0x30/0x40 drivers/base/dd.c:1162
>  bus_add_driver+0x325/0x3c0 drivers/base/bus.c:618
>  driver_register+0xf3/0x1d0 drivers/base/driver.c:171
> ...
> 
> Add a suitable sanity check.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/virtio_console.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 6a821118d553..f4fd5fe7cd3a 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1843,6 +1843,9 @@ static int init_vqs(struct ports_device *portdev)
>  	int err;
>  
>  	nr_ports = portdev->max_nr_ports;
> +	if (use_multiport(portdev) && nr_ports < 1)
> +		return -EINVAL;
> +
>  	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
>  
>  	vqs = kmalloc_array(nr_queues, sizeof(struct virtqueue *), GFP_KERNEL);
> -- 
> 2.39.0
> 

Why did I only get a small subset of these patches?

And why is the whole thread not on lore.kernel.org?

And the term "hardening" is marketing fluff.   Just say, "properly parse
input" or something like that, as what you are doing is fixing
assumptions about the data here, not causing anything to be more (or
less) secure.

But, this still feels wrong.  Why is this happening here, in init_vqs()
and not in the calling function that already did a bunch of validation
of the ports and the like?  Are those checks not enough?  if not, fix it
there, don't spread it out all over the place...

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
