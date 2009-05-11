From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH RFC 0/2] qemu-kvm: MSI-X support
Date: Mon, 11 May 2009 17:24:25 -0500
Message-ID: <4A08A599.1070708__27019.9536033489$1242081134$gmane$org@codemonkey.ws>
References: <20090511221350.GA22776@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090511221350.GA22776@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> Here's a draft MSI-X support patch. Among missing features:
> save/load support, and command-line flag to control the
> feature. This is on top of qemu-kvm: msi-x is disabled
> without kvm interrupt injection support for now.
>   

What's your impression of how much work would be to get this going on 
top of upstream QEMU?

I'm willing to borrow a few cycles to help out here.  I'd really like to 
see this series go in via QEMU if possible.

Regards,

Anthony Liguori

> Michael S. Tsirkin (2):
>   qemu-kvm: add MSI-X support
>   qemu-kvm: use common code for assigned msix
>
>  Makefile.target        |    2 +-
>  hw/device-assignment.c |  336 +++++++++++---------------------------------
>  hw/device-assignment.h |    8 +-
>  hw/msix.c              |  371 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/msix.h              |   33 +++++
>  hw/pci.c               |   35 ++++--
>  hw/pci.h               |   57 +++++++-
>  hw/virtio-balloon.c    |    2 +-
>  hw/virtio-blk.c        |    3 +-
>  hw/virtio-console.c    |    3 +-
>  hw/virtio-net.c        |    3 +-
>  hw/virtio.c            |  167 +++++++++++++++++-----
>  hw/virtio.h            |    4 +-
>  13 files changed, 709 insertions(+), 315 deletions(-)
>  create mode 100644 hw/msix.c
>  create mode 100644 hw/msix.h
>   
