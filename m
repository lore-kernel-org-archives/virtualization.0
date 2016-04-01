From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 5/6] virt, sched: add cpu pinning to
	smp_call_sync_on_phys_cpu()
Date: Fri, 1 Apr 2016 11:26:25 +0200
Message-ID: <56FE3EC1.7000800@suse.com>
References: <1459494874-12194-1-git-send-email-jgross@suse.com>
	<1459494874-12194-6-git-send-email-jgross@suse.com>
	<20160401074325.GC12845@twins.programming.kicks-ass.net>
	<56FE313E.9060804@suse.com>
	<20160401084408.GF3448@twins.programming.kicks-ass.net>
	<56FE3959.2030508@suse.com>
	<20160401091507.GG3448@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160401091507.GG3448@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, jeremy@goop.org, jdelvare@suse.com, konrad.wilk@oracle.com, hpa@zytor.com, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

On 01/04/16 11:15, Peter Zijlstra wrote:
> On Fri, Apr 01, 2016 at 11:03:21AM +0200, Juergen Gross wrote:
>>> Maybe just make the vpin thing an option like:
>>>
>>> 	smp_call_on_cpu(int (*func)(void *), int phys_cpu);
> 
>>> Also; is something like the vpin thing possible on KVM? because if we're
>>> going to expose it to generic code like this we had maybe look at wider
>>> support.
>>
>> It is necessary for dom0 under Xen. I don't think there is a need to do
>> this on KVM as a guest has no direct access to e.g. BIOS functions of
>> the real hardware and the host system needs no vcpu pinning. I'm not
>> sure about VMWare.
> 
> OK, then can we WARN if .phys=1 and the platform doesn't support it?
> 

Yes, good idea.


Juergen
