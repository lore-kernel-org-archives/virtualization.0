From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next RFC 0/5] batched tx processing in vhost_net
Date: Tue, 26 Sep 2017 22:26:40 +0300
Message-ID: <20170926222528-mutt-send-email-mst__26323.5326078304$1506454036$gmane$org@kernel.org>
References: <1506067355-5771-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1506067355-5771-1-git-send-email-jasowang@redhat.com>
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

On Fri, Sep 22, 2017 at 04:02:30PM +0800, Jason Wang wrote:
> Hi:
> 
> This series tries to implement basic tx batched processing. This is
> done by prefetching descriptor indices and update used ring in a
> batch. This intends to speed up used ring updating and improve the
> cache utilization. Test shows about ~22% improvement in tx pss.




> Please review.
> 
> Jason Wang (5):
>   vhost: split out ring head fetching logic
>   vhost: introduce helper to prefetch desc index
>   vhost: introduce vhost_add_used_idx()

Please squash these new APIs into where they are used.
This split-up just makes review harder for me as
I can't figure out how the new APIs are used.


>   vhost_net: rename VHOST_RX_BATCH to VHOST_NET_BATCH

This is ok as a separate patch.

>   vhost_net: basic tx virtqueue batched processing
> 
>  drivers/vhost/net.c   | 221 ++++++++++++++++++++++++++++----------------------
>  drivers/vhost/vhost.c | 165 +++++++++++++++++++++++++++++++------
>  drivers/vhost/vhost.h |   9 ++
>  3 files changed, 270 insertions(+), 125 deletions(-)
> 
> -- 
> 2.7.4
