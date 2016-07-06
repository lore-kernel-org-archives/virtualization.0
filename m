From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
Date: Wed, 6 Jul 2016 14:44:31 +0200
Message-ID: <eb0672ba-4a00-f87e-9f01-31537d7497e3@redhat.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160706065255.GH30909@twins.programming.kicks-ass.net>
	<577CB786.8000902@suse.com>
	<20160706081920.GG30921@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160706081920.GG30921@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>
Cc: linux-s390@vger.kernel.org, dave@stgolabs.net, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, boqun.feng@gmail.com, will.deacon@arm.com, xen-devel-request@lists.xenproject.org, waiman.long@hpe.com, linux-kernel@vger.kernel.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org, schwidefsky@de.ibm.com, paulmck@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org



On 06/07/2016 10:19, Peter Zijlstra wrote:
>>> Paolo, could you help out with an (x86) KVM interface for this?
>> > 
>> > Xen support of this interface should be rather easy. Could you please
>> > Cc: xen-devel-request@lists.xenproject.org in the next version?
> So meta question; aren't all you virt people looking at the regular
> virtualization list? Or should we really dig out all the various
> hypervisor lists and Cc them?

I at least skim the subjects.

Paolo
