From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v6 04/46] virtio: add support for 64 bit features.
Date: Fri, 28 Nov 2014 13:47:21 +0100
Message-ID: <20141128134721.5473ebbd.cornelia.huck@de.ibm.com>
References: <1417118789-18231-1-git-send-email-mst@redhat.com>
	<1417118789-18231-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417118789-18231-5-git-send-email-mst@redhat.com>
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
Cc: linux-s390@vger.kernel.org, lguest@lists.ozlabs.org, thuth@linux.vnet.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, rusty@au1.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, Siva Yerramreddy <yshivakrishna@gmail.com>, Joel Stanley <joel@jms.id.au>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 27 Nov 2014 22:07:55 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Change u32 to u64, and use BIT_ULL and 1ULL everywhere.
> 
> Note: transports are unchanged, and only set low 32 bit.
> This guarantees that no transport sets e.g. VERSION_1
> by mistake without proper support.
> 
> Based on patch by Rusty.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio.h                 |  2 +-
>  include/linux/virtio_config.h          | 20 ++++++++++----------
>  tools/virtio/linux/virtio.h            |  2 +-
>  drivers/lguest/lguest_device.c         |  2 +-
>  drivers/misc/mic/card/mic_virtio.c     |  2 +-
>  drivers/remoteproc/remoteproc_virtio.c |  2 +-
>  drivers/s390/kvm/kvm_virtio.c          |  2 +-
>  drivers/s390/kvm/virtio_ccw.c          |  2 +-
>  drivers/virtio/virtio.c                |  8 ++++----
>  drivers/virtio/virtio_mmio.c           |  2 +-
>  drivers/virtio/virtio_pci.c            |  2 +-
>  11 files changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
