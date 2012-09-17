From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v10 0/5] make balloon pages movable by compaction
Date: Mon, 17 Sep 2012 18:45:32 -0400
Message-ID: <5057A80C.3050800__46704.1158270606$1347921967$gmane$org@redhat.com>
References: <cover.1347897793.git.aquini@redhat.com>
	<20120917151531.e9ac59f2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120917151531.e9ac59f2.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 09/17/2012 06:15 PM, Andrew Morton wrote:
> On Mon, 17 Sep 2012 13:38:15 -0300
> Rafael Aquini <aquini@redhat.com> wrote:
>
>> Memory fragmentation introduced by ballooning might reduce significantly
>> the number of 2MB contiguous memory blocks that can be used within a guest,
>> thus imposing performance penalties associated with the reduced number of
>> transparent huge pages that could be used by the guest workload.
>>
>> This patch-set follows the main idea discussed at 2012 LSFMMS session:
>> "Ballooning for transparent huge pages" -- http://lwn.net/Articles/490114/
>> to introduce the required changes to the virtio_balloon driver, as well as
>> the changes to the core compaction & migration bits, in order to make those
>> subsystems aware of ballooned pages and allow memory balloon pages become
>> movable within a guest, thus avoiding the aforementioned fragmentation issue
>>
>> Following are numbers that prove this patch benefits on allowing compaction
>> to be more effective at memory ballooned guests.
>>
>> Results for STRESS-HIGHALLOC benchmark, from Mel Gorman's mmtests suite,
>> running on a 4gB RAM KVM guest which was ballooning 1gB RAM in 256mB chunks,
>> at every minute (inflating/deflating), while test was running:
>
> How can a patchset reach v10 and have zero Reviewed-by's?

Because people kept finding issues and nitpicks in patch 1/5,
which kept people from putting their Reviewed-by's on the other
patches :)

> (The question of "overall desirability" is the big one here.  Do we
> actually want to add this to Linux?  The rest is details which we can
> work out).

I believe we absolutely want this, to increase the likelyhood
of being able to use THP in KVM guests, which is exactly
where THP gives the largest performance benefit.

-- 
All rights reversed
