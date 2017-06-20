From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v11 6/6] virtio-balloon: VIRTIO_BALLOON_F_CMD_VQ
Date: Tue, 20 Jun 2017 19:18:46 +0300
Message-ID: <20170620190343-mutt-send-email-mst__18897.6531419486$1497975564$gmane$org@kernel.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-7-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1497004901-30593-7-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, amit.shah@redhat.com, liliang.opensource@gmail.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, cornelia.huck@de.ibm.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 09, 2017 at 06:41:41PM +0800, Wei Wang wrote:
> -	if (!virtqueue_indirect_desc_table_add(vq, desc, num)) {
> +	if (!virtqueue_indirect_desc_table_add(vq, desc, *num)) {
>  		virtqueue_kick(vq);
> -		wait_event(vb->acked, virtqueue_get_buf(vq, &len));
> -		vb->balloon_page_chunk.chunk_num = 0;
> +		if (busy_wait)
> +			while (!virtqueue_get_buf(vq, &len) &&
> +			       !virtqueue_is_broken(vq))
> +				cpu_relax();
> +		else
> +			wait_event(vb->acked, virtqueue_get_buf(vq, &len));


This is something I didn't previously notice.
As you always keep a single buffer in flight, you do not
really need indirect at all. Just add all descriptors
in the ring directly, then kick.

E.g.
	virtqueue_add_first
	virtqueue_add_next
	virtqueue_add_last

?

You also want a flag to avoid allocations but there's no need to do it
per descriptor, set it on vq.

-- 
MST
