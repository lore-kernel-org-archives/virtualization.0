Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B47BC25B4E
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 14:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E19C240C6C;
	Tue, 24 Jan 2023 14:24:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E19C240C6C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=cUqfsX3I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E3tRiTJm5azq; Tue, 24 Jan 2023 14:24:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB819400E2;
	Tue, 24 Jan 2023 14:24:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB819400E2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C79A9C0033;
	Tue, 24 Jan 2023 14:24:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 136B6C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1D2B60D58
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:24:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1D2B60D58
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=cUqfsX3I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ErzDJJOoWQiu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:24:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CE1160A7A
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CE1160A7A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:24:05 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id F1AD72184E;
 Tue, 24 Jan 2023 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674569864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xUFgq94lkIoqvnmIFB3kAZsDWNfWS7YvIhKyrZhAeC4=;
 b=cUqfsX3IZ+giAmku8cVWd/P58Q+rmT2DXmyKBfNz0LtIzD29jL7lZlg8RYWEPO7aaZxIlL
 2xwLkA7gDax4Br4cqoXGlZeF3yGW78vQs6MwG971l35sQp85hsgmakSDGBnDGKGU0bvggT
 MEwKU8jEODMygbr2xaU6usZxG7Z8AxU=
Received: from suse.cz (unknown [10.100.208.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CB5AC2C141;
 Tue, 24 Jan 2023 14:17:43 +0000 (UTC)
Date: Tue, 24 Jan 2023 15:17:43 +0100
To: "Seth Forshee (DigitalOcean)" <sforshee@digitalocean.com>
Subject: Re: [PATCH 2/2] vhost: check for pending livepatches from vhost
 worker kthreads
Message-ID: <Y8/ohzRGcOiqsh69@alley>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
 <20230120-vhost-klp-switching-v1-2-7c2b65519c43@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230120-vhost-klp-switching-v1-2-7c2b65519c43@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "Seth Forshee \(DigitalOcean\)" <sforshee@kernel.org>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 Josh Poimboeuf <jpoimboe@kernel.org>
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
From: Petr Mladek via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri 2023-01-20 16:12:22, Seth Forshee (DigitalOcean) wrote:
> Livepatch relies on stack checking of sleeping tasks to switch kthreads,
> so a busy kthread can block a livepatch transition indefinitely. We've
> seen this happen fairly often with busy vhost kthreads.

To be precise, it would be "indefinitely" only when the kthread never
sleeps.

But yes. I believe that the problem is real. It might be almost
impossible to livepatch some busy kthreads, especially when they
have a dedicated CPU.


> Add a check to call klp_switch_current() from vhost_worker() when a
> livepatch is pending. In testing this allowed vhost kthreads to switch
> immediately when they had previously blocked livepatch transitions for
> long periods of time.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  drivers/vhost/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index cbe72bfd2f1f..d8624f1f2d64 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -366,6 +367,9 @@ static int vhost_worker(void *data)
>  			if (need_resched())
>  				schedule();
>  		}
> +
> +		if (unlikely(klp_patch_pending(current)))
> +			klp_switch_current();

I suggest to use the following intead:

		if (unlikely(klp_patch_pending(current)))
			klp_update_patch_state(current);

We already use this in do_idle(). The reason is basically the same.
It is almost impossible to livepatch the idle task when a CPU is
very idle.

klp_update_patch_state(current) does not check the stack.
It switches the task immediately.

It should be safe because the kthread never leaves vhost_worker().
It means that the same kthread could never re-enter this function
and use the new code.

Best Regards,
Petr
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
