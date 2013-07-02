From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Tue, 02 Jul 2013 15:34:09 +0930
Message-ID: <87txkdfqg6.fsf@rustcorp.com.au>
References: <20130314111020.GA18050@redhat.com> <5141E990.7070609@redhat.com>
	<20130314173918.GB29411@redhat.com>
	<87k3lyzknl.fsf@rustcorp.com.au>
	<20130613080259.GA11175@redhat.com>
	<20130613081047.GA11269@redhat.com>
	<20130617063746.GA5693@redhat.com> <87r4fyn1wx.fsf@rustcorp.com.au>
	<20130619082417.GA2558@redhat.com>
	<51C16BC2.2060302@redhat.com> <8761x9mrmk.fsf@rustcorp.com.au>
	<51C2CABD.70000@redhat.com> <87ppv3tb3y.fsf@rustcorp.com.au>
	<51D16EB8.3050709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51D16EB8.3050709@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:
> Il 01/07/2013 01:47, Rusty Russell ha scritto:
>> > > 
>> > > Mainly because I'm not sure that *all* devices are now safe.  Are they?
>> >
>> > virtio-scsi's implementation in QEMU is not safe (been delaying that for
>> > too long, sorry), but the spec is safe.
>> 
>> Then if we added a transport feature, we couldn't use it :(
>
> Transport feature bits are still negotiated per device though.
> virtio-scsi devices in QEMU would not negotiate that feature.

That's a good point; I tend to think of them as tied to the transport
but there's nothing specifying that, nor any implementation requiring
it.

OK, so VIRTIO_F_ANY_LAYOUT it is?

Cheers,
Rusty.

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

Regrettably, initial driver implementations used simple layouts
and devices came to rely on it, despite this specification 
wording. It is thus recommended that drivers be conservative in 
their assumptions, unless specific device features indicate that 
general layout is permitted using VIRTIO_F_ANY_LAYOUT. In
addition, some implementations may have large-but-reasonable
restrictions on total descriptor size (such as based on IOV_MAX
in the host OS). This has not been a problem in practice: little
sympathy will be given to drivers which create unreasonably-sized
descriptors such as dividing a network packet into 1500
single-byte descriptors!
