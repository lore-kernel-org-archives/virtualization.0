Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B62AC433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 13:33:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B5D61373
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 13:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0B5D61373
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3FFA83D6A;
	Tue,  5 Oct 2021 13:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y8XQgsqxe97v; Tue,  5 Oct 2021 13:33:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5CAB983D74;
	Tue,  5 Oct 2021 13:33:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32E18C000F;
	Tue,  5 Oct 2021 13:33:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B98DC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 13:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E2CB83D74
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 13:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MrWNnRhFBqRL
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 13:33:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 747D683D6A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 13:33:44 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE28F61354;
 Tue,  5 Oct 2021 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1633440824;
 bh=ZUUrKlD8Dxp8jS8b/ulbcqRNvv1zelSYWWpWiZKXWgI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e3Nt8yedFhKHuTLKdQwElOYdptr1+5wQVSTeAilOgmFqhNRctCSHlLmpXZuRdzAOj
 7gUMkK7wrtxAeyiDA81CbKI4JMje0iIlOeeVxOvf9R4g2dYUTAfbhapky2TaelSFY3
 tjQNL7I1fRZH6LlPKEvHFsp3dBFjknffH5PAEUFY=
Date: Tue, 5 Oct 2021 15:33:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_console: break out of buf poll on remove
Message-ID: <YVxUNudHGxURHH/4@kroah.com>
References: <20211005070354.265164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211005070354.265164-1-mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>
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

On Tue, Oct 05, 2021 at 03:04:07AM -0400, Michael S. Tsirkin wrote:
> A common pattern for device reset is currently:
> vdev->config->reset(vdev);
> .. cleanup ..
> 
> reset prevents new interrupts from arriving and waits for interrupt
> handlers to finish.
> 
> However if - as is common - the handler queues a work request which is
> flushed during the cleanup stage, we have code adding buffers / trying
> to get buffers while device is reset. Not good.
> 
> This was reproduced by running
> 	modprobe virtio_console
> 	modprobe -r virtio_console
> in a loop.

That's a pathological case that is not "in the field" except by people
who want to abuse the system as root.  And they can do much worse things
than that.

> Fixing this comprehensively needs some thought, and new APIs.
> Let's at least handle the specific case of virtio_console
> removal that was reported in the field.

Let's fix this correctly, don't just hack it up now.

> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1786239
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/char/virtio_console.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 7eaf303a7a86..c852ce0b4d56 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1956,6 +1956,12 @@ static void virtcons_remove(struct virtio_device *vdev)
>  	list_del(&portdev->list);
>  	spin_unlock_irq(&pdrvdata_lock);
>  
> +	/* Device is going away, exit any polling for buffers */
> +	virtio_break_device(vdev);
> +	if (use_multiport(portdev))
> +		flush_work(&portdev->control_work);
> +	else
> +		flush_work(&portdev->config_work);
>  	/* Disable interrupts for vqs */

newline before comment?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
