From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] virtio-vsock live migration
Date: Tue, 15 Mar 2016 18:12:55 +0200
Message-ID: <20160315180916-mutt-send-email-mst__49775.7874815308$1458058398$gmane$org@redhat.com>
References: <20160303153737.GA19780@stefanha-x1.localdomain>
	<20160314130150-mutt-send-email-mst@redhat.com>
	<20160315151529.GB26263@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160315151529.GB26263@stefanha-x1.localdomain>
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

On Tue, Mar 15, 2016 at 03:15:29PM +0000, Stefan Hajnoczi wrote:
> On Mon, Mar 14, 2016 at 01:13:24PM +0200, Michael S. Tsirkin wrote:
> > On Thu, Mar 03, 2016 at 03:37:37PM +0000, Stefan Hajnoczi wrote:
> > > Michael pointed out that the virtio-vsock draft specification does not
> > > address live migration and in fact currently precludes migration.
> > > 
> > > Migration is fundamental so the device specification at least mustn't
> > > preclude it.  Having brainstormed migration with Matthew Benjamin and
> > > Michael Tsirkin, I am now summarizing the approach that I want to
> > > include in the next draft specification.
> > > 
> > > Feedback and comments welcome!  In the meantime I will implement this in
> > > code and update the draft specification.
> > 
> > Most of the issue seems to be a consequence of using a 4 byte CID.
> > 
> > I think the right thing to do is just to teach guests
> > about 64 bit CIDs.
> > 
> > For now, can we drop guest CID from guest to host communication completely,
> > making CID only host-visible? Maybe leave the space
> > in the packet so we can add CID there later.
> > It seems that in theory this will allow changing CID
> > during migration, transparently to the guest.
> > 
> > Guest visible CID is required for guest to guest communication -
> > but IIUC that is not currently supported.
> > Maybe that can be made conditional on 64 bit addressing.
> > Alternatively, it seems much easier to accept that these channels get broken
> > across migration.
> 
> I reached the conclusion that channels break across migration because:
> 
> 1. 32-bit CIDs are in sockaddr_vm and we'd break AF_VSOCK ABI by
>    changing it to 64-bit.  Application code would be specific
>    virtio-vsock and wouldn't work with other AF_VSOCK transports that
>    use the 32-bit sockaddr_vm struct.

You don't have to repeat the IPv6 mistake.  Make all 32 bit CIDs
64 bit CIDs by padding with 0s, then 64 bit apps can use
any CID.

Old 32 bit CID applications will not be able to use the extended
addresses, but hardcoding bugs
does not seem sane.


> 2. Dropping guest CIDs from the protocol breaks network protocols that
>    send addresses.

Stick it in config space if you really have to.
But why do you need it on each packet?

>  NFS and netperf are the first two protocols I looked
>    at and both transmit address information across the connection...


Does netperf really attempt to get local IP
and then send that inline within the connection?


-- 
MST
