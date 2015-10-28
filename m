From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Wed, 28 Oct 2015 18:12:59 +0200
Message-ID: <20151028175136-mutt-send-email-mst__21412.058818578$1446048811$gmane$org@redhat.com>
References: <cover.1446014204.git.luto@kernel.org>
	<20151028091208-mutt-send-email-mst@redhat.com>
	<56307BD1.6010806@de.ibm.com>
	<1446019787.3405.203.camel@infradead.org>
	<20151028132331-mutt-send-email-mst@redhat.com>
	<1446039327.3405.216.camel@infradead.org>
	<20151028155105-mutt-send-email-mst@redhat.com>
	<1446041609.3405.228.camel@infradead.org>
	<20151028161424-mutt-send-email-mst@redhat.com>
	<1446042754.3405.237.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1446042754.3405.237.camel@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 28, 2015 at 11:32:34PM +0900, David Woodhouse wrote:
> > I don't have a problem with extending DMA API to address
> > more usecases.
> 
> No, this isn't an extension. This is fixing a bug, on certain platforms
> where the DMA API has currently done the wrong thing.
> 
> We have historically worked around that bug by introducing *another*
> bug, which is not to *use* the DMA API in the virtio driver.
> 
> Sure, we can co-ordinate those two bug-fixes. But let's not talk about
> them as anything other than bug-fixes.

It was pretty practical not to use it. All virtio devices at the time
without exception bypassed the IOMMU, so it was a question of omitting a
couple of function calls in virtio versus hacking on DMA implementation
on multiple platforms. We have more policy options now, so I agree it's
time to revisit this.

But for me, the most important thing is that we do coordinate.

> > > Drivers use DMA API. No more talky.
> > 
> > Well for virtio they don't ATM. And 1:1 mapping makes perfect sense
> > for the wast majority of users, so I can't switch them over
> > until the DMA API actually addresses all existing usecases.
> 
> That's still not your business; it's the platform's. And there are
> hardware implementations of the virtio protocols on real PCI cards. And
> we have the option of doing IOMMU translation for the virtio devices
> even in a virtual machine. Just don't get involved.
> 
> -- 
> dwmw2
> 
> 

I'm involved anyway, it's possible not to put all the code in the virtio
subsystem in guest though.  But I suspect we'll need to find a way for
non-linux drivers within guest to work correctly too, and they might
have trouble poking at things at the system level.  So possibly virtio
subsystem will have to tell platform "this device wants to bypass IOMMU"
and then DMA API does the right thing.

I'll look into this after my vacation ~1.5 weeks from now.

-- 
MST
