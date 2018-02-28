From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] virtio-net: disable NAPI only when enabled during
	XDP set
Date: Wed, 28 Feb 2018 12:22:31 -0500 (EST)
Message-ID: <20180228.122231.1811613646832502397.davem@davemloft.net>
References: <1519813204-10002-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1519813204-10002-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Feb 2018 18:20:04 +0800

> We try to disable NAPI to prevent a single XDP TX queue being used by
> multiple cpus. But we don't check if device is up (NAPI is enabled),
> this could result stall because of infinite wait in
> napi_disable(). Fixing this by checking device state through
> netif_running() before.
> 
> Fixes: 4941d472bf95b ("virtio-net: do not reset during XDP set")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Yes, mis-paired NAPI enable/disable are really a pain.

Probably, we can do something in the interfaces or mechanisms to make
this less error prone and less fragile.

Anyways, applied and queued up for -stable, thanks!
