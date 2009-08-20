From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Thu, 20 Aug 2009 20:08:02 +0530
Message-ID: <20090820143802.GA20265@amit-x200.redhat.com>
References: <4A7FECCA.8080804@redhat.com> <4A801A7B.1020208@codemonkey.ws>
	<4A80287C.7050400@redhat.com> <4A802CA7.9020701@codemonkey.ws>
	<4A803E07.7080407@redhat.com> <4A8051F3.7040400@codemonkey.ws>
	<20090814081518.GA7418@amit-x200.redhat.com>
	<4A8566B8.8030808@codemonkey.ws>
	<20090820134241.GA19395@amit-x200.redhat.com>
	<20090820142509.GD27710@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090820142509.GD27710@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) Aug 20 2009 [15:25:09], Daniel P. Berrange wrote:
> On Thu, Aug 20, 2009 at 07:12:41PM +0530, Amit Shah wrote:
> > 
> > I've now seen some more code here and to me it looks like virtioconsole
> > is not used on any of the guests that qemu supports. The virtio_console
> > kernel module only works with lguest and s390 currently. There is one
> > feature and some config values supported by the kernel module but not in
> > qemu.
> > 
> > So it looks as if we have virtio-console merged but no one uses it. Is
> > this right?
> 
> Nope. Grab a Fedora 11 live CD, and boot with
> 
>   # qemu-kvm -virtioconsole stdio -cdrom Fedora-11-i686-Live.iso  -m 500
> 
> Once it completes booting & logs into gnome, open a terminal and run
> as root
> 
>    agetty /dev/hvc0 9600 vt100  
> 
> You'll get a login prompt on the host machine now.
> 
> What appears to not be working, is early kernel boot messages. eg, I
> ought to be able todo

Oh; ok. So the console device is exposed only in the userspace; it's not
used for the early boot messages and not registered early-on. That's
only done for lguest and s390.

>   # qemu-kvm -virtioconsole stdio -kernel vmlinuz -initrd initrd.img \
>       -append "console=hvc0"  -m 500
> 
> and see the kernel boot messages, but this doesn't work with Fedora
> kernels at least. Not tried upstream, or looked to see if this is just
> an oversight in the Kconfig use for Fedora kernels.

Thanks,

		Amit
