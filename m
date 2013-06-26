From: Chegu Vinod <chegu_vinod@hp.com>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Wed, 26 Jun 2013 07:39:36 -0700
Message-ID: <51CAFD28.7080002@hp.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<1372171802.3804.30.camel@oc2024037011.ibm.com>
	<51CAAA26.4090204@linux.vnet.ibm.com>
	<20130626113744.GA6300@hawk.usersys.redhat.com>
	<20130626125240.GY18508@redhat.com>
	<51CAEF45.3010203@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5521982060663361879=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51CAEF45.3010203@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, gregkh@suse.de, linux-doc@vger.kernel.org, peterz@infradead.org, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, kvm@vger.kernel.org, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, Andrew Jones <drjones@redhat.com>, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--===============5521982060663361879==
Content-Type: multipart/alternative;
 boundary="------------000207040400090303070409"

This is a multi-part message in MIME format.
--------------000207040400090303070409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/2013 6:40 AM, Raghavendra K T wrote:
> On 06/26/2013 06:22 PM, Gleb Natapov wrote:
>> On Wed, Jun 26, 2013 at 01:37:45PM +0200, Andrew Jones wrote:
>>> On Wed, Jun 26, 2013 at 02:15:26PM +0530, Raghavendra K T wrote:
>>>> On 06/25/2013 08:20 PM, Andrew Theurer wrote:
>>>>> On Sun, 2013-06-02 at 00:51 +0530, Raghavendra K T wrote:
>>>>>> This series replaces the existing paravirtualized spinlock mechanism
>>>>>> with a paravirtualized ticketlock mechanism. The series provides
>>>>>> implementation for both Xen and KVM.
>>>>>>
>>>>>> Changes in V9:
>>>>>> - Changed spin_threshold to 32k to avoid excess halt exits that are
>>>>>>     causing undercommit degradation (after PLE handler improvement).
>>>>>> - Added  kvm_irq_delivery_to_apic (suggested by Gleb)
>>>>>> - Optimized halt exit path to use PLE handler
>>>>>>
>>>>>> V8 of PVspinlock was posted last year. After Avi's suggestions to 
>>>>>> look
>>>>>> at PLE handler's improvements, various optimizations in PLE handling
>>>>>> have been tried.
>>>>>
>>>>> Sorry for not posting this sooner.  I have tested the v9 
>>>>> pv-ticketlock
>>>>> patches in 1x and 2x over-commit with 10-vcpu and 20-vcpu VMs.  I 
>>>>> have
>>>>> tested these patches with and without PLE, as PLE is still not 
>>>>> scalable
>>>>> with large VMs.
>>>>>
>>>>
>>>> Hi Andrew,
>>>>
>>>> Thanks for testing.
>>>>
>>>>> System: x3850X5, 40 cores, 80 threads
>>>>>
>>>>>
>>>>> 1x over-commit with 10-vCPU VMs (8 VMs) all running dbench:
>>>>> ----------------------------------------------------------
>>>>>                         Total
>>>>> Configuration                Throughput(MB/s)    Notes
>>>>>
>>>>> 3.10-default-ple_on            22945            5% CPU in host 
>>>>> kernel, 2% spin_lock in guests
>>>>> 3.10-default-ple_off            23184            5% CPU in host 
>>>>> kernel, 2% spin_lock in guests
>>>>> 3.10-pvticket-ple_on            22895            5% CPU in host 
>>>>> kernel, 2% spin_lock in guests
>>>>> 3.10-pvticket-ple_off            23051            5% CPU in host 
>>>>> kernel, 2% spin_lock in guests
>>>>> [all 1x results look good here]
>>>>
>>>> Yes. The 1x results look too close
>>>>
>>>>>
>>>>>
>>>>> 2x over-commit with 10-vCPU VMs (16 VMs) all running dbench:
>>>>> -----------------------------------------------------------
>>>>>                         Total
>>>>> Configuration                Throughput        Notes
>>>>>
>>>>> 3.10-default-ple_on             6287            55% CPU host 
>>>>> kernel, 17% spin_lock in guests
>>>>> 3.10-default-ple_off             1849            2% CPU in host 
>>>>> kernel, 95% spin_lock in guests
>>>>> 3.10-pvticket-ple_on             6691            50% CPU in host 
>>>>> kernel, 15% spin_lock in guests
>>>>> 3.10-pvticket-ple_off            16464            8% CPU in host 
>>>>> kernel, 33% spin_lock in guests
>>>>
>>>> I see 6.426% improvement with ple_on
>>>> and 161.87% improvement with ple_off. I think this is a very good sign
>>>>   for the patches
>>>>
>>>>> [PLE hinders pv-ticket improvements, but even with PLE off,
>>>>>   we still off from ideal throughput (somewhere >20000)]
>>>>>
>>>>
>>>> Okay, The ideal throughput you are referring is getting around atleast
>>>> 80% of 1x throughput for over-commit. Yes we are still far away from
>>>> there.
>>>>
>>>>>
>>>>> 1x over-commit with 20-vCPU VMs (4 VMs) all running dbench:
>>>>> ----------------------------------------------------------
>>>>>                         Total
>>>>> Configuration                Throughput        Notes
>>>>>
>>>>> 3.10-default-ple_on            22736            6% CPU in host 
>>>>> kernel, 3% spin_lock in guests
>>>>> 3.10-default-ple_off            23377            5% CPU in host 
>>>>> kernel, 3% spin_lock in guests
>>>>> 3.10-pvticket-ple_on            22471            6% CPU in host 
>>>>> kernel, 3% spin_lock in guests
>>>>> 3.10-pvticket-ple_off            23445            5% CPU in host 
>>>>> kernel, 3% spin_lock in guests
>>>>> [1x looking fine here]
>>>>>
>>>>
>>>> I see ple_off is little better here.
>>>>
>>>>>
>>>>> 2x over-commit with 20-vCPU VMs (8 VMs) all running dbench:
>>>>> ----------------------------------------------------------
>>>>>                         Total
>>>>> Configuration                Throughput        Notes
>>>>>
>>>>> 3.10-default-ple_on             1965            70% CPU in host 
>>>>> kernel, 34% spin_lock in guests
>>>>> 3.10-default-ple_off              226            2% CPU in host 
>>>>> kernel, 94% spin_lock in guests
>>>>> 3.10-pvticket-ple_on             1942            70% CPU in host 
>>>>> kernel, 35% spin_lock in guests
>>>>> 3.10-pvticket-ple_off             8003            11% CPU in host 
>>>>> kernel, 70% spin_lock in guests
>>>>> [quite bad all around, but pv-tickets with PLE off the best so far.
>>>>>   Still quite a bit off from ideal throughput]
>>>>
>>>> This is again a remarkable improvement (307%).
>>>> This motivates me to add a patch to disable ple when pvspinlock is on.
>>>> probably we can add a hypercall that disables ple in kvm init patch.
>>>> but only problem I see is what if the guests are mixed.
>>>>
>>>>   (i.e one guest has pvspinlock support but other does not. Host
>>>> supports pv)
>>>
>>> How about reintroducing the idea to create per-kvm ple_gap,ple_window
>>> state. We were headed down that road when considering a dynamic 
>>> window at
>>> one point. Then you can just set a single guest's ple_gap to zero, 
>>> which
>>> would lead to PLE being disabled for that guest. We could also revisit
>>> the dynamic window then.
>>>
>> Can be done, but lets understand why ple on is such a big problem. Is it
>> possible that ple gap and SPIN_THRESHOLD are not tuned properly?
>>
>
> The one obvious reason I see is commit awareness inside the guest. for
> under-commit there is no necessity to do PLE, but unfortunately we do.
>
> atleast we return back immediately in case of potential undercommits,
> but we still incur vmexit delay.
> same applies to SPIN_THRESHOLD. SPIN_THRESHOLD should be ideally more
> for undercommit and less for overcommit.
>
> with this patch series SPIN_THRESHOLD is increased to 32k to solely
> avoid under-commit regressions but it would have eaten some amount of
> overcommit performance.
> In summary: excess halt-exit/pl-exit was one  main reason for
> undercommit regression. (compared to pl disabled case)

I haven't yet tried these patches...hope to do so sometime soon.

Fwiw...after Raghu's last set of PLE changes that is now in 3.10-rc 
kernels...I didn't notice much difference in workload performance 
between PLE enabled vs. disabled. This is for under-commit (+pinned) 
large guest case.

Here is a small sampling of the guest exits collected via kvm ftrace for 
an OLTP-like workload which was keeping the guest ~85-90% busy on a 8 
socket Westmere-EX box (HT-off).

TIME_IN_GUEST 71.616293

TIME_ON_HOST 7.764597

MSR_READ 0.0003620.0%

NMI_WINDOW 0.0000020.0%

PAUSE_INSTRUCTION 0.1585952.0%

PENDING_INTERRUPT 0.0337790.4%

MSR_WRITE 0.0016950.0%

EXTERNAL_INTERRUPT 3.21086741.4%

IO_INSTRUCTION 0.0000180.0%

RDPMC 0.0000670.0%

HLT 2.82252336.4%

EXCEPTION_NMI 0.0083620.1%

CR_ACCESS 0.0100270.1%

APIC_ACCESS 1.51830019.6%



[  Don't mean to digress from the topic but in most of my under-commit + 
pinned large guest experiments with 3.10 kernels (using 2 or 3 different 
workloads) the time spent in halt exits are typically much more than the 
time spent in ple exits. Can anything be done to reduce the duration or 
avoid those exits ?  ]

>
> 1. dynamic ple window was one solution for PLE, which we can experiment
> further. (at VM level or global).

Is this the case where the dynamic PLE  window starts off at a value 
more suitable to reduce exits for under-commit (and pinned) cases and 
only when the host OS detects that the degree of under-commit is 
shrinking (i.e. moving towards having more vcpus to schedule and hence 
getting to be over committed) it adjusts the ple window more suitable to 
the over commit case ? or is this some different idea ?

Thanks
Vinod

> The other experiment I was thinking is to extend spinlock to
> accommodate vcpuid (Linus has opposed that but may be worth a
> try).
>


> 2. Andrew Theurer had patch to reduce double runq lock that I will be 
> testing.
>
> I have some older experiments to retry though they did not give 
> significant improvements before the PLE handler modified.
>
> Andrew, do you have any other details to add (from perf report that 
> you usually take with these experiments)?
>
> .
>


--------------000207040400090303070409
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 6/26/2013 6:40 AM, Raghavendra K T
      wrote:<br>
    </div>
    <blockquote cite="mid:51CAEF45.3010203@linux.vnet.ibm.com"
      type="cite">On 06/26/2013 06:22 PM, Gleb Natapov wrote:
      <br>
      <blockquote type="cite">On Wed, Jun 26, 2013 at 01:37:45PM +0200,
        Andrew Jones wrote:
        <br>
        <blockquote type="cite">On Wed, Jun 26, 2013 at 02:15:26PM
          +0530, Raghavendra K T wrote:
          <br>
          <blockquote type="cite">On 06/25/2013 08:20 PM, Andrew Theurer
            wrote:
            <br>
            <blockquote type="cite">On Sun, 2013-06-02 at 00:51 +0530,
              Raghavendra K T wrote:
              <br>
              <blockquote type="cite">This series replaces the existing
                paravirtualized spinlock mechanism
                <br>
                with a paravirtualized ticketlock mechanism. The series
                provides
                <br>
                implementation for both Xen and KVM.
                <br>
                <br>
                Changes in V9:
                <br>
                - Changed spin_threshold to 32k to avoid excess halt
                exits that are
                <br>
                &nbsp;&nbsp;&nbsp; causing undercommit degradation (after PLE handler
                improvement).
                <br>
                - Added&nbsp; kvm_irq_delivery_to_apic (suggested by Gleb)
                <br>
                - Optimized halt exit path to use PLE handler
                <br>
                <br>
                V8 of PVspinlock was posted last year. After Avi's
                suggestions to look
                <br>
                at PLE handler's improvements, various optimizations in
                PLE handling
                <br>
                have been tried.
                <br>
              </blockquote>
              <br>
              Sorry for not posting this sooner.&nbsp; I have tested the v9
              pv-ticketlock
              <br>
              patches in 1x and 2x over-commit with 10-vcpu and 20-vcpu
              VMs.&nbsp; I have
              <br>
              tested these patches with and without PLE, as PLE is still
              not scalable
              <br>
              with large VMs.
              <br>
              <br>
            </blockquote>
            <br>
            Hi Andrew,
            <br>
            <br>
            Thanks for testing.
            <br>
            <br>
            <blockquote type="cite">System: x3850X5, 40 cores, 80
              threads
              <br>
              <br>
              <br>
              1x over-commit with 10-vCPU VMs (8 VMs) all running
              dbench:
              <br>
              ----------------------------------------------------------
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total
              <br>
              Configuration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Throughput(MB/s)&nbsp;&nbsp;&nbsp; Notes
              <br>
              <br>
              3.10-default-ple_on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22945&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5% CPU in
              host kernel, 2% spin_lock in guests
              <br>
              3.10-default-ple_off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23184&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5% CPU in
              host kernel, 2% spin_lock in guests
              <br>
              3.10-pvticket-ple_on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22895&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5% CPU in
              host kernel, 2% spin_lock in guests
              <br>
              3.10-pvticket-ple_off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23051&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5% CPU
              in host kernel, 2% spin_lock in guests
              <br>
              [all 1x results look good here]
              <br>
            </blockquote>
            <br>
            Yes. The 1x results look too close
            <br>
            <br>
            <blockquote type="cite">
              <br>
              <br>
              2x over-commit with 10-vCPU VMs (16 VMs) all running
              dbench:
              <br>
-----------------------------------------------------------
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total
              <br>
              Configuration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Throughput&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Notes
              <br>
              <br>
              3.10-default-ple_on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6287&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 55% CPU&nbsp;
              host kernel, 17% spin_lock in guests
              <br>
              3.10-default-ple_off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1849&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2% CPU in
              host kernel, 95% spin_lock in guests
              <br>
              3.10-pvticket-ple_on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6691&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 50% CPU
              in host kernel, 15% spin_lock in guests
              <br>
              3.10-pvticket-ple_off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16464&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8% CPU
              in host kernel, 33% spin_lock in guests
              <br>
            </blockquote>
            <br>
            I see 6.426% improvement with ple_on
            <br>
            and 161.87% improvement with ple_off. I think this is a very
            good sign
            <br>
            &nbsp; for the patches
            <br>
            <br>
            <blockquote type="cite">[PLE hinders pv-ticket improvements,
              but even with PLE off,
              <br>
              &nbsp; we still off from ideal throughput (somewhere
              &gt;20000)]
              <br>
              <br>
            </blockquote>
            <br>
            Okay, The ideal throughput you are referring is getting
            around atleast
            <br>
            80% of 1x throughput for over-commit. Yes we are still far
            away from
            <br>
            there.
            <br>
            <br>
            <blockquote type="cite">
              <br>
              1x over-commit with 20-vCPU VMs (4 VMs) all running
              dbench:
              <br>
              ----------------------------------------------------------
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total
              <br>
              Configuration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Throughput&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Notes
              <br>
              <br>
              3.10-default-ple_on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22736&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6% CPU in
              host kernel, 3% spin_lock in guests
              <br>
              3.10-default-ple_off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23377&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5% CPU in
              host kernel, 3% spin_lock in guests
              <br>
              3.10-pvticket-ple_on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22471&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6% CPU in
              host kernel, 3% spin_lock in guests
              <br>
              3.10-pvticket-ple_off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 23445&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5% CPU
              in host kernel, 3% spin_lock in guests
              <br>
              [1x looking fine here]
              <br>
              <br>
            </blockquote>
            <br>
            I see ple_off is little better here.
            <br>
            <br>
            <blockquote type="cite">
              <br>
              2x over-commit with 20-vCPU VMs (8 VMs) all running
              dbench:
              <br>
              ----------------------------------------------------------
              <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total
              <br>
              Configuration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Throughput&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Notes
              <br>
              <br>
              3.10-default-ple_on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1965&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 70% CPU in
              host kernel, 34% spin_lock in guests&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
              3.10-default-ple_off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 226&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2% CPU in
              host kernel, 94% spin_lock in guests
              <br>
              3.10-pvticket-ple_on&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1942&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 70% CPU
              in host kernel, 35% spin_lock in guests
              <br>
              3.10-pvticket-ple_off&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8003&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11% CPU
              in host kernel, 70% spin_lock in guests
              <br>
              [quite bad all around, but pv-tickets with PLE off the
              best so far.
              <br>
              &nbsp; Still quite a bit off from ideal throughput]
              <br>
            </blockquote>
            <br>
            This is again a remarkable improvement (307%).
            <br>
            This motivates me to add a patch to disable ple when
            pvspinlock is on.
            <br>
            probably we can add a hypercall that disables ple in kvm
            init patch.
            <br>
            but only problem I see is what if the guests are mixed.
            <br>
            <br>
            &nbsp; (i.e one guest has pvspinlock support but other does not.
            Host
            <br>
            supports pv)
            <br>
          </blockquote>
          <br>
          How about reintroducing the idea to create per-kvm
          ple_gap,ple_window
          <br>
          state. We were headed down that road when considering a
          dynamic window at
          <br>
          one point. Then you can just set a single guest's ple_gap to
          zero, which
          <br>
          would lead to PLE being disabled for that guest. We could also
          revisit
          <br>
          the dynamic window then.
          <br>
          <br>
        </blockquote>
        Can be done, but lets understand why ple on is such a big
        problem. Is it
        <br>
        possible that ple gap and SPIN_THRESHOLD are not tuned properly?
        <br>
        <br>
      </blockquote>
      <br>
      The one obvious reason I see is commit awareness inside the guest.
      for
      <br>
      under-commit there is no necessity to do PLE, but unfortunately we
      do.
      <br>
      <br>
      atleast we return back immediately in case of potential
      undercommits,
      <br>
      but we still incur vmexit delay.
      <br>
      same applies to SPIN_THRESHOLD. SPIN_THRESHOLD should be ideally
      more
      <br>
      for undercommit and less for overcommit.
      <br>
      <br>
      with this patch series SPIN_THRESHOLD is increased to 32k to
      solely
      <br>
      avoid under-commit regressions but it would have eaten some amount
      of
      <br>
      overcommit performance.
      <br>
      In summary: excess halt-exit/pl-exit was one&nbsp; main reason for
      <br>
      undercommit regression. (compared to pl disabled case)
      <br>
    </blockquote>
    <br>
    I haven't yet tried these patches...hope to do so sometime soon.<br>
    <br>
    Fwiw...after Raghu's last set of PLE changes that is now in 3.10-rc
    kernels...I didn't notice much difference in workload performance
    between PLE enabled vs. disabled. This is for under-commit (+pinned)
    large guest case. <br>
    <br>
    Here is a small sampling of the guest exits collected via kvm ftrace
    for an OLTP-like workload which was keeping the guest ~85-90% busy
    on a 8 socket Westmere-EX box (HT-off). <br>
    <br>
    <meta http-equiv="Content-Type" content="text/html;
      charset=ISO-8859-1">
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">TIME_IN_GUEST </span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>71.616293</span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">TIME_ON_HOST </span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>7.764597<br>
        <br>
      </span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">MSR_READ </span><span
        style="font-size:
        11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>0.000362<span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.0</span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%">%</span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">NMI_WINDOW </span><span
        style="font-size:
        11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>0.000002<span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.0</span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%">%</span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><font color="#ff0000"><span
          style="font-size: 11pt; font-family: &quot;HP
          Simplified&quot;;">PAUSE_INSTRUCTION </span><span
          style="font-size: 11pt; font-family: &quot;HP
          Simplified&quot;;"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>0.158595<span
            style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>2.0</span><span
          style="font-size: 11pt; font-family: &quot;HP
          Simplified&quot;;">%</span></font></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">PENDING_INTERRUPT </span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>0.033779<span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.4</span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%">%</span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">MSR_WRITE </span><span
        style="font-size:
        11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>0.001695<span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.0</span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%">%</span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">EXTERNAL_INTERRUPT </span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>3.210867<span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>41.4%<span
          style="mso-spacerun:yes">&nbsp;&nbsp; </span></span><span
        style="font-size:11.0pt;
        font-family:Wingdings;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-char-type:symbol;mso-symbol-font-family:
Wingdings;mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:
text1;mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"></span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">IO_INSTRUCTION </span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>0.000018<span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.0</span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%">%</span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">RDPMC </span><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>0.000067<span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.0</span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%">%</span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><font color="#ff0000"><span
          style="font-size: 11pt; font-family: &quot;HP
          Simplified&quot;;">HLT </span><span style="font-size: 11pt;
          font-family: &quot;HP Simplified&quot;;"><span
            style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>2.822523<span
            style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>36.4%<span
            style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp; </span></span><span
          style="font-size: 11pt; font-family: Wingdings;"></span><span
          style="font-size: 11pt; font-family: &quot;HP
          Simplified&quot;;"> </span></font></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">EXCEPTION_NMI </span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>0.008362<span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.1</span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%">%</span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">CR_ACCESS </span><span
        style="font-size:
        11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>0.010027<span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>0.1</span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%">%</span></p>
    <p
      style="language:en-US;margin-top:0pt;margin-bottom:0pt;margin-left:0in;
text-align:left;direction:ltr;unicode-bidi:embed;mso-line-break-override:none;
      word-break:normal;punctuation-wrap:hanging"><span
        style="font-size:11.0pt;
        font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-style-textfill-type:solid;
mso-style-textfill-fill-themecolor:text1;mso-style-textfill-fill-color:black;
        mso-style-textfill-fill-alpha:100.0%">APIC_ACCESS </span><span
        style="font-size:11.0pt;font-family:&quot;HP
        Simplified&quot;;mso-ascii-font-family:&quot;HP
        Simplified&quot;;
mso-fareast-font-family:+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:
minor-latin;mso-fareast-theme-font:minor-fareast;mso-bidi-theme-font:minor-bidi;
color:black;mso-color-index:1;mso-font-kerning:12.0pt;language:en-US;
mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:text1;
mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"><span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>1.518300<span
          style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>19.6%<span
          style="mso-spacerun:yes">&nbsp;&nbsp; </span></span><span
        style="font-size:11.0pt;
        font-family:Wingdings;mso-ascii-font-family:&quot;HP
        Simplified&quot;;mso-fareast-font-family:
+mn-ea;mso-bidi-font-family:+mn-cs;mso-ascii-theme-font:minor-latin;mso-fareast-theme-font:
minor-fareast;mso-bidi-theme-font:minor-bidi;color:black;mso-color-index:1;
mso-font-kerning:12.0pt;language:en-US;mso-char-type:symbol;mso-symbol-font-family:
Wingdings;mso-style-textfill-type:solid;mso-style-textfill-fill-themecolor:
text1;mso-style-textfill-fill-color:black;mso-style-textfill-fill-alpha:100.0%"></span></p>
    <meta name="ProgId" content="PowerPoint.Slide">
    <meta name="Generator" content="Microsoft PowerPoint 14">
    <br>
    <br>
    [&nbsp; Don't mean to digress from the topic but in most of my
    under-commit + pinned large guest experiments with 3.10 kernels
    (using 2 or 3 different workloads) the time spent in halt exits are
    typically much more than the time spent in ple exits. Can anything
    be done to reduce the duration or avoid those exits ?&nbsp; ]<br>
    <br>
    <blockquote cite="mid:51CAEF45.3010203@linux.vnet.ibm.com"
      type="cite">
      <br>
      1. dynamic ple window was one solution for PLE, which we can
      experiment
      <br>
      further. (at VM level or global).
      <br>
    </blockquote>
    <br>
    Is this the case where the dynamic PLE&nbsp; window starts off at a value
    more suitable to reduce exits for under-commit (and pinned) cases
    and only when the host OS detects that the degree of under-commit is
    shrinking (i.e. moving towards having more vcpus to schedule and
    hence getting to be over committed) it adjusts the ple window more
    suitable to the over commit case ? or is this some different idea ?
    <br>
    <br>
    Thanks<br>
    Vinod<br>
    <br>
    <blockquote cite="mid:51CAEF45.3010203@linux.vnet.ibm.com"
      type="cite">The other experiment I was thinking is to extend
      spinlock to
      <br>
      accommodate vcpuid (Linus has opposed that but may be worth a
      <br>
      try).
      <br>
      <br>
    </blockquote>
    <br>
    <br>
    <blockquote cite="mid:51CAEF45.3010203@linux.vnet.ibm.com"
      type="cite">2. Andrew Theurer had patch to reduce double runq lock
      that I will be testing.
      <br>
      <br>
      I have some older experiments to retry though they did not give
      significant improvements before the PLE handler modified.
      <br>
      <br>
      Andrew, do you have any other details to add (from perf report
      that you usually take with these experiments)?
      <br>
      <br>
      .
      <br>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------000207040400090303070409--

--===============5521982060663361879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5521982060663361879==--
