From: "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [Xen-users] Re: [Xen-devel] State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 19:36:35 +0100
Message-ID: <20080731183634.GA27147@gallifrey>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>
	<ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>
	<4891FFBA.1020702@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4891FFBA.1020702@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Grant McWilliams <grantmasterflash@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, Xen-devel <xen-devel@lists.xensource.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Grant McWilliams wrote:

<snip>

> > Does this mean in the future all Fedora kernels will be Xen kernels?
> > Is this wise? If I try to run VirtualBox on a Xen kernel the machine
> > will reboot. If the Vbox module is loaded at runtime it will reboot
> > forever. Yes, I know it's a Vbox issue but what about KVM. Can we run
> > KVM on a Xen kernel?
> >
> > Or am I reading this completely wrong?
> 
> If you boot the kernel on bare hardware, the Xen parts of the kernel
> will basically be switched off, and play no part in runtime.  All
> hardware features and device drivers should be available as normal.  I
> run kvm on pvops/xen kernels all the time.

Does that include things like /proc/cpuinfo?  Current Dom0's seem
to lose some of the physical IDs information from there.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
