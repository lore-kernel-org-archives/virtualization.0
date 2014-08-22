From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [V9fs-developer] [Qemu-devel] QEMU dies on any attempt to load
	a Linux kernel module when using a 9P rootfs
Date: Fri, 22 Aug 2014 13:54:14 -0400
Message-ID: <53F783C6.2030409@codeaurora.org>
References: <5293718E.4090508@gentoo.org> <53F64DA2.3060308@codeaurora.org>
	<20140822062744.GA12382@u-barrelet>
	<53F739A0.4070106@codeaurora.org>
	<20140822124906.GA13229@u-galfione>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140822124906.GA13229@u-galfione>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Richard Yao <ryao@gentoo.org>, qemu-devel@nongnu.org, kernel@gentoo.org, v9fs-developer@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Dominique,

On 08/22/2014 08:49 AM, Dominique Martinet wrote:
> Hi,
> 
> Christopher Covington wrote on Fri, Aug 22, 2014 at 08:37:52AM -0400:
>> Thanks for the pointer to this patch. I think I started this kernel half way
>> through the 3.16 merge window. The last non-cherry-picked patch I have is:
>>
>> commit 6d87c225f5d82d29243dc124f1ffcbb0e14ec358
>>
>> So I do have the change you pointed out. Nevertheless, I'll reconfirm with the
>> latest torvalds/master.
> 
> Right, so you already do have it. I don't think there's been anything
> else 9P related recently, so it probably will not help much -- sorry for
> blindly assuming it would be this.
> 
> Actually reading the error message now, "no channels available" is
> printed when virtio doesn't find any match in device name so it would
> look like the mount name doesn't match maybe?
> 
> Could we get your exact qemu command line to confirm? (the name that
> needs to match is /dev/root here, used for booting as root= and for qemu
> as mount_tag)

I re-transposed Richard's command line to my environment and it worked. Thanks
for pointing me in that direction. For the record, I used:

$dir/bin/x86_64-linux-gnu/qemu-system-x86_64 \
  -m 1024 \
  -kernel $dir/boot/x86_64-linux-gnu/bzImage-x86_64 \
  -append 'root=/dev/root init=/sbin/x86_64-linux-gnu/init rootfstype=9p
rootflags=trans=virtio,version=9p2000.L ro console=ttyS0' \
  -serial stdio \
  -fsdev local,id=root,path=$dir,security_model=none \
  -device virtio-9p-pci,fsdev=root,mount_tag=/dev/root \
  -monitor none

$dir/bin/x86_64-linux-gnu/qemu-system-arm \
  -M virt \
  -cpu cortex-a15 \
  -m 1024 \
  -kernel $dir/boot/arm-linux-gnueabihf/Image \
  -append 'root=/dev/root init=/sbin/arm-linux-gnueabihf/init rootfstype=9p
rootflags=trans=virtio,version=9p2000.L ro console=ttyAMA0' \
  -serial stdio \
  -fsdev local,id=root,path=$dir,security_model=none \
  -device virtio-9p-device,fsdev=root,mount_tag=/dev/root \
  -monitor none

$dir/bin/x86_64-linux-gnu/qemu-system-aarch64 \
  -M virt \
  -cpu cortex-a57 \
  -m 1024 \
  -kernel $dir/boot/aarch64-linux-gnu/Image \
  -append 'root=/dev/root init=/sbin/aarch64-linux-gnu/init rootfstype=9p
rootflags=trans=virtio,version=9p2000.L ro console=ttyAMA0' \
  -serial stdio \
  -fsdev local,id=root,path=$dir,security_model=none \
  -device virtio-9p-device,fsdev=root,mount_tag=/dev/root -monitor none

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
