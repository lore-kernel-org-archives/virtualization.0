From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] virtio-net: mark PM functions as __maybe_unused
Date: Tue, 25 Jul 2017 21:23:13 -0700 (PDT)
Message-ID: <20170725.212313.1074903864708351840.davem__43930.3150553771$1501043003$gmane$org@davemloft.net>
References: <20170725153600.211694-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170725153600.211694-1-arnd@arndb.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: arnd@arndb.de
Cc: willemb@google.com, mst@redhat.com, netdev@vger.kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com, bigeasy@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 25 Jul 2017 17:35:50 +0200

> After removing the reset function, the freeze and restore functions
> are now unused when CONFIG_PM_SLEEP is disabled:
> 
> drivers/net/virtio_net.c:1881:12: error: 'virtnet_restore_up' defined but not used [-Werror=unused-function]
>  static int virtnet_restore_up(struct virtio_device *vdev)
> drivers/net/virtio_net.c:1859:13: error: 'virtnet_freeze_down' defined but not used [-Werror=unused-function]
>  static void virtnet_freeze_down(struct virtio_device *vdev)
> 
> A more robust way to do this is to remove the #ifdef around the callers
> and instead mark them as __maybe_unused. The compiler will now just
> silently drop the unused code.
> 
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
