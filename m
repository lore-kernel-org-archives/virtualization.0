From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 5/6] kvm-s390: use register_virtio_root_device()
Date: Thu, 11 Dec 2008 10:05:49 +0100
Message-ID: <200812111005.49597.borntraeger__41266.7794655592$1228986569$gmane$org@de.ibm.com>
References: <1228931096.5384.63.camel@blaa>
	<1228931139-12956-4-git-send-email-markmc@redhat.com>
	<1228931139-12956-5-git-send-email-markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1228931139-12956-5-git-send-email-markmc@redhat.com>
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
To: Mark McLoughlin <markmc@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 10. Dezember 2008 schrieb Mark McLoughlin:
> This is basically a no-op change, since it does exactly the
> same thing as s390_root_dev_register() when the caller isn't
> a module.

Ok, I gave it a short test and it seems to work.
Some comments: I agree with your comment in patch0, that a generic 
device_register_root() function might be useful. 

> --- a/drivers/s390/kvm/kvm_virtio.c
> +++ b/drivers/s390/kvm/kvm_virtio.c
[...]
> -	kvm_root = s390_root_dev_register("kvm_s390");
> +	kvm_root = register_virtio_root_device("kvm_s390");
[...]
> -		s390_root_dev_unregister(kvm_root);
> +		unregister_virtio_root_device(kvm_root);

You can now remove the include <asm/s390_rdev.h>
