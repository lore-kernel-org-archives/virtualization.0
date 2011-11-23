From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCHv3 RFC] virtio-pci: flexible configuration layout
Date: Wed, 23 Nov 2011 11:38:40 +0200
Message-ID: <1322041120.3581.6.camel@lappy>
References: <20111122183621.GA5235@redhat.com>
	<87hb1v1scp.fsf@rustcorp.com.au>  <20111123084932.GF22734@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111123084932.GF22734@redhat.com>
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
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2011-11-23 at 10:49 +0200, Michael S. Tsirkin wrote:
> On Wed, Nov 23, 2011 at 01:02:22PM +1030, Rusty Russell wrote:
> > +/* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
> > +struct virtio_pci_common_cfg {
> > +	/* About the whole device. */
> > +	__u64 device_features;	/* read-only */
> > +	__u64 guest_features;	/* read-write */
> 
> We currently require atomic accesses to common fields.
> Some architectures might not have such for 64 bit,
> so these need to be split I think ...

We can consider stealing the feature implementation from virtio-mmio:
Use the first 32 bits as a selector and the last as the features
themselves.

It's more complex to work with, but it provides 2**32 32 feature bits
(which should be enough for a while) and it solves the atomic access
issue.

> > +	__u64 queue_address;	/* read-write */
> > +	__u16 msix_config;	/* read-write */
> > +	__u8 device_status;	/* read-write */
> > +	__u8 unused;
> > +
> > +	/* About a specific virtqueue. */
> > +	__u16 queue_select;	/* read-write */
> > +	__u16 queue_align;	/* read-write, power of 2. */
> > +	__u16 queue_size;	/* read-write, power of 2. */
> > +	__u16 queue_msix_vector;/* read-write */
> > +};
> >  #endif
> > 
> > 

-- 

Sasha.
