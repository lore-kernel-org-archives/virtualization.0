From: Ravi Kumar Kulkarni <ravilinux4u@gmail.com>
Subject: Re: [SeaBIOS] IO APIC emulation failure with qemu-kvm
Date: Mon, 7 Feb 2011 14:03:07 +0530
Message-ID: <AANLkTimMQ5hcbtBaYae8p1YBv60GbCYitYRiCZ=P-tKv@mail.gmail.com>
References: <AANLkTi=pA0aBsOZn9D+EUZ4SyC7wNAYAHQXN9=1PcGNT@mail.gmail.com>
	<4D4C0613.9050309@siemens.com> <4D4ED860.2060109@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30433eeccf39f9049bad1488
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D4ED860.2060109@redhat.com>
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

--20cf30433eeccf39f9049bad1488
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 6, 2011 at 10:50 PM, Avi Kivity <avi@redhat.com> wrote:
> On 02/04/2011 03:58 PM, Jan Kiszka wrote:
>>
>> > =A0 when i run my kernel image with qemu-kvm it gives emulation error
>> > failure
>> > =A0trying to execute the code outside ROM or RAM at fec00000(IO APIC b=
ase
>> > address)
>> > =A0but the same code runs fine with qemu. can anyone please point me
>> > =A0where might be the problem or how to find out this one?
>
> Please post the error message.
  Im attachin the error message in kvm.txt file  with  above mail.
>
>> Start with capturing the activity of you guest via ftrace, enabling all
>> kvm:* events. You may also try to attach gdb to qemu and analyze the
>> different code path in both versions (specifically if you have debugging
>> symbols for your guest).
>
> The easy way to do that is trace-cmd (http://lwn.net/Articles/341902/):
>
> $ trace-cmd record -e kvm -b 20000
> ...
> ^C
> $ trace-cmd report

please give me some time to set up the trace-cmd utility for capture.
i also want to run with the latest kernel and qemu-kvm once. i will
post the results soon.


the kernel version im using is 2.6.33 and qemu-kvm version is 0.12.3
and qemu version is 0.13. also im not doing any fancy relocations with
the IO APIC.
>
> --
> error compiling committee.c: too many arguments to function

--20cf30433eeccf39f9049bad1488
Content-Type: text/plain; charset=US-ASCII; name="kvm.txt"
Content-Disposition: attachment; filename="kvm.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjuz6alx0

ICBLVk0gaW50ZXJuYWwgZXJyb3IuIFN1YmVycm9yOiAxDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJheCAwMDAwMDAw
MDAwMDAwMDBkIHJieCAwMDAwMDAwMDFlMmRiMmE2IHJjeCAwMDAwMDAwMGZhNGJlYzE5IHJkeCAw
MDAwMDAwMDAwMDAwMDg4DQogICAgICAgICAgICAgICAgICAgICAgICAgIHJzaSAwMDAwMDAwMDFm
NGRlMWVhIHJkaSAwMDAwMDAwMDAwMDAwMDAwIHJzcCAwMDAwMDAwMDAwMGMwMDA0IHJicCAwMDAw
MDAwMDFmNDY0ZmJiDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcjggIDAwMDAwMDAwMDAwMDAwMDAgcjkgIDAwMDAwMDAwMDAwMDAwMDAgcjEwIDAw
MDAwMDAwMDAwMDAwMDAgcjExIDAwMDAwMDAwMDAwMDAwMDANCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByMTIgMDAwMDAw
MDAwMDAwMDAwMCByMTMgMDAwMDAwMDAwMDAwMDAwMCByMTQgMDAwMDAwMDAwMDAwMDAwMCByMTUg
MDAwMDAwMDAwMDAwMDAwMA0KICAgICAgICAgICAgICAgICAgICAgICAgIHJpcCAwMDAwMDAwMDFl
MmYzZjdiIHJmbGFncyAwMDAxMDA5Nw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNzIDAwMDggKDAwMDAwMDAwL2ZmZmZmZmZmIHAg
MSBkcGwgMCBkYiAxIHMgMSB0eXBlIGIgbCAwIGcgMSBhdmwgMCkNCiAgIGRzIDAwMDAgKDAwMDAw
MDAwL2ZmZmZmZmZmIHAgMCBkcGwgMCBkYiAwIHMgMCB0eXBlIDAgbCAwIGcgMCBhdmwgMCkNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBlcyAwMDQwICgwMDAwMDAwMC9mZmZmZmZmZiBwIDEgZHBsIDMgZGIgMSBzIDEg
dHlwZSAzIGwgMCBnIDEgYXZsIDApDQogICAgICAgICAgICBzcyAwMDEwICgwMDAwMDAwMC9mZmZm
ZmZmZiBwIDEgZHBsIDAgZGIgMSBzIDEgdHlwZSAzIGwgMCBnIDEgYXZsIDApDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZnMgMDA0MCAoMDAwMDAwMDAvZmZmZmZmZmYgcCAxIGRwbCAzIGRiIDEgcyAx
IHR5cGUgMyBsIDAgZyAxIGF2bCAwKQ0KICAgICAgICAgICAgICAgICAgICAgZ3MgMDA0MCAoMDAw
MDAwMDAvZmZmZmZmZmYgcCAxIGRwbCAzIGRiIDEgcyAxIHR5cGUgMyBsIDAgZyAxIGF2bCAwKQ0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRyIDAwNGIgKDFmNTIyMjA2LzAwMDAwMDY3
IHAgMSBkcGwgMyBkYiAwIHMgMCB0eXBlIGIgbCAwIGcgMCBhdmwgMSkNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGxkdCAwMDAwICgwMDAwMDAwMC8wMDAwZmZmZiBwIDEgZHBsIDAgZGIg
MCBzIDAgdHlwZSAyIGwgMCBnIDAgYXZsIDApDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGdkdCAxZjUyMjAwNi83Zg0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZHQgMWY5YWYwMDAvN2ZmDQogICAgY3IwIDEx
IGNyMiAwIGNyMyAwIGNyNCAwIGNyOCAwIGVmZXIgMA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlbXVsYXRpb24gZmFpbHVyZSwgY2hlY2sgZG1lc2cgZm9yIGRldGFp
bHMNCg==
--20cf30433eeccf39f9049bad1488
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--20cf30433eeccf39f9049bad1488--
