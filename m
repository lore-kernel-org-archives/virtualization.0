Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BAEECAAD1
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 19:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DBC34012D;
	Wed, 31 Aug 2022 19:40:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DBC34012D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20210112.gappssmtp.com header.i=@fooishbar-org.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=PAfjqsjI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EAywALjdRRfx; Wed, 31 Aug 2022 19:40:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B4585400CE;
	Wed, 31 Aug 2022 19:40:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4585400CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94BB0C0033;
	Wed, 31 Aug 2022 19:40:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5FD4C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 19:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F71A83168
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 19:40:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F71A83168
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=fooishbar-org.20210112.gappssmtp.com
 header.i=@fooishbar-org.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=PAfjqsjI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7cul59UUnvjJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 19:40:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9869B8315C
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9869B8315C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 19:40:17 +0000 (UTC)
Received: by mail-yb1-xb2a.google.com with SMTP id g5so5655365ybg.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=sOPdRmF0K1JRDB7HzDBS2IrjwMwL3LRAyZ1lJrQO0WI=;
 b=PAfjqsjIgJCWRCdIT4OZIywTyYcWSJWwqQ5azTB2AXrmed1W54jb/q/LNrYaMDb+1o
 4rKdXsLYjr3/viZbSGOsbYMy4yJrRjOf7K65A6LZg2agAD0/xwT8GeRyTk1mtGCGofzC
 Fwd985o6v2F4IWV+uzhO+elLE9gvF9+2QqqmOXVGMc206Y2n5PEL0E6REUgyw6TJpe3r
 JGM4Wr5cS1OW0iR8jG6FojXY3jnRvbhDQMdD4Lf953IczCZBH/FgNbfvBQRSehlax69r
 dy9XwGe5LRpgdaImsFb7iA/ylfTV2YBxEASu1iSsXyn6Stn3XLmrsDM1S2/+WDmn2jWt
 fWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=sOPdRmF0K1JRDB7HzDBS2IrjwMwL3LRAyZ1lJrQO0WI=;
 b=FdYRNwWbpThQ6vGDJBQBnobPTvumfvWDh4Brxkwys7Lw89J3Wc2EOIVF0iaHV6Aoy1
 B7A64OJT1YaqTgmbqYUPpv+oJXkfNIL8Tn+LS4qv6kNOZblBwUClJLfQbknumFEnCUuC
 IoHL4xFsdWTtF+Nj/SNTlgg6DmyW0JTn40hHhqPj63mAjOCWOUxWyHQ5wA/nHODfaIpk
 mm7iSxfvGWe7I9h121eop0Z5+0kF4kTTLZx+9wU3wmjvy4moBvgEWe7wuh948nM3kQEP
 v2Nx7UBeqLv+841e5AqbGJYoYawzAXv4RGV/EinouWGvB1t1xlWHRdxex5CQ+Ia+9a/n
 NM9g==
X-Gm-Message-State: ACgBeo3ZxwrKzlDtmVFFJeiDklxiR3MZwKyVemHqwNW++hIoIRrgImET
 BdMYb/DK+JMqzLJV+mfuiy27LeJWgNRXObvt3rZu/A==
X-Google-Smtp-Source: AA6agR49GWFMNHjNnc4qF9RIGIh7N6FJLlqVu8z47qf9uxdXIVXJ7fgKUgsEStjyxdlWe78OShPfSs4yeaf3/0LoHBk=
X-Received: by 2002:a25:4d1:0:b0:69c:a114:5d3a with SMTP id
 200-20020a2504d1000000b0069ca1145d3amr5647002ybe.201.1661974816436; Wed, 31
 Aug 2022 12:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220831190601.1295129-1-olvaffe@gmail.com>
In-Reply-To: <20220831190601.1295129-1-olvaffe@gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 31 Aug 2022 20:38:43 +0100
Message-ID: <CAPj87rOJY752AFXpT4jDwbi6QAVQV_HqokcF62s10t78=4te2g@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: set fb_modifiers_not_supported
To: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 Shao-Chuan Lee <shaochuan@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Tomohito Esaki <etom@igel.co.jp>
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
Content-Type: multipart/mixed; boundary="===============0662192916263341749=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============0662192916263341749==
Content-Type: multipart/alternative; boundary="0000000000008f4bab05e78eaa15"

--0000000000008f4bab05e78eaa15
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Aug 2022 at 20:06, Chia-I Wu <olvaffe@gmail.com> wrote:

> Without this, the drm core advertises LINEAR modifier which is
> incorrect.
>
> Also userspace virgl does not support modifiers.  For example, it causes
> chrome on ozone/drm to fail with "Failed to create scanout buffer".
>
> Fixes: 2af104290da5 ("drm: introduce fb_modifiers_not_supported flag in
> mode_config")
> Suggested-by: Shao-Chuan Lee <shaochuan@chromium.org>
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>


 Reviewed-by: Daniel Stone <daniels@collabora.com>

--0000000000008f4bab05e78eaa15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, 31 Aug 2022 at 20:06, Chia-I Wu &=
lt;<a href=3D"mailto:olvaffe@gmail.com">olvaffe@gmail.com</a>&gt; wrote:<br=
></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Without this, the drm core advertises LINEAR modifier which is<b=
r>
incorrect.<br>
<br>
Also userspace virgl does not support modifiers.=C2=A0 For example, it caus=
es<br>
chrome on ozone/drm to fail with &quot;Failed to create scanout buffer&quot=
;.<br>
<br>
Fixes: 2af104290da5 (&quot;drm: introduce fb_modifiers_not_supported flag i=
n mode_config&quot;)<br>
Suggested-by: Shao-Chuan Lee &lt;<a href=3D"mailto:shaochuan@chromium.org" =
target=3D"_blank">shaochuan@chromium.org</a>&gt;<br>
Signed-off-by: Chia-I Wu &lt;<a href=3D"mailto:olvaffe@gmail.com" target=3D=
"_blank">olvaffe@gmail.com</a>&gt;</blockquote><div><br></div><div>=C2=A0Re=
viewed-by: Daniel Stone &lt;<a href=3D"mailto:daniels@collabora.com">daniel=
s@collabora.com</a>&gt;=C2=A0</div></div></div>

--0000000000008f4bab05e78eaa15--

--===============0662192916263341749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0662192916263341749==--
