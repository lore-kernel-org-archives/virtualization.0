From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFCv3 0/5] enable migration of driver pages
Date: Tue, 7 Jul 2015 17:07:46 -0700
Message-ID: <20150707170746.1b91ba0d07382cbc9ba3db92__42573.0728464716$1436314089$gmane$org@linux-foundation.org>
References: <1436243785-24105-1-git-send-email-gioh.kim@lge.com>
	<20150707153701.bfcde75108d1fb8aaedc8134@linux-foundation.org>
	<559C68B3.3010105@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <559C68B3.3010105@lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gioh Kim <gioh.kim@lge.com>
Cc: aquini@redhat.com, mst@redhat.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, minchan@kernel.org, Gioh Kim <gurugio@hanmail.net>, linux-mm@kvack.org, viro@zeniv.linux.org.uk, gunho.lee@lge.com, linux-fsdevel@vger.kernel.org, jlayton@poochiereds.net, koct9i@gmail.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 08 Jul 2015 09:02:59 +0900 Gioh Kim <gioh.kim@lge.com> wrote:

> 
> 
> 2015-07-08 ______ 7:37___ Andrew Morton ___(___) ___ ___:
> > On Tue,  7 Jul 2015 13:36:20 +0900 Gioh Kim <gioh.kim@lge.com> wrote:
> >
> >> From: Gioh Kim <gurugio@hanmail.net>
> >>
> >> Hello,
> >>
> >> This series try to enable migration of non-LRU pages, such as driver's page.
> >>
> >> My ARM-based platform occured severe fragmentation problem after long-term
> >> (several days) test. Sometimes even order-3 page allocation failed. It has
> >> memory size 512MB ~ 1024MB. 30% ~ 40% memory is consumed for graphic processing
> >> and 20~30 memory is reserved for zram.
> >>
> >> I found that many pages of GPU driver and zram are non-movable pages. So I
> >> reported Minchan Kim, the maintainer of zram, and he made the internal
> >> compaction logic of zram. And I made the internal compaction of GPU driver.
> >>
> >> They reduced some fragmentation but they are not enough effective.
> >> They are activated by its own interface, /sys, so they are not cooperative
> >> with kernel compaction. If there is too much fragmentation and kernel starts
> >> to compaction, zram and GPU driver cannot work with the kernel compaction.
> >>
> >> ...
> >>
> >> This patch set is tested:
> >> - turn on Ubuntu 14.04 with 1G memory on qemu.
> >> - do kernel building
> >> - after several seconds check more than 512MB is used with free command
> >> - command "balloon 512" in qemu monitor
> >> - check hundreds MB of pages are migrated
> >
> > OK, but what happens if the balloon driver is not used to force
> > compaction?  Does your test machine successfully compact pages on
> > demand, so those order-3 allocations now succeed?
> 
> If any driver that has many pages like the balloon driver is forced to compact,
> the system can get free high-order pages.
> 
> I have to show how this patch work with a driver existing in the kernel source,
> for kernel developers' undestanding. So I selected the balloon driver
> because it has already compaction and working with kernel compaction.
> I can show how driver pages is compacted with lru-pages together.
> 
> Actually balloon driver is not best example to show how this patch compacts pages.
> The balloon driver compaction is decreasing page consumtion, for instance 1024MB -> 512MB.
> I think it is not compaction precisely. It frees pages.
> Of course there will be many high-order pages after 512MB is freed.

Can the various in-kernel GPU drivers benefit from this?  If so, wiring
up one or more of those would be helpful?
