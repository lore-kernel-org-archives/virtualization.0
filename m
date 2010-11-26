From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] x86/pvclock-xen: zero last_value on resume
Date: Fri, 26 Nov 2010 14:29:40 -0800
Message-ID: <4CF034D4.70005__49610.7782390483$1290810737$gmane$org@goop.org>
References: <4CC708DE.1070000@goop.org> <4CEACFAB.90503@goop.org>
	<20101126104047.GA9798@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20101126104047.GA9798@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Xen-devel@lists.xensource.com" <Xen-devel@lists.xensource.com>, kvm-devel <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Olivier Hanesse <olivier.hanesse@gmail.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Eelco Dolstra <e.dolstra@tudelft.nl>
List-Id: virtualization@lists.linuxfoundation.org

On 11/26/2010 02:40 AM, Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>> On 10/26/2010 09:59 AM, Jeremy Fitzhardinge wrote:
>>> If the guest domain has been suspend/resumed or migrated, then the
>>> system clock backing the pvclock clocksource may revert to a smaller
>>> value (ie, can be non-monotonic across the migration/save-restore).
>>> Make sure we zero last_value in that case so that the domain
>>> continues to see clock updates.
>> Ping?  Looks like this fell through the gaps.
> Does not apply cleanly here - mind resending the latest version?

It rebased cleanly to 2.6.37-rc3.  You can pull it from:

  git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen.git pvclock-resume

Jeremy Fitzhardinge (1):
      x86/pvclock: zero last_value on resume

 arch/x86/include/asm/pvclock.h |    1 +
 arch/x86/kernel/pvclock.c      |    5 +++++
 arch/x86/xen/time.c            |    2 ++
 3 files changed, 8 insertions(+), 0 deletions(-)

Thanks,
	J

Subject: [PATCH] x86/pvclock: zero last_value on resume

If the guest domain has been suspend/resumed or migrated, then the
system clock backing the pvclock clocksource may revert to a smaller
value (ie, can be non-monotonic across the migration/save-restore).
Make sure we zero last_value in that case so that the domain
continues to see clock updates.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
index 7f7e577..31d84ac 100644
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -11,6 +11,7 @@ unsigned long pvclock_tsc_khz(struct pvclock_vcpu_time_info *src);
 void pvclock_read_wallclock(struct pvclock_wall_clock *wall,
 			    struct pvclock_vcpu_time_info *vcpu,
 			    struct timespec *ts);
+void pvclock_resume(void);
 
 /*
  * Scale a 64-bit delta by scaling and multiplying by a 32-bit fraction,
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index 008b91e..42eb330 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -83,6 +83,11 @@ unsigned long pvclock_tsc_khz(struct pvclock_vcpu_time_info *src)
 
 static atomic64_t last_value = ATOMIC64_INIT(0);
 
+void pvclock_resume(void)
+{
+	atomic64_set(&last_value, 0);
+}
+
 cycle_t pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 {
 	struct pvclock_shadow_time shadow;
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index b2bb5aa..5da5e53 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -426,6 +426,8 @@ void xen_timer_resume(void)
 {
 	int cpu;
 
+	pvclock_resume();
+
 	if (xen_clockevent != &xen_vcpuop_clockevent)
 		return;
