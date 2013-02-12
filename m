From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH] virtio_console: Let unconnected rproc device receive data.
Date: Tue, 12 Feb 2013 10:14:59 +0100
Message-ID: <CAJK669a7yr2Fo2Asrthtq5osLynurkuM_k_yO1GTsOTNaho+Dg@mail.gmail.com>
References: <1358425362-4517-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130125091024.GB30483@amit.redhat.com>
	<81C3A93C17462B4BBD7E272753C105792458D7DEEF@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <81C3A93C17462B4BBD7E272753C105792458D7DEEF@EXDCVYMBSTM005.EQ1STM.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Erwan.Yvin@stericsson.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Amit,

> > @@ -1763,8 +1763,11 @@ static void in_intr(struct virtqueue *vq)
>
> > >      * tty is spawned) and the host sends out data to console
> > >      * ports.  For generic serial ports, the host won't
> > >      * (shouldn't) send data till the guest is connected.
> > > +    * However a remote device might send data before the port is
> > > +    * connected. So don't remove data from a rproc_serial device.
> > >      */
> > > -   if (!port->guest_connected)
> > > +
> > > +   if (!port->guest_connected && !is_rproc_serial(port->portdev-
> > >vdev))
> > >             discard_port_data(port);
> >
> > How about setting port->guest_connected = true in the init routines
> > instead?  Keeps this code path cleaner.
>
> Agree, I'll respin this patch.

Hm, Rusty has already picked this up. Do you still want me to do a respin,
or should I leave it as is?

Regards,
Sjur
