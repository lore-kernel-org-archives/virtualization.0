From: Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH v4 13/25] virtio_console: enable VQs early
Date: Mon, 20 Oct 2014 14:10:52 +0100
Message-ID: <20141020131052.GB18561__44923.9056710669$1413820916$gmane$org@casper.infradead.org>
References: <1413114332-626-1-git-send-email-mst-v4@redhat.com>
	<1413114332-626-14-git-send-email-mst-v4@redhat.com>
	<20141020120750.GA18561@casper.infradead.org>
	<20141020144223.5655dcbc.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141020144223.5655dcbc.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit.shah@redhat.com>, v9fs-developer@lists.sourceforge.net, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 10/20/14 at 02:42pm, Cornelia Huck wrote:
> On Mon, 20 Oct 2014 13:07:50 +0100
> Thomas Graf <tgraf@suug.ch> wrote:
> 
> > On 10/13/14 at 10:50am, Michael S. Tsirkin wrote:
> > > virtio spec requires drivers to set DRIVER_OK before using VQs.
> > > This is set automatically after probe returns, virtio console violated this
> > > rule by adding inbufs, which causes the VQ to be used directly within
> > > probe.
> > > 
> > > To fix, call virtio_device_ready before using VQs.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/char/virtio_console.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > > index b585b47..6ebe8f6 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -1449,6 +1449,8 @@ static int add_port(struct ports_device *portdev, u32 id)
> > >  	spin_lock_init(&port->outvq_lock);
> > >  	init_waitqueue_head(&port->waitqueue);
> > >  
> > > +	virtio_device_ready(portdev->vdev);
> > > +
> > >  	/* Fill the in_vq with buffers so the host can send us data. */
> > >  	nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
> > >  	if (!nr_added_bufs) {
> > 
> > Seems like probe and add_port() now both set VIRTIO_CONFIG_S_DRIVER_OK
> 
> I think we need to set this in the probe function instead, otherwise we
> fail for multiqueue (which also wants to use the control queue early).
> 
> Completely untested patch below; I can send this with proper s-o-b if
> it helps.

virtio_dev_probe() already sets DRIVER_OK if ->probe() returned
without an error. I assume Michael added it to add_port() because
probing doesn't always occur first. Can we just remove the BUG_ON()?
