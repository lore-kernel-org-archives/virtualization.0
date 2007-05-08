From: yhlu <yhlu.kernel@gmail.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Tue, 8 May 2007 09:41:09 -0700
Message-ID: <86802c440705080941y69ddd5d6lab170c5f3967f148__1966.44374304942$1178642609$gmane$org@mail.gmail.com>
References: <4634483E.9030307@goop.org> <46385A8A.6070405@redhat.com>
	<4638AB55.20408@goop.org> <4638F9BE.8090508@zytor.com>
	<4638FC39.4010101@goop.org> <4638FE1B.9050901@zytor.com>
	<46390523.5010809@goop.org> <463909AF.9040205@zytor.com>
	<20070503045031.GA5794@in.ibm.com>
	<m1tzuuv24z.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1tzuuv24z.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, vgoyal@in.ibm.com, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On 5/2/07, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
>
> > On Wed, May 02, 2007 at 02:59:11PM -0700, H. Peter Anvin wrote:
> >> Jeremy Fitzhardinge wrote:
> >> >
> >> > So the bzImage structure is currently:
> >> >
> >> >    1. old-style boot sector
> >> >    2. old-style boot info, followed by 0xaa55 at the end of the sector
> >> >    3. the HdrS boot param block
> >> >    4. setup.S boot code
> >> >    5. the self-decompressing kernel
> >> >

Eric,

With the latest change that make vmlinux to be elf64 and make bzImage
do switch to 64bit long mode, the kernel started via kexec can not get
VGA console. but the serial console works well. I wonder if the
setup.S is skipped in bzImage via kexec path.

or i missed sth?

#!/bin/bash
./kexec -t bzImage -l bzImage_2.6.22_k8.1 --command-line="apic=debug
acpi_dbg_level=0x00000007 pci=routeirq snd-hda-intel.enable_msi=1
ramdisk_size=65536 root=/dev/ram0 rw ip=dhcp console=tty0
console=ttyS0,9600n8" --ramdisk=mydisk8_x86_64.gz


YH
