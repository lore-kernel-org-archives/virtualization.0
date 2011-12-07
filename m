From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v4 04/12] virtio: console: Add freeze and restore
	handlers to support S4
Date: Wed, 7 Dec 2011 16:29:55 +0530
Message-ID: <20111207105955.GJ4651@amit-x200.redhat.com>
References: <cover.1323199985.git.amit.shah@redhat.com>
	<9f09629340556ddac37135bc3aab233f1154f86a.1323199985.git.amit.shah@redhat.com>
	<20111207104323.GE8326@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111207104323.GE8326@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 07 Dec 2011 [12:43:24], Michael S. Tsirkin wrote:

> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index e14f5aa..fd2fd6f 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1844,6 +1844,60 @@ static unsigned int features[] = {
> >  	VIRTIO_CONSOLE_F_MULTIPORT,
> >  };
> >  
> > +#ifdef CONFIG_PM
> > +static int virtcons_freeze(struct virtio_device *vdev)
> > +{
> > +	struct ports_device *portdev;
> > +	struct port *port;
> > +
> > +	portdev = vdev->priv;
> > +
> > +	vdev->config->reset(vdev);
> 
> 
> So here, cancel_work_sync might still be running.
> If it does run, might it try to access the device
> config?  Could not determine this quickly, if yes it's a problem.

Similar to the other comment: I don't see why just resetting device
can cause config queue access to go bad.

		Amit
