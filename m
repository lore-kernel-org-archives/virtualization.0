From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] virtio: mark vring_dma_dev() static
Date: Thu, 01 Sep 2016 13:16:12 +0200
Message-ID: <5461726.tCKanM7eMs@wuerfel>
References: <1472727777-4695-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1472727777-4695-1-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, xie.baoyou@zte.com.cn, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thursday, September 1, 2016 7:02:57 PM CEST Baoyou Xie wrote:
> We get 1 warning when building kernel with W=1:
> drivers/virtio/virtio_ring.c:170:16: warning: no previous prototype for 'vring_dma_dev' [-Wmissing-prototypes]
> 
> In fact, this function is only used in the file in which it is
> declared and don't need a declaration, but can be made static.
> so this patch marks this function with 'static'.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
