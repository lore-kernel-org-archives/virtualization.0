From: Avi Kivity <avi@redhat.com>
Subject: Re: [SeaBIOS] IO APIC emulation failure with qemu-kvm
Date: Mon, 07 Feb 2011 11:29:39 +0200
Message-ID: <4D4FBB83.4030103__1234.59471292353$1297071048$gmane$org@redhat.com>
References: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT@mail.gmail.com>	<4D4C0613.9050309@siemens.com>	<4D4ED860.2060109@redhat.com>	<AANLkTimMQ5hcbtBaYae8p1YBv60GbCYitYRiCZ=P-tKv@mail.gmail.com>	<4D4FB231.1050107@redhat.com>
	<AANLkTik_vm3anS7V6uPr-+9Duz2SUDvoJT=MPsuA-Rv2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik_vm3anS7V6uPr-+9Duz2SUDvoJT=MPsuA-Rv2@mail.gmail.com>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, seabios@seabios.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/07/2011 11:24 AM, Ravi Kumar Kulkarni wrote:
> On Mon, Feb 7, 2011 at 2:19 PM, Avi Kivity<avi@redhat.com>  wrote:
> >  On 02/07/2011 10:33 AM, Ravi Kumar Kulkarni wrote:
> >>
> >>  On Sun, Feb 6, 2011 at 10:50 PM, Avi Kivity<avi@redhat.com>    wrote:
> >>>
> >>>  >    On 02/04/2011 03:58 PM, Jan Kiszka wrote:
> >>>>
> >>>>  >>
> >>>>>
> >>>>>  >>    >       when i run my kernel image with qemu-kvm it gives emulation
> >>>>>  >>  error
> >>>>>  >>    >    failure
> >>>>>  >>    >      trying to execute the code outside ROM or RAM at fec00000(IO
> >>>>>  >>  APIC base
> >>>>>  >>    >    address)
> >>>>>  >>    >      but the same code runs fine with qemu. can anyone please point
> >>>>>  >>  me
> >>>>>  >>    >      where might be the problem or how to find out this one?
> >>>
> >>>  >
> >>>  >    Please post the error message.
> >>
> >>     Im attachin the error message in kvm.txt file  with  above mail.
> >>     KVM internal error. Suberror: 1
> >>                                                                       rax
> >>  000000000000000d rbx 000000001e2db2a6 rcx 00000000fa4bec19 rdx
> >>  0000000000000088
> >>                             rsi 000000001f4de1ea rdi 0000000000000000 rsp
> >>  00000000000c0004 rbp 000000001f464fbb
> >>
> >>                                      r8  0000000000000000 r9  0000000000000000
> >>  r10 0000000000000000 r11 0000000000000000
> >>                                                                      r12
> >>  0000000000000000 r13 0000000000000000 r14 0000000000000000 r15
> >>  0000000000000000
> >>                            rip 000000001e2f3f7b rflags 00010097
> >>                                                                cs 0008
> >>  (00000000/ffffffff p 1 dpl 0 db 1 s 1 type b l 0 g
> >
> >  What's the guest code at rip 0x1e2f3f7b ?
>
>   please find the code below.
>
>   (qemu) xp /20iw 0x1e2f3f83

That is not the same address.  And the code you posted doesn't make any 
sense.

-- 
error compiling committee.c: too many arguments to function
