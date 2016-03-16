From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: [virtio-dev] virtio-vsock live migration
Date: Wed, 16 Mar 2016 10:58:01 -0400 (EDT)
Message-ID: <1738100539.67547322.1458140281107.JavaMail.zimbra@redhat.com>
References: <20160303153737.GA19780@stefanha-x1.localdomain>
	<20160314130150-mutt-send-email-mst@redhat.com>
	<20160315151529.GB26263@stefanha-x1.localdomain>
	<20160315180916-mutt-send-email-mst@redhat.com>
	<20160316143200.GA689@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160316143200.GA689@stefanha-x1.localdomain>
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
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

----- Original Message -----
> From: "Stefan Hajnoczi" <stefanha@redhat.com>
> To: "Michael S. Tsirkin" <mst@redhat.com>

> > > > I think the right thing to do is just to teach guests
> > > > about 64 bit CIDs.
> > > > 
> > > > For now, can we drop guest CID from guest to host communication
> > > > completely,
> > > > making CID only host-visible? Maybe leave the space
> > > > in the packet so we can add CID there later.
> > > > It seems that in theory this will allow changing CID
> > > > during migration, transparently to the guest.
> > > > 
> > > > Guest visible CID is required for guest to guest communication -
> > > > but IIUC that is not currently supported.
> > > > Maybe that can be made conditional on 64 bit addressing.
> > > > Alternatively, it seems much easier to accept that these channels get
> > > > broken
> > > > across migration.
> > > 
> > > I reached the conclusion that channels break across migration because:
> > > 
> > > 1. 32-bit CIDs are in sockaddr_vm and we'd break AF_VSOCK ABI by
> > >    changing it to 64-bit.  Application code would be specific
> > >    virtio-vsock and wouldn't work with other AF_VSOCK transports that
> > >    use the 32-bit sockaddr_vm struct.
> > 
> > You don't have to repeat the IPv6 mistake.  Make all 32 bit CIDs
> > 64 bit CIDs by padding with 0s, then 64 bit apps can use
> > any CID.
> > 
> > Old 32 bit CID applications will not be able to use the extended
> > addresses, but hardcoding bugs
> > does not seem sane.
> 
> A mixed 32-bit and 64-bit CID world is complex.  The host doesn't know
> in advance whether all applications (especially inside the guest) will
> support 64-bit CIDs or not.  32-bit CID applications won't work if a
> 64-bit CID has been assigned.
> 
> It also opens up the question how unique CIDs are allocated across
> hosts.
> 
> Given that AF_VSOCK in Linux already exists in the 32-bit CID version,
> I'd prefer to make virtio-vsock compatible with that for the time being.
> Extensions can be added in the future but just implementing existing
> AF_VSOCK semantics will already allow the applications to run.
> 
> > > 2. Dropping guest CIDs from the protocol breaks network protocols that
> > >    send addresses.
> > 
> > Stick it in config space if you really have to.
> > But why do you need it on each packet?
> 
> If packets are implicitly guest<->host then adding guest<->guest
> communication requires a virtio spec change.  If packets contain
> source/destination CIDs then allowing/forbidding guest<->host or
> guest<->guest communication is purely a host policy decision.  I think
> it's worth keeping that in from the start.

I'm just the downstream consumer of vsock, but this was my intuition, as well.

Matt

> 
> > >  NFS and netperf are the first two protocols I looked
> > >    at and both transmit address information across the connection...
> > 
> > 

> Stefan
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
