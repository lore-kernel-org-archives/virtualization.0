Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B2CC25B08
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 22:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EBAC4097A;
	Mon, 15 Aug 2022 22:24:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6EBAC4097A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=K3GMgspD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id REQBPnn9Wgwp; Mon, 15 Aug 2022 22:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C8E64094C;
	Mon, 15 Aug 2022 22:24:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C8E64094C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C392C0032;
	Mon, 15 Aug 2022 22:24:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ABE9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0496A60BFC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0496A60BFC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=K3GMgspD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7hxtzrEOh73z
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:24:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2386D60BF3
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2386D60BF3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:24:49 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id uj29so15888859ejc.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=/3IXWzd+wl2RRDXeLv2+xA05vlC4U88YqM5/n+NeSEQ=;
 b=K3GMgspDwTktDa13IofgOH0wIJzbay3VW81an1jha0AKmOvhDPlvRk0WOZp6aDvlbD
 6//WGvjCK/LH0DzeGdavGl9SU1jN+Muei6YeSDdFyN+n9WLwulVhMtFPW9uH7+1wRBge
 tPfBSs5ZiDfdB4kY4wPKlDhGDIY+DTVDjQvf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=/3IXWzd+wl2RRDXeLv2+xA05vlC4U88YqM5/n+NeSEQ=;
 b=aaed4Vz9yoFgegX1jrGkLKYzQ5Cp2LmZ9ZSZM9dNEBx5WHrptLxWzRVYQCPvUDBrjM
 k+W8CRqcOtMlHXPEApfQ6ZErUNfhhrPEo07Xkg2feRu2OiBEGODt5L5mpeZmn1DJjxek
 x4KY6d0sRunxRrr4b1ZlHjVCx0QeDj21EJSqRvuja1Cik9v+tYEDt3dhDky4NOSNHvG8
 w6GiVfjTyOon4YraMuAPsYZNQL3/Zh0NB88cPxX4jpLkeKr25LaZANVG27m5Ouo+S7M8
 tdrRWQu6DVTZMJdPnTd+Y0rm+FkkzqUUO8uEjhnVfuolQQhgI4jrsGgiup5P2ymVHhMz
 ErTw==
X-Gm-Message-State: ACgBeo1IPkggGDz4CJO/rgn0iY/rVBj3sy2A3DnuB/yiGpOrRm7BaMf6
 KIhcInZZFl8+TPYrpCifdci6VDxdQ4T3/Z7Si+o=
X-Google-Smtp-Source: AA6agR5Bsub97qWScfi8DiFKEZspRm7qOZwIu2nxCV1VInY6nYMNsKuCUgJ1AoItTmT+DIKlYZVlxw==
X-Received: by 2002:a17:907:b0d:b0:730:aa17:a0b7 with SMTP id
 h13-20020a1709070b0d00b00730aa17a0b7mr11613184ejl.661.1660602287148; 
 Mon, 15 Aug 2022 15:24:47 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50]) by smtp.gmail.com with ESMTPSA id
 m14-20020a056402050e00b0043d5ead65a6sm7279819edv.84.2022.08.15.15.24.45
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Aug 2022 15:24:45 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id z16so10534686wrh.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 15:24:45 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr9331179wri.442.1660602284992; Mon, 15
 Aug 2022 15:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220815215938.154999-1-mst@redhat.com>
In-Reply-To: <20220815215938.154999-1-mst@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Aug 2022 15:24:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=Ju_jhbww7WmpgmHHebMSdd1U5WBjh925yLB_F1j9Ng@mail.gmail.com>
Message-ID: <CAHk-=wj=Ju_jhbww7WmpgmHHebMSdd1U5WBjh925yLB_F1j9Ng@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] virtio: drop sizing vqs during init
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

On Mon, Aug 15, 2022 at 3:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> But the benefit is unclear in any case, so let's revert for now.

Should I take this patch series directly, or will you be sending a
pull request (preferred)?

             Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
