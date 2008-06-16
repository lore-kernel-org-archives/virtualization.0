From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1 of 4] mm: add a ptep_modify_prot transaction abstraction
Date: Mon, 16 Jun 2008 10:29:19 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806161028080.2949@woody.linux-foundation.org>
References: <b020e42384197b824320.1213615800@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b020e42384197b824320.1213615800@localhost>
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
Cc: xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm-devel <kvm-devel@lists.sourceforge.net>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org



On Mon, 16 Jun 2008, Jeremy Fitzhardinge wrote:
>
> ptep_modify_prot_start() returns the current pte value, and puts the
>   pte entry into a state where either the hardware will not update the
>   pte, or if it does, the updates will be preserved on commit.
> 
> ptep_modify_prot_commit() writes back the updated pte, makes sure that
>   any hardware updates made since ptep_modify_prot_start() are
>   preserved.

Ok, I'm fine with this now that it's renamed to be clearly about just 
protection bits.

So 

	Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

for what it's worth.

		Linus
