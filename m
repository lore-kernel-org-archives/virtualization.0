From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v5 14/19] s390x/virtio-ccw: enable virtio 1.0
Date: Tue, 9 Dec 2014 18:24:42 +0100
Message-ID: <20141209182442.6824a615.cornelia.huck__35281.7068146125$1418145908$gmane$org@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417525227-14051-15-git-send-email-cornelia.huck@de.ibm.com>
	<20141209134646.GA6897@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141209134646.GA6897@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 9 Dec 2014 15:46:46 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Dec 02, 2014 at 02:00:22PM +0100, Cornelia Huck wrote:
> > virtio-ccw should now have everything in place to operate virtio 1.0
> > devices, so let's enable revision 1.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Looks like this will allow revision 1 for all devices,
> we only want this for virtio 1 devices.
> 
> The following should fix it I think:
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> 

> @@ -104,6 +101,12 @@ struct VirtioCcwDevice {
>      uint64_t ind_bit;
>  };
> 
> +/* The maximum virtio revision we support. */
> +static int virtio_ccw_rev_max(VirtioCcwDevice *dev)

Make this "static inline int" and I'm fine with this :)

> +{
> +        return dev->host_features & (1ULL << VIRTIO_F_VERSION_1) ? 1 : 0;
> +}
> +
>  /* virtual css bus type */
>  typedef struct VirtualCssBus {
>      BusState parent_obj;
