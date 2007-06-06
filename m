From: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [patch 21/33] xen: Xen SMP guest support
Date: Wed, 06 Jun 2007 09:34:27 +0200
Message-ID: <46667FA3.76E4.0078.0@novell.com>
References: <20070522140941.802382212@goop.org>
	<20070522141252.611887616@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070522141252.611887616@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

>--- a/arch/i386/xen/time.c
>+++ b/arch/i386/xen/time.c
>@@ -105,17 +105,15 @@ static void get_runstate_snapshot(struct
> 	preempt_enable();
> }
>=20
>-static void setup_runstate_info(void)
>+static void setup_runstate_info(int cpu)
> {
> 	struct vcpu_register_runstate_memory_area area;
>=20
>-	area.addr.v =3D &__get_cpu_var(runstate);
>+	area.addr.v =3D &per_cpu(runstate, cpu);
>=20
> 	if (HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area,
> 			       smp_processor_id(), &area))

Shouldn't this be 'cpu' rather than 'smp_processor_id()'?

> 		BUG();
>-
>-	get_runstate_snapshot(&__get_cpu_var(runstate_snapshot));
> }
>=20
> static void do_stolen_accounting(void)

Jan
