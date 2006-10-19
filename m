From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: pv_ops smp support
Date: Thu, 19 Oct 2006 16:09:51 -0700
Message-ID: <453805BF.80301@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

I'm looking at adding Xen SMP support, so I'm trying to work out what =

pv_ops we need, and how to cut into the existing smp stuff.

smpboot.c has a mixture of stuff which is generally useful for SMP stuff =

(the various CPU sets, and presumably the sibling relationships are =

useful in principle), but also a whole pile of APIC stuff which is =

irrelevent to Xen.  It has these exported symbols, with my first pass =

comments:

    00000644 T __cpu_die			-- need pv_op
    000008a5 T __cpu_disable		-- need pv_op
    000006aa T __cpu_up			-- need pv_op
    00000000 T cpu_coregroup_map		-- ? ignore
    00000868 T cpu_exit_clear		-- ?
    00000d9f T initialize_secondary		-- Xen no-op
    000008ee T smp_alloc_memory		-- Xen no-op (doesn't matter if it gets ca=
lled)
    00000057 T smp_cpus_done		-- unwanted for Xen
    00000015 T smp_intr_init		-- need something to set up IPIs, but APIC in=
dependent
    0000082a T smp_prepare_boot_cpu		-- looks OK for Xen, I think
    00000066 T smp_prepare_cpus		-- need pv_op
      =



So at first pass, it looks like we need 6-8 new pv_ops for SMP, which =

isn't very appealing.

Any thoughts about how to come up with a more elegant interface?  I'm =

digging through smpboot.c and friends, but there's a lot of goo in there...

It's not clear to me what we should do with all the topology stuff.  =

Clearly a VCPU won't have any fixed physical relationship with other =

VCPUs unless they're pinned; I'm wondering if the existing code will =

confuse itself if it gets basically random topology info from cpuid.

    J
