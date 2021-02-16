Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221A6C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 16:00:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C58614A5
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 16:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C58614A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E7C9F857B0;
	Tue, 16 Feb 2021 16:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7aOVbvkHyQbk; Tue, 16 Feb 2021 16:00:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0038684799;
	Tue, 16 Feb 2021 16:00:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6E16C0893;
	Tue, 16 Feb 2021 16:00:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB863C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 16:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA4CA87111
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 16:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wPY8AiM2n01Y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 16:00:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E030786FEF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=zD9+E+ZI4r3/IBpj+enzwdFwXkNHRFx6629chcrO5Jo=; b=Oq2osaDx94R7D/gXckdRgZY3EW
 cox0JwwMGIN6w+fM0S1vOf3NpfkLg5pRxu06MvfhBwb3n6MwSPgkkBEZuehydylfbqzne4ENz+0Hk
 U5i8EN86I/c3J/GG4FIAh/mrLBu/UMTcuLz236NCC1lc98wt0SmsoFg3xBeVh6aXwKWed3dkd8ToV
 Il5iPUOp9wjZRn5qQ67Mpm9+19G9gkqWc8FsaUkgZ9zxBfowOu7YC/widj60xKG08dS+kzqPsTjqm
 sy8DtAsNydq7IRDBMVYhHBcbr09NkAs4znIYHMIC8k7sxhSmxcSatowBqRnEkXJXU8ItStj6RWNWf
 wNELq1hQ==;
Received: from [54.239.6.185] (helo=freeip.amazon.com)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lC2m4-0008Lk-8i; Tue, 16 Feb 2021 16:00:28 +0000
Message-ID: <425a47ad4de9f0f7bd00daf446566e59a9081c7e.camel@infradead.org>
Subject: Re: [PATCH] virtio_console: remove pointless check for
 debugfs_create_dir()
From: Amit Shah <amit@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 virtualization@lists.linux-foundation.org
Date: Tue, 16 Feb 2021 17:00:26 +0100
In-Reply-To: <20210216150410.3844635-1-gregkh@linuxfoundation.org>
References: <20210216150410.3844635-1-gregkh@linuxfoundation.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>
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

On Tue, 2021-02-16 at 16:04 +0100, Greg Kroah-Hartman wrote:
> It is impossible for debugfs_create_dir() to return NULL, so checking
> for it gives people a false sense that they actually are doing something
> if an error occurs.  As there is no need to ever change kernel logic if
> debugfs is working "properly" or not, there is no need to check the
> return value of debugfs calls, so remove the checks here as they will
> never be triggered and are wrong.
> 
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/virtio_console.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 1836cc56e357..59dfd9c421a1 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1456,18 +1456,15 @@ static int add_port(struct ports_device *portdev, u32 id)
>  	 */
>  	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
>  
> -	if (pdrvdata.debugfs_dir) {
> -		/*
> -		 * Finally, create the debugfs file that we can use to
> -		 * inspect a port's state at any time
> -		 */
> -		snprintf(debugfs_name, sizeof(debugfs_name), "vport%up%u",
> -			 port->portdev->vdev->index, id);
> -		port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
> -							 pdrvdata.debugfs_dir,
> -							 port,
> -							 &port_debugfs_fops);
> -	}
> +	/*
> +	 * Finally, create the debugfs file that we can use to
> +	 * inspect a port's state at any time
> +	 */
> +	snprintf(debugfs_name, sizeof(debugfs_name), "vport%up%u",
> +		 port->portdev->vdev->index, id);
> +	port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
> +						 pdrvdata.debugfs_dir,
> +						 port, &port_debugfs_fops);
>  	return 0;
>  
>  free_inbufs:
> @@ -2244,8 +2241,6 @@ static int __init init(void)
>  	}
>  
>  	pdrvdata.debugfs_dir = debugfs_create_dir("virtio-ports", NULL);
> -	if (!pdrvdata.debugfs_dir)
> -		pr_warn("Error creating debugfs dir for virtio-ports\n");
>  	INIT_LIST_HEAD(&pdrvdata.consoles);
>  	INIT_LIST_HEAD(&pdrvdata.portdevs);
> 

Reviewed-by: Amit Shah <amit@kernel.org>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
