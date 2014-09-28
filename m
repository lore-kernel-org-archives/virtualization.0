From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] virtio_balloon: Convert "vballon" kthread into a workqueue
Date: Sun, 28 Sep 2014 08:43:18 -0400
Message-ID: <20140928124318.GA3736@mtj.dyndns.org>
References: <1411662041-10986-1-git-send-email-pmladek@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1411662041-10986-1-git-send-email-pmladek@suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Petr Mladek <pmladek@suse.cz>
Cc: Jiri Kosina <jkosina@suse.cz>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 25, 2014 at 06:20:41PM +0200, Petr Mladek wrote:
...
>     1st create_freezable_workqueue("vballoon_wq");

All create_*workqueue() interfaces are deprecated.  Please don't
create new usages.  They map to alloc_*workqueue() anyway.

>     2nd alloc_workqueue("vballoon_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);

Is WQ_MEM_RECLAIM necessary here?  Does virtio_balloon depended upon
from memory allocation path?

...
> The 2nd way to create the workqueue has about the same results as kthread.
> This is why it is used in the patch.

You're testing WQ_UNBOUND vs. !WQ_UNBOUND and yes for most use cases,
!WQ_UNBOUND will be more efficient.  The right thing to do in most
cases is using alloc_workqueue() w/ as minimum extra flags as
possible.

Thanks!

-- 
tejun
