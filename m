From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCHv7 4/4] virtio_console: Add support for remoteproc serial
Date: Thu, 1 Nov 2012 13:09:51 +0530
Message-ID: <20121101073951.GA17012__7635.54136869988$1351756104$gmane$org@amit.redhat.com>
References: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
	<1350287856-5284-5-git-send-email-sjur.brandeland@stericsson.com>
	<878vayhsca.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <878vayhsca.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 23 Oct 2012 [12:17:49], Rusty Russell wrote:
> sjur.brandeland@stericsson.com writes:
> > From: Sjur Br=E6ndeland <sjur.brandeland@stericsson.com>

> > @@ -1415,7 +1524,16 @@ static void remove_port_data(struct port *port)
> >  =

> >  	/* Remove buffers we queued up for the Host to send us data in. */
> >  	while ((buf =3D virtqueue_detach_unused_buf(port->in_vq)))
> > -		free_buf(buf);
> > +		free_buf(buf, true);
> > +
> > +	/*
> > +	 * Remove buffers from out queue for rproc-serial. We cannot afford
> > +	 * to leak any DMA mem, so reclaim this memory even if this might be
> > +	 * racy for the remote processor.
> > +	 */
> > +	if (is_rproc_serial(port->portdev->vdev))
> > +		while ((buf =3D virtqueue_detach_unused_buf(port->out_vq)))
> > +			free_buf(buf, true);
> >  }
> =

> This seems wrong; either this is needed even if !is_rproc_serial(), or
> it's not necessary as the out_vq is empty.
> =

> Every path I can see has the device reset (in which case the queues
> should not be active), or we got a VIRTIO_CONSOLE_PORT_REMOVE event (in
> which case, the same).
> =

> I think we can have non-blocking writes which could leave buffers in
> out_vq: Amit?

Those get 'reclaimed' just above this hunk:


static void remove_port_data(struct port *port)
{
	struct port_buffer *buf;

	/* Remove unused data this port might have received. */
	discard_port_data(port);

	reclaim_consumed_buffers(port);

	/* Remove buffers we queued up for the Host to send us data in. */
	while ((buf =3D virtqueue_detach_unused_buf(port->in_vq)))
	      free_buf(buf, true);

  ...




> >  static void __exit fini(void)
> >  {
> > +	reclaim_dma_bufs();
> =

> Hmm, you didn't protect it here anyway...
> =

> Cheers,
> Rusty.

		Amit
