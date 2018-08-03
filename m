From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Fri, 3 Aug 2018 00:06:38 -0700
Message-ID: <20180803070638.GB1344__41725.021453067$1533279896$gmane$org@infradead.org>
References: <20180727095804.GA25592@arm.com>
	<20180730093414.GD26245@infradead.org>
	<20180730125100-mutt-send-email-mst@kernel.org>
	<20180730111802.GA9830@infradead.org>
	<20180730155633-mutt-send-email-mst@kernel.org>
	<20180731173052.GA17153@infradead.org>
	<3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
	<20180802003823-mutt-send-email-mst@kernel.org>
	<7779442d7889ee943b3e4ff6c63ec90b4a58b79d.camel@kernel.crashing.org>
	<20180802235233-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180802235233-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, paulus@samba.org, marc.zyngier@arm.com, mpe@ellerman.id.au, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 02, 2018 at 11:53:08PM +0300, Michael S. Tsirkin wrote:
> > We don't need cache flushing tricks.
> 
> You don't but do real devices on same platform need them?

IBMs power plaforms are always cache coherent.  There are some powerpc
platforms have not cache coherent DMA, but I guess this scheme isn't
intended for them.
