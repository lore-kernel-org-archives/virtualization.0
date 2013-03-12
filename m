From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH V2 WIP 2/2] vhost-scsi: new device supporting the
	tcm_vhost Linux kernel module
Date: Tue, 12 Mar 2013 09:20:24 +0100
Message-ID: <20130312082024.GA18112__26970.7529493191$1363076457$gmane$org@stefanha-thinkpad.redhat.com>
References: <1363069782-10735-1-git-send-email-asias@redhat.com>
	<1363069782-10735-3-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363069782-10735-3-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 12, 2013 at 02:29:42PM +0800, Asias He wrote:
> diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
> index 39c1966..4a97ca1 100644
> --- a/hw/virtio-pci.c
> +++ b/hw/virtio-pci.c

These changes break the build for non-Linux hosts.  Please introduce a
CONFIG_VHOST_SCSI and #ifdef appropriate sections in hw/virtio-pci.c.

CONFIG_VIRTFS does the same thing.

> +static Property vhost_scsi_properties[] = {
> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),

This flag makes QEMU's virtqueue handling use ioeventfd.  Since the
vhost-scsi.c takes over the guest/host notifiers, we never do QEMU
virtqueue processing and the "ioeventfd" flag has no real meaning.  You
can drop it.
