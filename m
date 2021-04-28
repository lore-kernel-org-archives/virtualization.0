Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB8C433B4
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 13:55:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBF061441
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 13:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBF061441
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codilime.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 83EF3400D4;
	Wed, 28 Apr 2021 13:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KYnvPMwgo85j; Wed, 28 Apr 2021 13:55:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C3F824036F;
	Wed, 28 Apr 2021 13:55:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 985B0C001C;
	Wed, 28 Apr 2021 13:55:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6A3CC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 13:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C59CC400D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 13:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YuSH290kgGjU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 13:55:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 309864036F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 13:55:49 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id m11so616689pfc.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codilime.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qe7+Nu5Mp5VWNz1k5MmelGwOIs2NLmoKtt+c2+rGQu0=;
 b=Y1fcHOPpIPG9fSvvisRB/GnhWmQpa/s2RIP3UhKLylzAuCoVIS0zI86W/+uFBVlM6w
 EoT7cnMxKEWzN6ZEl1+hXafxTKLgk06ekJvJwLvJF+Fb98k7vVW2nJ++HTSndKlV9UdK
 kdCrauVmcS7k7KfCg0Nd0oLZRCZn7CxgDw32l/1Kg0quuRrvzf5R0NgHYq54381PWw5a
 UsjfzboojjJOKuSrpRDGuT5BvK+1GkU5YXzGyiGVToQSXvQUfLnF9Apb2mdj4gY0ydcv
 7LJwycHDXF+DPZpaq/ClPiisU9b4V7s7+2aXm2GR9AdOHIYxSCfRc+IDnH//EIXAwMN6
 V7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qe7+Nu5Mp5VWNz1k5MmelGwOIs2NLmoKtt+c2+rGQu0=;
 b=BJLsRNZXsSoiOnwrI4EbJIs7IjEtrx3p/RbZlkA8kWUgRBKAPqJYURkcn6flT0Pczh
 RuIcVzPz87S4QHnv42BT/Mh5umy5nDhTxXJVEC5ho7YeAnqrcwEtGQV9vq6JcyPTvujE
 YB9pQKeeJN+TddBfTHYtXFNJw1XRdZWKCT1ApWU7hGIFKoquQ++UrZen6EyG5lTGS2hX
 o1ZEYVjx4ri8NQJesQcsoNnnz74zJiNA1atL53dL/5M483dLdM0hPL+TPDodOvOvMzLu
 ZwcdFHij+QkhyR/RdWVAx0QR9859UrBjUzLfL/b1WesDgpmilgCa9n4EUdiP8bqWU8Yn
 g/Qw==
X-Gm-Message-State: AOAM532K3ilZNPYTLrP+vbT2QjThTTiMNPjqZDbNYMNjjp3nyISSjT/A
 lJLD2poZ1D25Jj/Cxx17Y9ZTUwHi4Bb5inDkd8XWXw6e/pNRPz0YDKxzms8xjAvgQFBOBx9iImF
 gLgJbApgT9vJ7P50A/r//47AcBcEz7V1umGdXki/nutWDQ4LIOdY=
X-Google-Smtp-Source: ABdhPJzvZCAxNsCRNMYukgJXToJchRvvg2RD+xqNUaBYTDWNmU25TqmqFHaDrpYmz2076+3LitdImP7NC0nunGdueH8=
X-Received: by 2002:a05:6a00:be3:b029:254:799:27f with SMTP id
 x35-20020a056a000be3b02902540799027fmr28934429pfu.48.1619618148458; Wed, 28
 Apr 2021 06:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210426102135.227802-1-arkadiusz.kudan@codilime.com>
 <625a6618-bb59-8ccc-bf1c-e29ac556b590@redhat.com>
 <MWHPR1101MB209476B1939ADB73C57E71AC9E409@MWHPR1101MB2094.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR1101MB209476B1939ADB73C57E71AC9E409@MWHPR1101MB2094.namprd11.prod.outlook.com>
From: Arkadiusz Kudan <arkadiusz.kudan@codilime.com>
Date: Wed, 28 Apr 2021 15:57:37 +0200
Message-ID: <CAFSqgu1sX+t2hfQpbtDxOanRNd2y58GuR7=omSt0=DviwRGc6g@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: enable SRIOV
To: "Walukiewicz, Miroslaw" <Miroslaw.Walukiewicz@intel.com>,
 Jason Wang <jasowang@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Jayagopi,
 Geetha" <geetha.jayagopi@intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5625587160242127215=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5625587160242127215==
Content-Type: multipart/alternative; boundary="000000000000695e0e05c108bcf5"

--000000000000695e0e05c108bcf5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Also i would like to add another issue, that is location of 'net' sysfs
inside PCI devices sysfs. Libvirt also expects to find folder
'/sys/bus/pci/devices/<PF addr>/net' to get corresponding network
interface.
However, for virtio-net managed devices, the 'net' folder is located in
virtioX folder, i.e. '/sys/bus/pci/devices/<PF addr>/virtioX/net'.

AFAIK it is due to how sysfs works and usage of virtual bus in virtio
driver implementation, or am i wrong?
Is there any way to create somehow some symlink e.g. for this case, so
libvirt finds it?

Regarding the ndo_* SRIOV callbacks, a proper implementation would actually
need to tell the PF the VF config somehow. How would virtio-net do that?
Wouldn't that need extending virtio specification? Or is it worked on for
virtio 1.2? (AFAIK it isn't released yet)

Thanks and regards,
AK


On Wed, Apr 28, 2021 at 3:33 PM Walukiewicz, Miroslaw <
Miroslaw.Walukiewicz@intel.com> wrote:

> HI Jason,
>
> You are right here. We did not catch your change in driver and the SRIOV
> flag is set correctly as you stated.
>
> We want to orchestrate the HW implementation of VFs and PFs for virtio-ne=
t
> using libvirt.
>
> The issue that we want to resolve is that there is no .ndo_get_vf_config
> Callback implemented in virtio-net driver as other NIC's drivers have,
> called by libvirt.
> See
> https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/intel/=
igb/igb_main.c#L2996,
> for example
> This callback really should create a minimal configuration inside of
> driver, but we cannot avoid it.
>
> Another issue is lack of sysfs fro virtual functions
> /sys/class/net/ens801f0/device/virtfnX (where X is VF number and ens801fo
> is its PF netdev),
>
> Could you advise us, how we can solve our issue and drive us to proper
> solution?
>
> Regards,
>
> Mirek
> -----Original Message-----
> From: Jason Wang <jasowang@redhat.com>
> Sent: wtorek, 27 kwietnia 2021 04:44
> To: Arkadiusz Kudan <arkadiusz.kudan@codilime.com>;
> virtualization@lists.linux-foundation.org
> Cc: mst@redhat.com; netdev@vger.kernel.org; Walukiewicz, Miroslaw <
> Miroslaw.Walukiewicz@intel.com>
> Subject: Re: [PATCH] virtio-net: enable SRIOV
>
>
> =E5=9C=A8 2021/4/26 =E4=B8=8B=E5=8D=886:21, Arkadiusz Kudan =E5=86=99=E9=
=81=93:
> > With increasing interest for virtio, NIC have appeared that provide
> > SRIOV with PF appearing in the host as a virtio network device and
> > probably more similiar NICs will emerge.
> > igb_uio of DPDK or pci-pf-stub can be used to provide SRIOV, however
> > there are hypervisors/VMMs that require VFs, which are to be PCI
> > passthrued to a VM, to have its PF with network representation in the
> > kernel. For virtio-net based PFs, virtio-net could do that by
> > providing both SRIOV interface and netdev representation.
> >
> > Enable SRIOV via VIRTIO_F_SR_IOV feature bit if the device supports
> > it.
> >
> > Signed-off-by: Arkadiusz Kudan <arkadiusz.kudan@codilime.com>
> > Signed-off-by: Miroslaw Walukiewicz <Miroslaw.Walukiewicz@intel.com>
> > ---
> >   drivers/net/virtio_net.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > 0824e6999e49..a03aa7e99689 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3249,6 +3249,7 @@ static struct virtio_device_id id_table[] =3D {
> >
> >   static unsigned int features[] =3D {
> >       VIRTNET_FEATURES,
> > +     VIRTIO_F_SR_IOV,
> >   };
>
>
> So I'm suprised that it needs to be enabled per device. We had:
>
> static void vp_transport_features(struct virtio_device *vdev, u64
> features) {
>          struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>          struct pci_dev *pci_dev =3D vp_dev->pci_dev;
>
>          if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
>                          pci_find_ext_capability(pci_dev,
> PCI_EXT_CAP_ID_SRIOV))
>                  __virtio_set_bit(vdev, VIRTIO_F_SR_IOV); }
>
> And I had used this driver for SRIOV virtio-pci hardware for more than on=
e
> year.
>
> Thanks
>
>
> >
> >   static unsigned int features_legacy[] =3D {
>
>

--=20

Arkadiusz Kudan

Software Engineer

spiritualrage@gmail.com
[image: Logo Codilime]
<http://www.codilime.com/?utm_source=3DStopka&utm_medium=3DEmail&utm_campai=
gn=3DStopka>

[image: Logo Facebook] <https://www.facebook.com/codilime/> [image: Logo
Linkedin] <https://www.linkedin.com/company/codilime> [image: Logo Twitter]
<https://twitter.com/codilime>

CodiLime Sp. z o.o. - Ltd. company with its registered office in Poland,
02-493 Warsaw, ul. Krancowa 5.
Registered by The District Court for the Capital City of Warsaw,
XII Commercial Department of the National Court Register.
Entered into National Court Register under No. KRS 0000388871.
Tax identification number (NIP) 5272657478. Statistical number (REGON)
142974628.

--=20


-------------------------------
This document contains material that is=20
confidential in CodiLime Sp. z o.o. DO NOT PRINT. DO NOT COPY. DO NOT=20
DISTRIBUTE. If you are not the intended recipient of this document, be=20
aware that any use, review, retransmission, distribution, reproduction or=
=20
any action taken in reliance upon this message is strictly prohibited. If=
=20
you received this in error, please contact the sender and help@codilime.com=
=20
<mailto:help@codilime.com>. Return the paper copy, delete the material from=
=20
all computers and storage media.

--000000000000695e0e05c108bcf5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi Jason,<br><br></div>Also i would li=
ke to add another issue, that is location of &#39;net&#39; sysfs inside PCI=
 devices sysfs. Libvirt also expects to find folder &#39;/sys/bus/pci/devic=
es/&lt;PF addr&gt;/net&#39; to get corresponding network interface. <br></d=
iv>However, for virtio-net managed devices, the &#39;net&#39; folder is loc=
ated in virtioX folder, i.e. &#39;/sys/bus/pci/devices/&lt;PF addr&gt;/virt=
ioX/net&#39;. <br><br>AFAIK it is due to how sysfs works and usage of virtu=
al bus in virtio driver implementation, or am i wrong?<br></div>Is there an=
y way to create somehow some symlink e.g. for this case, so libvirt finds i=
t?<br><br></div><div>Regarding the ndo_* SRIOV callbacks, a proper implemen=
tation would actually need to tell the PF the VF config somehow. How would =
virtio-net do that? <br>Wouldn&#39;t that need extending virtio specificati=
on? Or is it worked on for virtio 1.2? (AFAIK it isn&#39;t released yet)<br=
></div><div><br></div><div>Thanks and regards,<br></div><div>AK<br></div><d=
iv><br></div> </div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Apr 28, 2021 at 3:33 PM Walukiewicz, Miroslaw &lt;<=
a href=3D"mailto:Miroslaw.Walukiewicz@intel.com">Miroslaw.Walukiewicz@intel=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">HI Jason, <br>
<br>
You are right here. We did not catch your change in driver and the SRIOV fl=
ag is set correctly as you stated.<br>
<br>
We want to orchestrate the HW implementation of VFs and PFs for virtio-net =
using libvirt. <br>
<br>
The issue that we want to resolve is that there is no .ndo_get_vf_config Ca=
llback implemented in virtio-net driver as other NIC&#39;s drivers have, ca=
lled by libvirt. <br>
See <a href=3D"https://github.com/torvalds/linux/blob/master/drivers/net/et=
hernet/intel/igb/igb_main.c#L2996" rel=3D"noreferrer" target=3D"_blank">htt=
ps://github.com/torvalds/linux/blob/master/drivers/net/ethernet/intel/igb/i=
gb_main.c#L2996</a>, for example <br>
This callback really should create a minimal configuration inside of driver=
, but we cannot avoid it. <br>
<br>
Another issue is lack of sysfs fro virtual functions /sys/class/net/ens801f=
0/device/virtfnX (where X is VF number and ens801fo is its PF netdev), <br>
<br>
Could you advise us, how we can solve our issue and drive us to proper solu=
tion?<br>
<br>
Regards,<br>
<br>
Mirek <br>
-----Original Message-----<br>
From: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"_blan=
k">jasowang@redhat.com</a>&gt; <br>
Sent: wtorek, 27 kwietnia 2021 04:44<br>
To: Arkadiusz Kudan &lt;<a href=3D"mailto:arkadiusz.kudan@codilime.com" tar=
get=3D"_blank">arkadiusz.kudan@codilime.com</a>&gt;; <a href=3D"mailto:virt=
ualization@lists.linux-foundation.org" target=3D"_blank">virtualization@lis=
ts.linux-foundation.org</a><br>
Cc: <a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>;=
 <a href=3D"mailto:netdev@vger.kernel.org" target=3D"_blank">netdev@vger.ke=
rnel.org</a>; Walukiewicz, Miroslaw &lt;<a href=3D"mailto:Miroslaw.Walukiew=
icz@intel.com" target=3D"_blank">Miroslaw.Walukiewicz@intel.com</a>&gt;<br>
Subject: Re: [PATCH] virtio-net: enable SRIOV<br>
<br>
<br>
=E5=9C=A8 2021/4/26 =E4=B8=8B=E5=8D=886:21, Arkadiusz Kudan =E5=86=99=E9=81=
=93:<br>
&gt; With increasing interest for virtio, NIC have appeared that provide <b=
r>
&gt; SRIOV with PF appearing in the host as a virtio network device and <br=
>
&gt; probably more similiar NICs will emerge.<br>
&gt; igb_uio of DPDK or pci-pf-stub can be used to provide SRIOV, however <=
br>
&gt; there are hypervisors/VMMs that require VFs, which are to be PCI <br>
&gt; passthrued to a VM, to have its PF with network representation in the =
<br>
&gt; kernel. For virtio-net based PFs, virtio-net could do that by <br>
&gt; providing both SRIOV interface and netdev representation.<br>
&gt;<br>
&gt; Enable SRIOV via VIRTIO_F_SR_IOV feature bit if the device supports <b=
r>
&gt; it.<br>
&gt;<br>
&gt; Signed-off-by: Arkadiusz Kudan &lt;<a href=3D"mailto:arkadiusz.kudan@c=
odilime.com" target=3D"_blank">arkadiusz.kudan@codilime.com</a>&gt;<br>
&gt; Signed-off-by: Miroslaw Walukiewicz &lt;<a href=3D"mailto:Miroslaw.Wal=
ukiewicz@intel.com" target=3D"_blank">Miroslaw.Walukiewicz@intel.com</a>&gt=
;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/net/virtio_net.c | 1 +<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index=
 <br>
&gt; 0824e6999e49..a03aa7e99689 100644<br>
&gt; --- a/drivers/net/virtio_net.c<br>
&gt; +++ b/drivers/net/virtio_net.c<br>
&gt; @@ -3249,6 +3249,7 @@ static struct virtio_device_id id_table[] =3D {<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static unsigned int features[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTNET_FEATURES,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0VIRTIO_F_SR_IOV,<br>
&gt;=C2=A0 =C2=A0};<br>
<br>
<br>
So I&#39;m suprised that it needs to be enabled per device. We had:<br>
<br>
static void vp_transport_features(struct virtio_device *vdev, u64 features)=
 {<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct virtio_pci_device *=
vp_dev =3D to_vp_device(vdev);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *pci_dev =
=3D vp_dev-&gt;pci_dev;<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((features &amp; BIT_UL=
L(VIRTIO_F_SR_IOV)) &amp;&amp;<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_f=
ind_ext_capability(pci_dev,<br>
PCI_EXT_CAP_ID_SRIOV))<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 __virtio_set_bit(vdev, VIRTIO_F_SR_IOV); }<br>
<br>
And I had used this driver for SRIOV virtio-pci hardware for more than one =
year.<br>
<br>
Thanks<br>
<br>
<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static unsigned int features_legacy[] =3D {<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr">
				=09
				=09
				=09
				=09
				=09
				=09
				=09
			       <table><tbody><tr><td><p style=3D"font-family:&quot;Helvetica Neu=
e&quot;,Helvetica,Arial,sans-serif;font-size:14px;font-weight:bold;margin:0=
px;line-height:1.2em">Arkadiusz Kudan</p>
						</td></tr><tr>
						<td>
							<p style=3D"font-family:&quot;Helvetica Neue&quot;,Helvetica,Arial,s=
ans-serif;font-size:12px;margin:0px;line-height:1.2em">Software Engineer</p=
>
						</td>
					</tr><tr>
						<td>
						=09
						<br></td>
					</tr><tr>
						<td>
							<p style=3D"font-family:&quot;Helvetica Neue&quot;,Helvetica,Arial,s=
ans-serif;text-decoration:none;color:rgb(0,0,0);display:block;font-size:12p=
x;margin:0px;line-height:1.2em"><a href=3D"mailto:spiritualrage@gmail.com" =
target=3D"_blank">spiritualrage@gmail.com</a></p>
						</td>
					</tr><tr style=3D"padding-bottom:10px">
						<td>
							<a href=3D"http://www.codilime.com/?utm_source=3DStopka&amp;utm_medi=
um=3DEmail&amp;utm_campaign=3DStopka" target=3D"_blank"><img src=3D"https:/=
/img.codilime.com/codilime_460.png" alt=3D"Logo Codilime" style=3D"width: 1=
38px; padding-top: 20px; margin-bottom: 10px;"></a>
						</td>
					</tr><tr>
						<td>
							<p>
		             <a href=3D"https://www.facebook.com/codilime/" target=3D"_bl=
ank">
		             <img src=3D"https://img.codilime.com/facebook_104.png" alt=
=3D"Logo Facebook" style=3D"width: 26px; height: 26px; margin-right: 7px;">=
</a>
		             <a href=3D"https://www.linkedin.com/company/codilime" target=
=3D"_blank">
		             <img src=3D"https://img.codilime.com/linkedin_104.png" alt=
=3D"Logo Linkedin" style=3D"width: 26px; height: 26px; margin-right: 7px;">=
</a>
		             <a href=3D"https://twitter.com/codilime" target=3D"_blank">
		             <img src=3D"https://img.codilime.com/twitter_104.png" alt=3D=
"Logo Twitter" style=3D"width: 26px; height: 26px;"></a>
		          </p>
						</td>
					</tr><tr><td>
			          <p style=3D"margin:0px;line-height:1.2em;font-size:7.5pt;font-=
family:Calibri,sans-serif;color:rgb(204,204,204)">CodiLime=C2=A0Sp.=C2=A0z=
=C2=A0o.o. - Ltd.=C2=A0company with its=C2=A0registered office in=C2=A0Pola=
nd, 02-493 Warsaw, ul.=C2=A0Krancowa=C2=A05.<br>Registered by=C2=A0The=C2=
=A0District Court for=C2=A0the=C2=A0Capital City of=C2=A0Warsaw, XII=C2=A0C=
ommercial Department of=C2=A0the=C2=A0National Court Register.<br>Entered
 into National Court Register under No.=C2=A0KRS=C2=A00000388871.=20
Tax=C2=A0identification number (NIP) 5272657478. Statistical number (REGON)=
=20
142974628.</p></td></tr></tbody></table></div></div>

<br>
<p style=3D"font-family:Calibri;font-size:1.3em;margin:0cm 0cm 0.0001pt"><i=
mg></p><span style=3D"font-family:Calibri,sans-serif;font-size:1.3em;color:=
rgb(118,247,3)"><font size=3D"1"><div><span style=3D"color:rgb(204,204,204)=
;font-size:9px;background-color:rgb(255,255,255)">-------------------------=
-----<wbr>-</span></div></font></span><div style=3D"font-family:Arial,Helve=
tica,sans-serif"><span style=3D"color:rgb(204,204,204);font-family:Calibri,=
sans-serif;background-color:rgb(255,255,255)"><font size=3D"1">This documen=
t contains material that is confidential in CodiLime Sp. z o.o. DO NOT PRIN=
T. DO NOT COPY. DO NOT DISTRIBUTE. If you are not the intended recipient of=
 this document, be aware that any use, review, retransmission, distribution=
, reproduction or any action taken in reliance upon this message is strictl=
y prohibited. If you received this in error, please contact the sender and =
<a href=3D"mailto:help@codilime.com" target=3D"_blank">help@codilime.com</a=
>. Return the paper copy, delete the material from all computers and storag=
e media.</font></span></div>
--000000000000695e0e05c108bcf5--

--===============5625587160242127215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5625587160242127215==--
