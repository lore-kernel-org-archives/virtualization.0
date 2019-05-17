From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v4 0/4] vmw_balloon: Compaction and shrinker support
Date: Fri, 17 May 2019 17:10:23 +0000
Message-ID: <9AD9FE33-1825-4D1A-914F-9C29DF93DC8D__33725.3161052772$1558113044$gmane$org@vmware.com>
References: <20190425115445.20815-1-namit@vmware.com>
	<8A2D1D43-759A-4B09-B781-31E9002AE3DA@vmware.com>
Reply-To: Nadav Amit <namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8A2D1D43-759A-4B09-B781-31E9002AE3DA@vmware.com>
Content-Language: en-US
Content-ID: <D489544212C01046B2B5533DCF95669B@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Pv-drivers <Pv-drivers@vmware.com>, lkml <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Linux-MM <linux-mm@kvack.org>, Julien Freche <jfreche@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

> On May 3, 2019, at 6:25 PM, Nadav Amit <namit@vmware.com> wrote:
> 
>> On Apr 25, 2019, at 4:54 AM, Nadav Amit <namit@vmware.com> wrote:
>> 
>> VMware balloon enhancements: adding support for memory compaction,
>> memory shrinker (to prevent OOM) and splitting of refused pages to
>> prevent recurring inflations.
>> 
>> Patches 1-2: Support for compaction
>> Patch 3: Support for memory shrinker - disabled by default
>> Patch 4: Split refused pages to improve performance
>> 
>> v3->v4:
>> * "get around to" comment [Michael]
>> * Put list_add under page lock [Michael]
>> 
>> v2->v3:
>> * Fixing wrong argument type (int->size_t) [Michael]
>> * Fixing a comment (it) [Michael]
>> * Reinstating the BUG_ON() when page is locked [Michael] 
>> 
>> v1->v2:
>> * Return number of pages in list enqueue/dequeue interfaces [Michael]
>> * Removed first two patches which were already merged
>> 
>> Nadav Amit (4):
>> mm/balloon_compaction: List interfaces
>> vmw_balloon: Compaction support
>> vmw_balloon: Add memory shrinker
>> vmw_balloon: Split refused pages
>> 
>> drivers/misc/Kconfig               |   1 +
>> drivers/misc/vmw_balloon.c         | 489 ++++++++++++++++++++++++++---
>> include/linux/balloon_compaction.h |   4 +
>> mm/balloon_compaction.c            | 144 ++++++---
>> 4 files changed, 553 insertions(+), 85 deletions(-)
>> 
>> -- 
>> 2.19.1
> 
> Ping.

Ping.

Greg, did it got lost again?
