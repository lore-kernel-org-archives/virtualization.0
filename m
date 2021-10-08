Return-Path: <SRS0=03hR=O4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD0C433F5
	for <virtualization@archiver.kernel.org>; Fri,  8 Oct 2021 10:02:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E7C60F5A
	for <virtualization@archiver.kernel.org>; Fri,  8 Oct 2021 10:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59E7C60F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1726B40247;
	Fri,  8 Oct 2021 10:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5gjjFCoPm-tj; Fri,  8 Oct 2021 10:02:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7673240229;
	Fri,  8 Oct 2021 10:02:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55E70C000F;
	Fri,  8 Oct 2021 10:02:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9989EC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 10:02:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68A02832B0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 10:02:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EYq7NHaXR8GE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 10:02:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A251182ECF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 10:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633687347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DYJJAEUu6hqgETTgE/jfMVtd0sOV59xWOXw/Ng2Zkk=;
 b=AKXG9IFLhoTMN/2h6V8k0izor9Tv4o0cLcBsR5j3ENsjEFV7PkWc6CxN7+ye5hpsDgY6KB
 2rpQHIUj1oY5fVa50P2hLvbERliQxJ/L1MLGq7O87ZLKPqSgi5+doMM4i30BSYT5dz5SF0
 YGXBC1CyuIgKZeozr7QN1bNkIyjPKtA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331--HQGj-qxMO2RCJli3Ytwsw-1; Fri, 08 Oct 2021 06:02:26 -0400
X-MC-Unique: -HQGj-qxMO2RCJli3Ytwsw-1
Received: by mail-ed1-f69.google.com with SMTP id
 p13-20020a056402044d00b003db3256e4f2so8775879edw.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 08 Oct 2021 03:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/DYJJAEUu6hqgETTgE/jfMVtd0sOV59xWOXw/Ng2Zkk=;
 b=YiQMTYsO217ECNo9jesSNTvywvdllXzHOI9DrqgueJ+1HyQgI/WpxHtIO4zn7CbnPU
 OBZrD2vSiueDUnV8nVs17lk1j3hlUJYhStf1rgkHLSSMCN08YaYdD1MtB47u8GsX7itJ
 zl1GuiH9wbsYc1IByVA5rwAPg9RpaEnNyU6cv/B65kX+KnU62mCjIiz+8nTZASYaGIEr
 Cb9+StoMZXLBqkLfA/mDNa/qFlirKjrSrXooSzi2EikEmxB5YLvEIA90mZ7sY/jSl2yB
 fSR+uJg2B4ZDSaA2t66NOFUyiC+y82/gkHAzj2w3diB/QkVouUOrOnDTz7CknbKXgq0C
 hfcw==
X-Gm-Message-State: AOAM53115EbaRa7bLkZajcdPFWz6KhScRZGg2VQ4W4bFc/h7gtci+IP9
 NmTfOO97EzhFRwhwRrtV/nRD/zVvx9F54qF2dp7bjjlTAE+/AH+6lXnssBfCMW43slASsWgi776
 6lLR0BfbV/Na7S3aiIeUdLa/BFm96i53kUo2yIsxB3w==
X-Received: by 2002:a05:6402:1157:: with SMTP id
 g23mr14198456edw.379.1633687344436; 
 Fri, 08 Oct 2021 03:02:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCXcDy+V1Ve+4wDUmBknbIZIJdSTIfRrrkzU3KaFgOcLrOJufywV2OgzBitVmiWIDaj6yP9Q==
X-Received: by 2002:a05:6402:1157:: with SMTP id
 g23mr14198441edw.379.1633687344249; 
 Fri, 08 Oct 2021 03:02:24 -0700 (PDT)
Received: from redhat.com ([2.55.132.170])
 by smtp.gmail.com with ESMTPSA id l6sm804400edt.21.2021.10.08.03.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Oct 2021 03:02:23 -0700 (PDT)
Date: Fri, 8 Oct 2021 06:02:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: virtio-net: kernel panic in virtio_net.c
Message-ID: <20211008055902-mutt-send-email-mst@kernel.org>
References: <YV8RTqGSTuVLMFOP@kroah.com>
 <1633623446.6192446-1-xuanzhuo@linux.alibaba.com>
 <YV/8Ia1d9zXvMqqc@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YV/8Ia1d9zXvMqqc@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: regressions@lists.linux.dev,
 Corentin =?iso-8859-1?Q?No=EBl?= <corentin.noel@collabora.com>,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Oct 08, 2021 at 10:06:57AM +0200, Greg KH wrote:
> On Fri, Oct 08, 2021 at 12:17:26AM +0800, Xuan Zhuo wrote:
> > On Thu, 7 Oct 2021 17:25:02 +0200, Greg KH <gregkh@linuxfoundation.org>=
 wrote:
> > > On Thu, Oct 07, 2021 at 11:06:12PM +0800, Xuan Zhuo wrote:
> > > > On Thu, 07 Oct 2021 14:04:22 +0200, Corentin No=EBl <corentin.noel@=
collabora.com> wrote:
> > > > > I've been experiencing crashes with 5.14-rc1 and above that do not
> > > > > occur with 5.13,
> > > >
> > > > I should have fixed this problem before. I don't know why, I just l=
ooked at the
> > > > latest net code, and this commit seems to be lost.
> > > >
> > > >      1a8024239dacf53fcf39c0f07fbf2712af22864f virtio-net: fix for s=
kb_over_panic inside big mode
> > > >
> > > > Can you test this patch again?
> > >
> > > That commit showed up in 5.13-rc5, so 5.14-rc1 and 5.13 should have h=
ad
> > > it in it, right?
> > >
> > =

> > Yes, it may be lost due to conflicts during a certain merge.
> =

> Really?  I tried to apply that again to 5.14 and it did not work.  So I
> do not understand what to do here, can you try to explain it better?
> =

> thanks,
> =

> greg k-h

Hmm, something like the following perhaps then?
Corentin would you like to try this?
Warning: untested.


diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 096c2ac6b7a6..18dd9f6d107d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -406,12 +406,13 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
 	 * add_recvbuf_mergeable() + get_mergeable_buf_len()
 	 */
 	truesize =3D headroom ? PAGE_SIZE : truesize;
-	tailroom =3D truesize - len - headroom;
+	tailroom =3D truesize - headroom;
 	buf =3D p - headroom;
 =

 	len -=3D hdr_len;
 	offset +=3D hdr_padded_len;
 	p +=3D hdr_padded_len;
+	tailroom -=3D hdr_padded_len + len;
 =

 	shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
