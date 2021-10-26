Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB84C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 05:41:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E3660F92
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 05:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B5E3660F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 674934012E;
	Tue, 26 Oct 2021 05:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dY3Bf0Dp2G2V; Tue, 26 Oct 2021 05:41:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AE66D401D2;
	Tue, 26 Oct 2021 05:41:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B5FDC0012;
	Tue, 26 Oct 2021 05:41:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 134CEC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 05:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFC0C404A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 05:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zxv8e5jngnQS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 05:41:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B73F740445
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 05:41:09 +0000 (UTC)
Received: by mail-io1-xd2c.google.com with SMTP id y67so18615505iof.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=++rZQRvjCC3Oey+qaI1RFCiy4lOpl4QYaWl2E1TXmzU=;
 b=nRylxwsXkBM5BFRc7/BgDsdK2SWoubKIYOS1e9uwSFKL7zJAWNTcyBHNbklkrgXkha
 b7sCk80gujqZqIhVBlFjjaX4wHHwaymAin5zbL3Q+ZlqdU8etWk7sO9bCxyihCM5poTz
 CVsDO3jY3CYt1p3K4GaRG0eelLDUZJll3MQfRB/wAZ0wSsFXhHo2Mqss6+GmVyBzRjxe
 dzbmF94np8lOAK23e7dBBJaLjNkTwX20SoBg7NJboxKEoiapTHH2m/qlXN1cFpLu6eGG
 YfDbbPAOzucYSKpNRidc64z7IVA0/gTqFqPp6cxyXGGG1JV2IQeizCD6NxBpNP5ZSYZ0
 XSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=++rZQRvjCC3Oey+qaI1RFCiy4lOpl4QYaWl2E1TXmzU=;
 b=2GZz1FR2M2kwwqfyQxR15dsh9ZBY4VacV3m5Lq0unYZAV7vkWqtPAMxZFGhykzhRo6
 A3+DdLEUljY3WJFhBiQFBlY9BV5H0hITWS79hyynWnpgsQKtDzQws4DSmqNr2I1r6gLM
 BrajO/z0uJkA5/IbJG1za/0/EN1/ikMnge3KNu4mz/r7tv4qP9Ps3k4xoIT9iUqP51zM
 WpsPFtg3GlEGzceH62OWljaQJjU5kUQFoS2MWzPlaNshFHaimTUl01lDqqXnxDeRH39d
 EAPRICtvQPKdxx26V30X3AscGAOzNJa71v/tI+C/mczv0bVun+dY8+1gBndof4eJVIaD
 drKA==
X-Gm-Message-State: AOAM531djYgU4lRt8SuiIyixxAMlUWE0p4F7lj9BBLHUnxJ9O0/hZ8NS
 73boB/qbwS0FYDz8FYJbF8+IgPkBI8HQe0gRvfPdJebJaAagnw==
X-Google-Smtp-Source: ABdhPJxTU+VpWtSy0wXFUqqjow1L9Xgyg0dkjzLQ4kZLgrnIahpuoFsXJhcm1MTxGur71DOnA1F5079aEna1vifgLMg=
X-Received: by 2002:a5d:9918:: with SMTP id x24mr8990304iol.51.1635226868863; 
 Mon, 25 Oct 2021 22:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211025125316.67664-1-parav@nvidia.com>
 <20211025125316.67664-8-parav@nvidia.com>
 <204B3436-0EFB-4722-9EA1-A43C7A2FEDE5@gmail.com>
 <PH0PR12MB54817E52E4B89662D73236A3DC849@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54817E52E4B89662D73236A3DC849@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Leo Hou <leohou1402@gmail.com>
Date: Tue, 26 Oct 2021 13:40:46 +0800
Message-ID: <CAFCaBXMe-CfpgEwi+0_eK5WMXqWrsqDjo2pevi6Z5tvwc2seLw@mail.gmail.com>
Subject: Re: [PATCH linux-next v5 7/8] vdpa/mlx5: Support configuration of MAC
To: Parav Pandit <parav@nvidia.com>
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
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
Content-Type: multipart/mixed; boundary="===============2286285152340990734=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2286285152340990734==
Content-Type: multipart/alternative; boundary="000000000000a5550205cf3aec08"

--000000000000a5550205cf3aec08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

Parav Pandit <parav@nvidia.com> =E4=BA=8E2021=E5=B9=B410=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:00=E5=86=99=E9=81=93=EF=BC=9A

>
> > From: leohou1402 <leohou1402@gmail.com>
> > Sent: Tuesday, October 26, 2021 10:28 AM
>
> > Which device does mlX5 refer to ? Connectx-4 or ConnectX-5 ?
> > I want to test it out.
> ConnectX-6 dx.
>
>

--000000000000a5550205cf3aec08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks! <br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Parav Pandit &lt;<a href=3D"mailto:parav@nvid=
ia.com">parav@nvidia.com</a>&gt; =E4=BA=8E2021=E5=B9=B410=E6=9C=8826=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:00=E5=86=99=E9=81=93=EF=BC=9A<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
&gt; From: leohou1402 &lt;<a href=3D"mailto:leohou1402@gmail.com" target=3D=
"_blank">leohou1402@gmail.com</a>&gt; <br>
&gt; Sent: Tuesday, October 26, 2021 10:28 AM<br>
<br>
&gt; Which device does mlX5 refer to ? Connectx-4 or ConnectX-5 ?<br>
&gt; I want to test it out.<br>
ConnectX-6 dx.<br>
<br>
</blockquote></div>

--000000000000a5550205cf3aec08--

--===============2286285152340990734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2286285152340990734==--
