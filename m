From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] kvmalloc: always use vmalloc if CONFIG_DEBUG_VM
Date: Sat, 21 Apr 2018 07:47:57 -0700
Message-ID: <20180421144757.GC14610__29882.1359560408$1524321976$gmane$org@bombadil.infradead.org>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com>
	<3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
	<alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
	<20180418.134651.2225112489265654270.davem@davemloft.net>
	<alpine.LRH.2.02.1804181350050.17942@file01.intranet.prod.int.rdu2.redhat.com>
	<alpine.LRH.2.02.1804191207380.31175@file01.intranet.prod.int.rdu2.redhat.com>
	<20180420130852.GC16083@dhcp22.suse.cz>
	<alpine.LRH.2.02.1804201635180.25408@file01.intranet.prod.int.rdu2.redhat.com>
	<20180420210200.GH10788@bombadil.infradead.org>
	<alpine.LRH.2.02.1804201704580.25408@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1804201704580.25408@file01.intranet.prod.int.rdu2.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@redhat.com, eric.dumazet@gmail.com, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, edumazet@google.com, bhutchings@solarflare.com, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 20, 2018 at 05:21:26PM -0400, Mikulas Patocka wrote:
> On Fri, 20 Apr 2018, Matthew Wilcox wrote:
> > On Fri, Apr 20, 2018 at 04:54:53PM -0400, Mikulas Patocka wrote:
> > > On Fri, 20 Apr 2018, Michal Hocko wrote:
> > > > No way. This is just wrong! First of all, you will explode most likely
> > > > on many allocations of small sizes. Second, CONFIG_DEBUG_VM tends to be
> > > > enabled quite often.
> > > 
> > > You're an evil person who doesn't want to fix bugs.
> > 
> > Steady on.  There's no need for that.  Michal isn't evil.  Please
> > apologise.
> 
> I see this attitude from Michal again and again.

Fine; then *say that*.  I also see Michal saying "No" a lot.  Sometimes
I agree with him, sometimes I don't.  I think he genuinely wants the best
code in the kernel, and saying "No" is part of it.

> He didn't want to fix vmalloc(GFP_NOIO)

I don't remember that conversation, so I don't know whether I agree with
his reasoning or not.  But we are supposed to be moving away from GFP_NOIO
towards marking regions with memalloc_noio_save() / restore.  If you do
that, you won't need vmalloc(GFP_NOIO).

> he didn't want to fix alloc_pages sleeping when __GFP_NORETRY is used.

The GFP flags are a mess, still.

> So what should I say? Fix them and 
> you won't be evil :-)

No, you should reserve calling somebody evil for truly evil things.

> (he could also fix the oom killer, so that it is triggered when 
> free_memory+cache+free_swap goes beyond a threshold and not when you loop 
> too long in the allocator)

... that also doesn't make somebody evil.

> I already said that we can change it from CONFIG_DEBUG_VM to 
> CONFIG_DEBUG_SG - or to whatever other option you may want, just to make 
> sure that it is enabled in distro debug kernels by default.

Yes, and I think that's the right idea.  So send a v2 and ignore the
replies that are clearly relating to an earlier version of the patch.
Not everybody reads every mail in the thread before responding to one they
find interesting.  Yes, ideally, one would, but sometimes one doesn't.
