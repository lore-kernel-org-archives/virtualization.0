From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC net-next 0/2] drivers: net: virtio_net: Implement
Date: Mon, 7 Oct 2019 03:43:50 -0400
Message-ID: <20191007034208-mutt-send-email-mst__47791.797823605$1570434249$gmane$org@kernel.org>
References: <20191006184515.23048-1-jcfaracco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191006184515.23048-1-jcfaracco@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jcfaracco@gmail.com
Cc: dnmendes76@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 06, 2019 at 03:45:13PM -0300, jcfaracco@gmail.com wrote:
> From: Julio Faracco <jcfaracco@gmail.com>
> 
> Driver virtio_net is not handling error events for TX provided by 
> dev_watchdog. This event is reached when transmission queue is having 
> problems to transmit packets. To enable it, driver should have 
> .ndo_tx_timeout implemented. This serie has two commits:
> 
> In the past, we implemented a function to recover driver state when this
> kind of event happens, but the structure was to complex for virtio_net
> that moment.

It's more that it was missing a bunch of locks.

> Alternativelly, this skeleton should be enough for now.
>
> For further details, see thread:
> https://lkml.org/lkml/2015/6/23/691
> 
> Patch 1/2:
>   Add statistic field for TX timeout events.
> 
> Patch 2/2:
>   Implement a skeleton function to debug TX timeout events.
> 
> Julio Faracco (2):
>   drivers: net: virtio_net: Add tx_timeout stats field
>   drivers: net: virtio_net: Add tx_timeout function
> 
>  drivers/net/virtio_net.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> -- 
> 2.21.0
