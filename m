From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc
	fallback options
Date: Thu, 26 Apr 2018 22:14:19 +0300
Message-ID: <20180426220523-mutt-send-email-mst__41913.3847383366$1524769950$gmane$org@kernel.org>
References: <20180426125817.GO17484@dhcp22.suse.cz>
	<alpine.LRH.2.02.1804261006120.32722@file01.intranet.prod.int.rdu2.redhat.com>
	<1524753932.3226.5.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804261100170.12157@file01.intranet.prod.int.rdu2.redhat.com>
	<1524756256.3226.7.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804261142480.21152@file01.intranet.prod.int.rdu2.redhat.com>
	<20180426184845-mutt-send-email-mst@kernel.org>
	<alpine.LRH.2.02.1804261202350.24656@file01.intranet.prod.int.rdu2.redhat.com>
	<20180426214011-mutt-send-email-mst@kernel.org>
	<alpine.LRH.2.02.1804261451120.23716@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1804261451120.23716@file01.intranet.prod.int.rdu2.redhat.com>
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
Cc: eric.dumazet@gmail.com, netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, dm-devel@redhat.com, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>, edumazet@google.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 26, 2018 at 02:54:26PM -0400, Mikulas Patocka wrote:
> 
> 
> On Thu, 26 Apr 2018, Michael S. Tsirkin wrote:
> 
> > On Thu, Apr 26, 2018 at 12:07:25PM -0400, Mikulas Patocka wrote:
> > > > IIUC debug kernels mainly exist so people who experience e.g. memory
> > > > corruption can try and debug the failure. In this case, CONFIG_DEBUG_SG
> > > > will *already* catch a failure early. Nothing special needs to be done.
> > > 
> > > The patch helps people debug such memory coprruptions (such as using DMA 
> > > API on the result of kvmalloc).
> > 
> > That's my point.  I don't think your patch helps debug any memory
> > corruptions.  With CONFIG_DEBUG_SG using DMA API already causes a
> > BUG_ON, that's before any memory can get corrupted.
> 
> The patch turns a hard-to-reproduce bug into an easy-to-reproduce bug. 

It's still not a memory corruption. It's a BUG_ON the source of which -
should it trigger - can be typically found using grep.

> Obviously we don't want this in production kernels, but in the debug 
> kernels it should be done.
> 
> Mikulas

I'm not so sure. debug kernels should make debugging easier,
definitely.

Unfortunately they are already slower so some races don't trigger.

If they also start crashing more because we are injecting
memory allocation errors, people are even less likely to
be able to use them.

Just add a comment near the BUG_ON within DMA API telling people how
they can inject this error some more if the bug does not
reproduce, and leave it at that.

-- 
MST
