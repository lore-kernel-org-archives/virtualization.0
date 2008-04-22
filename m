From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH] virtio: change config to guest endian.
Date: Tue, 22 Apr 2008 09:44:08 +0200
Message-ID: <200804220944.08568.borntraeger__9498.18567974052$1208850468$gmane$org@de.ibm.com>
References: <200804221357.34571.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804221357.34571.rusty@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Hollis Blanchard <hollisb@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag, 22. April 2008 schrieb Rusty Russell:
> [Christian, Hollis, how much is this ABI breakage going to hurt you?]

It is ok for s390 at the moment. We are still working on making userspace 
ready and I plan to change the guest<->host for s390 anyway. I try to make 
these changes for drivers/s390/kvm/kvm_virtio.c before 2.6.26. The main 
reason is, that we are currently limited to around 80 devices. I am not sure, 
if I should change the allocation of the virtqueues and descriptors to guest 
memory as well. 

Back to your patch:
I have still some ideas about virtio between little endian and big endian 
systems, but it requires more and different marshalling anyway - even on 
driver level. No idea yet how to solve that properly.

Consider your change
Acked-by: Christian Bornraeger <borntraeger@de.ibm.com>
given that you fix the issue below:

[...]
> --- a/drivers/virtio/virtio_balloon.c	Sun Apr 20 14:41:02 2008 +1000
> +++ b/drivers/virtio/virtio_balloon.c	Sun Apr 20 15:07:45 2008 +1000
> @@ -155,9 +155,9 @@ static inline s64 towards_target(struct 
>  static inline s64 towards_target(struct virtio_balloon *vb)
>  {
>  	u32 v;
> -	__virtio_config_val(vb->vdev,
> -			    offsetof(struct virtio_balloon_config, num_pages),
> -			    &v);
> +	vb->vdev->config->get(vb->vdev,
> +			      offsetof(struct virtio_balloon_config, num_pages),
> +			      &v);

this is missing a sizeof(v), no?

Christian
