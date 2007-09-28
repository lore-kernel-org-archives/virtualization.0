From: Avi Kivity <avi@qumranet.com>
Subject: Re: [RFC] KVM Source layout Proposal to accommodate new CPU
	architecture
Date: Fri, 28 Sep 2007 16:45:38 +0200
Message-ID: <46FD1392.1080905__36148.8914503299$1190990932$gmane$org@qumranet.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC753A4E@pdsmsx415.ccr.corp.intel.com>
	<46FB7566.9030504@qumranet.com>
	<42DFA526FC41B1429CE7279EF83C6BDC753E73@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC753E73@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhang, Xiantao" <xiantao.zhang@intel.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Zhang, Xiantao wrote:
> Hi Avi,
> 	Sound good! But what can we do before the merge? You know, we have to =
spend much effort maintaining our patches with sync with upstream tree. D=
o you have an interim solution or proposal for merging IA64 code?  Thanks=
.=20
> Xiantao=20
>  =20

The merge is due in a few weeks. If that is too far, we can push the x86
parts to arch/i386 and do makefile magic so that x86-64 sees it too.


> -----Original Message-----
> From: Avi Kivity [mailto:avi@qumranet.com]=20
> Sent: 2007=C4=EA9=D4=C227=C8=D5 17:19
> To: Zhang, Xiantao
> Cc: kvm-devel@lists.sourceforge.net; virtualization
> Subject: Re: [RFC] KVM Source layout Proposal to accommodate new CPU ar=
chitecture
>
> Zhang, Xiantao wrote:
>  =20
>> Hi Folks,
>> 	We are working on enabling KVM support on IA64 platform, and now
>> Linux, Windows guests get stable run and achieve reasonable performanc=
e
>> on KVM with Open GFW. But you know, the current KVM only considers x86
>> platform, and is short of cross-architecture framework. Currently, we
>> have a proposal for KVM source layout to accommodate new CPU
>> architectures. Attached foil describes the detail. With our proposal, =
we
>> can boot x86 guests based on commit
>> 2e278972a11eb14f031dea242a9ed118adfa0932, also didn't see regressions.
>> For IA64 side, we are rebasing our code to this framework.=20
>> Main changes to current source:
>> 1. Add subdirectories, such as x86 and ia64 to hold arch-specific code.
>> 2. Split kvm_main.c to two parts. One is still called kvm_main.c, just
>> contains KVM common interfaces with user space, and basic KVM
>> infrastructure. The other one is named as kvm_arch.c under sub-directo=
ry
>> (eg. X86, ia64 etc), which includes arch-specific code to supplement t=
he
>> functionality of kvm_main.c
>> 3. Add an "include" directory in drivers/kvm. Due to possibly complex
>> code logic in KVM source, maybe many header files need to maintain for
>> some architectures. If we put them under top-level include/asm-arch
>> directory, it may introduce much more maintain effort. So, we put it
>> under "drivers/kvm", and let it be effective when kernel configuration
>> time.
>> BTW, Userspace code changes are not involved in this thread.=20
>> Considering the readability, we didn't attach the diff file in the mai=
l,
>> due to big changes to kvm source structure, and only post the tarball
>> including whole directory "drivers/kvm" instead. For comparison, I
>> attached kvm_main.diff as well.=20
>>
>> Any comments are appreciated from you! Hope to see IA64 support on KVM
>> earlier!
>>  =20
>>    =20
>
> The whole drivers/kvm/ thing was just a trick to get merged quickly.  I
> think the new layout should be something like
>
>   virt/kvm/, include/linux/kvm*.h -> common code
>   virt/lguest/ -> the other hypervisor
>   virt/virtio/ -> shared I/O infrastructure
>   virt/ -> the CONFIG_VIRTIALIZATION menu
>   arch/x86/kvm/, include/asm-x86/ -> x86 specific code
>   arch/ia64/kvm/, include/asm-ia64/ -> ia64 specific code
>
> etc.
>
> Of course, this depends on the x86 merge which is scheduled for early
> 2.6.24.
>
>  =20


--=20
Any sufficiently difficult bug is indistinguishable from a feature.
