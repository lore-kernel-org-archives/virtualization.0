From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0 of 4] mm+paravirt+xen: add pte read-modify-write
	abstraction
Date: Fri, 23 May 2008 11:57:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805231133130.3081@woody.linux-foundation.org>
References: <patchbomb.1211552448@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <patchbomb.1211552448@localhost>
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
Cc: xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org



On Fri, 23 May 2008, Jeremy Fitzhardinge wrote:
> 
> This series adds the pte_rmw_start() and pte_rmw_commit() operations,
> which change this sequence to:
> 
> 	ptent = pte_rmw_start(mm, addr, pte);
> 	ptent = pte_modify(ptent, newprot);
> 	/* ... */
> 	pte_rmw_commit(mm, addr, pte, ptent);

Can you please rename these.

It's not a general "read-modify-write" operation on the PTE, and this 
*only* works for changing protection details. In particular, you cannot 
use pte_rmw_start/commit to change the actual page. So it's very much 
about just protection bits.

It should probably also be called ptep_xyz(), since it takes a pte 
pointer, not a pte.

So maybe calling it "ptent = ptep_modify_prot_start(..)" ... 
"ptep_modify_prot_commit(..)" or something.

			Linus
