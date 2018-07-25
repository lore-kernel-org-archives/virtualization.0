From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 0/6] virtio_net: Add ethtool stat items
Date: Wed, 25 Jul 2018 12:40:12 +0300
Message-ID: <20180725123908-mutt-send-email-mst__40165.1287837469$1532511497$gmane$org@kernel.org>
References: <20180723143609.2242-1-toshiaki.makita1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180723143609.2242-1-toshiaki.makita1@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Toshiaki Makita <toshiaki.makita1@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 23, 2018 at 11:36:03PM +0900, Toshiaki Makita wrote:
> From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> 
> Add some ethtool stat items useful for performance analysis.
> 
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

Series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Patch 1 seems appropriate for stable, even though it's minor.

> Toshiaki Makita (6):
>   virtio_net: Fix incosistent received bytes counter
>   virtio_net: Use temporary storage for accounting rx stats
>   virtio_net: Make drop counter per-queue
>   virtio_net: Factor out the logic to determine xdp sq
>   virtio_net: Add XDP related stats
>   virtio_net: Add kick stats
> 
>  drivers/net/virtio_net.c | 221 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 158 insertions(+), 63 deletions(-)
> 
> -- 
> 2.14.3
