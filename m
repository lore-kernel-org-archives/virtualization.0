From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lguest] error rebooting lguest
Date: Sat, 11 Aug 2007 12:44:49 +1000
Message-ID: <1186800289.30899.45.camel@localhost.localdomain>
References: <1186773617.5652.18.camel@odie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1186773617.5652.18.camel@odie>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Simon Holm =?ISO-8859-1?Q?Th=F8gersen?= <odie@cs.aau.dk>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-08-10 at 21:20 +0200, Simon Holm Th=F8gersen wrote:
> Hey!
>=20
> Trying the root disk image
> http://xm-test.xensource.com/ramdisks/initrd-1.1-i386.img
> suggested in Documentation/lguest/lguest.txt, I get the follow trace
> when rebooting the guest. Kernel is 2.6.23-rc2-ge1cf20c1.

Hi Simon,

	Implementing reboot is an interesting project.  It'd be nice to
separate "crash" from "halt" as well.  I think the steps are:

1) Override ative_machine_emergency_restart in paravirt_ops to an
lguest-specific routine.
2) Enhance the LHCALL_CRASH hypercall (and perhaps rename it) to take an
argument that says whether we've crashed, halted, or want to reboot.
Maybe set lg->dead to -EAGAIN for reboot, -EIO for crash, -ENOENT for
halt?
3) Change the launcher appropriately.  For reboot, perhaps we can just
exec ourselves.  For crash, exit with an error code, for halt exit with
0.

Patch welcome!
Rusty.
