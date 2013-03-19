From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Tue, 19 Mar 2013 09:58:21 +0200
Message-ID: <20130319075821.GA11259@redhat.com>
References: <20130314111020.GA18050@redhat.com>
	<20130318214702.GA21045@redhat.com>
	<87ip4oqj4w.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ip4oqj4w.fsf@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 19, 2013 at 11:51:35AM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Thu, Mar 14, 2013 at 01:10:20PM +0200, Michael S. Tsirkin wrote:
> >> Add field for guest to specify command size for virtio-blk.
> >> 
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > There's one concern here: are we going to add a
> > feature flag for flexible layout? If yes this feature
> > could thinkably just reuse it.
> >
> > It allows a nice optimization in virtio net that is very easy
> > with latest qemu.
> >
> > Rusty, what is our plan wrt this?  Are you fine with a per-device
> > feature bit?  Or do we need a transport feature bit (there's the small
> > issue that we almost run out of them for virtio-pci, do we use the last
> > one?).
> 
> I'd really like to tie it to the virtio PCI config work, but I need
> cycles to complete that....
> 
> > As an aside, the new virtio pci config proposal seems to be stuck too,
> > are you looking into it or want me to?
> 
> That would be good.  If I re-spin the kernel side, will you be able to
> look at the QEMU parts?
> 
> I can weave this in between my vhost/vringh work and other commitments,
> I hope.
> 
> Thanks,
> Rusty.

Let's start with the spec, OK?

I think there's one other issue I'd like to solve and that's
the need for IO BAR for kvm.  PCI folks are really trying to
move away from IO BARs. Pls take a look at the mail titled
	virtio PCI on KVM without IO BARs
the agreement on that thread was that virtio pci
devices will have a new capability which gives
the address/data pair to use for notifications.
For maximum flexibility, we can make it look kind of
like the MSIX table, and put it in the memory BAR,
with address/data pairs for each vq.

ISR is legacy so maybe it's okay to have it in the
memory BAR.

Making sense? Should I send a more formal proposal?

-- 
MST
