From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
	virito devices
Date: Tue, 5 Jun 2018 04:25:37 +0300
Message-ID: <20180605042229-mutt-send-email-mst__23268.8935626813$1528161844$gmane$org@kernel.org>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
	<20180523213703-mutt-send-email-mst@kernel.org>
	<f77638ddef3af52dd71341083707c9e3745dd505.camel@kernel.crashing.org>
	<20180604153558-mutt-send-email-mst@kernel.org>
	<e7ceddbec11711a89282e9b70b7fd3c8af10b030.camel@kernel.crashing.org>
	<20180604184035-mutt-send-email-mst@kernel.org>
	<6164442a718645a754879eac5c4c5fad9283c211.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6164442a718645a754879eac5c4c5fad9283c211.camel@kernel.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: robh@kernel.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, joe@perches.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 05, 2018 at 09:26:56AM +1000, Benjamin Herrenschmidt wrote:
> I would like to keep however the ability to bypass the iommu for
> performance reasons

So that's easy, clear the IOMMU flag and this means "bypass the IOMMU".

-- 
MST
