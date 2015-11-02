From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/3] Provide simple noop dma ops
Date: Mon, 2 Nov 2015 16:16:44 +0100
Message-ID: <20151102151644.GC2876__19277.8845354498$1446477438$gmane$org@suse.de>
References: <1446211237-111298-1-git-send-email-borntraeger@de.ibm.com>
	<1446211237-111298-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1446211237-111298-2-git-send-email-borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, KVM <kvm@vger.kernel.org>, Michael Tsirkin <mst@redhat.com>, benh@kernel.crashing.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, dwmw2@infradead.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 30, 2015 at 02:20:35PM +0100, Christian Borntraeger wrote:
> +static void *dma_noop_alloc(struct device *dev, size_t size,
> +			    dma_addr_t *dma_handle, gfp_t gfp,
> +			    struct dma_attrs *attrs)
> +{
> +	void *ret;
> +
> +	ret = (void *)__get_free_pages(gfp, get_order(size));
> +	if (ret) {
> +		memset(ret, 0, size);

There is no need to zero out the memory here. If the user wants
initialized memory it can call dma_zalloc_coherent. Having the memset
here means to clear the memory twice in the dma_zalloc_coherent path.

Otherwise it looks good.


	Joerg
