From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: find_vqs operation starting at arbitrary index
Date: Mon, 1 Jun 2009 12:12:50 +0300
Message-ID: <20090601091250.GC5061@redhat.com>
References: <20090601080348.GA17119@amit-x200.pnq.redhat.com>
	<20090601081106.GA5061@redhat.com>
	<20090601083510.GB17119@amit-x200.pnq.redhat.com>
	<20090601084327.GB5061@redhat.com>
	<20090601085128.GA19999@amit-x200.pnq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090601085128.GA19999@amit-x200.pnq.redhat.com>
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

On Mon, Jun 01, 2009 at 02:21:28PM +0530, Amit Shah wrote:
> On (Mon) Jun 01 2009 [11:43:27], Michael S. Tsirkin wrote:
> > On Mon, Jun 01, 2009 at 02:05:10PM +0530, Amit Shah wrote:
> > > On (Mon) Jun 01 2009 [11:11:06], Michael S. Tsirkin wrote:
> > > > On Mon, Jun 01, 2009 at 01:33:48PM +0530, Amit Shah wrote:
> > > > > Hello,
> > > > > 
> > > > > The recent find_vqs operation doesn't allow for a vq to be found at an
> > > > > arbitrary location; it's meant to be called once at startup to find all
> > > > > possible queues and never called again.
> > > > > 
> > > > > This doesn't work for devices which can have queues hot-plugged at
> > > > > run-time. This can be made to work by passing the 'start_index' value as
> > > > > was done earlier for find_vq, but I doubt something like the following
> > > > > will work. The MSI vectors might need some changing as well.
> > > > 
> > > > How, specifically?
> > > 
> > > I'm not sure; I was wanting to know if they will.
> > 
> > Yes, probably.
> > 
> > > I suspect this piece
> > > of code though:
> > > 
> > > in vp_find_vqs, just before calling vp_find_vq:
> > > 
> > > 	/* How many vectors would we like? */
> > > 	for (i = 0; i < nvqs; ++i)
> > > 		if (callbacks[i])
> > > 			++vectors;
> > > 
> > > 	err = vp_request_vectors(vdev, vectors);
> > > 	if (err)
> > > 		goto error_request;
> > > 
> > > Will any adjusting be needed for the 'vectors' argument (since it's
> > > considered to be the max value one can specify)?
> > > 
> > > 		Amit
> > 
> > Right. And it can only be called once. And something'll have to be done
> > on cleanup as well.
> 
> Yes; that's the assumption find_vqs currently makes.

The reason really is with pci_enable_msix which is the underlying
limitation here.

> I'll take a stab at reworking this code.
> 
> 		Amit
