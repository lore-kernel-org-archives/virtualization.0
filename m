From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: find_vqs operation starting at arbitrary index
Date: Tue, 2 Jun 2009 20:23:25 +0300
Message-ID: <20090602172325.GG6827@redhat.com>
References: <20090601080348.GA17119@amit-x200.pnq.redhat.com>
	<200906020853.07559.rusty@rustcorp.com.au>
	<20090602163227.GC6827@redhat.com>
	<20090602170916.GA9564@amit-x200.pnq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090602170916.GA9564@amit-x200.pnq.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 02, 2009 at 10:39:16PM +0530, Amit Shah wrote:
> On (Tue) Jun 02 2009 [19:32:27], Michael S. Tsirkin wrote:
> > On Tue, Jun 02, 2009 at 08:53:07AM +0930, Rusty Russell wrote:
> > > On Mon, 1 Jun 2009 05:33:48 pm Amit Shah wrote:
> > > > Hello,
> > > >
> > > > The recent find_vqs operation doesn't allow for a vq to be found at an
> > > > arbitrary location; it's meant to be called once at startup to find all
> > > > possible queues and never called again.
> > > >
> > > > This doesn't work for devices which can have queues hot-plugged at
> > > > run-time. This can be made to work by passing the 'start_index' value as
> > > > was done earlier for find_vq, but I doubt something like the following
> > > > will work. The MSI vectors might need some changing as well.
> > > 
> > > There's a fundamental conflict here: find_vqs was added so the PCI MSI code 
> > > knows exactly how many virtqueues there are.
> > > 
> > > So you'll need to sort this out with Michael...
> > > 
> > > Thanks,
> > > Rusty.
> > 
> > I'd like to understand the expected usage some more.  If there's still a
> > small # of hotpluggable queues known in advance, you can request all
> > vectors but have the queues disabled, and then enable as queues arrive.
> > In that case, something like resize_queue or enable_queue might be a
> > good idea.
> 
> Yes, it sounds like a good idea and I was debating this exact question
> -- how many queues should I expect. I currently don't expect more than
> 20 but even that sounds like a largish number.
> 
> > OTOH, if you want to have a potentially unlimited number of queues,
> > you will have to allocate a common vector for all of them
> > as on intel we are limited to 256 total vectors for all devices
> > taken together.  Not sure what a good API for that would be.
> 
> A common vector for all the queues in the device, right? And will that
> also mean each queue gets woken up on any activity on any one of them?
> 
> 		Amit

Yes. This is what find_vqs currently does if it can't allocate a queue
per VQ (actually, per queue with callback: your queues do have
callbacks?).

Of course we can start contemplating more complicated options
for mapping queues to vectors, and the guest/host ABI
supports this.

-- 
MST
