From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] virtio_balloon: Bugfixes for PAGE_SIZE != 4k
Date: Sun, 15 Apr 2012 11:52:04 +0300
Message-ID: <20120415085202.GA20414@redhat.com>
References: <1334208995-29985-1-git-send-email-david@gibson.dropbear.id.au>
	<1334208995-29985-4-git-send-email-david@gibson.dropbear.id.au>
	<20120412101157.GA13172@redhat.com>
	<20120413031211.GG5829@truffala.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120413031211.GG5829@truffala.fritz.box>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, paulus@samba.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 13, 2012 at 01:12:11PM +1000, David Gibson wrote:
> On Thu, Apr 12, 2012 at 01:14:06PM +0300, Michael S. Tsirkin wrote:
> > On Thu, Apr 12, 2012 at 03:36:35PM +1000, David Gibson wrote:
> [snip]
> > Good catch!
> > 
> > Unfortunately I find the approach a bit convoluted.
> > It also looks like when host asks for 5 balloon pages
> > you interpret this as 0 where 16 is probably saner
> > on a 64K system.
> 
> Hm, true.  Although qemu at least actuall operates in units of
> megabytes on the balloon, so I doubt it matters much in practice.
> 
> > I think it's easier if we just keep doing math in
> > balloon pages. I also get confused by shift operations,
> > IMO / and * are clearer where they are applicable.
> > Something like the below would make more sense I think.
> 
> Sure.  I thught working in local pages was clearer, but I don't really
> care.
> 
> 
> > I also wrote up a detailed commit log, so we have
> > the bugs and the expected consequences listed explicitly.
> > 
> > I'm out of time for this week - so completely untested, sorry.
> > Maybe you could try this out? That would be great.
> > Thanks!
> 
> Your patch has numerous syntax errors, but once those are fixed seems
> to work fine with a 64k ppc64 kernel.  Fixed version below.  I did add
> one comment, to note that with this change the num_pages field in the
> vb is no longer the same as the number of elements in the pages list.
> Nothing in the code relies on that, but it would probably be the first
> assumption of someone looking at the structure definition.

Good point. Although this really applies to all other
memory counters as well, so I put this at top of the file.

> Please apply.

Patch applied, thanks very much for the testing!
