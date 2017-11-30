From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v18 01/10] idr: add #include <linux/bug.h>
Date: Wed, 29 Nov 2017 16:58:17 -0800
Message-ID: <20171130005817.GA14785__28661.2390926623$1512003533$gmane$org@bombadil.infradead.org>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1511963726-34070-2-git-send-email-wei.w.wang@intel.com>
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
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 29, 2017 at 09:55:17PM +0800, Wei Wang wrote:
> The <linux/bug.h> was removed from radix-tree.h by the following commit:
> f5bba9d11a256ad2a1c2f8e7fc6aabe6416b7890.
> 
> Since that commit, tools/testing/radix-tree/ couldn't pass compilation
> due to: tools/testing/radix-tree/idr.c:17: undefined reference to
> WARN_ON_ONCE. This patch adds the bug.h header to idr.h to solve the
> issue.

Thanks; I sent this same patch out yesterday.

Unfortunately, you didn't cc the author of this breakage, Masahiro Yamada.
I want to highlight that these kinds of header cleanups are risky,
and very low reward.  I really don't want to see patches going all over
the tree randomly touching header files.  If we've got a real problem
to solve, then sure.  But I want to see a strong justification for any
more header file cleanups.
