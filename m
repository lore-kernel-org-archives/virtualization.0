From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next V3] virtio_net: ethtool tx napi configuration
Date: Wed, 10 Oct 2018 22:34:58 -0700 (PDT)
Message-ID: <20181010.223458.915344551656019248.davem__23552.9816979126$1539235981$gmane$org@davemloft.net>
References: <20181009020626.31723-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181009020626.31723-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, willemb@google.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue,  9 Oct 2018 10:06:26 +0800

> Implement ethtool .set_coalesce (-C) and .get_coalesce (-c) handlers.
> Interrupt moderation is currently not supported, so these accept and
> display the default settings of 0 usec and 1 frame.
> 
> Toggle tx napi through setting tx-frames. So as to not interfere
> with possible future interrupt moderation, value 1 means tx napi while
> value 0 means not.
> 
> Only allow the switching when device is down for simplicity.
> 
> Link: https://patchwork.ozlabs.org/patch/948149/
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V2:
> - only allow the switching when device is done
> - remove unnecessary global variable and initialization
> Changes from V1:
> - try to synchronize with datapath to allow changing mode when
>   interface is up.
> - use tx-frames 0 as to disable tx napi while tx-frames 1 to enable tx napi

Applied, with...

> +	bool running = netif_running(dev);

this unused variable removed.
