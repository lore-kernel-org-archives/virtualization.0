Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF11AC433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 07:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BC368349A;
	Wed,  9 Mar 2022 07:45:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxnReoEACia7; Wed,  9 Mar 2022 07:45:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E583F8283D;
	Wed,  9 Mar 2022 07:45:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6152C001D;
	Wed,  9 Mar 2022 07:45:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65935C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5940C8349A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lVKt4SwEBYYk
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:45:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D3E88283D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 07:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646811918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shnlbO2A3mjmLUKm5QnWhD/RjqpKfM31LBoGyH/wW6M=;
 b=HMITw6Seallq6EewtNJTzw64hT58Ort3mh0LTSed2pbiMcdo7rGv9jhu2mQqe2NZ5d4tsB
 +4ciAVp6aNUWHcmJeqOgg9bglGiIYcJikmc1wAkLd9Dxmf0/So1Bi3e8vxoBca/P2G6vWi
 bw/IYFcnw3mh8hIrslS/tH6N1+SPEmc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-UG2qpX--OhCCDrgsDs0J0w-1; Wed, 09 Mar 2022 02:45:16 -0500
X-MC-Unique: UG2qpX--OhCCDrgsDs0J0w-1
Received: by mail-lf1-f69.google.com with SMTP id
 d40-20020a0565123d2800b004482625da41so531984lfv.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 23:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=shnlbO2A3mjmLUKm5QnWhD/RjqpKfM31LBoGyH/wW6M=;
 b=bBIWGSuWM4paSoJxo1VVtZ7hPQpb/UFWheFCfF+Tniw/8eyxihb3KPfzZEzrzbI55w
 ETiYcT8AlAbLD/jdijkvLEdXgagx7hadHmnm/b3oYAHom9Y2vqUc8o3docYU03xL4bSf
 vzyD0/obdTXxfsIJRi422uK9S3z6p+xUny6/w0HU0vDYAawWRk72UfkioIbHobw0Wqp8
 SoItxiuGBPimypSc3aJBKW0y0oaf0kKYT2smeZe2qqJE7eSLFXsPru1Z8sSCPHJsZVno
 keQNE+SjcqqiLAujdyIwMQD9TbJfMljdTfkgpIWOISpEI9U5D4RGz76RS9wTxq0ad0Vm
 xw7w==
X-Gm-Message-State: AOAM532oqii7ozP9JuPfrT5PLO8CCklThcHu3cEvxHTUksZWekNmmCoH
 kk9Hg1nKgH7M0L44q/JR95zgrLK7m+fStAcwMN+VDnu6tWZN03ckpQOTnMeTrnX3x/8Ina0V4sD
 MLKhaa15x76X3+aNRgBORs0gpJwnGoRq9p3W70mPUz6JK4pbisEo/2Qah1Q==
X-Received: by 2002:ac2:4c4f:0:b0:448:21cd:596f with SMTP id
 o15-20020ac24c4f000000b0044821cd596fmr13357391lfk.257.1646811914918; 
 Tue, 08 Mar 2022 23:45:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+iU6LcSVPqbW7uHCanSX+7wkcd3FYrOE1sjOtn2SgH6/1QPaUKwWpe+GMlQAO4l6MS7pJi0REnmvGFWAWnhU=
X-Received: by 2002:ac2:4c4f:0:b0:448:21cd:596f with SMTP id
 o15-20020ac24c4f000000b0044821cd596fmr13357370lfk.257.1646811914715; Tue, 08
 Mar 2022 23:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20220308020348-mutt-send-email-mst@kernel.org>
 <CACGkMEvY-+XpPWbtiX9dy+fwDxPp7sHFhH_LY0PB2YuusEugyw@mail.gmail.com>
 <20220308022300-mutt-send-email-mst@kernel.org>
 <CACGkMEvuTPCRk7Ng7CbgpPSPgs_QYijzc5fU+cV3kW09W1R7Qg@mail.gmail.com>
 <20220308024724-mutt-send-email-mst@kernel.org>
 <CACGkMEsPBDM8ko1qgnCR1DcofPNJJo3S2j3pOJHk4xaSGQimcQ@mail.gmail.com>
 <20220308054623-mutt-send-email-mst@kernel.org>
 <CAJaqyWcuitG+01pjO__tYERN9910fL_JGiHG88xU=fTG3KmpJw@mail.gmail.com>
 <20220308071253-mutt-send-email-mst@kernel.org>
 <56b837a6-c67d-5ffc-bd70-ba51d996a6c2@redhat.com>
 <20220309023020-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220309023020-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Mar 2022 15:45:03 +0800
Message-ID: <CACGkMEvsoJf3rXUe_CD3O4pwYf4=uLvAFOkdCaAOCEmnkNyKMA@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] vDPA shadow virtqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: qemu-devel <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Lingshan <lingshan.zhu@intel.com>
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
Content-Type: multipart/mixed; boundary="===============4097744569903831426=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4097744569903831426==
Content-Type: multipart/alternative; boundary="00000000000030630505d9c44715"

--00000000000030630505d9c44715
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 9, 2022 at 3:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Mar 09, 2022 at 11:38:35AM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/3/8 =E4=B8=8B=E5=8D=888:16, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> > > On Tue, Mar 08, 2022 at 12:37:33PM +0100, Eugenio Perez Martin wrote:
> > > > On Tue, Mar 8, 2022 at 11:48 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > > > > On Tue, Mar 08, 2022 at 04:20:53PM +0800, Jason Wang wrote:
> > > > > > > Not by itself but I'm not sure we can guarantee guest will no=
t
> > > > > > > attempt to use the IOVA addresses we are reserving down
> > > > > > > the road.
> > > > > > The IOVA is allocated via the listeners and stored in the iova
> tree
> > > > > > per GPA range as IOVA->(GPA)->HVA.Guests will only see GPA, Qem=
u
> > > > > > virtio core see GPA to HVA mapping. And we do a reverse lookup
> to find
> > > > > > the HVA->IOVA we allocated previously.  So we have double check
> here:
> > > > > >
> > > > > > 1) Qemu memory core to make sure the GPA that guest uses is val=
id
> > > > > > 2) the IOVA tree that guarantees there will be no HVA beyond wh=
at
> > > > > > guest can see is used
> > > > > >
> > > > > > So technically, there's no way for the guest to use the IOVA
> address
> > > > > > allocated for the shadow virtqueue.
> > > > > >
> > > > > > Thanks
> > > > > I mean, IOVA is programmed in the host hardware to translate to
> HPA, right?
> > > > >
> > > > Yes, that's right if the device uses physical maps. Also to note, S=
VQ
> > > > vring is allocated in multiples of host huge pages to avoid garbage
> or
> > > > unintended access from the device.
> > > >
> > > > If a vdpa device uses physical addresses, kernel vdpa will pin qemu
> > > > memory first and then will send IOVA to HPA translation to hardware=
.
> > > > But this IOVA space is not controlled by the guest, but by SVQ. If =
a
> > > > guest's virtqueue buffer cannot be translated first to GPA, it will
> > > > not be forwarded.
> > > >
> > > > Thanks!
> > > Right. So if guests send a buffer where buffer address overlaps the
> > > range we used for the SVQ, then I think at the moment guest won't wor=
k.
> >
> >
> > There's no way for a guest to do this, it can only use GPA
>
> With a vIOMMU it can.
>

It should be the same or I may miss something.

With a vIOMMU, vDPA devices still won't use gIOVA. Instead the device will
use the IOVA that is managed by the Qemu.

Listeners: IOVA->HVA
Qemu virtqueue helper: gIOVA->GPA->HVA
SVQ: HVA->IOVA

So SVQ will use an IOVA that is overlapped with gIOVA/GPA

Thanks


>
> > but the Qemu
> > won't let vDPA to use GPA as IOVA. Dedicated IOVA ranges were allocated
> for
> > those GPA ranges so SVQ won't use IOVA that is overlapped with what Gue=
st
> > use.
> >
> > Thanks
> >
> >
> > >
>
>

--00000000000030630505d9c44715
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 9, 2022 at 3:30 PM Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Ma=
r 09, 2022 at 11:38:35AM +0800, Jason Wang wrote:<br>
&gt; <br>
&gt; =E5=9C=A8 2022/3/8 =E4=B8=8B=E5=8D=888:16, Michael S. Tsirkin =E5=86=
=99=E9=81=93:<br>
&gt; &gt; On Tue, Mar 08, 2022 at 12:37:33PM +0100, Eugenio Perez Martin wr=
ote:<br>
&gt; &gt; &gt; On Tue, Mar 8, 2022 at 11:48 AM Michael S. Tsirkin &lt;<a hr=
ef=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote=
:<br>
&gt; &gt; &gt; &gt; On Tue, Mar 08, 2022 at 04:20:53PM +0800, Jason Wang wr=
ote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; Not by itself but I&#39;m not sure we can gua=
rantee guest will not<br>
&gt; &gt; &gt; &gt; &gt; &gt; attempt to use the IOVA addresses we are rese=
rving down<br>
&gt; &gt; &gt; &gt; &gt; &gt; the road.<br>
&gt; &gt; &gt; &gt; &gt; The IOVA is allocated via the listeners and stored=
 in the iova tree<br>
&gt; &gt; &gt; &gt; &gt; per GPA range as IOVA-&gt;(GPA)-&gt;HVA.Guests wil=
l only see GPA, Qemu<br>
&gt; &gt; &gt; &gt; &gt; virtio core see GPA to HVA mapping. And we do a re=
verse lookup to find<br>
&gt; &gt; &gt; &gt; &gt; the HVA-&gt;IOVA we allocated previously.=C2=A0 So=
 we have double check here:<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; 1) Qemu memory core to make sure the GPA that gues=
t uses is valid<br>
&gt; &gt; &gt; &gt; &gt; 2) the IOVA tree that guarantees there will be no =
HVA beyond what<br>
&gt; &gt; &gt; &gt; &gt; guest can see is used<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; So technically, there&#39;s no way for the guest t=
o use the IOVA address<br>
&gt; &gt; &gt; &gt; &gt; allocated for the shadow virtqueue.<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; &gt; I mean, IOVA is programmed in the host hardware to tran=
slate to HPA, right?<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; Yes, that&#39;s right if the device uses physical maps. Also=
 to note, SVQ<br>
&gt; &gt; &gt; vring is allocated in multiples of host huge pages to avoid =
garbage or<br>
&gt; &gt; &gt; unintended access from the device.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; If a vdpa device uses physical addresses, kernel vdpa will p=
in qemu<br>
&gt; &gt; &gt; memory first and then will send IOVA to HPA translation to h=
ardware.<br>
&gt; &gt; &gt; But this IOVA space is not controlled by the guest, but by S=
VQ. If a<br>
&gt; &gt; &gt; guest&#39;s virtqueue buffer cannot be translated first to G=
PA, it will<br>
&gt; &gt; &gt; not be forwarded.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Thanks!<br>
&gt; &gt; Right. So if guests send a buffer where buffer address overlaps t=
he<br>
&gt; &gt; range we used for the SVQ, then I think at the moment guest won&#=
39;t work.<br>
&gt; <br>
&gt; <br>
&gt; There&#39;s no way for a guest to do this, it can only use GPA<br>
<br>
With a vIOMMU it can.<br></blockquote><div><br></div><div>It should be the =
same or I may miss something.</div><div><br></div><div>With a vIOMMU, vDPA =
devices still won&#39;t use gIOVA. Instead the device will use the IOVA tha=
t is managed by the Qemu.</div><div><br></div><div>Listeners: IOVA-&gt;HVA<=
/div><div>Qemu virtqueue helper: gIOVA-&gt;GPA-&gt;HVA</div><div>SVQ: HVA-&=
gt;IOVA</div><div><br></div><div>So SVQ will use an IOVA that is overlapped=
 with gIOVA/GPA</div><div><br></div><div>Thanks</div><div>=C2=A0<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; but the Qemu<br>
&gt; won&#39;t let vDPA to use GPA as IOVA. Dedicated IOVA ranges were allo=
cated for<br>
&gt; those GPA ranges so SVQ won&#39;t use IOVA that is overlapped with wha=
t Guest<br>
&gt; use.<br>
&gt; <br>
&gt; Thanks<br>
&gt; <br>
&gt; <br>
&gt; &gt; <br>
<br>
</blockquote></div></div>

--00000000000030630505d9c44715--


--===============4097744569903831426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4097744569903831426==--

