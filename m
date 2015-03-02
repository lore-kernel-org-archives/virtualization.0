From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/2] virtio: add modern config accessors
Date: Mon, 2 Mar 2015 12:55:32 +0100
Message-ID: <20150302125532.5d4ee026.cornelia.huck@de.ibm.com>
References: <1425296404-12903-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1425296404-12903-1-git-send-email-mst@redhat.com>
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
Cc: qemu-devel@nongnu.org, Anthony Liguori <aliguori@amazon.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2 Mar 2015 12:40:25 +0100
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtio 1.0 defines config space as LE,
> as opposed to pre-1.0 which was native endian.
> 
> Add API for transports to execute word/dword accesses in
> little endian format - will be useful for mmio
> and pci (byte access is also wrapped, for completeness).
> 
> For simplicity, we still keep config in host native
> endian format, byteswap to LE on guest access.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/virtio/virtio.h |  6 +++
>  hw/virtio/virtio.c         | 93 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)

One could also imagine making the accessors dependant on whether the
provided virtio device is standard compliant, but as mmio will probably
register different MemoryRegionOps for v1.0 devices as well, this
should work out nicer this way.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
