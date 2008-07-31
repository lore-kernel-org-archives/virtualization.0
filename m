From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-users] Re: State of Xen in upstream Linux
Date: Thu, 31 Jul 2008 13:14:54 -0700
Message-ID: <48921D3E.5040501@goop.org>
References: <48910C99.10606@goop.org> <20080731090845.GH23888@redhat.com>	
	<ed123fa30807311054p4965f43bod78dafa6626c9c2d@mail.gmail.com>	
	<4891FFBA.1020702@goop.org>	
	<7fac565a0807311119p55e534f1hc15005aea46671a2@mail.gmail.com>	
	<48920455.40204@goop.org>	
	<ed123fa30807311148q6460d2d8nb012f1b4edeb042f@mail.gmail.com>	
	<48920B4F.7010608@goop.org>
	<ed123fa30807311307j1687590bg31746d19f58d892d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <ed123fa30807311307j1687590bg31746d19f58d892d@mail.gmail.com>
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
> I wasn't really trying to run VBox in the dom0. I'd been running the
> Xen kernel so long that I'd forgotten which
> kernel I was on. Like I said when you start VMware the guest OS just
> doesn't run which gives you a second
> to ponder why. VBox uses VT/SVM if you check a box in the config. It
> was not checked when it
> crashed the server.

Yes.  It looks to me like the VBox kernel code is constructing its own
pagetable entries without using the normal kernel API to do so, and is
therefore not taking the pfn to mfn translation that must be done when
constructing pagetable entries.  The upshot is that it will use invalid
pagetables which are bound to crash the dom0 kernel.

There are two possible fixes: 1) make VBox Xen (or pvops) aware by
making sure it always uses the normal kernel APIs for constructing
pagetables, 2a) refuse to build with CONFIG_PARAVIRT enables, or 2b)
detect at runtime we're running on a non-native platform and refuse to
run.  2[ab] probably being easiest to implement.

> Depending on the application I use VBox or Xen for virtualization
> projects. VBox acts as an HVM most of the time
> so it's great for those times I'm virtualizing a product that I have
> no control over. Xen is best for environments
> that I do have control over.

Yes, I use kvm in a similar way.

    J
