From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 8/8] virtio: console: struct ports for multiple ports per
	device.
Date: Tue, 10 Nov 2009 23:21:42 +1030
Message-ID: <200911102321.42594.rusty@rustcorp.com.au>
References: <1257834450..rusty@rustcorp.com.au>
	<20091110093328.GA22563@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091110093328.GA22563@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 10 Nov 2009 08:03:28 pm Amit Shah wrote:
> On (Tue) Nov 10 2009 [16:57:30], Rusty Russell wrote:
> > 
> > Rather than assume a single port, add a 'struct ports' with an array
> > of ports.  Currently, there's always only one, but that will change.
> 
> Hey Rusty,

Hi Amit,

> > -static struct port *__devinit alloc_port(u32 vtermno)
> > +static struct ports *__devinit alloc_ports(unsigned int num)
> 
> This will have to be changed when we add support for hotplug. So instead
> of doing this, just have a linked list from the start?

No, for hotplug I think we just shift from a dangling array to a pointer
to an array.  That changes the alloc and free functions, but *not* change
to any users.

> Other than this, the series is good; I can base my patches on top of
> these.

Excellent!

> I guess we can also assign a number to each vdev that gets probed so
> that sysfs and debugfs entries for ports can be put in their
> vdev-specific directories, like
> 
> /sys/class/virtio-console0/vcon0/name

That makes sense; we do the same with virtio_blk IIRC.

> Also, if you think the send/receive workqueues are fine and we move to
> those, they will have to be introduced slightly earlier in this patch
> series.

So far I haven't seen a need for them.  This is simple and works.  But if
a later patch needs it, we do it and then maybe shuffle the patch backwards
in the sequence.

(As you can tell, I don't use git for development :)

Thanks,
Rusty.
