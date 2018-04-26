From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc
	fallback options
Date: Fri, 27 Apr 2018 01:21:52 +0300
Message-ID: <20180427005213-mutt-send-email-mst__28403.0563118451$1524781271$gmane$org@kernel.org>
References: <alpine.LRH.2.02.1804251556060.30569@file01.intranet.prod.int.rdu2.redhat.com>
	<1114eda5-9b1f-4db8-2090-556b4a37c532@infradead.org>
	<alpine.LRH.2.02.1804251656300.9428@file01.intranet.prod.int.rdu2.redhat.com>
	<alpine.DEB.2.21.1804251417470.166306@chino.kir.corp.google.com>
	<alpine.LRH.2.02.1804251720090.9428@file01.intranet.prod.int.rdu2.redhat.com>
	<1524694663.4100.21.camel@HansenPartnership.com>
	<alpine.LRH.2.02.1804251857070.31135@file01.intranet.prod.int.rdu2.redhat.com>
	<1524697697.4100.23.camel@HansenPartnership.com>
	<23266.8532.619051.784274@quad.stoffel.home>
	<alpine.LRH.2.02.1804261726540.13401@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1804261726540.13401@file01.intranet.prod.int.rdu2.redhat.com>
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
Cc: Andrew@stoffel.org, eric.dumazet@gmail.com, linux-mm@kvack.org, edumazet@google.com, netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, John Stoffel <john@stoffel.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Hocko <mhocko@kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Michal@stoffel.org, dm-devel@redhat.com, David Rientjes <rientjes@google.com>, Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 26, 2018 at 05:50:20PM -0400, Mikulas Patocka wrote:
> How is the user or developer supposed to learn about this option, if 
> he gets no crash at all?

Look in /sys/kernel/debug/fail* ? That actually lets you
filter by module, process etc.

I think this patch conflates two things:

1. Make kvmalloc use the vmalloc path.
    This seems a bit narrow.
    What is special about kvmalloc? IMHO nothing - it's yet another user
    of __GFP_NORETRY or __GFP_RETRY_MAYFAIL. As any such
    user, it either recovers correctly or not.
    So IMHO it's just a case of
    making __GFP_NORETRY, __GFP_RETRY_MAYFAIL, or both
    fail once in a while.
    Seems like a better extension to me than focusing on vmalloc.
    I think you will find more bugs this way.

2. Ability to control this from a separate config
   option.

   It's still not that clear to me why is this such a
   hard requirement.  If a distro wants to force specific
   boot time options, why isn't CONFIG_CMDLINE sufficient?

   But assuming it's important to control this kind of
   fault injection to be controlled from
   a dedicated menuconfig option, why not the rest of
   faults?

IMHO if you split 1/2 up, and generalize, the path upstream
will be much smoother.

Hope this helps.

-- 
MST
