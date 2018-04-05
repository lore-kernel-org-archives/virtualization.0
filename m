From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] virtio: Use DMA MAP API for devices without an IOMMU
Date: Fri, 06 Apr 2018 07:18:33 +1000
Message-ID: <1522963113.21446.211.camel@kernel.crashing.org>
References: <20180405105631.9514-1-khandual@linux.vnet.ibm.com>
	<3e1b113b-79ca-b700-5be9-10c66d74aabe@linux.vnet.ibm.com>
	<20180405175326-mutt-send-email-mst@kernel.org>
	<1522940983.21446.205.camel@kernel.crashing.org>
	<20180405213042-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180405213042-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, joe@perches.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2018-04-05 at 21:34 +0300, Michael S. Tsirkin wrote:
> > In this specific case, because that would make qemu expect an iommu,
> > and there isn't one.
> 
> 
> I think that you can set iommu_platform in qemu without an iommu.

No I mean the platform has one but it's not desirable for it to be used
due to the performance hit.

Cheers,
Ben.
> 
> > Anshuman, you need to provide more background here. I don't have time
> > right now it's late, but explain about the fact that this is for a
> > specific type of secure VM which has only a limited pool of (insecure)
> > memory that can be shared with qemu, so all IOs need to bounce via that
> > pool, which can be achieved by using swiotlb.
> > 
> > Note: this isn't urgent, we can discuss alternative approaches, this is
> > just to start the conversation.
> > 
> > Cheers,
> > Ben.
