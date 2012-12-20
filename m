From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] [PATCH v6 12/12] virtio-blk: add x-data-plane=on|off
	performance feature
Date: Thu, 20 Dec 2012 14:34:55 +1030
Message-ID: <87d2y51i8o.fsf@rustcorp.com.au>
References: <1355144985-12897-1-git-send-email-stefanha@redhat.com>
	<1355144985-12897-13-git-send-email-stefanha@redhat.com>
	<20121216160853.GC15790@redhat.com>
	<20121218145717.GA11063@stefanha-thinkpad.redhat.com>
	<20121218152239.GE27400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121218152239.GE27400@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, yvugenfi@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, khoa@us.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Tue, Dec 18, 2012 at 03:57:17PM +0100, Stefan Hajnoczi wrote:
>> > > @@ -407,6 +409,14 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>> > >          .num_writes = 0,
>> > >      };
>> > >  
>> > > +    /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
>> > > +     * dataplane here instead of waiting for .set_status().
>> > > +     */
>> > 
>> > By the way which guests are these?
>> 
>> I ran a Windows 8 guest today with build 48 virtio-win drivers.  It
>> notifies before the device gets its .set_status() callback invoked.
>> But I could swear I've seen Linux guests do this too.
>
>
> That's very broken. But looking at linux drivers it also
> seems linux guests do this even today.
> We have:
>
>        err = drv->probe(dev);
>         if (err)
>                 add_status(dev, VIRTIO_CONFIG_S_FAILED);
>         else {
>                 add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
>                 if (drv->scan)
>                         drv->scan(dev);
>         }
>
> this means that unless drivers implement scan() they
> will make device active before DRIVER_OK is written
> as the result linux can access it and kick.
> And almost no drivers implement scan.
> Nasty.

Yes, that's true.  But as long as they have completed feature
negotiation, we allow this (that's why we tool feature negotiation out
of the drivers).

For example, filling an input virtqueue may well mean we kick the vq,
and almost every device does this.

virtio_block is the worst: add_disk() does partition scanning.

> Rusty, what do you think? Worth fixing?

If we tried, I'm fairly sure things would slip through.  My feeling has
been that we should not rely on the status to indicate readiness.

> It does mean that for now we are stuck
> with a work around, but I think we need it
> in virtio core in qemu, it's not dataplane
> specific.

Yes, it's a general problem.

Cheers,
Rusty.
