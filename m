From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3] virtio_net: avoid using netif_tx_disable() for
	serializing tx routine
Date: Wed, 17 Oct 2018 22:30:01 -0700 (PDT)
Message-ID: <20181017.223001.1576138840071012489.davem@davemloft.net>
References: <276ac5bb-90f7-5fb6-a826-0bb05ecfa069@redhat.com>
	<20181017104419.13003-1-ake@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181017104419.13003-1-ake@igel.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: ake@igel.co.jp
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Ake Koomsin <ake@igel.co.jp>
Date: Wed, 17 Oct 2018 19:44:12 +0900

> Commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> introduces netif_tx_disable() after netif_device_detach() in order to
> avoid use-after-free of tx queues. However, there are two issues.
> 
> 1) Its operation is redundant with netif_device_detach() in case the
>    interface is running.
> 2) In case of the interface is not running before suspending and
>    resuming, the tx does not get resumed by netif_device_attach().
>    This results in losing network connectivity.
> 
> It is better to use netif_tx_lock_bh()/netif_tx_unlock_bh() instead for
> serializing tx routine during reset. This also preserves the symmetry
> of netif_device_detach() and netif_device_attach().
> 
> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> Signed-off-by: Ake Koomsin <ake@igel.co.jp>

Applied and queued up for -stable.
