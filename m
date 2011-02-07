From: Ravi Kumar Kulkarni <ravilinux4u@gmail.com>
Subject: Re: [SeaBIOS] IO APIC emulation failure with qemu-kvm
Date: Mon, 7 Feb 2011 15:58:25 +0530
Message-ID: <AANLkTi=Neds4Zm8sVE4k8yA_YQJ+TqMhTSRZEMKZcPhs__43049.0658538931$1297074643$gmane$org@mail.gmail.com>
References: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT@mail.gmail.com>
	<4D4C0613.9050309@siemens.com> <4D4ED860.2060109@redhat.com>
	<AANLkTimMQ5hcbtBaYae8p1YBv60GbCYitYRiCZ=P-tKv@mail.gmail.com>
	<4D4FB231.1050107@redhat.com>
	<AANLkTik_vm3anS7V6uPr-+9Duz2SUDvoJT=MPsuA-Rv2@mail.gmail.com>
	<4D4FBB83.4030103@redhat.com>
	<AANLkTi=p1R63Oaw9BkZ_YLVB54Yi7mQkFt5L6W5Um1ph@mail.gmail.com>
	<4D4FC13B.7010001@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054acaf26a823049baeb174
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D4FC13B.7010001@redhat.com>
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

--20cf3054acaf26a823049baeb174
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 7, 2011 at 3:24 PM, Avi Kivity <avi@redhat.com> wrote:
> On 02/07/2011 11:47 AM, Ravi Kumar Kulkarni wrote:
>>
>> >
>> > =A0That is not the same address. =A0And the code you posted doesn't ma=
ke any
>> > =A0sense.
>> >
>> =A0sorry for the mistake. here's the correct one
>>
>>
>> (qemu) xp /20iw 0x1e2f3f7b
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000000001e2f3f7b: =A0(bad)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000000001e2f3f7c: =A0std
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000000001e2f3f7d: =A0(bad)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000000001e2f3f7e: =A0(bad)
>
> That looks like garbage. =A0Are you sure you're disassembling the right c=
ode?
>
  ok  . Just to be clear   i ran the command qemu-kvm once and i found
got the crash report below which i have attached and in that eip is at
0x1e2f3f77
 and then

 (qemu) xp /20iw 0x1e2f3f77
                      0x000000001e2f3f77:  pop    %ds
                      0x000000001e2f3f78:  inc    %edx
                      0x000000001e2f3f79:  loope  0x1e2f3fc8
                      0x000000001e2f3f7b:  pop    %ds
                      0x000000001e2f3f7c:  jnp    0x1e2f3f5e
                      0x000000001e2f3f7e:  dec    %ebp
                      0x000000001e2f3f7f:  pop    %ds
                      0x000000001e2f3f80:  xchg   %eax,%esp
                      0x000000001e2f3f81:  aas
                      0x000000001e2f3f82:  das
                      0x000000001e2f3f83:  push   %ds
                      0x000000001e2f3f84:  add    %eax,(%eax)
                      0x000000001e2f3f86:  add    %al,(%eax)
                      0x000000001e2f3f88:  add    %al,(%eax)
                      0x000000001e2f3f8a:  add    %al,(%eax)
                      0x000000001e2f3f8c:  add    %al,(%eax)
                      0x000000001e2f3f8e:  add    %al,(%eax)
                      0x000000001e2f3f90:  or     $0x0,%eax
                      0x000000001e2f3f95:  add    %al,(%eax)
                      0x000000001e2f3f97:  add    %cl,0x81e2f4c(%esi)

Warm Regards,
Ravi Kulkarni.


>

--20cf3054acaf26a823049baeb174
Content-Type: text/plain; charset=US-ASCII; name="kvm1.txt"
Content-Disposition: attachment; filename="kvm1.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjv8jpm90

IEtWTSBpbnRlcm5hbCBlcnJvci4gU3ViZXJyb3I6IDENCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmF4IDAwMDAwMDAwMDAwMDAwMGQgcmJ4IDAwMDAwMDAwMDAwMDAwMDEgcmN4IDAwMDAwMDAw
ZmZmZmZmZmYgcmR4IDAwMDAwMDAwMDAwMDAwMDENCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcnNpIDAwMDAwMDAwMWY0ZGUxNDIgcmRpIDAwMDAwMDAwMWY0ZGUwZTIg
cnNwIDAwMDAwMDAwMDAwYzAwMDQgcmJwIDAwMDAwMDAwMWY0ZGUwN2INCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByOCAg
MDAwMDAwMDAwMDAwMDAwMCByOSAgMDAwMDAwMDAwMDAwMDAwMCByMTAgMDAwMDAwMDAwMDAwMDAw
MCByMTEgMDAwMDAwMDAwMDAwMDAwMA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHIxMiAwMDAw
MDAwMDAwMDAwMDAwIHIxMyAwMDAwMDAwMDAwMDAwMDAwIHIxNCAwMDAwMDAwMDAwMDAwMDAwIHIx
NSAwMDAwMDAwMDAwMDAwMDAwDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmlwIDAwMDAwMDAwMWUyZjNmNzcgcmZsYWdzIDAwMDEwMDAyDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY3MgMDAwOCAoMDAwMDAwMDAvZmZmZmZmZmYgcCAxIGRwbCAwIGRiIDEgcyAxIHR5cGUgYiBs
IDAgZyAxIGF2bCAwKQ0KICAgICAgICAgICAgICAgICAgZHMgMDAwMyAoMDAwMDAwMDAvZmZmZmZm
ZmYgcCAwIGRwbCAwIGRiIDAgcyAwIHR5cGUgMCBsIDAgZyAwIGF2bCAwKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGVzIDAwNDAgKDAwMDAwMDAwL2ZmZmZmZmZmIHAgMSBkcGwgMyBkYiAx
IHMgMSB0eXBlIDMgbCAwIGcgMSBhdmwgMCkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgIHNz
IDAwMTAgKDAwMDAwMDAwL2ZmZmZmZmZmIHAgMSBkcGwgMCBkYiAxIHMgMSB0eXBlIDMgbCAwIGcg
MSBhdmwgMCkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmcyAwMDQwICgw
MDAwMDAwMC9mZmZmZmZmZiBwIDEgZHBsIDMgZGIgMSBzIDEgdHlwZSAzIGwgMCBnIDEgYXZsIDAp
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncyAwMDQwICgwMDAwMDAwMC9m
ZmZmZmZmZiBwIDEgZHBsIDMgZGIgMSBzIDEgdHlwZSAzIGwgMCBnIDEgYXZsIDApDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHIgMDA0YiAoMWY1MjIyMDYv
MDAwMDAwNjcgcCAxIGRwbCAzIGRiIDAgcyAwIHR5cGUgYiBsIDAgZyAwIGF2bCAxKQ0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGR0IDAwMDAgKDAwMDAwMDAw
LzAwMDBmZmZmIHAgMSBkcGwgMCBkYiAwIHMgMCB0eXBlIDIgbCAwIGcgMCBhdmwgMCkNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2R0IDFm
NTIyMDA2LzdmDQogICBpZHQgMWY5YWYwMDAvN2ZmDQogICAgICAgICAgICAgICAgICAgY3IwIDEx
IGNyMiAwIGNyMyAwIGNyNCAwIGNyOCAwIGVmZXIgMA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbXVsYXRpb24gZmFpbHVyZSwgY2hlY2sg
ZG1lc2cgZm9yIGRldGFpbHMNCg==
--20cf3054acaf26a823049baeb174
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--20cf3054acaf26a823049baeb174--
