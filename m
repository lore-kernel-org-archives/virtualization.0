From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v7 2/4] virtio_balloon: introduce migration primitives
	to balloon pages
Date: Wed, 15 Aug 2012 11:30:34 -0400
Message-ID: <502BC09A.5050104@redhat.com>
References: <20120813084123.GF14081@redhat.com>
	<20120814182244.GB13338@t510.redhat.com>
	<20120814195139.GA28870@redhat.com>
	<20120814195916.GC28870@redhat.com>
	<20120814200830.GD22133@t510.redhat.com>
	<20120814202401.GB28990@redhat.com>
	<20120814202949.GF22133@t510.redhat.com>
	<20120814204906.GD28990@redhat.com>
	<20120814205426.GA29162@redhat.com> <502ABB9B.90108@redhat.com>
	<20120814213832.GA29180@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120814213832.GA29180@redhat.com>
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
Cc: Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 08/14/2012 05:38 PM, Michael S. Tsirkin wrote:

> And even ignoring that, global pointer to a device
> is an ugly hack and ugly hacks tend to explode.
>
> And even ignoring estetics, and if we decide we are fine
> with a single balloon, it needs to fail gracefully not
> crash like it does now.

Fair enough.  That certainly seems easy enough to fix.

Each balloon driver can have its own struct address_space,
and simply point mapping->host (or any of the others) at
a global balloon thing somewhere.

if (page->mapping && page->mapping->host == balloon_magic)
