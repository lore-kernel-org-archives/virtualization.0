From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] virtio_blk: Dont waste major numbers
Date: Thu, 20 Mar 2008 10:38:31 -0700
Message-ID: <47E2A117.4090607__10686.2587076195$1206035119$gmane$org@zytor.com>
References: <200801311553.53653.borntraeger__25311.9055800655$1201791369$gmane$org@de.ibm.com>
	<47A242B1.40709@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47A242B1.40709@codemonkey.ws>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
> Christian Borntraeger wrote:
>> Rusty,
>>
>> currently virtio_blk uses one major number per device. While this works
>> quite well on most systems it is wasteful and will exhaust major numbers
>> on larger installations.
>>
>> This patch allocates a major number on init and will use 16 minor numbers
>> for each disk. That will allow ~64k virtio_blk disks.
>>
> 
> There's are some other limitations to the number of virtio block 
> devices.  For instances...
> 
>>      sprintf(vblk->disk->disk_name, "vd%c", virtblk_index++);
> 
> This gets bogus after 64 disks.  We also have a hard limit for 
> virtio-pci based on the number of PCI slots available.  One thing I was 
> considering was whether we should try to support multiple disks per 
> virtio device.
> 

I would much rather prefer a /dev/vd/dXpY naming scheme, similar to 
cciss and other large disk installations.

Unfortunately yet another side effect of people not habitually 
registering major numbers is that the namespace is not as well maintained.

	-hpa
