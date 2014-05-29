From: Chris Webb <chris@arachsys.com>
Subject: Re: Divide error in kvm_unlock_kick()
Date: Thu, 29 May 2014 19:03:47 +0100
Message-ID: <CF32F1E1-EF8C-4A18-9697-FAD9CDDBDE8F__14266.8061926544$1401464372$gmane$org@arachsys.com>
References: <20140528164231.GA8888@arachsys.com>
	<D2F026E2-666F-4194-B95F-B5001843FA44@arachsys.com>
	<53877396.8010503@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53877396.8010503@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> wrote:

> Il 29/05/2014 19:45, Chris Webb ha scritto:
>> Chris Webb <chris@arachsys.com> wrote:
>> 
>>> My CPU flags inside the crashing guest look like this:
>>> 
>>> fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush
>>> mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb lm rep_good nopl
>>> extd_apicid pni pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 x2apic popcnt aes xsave
>>> avx f16c hypervisor lahf_lm cmp_legacy svm cr8_legacy abm sse4a misalignsse
>>> 3dnowprefetch osvw xop fma4 tbm arat npt nrip_save tsc_adjust bmi1
>>> 
>>> whereas in a (working) -cpu qemu64 guest, they look like this:
>>> 
>>> fpu de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx
>>> fxsr sse sse2 ht syscall nx lm nopl pni cx16 x2apic popcnt hypervisor lahf_lm
>>> cmp_legacy svm abm sse4a
>> 
>> I thought I'd try to bisect on processor flags to see which was/were
>> implicated.
> 
> Can you dump the full /proc/cpuinfo?

On the host, it looks like this:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 21
model		: 2
model name	: AMD Opteron(tm) Processor 6328
stepping	: 0
microcode	: 0x600081c
cpu MHz		: 3200.000
cache size	: 2048 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 32
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb arat cpb hw_pstate npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold bmi1
bogomips	: 6399.89
TLB size	: 1536 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro

[ x8 for processor 0 -> 7; full dump at http://cdw.me.uk/tmp/host-cpuinfo.txt ]

and on the guest it looks like:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 21
model		: 2
model name	: AMD Opteron(tm) Processor 6328
stepping	: 0
microcode	: 0x1000065
cpu MHz		: 3199.946
cache size	: 2048 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb lm rep_good nopl extd_apicid pni pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 x2apic popcnt aes xsave avx f16c hypervisor lahf_lm cmp_legacy svm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw xop fma4 tbm arat npt nrip_save tsc_adjust bmi1
bogomips	: 6399.89
TLB size	: 1536 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

[ x4 for processor 0 -> 3; full dump at http://cdw.me.uk/tmp/guest-cpuinfo.txt ]

Many thanks in advance for any pointers.

Best wishes,

Chris.
