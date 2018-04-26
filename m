From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc fallback
	options
Date: Thu, 26 Apr 2018 11:22:38 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1804261116470.14894__37535.0340306342$1524756049$gmane$org@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804261045001.9108@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-997862569-1524756159=:14894"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LRH.2.02.1804261045001.9108@file01.intranet.prod.int.rdu2.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: eric.dumazet@gmail.com, mst@redhat.com, netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, dm-devel@redhat.com, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>, edumazet@google.com
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-997862569-1524756159=:14894
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Thu, 26 Apr 2018, Mikulas Patocka wrote:

> 
> 
> On Wed, 25 Apr 2018, James Bottomley wrote:
> 
> > > BTW. even developers who compile their own kernel should have this
> > > enabled by a CONFIG option - because if the developer sees the option
> > > when browsing through menuconfig, he may enable it. If he doesn't see
> > > the option, he won't even know that such an option exists.
> > 
> > I may be an atypical developer but I'd rather have a root canal than
> > browse through menuconfig options.  The way to get people to learn
> > about new debugging options is to blog about it (or write an lwn.net
> > article) which google will find the next time I ask it how I debug XXX.
> >  Google (probably as a service to humanity) rarely turns up Kconfig
> > options in response to a query.
> 
> From my point of view, this feature should be as little disruptive to the 
> developer as possible. It should work automatically behind the scenes 
> without the developer or the tester even knowing that it is working. From 
> this point of view, binding it to CONFIG_DEBUG_SG (or any other commonly 
> used debugging option) would be ideal, because driver developers already 
> enable CONFIG_DEBUG_SG, so they'll get this kvmalloc test for free.
> 
> From your point of view, you should introduce a sysfs file and a kernel 
> parameter that no one knows about - and then start blogging about it - to 
> let people know. Why would you bother people with this knowledge? They'll 
> forget about it anyway and won't turn it on.

BTW. try to think about - how many total lines of code should this feature 
consume in the whole Linux ecosystem?

I made a 10-line patch. I got pushback.

I remade it to a 53-line patch. And you try to suggest that 53 lines is 
not enough and we must also change kernel packaging scripts in distro 
kernels, because the kernel just cannot enable this feature on its own.

If we hack kernel packaging scripts in most distros, how many lines of 
code would that be? What's your target?

Mikulas
--185206533-997862569-1524756159=:14894
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--185206533-997862569-1524756159=:14894--
