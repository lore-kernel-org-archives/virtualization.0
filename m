Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646DCC433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:42:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F8D6135A
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13F8D6135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C7EBB4072E;
	Thu, 21 Oct 2021 16:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09Dms4s0MgKg; Thu, 21 Oct 2021 16:42:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BC0A402E1;
	Thu, 21 Oct 2021 16:42:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0524C0033;
	Thu, 21 Oct 2021 16:42:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0081EC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2B7B60F2B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MaEoW1k3hkDO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:42:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3966060F21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:42:14 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id r4so719255edi.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5kDRmnzIH03xrtrZgYDtwH/WzS6dnydlo7OWL37wWGU=;
 b=c0pPEzMM+ASHHHj4QCNroPy2CARe+mLhA2STa+pRVgVttv/jnFta1ziqiI61pCgTeD
 q+IZuwqAnYPzTOTNsVi9nyYe1nN7QKSnBa9bpkd6gcYirMZcQmKBYBBIEAx8p5W9+kwf
 z8fjQ9n2pAQkUTpdpeyz2cVzajCbziKix765QEDWFkBlnDMa2mUjtkRvH4bkx/tU9yWQ
 9gCX4XKZJoY+6DahPdAbe41RwLqf8sLRW3+H6WY99ygDr0IYYCfS1kBfU4cQWAm/YX9m
 3l0AnUJRPowmGxJWoALREX+POwQiMWzswUWsudnHWklUDxsPo/jF49xJOA8hIb866LIC
 I0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5kDRmnzIH03xrtrZgYDtwH/WzS6dnydlo7OWL37wWGU=;
 b=rQm1RGNP+KodzqOmL78GEsWuhlFToQ4U5nO3wDBw8YUFcv944a1LleqRtHmiZ5i1Et
 6kzGSown0e3mcTlQo9sugmzAHoZPYUqVzQVr+vAOLVTlay0gSua59JPKtZgGvnmPGDYC
 cWGWkSE8/majiAoset4AAKBaLg4XGCPA/wXloPnYJ0MkQlpNqPSmQ2QXGsP7xn4i3jg6
 UZPdPkDicRm5exekGf7V3k3abF1tfOMpA1GWFmZwh4jMiKgq0rR3Js85wXySq365dFXf
 WIGmsJR5xlEtqmuHmpFt2VWUXSqYL4ui05BGO6MAcR15FC3LlqZ+eRlopY2HoLl1d8qE
 8rSA==
X-Gm-Message-State: AOAM5302LskQ0e5W0RTMtdBZr5uxu8ArxSp7Zbs0DmGigTqKIjZ6wGUf
 RveT+owCLQ9GbQ2wLAuXGBhRQ3NgyXc3ZX4IXGg=
X-Google-Smtp-Source: ABdhPJyccymnZsJh0cBou34794Zed2lq7y9b5xrz0vlxEDmBG54OEPx1zAnudKX4kA+2F1rEFB3yNELsy5w3piWj6SM=
X-Received: by 2002:a17:907:971e:: with SMTP id
 jg30mr8348703ejc.375.1634834532298; 
 Thu, 21 Oct 2021 09:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211021074445.452309-1-maksym.wezdecki@collabora.com>
 <20211021092535.ozafsijlakj7ccwc@sirius.home.kraxel.org>
 <327a5c8a-d82d-f115-27bb-37125affe24b@collabora.co.uk>
 <20211021115212.dk2kl2vbl6qotjwa@sirius.home.kraxel.org>
In-Reply-To: <20211021115212.dk2kl2vbl6qotjwa@sirius.home.kraxel.org>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 21 Oct 2021 09:42:00 -0700
Message-ID: <CAPaKu7TfEtikdg2HEt2_PH7=zPbk=d9wfosDjNmr1AU6CC6sMw@mail.gmail.com>
Subject: Re: drm/virtio: not pin pages on demand
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>,
 Maksym Wezdecki <maksym.wezdecki@collabora.co.uk>,
 ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Oct 21, 2021 at 4:52 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Oct 21, 2021 at 11:55:47AM +0200, Maksym Wezdecki wrote:
> > I get your point. However, we need to make resource_create ioctl,
> > in order to create corresponding resource on the host.
>
> That used to be the case but isn't true any more with the new
> blob resources.  virglrenderer allows to create gpu objects
> via execbuffer.  Those gpu objects can be linked to a
> virtio-gpu resources, but it's optional.  In your case you
> would do that only for your staging buffer.  The other textures
> (which you fill with a host-side copy from the staging buffer)
> do not need a virtio-gpu resource in the first place.
That's however a breaking change to the virgl protocol.  All virgl
commands expect res ids rather than blob ids.

Using VIRTGPU_BLOB_MEM_HOST3D could in theory work.  But there are a
few occasions where virglrenderer expects there to be guest storage.
There are also readbacks that we need to support.  We might end up
using VIRTGPU_BLOB_MEM_HOST3D_GUEST, where pin-on-demand is still
desirable.

For this patch, I think the uapi change can be simplified.  It can be
a new param plus a new field in drm_virtgpu_execbuffer

  __u64 bo_flags; /* pointer to an array of size num_bo_handles, or NULL */

The other changes do not seem needed.

>
> take care,
>   Gerd
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
