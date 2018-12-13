From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 3/3] vhost: access vq metadata through kernel
	virtual address
Date: Thu, 13 Dec 2018 16:58:04 -0500
Message-ID: <20181213165731-mutt-send-email-mst__6558.53258581391$1544738189$gmane$org@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
	<20181213101022.12475-4-jasowang@redhat.com>
	<20181213102713-mutt-send-email-mst@kernel.org>
	<20181213211840.GC18692@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181213211840.GC18692@char.us.oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 13, 2018 at 04:18:40PM -0500, Konrad Rzeszutek Wilk wrote:
> .giant snip..
> > > +	npinned = get_user_pages_fast(uaddr, npages, write, pages);
> > > +	if (npinned != npages)
> > > +		goto err;
> > > +
> > 
> > As I said I have doubts about the whole approach, but this
> > implementation in particular isn't a good idea
> > as it keeps the page around forever.
> > So no THP, no NUMA rebalancing, userspace-controlled
> > amount of memory locked up and not accounted for.
> > 
> > Don't get me wrong it's a great patch in an ideal world.
> > But then in an ideal world no barriers smap etc are necessary at all.
> 
> So .. suggestions on how this could be accepted? As in other ways
> where we still get vmap and the issues you mentioned are not troubling you?
> 
> Thanks!

I'd suggest leave vmap alone and find ways to speed up accesses
that can fault.

-- 
MST
