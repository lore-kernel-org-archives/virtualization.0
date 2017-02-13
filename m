From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] virtio: Try to untangle DMA coherency
Date: Mon, 13 Feb 2017 11:57:59 +0000
Message-ID: <20170213115758.GK1512@arm.com>
References: <20170201195732-mutt-send-email-mst@kernel.org>
	<20170201182659.GM8177@arm.com>
	<20170201210648-mutt-send-email-mst@kernel.org>
	<20170202112614.GB30577@arm.com>
	<bb041fbe-3fde-0dc1-ae28-cca5acfe9dc5@arm.com>
	<20170202182224-mutt-send-email-mst@kernel.org>
	<20170202164049.GI13839@arm.com>
	<20170209201341-mutt-send-email-mst@kernel.org>
	<20170209183118.GI19397@arm.com>
	<20170210191409-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170210191409-mutt-send-email-mst@kernel.org>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, virtualization@lists.linux-foundation.org, robh+dt@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 10, 2017 at 07:16:10PM +0200, Michael S. Tsirkin wrote:
> On Thu, Feb 09, 2017 at 06:31:18PM +0000, Will Deacon wrote:
> > On ARM (and other archs such as
> > Power), having a mismatch between a cacheable and a non-cacheable mapping
> > can result in a loss of coherency between the two (for example, if the
> > non-cacheable gues accesses bypass the cache, but the cacheable host
> > accesses allocate in the cache).
> 
> I guess it's an optimization to avoid cache snoops for non-cacheable accesses?

The architecture doesn't rationalise the decision, but a micro-architecture
could indeed implement the optimisation you suggest (and we do observe the
loss of coherency in practice).

Will
