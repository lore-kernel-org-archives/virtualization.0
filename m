From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/6] virtio 1.0 fixups, tweaks
Date: Fri, 19 Dec 2014 11:56:54 +1030
Message-ID: <87sigcsa3l.fsf@rustcorp.com.au>
References: <1418678575-31755-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418678575-31755-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> Fixes a couple of minor compliance issues in new virtio 1.0 code.
> Plus, adds a couple of minor cleanups - not bugfixes,
> but seem safe enough for 3.19.

OK, I've applied these.

Thanks,
Rusty.

> Michael S. Tsirkin (6):
>   virtio: set VIRTIO_CONFIG_S_FEATURES_OK on restore
>   virtio_config: fix virtio_cread_bytes
>   virtio_pci_common.h: drop VIRTIO_PCI_NO_LEGACY
>   virtio_pci: move probe to common file
>   virtio_pci: add VIRTIO_PCI_NO_LEGACY
>   virtio: core support for config generation
>
>  drivers/virtio/virtio_pci_common.h |  7 +++----
>  include/linux/virtio_config.h      | 29 ++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_pci.h    | 15 ++++++++++-----
>  drivers/virtio/virtio.c            | 37 +++++++++++++++++++++++--------------
>  drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++++++-
>  drivers/virtio/virtio_pci_legacy.c | 24 ++----------------------
>  6 files changed, 99 insertions(+), 47 deletions(-)
>
> -- 
> MST
