From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 13 Aug 2009 08:55:50 +0300
Message-ID: <20090813055550.GA3029__20034.6442558386$1250143086$gmane$org@redhat.com>
References: <cover.1249930169.git.mst@redhat.com>
	<20090810185340.GC13924@redhat.com>
	<200908121903.22325.arnd@arndb.de>
	<20090812171921.GC24151@ovro.caltech.edu>
	<20090812173104.GB29966@redhat.com>
	<20090812174821.GD24151@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090812174821.GD24151@ovro.caltech.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 12, 2009 at 10:48:21AM -0700, Ira W. Snyder wrote:
> On Wed, Aug 12, 2009 at 08:31:04PM +0300, Michael S. Tsirkin wrote:
> > On Wed, Aug 12, 2009 at 10:19:22AM -0700, Ira W. Snyder wrote:
> 
> [ snip out code ]
> 
> > > > 
> > > > We discussed this before, and I still think this could be directly derived
> > > > from struct virtqueue, in the same way that vring_virtqueue is derived from
> > > > struct virtqueue. That would make it possible for simple device drivers
> > > > to use the same driver in both host and guest, similar to how Ira Snyder
> > > > used virtqueues to make virtio_net run between two hosts running the
> > > > same code [1].
> > > > 
> > > > Ideally, I guess you should be able to even make virtio_net work in the
> > > > host if you do that, but that could bring other complexities.
> > > 
> > > I have no comments about the vhost code itself, I haven't reviewed it.
> > > 
> > > It might be interesting to try using a virtio-net in the host kernel to
> > > communicate with the virtio-net running in the guest kernel. The lack of
> > > a management interface is the biggest problem you will face (setting MAC
> > > addresses, negotiating features, etc. doesn't work intuitively).
> > 
> > That was one of the reasons I decided to move most of code out to
> > userspace. My kernel driver only handles datapath,
> > it's much smaller than virtio net.
> > 
> > > Getting
> > > the network interfaces talking is relatively easy.
> > > 
> > > Ira
> > 
> > Tried this, but
> > - guest memory isn't pinned, so copy_to_user
> >   to access it, errors need to be handled in a sane way
> > - used/available roles are reversed
> > - kick/interrupt roles are reversed
> > 
> > So most of the code then looks like
> > 
> > 	if (host) {
> > 	} else {
> > 	}
> > 	return
> > 
> > 
> > The only common part is walking the descriptor list,
> > but that's like 10 lines of code.
> > 
> > At which point it's better to keep host/guest code separate, IMO.
> > 
> 
> Ok, that makes sense. Let me see if I understand the concept of the
> driver. Here's a picture of what makes sense to me:
> 
> guest system
> ---------------------------------
> | userspace applications        |
> ---------------------------------
> | kernel network stack          |
> ---------------------------------
> | virtio-net                    |
> ---------------------------------
> | transport (virtio-ring, etc.) |
> ---------------------------------
>                |
>                |
> ---------------------------------
> | transport (virtio-ring, etc.) |
> ---------------------------------
> | some driver (maybe vhost?)    | <-- [1]
> ---------------------------------
> | kernel network stack          |
> ---------------------------------
> host system
> 
> >From the host's network stack, packets can be forwarded out to the
> physical network, or be consumed by a normal userspace application on
> the host. Just as if this were any other network interface.
> 
> In my patch, [1] was the virtio-net driver, completely unmodified.
> 
> So, does this patch accomplish the above diagram?

Not exactly. vhost passes packets to a physical device,
through a raw socket, not into host network stack.

> If so, why the copy_to_user(), etc?

Guest memory is not pinned. Memory access needs to go through
translation process, could cause page faults, etc.

> Maybe I'm confusing this with my system, where the
> "guest" is another physical system, separated by the PCI bus.
> 
> Ira

Yes, that's different.
