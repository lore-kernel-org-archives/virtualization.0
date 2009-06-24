From: Amit Shah <amit.shah@redhat.com>
Subject: Re: virtio-serial: A guest <-> host interface for simple communication
Date: Wed, 24 Jun 2009 18:09:37 +0530
Message-ID: <20090624123937.GA14630__9206.65874514288$1245847273$gmane$org@amit-x200.redhat.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<200906241345.02051.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906241345.02051.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) Jun 24 2009 [13:45:01], Rusty Russell wrote:
> On Tue, 23 Jun 2009 10:12:31 pm Amit Shah wrote:
> > Hello,
> >
> > Here are two patches. One implements a virtio-serial device in qemu
> > and the other is the driver for a guest kernel.
> >
> > While working on a vmchannel interface that is needed for communication
> > between guest userspace and host userspace, I saw that most of the
> > interface can be abstracted out as a "serial" device with "ports".
> 
> OK, I don't think the "naming" idea works though.  A userspace user would have 
> to open each one in turn to get its name.  I'd stick with numbers.

What if an ioctl were added to get the port number from the port name?
Userspace would do
	ioctl(fd, VIRTIO_SERIAL_GET_PORT_FROM_NAME, &nr);
	sprintf(port, "/dev/vmch%s", nr);
	fd2 = open(port, ...);

?

> You also don't have dynamic creation and removal, except by hotpluging the 
> entire device (which was on your requirements page).

Actually we're more interested in hotplugging ports than the device
itself ("Dynamic channel creation").

> what ports exist.  Register on the change interrupt to get updates.  Drop the 
> control vq entirely.

If the ioctl mentioned above were added, it would justify the control
vq, right?

Thanks for the comments,
		Amit
