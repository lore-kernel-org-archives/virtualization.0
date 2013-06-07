From: Andrew Theurer <habanero@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V9 0/19] Paravirtualized ticket spinlocks
Date: Fri, 07 Jun 2013 08:29:13 -0500
Message-ID: <1370611753.1425.50.camel__35081.1294316829$1370879185$gmane$org@oc2024037011.ibm.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<20130602080739.GA24773@redhat.com>
	<CAJocwcf0oykyLv4B22pBf1A3H7+Cs6qu0vmTWp46Z=KwrTkXyQ@mail.gmail.com>
	<51ABF410.4090109@linux.vnet.ibm.com>
	<51AC35F0.4010400@linux.vnet.ibm.com>
	<51B17A6A.7060709@linux.vnet.ibm.com>
Reply-To: habanero@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51B17A6A.7060709@linux.vnet.ibm.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, gregkh@suse.de, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Jones <drjones@redhat.com>, virtualization@lists.linux-foundation.org, andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@redhat.com>, konrad.wilk@oracle.com, Jiannan Ouyang <ouyang@cs.pitt.edu>, Avi Kivity <avi.kivity@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, chegu vinod <chegu_vinod@hp.com>, LKML <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <srivatsa.vaddagiri@gmail.com>, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2013-06-07 at 11:45 +0530, Raghavendra K T wrote:
> On 06/03/2013 11:51 AM, Raghavendra K T wrote:
> > On 06/03/2013 07:10 AM, Raghavendra K T wrote:
> >> On 06/02/2013 09:50 PM, Jiannan Ouyang wrote:
> >>> On Sun, Jun 2, 2013 at 1:07 AM, Gleb Natapov <gleb@redhat.com> wrote:
> >>>
> >>>> High level question here. We have a big hope for "Preemptable Ticket
> >>>> Spinlock" patch series by Jiannan Ouyang to solve most, if not all,
> >>>> ticketing spinlocks in overcommit scenarios problem without need for
> >>>> PV.
> >>>> So how this patch series compares with his patches on PLE enabled
> >>>> processors?
> >>>>
> >>>
> >>> No experiment results yet.
> >>>
> >>> An error is reported on a 20 core VM. I'm during an internship
> >>> relocation, and will start work on it next week.
> >>
> >> Preemptable spinlocks' testing update:
> >> I hit the same softlockup problem while testing on 32 core machine with
> >> 32 guest vcpus that Andrew had reported.
> >>
> >> After that i started tuning TIMEOUT_UNIT, and when I went till (1<<8),
> >> things seemed to be manageable for undercommit cases.
> >> But I still see degradation for undercommit w.r.t baseline itself on 32
> >> core machine (after tuning).
> >>
> >> (37.5% degradation w.r.t base line).
> >> I can give the full report after the all tests complete.
> >>
> >> For over-commit cases, I again started hitting softlockups (and
> >> degradation is worse). But as I said in the preemptable thread, the
> >> concept of preemptable locks looks promising (though I am still not a
> >> fan of  embedded TIMEOUT mechanism)
> >>
> >> Here is my opinion of TODOs for preemptable locks to make it better ( I
> >> think I need to paste in the preemptable thread also)
> >>
> >> 1. Current TIMEOUT UNIT seem to be on higher side and also it does not
> >> scale well with large guests and also overcommit. we need to have a
> >> sort of adaptive mechanism and better is sort of different TIMEOUT_UNITS
> >> for different types of lock too. The hashing mechanism that was used in
> >> Rik's spinlock backoff series fits better probably.
> >>
> >> 2. I do not think TIMEOUT_UNIT itself would work great when we have a
> >> big queue (for large guests / overcommits) for lock.
> >> one way is to add a PV hook that does yield hypercall immediately for
> >> the waiters above some THRESHOLD so that they don't burn the CPU.
> >> ( I can do POC to check if  that idea works in improving situation
> >> at some later point of time)
> >>
> >
> > Preemptable-lock results from my run with 2^8 TIMEOUT:
> >
> > +-----------+-----------+-----------+------------+-----------+
> >                   ebizzy (records/sec) higher is better
> > +-----------+-----------+-----------+------------+-----------+
> >      base        stdev        patched    stdev        %improvement
> > +-----------+-----------+-----------+------------+-----------+
> > 1x  5574.9000   237.4997    3484.2000   113.4449   -37.50202
> > 2x  2741.5000   561.3090     351.5000   140.5420   -87.17855
> > 3x  2146.2500   216.7718     194.8333    85.0303   -90.92215
> > 4x  1663.0000   141.9235     101.0000    57.7853   -93.92664
> > +-----------+-----------+-----------+------------+-----------+
> > +-----------+-----------+-----------+------------+-----------+
> >                 dbench  (Throughput) higher is better
> > +-----------+-----------+-----------+------------+-----------+
> >       base        stdev        patched    stdev        %improvement
> > +-----------+-----------+-----------+------------+-----------+
> > 1x  14111.5600   754.4525   3930.1602   2547.2369    -72.14936
> > 2x  2481.6270    71.2665      181.1816    89.5368    -92.69908
> > 3x  1510.2483    31.8634      104.7243    53.2470    -93.06576
> > 4x  1029.4875    16.9166       72.3738    38.2432    -92.96992
> > +-----------+-----------+-----------+------------+-----------+
> >
> > Note we can not trust on overcommit results because of softlock-ups
> >
> 
> Hi, I tried
> (1) TIMEOUT=(2^7)
> 
> (2) having yield hypercall that uses kvm_vcpu_on_spin() to do directed 
> yield to other vCPUs.
> 
> Now I do not see any soft-lockup in overcommit cases and results are 
> better now (except ebizzy 1x). and for dbench I see now it is closer to 
> base and even improvement in 4x
> 
> +-----------+-----------+-----------+------------+-----------+
>                 ebizzy (records/sec) higher is better
> +-----------+-----------+-----------+------------+-----------+
>    base        stdev        patched    stdev        %improvement
> +-----------+-----------+-----------+------------+-----------+
>    5574.9000   237.4997     523.7000     1.4181   -90.60611
>    2741.5000   561.3090     597.8000    34.9755   -78.19442
>    2146.2500   216.7718     902.6667    82.4228   -57.94215
>    1663.0000   141.9235    1245.0000    67.2989   -25.13530
> +-----------+-----------+-----------+------------+-----------+
> +-----------+-----------+-----------+------------+-----------+
>                  dbench  (Throughput) higher is better
> +-----------+-----------+-----------+------------+-----------+
>     base        stdev        patched    stdev        %improvement
> +-----------+-----------+-----------+------------+-----------+
>   14111.5600   754.4525     884.9051    24.4723   -93.72922
>    2481.6270    71.2665    2383.5700   333.2435    -3.95132
>    1510.2483    31.8634    1477.7358    50.5126    -2.15279
>    1029.4875    16.9166    1075.9225    13.9911     4.51050
> +-----------+-----------+-----------+------------+-----------+
> 
> 
> IMO hash based timeout is worth a try further.
> I think little more tuning will get more better results.

The problem I see (especially for dbench) is that we are still way off
what I would consider the goal.  IMO, 2x over-commit result should be a
bit lower than 50% (to account for switching overhead and less cache
warmth).  We are at about 17.5% for 2x.  I am thinking we need a
completely different approach to get there, but of course I do not know
what that is yet :)  

I am testing your patches now and hopefully with some analysis data we
can better understand what's going on.
> 
> Jiannan, When you start working on this, I can also help
> to get best of preemptable lock idea if you wish and share
> the patches I tried.

-Andrew Theurer
