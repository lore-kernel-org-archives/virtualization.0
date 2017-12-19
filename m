From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v20 0/7] Virtio-balloon Enhancement
Date: Tue, 19 Dec 2017 20:08:41 +0200
Message-ID: <20171219200726-mutt-send-email-mst__21045.7314657562$1513706855$gmane$org@kernel.org>
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
Cc: yang.zhang.wz@gmail.com, kvm@vger.kernel.org, liliang.opensource@gmail.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, aarcange@redhat.com, virtio-dev@lists.oasis-open.org, mawilcox@microsoft.com, willy@infradead.org, nilal@redhat.com, riel@redhat.com, cornelia.huck@de.ibm.com, mhocko@kernel.org, quan.xu0@gmail.com, linux-kernel@vger.kernel.org, amit.shah@redhat.com, pbonzini@redhat.com, akpm@linux-foundation.org, mgorman@techsingularity.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 19, 2017 at 11:05:11PM +0900, Tetsuo Handa wrote:
> Wei Wang wrote:
> > ChangeLog:
> > v19->v20:
> > 1) patch 1: xbitmap
> > 	- add __rcu to "void **slot";
> > 	- remove the exceptional path.
> > 2) patch 3: xbitmap
> > 	- DeveloperNotes: add an item to comment that the current bit range
> > 	  related APIs operating on extremely large ranges (e.g.
> >           [0, ULONG_MAX)) will take too long time. This can be optimized in
> > 	  the future.
> > 	- remove the exceptional path;
> > 	- remove xb_preload_and_set();
> > 	- reimplement xb_clear_bit_range to make its usage close to
> > 	  bitmap_clear;
> > 	- rename xb_find_next_set_bit to xb_find_set, and re-implement it
> > 	  in a style close to find_next_bit;
> > 	- rename xb_find_next_zero_bit to xb_find_clear, and re-implement
> > 	  it in a stytle close to find_next_zero_bit;
> > 	- separate the implementation of xb_find_set and xb_find_clear for
> > 	  the convenience of future updates.
> 
> Removing exceptional path made this patch easier to read.
> But what I meant is
> 
>   Can you eliminate exception path and fold all xbitmap patches into one, and
>   post only one xbitmap patch without virtio-balloon changes? 

And then people will complain that patch is too big
and hard to understand without any users.

As long as patches don't change the same lines of code,
it's fine to split up imho. In this case it's done
to attribute code better, seems like a reasonable thing to do
to me.

> .
> 
> I still think we don't need xb_preload()/xb_preload_end().
> I think xb_find_set() has a bug in !node path.
> 
> Also, please avoid unconditionally adding to builtin modules.
> There are users who want to save even few KB.
