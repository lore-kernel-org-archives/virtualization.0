From: Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v6 03/20] virtio: feature bit manipulation helpers
Date: Thu, 11 Dec 2014 15:29:29 +0100
Message-ID: <20141211152929.60145e2d__16993.2205150419$1418310582$gmane$org@oc7435384737.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-4-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 11 Dec 2014 14:25:05 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> Add virtio_{add,clear}_feature helper functions for manipulating a
> feature bits variable. This has some benefits over open coding:
> - add check that the bit is in a sane range
> - make it obvious at a glance what is going on
> - have a central point to change when we want to extend feature bits
> 
> Convert existing code manipulating features to use the new helpers.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/9pfs/virtio-9p-device.c  |    2 +-
>  hw/block/virtio-blk.c       |   16 ++++++++--------
>  hw/char/virtio-serial-bus.c |    2 +-
>  hw/net/virtio-net.c         |   34 +++++++++++++++++-----------------
>  hw/s390x/virtio-ccw.c       |    4 ++--
>  hw/virtio/virtio-mmio.c     |    2 +-
>  hw/virtio/virtio-pci.c      |    4 ++--
>  include/hw/virtio/virtio.h  |   12 ++++++++++++
>  8 files changed, 44 insertions(+), 32 deletions(-)

Patch looks fine to me.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
