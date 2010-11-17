From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 13/14] x86/ticketlock: add slowpath logic
Date: Wed, 17 Nov 2010 00:52:24 -0800
Message-ID: <4CE397C8.9040901__26005.5893836126$1289984009$gmane$org@goop.org>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com><cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<97ed99ae9160bdb6477284b333bd6708fb7a19cb.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<4CE3A1060200007800022B04@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CE3A1060200007800022B04@vpn.id2.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Eric Dumazet <dada1@cosmosbay.com>, Xen-devel <xen-devel@lists.xensource.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xiyou.wangcong@gmail.com, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/17/2010 12:31 AM, Jan Beulich wrote:
>>>> On 16.11.10 at 22:08, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>> +static inline void __ticket_enter_slowpath(struct arch_spinlock *lock)
>> +{
>> +	if (sizeof(lock->tickets.tail) == sizeof(u8))
>> +		asm (LOCK_PREFIX "orb %1, %0"
>> +		     : "+m" (lock->tickets.tail)
>> +		     : "i" (TICKET_SLOWPATH_FLAG) : "memory");
>> +	else
>> +		asm (LOCK_PREFIX "orw %1, %0"
>> +		     : "+m" (lock->tickets.tail)
>> +		     : "i" (TICKET_SLOWPATH_FLAG) : "memory");
>> +}
> Came only now to mind: Here and elsewhere, did you try using
> %z0 to have gcc produce the opcode suffix character, rather
> than having these somewhat ugly if()-s?

Actually in this case I'm pretty sure there's already a "set bit"
function which will do the job.  set_bit(), I guess, though it takes a
bit number rather than a mask...

But, yes, %z0 sounds interesting.  Is it documented anywhere?  I think
I've tried to use it in the past and run into gcc bugs.

Thanks,
    J
