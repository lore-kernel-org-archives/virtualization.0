From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH] virtio_balloon: fix deadlock on OOM
Date: Mon, 30 Oct 2017 17:48:58 +0800
Message-ID: <59F6F58A.2030000__22246.9713575721$1509356822$gmane$org@intel.com>
References: <1507900754-32239-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1507900754-32239-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/13/2017 09:21 PM, Michael S. Tsirkin wrote:
> fill_balloon doing memory allocations under balloon_lock
> can cause a deadlock when leak_balloon is called from
> virtballoon_oom_notify and tries to take same lock.
>
> To fix, split page allocation and enqueue and do allocations outside the lock.
>
> Here's a detailed analysis of the deadlock by Tetsuo Handa:
>
> In leak_balloon(), mutex_lock(&vb->balloon_lock) is called in order to
> serialize against fill_balloon(). But in fill_balloon(),
> alloc_page(GFP_HIGHUSER[_MOVABLE] | __GFP_NOMEMALLOC | __GFP_NORETRY) is
> called with vb->balloon_lock mutex held. Since GFP_HIGHUSER[_MOVABLE]
> implies __GFP_DIRECT_RECLAIM | __GFP_IO | __GFP_FS, despite __GFP_NORETRY
> is specified, this allocation attempt might indirectly depend on somebody
> else's __GFP_DIRECT_RECLAIM memory allocation. And such indirect
> __GFP_DIRECT_RECLAIM memory allocation might call leak_balloon() via
> virtballoon_oom_notify() via blocking_notifier_call_chain() callback via
> out_of_memory() when it reached __alloc_pages_may_oom() and held oom_lock
> mutex. Since vb->balloon_lock mutex is already held by fill_balloon(), it
> will cause OOM lockup. Thus, do not wait for vb->balloon_lock mutex if
> leak_balloon() is called from out_of_memory().
>
>    Thread1                                       Thread2
>      fill_balloon()
>        takes a balloon_lock
>        balloon_page_enqueue()
>          alloc_page(GFP_HIGHUSER_MOVABLE)
>            direct reclaim (__GFP_FS context)       takes a fs lock
>              waits for that fs lock                  alloc_page(GFP_NOFS)
>                                                        __alloc_pages_may_oom()
>                                                          takes the oom_lock
>                                                          out_of_memory()
>                                                            blocking_notifier_call_chain()
>                                                              leak_balloon()
>                                                                tries to take that balloon_lock and deadlocks
>
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> ---

The "virtio-balloon enhancement" series has a dependency on this patch.
Could you send out a new version soon? Or I can include it in the series 
if you want.


Best,
Wei
