From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 3/8] macvtap: introduce macvtap_is_little_endian()
	helper
Date: Thu, 23 Apr 2015 20:59:25 +0200
Message-ID: <20150423205925.5bd803a3__47.5772460506008$1429896763$gmane$org@thh440s>
References: <20150423152608.11795.4373.stgit@bahia.local>
	<20150423152638.11795.37818.stgit@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150423152638.11795.37818.stgit@bahia.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 23 Apr 2015 17:26:41 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  drivers/net/macvtap.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
> index 27ecc5c..a2f2958 100644
> --- a/drivers/net/macvtap.c
> +++ b/drivers/net/macvtap.c
> @@ -49,14 +49,19 @@ struct macvtap_queue {
>  
>  #define MACVTAP_VNET_LE 0x80000000
>  
> +static inline bool macvtap_is_little_endian(struct macvtap_queue *q)
> +{
> +	return q->flags & MACVTAP_VNET_LE;
> +}
> +
>  static inline u16 macvtap16_to_cpu(struct macvtap_queue *q, __virtio16 val)
>  {
> -	return __virtio16_to_cpu(q->flags & MACVTAP_VNET_LE, val);
> +	return __virtio16_to_cpu(macvtap_is_little_endian(q), val);
>  }
>  
>  static inline __virtio16 cpu_to_macvtap16(struct macvtap_queue *q, u16 val)
>  {
> -	return __cpu_to_virtio16(q->flags & MACVTAP_VNET_LE, val);
> +	return __cpu_to_virtio16(macvtap_is_little_endian(q), val);
>  }

Reviewed-by: Thomas Huth <thuth@redhat.com>
