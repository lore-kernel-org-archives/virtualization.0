From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 0/9] Fixes for vhost metadata acceleration
Date: Sat, 10 Aug 2019 13:52:38 -0400
Message-ID: <20190810134948-mutt-send-email-mst@kernel.org>
References: <20190809054851.20118-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190809054851.20118-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, jgg@ziepe.ca, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 09, 2019 at 01:48:42AM -0400, Jason Wang wrote:
> Hi all:
> 
> This series try to fix several issues introduced by meta data
> accelreation series. Please review.
> 
> Changes from V4:
> - switch to use spinlock synchronize MMU notifier with accessors
> 
> Changes from V3:
> - remove the unnecessary patch
> 
> Changes from V2:
> - use seqlck helper to synchronize MMU notifier with vhost worker
> 
> Changes from V1:
> - try not use RCU to syncrhonize MMU notifier with vhost worker
> - set dirty pages after no readers
> - return -EAGAIN only when we find the range is overlapped with
>   metadata
> 
> Jason Wang (9):
>   vhost: don't set uaddr for invalid address
>   vhost: validate MMU notifier registration
>   vhost: fix vhost map leak
>   vhost: reset invalidate_count in vhost_set_vring_num_addr()
>   vhost: mark dirty pages during map uninit
>   vhost: don't do synchronize_rcu() in vhost_uninit_vq_maps()
>   vhost: do not use RCU to synchronize MMU notifier with worker
>   vhost: correctly set dirty pages in MMU notifiers callback
>   vhost: do not return -EAGAIN for non blocking invalidation too early
> 
>  drivers/vhost/vhost.c | 202 +++++++++++++++++++++++++-----------------
>  drivers/vhost/vhost.h |   6 +-
>  2 files changed, 122 insertions(+), 86 deletions(-)

This generally looks more solid.

But this amounts to a significant overhaul of the code.

At this point how about we revert 7f466032dc9e5a61217f22ea34b2df932786bbfc
for this release, and then re-apply a corrected version
for the next one?


> -- 
> 2.18.1
