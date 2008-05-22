From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Fwd: [PATCH]: Fix silly output for virtio devices in
	/proc/interrupts]
Date: Thu, 22 May 2008 16:58:44 -0500
Message-ID: <4835EC94.8080508__40465.520686894$1211493639$gmane$org@codemonkey.ws>
References: <48341FE1.4070305@redhat.com>
	<200805222238.58166.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805222238.58166.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Wednesday 21 May 2008 23:13:05 Chris Lalancette wrote:
>   
>> Author: Chris Lalancette <clalance@redhat.com>
>> Date:   Thu May 15 09:04:55 2008 -0400
>>
>>     register_virtio_device was doing something silly, in that it was
>> overwriting what the calling driver stuck into .bus_id" for the name.  This
>> caused problems in the output of /proc/interrupts, since when you
>> request_irq(), it doesn't actually copy the devname you pass in but just
>> stores a pointer to the data.  The fix is to just not have
>> register_virtio_device do anything with the bus_id, and assume the higher
>> level driver set it up properly.
>>     
>
> OK, but only one higher-level driver will set it up properly: kvm.  Neither
> lguest nor s/390 do this, and as a result, they fail to register *any*
> devices.
>
> The following patch should fix it for s/390 (it's identical to the lguest
> patch), but would prefer testing (S/390-ers cc'd).
>   

It may actually be better for virtio to set this up.  The problem is 
that if you have multiple transports that are registering virtio 
devices, it's impossible at the transport level to guarantee uniqueness 
while still using the "virtio%d" naming.  Except the current scheme is 
no good, we'd have to push the dev_index into virtio too.

Regards,

Anthony Liguori

> ===
> virtio: S/390 set name of virtio devices directly.
>
> Chris has a patch 'Fix silly output for virtio devices in /proc/interrupts'
> which requires callers to the virtio driver infrastructure to set the bus_ids
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
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
