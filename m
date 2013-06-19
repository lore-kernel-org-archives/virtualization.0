From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Wed, 19 Jun 2013 14:16:06 +0930
Message-ID: <87r4fyn1wx.fsf@rustcorp.com.au>
References: <20130314111020.GA18050@redhat.com> <5141E990.7070609@redhat.com>
	<20130314173918.GB29411@redhat.com>
	<87k3lyzknl.fsf@rustcorp.com.au>
	<20130613080259.GA11175@redhat.com>
	<20130613081047.GA11269@redhat.com>
	<20130617063746.GA5693@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130617063746.GA5693@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, Jun 13, 2013 at 11:10:47AM +0300, Michael S. Tsirkin wrote:
>> On Thu, Jun 13, 2013 at 11:02:59AM +0300, Michael S. Tsirkin wrote:
>> > On Thu, Jun 13, 2013 at 02:12:22PM +0930, Rusty Russell wrote:
>> > > "Michael S. Tsirkin" <mst@redhat.com> writes:
>> > > > On Thu, Mar 14, 2013 at 04:15:28PM +0100, Paolo Bonzini wrote:
>> > > >> Il 14/03/2013 12:10, Michael S. Tsirkin ha scritto:
>> > > >> > Add field for guest to specify command size for virtio-blk.
>> > > >> > 
>> > > >> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > > >
>> > > > OK, but Rusty usually tweaks wording anyway.
>> > > > Rusty want to apply and make changes Paolo suggested yourself
>> > > > or want me to?
>> > > 
>> > > (MST drew my attention back to this)
>> > > 
>> > > Please do.  And please add a note about this feature: that without it,
>> > > the descriptor layout must be on the right boundaries for historical
>> > > reasons.
>> > 
>> > It's there already, isn't it:
>> > 
>> >  If VIRTIO_BLK_F_SCSI_CMD_SIZE is not negotiated,
>> >  This field must reside in a single, separate read-only buffer; 
>> >  the command length
>> >  can be derived from the length of this buffer.
>> > 
>> 
>> Wait, I think I got it: you actually want to rename this
>> VIRTIO_BLK_F_ANY_SG and have it affect all requests?
>
> Sorry about being dense - could you please clarify?

OK, here's the new section I've written (but not committed!) on Message
Framing:

  Message Framing
 
The original intent of the specification was that message framing 
(the particular layout of descriptors) be independent of the 
contents of the buffers. For example, a network transmit buffer 
consists of a 12 byte header followed by the network packet. This 
could be most simply placed in the descriptor table as a 12 byte 
output descriptor followed by a 1514 byte output descriptor, but 
it could also consist of a single 1526 byte output descriptor in 
the case where the header and packet are adjacent, or even three 
or more descriptors (possibly with loss of efficiency in that 
case).

Regrettably, initial driver implementations used simple layouts, 
and devices came to rely on it, despite this specification 
wording. It is thus recommended that drivers be conservative in 
their assumptions, unless specific device features indicate that 
general layout is permitted, such VIRTIO_NET_F_ANY_LAYOUT or 
VIRTIO_BLK_F_ANY_LAYOUT. In addition, some implementations may 
have large-but-reasonable restrictions on total descriptor size 
(such as based on IOV_MAX in the host OS). This has not been a 
problem in practice: little sympathy will be given to drivers 
which create unreasonably-sized descriptors such as by dividing a 
network packet into 1500 single-byte descriptors!
===

Notes:
1) The restrictions are still in place by default.
2) We introduce VIRTIO_NET_F_ANY_LAYOUT and VIRTIO_BLK_F_ANY_LAYOUT
   specifically for net and block (note the new names).
3) I note the special case of stupid descriptors.
4) Enjoy our humble pie, don't hide it in a footnote!

If that seems OK, I'll modify the net and block specs appropriately.

Cheers,
Rusty.
