From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v18 01/10] idr: add #include <linux/bug.h>
Date: Thu, 30 Nov 2017 13:49:24 -0800
Message-ID: <20171130134924.e842ccd01e34eaf8834f4033__23963.5214595639$1512078589$gmane$org@linux-foundation.org>
References: <1511963726-34070-1-git-send-email-wei.w.wang@intel.com>
	<1511963726-34070-2-git-send-email-wei.w.wang@intel.com>
	<20171130005817.GA14785@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171130005817.GA14785@bombadil.infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <willy@infradead.org>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 29 Nov 2017 16:58:17 -0800 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, Nov 29, 2017 at 09:55:17PM +0800, Wei Wang wrote:
> > The <linux/bug.h> was removed from radix-tree.h by the following commit:
> > f5bba9d11a256ad2a1c2f8e7fc6aabe6416b7890.
> > 
> > Since that commit, tools/testing/radix-tree/ couldn't pass compilation
> > due to: tools/testing/radix-tree/idr.c:17: undefined reference to
> > WARN_ON_ONCE. This patch adds the bug.h header to idr.h to solve the
> > issue.
> 
> Thanks; I sent this same patch out yesterday.
> 
> Unfortunately, you didn't cc the author of this breakage, Masahiro Yamada.
> I want to highlight that these kinds of header cleanups are risky,
> and very low reward.  I really don't want to see patches going all over
> the tree randomly touching header files.  If we've got a real problem
> to solve, then sure.  But I want to see a strong justification for any
> more header file cleanups.

I tend to disagree.  We accumulate more and more cruft over time so it
is good to be continually hacking away at it.  These little build
breaks happen occasionally but they are trivially and quickly fixed. 
If a small minority of these cleanups require a followup patch which
consumes a global ten person minutes then that seems an acceptable
price to pay.  Says the guy who pays most of that price :)
