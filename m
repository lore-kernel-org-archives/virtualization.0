From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] kvmalloc: always use vmalloc if CONFIG_DEBUG_VM
Date: Tue, 24 Apr 2018 07:31:46 -0600
Message-ID: <20180424133146.GG17484__14476.754787802$1524576614$gmane$org@dhcp22.suse.cz>
References: <alpine.LRH.2.02.1804181350050.17942@file01.intranet.prod.int.rdu2.redhat.com>
	<alpine.LRH.2.02.1804191207380.31175@file01.intranet.prod.int.rdu2.redhat.com>
	<20180420130852.GC16083@dhcp22.suse.cz>
	<alpine.LRH.2.02.1804201635180.25408@file01.intranet.prod.int.rdu2.redhat.com>
	<20180420210200.GH10788@bombadil.infradead.org>
	<alpine.LRH.2.02.1804201704580.25408@file01.intranet.prod.int.rdu2.redhat.com>
	<20180421144757.GC14610@bombadil.infradead.org>
	<alpine.LRH.2.02.1804221733520.7995@file01.intranet.prod.int.rdu2.redhat.com>
	<20180423151545.GU17484@dhcp22.suse.cz>
	<alpine.LRH.2.02.1804232006540.2299@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1804232006540.2299@file01.intranet.prod.int.rdu2.redhat.com>
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
Cc: dm-devel@redhat.com, eric.dumazet@gmail.com, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, edumazet@google.com, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Mon 23-04-18 20:25:15, Mikulas Patocka wrote:
> 
> 
> On Mon, 23 Apr 2018, Michal Hocko wrote:
> 
> > On Mon 23-04-18 10:06:08, Mikulas Patocka wrote:
> > 
> > > > > He didn't want to fix vmalloc(GFP_NOIO)
> > > > 
> > > > I don't remember that conversation, so I don't know whether I agree with
> > > > his reasoning or not.  But we are supposed to be moving away from GFP_NOIO
> > > > towards marking regions with memalloc_noio_save() / restore.  If you do
> > > > that, you won't need vmalloc(GFP_NOIO).
> > > 
> > > He said the same thing a year ago. And there was small progress. 6 out of 
> > > 27 __vmalloc calls were converted to memalloc_noio_save in a year - 5 in 
> > > infiniband and 1 in btrfs. (the whole discussion is here 
> > > http://lkml.iu.edu/hypermail/linux/kernel/1706.3/04681.html )
> > 
> > Well this is not that easy. It requires a cooperation from maintainers.
> > I can only do as much. I've posted patches in the past and actively
> > bringing up this topic at LSFMM last two years...
> 
> You're right - but you have chosen the uneasy path.

Yes.

> Fixing __vmalloc code 
> is easy and it doesn't require cooperation with maintainers.

But it is a hack against the intention of the scope api. It also alows
maintainers to not care about their broken code.

> > > He refuses 15-line patch to fix GFP_NOIO bug because he believes that in 4 
> > > years, the kernel will be refactored and GFP_NOIO will be eliminated. Why 
> > > does he have veto over this part of the code? I'd much rather argue with 
> > > people who have constructive comments about fixing bugs than with him.
> > 
> > I didn't NACK the patch AFAIR. I've said it is not a good idea longterm.
> > I would be much more willing to change my mind if you would back your
> > patch by a real bug report. Hacks are acceptable when we have a real
> > issue in hands. But if we want to fix potential issue then better make
> > it properly.
> 
> Developers should fix bugs in advance, not to wait until a crash hapens, 
> is analyzed and reported.

I agree. But are those existing users broken in the first place? I have
seen so many GFP_NOFS abuses that I would dare to guess that most of
those vmalloc NOFS abusers can be simply turned into GFP_KERNEL. Maybe
that is the reason we haven't heard any complains in years.

-- 
Michal Hocko
SUSE Labs
