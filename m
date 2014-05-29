From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Divide error in kvm_unlock_kick()
Date: Thu, 29 May 2014 19:51:18 +0200
Message-ID: <53877396.8010503__26847.6031524644$1401385896$gmane$org@redhat.com>
References: <20140528164231.GA8888@arachsys.com>
	<D2F026E2-666F-4194-B95F-B5001843FA44@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <D2F026E2-666F-4194-B95F-B5001843FA44@arachsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Webb <chris@arachsys.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Il 29/05/2014 19:45, Chris Webb ha scritto:
> Chris Webb <chris@arachsys.com> wrote:
>
>> My CPU flags inside the crashing guest look like this:
>>
>> fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush
>> mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb lm rep_good nopl
>> extd_apicid pni pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 x2apic popcnt aes xsave
>> avx f16c hypervisor lahf_lm cmp_legacy svm cr8_legacy abm sse4a misalignsse
>> 3dnowprefetch osvw xop fma4 tbm arat npt nrip_save tsc_adjust bmi1
>>
>> whereas in a (working) -cpu qemu64 guest, they look like this:
>>
>> fpu de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx
>> fxsr sse sse2 ht syscall nx lm nopl pni cx16 x2apic popcnt hypervisor lahf_lm
>> cmp_legacy svm abm sse4a
>
> I thought I'd try to bisect on processor flags to see which was/were
> implicated.

Can you dump the full /proc/cpuinfo?

Paolo
