From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] KVM simplified virtio balloon driver
Date: Thu, 17 Jan 2008 11:25:58 +0100
Message-ID: <1200565558.22385.13.camel__5232.09153111583$1200585826$gmane$org@localhost>
References: <20080114200357.GA18354@dmt>
	<1200525166.26281.103.camel@localhost.localdomain>
	<200801171245.59510.rusty@rustcorp.com.au>
	<200801171032.26198.borntraeger@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801171032.26198.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Marcelo Tosatti <marcelo@kvack.org>, virtualization@lists.linux-foundation.org, kvm-devel <kvm-devel@lists.sourceforge.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-01-17 at 10:32 +0100, Christian Borntraeger wrote:
> Am Donnerstag, 17. Januar 2008 schrieb Rusty Russell:
> > Since the balloon requires Guest cooperation anyway, there seems
> > little reason to force it to tell the Host when it wants to reuse a
> > page.  It can simply fault it in.
> Yes, thats what we do in the s390 cmm driver.
> 
> All in all the driver has similarities with cmm. I dont know, if we can 
> consolidate some code.
> Besides the hypervisor, we have a additional user interface: /proc/sys/vm/. 
> The root user can specify the amount of pages in the balloon 
> via /proc/sys/vm/cmm_pages. 
> 
> Another idea: Martin added an oom notifier to the cmm driver. Before the 
> oom-killer kicks in cmm will try to free 256 pages. I think your virtio 
> balloon driver should do the same - it seems to be the correct tradeoff. 

Nod, you definitly want to add an oom notifier. If 256 pages is the
correct number of pages to free is debatable. We have seen long delays
for a process that quickly eats up memory if there are lots of pages in
the balloon. The problem is that the memory management tries hard to
find memory until it decides to oom kill a process, only to be stopped
in the last second by the oom notifier. The 1MB is quickly eaten up
again so the whole things starts again. The profile of such a scenario
shows that almost all cpu is burned in the page reclaim code.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
