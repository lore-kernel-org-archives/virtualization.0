From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [Lguest] networking in lguest: strange error: lguest: Guest
	moved used index from 6 to 256
Date: Thu, 06 Mar 2008 01:03:59 +0200
Message-ID: <1204758239.4708.25.camel__30005.6932414465$1204759007$gmane$org@localhost.localdomain>
References: <1204560316.47cc21bc513ed@webmail.alinto.com>
	<200803052206.31266.rusty@rustcorp.com.au>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803052206.31266.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@us.ibm.com>, Av
Cc: lguest@ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org


On Wed, 2008-03-05 at 22:06 +1100, Rusty Russell wrote:
> On Tuesday 04 March 2008 03:05:16 octane indice wrote:
> > Hello
> >
> > I have some difficulty to use network inside lguest.
> > I use a slackware 12 for guest and host with a 2.6.24 kernel.
> >
> > I boot lguest like that:
> > # tunctl
> > # ifconfig tap0 192.168.19.1
> > # lguest --tunnet=192.168.19.1 --block=/var/samba/iso/lguest.img 48
> > /usr/src/linux/arch/i386/boot/bzImage root=/dev/vda rw
> >
> > The init script files try to do a DHCP. It doesn't work (I do'nt have a
> > DHCP server).
> >
> > If in the host I try to configure the eth0, lguest crashes strangely:
> > root@slack12:~# ifconfig eth0 192.168.19.5
> > root@slack12:~# lguest: Guest moved used index from 6 to 256
> 
> Damn.  This is fixed in Linus' tree, but I've reproduced it here for 2.6.24.
> 
> It's non-trivial to repair, unfortunately (2.6.25 has a complete
> reset 
> infrastructure for this).  It will occur whenever the network device is 
> reopened, after packets were sent (or received).
> 
> The workaround is to disable the dhcp in the init scripts...
> 

You can also try to use backport scripts that automatically backport
virtio to older guest kernels >= 2.6.18.
It was written by Anthony Liguori and was decorated also by Avi and
myself.
Seems to work reliably with kvm, should do the same trick for lguest.
You can download it from
git://kvm.qumranet.com/home/dor/src/kvm-guest-drivers-linux

Anthony, you can update your mercurial repository with our changes.

Cheers,
Dor


> Thanks for the report,
> Rusty.
> _______________________________________________
> Lguest mailing list
> Lguest@ozlabs.org
> https://ozlabs.org/mailman/listinfo/lguest
