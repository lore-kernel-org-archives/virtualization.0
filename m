From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v8 0/7] net: vhost: improve performance when
	enable busyloop
Date: Mon, 20 Aug 2018 23:34:10 +0300
Message-ID: <20180820233340-mutt-send-email-mst__10029.6818688095$1534797132$gmane$org@kernel.org>
References: <1534680686-3108-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1534680686-3108-1-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xiangxia.m.yue@gmail.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Aug 19, 2018 at 05:11:19AM -0700, xiangxia.m.yue@gmail.com wrote:
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> This patches improve the guest receive performance.
> On the handle_tx side, we poll the sock receive queue
> at the same time. handle_rx do that in the same way.
> 
> For more performance report, see patch 4, 6, 7


Thanks for the patches. I'm traveling this week,
will do my best to review next week.

> Tonghao Zhang (7):
>   net: vhost: lock the vqs one by one
>   net: vhost: replace magic number of lock annotation
>   net: vhost: factor out busy polling logic to vhost_net_busy_poll()
>   net: vhost: add rx busy polling in tx path
>   net: vhost: introduce bitmap for vhost_poll
>   net: vhost: disable rx wakeup during tx busypoll
>   net: vhost: make busyloop_intr more accurate
> 
>  drivers/vhost/net.c   | 169 +++++++++++++++++++++++++++++++-------------------
>  drivers/vhost/vhost.c |  41 ++++++------
>  drivers/vhost/vhost.h |   7 ++-
>  3 files changed, 133 insertions(+), 84 deletions(-)
> 
> -- 
> 1.8.3.1
