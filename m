From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Sun, 11 Aug 2019 04:42:38 -0400
Message-ID: <20190811041636-mutt-send-email-mst__19910.3800974385$1565512982$gmane$org@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190811055607.GA12488@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-devel@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Aug 11, 2019 at 07:56:07AM +0200, Christoph Hellwig wrote:
> And once again this is entirely going in the wrong direction.  The only
> way using the DMA API is going to work at all is if the device is ready
> for it.

So the point made is that if DMA addresses are also physical addresses
(not necessarily the same physical addresses that driver supplied), then
DMA API actually works even though device itself uses CPU page tables.


To put it in other terms: it would be possible to make all or part of
memory unenecrypted and then have virtio access all of it.  SEV guests
at the moment make a decision to instead use a bounce buffer, forcing an
extra copy but gaining security.

-- 
MST
