From: Stefan Fritsch <sf@sfritsch.de>
Subject: Re: [PATCH RFC] virtio-pci: share config interrupt between virtio
	devices
Date: Sun, 21 Sep 2014 11:36:44 +0200
Message-ID: <1521507.s7iVWsv4g7@k>
References: <1409550114-8186-1-git-send-email-akong@redhat.com>
	<11860049.kd4R4PIiz4@k> <20140921080914.GA2489@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140921080914.GA2489@redhat.com>
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
Cc: kvm@vger.kernel.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, sasha.levin@oracle.com, penberg@iki.fi
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 21 September 2014 11:09:14, Michael S. Tsirkin wrote:
> On Thu, Sep 18, 2014 at 09:18:37PM +0200, Stefan Fritsch wrote:
> > On Monday 01 September 2014 09:37:30, Michael S. Tsirkin wrote:
> > > Why do we need INT#x?
> > > How about setting IRQF_SHARED for the config interrupt
> > > while using MSI-X? You'd have to read ISR to check that the
> > > interrupt was intended for your device.
> >
> > 
> >
> > The virtio 0.9.5 spec says that ISR is "unused" when in MSI-X
> > mode. I  don't think that you can depend on the device to set the
> > configuration changed bit.
> > The virtio 1.0 spec seems to have fixed that.
> 
> Yes, virtio 0.9.5 has this bug. But in practice qemu always set this
> bit, so for qemu we could do that unconditionally.  Pekka's lkvm
> tool doesn't unfortunately.  It's easy to fix that, but it would be
> nicer to additionally probe for old versions of the tool, and
> disable IRQF_SHARED in that case.

What about other implementations? I think Linux should try to conform 
to the spec so that all device implementations which conform to the 
spec just work.

One implementation that comes to mind is virtualbox. But from a quick 
look at the source, it seems that it sets the ISR bit always, too. And 
it uses qemu's subsystem vendor id.

But there are other implementations. For example bhyve.


> AFAIK a subsystem vendor id does not cost money to register, but
> only pci sig members can do this, and membership costs $3000.
> Maybe we should combine all this with checking subsystem vendor id,
> and only implement the optimization if it matches qemu, for now.
> This needs some thought.

Maybe the virtio spec should include a way to query the vendor that 
does not involve the pci sig. Maybe use a string? Then no registry 
would be necessary.
