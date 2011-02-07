From: Ravi Kumar Kulkarni <ravilinux4u@gmail.com>
Subject: Re: [SeaBIOS] IO APIC emulation failure with qemu-kvm
Date: Mon, 7 Feb 2011 14:54:04 +0530
Message-ID: <AANLkTik_vm3anS7V6uPr-+9Duz2SUDvoJT=MPsuA-Rv2__11897.0267395072$1297070773$gmane$org@mail.gmail.com>
References: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT@mail.gmail.com>
	<4D4C0613.9050309@siemens.com> <4D4ED860.2060109@redhat.com>
	<AANLkTimMQ5hcbtBaYae8p1YBv60GbCYitYRiCZ=P-tKv@mail.gmail.com>
	<4D4FB231.1050107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D4FB231.1050107@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, seabios@seabios.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 7, 2011 at 2:19 PM, Avi Kivity <avi@redhat.com> wrote:
> On 02/07/2011 10:33 AM, Ravi Kumar Kulkarni wrote:
>>
>> On Sun, Feb 6, 2011 at 10:50 PM, Avi Kivity<avi@redhat.com> =A0wrote:
>>>
>>> > =A0On 02/04/2011 03:58 PM, Jan Kiszka wrote:
>>>>
>>>> >>
>>>>>
>>>>> >> =A0> =A0 =A0 when i run my kernel image with qemu-kvm it gives emu=
lation
>>>>> >> error
>>>>> >> =A0> =A0failure
>>>>> >> =A0> =A0 =A0trying to execute the code outside ROM or RAM at fec00=
000(IO
>>>>> >> APIC base
>>>>> >> =A0> =A0address)
>>>>> >> =A0> =A0 =A0but the same code runs fine with qemu. can anyone plea=
se point
>>>>> >> me
>>>>> >> =A0> =A0 =A0where might be the problem or how to find out this one?
>>>
>>> >
>>> > =A0Please post the error message.
>>
>> =A0 Im attachin the error message in kvm.txt file =A0with =A0above mail.
>> =A0 KVM internal error. Suberror: 1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rax
>> 000000000000000d rbx 000000001e2db2a6 rcx 00000000fa4bec19 rdx
>> 0000000000000088
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rsi 000000001f4de1ea=
 rdi 0000000000000000 rsp
>> 00000000000c0004 rbp 000000001f464fbb
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r=
8 =A00000000000000000 r9 =A00000000000000000
>> r10 0000000000000000 r11 0000000000000000
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r12
>> 0000000000000000 r13 0000000000000000 r14 0000000000000000 r15
>> 0000000000000000
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rip 000000001e2f3f7b =
rflags 00010097
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs 0008
>> (00000000/ffffffff p 1 dpl 0 db 1 s 1 type b l 0 g
>
> What's the guest code at rip 0x1e2f3f7b ?

 please find the code below.

 (qemu) xp /20iw 0x1e2f3f83

                                            0x000000001e2f3f83:  pop    %ds

                                            0x000000001e2f3f84:  jae
 0x1e2f3f66

                                            0x000000001e2f3f86:  dec    %ebp

                                            0x000000001e2f3f87:  pop    %ds

                                            0x000000001e2f3f88:  pushf

                                            0x000000001e2f3f89:  aas

                                            0x000000001e2f3f8a:  das

                                            0x000000001e2f3f8b:  push
 %ds

0x000000001e2f3f8c:  iret

                                            0x000000001e2f3f8d:  test
 $0x1e2e,%eax

                                            0x000000001e2f3f92:  add
 %al,(%eax)

0x000000001e2f3f94:  add    %al,(%eax)

                                            0x000000001e2f3f96:  add
 %al,(%eax)

                                            0x000000001e2f3f98:  or
 $0x0,%eax

                                            0x000000001e2f3f9d:  add
 %al,(%eax)

0x000000001e2f3f9f:  add    %cl,0x81e2f4c(%esi)

                                            0x000000001e2f3fa5:  add
 %al,(%eax)

                                            0x000000001e2f3fa7:  add
 %al,(%edx)

0x000000001e2f3fa9:  add    %al,(%ecx)

                                            0x000000001e2f3fab:  add
 %cl,-0x1f(%edx)
Thanks,
Ravi Kulkarni.


>
> --

>
>
