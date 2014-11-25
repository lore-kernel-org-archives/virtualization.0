From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 04/42] virtio: disable virtio 1.0 in transports
Date: Tue, 25 Nov 2014 18:29:42 +0100
Message-ID: <20141125182942.3890fe7b.cornelia.huck@de.ibm.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1416933600-21398-5-git-send-email-mst@redhat.com>
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
Cc: linux-s390@vger.kernel.org, lguest@lists.ozlabs.org, Pawel Moll <pawel.moll@arm.com>, rusty@au1.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Siva Yerramreddy <yshivakrishna@gmail.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Nov 2014 18:41:35 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> disable virtio 1.0 in transports that don't
> support it yet.

I'd prefer if you disabled it for _every_ transport in this patch,
until the needed infrastructure is in place. Else this is a bit
confusing.

> We will gradually re-enable as support is added.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/lguest/lguest_device.c     | 3 ++-
>  drivers/misc/mic/card/mic_virtio.c | 2 ++
>  drivers/s390/kvm/virtio_ccw.c      | 3 ++-
>  drivers/virtio/virtio_mmio.c       | 2 ++
>  4 files changed, 8 insertions(+), 2 deletions(-)

Why do you disable ccw but not pci? (Doesn't pci need any changes
transport-side?) And you missed the old s390 virtio transport in
drivers/s390/kvm/kvm_virtio.c :)

> diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> index abba04d..08536f0 100644
> --- a/drivers/s390/kvm/virtio_ccw.c
> +++ b/drivers/s390/kvm/virtio_ccw.c
> @@ -704,7 +704,8 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
>  out_free:
>  	kfree(features);
>  	kfree(ccw);
> -	return rc;
> +	/* TODO: enable virtio 1.0 */
> +	return rc & ~BIT_ULL(VIRTIO_F_VERSION_1);;

double ';'

FWIW, as negotiating a revision >= 1 is a pre-req for virtio 1.0
support on ccw, virtio 1.0 is already implicitly disabled.

>  }
> 
>  static void virtio_ccw_finalize_features(struct virtio_device *vdev)
