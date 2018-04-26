From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc fallback
	options
Date: Thu, 26 Apr 2018 16:05:25 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1804261556290.3850__13620.8736141727$1524773015$gmane$org@file01.intranet.prod.int.rdu2.redhat.com>
References: <1524753932.3226.5.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804261100170.12157@file01.intranet.prod.int.rdu2.redhat.com>
	<1524756256.3226.7.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804261142480.21152@file01.intranet.prod.int.rdu2.redhat.com>
	<20180426184845-mutt-send-email-mst@kernel.org>
	<alpine.LRH.2.02.1804261202350.24656@file01.intranet.prod.int.rdu2.redhat.com>
	<20180426214011-mutt-send-email-mst@kernel.org>
	<alpine.LRH.2.02.1804261451120.23716@file01.intranet.prod.int.rdu2.redhat.com>
	<20180426220523-mutt-send-email-mst@kernel.org>
	<alpine.LRH.2.02.1804261516250.26980@file01.intranet.prod.int.rdu2.redhat.com>
	<20180426223925-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180426223925-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.dumazet@gmail.com, netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, dm-devel@redhat.com, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>, edumazet@google.com
List-Id: virtualization@lists.linuxfoundation.org



On Thu, 26 Apr 2018, Michael S. Tsirkin wrote:

> On Thu, Apr 26, 2018 at 03:36:14PM -0400, Mikulas Patocka wrote:
> > People on this list argue "this should be a kernel parameter".
> 
> How about making it a writeable attribute, so it's easy to turn on/off
> after boot. Then you can keep it deterministic, userspace can play with
> the attribute at random if it wants to.
> 
> -- 
> MST

It is already controllable by an attribute in debugfs.

Will you email all the testers about this attribute? How many of them will 
remember to set it? How many of them will remember to set it a year after? 
Will you write a userspace program that manages it and introduce it into 
the distributon?

This is a little feature.

Mikulas
