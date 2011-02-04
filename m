From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: IO APIC emulation failure with qemu-kvm
Date: Fri, 04 Feb 2011 14:58:43 +0100
Message-ID: <4D4C0613.9050309__7794.70515340126$1296833820$gmane$org@siemens.com>
References: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ravi Kumar Kulkarni <ravilinux4u@gmail.com>
Cc: seabios@seabios.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 2011-02-04 14:35, Ravi Kumar Kulkarni wrote:
> Hi all,
>  I'm Initializing the Local and IO APIC for a propeitary operating
> system running in Virtualized Environment  .
>  Im facing some problem with qemu-kvm  but the code runs fine with qemu.

Does it also run fine with qemu-kvm and -no-kvm-irqchip? What versions
of the kernel and qemu-kvm are you using? If not the latest git, does
updating change the picture?

>  when i run my kernel image with qemu-kvm it gives emulation error failure
> trying to execute the code outside ROM or RAM at fec00000(IO APIC base address)
> but the same code runs fine with qemu. can anyone please point me
> where might be the problem or how to find out this one?

Start with capturing the activity of you guest via ftrace, enabling all
kvm:* events. You may also try to attach gdb to qemu and analyze the
different code path in both versions (specifically if you have debugging
symbols for your guest).

BTW, is your OS doing any fancy [IO]APIC relocations?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux
