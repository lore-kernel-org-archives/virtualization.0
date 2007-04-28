From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: huh startup_ipi_hook?
Date: Sat, 28 Apr 2007 00:22:59 -0700
Message-ID: <4632F653.3000102@goop.org>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> So conceptually I think the concept makes sense but implementation
> wise I think what is currently present is totally ridiculous.

I tend to agree. For Xen I added smp_ops as an adjunct to paravirt_ops,
which is basically the interface defined in linux/smp.h:

struct smp_ops
{
	void (*smp_prepare_boot_cpu)(void);
	void (*smp_prepare_cpus)(unsigned max_cpus);
	int (*cpu_up)(unsigned cpu);
	void (*smp_cpus_done)(unsigned max_cpus);

	void (*smp_send_stop)(void);
	void (*smp_send_reschedule)(int cpu);
	int (*smp_call_function_mask)(cpumask_t mask,
				      void (*func)(void *info), void *info,
				      int wait);
};


This is a fairly close match to Xen's requirements. Certainly, anything
APIC-related is useless for us, since there's no APIC emulation going on.

I won't speak for Zach, but his counter-argument is generally along the
lines of "we can just make use of the existing code with a couple of
little hooks near the bottom". But I wonder if the existing genapic
interface can be used (or extended) to cover these cases without having
needing to have APIC-level interfaces in paravirt_ops.

Are you reviewing -mm? That's basically OK, but there's newer stuff in
Andi's patch queue.

J
