From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Try to untangle DMA coherency
Date: Thu, 9 Feb 2017 20:17:16 +0200
Message-ID: <20170209201341-mutt-send-email-mst@kernel.org>
References: <8a6494f6409c20b4609cd6bdcdd751f68b5c0564.1485951731.git.robin.murphy@arm.com>
	<20170201195732-mutt-send-email-mst@kernel.org>
	<20170201182659.GM8177@arm.com>
	<20170201210648-mutt-send-email-mst@kernel.org>
	<20170202112614.GB30577@arm.com>
	<bb041fbe-3fde-0dc1-ae28-cca5acfe9dc5@arm.com>
	<20170202182224-mutt-send-email-mst@kernel.org>
	<20170202164049.GI13839@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170202164049.GI13839@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, virtualization@lists.linux-foundation.org, robh+dt@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 02, 2017 at 04:40:49PM +0000, Will Deacon wrote:
> On Thu, Feb 02, 2017 at 06:30:28PM +0200, Michael S. Tsirkin wrote:
> > I am inclined to say, for 4.10 let's revert
> > c7070619f3408d9a0dffbed9149e6f00479cf43b since what it fixes is not a
> > regression in 4.10.
> 
> No complaints there, as long as we can keep working to fix this for 4.11
> and onwards. You'll also need to cc stable on the revert.
> 
> > So I think we can defer the fix to 4.11.
> > I think we still want f7f6634d23830ff74335734fbdb28ea109c1f349
> > for hosts with virtio 1 support.
> > 
> > All this will hopefully push hosts to just implement virtio 1.
> > For mmio the changes are very small: several new registers,
> > that's all. You want this for proper 64 bit dma mask anyway.
> 
> As I've said, virtio 1 will have exactly the same issue unless we start
> requiring firmware to advertise dma-coherent/_CCA for virtio-mmio
> devices correctly.
> 
> Will

OK I read up on _CCA in ACPI spec. It says:
The _CCA object returns whether or not a bus-master device supports
hardware managed cache coherency. Expected values are 0 to indicate it
is not supported, and 1 to indicate that it is supported.

So if host is cache coherent, and guest thinks it isn't, we incur
unnecessary overhead by wasting coherent memory.
I get that but you said it actually breaks - why does it?

-- 
MST
