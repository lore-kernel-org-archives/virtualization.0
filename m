From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC v4 5/5] virtio_ring: enable packed ring
Date: Wed, 16 May 2018 13:15:48 +0300
Message-ID: <27dfb4e8-6d63-bf7d-0f97-ac51559f8040@cogentembedded.com>
References: <20180516083737.26504-1-tiwei.bie@intel.com>
	<20180516083737.26504-6-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180516083737.26504-6-tiwei.bie@intel.com>
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
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 5/16/2018 11:37 AM, Tiwei Bie wrote:

> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>   drivers/virtio/virtio_ring.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index de3839f3621a..b158692263b0 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1940,6 +1940,8 @@ void vring_transport_features(struct virtio_device *vdev)
>   			break;
>   		case VIRTIO_F_IOMMU_PLATFORM:
>   			break;
> +		case VIRTIO_F_RING_PACKED:
> +			break;

    Why not just add this *case* under the previous *case*?

>    		default:
>   			/* We don't understand this bit. */
>   			__virtio_clear_bit(vdev, i);

MBR, Sergei
