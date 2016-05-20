From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC kernel] balloon: speed up inflating/deflating process
Date: Fri, 20 May 2016 13:19:51 +0200
Message-ID: <3e47bf87-3e9d-f836-021b-8a90919f9002@redhat.com>
References: <1463738386-30868-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1463738386-30868-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Liang Li <liang.z.li@intel.com>, mst@redhat.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, amit.shah@redhat.com, akpm@linux-foundation.org, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org



On 20/05/2016 11:59, Liang Li wrote:
> +
> +		sg_init_table(sg, 5);
> +		sg_set_buf(&sg[0], &flags, sizeof(flags));
> +		sg_set_buf(&sg[1], &start_pfn, sizeof(start_pfn));
> +		sg_set_buf(&sg[2], &page_shift, sizeof(page_shift));
> +		sg_set_buf(&sg[3], &bmap_len, sizeof(bmap_len));

These four should probably be placed in a single struct and therefore a
single sg entry.  It might even be faster to place it together with the
bitmap, thus avoiding the use of indirect descriptors.

You should also test ballooning of a 64GB guest after filling in the
page cache, not just ballooning of a freshly booted 4GB guest.  This
will give you a much more sparse bitmap.  Still, the improvement in
sending PFNs to the host are impressive.

Thanks,

Paolo

> +		sg_set_buf(&sg[4], vb->page_bitmap +
> +				 (start_pfn / BITS_PER_LONG), bmap_len);
> +		virtqueue_add_outbuf(vq, sg, 5, vb, GFP_KERNEL);
