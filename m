From: PICT PUNE <kvm.smartshare@gmail.com>
Subject: Re: Help - KVM TODO_NOV2008_Sharing Memory between guests
Date: Wed, 4 Mar 2009 19:42:44 +0530
Message-ID: <b20fe0330903040612m784b273ew7bca3c8ad087990a@mail.gmail.com>
References: <b20fe0330902210535p1efb68bcv282853c5f4f08f3b@mail.gmail.com>
	<49A549F1.8000901@redhat.com> <49A566AC.3010208@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4895571767546436847=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <49A566AC.3010208@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============4895571767546436847==
Content-Type: multipart/alternative; boundary=0016e64b076a41e84304644ba523

--0016e64b076a41e84304644ba523
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Wed, Feb 25, 2009 at 9:11 PM, Anthony Liguori <anthony@codemonkey.ws>wrote:

> Avi Kivity wrote:
>
>> PICT PUNE wrote:
>>
>>> In reference to the November 2008 todo list on Qumranet Website
>>>
>>> we are a group of college students working on this todo:
>>>
>>> *Add a qemu interface for sharing memory between guests. Using a pci
>>> device to expose the shared memory is probably a good starting point.
>>> *
>>> Can anyone suggest us some starting point or a possible approach for the
>>> same...
>>>
>>
>> Write a PCI device that exposes a BAR containing RAM.  Implement the RAM
>> by mapping a shared memory segment or a file.  Write a guest driver to use
>> this shared RAM.
>>
>>
> Or implement a virtio device that can advertise available shared memory
> segments.  Have guest allocate its own memory to send to host that becomes
> the shared memory segment.
>
> Expose shared memory mappings via a virtual file system (similar to
> hugetlbfs or ramfs).
>
> Using PCI BARs implies static shared memory mappings.  For a long running
> VM, you're likely to want to support dynamic shared memory mappings.
>
> Also exposing a simple signaling mechanism with this too would allow for
> shared ring queues to be implemented in userspace between guests.
>
> Regards,
>
> Anthony Liguori
>

Hello Mr. Avi Kivity  and Mr. Anthony Liguori

Thanks for your early reply. We expecting the same approach. We are in
process of making clusters of free memory  and reserve these memory as a
fake PCI device for the guest  OS. this device will be then passed using PCI
passthrough  to the guest from the host. Can you please help us in faking
the free memory cluster as a PCI device. Thanking in anticipation.


Regards,

PICT Pune BE Students

--0016e64b076a41e84304644ba523
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Feb 25, 2009 at 9:11 PM, Anthony=
 Liguori <span dir=3D"ltr">&lt;<a href=3D"mailto:anthony@codemonkey.ws">ant=
hony@codemonkey.ws</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
<div class=3D"im">Avi Kivity wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
PICT PUNE wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
In reference to the November 2008 todo list on Qumranet Website<br>
<br>
we are a group of college students working on this todo:<br>
<br>
*Add a qemu interface for sharing memory between guests. Using a pci device=
 to expose the shared memory is probably a good starting point.<br>
*<br>
Can anyone suggest us some starting point or a possible approach for the sa=
me...<br>
</blockquote>
<br>
Write a PCI device that exposes a BAR containing RAM. =A0Implement the RAM =
by mapping a shared memory segment or a file. =A0Write a guest driver to us=
e this shared RAM.<br>
<br>
</blockquote>
<br></div>
Or implement a virtio device that can advertise available shared memory seg=
ments. =A0Have guest allocate its own memory to send to host that becomes t=
he shared memory segment.<br>
<br>
Expose shared memory mappings via a virtual file system (similar to hugetlb=
fs or ramfs).<br>
<br>
Using PCI BARs implies static shared memory mappings. =A0For a long running=
 VM, you&#39;re likely to want to support dynamic shared memory mappings.<b=
r>
<br>
Also exposing a simple signaling mechanism with this too would allow for sh=
ared ring queues to be implemented in userspace between guests.<br>
<br>
Regards,<br><font color=3D"#888888">
<br>
Anthony Liguori<br>
</font></blockquote><div><br>Hello Mr. Avi Kivity=A0 and Mr. Anthony Liguor=
i<br><br>Thanks for your early reply. We expecting the same approach. We ar=
e in process of making clusters of free memory=A0 and reserve these memory =
as a fake PCI device for the guest=A0 OS. this device will be then passed u=
sing PCI passthrough=A0 to the guest from the host. Can you please help us =
in faking the free memory cluster as a PCI device. Thanking in anticipation=
.<br>
<br><br>Regards,<br><br>PICT Pune BE Students<br></div></div><br>

--0016e64b076a41e84304644ba523--

--===============4895571767546436847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============4895571767546436847==--
