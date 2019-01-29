From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_net: Introduce extended RSC feature
Date: Tue, 29 Jan 2019 11:07:47 -0500
Message-ID: <20190129110636-mutt-send-email-mst__6691.69266927696$1548825316$gmane$org@kernel.org>
References: <20190129125236.12165-1-yuri.benditovich@daynix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190129125236.12165-1-yuri.benditovich@daynix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: yan@daynix.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 29, 2019 at 02:52:36PM +0200, Yuri Benditovich wrote:
> VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
> is able to provide extended RSC information. When the feature
> is active and 'gso_type' field in received packet is not GSO_NONE,
> the device reports number of coalesced packets in 'csum_start'
> field and number of duplicated acks in 'csum_offset' field
> and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/uapi/linux/virtio_net.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index a3715a3224c1..93c71d714475 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,7 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> -
> +#define VIRTIO_NET_F_RSC_EXT	  61	/* Provides extended RSC info */
>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
>  					 * with the same MAC.
>  					 */
> @@ -104,6 +104,7 @@ struct virtio_net_config {
>  struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
>  #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
> +#define VIRTIO_NET_HDR_F_RSC_INFO	4   /* rsc_ext data in csum_ fields */
>  	__u8 flags;
>  #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
>  #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
> @@ -140,6 +141,18 @@ struct virtio_net_hdr_mrg_rxbuf {
>  	struct virtio_net_hdr hdr;
>  	__virtio16 num_buffers;	/* Number of merged rx buffers */
>  };
> +
> +static inline __virtio16 *virtio_net_rsc_ext_num_packets(
> +	struct virtio_net_hdr *hdr)
> +{
> +	return &hdr->csum_start;
> +}
> +
> +static inline __virtio16 *virtio_net_rsc_ext_num_dupacks(
> +	struct virtio_net_hdr *hdr)
> +{
> +	return &hdr->csum_offset;
> +}
>  #endif /* ...VIRTIO_NET_NO_LEGACY */

Coding style is off here. But really I don't think these inlines are
needed here. Put them in qemu or something.

>  /*
> -- 
> 2.17.1
