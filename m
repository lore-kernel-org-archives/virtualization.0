From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [PATCH] virtio_console: Let unconnected rproc device receive data.
Date: Fri, 25 Jan 2013 12:24:27 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C105792458D7DEEF@EXDCVYMBSTM005.EQ1STM.local>
References: <1358425362-4517-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130125091024.GB30483@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130125091024.GB30483@amit.redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Amit,

> > @@ -1763,8 +1763,11 @@ static void in_intr(struct virtqueue *vq)
> >  	 * tty is spawned) and the host sends out data to console
> >  	 * ports.  For generic serial ports, the host won't
> >  	 * (shouldn't) send data till the guest is connected.
> > +	 * However a remote device might send data before the port is
> > +	 * connected. So don't remove data from a rproc_serial device.
> >  	 */
> > -	if (!port->guest_connected)
> > +
> > +	if (!port->guest_connected && !is_rproc_serial(port->portdev-
> >vdev))
> >  		discard_port_data(port);
> 
> How about setting port->guest_connected = true in the init routines
> instead?  Keeps this code path cleaner.

Agree, I'll respin this patch.

Thanks,
Sjur
