From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v9 0/5] make balloon pages movable by compaction
Date: Sun, 26 Aug 2012 10:40:37 -0400
Message-ID: <503A3565.2060004__29123.1265211993$1345992079$gmane$org@redhat.com>
References: <cover.1345869378.git.aquini@redhat.com>
	<20120826075840.GE19551@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120826075840.GE19551@redhat.com>
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
Cc: Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/26/2012 03:58 AM, Michael S. Tsirkin wrote:
> On Sat, Aug 25, 2012 at 02:24:55AM -0300, Rafael Aquini wrote:
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
>
> Meta-question: are there any numbers showing gain from this patchset?
>
> The reason I ask, on migration we notify host about each page
> individually.  If this is rare maybe the patchset does not help much.
> If this is common we would be better off building up a list of multiple
> pages and passing them in one go.

The gain is in getting a better THP allocation rate inside the
guest, allowing applications to run faster.

The rarer it is for this code to run, the better - it means we
are getting the benefits without the overhead :)

-- 
All rights reversed
