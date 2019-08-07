From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/4] virtio: Add definitions for shared memory regions
Date: Wed, 7 Aug 2019 14:20:55 +0100
Message-ID: <20190807132055.GB32432@stefanha-x1.localdomain>
References: <20190725175044.29303-1-dgilbert@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190725175044.29303-1-dgilbert@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: mst@redhat.com, sebastien.boeuf@intel.com, vgoyal@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 25, 2019 at 06:50:40PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add the virtio shared memory region definitions that
> have just got merged into the spec.
> 
> Dr. David Alan Gilbert (4):
>   virtio_pci: Define id field
>   virtio_pci: Define virtio_pci_cap64
>   virtio_pci: Defined shared memory capability
>   virito_mmio: Define shared memory region registers
> 
>  include/uapi/linux/virtio_mmio.h | 11 +++++++++++
>  include/uapi/linux/virtio_pci.h  | 11 ++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> -- 
> 2.21.0
> 

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
