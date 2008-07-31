From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-users] Re: State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 11:28:37 -0700
Message-ID: <48920455.40204@goop.org>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>	
	<ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>	
	<4891FFBA.1020702@goop.org>
	<7fac565a0807311119p55e534f1hc15005aea46671a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <7fac565a0807311119p55e534f1hc15005aea46671a2@mail.gmail.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Alexey Eremenko <al4321@gmail.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Grant McWilliams <grantmasterflash@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, Xen-devel <xen-devel@lists.xensource.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Alexey Eremenko wrote:
> Jeremy: Mr. Grant speaking about the future where Linux (2.6.28?)
> mainline kernel will support Xen Dom0, not kernel 2.6.27, which only
> improves Xen DomU.
>
> And I agree with Grant, that if Linux mainline will have Dom0
> included, that may cause problems for all kinds of drivers.

The intention is that a single kernel will be equally functional in all
modes of operation.  If the kernel has dom0 capabilities, then they will
only come into play when actually running under Xen; when booting
natively, they will have no effect on anything else.  Naturally, running
under Xen is likely incompatible with any other in-kernel virtualization
system, so we need to make sure that they don't get in the way.  That's
easy to arrange for kvm, but I'm not sure about VirtualBox as it is
out-of-tree (though full source is available, right?).

    J
