Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C279C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 13:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9BCBD408F5;
	Tue,  8 Mar 2022 13:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DFNYqJLiVBg8; Tue,  8 Mar 2022 13:23:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 007DF408FB;
	Tue,  8 Mar 2022 13:23:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4BC1C0012;
	Tue,  8 Mar 2022 13:23:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E418C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65B3380EC1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EiloDuz7MrP1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:23:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7113F80DCD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646745811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+BFpMveWz1PM4HPWOdYk4KHbFe/+Wx8MQGLoc1pigYg=;
 b=OkBv+uuuyzMdPHFRtR7MN1x5QtkfcQlVt4khHD78IISyWH9H4dvUt4bhkG8CUQDHOCKZ5d
 Jt2Z/vguc0xns/3rSM7txgPSNnr431UqdG30t6I1IcHkdzXuRfwse3zj3aMl9v2m3mxSQa
 d5cclEWEG3hRgzVGviUEaQmuW3c3iII=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-okFq8RYmOtulqxy_yWyVqA-1; Tue, 08 Mar 2022 08:23:29 -0500
X-MC-Unique: okFq8RYmOtulqxy_yWyVqA-1
Received: by mail-lf1-f72.google.com with SMTP id
 m18-20020a0565120a9200b004439214844dso4889179lfu.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 05:23:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+BFpMveWz1PM4HPWOdYk4KHbFe/+Wx8MQGLoc1pigYg=;
 b=NkhngCirurhOy5sS15Y6y6WUbdqlz6LO1Zd5H91HoCzeEA7WXXmdcIPeDkOwMEGpAW
 qx1Lcp9veDheL5gVEJa+d7SHt7JQ7YgXnCb0/CEbxiOpPNX9RNtnXu0O7bBOOgy6fbhh
 KqegYNQgTGSuyJFadWs5jAywiA9muvbZdOgwyi8lIcTHyne7QRPA6JJ+r/Vis/RqLPym
 EczSZ07JbVRFvXdwvcRSG6kj9HXiO+LDAuPOmbsJSweIloh18S4yi9fJdcIxj4kNp2Bx
 MrEXl0rsvm/YDrrYHYKmCu/tmaYvcma5hRL8sOz4J1WvWY+yGgoVAzUOJHpnllPdiL5K
 mZbg==
X-Gm-Message-State: AOAM530XFNHi50ztfNV5WUdePLd4x5rSV4YwSp38qsu7HWQuaH+aE5qt
 GkdTLoTGxj8Xk9RXLPuOZvY23c6OtivHQNi+kYgAMIMv0utpgYuDea452+uJSjJZoz0rQ1EhUGo
 uDhW21+zjasMr+u+sRz/ECiSo72nTcVIrOmvDKgI8V3qezrqbXGR6Qzhd5w==
X-Received: by 2002:ac2:4c4f:0:b0:448:21cd:596f with SMTP id
 o15-20020ac24c4f000000b0044821cd596fmr10919145lfk.257.1646745808265; 
 Tue, 08 Mar 2022 05:23:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5c0Eg+3oJM/eNirofea31KPsRHlR2kaX0V1EVtxG1oGS7954rRkDe0bQlO3Y0rgGZ9XJ1likpuzCoYv7Jfl0=
X-Received: by 2002:ac2:4c4f:0:b0:448:21cd:596f with SMTP id
 o15-20020ac24c4f000000b0044821cd596fmr10919108lfk.257.1646745807969; Tue, 08
 Mar 2022 05:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20220307153334.3854134-1-eperezma@redhat.com>
 <14d4fde4-6ea5-4805-b684-c33f6b448565@redhat.com>
 <20220308020348-mutt-send-email-mst@kernel.org>
 <CACGkMEvY-+XpPWbtiX9dy+fwDxPp7sHFhH_LY0PB2YuusEugyw@mail.gmail.com>
 <20220308022300-mutt-send-email-mst@kernel.org>
 <CACGkMEvuTPCRk7Ng7CbgpPSPgs_QYijzc5fU+cV3kW09W1R7Qg@mail.gmail.com>
 <20220308024724-mutt-send-email-mst@kernel.org>
 <CACGkMEsPBDM8ko1qgnCR1DcofPNJJo3S2j3pOJHk4xaSGQimcQ@mail.gmail.com>
 <20220308054213-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220308054213-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Mar 2022 21:23:16 +0800
Message-ID: <CACGkMEtRG5cH41MV5gGKyGKtX4Lvok-OQpvkP48qCArr_pOZ3Q@mail.gmail.com>
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
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
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
Content-Type: multipart/mixed; boundary="===============6872302583459934230=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============6872302583459934230==
Content-Type: multipart/alternative; boundary="000000000000eb874805d9b4e268"

--000000000000eb874805d9b4e268
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 8, 2022 at 6:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Tue, Mar 08, 2022 at 04:20:53PM +0800, Jason Wang wrote:
> > Generally, yes.
>
>
> So generally I support the idea of merging code gradually.  And merging
> with an unstable flag to enable it is a reasonable way to do it.
> However we are half a day away from soft freeze, so this will just
> result in the feature getting to users in it's current not really
> useable form. If we just want to simplify upstreaming then
> merging patches 1-14 for now would be one way to do it.
>

Yes.


> If you want to do it through your tree then ok
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>

Thanks. Will send a pull request soon.


>
>
> --
> MST
>
>

--000000000000eb874805d9b4e268
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 8, 2022 at 6:46 PM Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Ma=
r 08, 2022 at 04:20:53PM +0800, Jason Wang wrote:<br>
&gt; Generally, yes.<br>
<br>
<br>
So generally I support the idea of merging code gradually.=C2=A0 And mergin=
g<br>
with an unstable flag to enable it is a reasonable way to do it.<br>
However we are half a day away from soft freeze, so this will just<br>
result in the feature getting to users in it&#39;s current not really<br>
useable form. If we just want to simplify upstreaming then<br>
merging patches 1-14 for now would be one way to do it.<br></blockquote><di=
v><br></div><div>Yes.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
If you want to do it through your tree then ok<br>
<br>
Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a>&gt;<br></blockquote><div><br></div><div>Than=
ks. Will send a pull request soon.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
<br>
-- <br>
MST<br>
<br>
</blockquote></div></div>

--000000000000eb874805d9b4e268--


--===============6872302583459934230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6872302583459934230==--

