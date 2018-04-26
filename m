From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc fallback
	options
Date: Thu, 26 Apr 2018 14:58:08 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1804261454380.23716__36753.5254605629$1524768977$gmane$org@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com>
	<alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com>
	<1524694663.4100.21.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com>
	<20180426125817.GO17484@dhcp22.suse.cz>
	<alpine.LRH.2.02.1804261006120.32722@file01.intranet.prod.int.rdu2.redhat.com>
	<1524753932.3226.5.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804261100170.12157@file01.intranet.prod.int.rdu2.redhat.com>
	<1524756256.3226.7.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804261142480.21152@file01.intranet.prod.int.rdu2.redhat.com>
	<20180426184845-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180426184845-mutt-send-email-mst@kernel.org>
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

> How do you make sure QA tests a specific corner case? Add it to
> the test plan :)

BTW. how many "lines of code" of corporate bureaucracy would that take? :-)

> I don't speak for Red Hat, etc.
> 
> -- 
> MST

Mikulas
