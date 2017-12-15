From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v19 3/7] xbitmap: add more operations
Date: Fri, 15 Dec 2017 10:42:56 -0800
Message-ID: <20171215184256.GA27160__29747.4814033651$1513363452$gmane$org@bombadil.infradead.org>
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>
	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
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
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 12, 2017 at 07:55:55PM +0800, Wei Wang wrote:
> +int xb_preload_and_set_bit(struct xb *xb, unsigned long bit, gfp_t gfp);

I'm struggling to understand when one would use this.  The xb_ API
requires you to handle your own locking.  But specifying GFP flags
here implies you can sleep.  So ... um ... there's no locking?

> +void xb_clear_bit_range(struct xb *xb, unsigned long start, unsigned long end);

That's xb_zero() which you deleted with the previous patch ... remember,
keep things as close as possible to the bitmap API.
