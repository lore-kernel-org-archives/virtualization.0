From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH net-next v9 1/3] netdev: pass the stuck queue to the
 timeout handler
Date: Mon, 9 Dec 2019 12:34:40 -0700
Message-ID: <20191209193440.GA15189__43023.1412335829$1575920097$gmane$org@ubuntu-m2-xlarge-x86>
References: <20191209162727.10113-1-mst@redhat.com>
 <20191209162727.10113-2-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191209162727.10113-2-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: dnmendes76@gmail.com, Jakub Kicinski <jakub.kicinski@netronome.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, clang-built-linux@googlegroups.com, Martin Habets <mhabets@solarflare.com>, Julio Faracco <jcfaracco@gmail.com>, Shannon Nelson <snelson@pensando.io>, davem@davemloft.net, Heiner Kallweit <hkallweit1@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

On Mon, Dec 09, 2019 at 11:29:03AM -0500, Michael S. Tsirkin wrote:
> This allows incrementing the correct timeout statistic without any mess.
> Down the road, devices can learn to reset just the specific queue.
> 
> The patch was generated with the following script:
> 
<snip>
> 
> where the list of files and functions is simply from:
> 
> git grep ndo_tx_timeout, with manual addition of headers
> in the rare cases where the function is from a header,
> then manually changing the few places which actually
> call ndo_tx_timeout.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Heiner Kallweit <hkallweit1@gmail.com>
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Acked-by: Shannon Nelson <snelson@pensando.io>
> Reviewed-by: Martin Habets <mhabets@solarflare.com>
> 
> changes from v8:
> 	fix up a missing direct call to timeout
> 	rebased on net-next
> changes from v7:
> 	fixup leftovers from v3 change
> changes from v6:
> 	fix typo in rtl driver
> changes from v5:
> 	add missing files (allow any net device argument name)
> changes from v4:
> 	add a missing driver header
> changes from v3:
>         change queue # to unsigned
> Changes from v2:
>         added headers
> Changes from v1:
>         Fix errors found by kbuild:
>         generalize the pattern a bit, to pick up
>         a couple of instances missed by the previous
>         version.
> ---
<snip>
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index 6a9d12dad5d9..ad0ecebb1b34 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -288,7 +288,7 @@ static int dpaa_stop(struct net_device *net_dev)
>  	return err;
>  }
>  
> -static void dpaa_tx_timeout(struct net_device *net_dev)
> +static void dpaa_tx_timeout(struct net_device *net_dev, int txqueue)

This needs to be unsigned int, otherwise there is a build error:

../drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:2622:20: error: incompatible pointer types initializing 'void (*)(struct net_device *, unsigned int)' with an expression of type 'void (struct net_device *, int)' [-Werror,-Wincompatible-pointer-types]
        .ndo_tx_timeout = dpaa_tx_timeout,
                          ^~~~~~~~~~~~~~~
1 error generated.

Cheers,
Nathan
