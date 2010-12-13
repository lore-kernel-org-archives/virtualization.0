From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] SCSI Command support over VirtIO Block device
Date: Mon, 13 Dec 2010 07:42:15 +0000
Message-ID: <AANLkTi=MVouwpAu5Zfxexx-yOZa3p0SpQ4OrO+_ax-Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5278717429763121343=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: =?UTF-8?B?4KSF4KSo4KWB4KSc?= <anuj01@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============5278717429763121343==
Content-Type: multipart/alternative; boundary=001636499c3fc496fe049745d79f

--001636499c3fc496fe049745d79f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Dec 13, 2010 5:14 AM, "=E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=9C" <anuj01@gma=
il.com> wrote:
>
> Hi
>
> I am trying to implement VirtIO support for a proprietary OS. And It
> would be great if I am able to process SCSI commands over VirtIO Block
> device.
>
> I tried to execute INQUIRY command but the status returned is UNSUPPORTED=
.
> If anyone provide example VirtIO SCSI Command request structure for
> INQUIRY command as per VirtIO spec Appendix D would be a great help.
>
> And also, the paragraph from VirtIO spec - 0.8.9 is confusing for me :
>
> "Historically, devices assumed that the  fields type, ioprio and
> sector reside in
> a single, separate read-only buffer; the  fields errors, data_len,
sense_len and
> residual reside in a single, separate write-only buffer; the sense
>  eld in a separate
> write-only buffer of size 96 bytes, by itself; the fields errors,
> data_len, sense_len
> and residual in a single write-only buffer; and the status field is a
> separate readonly
> buffer of size 1 byte, by itself."
>
> Here 'status field of buffer size 1 byte' is whether readonly or
writeonly?

Writeonly

>
> I want to know from which version of Qemu-kvm supports processing of
> scsi commands over VirtIO block device as a backend.
> Although I checked the Host Feature fields in which VIRTIO_BLK_F_SCSI
> bit is set. I am using qemu-kvm version 0.12.3.

Make sure you have a scsi-generic block device in qemu-kvm, not just a
regular file or physical block device. Open /dev/sg.

Look at hw/virtio-blk.c in qemu-kvm for host implementation details.

>
> --
> Anuj Aggarwal
>
>  .''`.
> : :=E2=92=B6 :   # apt-get install hakuna-matata
> `. `'`
>    `-
>

--001636499c3fc496fe049745d79f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
On Dec 13, 2010 5:14 AM, &quot;=E0=A4=85=E0=A4=A8=E0=A5=81=E0=A4=9C&quot; &=
lt;<a href=3D"mailto:anuj01@gmail.com">anuj01@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi<br>
&gt;<br>
&gt; I am trying to implement VirtIO support for a proprietary OS. And It<b=
r>
&gt; would be great if I am able to process SCSI commands over VirtIO Block=
<br>
&gt; device.<br>
&gt;<br>
&gt; I tried to execute INQUIRY command but the status returned is UNSUPPOR=
TED.<br>
&gt; If anyone provide example VirtIO SCSI Command request structure for<br=
>
&gt; INQUIRY command as per VirtIO spec Appendix D would be a great help.<b=
r>
&gt;<br>
&gt; And also, the paragraph from VirtIO spec - 0.8.9 is confusing for me :=
<br>
&gt;<br>
&gt; &quot;Historically, devices assumed that the =C2=A0fields type, ioprio=
 and<br>
&gt; sector reside in<br>
&gt; a single, separate read-only buffer; the =C2=A0fields errors, data_len=
, sense_len and<br>
&gt; residual reside in a single, separate write-only buffer; the sense<br>
&gt; =C2=A0eld in a separate<br>
&gt; write-only buffer of size 96 bytes, by itself; the fields errors,<br>
&gt; data_len, sense_len<br>
&gt; and residual in a single write-only buffer; and the status field is a<=
br>
&gt; separate readonly<br>
&gt; buffer of size 1 byte, by itself.&quot;<br>
&gt;<br>
&gt; Here &#39;status field of buffer size 1 byte&#39; is whether readonly =
or writeonly?</p>
<p>Writeonly</p>
<p>&gt;<br>
&gt; I want to know from which version of Qemu-kvm supports processing of<b=
r>
&gt; scsi commands over VirtIO block device as a backend.<br>
&gt; Although I checked the Host Feature fields in which VIRTIO_BLK_F_SCSI<=
br>
&gt; bit is set. I am using qemu-kvm version 0.12.3.</p>
<p>Make sure you have a scsi-generic block device in qemu-kvm, not just a r=
egular file or physical block device. Open /dev/sg.</p>
<p>Look at hw/virtio-blk.c in qemu-kvm for host implementation details.</p>
<p>&gt;<br>
&gt; --<br>
&gt; Anuj Aggarwal<br>
&gt;<br>
&gt; =C2=A0.&#39;&#39;`.<br>
&gt; : :=E2=92=B6 :=C2=A0=C2=A0 # apt-get install hakuna-matata<br>
&gt; `. `&#39;`<br>
&gt; =C2=A0=C2=A0 `-<br>
&gt;<br>
</p>

--001636499c3fc496fe049745d79f--

--===============5278717429763121343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============5278717429763121343==--
