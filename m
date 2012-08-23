From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v8 1/5] mm: introduce a common interface for balloon pages
	mobility
Date: Thu, 23 Aug 2012 13:59:14 -0400
Message-ID: <50366F72.3040700__42152.1324119114$1345747841$gmane$org@redhat.com>
References: <20120822000741.GI9027@redhat.com>
	<20120822011930.GA23753@t510.redhat.com>
	<20120822093317.GC10680@redhat.com>
	<20120823021903.GA23660@x61.redhat.com>
	<20120823100107.GA17409@redhat.com>
	<20120823121338.GA3062@t510.redhat.com>
	<20120823123432.GA25659@redhat.com>
	<20120823130606.GB3746@t510.redhat.com>
	<20120823135328.GB25709@redhat.com>
	<20120823162504.GA1522@redhat.com>
	<20120823172844.GC10777@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120823172844.GC10777@t510.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rafael Aquini <aquini@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 08/23/2012 01:28 PM, Rafael Aquini wrote:

> What about keep a conter at virtio_balloon structure on how much pages are
> isolated from balloon's list and check it at leak time?
> if the counter gets > 0 than we can safely put leak_balloon() to wait until
> balloon page list gets completely refilled.

We only have to wait if we failed to leak enough
pages, and then only for as many additional pages
as we require.
