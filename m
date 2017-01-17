From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 kernel 3/5] virtio-balloon: speed up inflate/deflate
	process
Date: Tue, 17 Jan 2017 21:15:45 +0200
Message-ID: <20170117211131-mutt-send-email-mst__3272.02880657769$1484680552$gmane$org@kernel.org>
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
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, dave.hansen@intel.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 21, 2016 at 02:52:26PM +0800, Liang Li wrote:
>  
> -	/* We should always be able to add one buffer to an empty queue. */
> -	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
> -	virtqueue_kick(vq);
> +static void do_set_resp_bitmap(struct virtio_balloon *vb,
> +		unsigned long base_pfn, int pages)
>  
> -	/* When host has read buffer, this completes via balloon_ack */
> -	wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> +{
> +	__le64 *range = vb->resp_data + vb->resp_pos;
>  
> +	if (pages > (1 << VIRTIO_BALLOON_NR_PFN_BITS)) {
> +		/* when the length field can't contain pages, set it to 0 to

/*
 * Multi-line
 * comments
 * should look like this.
 */

Also, pls start sentences with an upper-case letter.

> +		 * indicate the actual length is in the next __le64;
> +		 */

This is part of the interface so should be documented as such.

> +		*range = cpu_to_le64((base_pfn <<
> +				VIRTIO_BALLOON_NR_PFN_BITS) | 0);
> +		*(range + 1) = cpu_to_le64(pages);
> +		vb->resp_pos += 2;

Pls use structs for this kind of stuff.

> +	} else {
> +		*range = (base_pfn << VIRTIO_BALLOON_NR_PFN_BITS) | pages;
> +		vb->resp_pos++;
> +	}
> +}
