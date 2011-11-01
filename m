From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL] virtio
Date: Tue, 1 Nov 2011 13:45:42 +0200
Message-ID: <20111101114542.GA13434@redhat.com>
References: <87wrbkvh3v.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wrbkvh3v.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Wang Sheng-Hui <shhuiw@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Amit Shah <amit.shah@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 01, 2011 at 10:39:08AM +1030, Rusty Russell wrote:
>  * [new tag]         rusty@rustcorp.com.au-v3.1-7196-gac5be1e -> rusty@rustcorp.com.au-v3.1-7196-gac5be1e
> 
> The following changes since commit 839d8810747bbf39e0a5a7f223b67bffa7945f8d:
> 
>   Merge branch 'i2c-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging (2011-10-30 15:54:59 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/rustyrussell/linux.git master
> 
> Alexey Kardashevskiy (1):
>       virtio-pci: Use PCI MMIO instead of PIO when available

I missed this one - wasn't Cc'd neither me, kvm or virtio mailing lists.

It's well known that mmio is much slower than pio on kvm, since
mmio needs to be emulated to get at the address.
So I'm expecting this will cause a performance regression.
IMO we should keep using PIO for VQ and interrupt status access
if PIO is available.

Another consideration is that in an attempt to pack data
densely in the PIO space the layout became messy.
It would be better to have common config space and
per-device config space in separate pages, possibly
with padding between them.

So I'd like a bit more discussion on this patch,
I'm concerned that if this is released in 3.2 as is we'll
have to support this forever. How about a revert for now?


> Amit Shah (8):
>       virtio: console: Fix indentation
>       virtio: console: Ignore port name update request if name already set
>       virtio: console: Use wait_event_freezable instead of _interruptible
>       virtio: console: Fix return type for get_inbuf()
>       virtio: console: make get_inbuf() return port->inbuf if present
>       virtio: console: rename variable
>       virtio: console: make discard_port_data() use get_inbuf()
>       virtio: console: add port stats for bytes received, sent and discarded
> 
> Christian Borntraeger (1):
>       virtio: console: wait for first console port for early console output
> 
> Krishna Kumar (1):
>       virtio: Dont add "config" to list for !per_vq_vector
> 
> Michael S. Tsirkin (1):
>       virtio-blk: use ida to allocate disk index
> 
> Pawel Moll (1):
>       virtio: Add platform bus driver for memory mapped virtio device
> 
> Sasha Levin (3):
>       virtio-console: Use virtio_config_val() for retrieving config
>       virtio_config: Add virtio_config_val_len()
>       virtio-net: Use virtio_config_val() for retrieving config
> 
> Wang Sheng-Hui (2):
>       virtio.h: correct comment for struct virtio_driver
>       virtio: modify vring_init and vring_size to take account of the layout containing *_event_idx
> 
>  Documentation/devicetree/bindings/virtio/mmio.txt |   17 +
>  drivers/block/virtio_blk.c                        |   30 +-
>  drivers/char/virtio_console.c                     |  120 ++++--
>  drivers/net/virtio_net.c                          |   14 +-
>  drivers/virtio/Kconfig                            |   11 +
>  drivers/virtio/Makefile                           |    1 +
>  drivers/virtio/virtio_mmio.c                      |  479 +++++++++++++++++++++
>  drivers/virtio/virtio_pci.c                       |   20 +-
>  include/linux/virtio.h                            |    4 +-
>  include/linux/virtio_config.h                     |    3 +
>  include/linux/virtio_mmio.h                       |  111 +++++
>  include/linux/virtio_ring.h                       |    6 +-
>  12 files changed, 749 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/virtio/mmio.txt
>  create mode 100644 drivers/virtio/virtio_mmio.c
>  create mode 100644 include/linux/virtio_mmio.h
