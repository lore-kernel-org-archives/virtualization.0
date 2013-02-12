From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_console: Let unconnected rproc device receive data.
Date: Tue, 12 Feb 2013 11:42:42 +0200
Message-ID: <20130212094242.GC22567@redhat.com>
References: <1358425362-4517-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130125091024.GB30483@amit.redhat.com>
	<81C3A93C17462B4BBD7E272753C105792458D7DEEF@EXDCVYMBSTM005.EQ1STM.local>
	<CAJK669a7yr2Fo2Asrthtq5osLynurkuM_k_yO1GTsOTNaho+Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJK669a7yr2Fo2Asrthtq5osLynurkuM_k_yO1GTsOTNaho+Dg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?iso-8859-1?Q?Br=E6ndeland?= <sjurbren@gmail.com>
Cc: Amit Shah <amit.shah@redhat.com>, Erwan.Yvin@stericsson.com, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 12, 2013 at 10:14:59AM +0100, Sjur Br=E6ndeland wrote:
> Hi Amit,
> =

> > > @@ -1763,8 +1763,11 @@ static void in_intr(struct virtqueue *vq)
> >
> > > >      * tty is spawned) and the host sends out data to console
> > > >      * ports.  For generic serial ports, the host won't
> > > >      * (shouldn't) send data till the guest is connected.
> > > > +    * However a remote device might send data before the port is
> > > > +    * connected. So don't remove data from a rproc_serial device.
> > > >      */
> > > > -   if (!port->guest_connected)
> > > > +
> > > > +   if (!port->guest_connected && !is_rproc_serial(port->portdev-
> > > >vdev))
> > > >             discard_port_data(port);
> > >
> > > How about setting port->guest_connected =3D true in the init routines
> > > instead?  Keeps this code path cleaner.
> >
> > Agree, I'll respin this patch.
> =

> Hm, Rusty has already picked this up.

I don't see it in virtio-next. Do you?

> Do you still want me to do a respin,
> or should I leave it as is?
> =

> Regards,
> Sjur
