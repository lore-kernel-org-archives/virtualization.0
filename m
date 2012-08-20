From: McPacino <mcpacino@gmail.com>
Subject: Re: [PATCH] virtio-scsi spec: add per-LUN parameter query
Date: Mon, 20 Aug 2012 22:44:16 +0800
Message-ID: <CAOKNXO7PLs8ansCf0YajruO=yX8B_FAeZ==iuYwN2mAqoOLVuQ@mail.gmail.com>
References: <1345453404-15244-1-git-send-email-mc@linux.vnet.ibm.com>
	<50323926.8000205@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4101280328984521091=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50323926.8000205@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

--===============4101280328984521091==
Content-Type: multipart/alternative; boundary=f46d043890c54af01004c7b38bc3

--f46d043890c54af01004c7b38bc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2012-8-20 =E4=B8=8B=E5=8D=889:18=EF=BC=8C"Paolo Bonzini" <pbonzin=
i@redhat.com>=E5=86=99=E9=81=93=EF=BC=9A
>
> Il 20/08/2012 11:03, Cong Meng ha scritto:
> > Each virtio scsi HBA has global request queue limits. But the
passthrough
> > LUNs (scsi-generic) come from different host HBAs may have different
request
> > queue limits. If the guest sends commands that exceed the host limits,
the
> > commands will be rejected by host HAB.
> >
> > To address this issue, this patch adds a per-LUN parameter query via
the control
> > queue, and defines some parameter query types. The driver can query and
set the
> > needed per-LUN parameters if the device enables this feature.
> >
> > Signed-off-by: Cong Meng <mc@linux.vnet.ibm.com>
> > --
> >  virtio-spec.lyx |  218
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 218 insertions(+), 0 deletions(-)
>
> Do you have kernel and QEMU patches for this?  That would help me
> evaluate whether the interface is the correct one.
>
yes,I have a demo. I will post it after I polish it tomorrow.

> In any case, I'd rather have a single command returning all three values
> (VIRTIO_SCSI_T_LUN_QUEUE_PARAMS), since it's unlikely that you need just
> one.

I intend to seperat them one by one. As there is opportunity that other new
parameters are needed for other features.

Thanks.
Cong.

>
> Paolo
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

--f46d043890c54af01004c7b38bc3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
=E5=9C=A8 2012-8-20 =E4=B8=8B=E5=8D=889:18=EF=BC=8C&quot;Paolo Bonzini&quot=
; &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;=E5=
=86=99=E9=81=93=EF=BC=9A<br>
&gt;<br>
&gt; Il 20/08/2012 11:03, Cong Meng ha scritto:<br>
&gt; &gt; Each virtio scsi HBA has global request queue limits. But the pas=
sthrough<br>
&gt; &gt; LUNs (scsi-generic) come from different host HBAs may have differ=
ent request<br>
&gt; &gt; queue limits. If the guest sends commands that exceed the host li=
mits, the<br>
&gt; &gt; commands will be rejected by host HAB.<br>
&gt; &gt;<br>
&gt; &gt; To address this issue, this patch adds a per-LUN parameter query =
via the control<br>
&gt; &gt; queue, and defines some parameter query types. The driver can que=
ry and set the<br>
&gt; &gt; needed per-LUN parameters if the device enables this feature.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Cong Meng &lt;<a href=3D"mailto:mc@linux.vnet.ibm.=
com">mc@linux.vnet.ibm.com</a>&gt;<br>
&gt; &gt; --<br>
&gt; &gt; =C2=A0virtio-spec.lyx | =C2=A0218 +++++++++++++++++++++++++++++++=
++++++++++++++++++++++++<br>
&gt; &gt; =C2=A01 files changed, 218 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; Do you have kernel and QEMU patches for this? =C2=A0That would help me=
<br>
&gt; evaluate whether the interface is the correct one.<br>
&gt;<br>
yes,I have a demo. I will post it after I polish it tomorrow.</p>
<p dir=3D"ltr">&gt; In any case, I&#39;d rather have a single command retur=
ning all three values<br>
&gt; (VIRTIO_SCSI_T_LUN_QUEUE_PARAMS), since it&#39;s unlikely that you nee=
d just<br>
&gt; one.</p>
<p dir=3D"ltr">I intend to seperat them one by one. As there is opportunity=
 that other new parameters are needed for other features.</p>
<p dir=3D"ltr">Thanks.<br>
Cong.</p>
<p dir=3D"ltr">&gt;<br>
&gt; Paolo<br>
&gt; _______________________________________________<br>
&gt; Virtualization mailing list<br>
&gt; <a href=3D"mailto:Virtualization@lists.linux-foundation.org">Virtualiz=
ation@lists.linux-foundation.org</a><br>
&gt; <a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/virtuali=
zation">https://lists.linuxfoundation.org/mailman/listinfo/virtualization</=
a><br>
</p>

--f46d043890c54af01004c7b38bc3--

--===============4101280328984521091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4101280328984521091==--
