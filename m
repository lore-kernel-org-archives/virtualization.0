From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio_blk: Dont waste major numbers
Date: Fri, 1 Feb 2008 08:33:51 +0100
Message-ID: <200802010833.51809.borntraeger__18361.8700052195$1201851367$gmane$org@de.ibm.com>
References: <200801311553.53653.borntraeger__25311.9055800655$1201791369$gmane$org@de.ibm.com>
	<47A242B1.40709@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47A242B1.40709@codemonkey.ws>
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
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 31. Januar 2008 schrieb Anthony Liguori:
> There's are some other limitations to the number of virtio block 
> devices.  For instances...
> 
> >  	sprintf(vblk->disk->disk_name, "vd%c", virtblk_index++);
> 
> This gets bogus after 64 disks.  

Right. I will fix that with an additional patch.

> We also have a hard limit for  
> virtio-pci based on the number of PCI slots available.  One thing I was 
> considering was whether we should try to support multiple disks per 
> virtio device.

What is the hard limit in the PCI name space?


Christian
