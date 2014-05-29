From: Chris Webb <chris@arachsys.com>
Subject: Re: Divide error in kvm_unlock_kick()
Date: Thu, 29 May 2014 18:45:17 +0100
Message-ID: <D2F026E2-666F-4194-B95F-B5001843FA44__26070.3642190949$1401464367$gmane$org@arachsys.com>
References: <20140528164231.GA8888@arachsys.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140528164231.GA8888@arachsys.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Chris Webb <chris@arachsys.com> wrote:

> My CPU flags inside the crashing guest look like this:
> 
> fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush
> mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb lm rep_good nopl
> extd_apicid pni pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 x2apic popcnt aes xsave
> avx f16c hypervisor lahf_lm cmp_legacy svm cr8_legacy abm sse4a misalignsse
> 3dnowprefetch osvw xop fma4 tbm arat npt nrip_save tsc_adjust bmi1
> 
> whereas in a (working) -cpu qemu64 guest, they look like this:
> 
> fpu de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx
> fxsr sse sse2 ht syscall nx lm nopl pni cx16 x2apic popcnt hypervisor lahf_lm
> cmp_legacy svm abm sse4a

I thought I'd try to bisect on processor flags to see which was/were
implicated. The extra flags from -cpu host compared to -cpu qemu64 are:

3dnowprefetch aes arat avx bmi1 cr8_legacy extd_apicid f16c fma fma4
fxsr_opt misalignsse mmxext npt nrip_save osvw pclmulqdq pdpe1gb rep_good
sse4_1 sse4_2 ssse3 tbm tsc_adjust vme xop xsave

I can add all of these to -cpu qemu64 with the +FLAG,... syntax and obtain a
working guest, but qemu doesn't recognise a handful of them:

CPU feature tsc_adjust not found
CPU feature arat not found
CPU feature cr8_legacy not found
CPU feature extd_apicid not found
CPU feature rep_good not found
CPU feature tsc_adjust not found
Failed to access perfctr msr (MSR c0010001 is ffffffffffffffff)
[...]

Doing this results in a working, non-crashing guest, which suggests the
behaviour is triggered by one of tsc_adjust, arat, cr8_legacy, extd_apicid
or rep_good. However, because qemu doesn't recognise the flags, I can't run
with -cpu host,-tsc_adjust,-arat,... to investigate further. :(

Cheers,

Chris.
