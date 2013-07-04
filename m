From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Thu, 4 Jul 2013 10:38:12 +0300
Message-ID: <20130704073812.GD2095@redhat.com>
References: <87k3lyzknl.fsf@rustcorp.com.au>
	<20130613080259.GA11175@redhat.com>
	<20130613081047.GA11269@redhat.com>
	<20130617063746.GA5693@redhat.com> <87r4fyn1wx.fsf@rustcorp.com.au>
	<20130619082417.GA2558@redhat.com> <51C16BC2.2060302@redhat.com>
	<8761x9mrmk.fsf@rustcorp.com.au> <51C2CABD.70000@redhat.com>
	<87ppv3tb3y.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ppv3tb3y.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 01, 2013 at 09:17:13AM +0930, Rusty Russell wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > Il 20/06/2013 04:40, Rusty Russell ha scritto:
> >> Paolo Bonzini <pbonzini@redhat.com> writes:
> >>> Il 19/06/2013 10:24, Michael S. Tsirkin ha scritto:
> >>>>>> 2) We introduce VIRTIO_NET_F_ANY_LAYOUT and VIRTIO_BLK_F_ANY_LAYOUT
> >>>>>>    specifically for net and block (note the new names).
> >>>
> >>> So why not a transport feature?  Is it just because the SCSI commands
> >>> for virtio-blk also require a config space field?  Sorry if I missed
> >>> this upthread.
> >> 
> >> Mainly because I'm not sure that *all* devices are now safe.  Are they?
> >
> > virtio-scsi's implementation in QEMU is not safe (been delaying that for
> > too long, sorry), but the spec is safe.
> 
> Then if we added a transport feature, we couldn't use it :(
> 
> So I think it needs to be a per-device feature bit.
> 
> Cheers,
> Rusty.

Yea.
Could you push the updated spec so I can send the updated patch?
Would be nice to have the virtio-net optimization in 3.11.
