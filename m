From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon pages
	mobility
Date: Thu, 23 Aug 2012 12:03:15 -0400
Message-ID: <50365443.1070104__28916.3223038942$1345737794$gmane$org@redhat.com>
References: <20120822000741.GI9027@redhat.com>
	<20120822011930.GA23753@t510.redhat.com>
	<20120822093317.GC10680@redhat.com>
	<20120823021903.GA23660@x61.redhat.com>
	<20120823100107.GA17409@redhat.com>
	<20120823121338.GA3062@t510.redhat.com>
	<20120823123432.GA25659@redhat.com>
	<20120823130606.GB3746@t510.redhat.com>
	<20120823135328.GB25709@redhat.com>
	<20120823152128.GA8975@t510.redhat.com>
	<20120823155401.GA28876@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120823155401.GA28876@redhat.com>
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
Cc: Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/23/2012 11:54 AM, Michael S. Tsirkin wrote:
> On Thu, Aug 23, 2012 at 12:21:29PM -0300, Rafael Aquini wrote:
>> On Thu, Aug 23, 2012 at 04:53:29PM +0300, Michael S. Tsirkin wrote:
>>> On Thu, Aug 23, 2012 at 10:06:07AM -0300, Rafael Aquini wrote:
>>>> On Thu, Aug 23, 2012 at 03:34:32PM +0300, Michael S. Tsirkin wrote:
>>>>>> So, nothing has changed here.
>>>>>
>>>>> Yes, your patch does change things:
>>>>> leak_balloon now might return without freeing any pages.
>>>>> In that case we will not be making any progress, and just
>>>>> spin, pinning CPU.
>>>>
>>>> That's a transitory condition, that migh happen if leak_balloon() takes place
>>>> when compaction, or migration are under their way and it might only affects the
>>>> module unload case.
>>>
>>> Regular operation seems even more broken: host might ask
>>> you to leak memory but because it is under compaction
>>> you might leak nothing. No?
>>>
>>
>> And that is exactely what it wants to do. If there is (temporarily) nothing to leak,
>> then not leaking is the only sane thing to do.
>
> It's an internal issue between balloon and mm. User does not care.
>
>> Having balloon pages being migrated
>> does not break the leak at all, despite it can last a little longer.
>>
>
> Not "longer" - apparently forever unless user resend the leak command.
> It's wrong - it should
> 1. not tell host if nothing was done
> 2. after migration finished leak and tell host

Agreed.  If the balloon is told to leak N pages, and could
not do so because those pages were locked, the balloon driver
needs to retry (maybe waiting on a page lock?) and not signal
completion until after the job has been completed.

Having the balloon driver wait on the page lock should be
fine, because compaction does not hold the page lock for
long.
