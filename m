From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 05/46] virtio: assert 32 bit features in transports
Date: Fri, 28 Nov 2014 09:54:36 +0100
Message-ID: <20141128095436.20c59e84@thinkpad-w530>
References: <1417118789-18231-1-git-send-email-mst@redhat.com>
	<1417118789-18231-6-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417118789-18231-6-git-send-email-mst@redhat.com>
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
Cc: linux-s390@vger.kernel.org, lguest@lists.ozlabs.org, thuth@linux.vnet.ibm.com, rusty@au1.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Sudeep Dutt <sudeep.dutt@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Siva Yerramreddy <yshivakrishna@gmail.com>, linux390@de.ibm.com, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

> At this point, no transports set any of the high 32 feature bits.
> Since transports generally can't (yet) cope with such bits, add BUG_ON
> checks to make sure they are not set by mistake.
> 
> Based on rproc patch by Rusty.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/lguest/lguest_device.c         | 3 +++
>  drivers/misc/mic/card/mic_virtio.c     | 3 +++
>  drivers/remoteproc/remoteproc_virtio.c | 3 +++
>  drivers/s390/kvm/kvm_virtio.c          | 3 +++
>  drivers/s390/kvm/virtio_ccw.c          | 3 +++
>  drivers/virtio/virtio_mmio.c           | 3 +++
>  drivers/virtio/virtio_pci.c            | 3 +++
>  7 files changed, 21 insertions(+)
> 

Looks sane to me.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
