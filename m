From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 6 Aug 2018 09:34:21 -0700
Message-ID: <20180806163421.GA13077@infradead.org>
References: <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
	<20180803220812-mutt-send-email-mst@kernel.org>
	<01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
	<20180805032355-mutt-send-email-mst@kernel.org>
	<74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
	<20180806163440-mutt-send-email-mst@kernel.org>
	<20180806152406.GA29020@infradead.org>
	<20180806190321-mutt-send-email-mst@kernel.org>
	<20180806161040.GA4675@infradead.org>
	<20180806191111-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180806191111-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, paulus@samba.org, joe@perches.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 06, 2018 at 07:13:32PM +0300, Michael S. Tsirkin wrote:
> Oh that makes sense then. Could you post a pointer pls so
> this patchset is rebased on top (there are things to
> change about 4/4 but 1-3 could go in if they don't add
> overhead)?

The dma mapping direct calls will need a major work vs what I posted.
I plan to start that work in about two weeks once returning from my
vacation.
