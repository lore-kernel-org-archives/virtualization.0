From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/14] x86/ticketlock: add slowpath logic
Date: Mon, 17 Jan 2011 20:52:22 +0530
Message-ID: <20110117152222.GA19233__9706.38596122644$1295277822$gmane$org@linux.vnet.ibm.com>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<97ed99ae9160bdb6477284b333bd6708fb7a19cb.1289940821.git.jeremy.fitzhardinge@citrix.com>
Reply-To: vatsa@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <97ed99ae9160bdb6477284b333bd6708fb7a19cb.1289940821.git.jeremy.fitzhardinge@citrix.com>
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
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Eric Dumazet <dada1@cosmosbay.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, suzuki@in.ibm.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 16, 2010 at 01:08:44PM -0800, Jeremy Fitzhardinge wrote:
> From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
> 
> Maintain a flag in both LSBs of the ticket lock which indicates whether
> anyone is in the lock slowpath and may need kicking when the current
> holder unlocks.  The flags are set when the first locker enters
> the slowpath, and cleared when unlocking to an empty queue.
> 
> In the specific implementation of lock_spinning(), make sure to set
> the slowpath flags on the lock just before blocking.  We must do
> this before the last-chance pickup test to prevent a deadlock
> with the unlocker:
> 
> Unlocker			Locker
> 				test for lock pickup
> 					-> fail
> test slowpath + unlock
> 	-> false
> 				set slowpath flags
> 				block
> 
> Whereas this works in any ordering:
> 
> Unlocker			Locker
> 				set slowpath flags
> 				test for lock pickup
> 					-> fail
> 				block
> test slowpath + unlock
> 	-> true, kick

I think this is still racy ..

Unlocker				Locker

				
test slowpath
	-> false
		
				set slowpath flag
				test for lock pickup
					-> fail
				block


unlock

unlock needs to happen first before testing slowpath? I have made that change
for my KVM guest and it seems to be working well with that change .. Will
cleanup and post my patches shortly

- vatsa
