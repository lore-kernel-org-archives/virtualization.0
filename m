From: Avi Kivity <avi@redhat.com>
Subject: Re: [SeaBIOS] IO APIC emulation failure with qemu-kvm
Date: Mon, 07 Feb 2011 15:17:02 +0200
Message-ID: <4D4FF0CE.7000702__24377.8735203252$1297084677$gmane$org@redhat.com>
References: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT@mail.gmail.com>	<4D4C0613.9050309@siemens.com>	<4D4ED860.2060109@redhat.com>	<AANLkTimMQ5hcbtBaYae8p1YBv60GbCYitYRiCZ=P-tKv@mail.gmail.com>	<4D4FB231.1050107@redhat.com>	<AANLkTik_vm3anS7V6uPr-+9Duz2SUDvoJT=MPsuA-Rv2@mail.gmail.com>	<4D4FBB83.4030103@redhat.com>	<AANLkTi=p1R63Oaw9BkZ_YLVB54Yi7mQkFt5L6W5Um1ph@mail.gmail.com>	<4D4FC13B.7010001@redhat.com>
	<AANLkTi=Neds4Zm8sVE4k8yA_YQJ+TqMhTSRZEMKZcPhs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=Neds4Zm8sVE4k8yA_YQJ+TqMhTSRZEMKZcPhs@mail.gmail.com>
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

On 02/07/2011 12:28 PM, Ravi Kumar Kulkarni wrote:
> On Mon, Feb 7, 2011 at 3:24 PM, Avi Kivity<avi@redhat.com>  wrote:
> >  On 02/07/2011 11:47 AM, Ravi Kumar Kulkarni wrote:
> >>
> >>  >
> >>  >    That is not the same address.  And the code you posted doesn't make any
> >>  >    sense.
> >>  >
> >>    sorry for the mistake. here's the correct one
> >>
> >>
> >>  (qemu) xp /20iw 0x1e2f3f7b
> >>                         0x000000001e2f3f7b:  (bad)
> >>                         0x000000001e2f3f7c:  std
> >>                         0x000000001e2f3f7d:  (bad)
> >>                         0x000000001e2f3f7e:  (bad)
> >
> >  That looks like garbage.  Are you sure you're disassembling the right code?
> >
>    ok  . Just to be clear   i ran the command qemu-kvm once and i found
> got the crash report below which i have attached and in that eip is at
> 0x1e2f3f77
>   and then
>
>   (qemu) xp /20iw 0x1e2f3f77
>                        0x000000001e2f3f77:  pop    %ds
>                        0x000000001e2f3f78:  inc    %edx
>                        0x000000001e2f3f79:  loope  0x1e2f3fc8
>                        0x000000001e2f3f7b:  pop    %ds
>                        0x000000001e2f3f7c:  jnp    0x1e2f3f5e
>                        0x000000001e2f3f7e:  dec    %ebp
>                        0x000000001e2f3f7f:  pop    %ds
>                        0x000000001e2f3f80:  xchg   %eax,%esp
>                        0x000000001e2f3f81:  aas
>                        0x000000001e2f3f82:  das


This still doesn't look like real code.  The problem was likely much 
earlier and caused a branch into a data section.

Someone with a good understanding of your OS needs to examine the trace 
and see what went wrong.

-- 
error compiling committee.c: too many arguments to function
