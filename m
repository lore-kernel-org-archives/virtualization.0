From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 6 Aug 2018 23:32:01 -0700
Message-ID: <20180807063201.GB23159__39808.6638575934$1533623410$gmane$org@infradead.org>
References: <051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
	<20180805031046-mutt-send-email-mst@kernel.org>
	<fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
	<20180806164106-mutt-send-email-mst@kernel.org>
	<ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
	<20180806233024-mutt-send-email-mst@kernel.org>
	<0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
	<20180807002857-mutt-send-email-mst@kernel.org>
	<93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
	<20180807024503-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180807024503-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, jean-philippe.brucker@arm.com, paulus@samba.org, marc.zyngier@arm.com, mpe@ellerman.id.au, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 07, 2018 at 02:45:25AM +0300, Michael S. Tsirkin wrote:
> > > I think that's where Christoph might have specific ideas about it.
> > 
> > OK well, assuming Christoph can solve the direct case in a way that
> > also work for the virtio !iommu case, we still want some bit of logic
> > somewhere that will "switch" to swiotlb based ops if the DMA mask is
> > limited.
> > 
> > You mentioned an RFC for that ? Do you happen to have a link ?
> 
> No but Christoph did I think.

Do you mean the direct map retpoline mitigation?  It is here:

https://www.spinics.net/lists/netdev/msg495413.html

https://www.spinics.net/lists/netdev/msg495785.html
