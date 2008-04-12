From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 1/5] vringfd syscall
Date: Sun, 13 Apr 2008 04:19:54 +1000
Message-ID: <200804130419.55083.rusty__37493.3539926589$1208024497$gmane$org@rustcorp.com.au>
References: <200804052202.09157.rusty@rustcorp.com.au>
	<20080412171820.GA29568@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080412171820.GA29568@dmt>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 13 April 2008 03:18:20 Marcelo Tosatti wrote:
> I suppose you are doing data copy in ->poll instead of ->read to save
> a system call? This is weird, not conformant to what the interface is
> supposed to do.

Hi Marcelo,

   Thanks for reading this.

   Yeah, I dislike it too.  The main motivation was that not all rings need to 
be "pulled" in this way, but it turns out that userspace can detect this 
(poll, check ring, if nothing, try read, check ring).  So next version will 
unscrew the poll callback.

> > +	/* If they want to use atomically, we have to map the page. */
> > +	if (atomic_use) {
> > +		if (get_user_pages(current, current->mm,
> > +				   (unsigned long)vr->ring.used, 1, 1, 1,
> > +				   &vr->used_page, NULL) != 1) {
>
> Can't the same be achieved by the app mlocking the vring pages, which
> then goes through standard rlimit checking ?

Tun/tap writes to this from any context.  Fortunately, this too is changing, 
as I came up with a sane way of queueing to userspace context for this case.

Expect updated patches Monday.

Thanks!
Rusty.
