From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 00/14] PV ticket locks without expanding spinlock
Date: Wed, 17 Nov 2010 10:56:29 +0200
Message-ID: <4CE398BD.7080708__40128.793687518$1289984283$gmane$org@redhat.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/16/2010 11:08 PM, Jeremy Fitzhardinge wrote:
> From: Jeremy Fitzhardinge<jeremy.fitzhardinge@citrix.com>
>
> Hi all,
>
> This is a revised version of the pvticket lock series.
>
> The early part of the series is mostly unchanged: it converts the bulk
> of the ticket lock code into C and makes the "small" and "large"
> ticket code common.  The only changes are the incorporation of various
> review comments.
>
> The latter part of the series converts from pv spinlocks to pv ticket
> locks (ie, using the ticket lock fastpath as-is, but adding pv ops for
> the ticketlock slowpaths).
>
> The significant difference here is that rather than adding a new
> ticket_t-sized element to arch_spinlock_t - effectively doubling the
> size - I steal the LSB of the tickets themselves to store a bit.  This
> allows the structure to remain the same size, but at the cost of
> halving the max number of CPUs (127 for a 8-bit ticket, and a hard max
> of 32767 overall).
>
> The extra bit (well, two, but one is unused) in indicates whether the
> lock has gone into "slowpath state", which means one of its lockers
> has entered its slowpath and has blocked in the hypervisor.  This
> means the current lock-holder needs to make sure it gets kicked out of
> the hypervisor on unlock.
>
> The spinlock remains in slowpath state until the last unlock happens
> (ie there are no more queued lockers).
>
> This code survives for a while with moderate testing, (make -j 100 on
> 8 VCPUs on a 4 PCPU system), but locks up after about 20 iterations,
> so there's still some race/deadlock in there (probably something
> misordered), but I think the basic approach is sound.

This is going to be very useful for kvm; I'd like to see the fixed 
version gets merged.

-- 
error compiling committee.c: too many arguments to function
