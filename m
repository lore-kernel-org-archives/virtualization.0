From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lguest/host benchmarks.
Date: Sat, 09 Jun 2007 14:16:42 +1000
Message-ID: <1181362602.6025.72.camel@localhost.localdomain>
References: <Pine.LNX.4.60.0706011704240.786@rtl14.hofr.at>
	<1180780059.9228.72.camel@localhost.localdomain>
	<Pine.LNX.4.60.0706080908100.811@rtl14.hofr.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0706080908100.811@rtl14.hofr.at>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Jens Axboe <jens.axboe@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-06-08 at 09:27 +0200, Nicholas Mc Guire wrote:
> HI !

Hi Nicholas,

	Thanks for this!

>   here are some preliminary benchmarks of lguest vs host (2.6.21)
> 
>   Most results seem resonable - the file create/delete is a bit
>   strange - does anybody have an idea why 0k file create/delete could
>   be so much faster under lguest and 10k file so much slower ?

Is this ext3?   The lguest blockio drvier is very naive and is actually
synchronous (SLOW!), but also ignores barriers.

BTW, I suspect your sh is different inside the guest than host:

> darkstar  Lguest 2.6.21 1602 0.21 0.37 2.38 4.02      0.65 1.75 1137 2653 7960
> darkstar   Linux 2.6.21 1602 0.18 0.37 3.54 5.20 28.9 0.62 1.59 213. 1042 8725

>   The only really serious problem with lguest performance seems to be
>   mmap latency, page-faults and protection faults.

Yes.  A real page fault hurts quite a bit, because all page faults go
via the host (which can swap out guest pages or have them COW).
Sequence goes:

- Guest userspace hits page
- Trap to switcher
- Switch to host kernel
- Walk guest pagetables to see if it's mapped, it's not, so deliver.
- Switch to guest kernel
- Process fault, insert page table entry
- Trap to switcher
- Switch to host kernel
- Insert page table entry in shadow pagetables
- Switch to guest kernel
- Handle fault

This can be optimized by enhancing the switcher itself to walk the guest
page tables and reflect is straight back into the guest if it's not
mapped there.  This shouldn't actually be too hard, but I wonder if it's
worth the complexity...

Thanks!
Rusty.
