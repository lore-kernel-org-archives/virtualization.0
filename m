From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 2/4] virtio_balloon: introduce migration primitives to
	balloon pages
Date: Wed, 15 Aug 2012 01:48:16 +0300
Message-ID: <20120814224816.GB29180__24842.7875027575$1344984454$gmane$org@redhat.com>
References: <f19b63dfa026fe2f8f11ec017771161775744781.1344619987.git.aquini@redhat.com>
	<20120813084123.GF14081@redhat.com>
	<20120814182244.GB13338@t510.redhat.com>
	<20120814195139.GA28870@redhat.com>
	<20120814195916.GC28870@redhat.com>
	<20120814200830.GD22133@t510.redhat.com>
	<20120814202401.GB28990@redhat.com>
	<20120814202949.GF22133@t510.redhat.com>
	<20120814204906.GD28990@redhat.com>
	<20120814213412.GG22133@t510.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120814213412.GG22133@t510.redhat.com>
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
Cc: Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Andi Kleen <andi@firstfloor.org>, Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 14, 2012 at 06:34:13PM -0300, Rafael Aquini wrote:
> On Tue, Aug 14, 2012 at 11:49:06PM +0300, Michael S. Tsirkin wrote:
> > On Tue, Aug 14, 2012 at 05:29:50PM -0300, Rafael Aquini wrote:
> > > On Tue, Aug 14, 2012 at 11:24:01PM +0300, Michael S. Tsirkin wrote:
> > > > On Tue, Aug 14, 2012 at 05:08:31PM -0300, Rafael Aquini wrote:
> > > > > On Tue, Aug 14, 2012 at 10:59:16PM +0300, Michael S. Tsirkin wrote:
> > > > > > > > > What if there is more than one balloon device?
> > > > > > > > 
> > > > > > > > Is it possible to load this driver twice, or are you foreseeing a future case
> > > > > > > > where this driver will be able to manage several distinct memory balloons for
> > > > > > > > the same guest?
> > > > > > > > 
> > > > > > > 
> > > > > > > Second.
> > > > > > > It is easy to create several balloons they are just
> > > > > > > pci devices.
> > > > > >  
> > > > > > 
> > > > > > 
> > > > > > and it might not be too important to make it work but
> > > > > > at least would be nice not to have a crash in this
> > > > > > setup.
> > > > > >
> > > > > Fair enough. For now, as I believe it's safe to assume we are only inflating one
> > > > > balloon per guest, I'd like to propose this as a future enhancement. Sounds
> > > > > good?
> > > > >  
> > > > 
> > > > Since guest crashes when it's not the case, no it doesn't, sorry :(.
> > > >
> > > Ok, but right now this driver only takes care of 1 balloon per guest,
> > 
> > It does? Are you sure? There is no global state as far as I can see. So
> > I can create 2 devices and driver will happily create two instances,
> > each one can be inflated/deflated independently.
> > 
> > > so how
> > > could this approach crash it? 
> > 
> > Add device. inflate. Add another device. inflate. deflate. unplug.
> > Now you have pointer to freed memory and when mm touches
> > page from first device, you ge use after free.
> > 
> > > Your point is a good thing to be on a to-do list for future enhancements, but
> > > it's not a dealbreaker for the present balloon driver implementation, IMHO.
> > > 
> > 
> > Yes it looks like a dealbreaker to me.
> 
> Sorry. You're right, I'm wrong.
> 
> I'll get back to the scracthpad to overcome this constraint. I believe the way
> this patch was at its v4 revision (wrt this particular case) could possibly
> address this concern of yours.

Almost. We still have a global balloon_mapping. The only reason for
it to exist seems solely to detect balloon mappings, so it
can just be replaced by a flag in the mapping, or in mapping
ops, or elsewhere. Also, please add APIs to mm so we can
avoid doing internal mm stuff like

INIT_RADIX_TREE(&balloon_mapping->page_tree, GFP_ATOMIC | __GFP_NOWARN);

in the driver. It should be
alloc_address_mapping(&virtio_balloon_aops);
free_address_mapping

Make page->mapping use rcu, and sync rcu in
free_address_mapping.

-- 
MST
