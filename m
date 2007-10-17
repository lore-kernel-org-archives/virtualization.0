From: Nick Piggin <npiggin@suse.de>
Subject: Re: LFENCE instruction (was: [rfc][patch 3/3] x86: optimise
	barriers)
Date: Wed, 17 Oct 2007 14:28:42 +0200
Message-ID: <20071017122842.GB14401__21357.0456406616$1192632561$gmane$org@wotan.suse.de>
References: <20071016002229.GA5851@wotan.suse.de>
	<E1Ii1oL-0005I3-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <E1Ii1oL-0005I3-00@gondolin.me.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: virtualization <virtualization@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, mikulas@artax.karlin.mff.cuni.cz, arjan@infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 17, 2007 at 01:51:17PM +0800, Herbert Xu wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> >
> > Also, for non-wb memory. I don't think the Intel document referenced
> > says anything about this, but the AMD document says that loads can pass
> > loads (page 8, rule b).
> > 
> > This is why our rmb() is still an lfence.
> 
> BTW, Xen (in particular, the code in drivers/xen) uses mb/rmb/wmb
> instead of smp_mb/smp_rmb/smp_wmb when it accesses memory that's
> shared with other Xen domains or the hypervisor.
> 
> The reason this is necessary is because even if a Xen domain is
> UP the hypervisor might be SMP.
> 
> It would be nice if we can have these adopt the new SMP barriers
> on x86 instead of the IO ones as they currently do.

That's a good point actually. Something like raw_smp_*mb, which
always orders memory, but only for regular WB operatoins. I could
put that on the todo list...
