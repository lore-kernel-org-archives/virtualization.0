From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_rpmsg: set DRIVER_OK before using device
Date: Mon, 9 Mar 2015 09:27:31 +0100
Message-ID: <20150309082731.GB21823@redhat.com>
References: <1425754898-32707-1-git-send-email-mst@redhat.com>
	<87zj7mwstb.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87zj7mwstb.fsf@rustcorp.com.au>
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
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 09, 2015 at 05:39:20PM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > virtio spec requires that all drivers set DRIVER_OK
> > before using devices. While rpmsg isn't yet
> > included in the virtio 1 spec, previous spec versions
> > also required this.
> >
> > virtio rpmsg violates this rule: is calls kick
> > before setting DRIVER_OK.
> >
> > The fix isn't trivial since simply calling virtio_device_ready earlier
> > would mean we might get an interrupt in parallel with adding buffers.
> >
> > Instead, split kick out to prepare+notify calls.  prepare before
> > virtio_device_ready - when we know we won't get interrupts. notify right
> > afterwards.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Applied.  I'll wait for Ohad to ack before sending to Linus.
> 
> BTW I assume you have a version of qemu which warns on these kind of
> failures?  That'd be nice to have!
> 
> Thanks,
> Rusty.

Yes but it's hacky ATM - it's just a one-liner that checks
the status on kick and does fprintf(stderr).
I'm trying to rework the code so it'll actually
set the status automatically, but there are some difficulties there
when ioeventfd is used,
in particular we need a way to re-inject the kick
after status update.


> > ---
> >
> > Note: compile-tested only.
> >
> >  drivers/rpmsg/virtio_rpmsg_bus.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index 92f6af6..73354ee 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -951,6 +951,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >  	void *bufs_va;
> >  	int err = 0, i;
> >  	size_t total_buf_space;
> > +	bool notify;
> >  
> >  	vrp = kzalloc(sizeof(*vrp), GFP_KERNEL);
> >  	if (!vrp)
> > @@ -1030,8 +1031,22 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Prepare to kick but don't notify yet - we can't do this before
> > +	 * device is ready.
> > +	 */
> > +	notify = virtqueue_kick_prepare(vrp->rvq);
> > +
> > +	/* From this point on, we can notify and get callbacks. */
> > +	virtio_device_ready(vdev);
> > +
> >  	/* tell the remote processor it can start sending messages */
> > -	virtqueue_kick(vrp->rvq);
> > +	/*
> > +	 * this might be concurrent with callbacks, but we are only
> > +	 * doing notify, not a full kick here, so that's ok.
> > +	 */
> > +	if (notify)
> > +		virtqueue_notify(vrp->rvq);
> >  
> >  	dev_info(&vdev->dev, "rpmsg host is online\n");
> >  
> > -- 
> > MST
