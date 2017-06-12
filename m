From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v11 6/6] virtio-balloon: VIRTIO_BALLOON_F_CMD_VQ
Date: Mon, 12 Jun 2017 07:07:15 -0700
Message-ID: <db8cc3d1-50fc-2412-af2f-1070dda38be3__22976.417039945$1497276530$gmane$org@intel.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-7-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1497004901-30593-7-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/09/2017 03:41 AM, Wei Wang wrote:
> +	for_each_populated_zone(zone) {
> +		for (order = MAX_ORDER - 1; order > 0; order--) {
> +			for (migratetype = 0; migratetype < MIGRATE_TYPES;
> +			     migratetype++) {
> +				do {
> +					ret = report_unused_page_block(zone,
> +						order, migratetype, &page);
> +					if (!ret) {
> +						pfn = (u64)page_to_pfn(page);
> +						add_one_chunk(vb, vq,
> +						PAGE_CHNUK_UNUSED_PAGE,
> +						pfn << VIRTIO_BALLOON_PFN_SHIFT,
> +						(u64)(1 << order) *
> +						VIRTIO_BALLOON_PAGES_PER_PAGE);
> +					}
> +				} while (!ret);
> +			}
> +		}
> +	}

This is pretty unreadable.    Please add some indentation.  If you go
over 80 cols, then you might need to break this up into a separate
function.  But, either way, it can't be left like this.
