Return-Path: <SRS0=UZhq=OW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B956FC433EF
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 18:13:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4671F61B32
	for <virtualization@archiver.kernel.org>; Sat,  2 Oct 2021 18:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4671F61B32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BE5640558;
	Sat,  2 Oct 2021 18:13:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AjphdMI-X0QI; Sat,  2 Oct 2021 18:13:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B653B4053B;
	Sat,  2 Oct 2021 18:13:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D0F6C000F;
	Sat,  2 Oct 2021 18:13:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70C56C000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 18:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BFAE846F1
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 18:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e_AelXVlrZqT
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 18:13:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B542846EC
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 18:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633198425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3oSEK/nQsdZlU+yYMpXszg2Kp8d5WMgwuTa52Aw2D3Y=;
 b=I8PsR+DgGuOe1K9hlg6YjY22aR5Q3e7Ss+hf0JhsEsvBw8KhKOQl8wwofCop3rYD9rw05z
 i5jXyuChArjpBK80ERj3mzsiF/HfAj4X1I5h8pfFsW2baxt/IIhhjvfOCDh48jSwdlbQ1x
 FM56uT5HnB3echT77ZAsr+x24o/MtO0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-jF93yDg_NI-iI2sh2fdjBg-1; Sat, 02 Oct 2021 14:13:44 -0400
X-MC-Unique: jF93yDg_NI-iI2sh2fdjBg-1
Received: by mail-ed1-f72.google.com with SMTP id
 c7-20020a05640227c700b003d27f41f1d4so13219288ede.16
 for <virtualization@lists.linux-foundation.org>;
 Sat, 02 Oct 2021 11:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3oSEK/nQsdZlU+yYMpXszg2Kp8d5WMgwuTa52Aw2D3Y=;
 b=d6EowTRuyFF044fyMZypG7fzwlF38VmQt0ee4K2J5qaK+jaD7epoDNyPNQR6Mn8L0U
 KbUe3XS6ny8Q5gCKq9lQRSUaLJ77r6aNl1CQ5qTmNF/PER93MOnibqwIcDYMYMhRxTI/
 ggwYa1VE4nBLYlkQ3aG2+Mz9YKYbYrbXI2UAmoAVF7aRIoB/Qh8UbSyxat340qgRL39w
 IOtKAiBTQY1IYviD1GWU/qAXTFnSBYaF0sTq1NOHSznxK2+esIU/uZ5ps0qwonZXAKmB
 Ff7VGD8xgDDDElmKV1SHWtSb8WCb/OTeliAav3g8oZzsbP1WxbdoF3PyBExHb0QpJCMn
 k4CQ==
X-Gm-Message-State: AOAM533PmIAxvfNHqGTL0FRfzdfa6RrX8yCTOyqF7w1v5WhFhKBolSIg
 X5o2eRvF7O1KkN2tpNC8yLcQrIEE9QmNtEQOk3CVTiREWNt9W1+Bas+jtW4kiC7mHYN5Ae0prhp
 3fJ2tpKri6A8iyA8yCBf2s06DAh6M40KDAUiFYAqeyA==
X-Received: by 2002:a17:906:3148:: with SMTP id
 e8mr5549047eje.240.1633198422797; 
 Sat, 02 Oct 2021 11:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRv0l7yLWVghnzKaRjGETRmZdWUznHgB707hsC9MH/6Nu9SV2dEEHSsiG1hSfbsv5Yq/RsSA==
X-Received: by 2002:a17:906:3148:: with SMTP id
 e8mr5549025eje.240.1633198422593; 
 Sat, 02 Oct 2021 11:13:42 -0700 (PDT)
Received: from redhat.com ([2.55.22.213])
 by smtp.gmail.com with ESMTPSA id d10sm4409791eja.81.2021.10.02.11.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Oct 2021 11:13:41 -0700 (PDT)
Date: Sat, 2 Oct 2021 14:13:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211002082128-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com>
 <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com>
 <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87v92g3h9l.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Xie Yongji <xieyongji@bytedance.com>
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

On Fri, Oct 01, 2021 at 05:18:46PM +0200, Cornelia Huck wrote:
> I'd say we need a hack here so that we assume little-endian config space
> if VERSION_1 has been offered; if your patch here works, I assume QEMU
> does what we expect (assmuming little-endian as well.) I'm mostly
> wondering what happens if you use a different VMM; can we expect it to
> work similar to QEMU?

Hard to say of course ... hopefully other VMMs are actually
implementing the spec. E.g. IIUC rust vmm is modern only.


> Even if it helps for s390, we should double-check
> what happens for other architectures.
> 
> >
> >> 
> >> Anyone have any better suggestions?
> >> 
> >
> > There is the conditional compile, as an option but I would not say it is
> > better.
> 
> Yes, I agree.
> 
> Anyone else have an idea? This is a nasty regression; we could revert the
> patch, which would remove the symptoms and give us some time, but that
> doesn't really feel right, I'd do that only as a last resort.

Well we have Halil's hack (except I would limit it
to only apply to BE, only do devices with validate,
and only in modern mode), and we will fix QEMU to be spec compliant.
Between these why do we need any conditional compiles?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
