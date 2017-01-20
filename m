From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v6 kernel 3/5] virtio-balloon: speed up inflate/deflate
	process
Date: Fri, 20 Jan 2017 11:48:09 +0000
Message-ID: <20170120114809.GH2658__48860.6141916991$1484912914$gmane$org@work-vm>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
	<1482303148-22059-4-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1482303148-22059-4-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, dave.hansen@intel.com, qemu-devel@nongnu.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, amit.shah@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

* Liang Li (liang.z.li@intel.com) wrote:

<snip>

> +static void free_extended_page_bitmap(struct virtio_balloon *vb)
> +{
> +	int i, bmap_count = vb->nr_page_bmap;
> +
> +	for (i = 1; i < bmap_count; i++) {
> +		kfree(vb->page_bitmap[i]);
> +		vb->page_bitmap[i] = NULL;
> +		vb->nr_page_bmap--;
> +	}
> +}
> +
> +static void kfree_page_bitmap(struct virtio_balloon *vb)
> +{
> +	int i;
> +
> +	for (i = 0; i < vb->nr_page_bmap; i++)
> +		kfree(vb->page_bitmap[i]);
> +}

It might be worth commenting that pair of functions to make it clear
why they are so different; I guess the kfree_page_bitmap
is used just before you free the structure above it so you
don't need to keep the count/pointers updated?

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
