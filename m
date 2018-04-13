From: Jonathan Helman <jonathan.helman@oracle.com>
Subject: Re: [PATCH] virtio_balloon: add array of stat names
Date: Fri, 13 Apr 2018 11:53:31 -0700
Message-ID: <8ac55da5-3c2b-a546-7597-ec6c82ff9590__44868.2283437394$1523645516$gmane$org@oracle.com>
References: <1523627031-370966-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1523627031-370966-1-git-send-email-mst@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 04/13/2018 06:44 AM, Michael S. Tsirkin wrote:
> Jason Wang points out that it's vary hard for users to build an array of

s/vary/very

> stat names. The naive thing is to use VIRTIO_BALLOON_S_NR but that
> breaks if we add more stats.
> 
> Let's add an array of reasonably readable names.

Thanks for doing this, this is goodness. Clients of this interface will 
now only require a modification to their internal copy of the header 
file (if they have one), rather than updating their string array as well.

> 
> Fixes: 6c64fe7f2 ("virtio_balloon: export hugetlb page allocation counts")

I think this is a tad bit confusing since the only way you'd know why 
this patch "fixes" 6c64fe7f2 is by reading the LKML archives and finding 
Jason's comment.

> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Jonathan Helman <jonathan.helman@oracle.com>, > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Jonathan Helman <jonathan.helman@oracle.com>

> ---
>   include/uapi/linux/virtio_balloon.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 9e02137..1477c17 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -64,6 +64,21 @@ struct virtio_balloon_config {
>   #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
>   #define VIRTIO_BALLOON_S_NR       10
>   
> +#define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
> +	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "swap-out", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "major-faults", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "minor-faults", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "free-memory", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "total-memory", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \ > +}
> +
> +#define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
> +
>   /*
>    * Memory statistics structure.
>    * Driver fills an array of these structures and passes to device.
> 
