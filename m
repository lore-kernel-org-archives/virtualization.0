From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v4 1/3] mm: introduce compaction and migration for virtio
	ballooned pages
Date: Wed, 01 Aug 2012 16:51:25 -0400
Message-ID: <501996CD.70007__30627.1523506895$1343854424$gmane$org@redhat.com>
References: <cover.1342485774.git.aquini@redhat.com>
	<49f828a9331c9b729fcf77226006921ec5bc52fa.1342485774.git.aquini@redhat.com>
	<20120718054824.GA32341@bbox>
	<20120720194858.GA16249@t510.redhat.com>
	<20120723023332.GA6832@bbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120723023332.GA6832@bbox>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minchan Kim <minchan@kernel.org>
Cc: Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, Rafael Aquini <aquini@linux.com>
List-Id: virtualization@lists.linuxfoundation.org

On 07/22/2012 10:33 PM, Minchan Kim wrote:

> IMHO, better approach is that after we can get complete free pageblocks
> by compaction or reclaim, move balloon pages into that pageblocks and make
> that blocks to unmovable. It can prevent fragmentation and it makes
> current or future code don't need to consider balloon page.

I believe this is the wrong thing to do.

In a KVM guest, getting applications in transparent
huge pages can be a 10-25% performance benefit.

Therefore, we need to make all the 2MB pageblocks
we can available for use by userland.

Using 2MB blocks for the balloon (which is never
touched) is extremely wasteful and could result in
a large performance penalty, if we cannot defragment
the remaining memory enough to give 2MB pages to
applications.

The 2MB blocks are prime real estate. They should
remain available for applications.
