From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-users] Re: State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 11:08:58 -0700
Message-ID: <4891FFBA.1020702@goop.org>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>
	<ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Grant McWilliams <grantmasterflash@gmail.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Xen-devel <xen-devel@lists.xensource.com>, "Daniel P. Berrange" <berrange@redhat.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Grant McWilliams wrote:
>
>
>     > Fedora 9's kernel-xen package has been based on the mainline
>     kernel from
>     > the outset, but it is still packaged as a separate kernel.
>      kernel-xen
>     > has been dropped from rawhide (what will become Fedora 10), and
>     all Xen
>     > support - both 32 and 64 bit - has been rolled into the main kernel
>     > package.
>
>
> Does this mean in the future all Fedora kernels will be Xen kernels?
> Is this wise? If I try to run VirtualBox on a Xen kernel the machine
> will reboot. If the Vbox module is loaded at runtime it will reboot
> forever. Yes, I know it's a Vbox issue but what about KVM. Can we run
> KVM on a Xen kernel?
>
> Or am I reading this completely wrong?

If you boot the kernel on bare hardware, the Xen parts of the kernel
will basically be switched off, and play no part in runtime.  All
hardware features and device drivers should be available as normal.  I
run kvm on pvops/xen kernels all the time.

If you boot the kernel under Xen, then VT/SVM will not be available, and
any kernel module which tries to use them - like kvm or (I presume)
virtualbox - should quietly get out of the way.  If they cause the
domain to crash, then that's a bug in those modules.

If by "the machine will reboot" you mean that the whole system crashes,
then that's definitely a bug in Xen which should be fixed.  It should
never be possible for a domU to crash the system.

    J
