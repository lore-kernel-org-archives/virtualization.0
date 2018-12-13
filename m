From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net V3 0/3] Fix various issue of vhost
Date: Thu, 13 Dec 2018 09:32:30 -0500
Message-ID: <20181213093207-mutt-send-email-mst__48683.6146367297$1544711453$gmane$org@kernel.org>
References: <20181213025339.14023-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181213025339.14023-1-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 13, 2018 at 10:53:36AM +0800, Jason Wang wrote:
> Hi:
> 
> This series tries to fix various issues of vhost:
> 
> - Patch 1 adds a missing write barrier between used idx updating and
>   logging.
> - Patch 2-3 brings back the protection of device IOTLB through vq
>   mutex, this fixes possible use after free in device IOTLB entries.
> 
> Please consider them for -stable.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Thanks
> 
> Changes from V2:
> - drop dirty page fix and make it for net-next
> Changes from V1:
> - silent compiler warning for 32bit.
> - use mutex_trylock() on slowpath instead of mutex_lock() even on fast
>   path.
> 
> Jason Wang (3):
>   vhost: make sure used idx is seen before log in vhost_add_used_n()
>   vhost_net: switch to use mutex_trylock() in vhost_net_busy_poll()
>   Revert "net: vhost: lock the vqs one by one"
> 
>  drivers/vhost/net.c   |  8 +++++++-
>  drivers/vhost/vhost.c | 23 +++++++++++++++++++----
>  2 files changed, 26 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1
