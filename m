From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [RFC v4 5/5] virtio_ring: enable packed ring
Date: Wed, 16 May 2018 18:21:59 +0800
Message-ID: <20180516102159.GA11467__18232.6722344898$1526465993$gmane$org@debian>
References: <20180516083737.26504-1-tiwei.bie@intel.com>
	<20180516083737.26504-6-tiwei.bie@intel.com>
	<27dfb4e8-6d63-bf7d-0f97-ac51559f8040@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <27dfb4e8-6d63-bf7d-0f97-ac51559f8040@cogentembedded.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 16, 2018 at 01:15:48PM +0300, Sergei Shtylyov wrote:
> On 5/16/2018 11:37 AM, Tiwei Bie wrote:
> 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> >   drivers/virtio/virtio_ring.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index de3839f3621a..b158692263b0 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1940,6 +1940,8 @@ void vring_transport_features(struct virtio_device *vdev)
> >   			break;
> >   		case VIRTIO_F_IOMMU_PLATFORM:
> >   			break;
> > +		case VIRTIO_F_RING_PACKED:
> > +			break;
> 
>    Why not just add this *case* under the previous *case*?

Do you mean fallthrough? Something like:

		case VIRTIO_F_IOMMU_PLATFORM:
		case VIRTIO_F_RING_PACKED:
			break;

Best regards,
Tiwei Bie

> 
> >    		default:
> >   			/* We don't understand this bit. */
> >   			__virtio_clear_bit(vdev, i);
> 
> MBR, Sergei
