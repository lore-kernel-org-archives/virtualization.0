From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] kvmalloc: always use vmalloc if CONFIG_DEBUG_VM
Date: Fri, 20 Apr 2018 16:54:53 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1804201635180.25408__35022.3243040547$1524257594$gmane$org@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1804181029270.19294@file01.intranet.prod.int.rdu2.redhat.com>
	<3e65977e-53cd-bf09-bc4b-0ce40e9091fe@gmail.com>
	<alpine.LRH.2.02.1804181218270.19136@file01.intranet.prod.int.rdu2.redhat.com>
	<20180418.134651.2225112489265654270.davem@davemloft.net>
	<alpine.LRH.2.02.1804181350050.17942@file01.intranet.prod.int.rdu2.redhat.com>
	<alpine.LRH.2.02.1804191207380.31175@file01.intranet.prod.int.rdu2.redhat.com>
	<20180420130852.GC16083@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180420130852.GC16083@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@kernel.org>
Cc: dm-devel@redhat.com, eric.dumazet@gmail.com, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, edumazet@google.com, bhutchings@solarflare.com, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org



On Fri, 20 Apr 2018, Michal Hocko wrote:

> On Thu 19-04-18 12:12:38, Mikulas Patocka wrote:
> [...]
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > Subject: [PATCH] kvmalloc: always use vmalloc if CONFIG_DEBUG_VM
> > 
> > The kvmalloc function tries to use kmalloc and falls back to vmalloc if
> > kmalloc fails.
> > 
> > Unfortunatelly, some kernel code has bugs - it uses kvmalloc and then
> > uses DMA-API on the returned memory or frees it with kfree. Such bugs were
> > found in the virtio-net driver, dm-integrity or RHEL7 powerpc-specific
> > code.
> > 
> > These bugs are hard to reproduce because vmalloc falls back to kmalloc
> > only if memory is fragmented.
> > 
> > In order to detect these bugs reliably I submit this patch that changes
> > kvmalloc to always use vmalloc if CONFIG_DEBUG_VM is turned on.
> 
> No way. This is just wrong! First of all, you will explode most likely
> on many allocations of small sizes. Second, CONFIG_DEBUG_VM tends to be
> enabled quite often.

You're an evil person who doesn't want to fix bugs.

You refused to fix vmalloc(GFP_NOIO) misbehavior a year ago (did you make 
some progress with it since that time?) and you refuse to fix kvmalloc 
misuses.

I tried this patch on text-only virtual machine and /proc/vmallocinfo 
shows 614kB more memory. I tried it on a desktop machine with the chrome 
browser open and /proc/vmallocinfo space is increased by 7MB. So no - this 
won't exhaust memory and kill the machine.

Arguing that this increases memory consumption is as bogus as arguing that 
CONFIG_LOCKDEP increses memory consumption. No one is forcing you to 
enable CONFIG_LOCKDEP and no one is forcing you to enable this kvmalloc 
test too.

Mikulas
