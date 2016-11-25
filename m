From: Yuan Liu <liuy139@gmail.com>
Subject: Re: [PATCH] virtio_mmio: Set dev.release() to avoid warning
Date: Thu, 24 Nov 2016 18:47:31 -0800
Message-ID: <CAOE4wo1qSeikjAyH-kFW2oZdZ1w2m1pbigjSr+jDx3E3V3tgrQ@mail.gmail.com>
References: <1479947460-9379-1-git-send-email-liuy139@gmail.com>
	<9eba9d6a-e70b-56ca-834f-83d99822fe0c@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6282956578038282581=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9eba9d6a-e70b-56ca-834f-83d99822fe0c@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, Yuan Liu <liuyuan@google.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

--===============6282956578038282581==
Content-Type: multipart/alternative; boundary=94eb2c0b0174bfa72e0542172402

--94eb2c0b0174bfa72e0542172402
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I think not. In virtio_pci_common, vp_dev is allocated by kzalloc so a
kfree is needed. Here vm_dev is allocated by devm_kmalloc which is
"automatically freed on driver detach" from the comment
(drivers/base/devres.c:769).

On Thu, Nov 24, 2016 at 6:37 PM, Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2016=E5=B9=B411=E6=9C=8824=E6=97=A5 08:31, Yuan Liu wrote:
>
>> From: Yuan Liu <liuyuan@google.com>
>>
>> Fix a warning thrown from virtio_mmio_remove():
>> Device 'virtio0' does not have a release() function
>>
>> The fix is according to virtio_pci_probe() of
>> drivers/virtio/virtio_pci_common.c
>>
>> Signed-off-by: Yuan Liu <liuyuan@google.com>
>> ---
>>   drivers/virtio/virtio_mmio.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
>> index 48bfea9..d47a2fc 100644
>> --- a/drivers/virtio/virtio_mmio.c
>> +++ b/drivers/virtio/virtio_mmio.c
>> @@ -489,6 +489,7 @@ static const struct virtio_config_ops
>> virtio_mmio_config_ops =3D {
>>   };
>>     +static void virtio_mmio_release_dev_empty(struct device *_d) {}
>>
>
> Do we need to free vm_dev here?
>
>
>     /* Platform device */
>>   @@ -511,6 +512,7 @@ static int virtio_mmio_probe(struct platform_devic=
e
>> *pdev)
>>                 return  -ENOMEM;
>>         vm_dev->vdev.dev.parent =3D &pdev->dev;
>> +       vm_dev->vdev.dev.release =3D virtio_mmio_release_dev_empty;
>>         vm_dev->vdev.config =3D &virtio_mmio_config_ops;
>>         vm_dev->pdev =3D pdev;
>>         INIT_LIST_HEAD(&vm_dev->virtqueues);
>>
>
>

--94eb2c0b0174bfa72e0542172402
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think not. In virtio_pci_common, vp_dev is allocated by =
kzalloc so a kfree is needed. Here vm_dev is allocated by devm_kmalloc whic=
h is &quot;automatically freed on driver detach&quot; from the comment (dri=
vers/base/devres.c:769).<br></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Thu, Nov 24, 2016 at 6:37 PM, Jason Wang <span dir=3D"l=
tr">&lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blank">jasowang@r=
edhat.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D""><br>
<br>
On 2016=E5=B9=B411=E6=9C=8824=E6=97=A5 08:31, Yuan Liu wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
From: Yuan Liu &lt;<a href=3D"mailto:liuyuan@google.com" target=3D"_blank">=
liuyuan@google.com</a>&gt;<br>
<br>
Fix a warning thrown from virtio_mmio_remove():<br>
Device &#39;virtio0&#39; does not have a release() function<br>
<br>
The fix is according to virtio_pci_probe() of<br>
drivers/virtio/virtio_pci_comm<wbr>on.c<br>
<br>
Signed-off-by: Yuan Liu &lt;<a href=3D"mailto:liuyuan@google.com" target=3D=
"_blank">liuyuan@google.com</a>&gt;<br>
---<br>
=C2=A0 drivers/virtio/virtio_mmio.c | 2 ++<br>
=C2=A0 1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c<br=
>
index 48bfea9..d47a2fc 100644<br>
--- a/drivers/virtio/virtio_mmio.c<br>
+++ b/drivers/virtio/virtio_mmio.c<br>
@@ -489,6 +489,7 @@ static const struct virtio_config_ops virtio_mmio_confi=
g_ops =3D {<br>
=C2=A0 };<br>
=C2=A0 =C2=A0 +static void virtio_mmio_release_dev_empty(<wbr>struct device=
 *_d) {}<br>
</blockquote>
<br></span>
Do we need to free vm_dev here?<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 /* Platform device */<br>
=C2=A0 @@ -511,6 +512,7 @@ static int virtio_mmio_probe(struct platform_dev=
ice *pdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return=C2=A0 -ENOME=
M;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm_dev-&gt;vdev.dev.parent =3D &amp;pdev-&gt;de=
v;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vm_dev-&gt;vdev.dev.release =3D virtio_mmio_rel=
ease_dev_empty;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm_dev-&gt;vdev.config =3D &amp;virtio_mmio_con=
fig_ops;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 vm_dev-&gt;pdev =3D pdev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&amp;vm_dev-&gt;virtqu<wbr>eues)=
;<br>
</blockquote>
<br>
</div></div></blockquote></div><br></div>

--94eb2c0b0174bfa72e0542172402--

--===============6282956578038282581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6282956578038282581==--
