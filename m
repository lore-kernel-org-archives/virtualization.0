From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] virtio-vsock live migration
Date: Wed, 6 Apr 2016 16:17:06 +0300
Message-ID: <20160406160233-mutt-send-email-mst__47935.2075876251$1459948650$gmane$org@redhat.com>
References: <20160303153737.GA19780@stefanha-x1.localdomain>
	<20160314130150-mutt-send-email-mst@redhat.com>
	<20160315151529.GB26263@stefanha-x1.localdomain>
	<20160315180916-mutt-send-email-mst@redhat.com>
	<20160316143200.GA689@stefanha-x1.localdomain>
	<20160316163344-mutt-send-email-mst@redhat.com>
	<20160406125550.GB17538@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160406125550.GB17538@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Matt Benjamin <mbenjamin@redhat.com>, virtualization@lists.linux-foundation.org, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 06, 2016 at 01:55:50PM +0100, Stefan Hajnoczi wrote:
> On Wed, Mar 16, 2016 at 05:05:19PM +0200, Michael S. Tsirkin wrote:
> > > > >  NFS and netperf are the first two protocols I looked
> > > > >    at and both transmit address information across the connection...
> > > > 
> > > > 
> > > > Does netperf really attempt to get local IP
> > > > and then send that inline within the connection?
> > > 
> > > Yes, netperf has separate control and data sockets.  I think part of the
> > > reason for this split is that the control connection can communicate the
> > > address details for the data connection over a different protocol (TCP +
> > > RDMA?), but I'm not sure.
> > > 
> > > Stefan
> > 
> > Thinking about it, netperf does not survive disconnects.
> > So the current protocol would be useless for it.
> > I am not sure about NFS but from (long past) experience it did not
> > attempt to re-resolve the name to address, so changing an
> > address would break it as well.
> > 
> > So I think these applications would have to use a 64 bit CID.
> > 
> > Why, then, do we care about one aspect of these applications
> > (creating connections) and not another (not breaking them)?
> 
> I care about mapping the semantics of AF_VSOCK to virtio-vsock.
> AF_VSOCK was implemented with the ability to plug in additional
> transports (like virtio).  This allows guest agents and other
> applications to compile once and run on any transport.
> 
> If we change virtio-vsock to rely on unique addresses across migration
> then we lose zero-configuration.

Could be an option. management has very little trouble configuring
unique CIDs and it does care about migration. Desktop users don't
migrate and they want zero configuration.

> AF_VSOCK applications use the
> VMADDR_CID_HOST (2) constant to communicate with the host.  After live
> migration this well-known CID refers to the new host.  Applications
> would need to know a unique host CID in order to work correctly across
> live migration.
> 
> Although I appreciate your drive to make the device as flexible as
> possible, if we want to do this we are totally beyond AF_VSOCK semantics
> and would be better served by a separate effort that avoids confusion
> between class AF_VSOCK semantics and virtio socket semantics.

Maybe, though I merely proposed reserving some space so we can extend
CIDs to 64 bit (or 128 bit like hyperv guys would like to?)
in the future without too much pain.
To me this doesn't look like worth starting a completely separate effort for.

> Can we please treat AF_VSOCK semantics as the requirements we're trying
> to implement?  It supports qemu-guest-agent and as I described in a
> previous mail could also support transparent connection migration a la
> CRIU sockets.
> 
> Stefan

I only wish the semantics were better documented somewhere :)

-- 
MST
