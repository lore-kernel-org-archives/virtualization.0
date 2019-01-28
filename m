From: "hch@infradead.org" <hch@infradead.org>
Subject: Re: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Date: Mon, 28 Jan 2019 00:00:29 -0800
Message-ID: <20190128080028.GA18476__15314.353261941$1548681639$gmane$org@infradead.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
	<alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
	<20190123071232.GA20526@infradead.org>
	<alpine.DEB.2.10.1901230935280.17936@sstabellini-ThinkPad-X260>
	<20190123211405.GA4971@infradead.org>
	<AM0PR04MB4481F3986CFB6D1EF26FA135889B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481F3986CFB6D1EF26FA135889B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peng Fan <peng.fan@nxp.com>
Cc: "jgross@suse.com" <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Andy Duan <fugang.duan@nxp.com>, "mst@redhat.com" <mst@redhat.com>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "hch@infradead.org" <hch@infradead.org>, "luto@kernel.org" <luto@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 25, 2019 at 09:45:26AM +0000, Peng Fan wrote:
> Just have a question, 
> 
> Since vmalloc_to_page is ok for cma area, no need to take cma and per device
> cma into consideration right? 

The CMA area itself it a physical memory region.  If it is a non-highmem
region you can call virt_to_page on the virtual addresses for it.  If
it is in highmem it doesn't even have a kernel virtual address by
default.

> we only need to implement a piece code to handle per device specific region
> using RESERVEDMEM_OF_DECLARE, just like:
> RESERVEDMEM_OF_DECLARE(rpmsg-dma, "rpmsg-dma-pool", 
> rmem_rpmsg_dma_setup);
> And implement the device_init call back and build a map between page and phys.
> Then in rpmsg driver, scatter list could use page structure, no need vmalloc_to_page
> for per device dma.
> 
> Is this the right way?

I think this should work fine.  If you have the cycles for it I'd
actually love to be able to have generic CMA DT glue for non DMA API
driver allocations, as there obviously is a need for it.  So basically
the same as above, just added to kernel/cma.c as a generic API.
