From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: BUG: 'list_empty(&vgdev->free_vbufs)' is true!
Date: Thu, 15 Dec 2016 14:01:12 +0100
Message-ID: <a03bbf47-f08a-e54c-a5f4-e639c40f7cee@suse.cz>
References: <bfe29853-694b-6cb5-02e7-6986a9927438@suse.cz>
	<20161108223153-mutt-send-email-mst@kernel.org>
	<1478678517.2078.12.camel@redhat.com>
	<f006e3a6-51d2-4092-57b6-eea7ff64f58f@suse.cz>
	<1479301975.25611.23.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1479301975.25611.23.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/16/2016, 02:12 PM, Gerd Hoffmann wrote:
> On Fr, 2016-11-11 at 17:28 +0100, Jiri Slaby wrote:
>> On 11/09/2016, 09:01 AM, Gerd Hoffmann wrote:
>>> On Di, 2016-11-08 at 22:37 +0200, Michael S. Tsirkin wrote:
>>>> On Mon, Nov 07, 2016 at 09:43:24AM +0100, Jiri Slaby wrote:
>>>>> Hi,
>>>>>
>>>>> I can relatively easily reproduce this bug:
>>>
>>> How?
>>
>> Run dmesg -w in the qemu window (virtio_gpu) to see a lot of output.
>> Run pps [1] without exit(0); on e.g. serial console.
>> Wait a bit. The lot of output causes the BUG.
>>
>> [1] https://github.com/jirislaby/collected_sources/blob/master/pps.c
> 
> Doesn't reproduce here.
> 
> Running "while true; do dmesg; done" on the virtio-gpu fbcon.
> Running the pps fork bomb on the serial console.
> 
> Can watch dmesg printing the kernel messages over and over, until the
> shell can't spawn dmesg any more due to the fork bomb hitting the
> process limit.  No BUG() triggered.
> 
> Tried spice, gtk and sdl.
> 
> Hmm.
> 
> Any ideas what else might be needed to reproduce it?

I can reproduce even with count = 32 :(. And without the fork bomb (i.e.
with the code from the repository).

This is how I start qemu:
/usr/bin/qemu-system-x86_64 -machine accel=kvm -k en-us -smp 4 -m 2371
-usb -device virtio-rng-pci -drive
file=/home/new/suse-fact.img,format=raw,discard=unmap,if=none,id=hd
-device virtio-scsi-pci,id=scsi -device scsi-hd,drive=hd -soundhw hda
-net
user,tftp=/home/xslaby/tftp,bootfile=/pxelinux.0,hostfwd=tcp::2222-:22,hostfwd=tcp::3632-:3632
-net nic,model=virtio -serial pty -balloon virtio -device
virtio-tablet-pci -vga virtio -kernel
/home/latest/my/arch/x86/boot/bzImage -append root=/dev/sda1
console=ttyS0,115200 loglevel=debug -snapshot

I do
  dmesg -w # on the console
and on serial console:
  while :; do for aa in `seq 1 10`; do ./pps & done; wait; done

Note the latter can cause interrupt "storm" (~ 700 irqs per second) as
much output is generated. This can lead to some race condition. serial
is on IRQ4 and virtio gpu on IRQ10 which has lower priority AFAIK.

thanks,
-- 
js
suse labs
