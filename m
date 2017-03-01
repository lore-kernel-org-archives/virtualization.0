From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] packed ring layout proposal v2
Date: Wed, 1 Mar 2017 03:02:29 +0200
Message-ID: <20170301024951-mutt-send-email-mst__14831.01336421$1488330158$gmane$org@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<20170228050218.GI18844@yliu-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170228050218.GI18844@yliu-dev.sh.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yuanhan Liu <yuanhan.liu@linux.intel.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 28, 2017 at 01:02:18PM +0800, Yuanhan Liu wrote:
> On Wed, Feb 08, 2017 at 05:20:14AM +0200, Michael S. Tsirkin wrote:
> > This is an update from v1 version.
> > Changes:
> > - update event suppression mechanism
> > - separate options for indirect and direct s/g
> > - lots of new features
> > 
> > ---
> > 
> > Performance analysis of this is in my kvm forum 2016 presentation.
> > The idea is to have a r/w descriptor in a ring structure,
> > replacing the used and available ring, index and descriptor
> > buffer.
> > 
> > * Descriptor ring:
> > 
> > Guest adds descriptors with unique index values and DESC_HW set in flags.
> > Host overwrites used descriptors with correct len, index, and DESC_HW
> > clear.  Flags are always set/cleared last.
> 
> May I know what's the index intended for? Back referencing a pkt buffer?

Yes and generally identify which descriptor completed. Recall that
even though vhost net completes in order at the moment,
virtio rings serve devices (e.g. storage) that complete out of order.

> > #define DESC_HW 0x0080
> > 
> > struct desc {
> >         __le64 addr;
> >         __le32 len;
> >         __le16 index;
> >         __le16 flags;
> > };
> 
> ...
> > * Batching descriptors:
> > 
> > virtio 1.0 allows passing a batch of descriptors in both directions, by
> > incrementing the used/avail index by values > 1.  We can support this by
> > chaining a list of descriptors through a bit the flags field.
> > To allow use together with s/g, a different bit will be used.
> > 
> > #define VRING_DESC_F_BATCH_NEXT 0x0010
> > 
> > Batching works for both driver and device descriptors.
> 
> Honestly, I don't think it's an efficient way for batching. Neither the
> DESC_F_NEXT nor the BATCH_NEXT tells us how many new descs are there
> for processing: it's just a hint that there is one more. And you have
> to follow the link one by one.
> 
> I was thinking, maybe we could sub-divide some fields of desc, thus
> we could introduce more. For example, 32 bits "len" maybe too much,
> at least to virtio-net: the biggest pkt size is 64K, which is 16 bits.
> If we use 16 bits for len, we could use the extra 16 bits for telling
> how telling the batch number.
> 
> 	struct desc {
> 	        __le64 addr;
> 	        __le16 len;
> 	        __le16 batch;
> 	        __le16 index;
> 	        __le16 flags;
> 	};
> 
> Only the heading desc need set the batch count and DESC_HW flag. With
> the two used together, we don't have to set/clear the DESC_HW flag on
> driver/device.
> If 64K is small enough for other devices (say, BLK), we may re-allocate
> the bits to something like "24 : 8", whereas 24 for len (16M at most)
> and 8 for batch.  OTOH, 8 bit of batch should be pretty enough, judging
> that the default vring size is 256 and a typical burst size normally is
> way less than that.
> 
> That said, if it's "16: 16" and if we use only 8 bits for batch, we
> could still have another 8 bit for anything else, say the number of
> desc for a single pkt. With that, the num_buffers of mergeable Rx
> header could be replaced.  More importantly, we could reduce a cache
> line write if non offload are supported in mergeable Rx path. 

Why do you bother with mergeable Rx without offloads?  Make each buffer
MTU sized and it'll fit without merging.  Linux used not to, it only
started doing this to save memory aggressively. I don't think
DPDK cares about this.

> 
> 	struct desc {
> 	        __le64 addr;
> 	        __le16 len;
> 	        __le8  batch;
> 	        __le8  num_buffers;
> 	        __le16 index;
> 	        __le16 flags;
> 	};

Interesting. How about a benchmark for these ideas?

> 
> > * Device specific descriptor flags
> > We have a lot of unused space in the descriptor.  This can be put to
> > good use by reserving some flag bits for device use.
> > For example, network device can set a bit to request
> > that header in the descriptor is suppressed
> > (in case it's all 0s anyway). This reduces cache utilization.
> 
> Good proposal. But I think it could only work with Tx, where the driver
> knows whether the headers are all 0s while filling the desc. But for
> Rx, whereas the driver has to pre-fill the desc, it doesn't know. Thus
> it still requires filling an header desc for storing it.

I don't see why - I don't think drivers pre-fill buffers in header for RX
right now. Why would they start?

> Maybe we could introduce a global feature? When that's negotiated, no
> header desc need filled and processed? I'm thinking this could also
> help the vector implementation I mentioned in another email.

It's possible of course - it's a subset of what I said.
Though it makes it less useful in the general case.

> > Note: this feature can be supported in virtio 1.0 as well,
> > as we have unused bits in both descriptor and used ring there.
> 
> Agreed.
> 
> 	--yliu
