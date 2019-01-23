From: "hch@infradead.org" <hch@infradead.org>
Subject: Re: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Date: Tue, 22 Jan 2019 23:12:32 -0800
Message-ID: <20190123071232.GA20526__26943.9993704268$1548227762$gmane$org@infradead.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
	<alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: jgross@suse.com, Peng Fan <peng.fan@nxp.com>, "mst@redhat.com" <mst@redhat.com>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "hch@infradead.org" <hch@infradead.org>, luto@kernel.org, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 22, 2019 at 11:59:31AM -0800, Stefano Stabellini wrote:
> >  	if (!virtio_has_iommu_quirk(vdev))
> >  		return true;
> >  
> > @@ -260,7 +262,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_domain() && !dma_dev->dma_mem)
> >  		return true;
> >  
> >  	return false;
> 
> I can see you spotted a real issue, but this is not the right fix. We
> just need something a bit more flexible than xen_domain(): there are
> many kinds of Xen domains on different architectures, we basically want
> to enable this (return true from vring_use_dma_api) only when the xen
> swiotlb is meant to be used. Does the appended patch fix the issue you
> have?

The problem generally is the other way around - if dma_dev->dma_mem
is set the device decription in the device tree explicitly requires
using this memory, so we must _always_ use the DMA API.

The problem is just that that rproc driver absuses the DMA API
in horrible ways.
