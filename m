From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v20 0/7] Virtio-balloon Enhancement
Date: Tue, 19 Dec 2017 06:40:20 -0800
Message-ID: <20171219144020.GA30842__10561.5718327046$1513694348$gmane$org@bombadil.infradead.org>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, mst@redhat.com, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, quan.xu0@gmail.com, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 19, 2017 at 11:05:11PM +0900, Tetsuo Handa wrote:
> Removing exceptional path made this patch easier to read.
> But what I meant is
> 
>   Can you eliminate exception path and fold all xbitmap patches into one, and
>   post only one xbitmap patch without virtio-balloon changes? 
> 
> .
> 
> I still think we don't need xb_preload()/xb_preload_end().
> I think xb_find_set() has a bug in !node path.

Don't think.  Write a test-case.  Please.  If it shows a bug, then great,
Wei has an example of what the bug is to fix.  If it doesn't show a bug,
then we can add it to the test suite anyway, to ensure that case continues
to work in the future.

> Also, please avoid unconditionally adding to builtin modules.
> There are users who want to save even few KB.
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
