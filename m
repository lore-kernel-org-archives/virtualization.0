From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Thu, 05 Apr 2012 14:13:56 +0530
Message-ID: <4F7D5B4C.3040906@linux.vnet.ibm.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F707C5F.1000905@redhat.com>	<4F716E31.3000803@linux.vnet.ibm.com>
	<CAMy5W3foop40+R1RLv_JPhnO5ZmV90uMmNERYY-e3QCeaJfqLw@mail.gmail.com>
	<4F73568D.7000703@linux.vnet.ibm.com> <4F743247.5080407@redhat.com>
	<4F74A405.2040609@linux.vnet.ibm.com>
	<4F7585EE.7060203@linux.vnet.ibm.com> <4F7855A1.80107@redhat.com>
	<4F785CC9.7070204@linux.vnet.ibm.com> <4F785DCF.7020809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F785DCF.7020809@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
Cc: the arch/x86 maintainers <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Alan Meadows <alan.meadows@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, LKML <linux-kernel@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andi Kleen <andi@firstfloor.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Attilio Rao <attilio.rao@citrix.com>, Virtualization <virtualization@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/01/2012 07:23 PM, Avi Kivity wrote:
> On 04/01/2012 04:48 PM, Raghavendra K T wrote:
>>>> I have patch something like below in mind to try:
>>>>
>>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>>> index d3b98b1..5127668 100644
>>>> --- a/virt/kvm/kvm_main.c
>>>> +++ b/virt/kvm/kvm_main.c
>>>> @@ -1608,15 +1608,18 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
>>>>         * else and called schedule in __vcpu_run.  Hopefully that
>>>>         * VCPU is holding the lock that we need and will release it.
>>>>         * We approximate round-robin by starting at the last boosted
>>>> VCPU.
>>>> +     * Priority is given to vcpu that are unhalted.
>>>>         */
>>>> -    for (pass = 0; pass<   2&&   !yielded; pass++) {
>>>> +    for (pass = 0; pass<   3&&   !yielded; pass++) {
>>>>            kvm_for_each_vcpu(i, vcpu, kvm) {
>>>>                struct task_struct *task = NULL;
>>>>                struct pid *pid;
>>>> -            if (!pass&&   i<   last_boosted_vcpu) {
>>>> +            if (!pass&&   !vcpu->pv_unhalted)
>>>> +                continue;
>>>> +            else if (pass == 1&&   i<   last_boosted_vcpu) {
>>>>                    i = last_boosted_vcpu;
>>>>                    continue;
>>>> -            } else if (pass&&   i>   last_boosted_vcpu)
>>>> +            } else if (pass == 2&&   i>   last_boosted_vcpu)
>>>>                    break;
>>>>                if (vcpu == me)
>>>>                    continue;
>>>>
>>>

[...]

> I'm interested in how PLE does vs. your patches, both with PLE enabled
> and disabled.
>

  Here is the result taken on PLE machine. Results seem to support all 
our assumptions.
  Following are the observations from results:

  1) There is a huge benefit for Non PLE based configuration. 
(base_nople vs pv_ple) (around 90%)

  2) ticketlock + kvm patches does go well along with PLE (more benefit 
is seen not degradation)
	(base_ple vs pv_ple)

  3) The ticketlock + kvm patches make behaves almost like PLE enabled 
machine (base_ple vs pv_nople)

  4) ple handler modification patches seem to give advantage (pv_ple vs 
pv_ple_optimized). More study needed
     probably with higher M/N ratio Avi pointed.

  configurations:

  base_nople       = 3.3-rc6 with CONFIG_PARAVIRT_SPINLOCK=n - PLE
  base_ple         = 3.3-rc6 with CONFIG_PARAVIRT_SPINLOCK=n  + PLE
  pv_ple           = 3.3-rc6 with CONFIG_PARAVIRT_SPINLOCK=y + PLE + 
ticketlock + kvm patches
  pv_nople         = 3.3-rc6 with CONFIG_PARAVIRT_SPINLOCK=y - PLE + 
ticketlock + kvm patches
  pv_ple_optimized = 3.3-rc6 with CONFIG_PARAVIRT_SPINLOCK=y + PLE + 
optimizaton patch + ticketlock
			+ kvm patches + posted with ple_handler modification (yield to kicked 
vcpu).

  Machine : IBM xSeries with Intel(R) Xeon(R)  X7560 2.27GHz CPU with 32 
core, with 8
          online cores and 4*64GB RAM

  3 guests running with 2GB RAM, 8vCPU.

  Results:
  -------
  case A)
  1x: 1 kernbench 2 idle
  2x: 1 kernbench 1 while1 hog 1 idle
  3x: 1 kernbench 2 while1 hog

  Average time taken in sec for kernbench run (std). [ lower the value 
better ]

       base_nople                 base_ple              pv_ple 
       pv_nople           pv_ple_optimized
	
  1x   72.8284 (89.8757) 	 70.475 (85.6979) 	63.5033 (72.7041) 
65.7634 (77.0504)  64.3284 (73.2688)
  2x   823.053 (1113.05) 	 110.971 (132.829) 	105.099 (128.738) 
139.058 (165.156)  106.268 (129.611)
  3x   3244.37 (4707.61) 	 150.265 (184.766) 	138.341 (172.69) 
139.106 (163.549)  133.238 (168.388)


    Percentage improvement calculation w.r.t base_nople
    -------------------------------------------------

       base_ple  pv_ple    pv_nople pv_ple_optimized

  1x    3.23143  12.8042   9.70089   11.6713
  2x    86.5172  87.2306   83.1046   87.0886
  3x    95.3684  95.736    95.7124   95.8933

-------------------
    Percentage improvement calculation w.r.t base_ple
    -------------------------------------------------

       base_nople  pv_ple    pv_nople  pv_ple_optimized

   1x   -3.3393    9.89244   6.68549   8.72167
   2x   -641.683   5.29147   -25.3102  4.23804
   3x   -2059.1    7.93531   7.42621   11.3313


  case B)
  all 3 guests running kernbench
  Average time taken in sec for kernbench run (std). [ lower the value 
better ].
  Note that std is calculated over 6*3 run average from all 3 guests 
given by kernbench

  base_nople            base_ple                pv_ple 
pv_nople              pv_ple_opt
  2886.92 (18.289131)   204.80333 (7.1784039)   200.22517 (10.134804) 
202.091 (12.249673)   201.60683 (7.881737)


    Percentage improvement calculation w.r.t base_nople
    -------------------------------------------------

       base_ple   pv_ple    pv_nople   pv_ple_optimized
       92.9058    93.0644   93	     93.0166
	


    Percentage improvement calculation w.r.t base_ple
    -------------------------------------------------

       base_nople   pv_ple    pv_nople   pv_ple_optimized
       -1309.606	   2.2354    1.324      1.5607	

  I hope the experimental results should convey same message if somebody 
does benchmarking.

  Also as Ian pointed in the thread, the earlier results from Attilio
and me was to convince that framework is acceptable on native.

  Does this convince to consider for it to go to next merge window?

  comments /suggestions please...
