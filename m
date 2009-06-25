From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio-serial: A guest <-> host interface for simple communication
Date: Thu, 25 Jun 2009 21:03:02 +0930
Message-ID: <200906252103.02892.rusty__10339.6914004863$1245929653$gmane$org@rustcorp.com.au>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<200906241345.02051.rusty@rustcorp.com.au>
	<20090624123937.GA14630@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090624123937.GA14630@amit-x200.redhat.com>
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 24 Jun 2009 10:09:37 pm Amit Shah wrote:
> On (Wed) Jun 24 2009 [13:45:01], Rusty Russell wrote:
> > On Tue, 23 Jun 2009 10:12:31 pm Amit Shah wrote:
> > > Hello,
> > >
> > > Here are two patches. One implements a virtio-serial device in qemu
> > > and the other is the driver for a guest kernel.
> > >
> > > While working on a vmchannel interface that is needed for communication
> > > between guest userspace and host userspace, I saw that most of the
> > > interface can be abstracted out as a "serial" device with "ports".
> >
> > OK, I don't think the "naming" idea works though.  A userspace user would
> > have to open each one in turn to get its name.  I'd stick with numbers.
>
> What if an ioctl were added to get the port number from the port name?
> Userspace would do
> 	ioctl(fd, VIRTIO_SERIAL_GET_PORT_FROM_NAME, &nr);
> 	sprintf(port, "/dev/vmch%s", nr);
> 	fd2 = open(port, ...);

Yep, pretty ugly tho.  If you use the "Amit Shah is in charge of port 
numbering approach", then it's just:

	fd = open("/dev/vmch<my-assigned-number>", ...);

Since you need to control names anyway, why not just use numbers?

> > You also don't have dynamic creation and removal, except by hotpluging
> > the entire device (which was on your requirements page).
>
> Actually we're more interested in hotplugging ports than the device
> itself ("Dynamic channel creation").

Exactly, which you don't seem to have.

> > what ports exist.  Register on the change interrupt to get updates.  Drop
> > the control vq entirely.
>
> If the ioctl mentioned above were added, it would justify the control
> vq, right?

Yes.  Or put another way, simplifying the interface to use assigned port 
numbers would simplify the implementation, use, and specification of the device 
:)

Cheers,
Rusty.
