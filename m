From: Christoph Hellwig <hch@infradead.org>
Subject: Re: automatic IRQ affinity for virtio V3
Date: Thu, 9 Feb 2017 05:50:31 -0800
Message-ID: <20170209135031.GA5771@infradead.org>
References: <20170205171526.6224-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170205171526.6224-1-hch@lst.de>
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
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Feb 05, 2017 at 06:15:17PM +0100, Christoph Hellwig wrote:
> Hi Michael, hi Jason,
> 
> This patches applies a few cleanups to the virtio PCI interrupt handling
> code, and then converts the virtio PCI code to use the automatic MSI-X
> vectors spreading, as well as using the information in virtio-blk
> and virtio-scsi to automatically align the blk-mq queues to the MSI-X
> vectors.

Any chance to get this in for 4.11 after I got reviews from Jason
for most of the patches?
