From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [Fwd: [PATCH]: Fix silly output for virtio devices in
	/proc/interrupts]
Date: Thu, 22 May 2008 15:38:13 +0200
Message-ID: <200805221538.13898.borntraeger__2417.71673686362$1211463720$gmane$org@de.ibm.com>
References: <48341FE1.4070305@redhat.com>
	<200805222238.58166.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805222238.58166.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 22. Mai 2008 schrieb Rusty Russell:

> virtio: S/390 set name of virtio devices directly.
> 
> Chris has a patch 'Fix silly output for virtio devices in /proc/interrupts'
> which requires callers to the virtio driver infrastructure to set the 
bus_ids
> themselves.  This does that for s/390.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Carsten Otte <cotte@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Chris Lalancette <clalance@redhat.com>
> ---
>  drivers/s390/kvm/kvm_virtio.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -r c903ef6b391f drivers/s390/kvm/kvm_virtio.c
> --- a/drivers/s390/kvm/kvm_virtio.c	Thu May 22 22:31:31 2008 +1000
> +++ b/drivers/s390/kvm/kvm_virtio.c	Thu May 22 22:32:55 2008 +1000
> @@ -265,6 +265,8 @@ static void add_kvm_device(struct kvm_de
>  
>  	kdev->vdev.dev.parent = &kvm_root;
>  	kdev->vdev.index = dev_index++;
> +	snprintf(kdev->vdev.dev.bus_id, BUS_ID_SIZE, "virtio%d",
> +		 kdev->vdev.index);
>  	kdev->vdev.id.device = d->type;
>  	kdev->vdev.config = &kvm_vq_configspace_ops;
>  	kdev->desc = d;
> 
> 

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

This will probably create a fuzzy hunk with another patch from Cornelia Huck 
(CCed) which will be send to Gregs tree soon. This patch converts kvm_root to 
dynamic allocation, but the fuzz will be easy to fix.

Christian
