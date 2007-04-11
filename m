From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: paravirt repo rebased to 2.6.21-rc6-mm1
Date: Tue, 10 Apr 2007 17:10:18 -0700
Message-ID: <20070411001018.GV10574@sequoia.sous-sol.org>
References: <461C1C7B.5080509@goop.org> <461C1DDB.4090307@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <461C1DDB.4090307@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Zachary Amsden (zach@vmware.com) wrote:
> Jeremy Fitzhardinge wrote:
> >Seems to work OK for native and Xen.  I had to play a bit with the
> >paravirt-sched-clock patch to deal with the VMI changes.  Zach, can you
> >check that it still works?
> =

> I'm on it.

Not sure about cycles_2_ns...

arch/i386/kernel/built-in.o: In function `activate_vmi':
/home/chrisw/hg/xen/linux-2.6-pv/arch/i386/kernel/vmi.c:894: undefined refe=
rence to `vmi_sched_clock'

diff -r a5e50a2e914a arch/i386/kernel/vmiclock.c
--- a/arch/i386/kernel/vmiclock.c	Tue Apr 10 16:20:13 2007 -0700
+++ b/arch/i386/kernel/vmiclock.c	Tue Apr 10 17:07:47 2007 -0700
@@ -64,10 +64,10 @@ int vmi_set_wallclock(unsigned long now)
 	return 0;
 }
 =

-/* paravirt_ops.get_scheduled_cycles =3D vmi_get_sched_cycles */
-unsigned long long vmi_get_sched_cycles(void)
-{
-	return vmi_timer_ops.get_cycle_counter(VMI_CYCLES_AVAILABLE);
+unsigned long long vmi_sched_clock(void)
+{
+	cycle_t cycles =3D vmi_timer_ops.get_cycle_counter(VMI_CYCLES_AVAILABLE);
+	return cycles_2_ns(cycles);
 }
 =

 /* paravirt_ops.get_cpu_khz =3D vmi_cpu_khz */
