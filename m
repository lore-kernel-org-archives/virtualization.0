From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-users] Re: State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 11:58:23 -0700
Message-ID: <48920B4F.7010608@goop.org>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>	
	<ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>	
	<4891FFBA.1020702@goop.org>	
	<7fac565a0807311119p55e534f1hc15005aea46671a2@mail.gmail.com>	
	<48920455.40204@goop.org>
	<ed123fa30807311148q6460d2d8nb012f1b4edeb042f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <ed123fa30807311148q6460d2d8nb012f1b4edeb042f@mail.gmail.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Grant McWilliams <grantmasterflash@gmail.com>
Cc: Alexey Eremenko <al4321@gmail.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Xen-devel <xen-devel@lists.xensource.com>, "Daniel P. Berrange" <berrange@redhat.com>, xen-users@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Grant McWilliams wrote:
> Vbox OSE has full source available. I was working on a contract for a
> corporation and was in the stage
> of deciding which virtualization platform to run and installed Vbox in
> a Xen system (running Xen). The installer
> loaded the vbox driver (As well as set it up to load automatically)
> and sent the server into a continuous reboot. Unfortunately this was
> in a Datacenter that I had no physical access to. The Vbox developers
> jumped all over me when I suggested that it was a bug.
> When running Xen the VMware interface will come up and the driver will
> load but the VMs just don't start. It seems like
> that would be a much better situation than causing the entire machine
> to crash. Seems like a Vbox problem. It was run in Dom0.

Yes, that sounds like an inherently unstable configuration.  I don't
know anything about how VBox operates internally, but whatever pagetable
management scheme they're using will quite likely not work under Xen
without a lot of care.  The best we can do in that case is try to make
sure that VBox doesn't attempt to come up.

If they don't rely on VT/SVM, then it may work from within a Xen hvm
domain, but I don't know what benefit that would have.  What were you
trying to achieve by running VBox in dom0?

    J
