From: Ravi Kumar Kulkarni <ravilinux4u@gmail.com>
Subject: Re: [SeaBIOS] IO APIC emulation failure with qemu-kvm
Date: Mon, 7 Feb 2011 15:17:22 +0530
Message-ID: <AANLkTi=p1R63Oaw9BkZ_YLVB54Yi7mQkFt5L6W5Um1ph__48801.2250200429$1297072576$gmane$org@mail.gmail.com>
References: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT@mail.gmail.com>
	<4D4C0613.9050309@siemens.com> <4D4ED860.2060109@redhat.com>
	<AANLkTimMQ5hcbtBaYae8p1YBv60GbCYitYRiCZ=P-tKv@mail.gmail.com>
	<4D4FB231.1050107@redhat.com>
	<AANLkTik_vm3anS7V6uPr-+9Duz2SUDvoJT=MPsuA-Rv2@mail.gmail.com>
	<4D4FBB83.4030103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D4FBB83.4030103@redhat.com>
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

On Mon, Feb 7, 2011 at 2:59 PM, Avi Kivity <avi@redhat.com> wrote:
> On 02/07/2011 11:24 AM, Ravi Kumar Kulkarni wrote:
>>
>> On Mon, Feb 7, 2011 at 2:19 PM, Avi Kivity<avi@redhat.com> =A0wrote:
>> > =A0On 02/07/2011 10:33 AM, Ravi Kumar Kulkarni wrote:
>> >>
>> >> =A0On Sun, Feb 6, 2011 at 10:50 PM, Avi Kivity<avi@redhat.com> =A0 =
=A0wrote:
>> >>>
>> >>> =A0> =A0 =A0On 02/04/2011 03:58 PM, Jan Kiszka wrote:
>> >>>>
>> >>>> =A0>>
>> >>>>>
>> >>>>> =A0>> =A0 =A0> =A0 =A0 =A0 when i run my kernel image with qemu-kv=
m it gives
>> >>>>> emulation
>> >>>>> =A0>> =A0error
>> >>>>> =A0>> =A0 =A0> =A0 =A0failure
>> >>>>> =A0>> =A0 =A0> =A0 =A0 =A0trying to execute the code outside ROM o=
r RAM at
>> >>>>> fec00000(IO
>> >>>>> =A0>> =A0APIC base
>> >>>>> =A0>> =A0 =A0> =A0 =A0address)
>> >>>>> =A0>> =A0 =A0> =A0 =A0 =A0but the same code runs fine with qemu. c=
an anyone
>> >>>>> please point
>> >>>>> =A0>> =A0me
>> >>>>> =A0>> =A0 =A0> =A0 =A0 =A0where might be the problem or how to fin=
d out this
>> >>>>> one?
>> >>>
>> >>> =A0>
>> >>> =A0> =A0 =A0Please post the error message.
>> >>
>> >> =A0 =A0 Im attachin the error message in kvm.txt file =A0with =A0abov=
e mail.
>> >> =A0 =A0 KVM internal error. Suberror: 1
>> >>
>> >> rax
>> >> =A0000000000000000d rbx 000000001e2db2a6 rcx 00000000fa4bec19 rdx
>> >> =A00000000000000088
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rsi 000000001=
f4de1ea rdi 0000000000000000
>> >> rsp
>> >> =A000000000000c0004 rbp 000000001f464fbb
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0r8 =A00000000000000000 r9
>> >> =A00000000000000000
>> >> =A0r10 0000000000000000 r11 0000000000000000
>> >>
>> >> =A0r12
>> >> =A00000000000000000 r13 0000000000000000 r14 0000000000000000 r15
>> >> =A00000000000000000
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rip 000000001e=
2f3f7b rflags 00010097
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs 0008
>> >> =A0(00000000/ffffffff p 1 dpl 0 db 1 s 1 type b l 0 g
>> >
>> > =A0What's the guest code at rip 0x1e2f3f7b ?
>>
>> =A0please find the code below.
>>
>> =A0(qemu) xp /20iw 0x1e2f3f83
>
> That is not the same address. =A0And the code you posted doesn't make any
> sense.
>
 sorry for the mistake. here's the correct one


(qemu) xp /20iw 0x1e2f3f7b
                      0x000000001e2f3f7b:  (bad)
                      0x000000001e2f3f7c:  std
                      0x000000001e2f3f7d:  (bad)
                      0x000000001e2f3f7e:  (bad)
                      0x000000001e2f3f7f:  decl   0x28000000
                      0x000000001e2f3f85:  loope  0x1e2f3f87
                      0x000000001e2f3f87:  add    %cl,0x81e2f4c(%edi)
                      0x000000001e2f3f8d:  add    %al,(%eax)
                      0x000000001e2f3f8f:  add    %al,(%edi)
                      0x000000001e2f3f91:  add    %al,(%ecx)
                      0x000000001e2f3f93:  add    %ch,(%edx)
                      0x000000001e2f3f95:  loope  0x1e2f3fe4
                      0x000000001e2f3f97:  pop    %ds
                      0x000000001e2f3f98:  mov    %cl,%ah
                      0x000000001e2f3f9a:  dec    %ebp
                      0x000000001e2f3f9b:  pop    %ds
                      0x000000001e2f3f9c:  or     $0xb41f4de0,%eax
                      0x000000001e2f3fa1:  aas
                      0x000000001e2f3fa2:  das
                      0x000000001e2f3fa3:  push   %ds



Warm regards,
Ravi Kulkarni.
