From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 4/5] tun: Add support for SCTP checksum offload
Date: Mon, 16 Apr 2018 20:12:03 +0300
Message-ID: <20180416201004-mutt-send-email-mst__36778.3341477208$1523898630$gmane$org@kernel.org>
References: <20180402134006.10111-1-vyasevic@redhat.com>
	<20180402134006.10111-5-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180402134006.10111-5-vyasevic@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vladislav Yasevich <vyasevich@gmail.com>
Cc: nhorman@tuxdriver.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sctp@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 02, 2018 at 09:40:05AM -0400, Vladislav Yasevich wrote:
> Adds a new tun offload flag to allow for SCTP checksum offload.
> The flag has to be set by the user and defaults to "no offload".
> 
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>

When would user set this flag? Wouldn't that be when
userspace is ready to get SCTP packets without a checksum?
Seems to be this is an indication that when userspace
is qemu running a guest, said guest needs to communicate
the new ability to qemu.

> ---
>  drivers/net/tun.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index a1ba262..263bcbe 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2719,6 +2719,11 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
>  		arg &= ~TUN_F_UFO;
>  	}
>  
> +	if (arg & TUN_F_SCTP_CSUM) {
> +		features |= NETIF_F_SCTP_CRC;
> +		arg &= ~TUN_F_SCTP_CSUM;
> +	}
> +
>  	/* This gives the user a way to test for new features in future by
>  	 * trying to set them. */
>  	if (arg)
> -- 
> 2.9.5
