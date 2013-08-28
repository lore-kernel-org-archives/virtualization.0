From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH-v3 1/4] idr: Percpu ida
Date: Wed, 28 Aug 2013 14:15:44 -0700
Message-ID: <20130828141544.b3cafb57b05ced5f0ba64766@linux-foundation.org>
References: <1376694549-20609-1-git-send-email-nab@linux-iscsi.org>
	<1376694549-20609-2-git-send-email-nab@linux-iscsi.org>
	<20130820143157.f91bf59d16352989b54e431e@linux-foundation.org>
	<20130828195317.GE8032@kmo-pixel>
	<20130828132332.6d5263ee9622235ae0fcc615@linux-foundation.org>
	<20130828204454.GC1357@kmo-pixel>
	<20130828135042.9e460b27699b52bb4eb53d9e@linux-foundation.org>
	<20130828211217.GE1357@kmo-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130828211217.GE1357@kmo-pixel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kent Overstreet <kmo@daterainc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andi Kleen <andi@firstfloor.org>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, lkml <linux-kernel@vger.kernel.org>, lf-virt <virtualization@lists.linux-foundation.org>, target-devel <target-devel@vger.kernel.org>, Christoph Lameter <cl@gentwo.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 28 Aug 2013 14:12:17 -0700 Kent Overstreet <kmo@daterainc.com> wrote:

> How's this look?
> 
> diff --git a/lib/idr.c b/lib/idr.c
> index 15c021c..a3f8e9a 100644
> --- a/lib/idr.c
> +++ b/lib/idr.c
> @@ -1288,6 +1288,11 @@ static inline unsigned alloc_local_tag(struct percpu_ida *pool,
>   * Safe to be called from interrupt context (assuming it isn't passed
>   * __GFP_WAIT, of course).
>   *
> + * @gfp indicates whether or not to wait until a free id is available (it's not
> + * used for internal memory allocations); thus if passed __GFP_WAIT we may sleep
> + * however long it takes until another thread frees an id (same semantics as a
> + * mempool).

Looks good.  Mentioning the mempool thing is effective - people
understand that.
