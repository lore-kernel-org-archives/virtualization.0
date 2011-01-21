From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 2/3] kvm hypervisor : Add hypercalls to support
	pv-ticketlock
Date: Fri, 21 Jan 2011 09:48:29 -0500
Message-ID: <4D399CBD.10506__30459.177416242$1295621553$gmane$org@redhat.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<20110119164432.GA30669@linux.vnet.ibm.com>
	<20110119171239.GB726@linux.vnet.ibm.com>
	<1295457672.28776.144.camel@laptop> <4D373340.60608@goop.org>
	<20110120115958.GB11177@linux.vnet.ibm.com>
	<4D38774B.6070704@goop.org>
	<20110121140208.GA13609@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110121140208.GA13609@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: vatsa@linux.vnet.ibm.com
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?B?QW3DqXJpY28g?= =?UTF-8?B?V2FuZw==?= <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 01/21/2011 09:02 AM, Srivatsa Vaddagiri wrote:
> On Thu, Jan 20, 2011 at 09:56:27AM -0800, Jeremy Fitzhardinge wrote:
>>>   The key here is not to
>>> sleep when waiting for locks (as implemented by current patch-series, which can
>>> put other VMs at an advantage by giving them more time than they are entitled
>>> to)
>>
>> Why?  If a VCPU can't make progress because its waiting for some
>> resource, then why not schedule something else instead?
>
> In the process, "something else" can get more share of cpu resource than its
> entitled to and that's where I was bit concerned. I guess one could
> employ hard-limits to cap "something else's" bandwidth where it is of real
> concern (like clouds).

I'd like to think I fixed those things in my yield_task_fair +
yield_to + kvm_vcpu_on_spin patch series from yesterday.

https://lkml.org/lkml/2011/1/20/403

-- 
All rights reversed
