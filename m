From: Richard Yao <ryao@gentoo.org>
Subject: Re: [Qemu-devel] QEMU dies on any attempt to load a Linux kernel
	module when using a 9P rootfs
Date: Thu, 21 Aug 2014 22:00:43 -0500
Message-ID: <D7F0E6B9-FA40-4E84-B4D3-C3AB7FA30C6D__46743.7737192542$1408677019$gmane$org@gentoo.org>
References: <5293718E.4090508@gentoo.org> <53F64DA2.3060308@codeaurora.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53F64DA2.3060308@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christopher Covington <cov@codeaurora.org>
Cc: "kernel@gentoo.org" <kernel@gentoo.org>, "v9fs-developer@lists.sourceforge.net" <v9fs-developer@lists.sourceforge.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
List-Id: virtualization@lists.linuxfoundation.org

I use it all the time, but I have not updated to a more recent kernel yet. I am at LinuxCon, so I am unlikely to try it until I get home.

> On Aug 21, 2014, at 2:50 PM, Christopher Covington <cov@codeaurora.org> wrote:
> 
> Hi Richard,
> 
>> On 11/25/2013 10:49 AM, Richard Yao wrote:
>> I booted a Gentoo Linux installation in QEMU with a 9P rootfs as follows:
>> 
>> sudo qemu-kvm -cpu host -m 1024 -kernel
>> /mnt/test/usr/src/linux-3.13-rc1/arch/x86/boot/bzImage -append
>> 'root=/dev/root rootfstype=9p rootflags=trans=virtio,version=9p2000.L ro
>> console=ttyS0' -serial stdio -fsdev
>> local,id=root,path=/mnt/test,security_model=none -device
>> virtio-9p-pci,fsdev=root,mount_tag=/dev/root
>> 
>> The system boots fine, but attempting to load any module will fail:
>> 
>> localhost ~ # modprobe crc32
>> qemu-system-x86_64: virtio: trying to map MMIO memory
>> 
>> The behavior is consistent no matter what combination of things that I
>> try. So far, I have tried Linux 3.10.7-gentoo (Gentoo patchset) and
>> Linux 3.13-rc1. I have tried QEMU 1.4.2, QEMU 1.6.1 and QEMU HEAD. I
>> have also tried booting without KVM, but the behavior is the same:
>> 
>> sudo qemu-kvm --no-kvm -m 1024 -kernel
>> /mnt/test/usr/src/linux-3.13-rc1/arch/x86/boot/bzImage -append
>> 'root=/dev/root rootfstype=9p rootflags=trans=virtio,version=9p2000.L ro
>> console=ttyS0' -serial stdio -fsdev
>> local,id=root,path=/mnt/test,security_model=none -device
>> virtio-9p-pci,fsdev=root,mount_tag=/dev/root
> 
> Have you used this setup recently?
> 
> With my 3.15.0+ kernel, qemu-system-x86_64 substituted for qemu-kvm, and the
> path changed from your arguments I get:
> 
> 9pnet_virtio: no channels available
> VFS: Cannot open root device "root" or unknown-block(0,0): error -2
> Please append a correct "root=" boot option; here are the available partitions:
> 0b00         1048575 sr0  driver: sr
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
> 
> Thanks,
> Christopher
> 
> -- 
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by the Linux Foundation.
