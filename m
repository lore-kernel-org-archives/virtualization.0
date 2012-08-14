From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 2/4] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Wed, 15 Aug 2012 00:38:32 +0300
Message-ID: <20120814213832.GA29180__43112.3648923405$1344980269$gmane$org@redhat.com>
References: <20120813084123.GF14081@redhat.com>
	<20120814182244.GB13338@t510.redhat.com>
	<20120814195139.GA28870@redhat.com>
	<20120814195916.GC28870@redhat.com>
	<20120814200830.GD22133@t510.redhat.com>
	<20120814202401.GB28990@redhat.com>
	<20120814202949.GF22133@t510.redhat.com>
	<20120814204906.GD28990@redhat.com>
	<20120814205426.GA29162@redhat.com> <502ABB9B.90108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <502ABB9B.90108@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: Rafael Aquini <aquini@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 14, 2012 at 04:56:59PM -0400, Rik van Riel wrote:
> On 08/14/2012 04:54 PM, Michael S. Tsirkin wrote:
> 
> >To clarify, the global state that this patch adds, is ugly
> >even if we didn't support multiple balloons yet.
> >So I don't think I can accept such a patch.
> >Rusty has a final word here, maybe he thinks differently.
> 
> Before deciding that "does not support multiple balloon drivers
> at once" is an issue, is there any use case at all for having
> multiple balloon drivers active at a time?
> 
> I do not see any.

For example, we had a proposal for a page-cache backed
device. So it could be useful to have two, a regular balloon
and a pagecache backed one.
There could be other uses - it certainly looks like it
works so how can you be sure it's useless?

And even ignoring that, global pointer to a device
is an ugly hack and ugly hacks tend to explode.

And even ignoring estetics, and if we decide we are fine
with a single balloon, it needs to fail gracefully not
crash like it does now.

> -- 
> All rights reversed
