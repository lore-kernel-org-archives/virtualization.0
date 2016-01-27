From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] documentation: Add disclaimer
Date: Wed, 27 Jan 2016 10:11:52 +0000
Message-ID: <20160127101151.GB2390__40390.3658887886$1453889537$gmane$org@arm.com>
References: <20160114120445.GB15828@arm.com> <56980145.5030901@imgtec.com>
	<20160114204827.GE3818@linux.vnet.ibm.com>
	<56981212.7050301@imgtec.com>
	<20160114222046.GH3818@linux.vnet.ibm.com>
	<20160126102402.GE6357@twins.programming.kicks-ass.net>
	<20160126103200.GI6375@twins.programming.kicks-ass.net>
	<20160126110053.GA21553@arm.com>
	<20160126201143.GV4503@linux.vnet.ibm.com>
	<20160127083546.GJ6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160127083546.GJ6357@twins.programming.kicks-ass.net>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ddaney.cavm@gmail.com, Thomas Gleixner <tglx@linutronix.de>, linux-metag@v
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 27, 2016 at 09:35:46AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 26, 2016 at 12:11:43PM -0800, Paul E. McKenney wrote:
> > So Peter, would you like to update your patch to include yourself
> > and Will as authors?
> 
> Sure, here goes.
> 
> ---
> Subject: documentation: Add disclaimer
> 
> It appears people are reading this document as a requirements list for
> building hardware. This is not the intent of this document. Nor is it
> particularly suited for this purpose.
> 
> The primary purpose of this document is our collective attempt to define
> a set of primitives that (hopefully) allow us to write correct code on
> the myriad of SMP platforms Linux supports.
> 
> Its a definite work in progress as our understanding of these platforms,
> and memory ordering in general, progresses.
> 
> Nor does being mentioned in this document mean we think its a
> particularly good idea; the data dependency barrier required by Alpha
> being a prime example. Yes we have it, no you're insane to require it
> when building new hardware.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/memory-barriers.txt | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
