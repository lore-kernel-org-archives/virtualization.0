Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E497C433FE
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 08:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F1E6812DE;
	Mon, 14 Nov 2022 08:57:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F1E6812DE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=h/7QZlbc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hca_wmOayquh; Mon, 14 Nov 2022 08:57:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 39E1280BA6;
	Mon, 14 Nov 2022 08:57:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39E1280BA6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2BFEC0033;
	Mon, 14 Nov 2022 08:57:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 406D8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D4C640277
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:57:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D4C640277
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=h/7QZlbc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6MI6ABYrnoVd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:57:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F92D4023B
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F92D4023B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 08:57:08 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 374FD60EC7;
 Mon, 14 Nov 2022 08:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E35DC433C1;
 Mon, 14 Nov 2022 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1668416226;
 bh=SneOeuh4XSzDuYIwr4CoDX87df1Ue2RthGJkbj7xXr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h/7QZlbclg5G94UghYgRrC4MhghMzD25vK2h9YDwFo0nzkdwfsKWbFcv0GkMts+sM
 LlA4yI+itLJSY9JGkwIyTC733OfLQKE/PIydUa3gplG9+6kT4LJ8xauJzSPFf+3fQe
 Bi3bTtmAH3WQwKK8k3qtj/LUzjp5DVssEuWN1m+Y=
Date: Mon, 14 Nov 2022 09:57:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] virtio_console: Use an atomic to allocate virtual
 console numbers
Message-ID: <Y3IC3miVoiMROwaE@kroah.com>
References: <20221114080752.1900699-1-clg@kaod.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221114080752.1900699-1-clg@kaod.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Nov 14, 2022 at 09:07:52AM +0100, C=E9dric Le Goater wrote:
> When a virtio console port is initialized, it is registered as an hvc
> console using a virtual console number. If a KVM guest is started with
> multiple virtio console devices, the same vtermno (or virtual console
> number) can be used to allocate different hvc consoles, which leads to
> various communication problems later on.
> =

> This is also reported in debugfs :
> =

>   # grep vtermno /sys/kernel/debug/virtio-ports/*
>   /sys/kernel/debug/virtio-ports/vport1p1:console_vtermno: 1
>   /sys/kernel/debug/virtio-ports/vport2p1:console_vtermno: 1
>   /sys/kernel/debug/virtio-ports/vport3p1:console_vtermno: 2
>   /sys/kernel/debug/virtio-ports/vport4p1:console_vtermno: 3
> =

> Fix the issue with an atomic variable and start the first console
> number at 1 as it is today.
> =

> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  drivers/char/virtio_console.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 9fa3c76a267f..253574f41e57 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -58,12 +58,13 @@ struct ports_driver_data {
>  	 * We also just assume the first console being initialised was
>  	 * the first one that got used as the initial console.
>  	 */
> -	unsigned int next_vtermno;
> +	atomic_t next_vtermno;
>  =

>  	/* All the console devices handled by this driver */
>  	struct list_head consoles;
>  };
> -static struct ports_driver_data pdrvdata =3D { .next_vtermno =3D 1};
> +
> +static struct ports_driver_data pdrvdata =3D { .next_vtermno =3D ATOMIC_=
INIT(0) };
>  =

>  static DEFINE_SPINLOCK(pdrvdata_lock);
>  static DECLARE_COMPLETION(early_console_added);
> @@ -1244,7 +1245,7 @@ static int init_port_console(struct port *port)
>  	 * pointers.  The final argument is the output buffer size: we
>  	 * can do any size, so we put PAGE_SIZE here.
>  	 */
> -	port->cons.vtermno =3D pdrvdata.next_vtermno;
> +	port->cons.vtermno =3D atomic_inc_return(&pdrvdata.next_vtermno);

Why not use a normal ida/idr structure here?

And why is this never decremented?

and finally, why not use the value that created the "vportN" number
instead?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
