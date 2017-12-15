From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v19 1/7] xbitmap: Introduce xbitmap
Date: Fri, 15 Dec 2017 05:24:05 -0800
Message-ID: <20171215132405.GB10348__27663.9795898975$1513344296$gmane$org@bombadil.infradead.org>
References: <1513079759-14169-2-git-send-email-wei.w.wang@intel.com>
	<201712151837.MQq7hdgk%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201712151837.MQq7hdgk%fengguang.wu@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kbuild test robot <lkp@intel.com>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, linux-kernel@vger.kernel.org, kbuild-all@01.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 15, 2017 at 07:05:07PM +0800, kbuild test robot wrote:
>     21		struct radix_tree_node *node;
>     22		void **slot;
                             ^^^
missing __rcu annotation here.

Wei, could you fold that change into your next round?  Thanks!
