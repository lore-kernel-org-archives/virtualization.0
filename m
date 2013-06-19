From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Wed, 19 Jun 2013 10:28:50 +0200
Message-ID: <51C16BC2.2060302@redhat.com>
References: <20130314111020.GA18050@redhat.com> <5141E990.7070609@redhat.com>
	<20130314173918.GB29411@redhat.com>
	<87k3lyzknl.fsf@rustcorp.com.au>
	<20130613080259.GA11175@redhat.com>
	<20130613081047.GA11269@redhat.com>
	<20130617063746.GA5693@redhat.com> <87r4fyn1wx.fsf@rustcorp.com.au>
	<20130619082417.GA2558@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130619082417.GA2558@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 19/06/2013 10:24, Michael S. Tsirkin ha scritto:
>> > 2) We introduce VIRTIO_NET_F_ANY_LAYOUT and VIRTIO_BLK_F_ANY_LAYOUT
>> >    specifically for net and block (note the new names).

So why not a transport feature?  Is it just because the SCSI commands
for virtio-blk also require a config space field?  Sorry if I missed
this upthread.

Paolo

>> > 3) I note the special case of stupid descriptors.
>> > 4) Enjoy our humble pie, don't hide it in a footnote!
>> > 
>> > If that seems OK, I'll modify the net and block specs appropriately.
>> > 
>> > Cheers,
>> > Rusty.
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> an additional suggestion: limit max s/g
> to vq size (it's in theory possible to go higher with indirect
> descriptors, but we need some limit, and queue size gives us
> a nice way to say "this is a max descriptor size").
