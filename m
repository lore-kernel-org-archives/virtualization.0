From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Wed, 29 May 2013 13:21:00 +0300
Message-ID: <20130529102100.GQ4472@redhat.com>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <87zkf3fiu2.fsf@rustcorp.com.au>
	<20111211094256.GB11504@redhat.com>
	<87boreohhs.fsf@rustcorp.com.au> <20111212114912.GA7946@redhat.com>
	<20130528075613.GA23148@redhat.com>
	<874ndmoa7z.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <874ndmoa7z.fsf@rustcorp.com.au>
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
Cc: Sasha Levin <levinsasha928@gmail.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 29, 2013 at 10:47:52AM +0930, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Mon, Dec 12, 2011 at 01:49:13PM +0200, Michael S. Tsirkin wrote:
> >> On Mon, Dec 12, 2011 at 09:15:03AM +1030, Rusty Russell wrote:
> >> > On Sun, 11 Dec 2011 11:42:56 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > > On Thu, Dec 08, 2011 at 09:09:33PM +1030, Rusty Russell wrote:
> >> > > > +/* There is no iowrite64.  We use two 32-bit ops. */
> >> > > > +static void iowrite64(u64 val, const __le64 *addr)
> >> > > > +{
> >> > > > +	iowrite32((u32)val, (__le32 *)addr);
> >> > > > +	iowrite32(val >> 32, (__le32 *)addr + 1);
> >> > > > +}
> >> > > > +
> >> > > 
> >> > > Let's put addr_lo/addr_hi in the structure then,
> >> > > to make the fact this field is not atomic explicit?
> >> > 
> >> > Good point, assuming I haven't missed something.
> >> > 
> >> > Are 64-bit accesses actually unknown in PCI-land?  Or is this a limited
> >> > availability thing?
> >> > 
> >> > Thanks,
> >> > Rusty.
> >> 
> >> I think PCI can optionally support atomic 64 bit accesses, but not all
> >> architectures can generate them.
> >
> > Ping. Going to change this in the layout struct?
> 
> Not sure what you mean....  We use a queue_enable field, so it doesn't
> matter if the accesses aren't atomic for that.
> 
> Cheers,
> Rusty.

I mean the struct should have separate _lo and _hi fields.

Otherwise I have to do:

+    case offsetof(struct virtio_pci_common_cfg, queue_desc):
+	 assert(size == 4);
+        return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) & low;
+    case offsetof(struct virtio_pci_common_cfg, queue_desc) + 4:
+	 assert(size == 4);
+        return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) >> 32;

Would be nicer as:

+    case offsetof(struct virtio_pci_common_cfg, queue_desc_lo):
+	 assert(size == sizeof cfg.queue_desc_lo);
+        return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) & low;
+    case offsetof(struct virtio_pci_common_cfg, queue_desc_hi):
+	 assert(size ==  sizeof cfg.queue_desc_hi);
+        return virtio_queue_get_desc_addr(vdev, vdev->queue_sel) >> 32;

Agree?

-- 
MST
