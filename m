From: Avi Kivity <avi@redhat.com>
Subject: Re: [SeaBIOS] IO APIC emulation failure with qemu-kvm
Date: Sun, 06 Feb 2011 19:20:32 +0200
Message-ID: <4D4ED860.2060109__976.892156950448$1297012903$gmane$org@redhat.com>
References: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT@mail.gmail.com>
	<4D4C0613.9050309@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D4C0613.9050309@siemens.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Kiszka <jan.kiszka@siemens.com>, Ravi Kumar Kulkarni <ravilinux4u@gmail.com>
Cc: seabios@seabios.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/04/2011 03:58 PM, Jan Kiszka wrote:
> >   when i run my kernel image with qemu-kvm it gives emulation error failure
> >  trying to execute the code outside ROM or RAM at fec00000(IO APIC base address)
> >  but the same code runs fine with qemu. can anyone please point me
> >  where might be the problem or how to find out this one?

Please post the error message.

> Start with capturing the activity of you guest via ftrace, enabling all
> kvm:* events. You may also try to attach gdb to qemu and analyze the
> different code path in both versions (specifically if you have debugging
> symbols for your guest).

The easy way to do that is trace-cmd (http://lwn.net/Articles/341902/):

$ trace-cmd record -e kvm -b 20000
...
^C
$ trace-cmd report

-- 
error compiling committee.c: too many arguments to function
