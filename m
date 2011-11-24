From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3 RFC] virtio-pci: flexible configuration layout
Date: Thu, 24 Nov 2011 08:24:41 +0200
Message-ID: <20111124062440.GG29994@redhat.com>
References: <20111122183621.GA5235@redhat.com> <87hb1v1scp.fsf@rustcorp.com.au>
	<20111123084640.GE22734@redhat.com>
	<87ty5uxso3.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ty5uxso3.fsf@rustcorp.com.au>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 24, 2011 at 11:06:44AM +1030, Rusty Russell wrote:
> > > +/* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
> > > +struct virtio_pci_common_cfg {
> > > +	/* About the whole device. */
> > > +	__u64 device_features;	/* read-only */
> > > +	__u64 guest_features;	/* read-write */
> > > +	__u64 queue_address;	/* read-write */
> > > +	__u16 msix_config;	/* read-write */
> > > +	__u8 device_status;	/* read-write */
> > > +	__u8 unused;
> > > +
> > > +	/* About a specific virtqueue. */
> > > +	__u16 queue_select;	/* read-write */
> > > +	__u16 queue_align;	/* read-write, power of 2. */
> > > +	__u16 queue_size;	/* read-write, power of 2. */
> > > +	__u16 queue_msix_vector;/* read-write */
> > > +};
> > 
> > Slightly confusing as the registers are in fact little endian ...
> 
> Good point, should mark them appropriately with __le16.  That makes it
> even clearer.
> 
> Thanks,
> Rusty.

Do we still require atomic access to fields in common cfg?
If yes it's a problem as some systems don't have 64 bit
addresses. If no, implementations might get harder.

-- 
MST
