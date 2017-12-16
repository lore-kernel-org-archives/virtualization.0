From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v19 1/7] xbitmap: Introduce xbitmap
Date: Sat, 16 Dec 2017 18:10:11 +0800
Message-ID: <5A34F103.7070004__31052.1690328189$1513418944$gmane$org@intel.com>
References: <1513079759-14169-2-git-send-email-wei.w.wang@intel.com>
	<201712151837.MQq7hdgk%fengguang.wu@intel.com>
	<20171215132405.GB10348@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171215132405.GB10348@bombadil.infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <willy@infradead.org>, kbuild test robot <lkp@intel.com>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, kbuild-all@01.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On 12/15/2017 09:24 PM, Matthew Wilcox wrote:
> On Fri, Dec 15, 2017 at 07:05:07PM +0800, kbuild test robot wrote:
>>      21		struct radix_tree_node *node;
>>      22		void **slot;
>                               ^^^
> missing __rcu annotation here.
>
> Wei, could you fold that change into your next round?  Thanks!
>

Sure, I'll do. Thanks for your time on this patch series.

Best,
Wei
