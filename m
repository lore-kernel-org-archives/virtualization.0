From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] virtio_blk: Dont waste major numbers
Date: Thu, 31 Jan 2008 15:50:41 -0600
Message-ID: <47A242B1.40709__21672.1276323826$1201816496$gmane$org@codemonkey.ws>
References: <200801311553.53653.borntraeger__25311.9055800655$1201791369$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801311553.53653.borntraeger__25311.9055800655$1201791369$gmane$org@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> Rusty,
> 
> currently virtio_blk uses one major number per device. While this works
> quite well on most systems it is wasteful and will exhaust major numbers
> on larger installations.
> 
> This patch allocates a major number on init and will use 16 minor numbers
> for each disk. That will allow ~64k virtio_blk disks.
>

There's are some other limitations to the number of virtio block 
devices.  For instances...

>  	sprintf(vblk->disk->disk_name, "vd%c", virtblk_index++);

This gets bogus after 64 disks.  We also have a hard limit for 
virtio-pci based on the number of PCI slots available.  One thing I was 
considering was whether we should try to support multiple disks per 
virtio device.

Otherwise, this patch looks good to me.

Regards,

Anthony Liguori
