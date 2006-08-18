From: Zachary Amsden <zach@vmware.com>
Subject: Re: proposed interface change for setting the ldt
Date: Fri, 18 Aug 2006 13:23:22 -0700
Message-ID: <44E621BA.6090001@vmware.com>
References: <44E599A3.6020907@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44E599A3.6020907@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> A better interface for us would be simply:
>
>     set_ldt(const struct desc_struct *ldt, int num_entries);
>
> since this maps directly to the appropriate Xen hypercall.  If you =

> still want to implement it by plugging the LDT descriptor into the GDT =

> and then lldt, then there's no reason you can't implement it that way.
>
> Thoughts?

This interface doesn't work for anything other than Xen.  It is =

impossible to implement it without specific knowledge of kernel =

internals, since it doesn't provide the GDT selector for the LDT.  Now =

everything that looks like real hardware needs to move the knowledge of =

the LDT structure into paravirt-ops, and it has no clear calling =

convention, so you've now got to reason about SMP preemption correctness =

inside the paravirt-op, instead of at the higher level where it should =

be done.

This is an example of one place where Xen has broken the x86 =

architecture in favor of a simpler implementation of the hypervisor, but =

a radical change to the kernel.  It is one of the reasons why XenoLinux =

as implemented is unable to boot on native hardware.  I would strongly =

prefer if we didn't introduce this ugliness into paravirt-ops.

Zach
