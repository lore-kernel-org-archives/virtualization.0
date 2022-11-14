Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC3AC43217
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 16:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0198360AA5;
	Mon, 14 Nov 2022 16:18:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0198360AA5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yfcJXHl/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5N_qj3ilrl6t; Mon, 14 Nov 2022 16:18:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B729605F6;
	Mon, 14 Nov 2022 16:18:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B729605F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DA22C0033;
	Mon, 14 Nov 2022 16:18:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73DEBC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 16:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40DEA60776
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 16:18:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40DEA60776
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Sh1a5J5ywLV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 16:18:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 403B5605F6
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 403B5605F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 16:18:30 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 654CCB81076;
 Mon, 14 Nov 2022 16:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C8FC433D7;
 Mon, 14 Nov 2022 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1668442706;
 bh=AqtzYtgXN3z9nM+kNUs9g6opjfSPy/5KmOAnNI1Je7U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yfcJXHl/qAG6UhIPzAWlKql8R2YTxkgePNZkoB8I8NWZmiEKmqYfi1uhCPxoI3NYl
 OGfPj1Tt77iI7zUf1D+TyWRFtZTxZgCJ5j7bVUv5VTN4r1ohjSqJNhTOUPdo/T0Jnw
 jZyOiBNTNPUxkdpLI0LWXbaswhvoUyMnH6i4XFnU=
Date: Mon, 14 Nov 2022 17:18:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] virtio_console: Use an atomic to allocate virtual
 console numbers
Message-ID: <Y3JqThFr67DJnGJL@kroah.com>
References: <20221114080752.1900699-1-clg@kaod.org>
 <Y3IC3miVoiMROwaE@kroah.com>
 <b0503354-2d1e-a93d-a6a5-6f6a1f55f0e2@kaod.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b0503354-2d1e-a93d-a6a5-6f6a1f55f0e2@kaod.org>
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

On Mon, Nov 14, 2022 at 05:03:40PM +0100, C=E9dric Le Goater wrote:
> On 11/14/22 09:57, Greg Kroah-Hartman wrote:
> > On Mon, Nov 14, 2022 at 09:07:52AM +0100, C=E9dric Le Goater wrote:
> > > When a virtio console port is initialized, it is registered as an hvc
> > > console using a virtual console number. If a KVM guest is started with
> > > multiple virtio console devices, the same vtermno (or virtual console
> > > number) can be used to allocate different hvc consoles, which leads to
> > > various communication problems later on.
> > > =

> > > This is also reported in debugfs :
> > > =

> > >    # grep vtermno /sys/kernel/debug/virtio-ports/*
> > >    /sys/kernel/debug/virtio-ports/vport1p1:console_vtermno: 1
> > >    /sys/kernel/debug/virtio-ports/vport2p1:console_vtermno: 1
> > >    /sys/kernel/debug/virtio-ports/vport3p1:console_vtermno: 2
> > >    /sys/kernel/debug/virtio-ports/vport4p1:console_vtermno: 3
> > > =

> > > Fix the issue with an atomic variable and start the first console
> > > number at 1 as it is today.
> > > =

> > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > ---
> > >   drivers/char/virtio_console.c | 8 ++++----
> > >   1 file changed, 4 insertions(+), 4 deletions(-)
> > > =

> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_cons=
ole.c
> > > index 9fa3c76a267f..253574f41e57 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -58,12 +58,13 @@ struct ports_driver_data {
> > >   	 * We also just assume the first console being initialised was
> > >   	 * the first one that got used as the initial console.
> > >   	 */
> > > -	unsigned int next_vtermno;
> > > +	atomic_t next_vtermno;
> > >   	/* All the console devices handled by this driver */
> > >   	struct list_head consoles;
> > >   };
> > > -static struct ports_driver_data pdrvdata =3D { .next_vtermno =3D 1};
> > > +
> > > +static struct ports_driver_data pdrvdata =3D { .next_vtermno =3D ATO=
MIC_INIT(0) };
> > >   static DEFINE_SPINLOCK(pdrvdata_lock);
> > >   static DECLARE_COMPLETION(early_console_added);
> > > @@ -1244,7 +1245,7 @@ static int init_port_console(struct port *port)
> > >   	 * pointers.  The final argument is the output buffer size: we
> > >   	 * can do any size, so we put PAGE_SIZE here.
> > >   	 */
> > > -	port->cons.vtermno =3D pdrvdata.next_vtermno;
> > > +	port->cons.vtermno =3D atomic_inc_return(&pdrvdata.next_vtermno);
> > =

> > Why not use a normal ida/idr structure here?
> =

> yes that works.
> =

> > And why is this never decremented?
> =

> The driver would then need to track the id allocation ...

That's what an ida/idr does.

> > and finally, why not use the value that created the "vportN" number
> > instead?
> =

> yes. we could also encode the tuple (vdev->index, port) using a bitmask,

No need for that, you already have a unique number in the name above,
why not use that?

> possibly using 'max_nr_ports' to reduce the port width.

Why is that an issue?  Maybe I am confused as to what this magic
"vtermno" is here.  Who uses it and why is the vportN number not
sufficient?

> VIRTCONS_MAX_PORTS
> seems a bit big for this device and QEMU sets the #ports to 31.
> =

> An ida might be simpler. One drawback is that an id can be reused for a
> different device/port tuple in case of an (unlikely) unplug/plug sequence.

What's wrong with that?  We do not have persistent device names from
within the kernel.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
