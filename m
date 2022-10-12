Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37BCC433FE
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 11:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4381660C00;
	Wed, 12 Oct 2022 11:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4381660C00
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iDIJ8YJ7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-i0Y_rOawn1; Wed, 12 Oct 2022 11:11:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E8C060AD7;
	Wed, 12 Oct 2022 11:11:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E8C060AD7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19632C0033;
	Wed, 12 Oct 2022 11:11:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F251C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 11:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0DBF83260
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 11:11:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0DBF83260
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iDIJ8YJ7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zIjaodJPWC2S
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 11:11:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0296082FE4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0296082FE4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665573074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8YiAlVcyacuAF1cXPKHrDiH+rQYQoNsO4NEHWDYYi14=;
 b=iDIJ8YJ7dFjXb2rzD86PK0sSXWE5o+yyGWbgK1DjTyFZ0efUFxwFHVKz8UGuyLEBCkwFl7
 +d3RimS8s9MPiH0k6PRjiTrDzuo1DsRkD9xY01+ZeO+U1HKW4dQf0Uhlon5kBjzgT8iIfT
 zPWZJQWhakUsBq5rMgd29tNz/jRHf0Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-vG-2v5bOPym_MvhrkOF4vw-1; Wed, 12 Oct 2022 07:11:13 -0400
X-MC-Unique: vG-2v5bOPym_MvhrkOF4vw-1
Received: by mail-wr1-f69.google.com with SMTP id
 h17-20020adfaa91000000b0022e9f2245c8so3976249wrc.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 04:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8YiAlVcyacuAF1cXPKHrDiH+rQYQoNsO4NEHWDYYi14=;
 b=m/605kucT+n6f/RKU924iibF11bbC0w6vKCIlFxrZ5w9p8flXvFyckRPoUjVn8d72r
 OkZY0oijSsftuUmzkNWaBM7I64Na91KxP7enZqFvlkyi5JE3nAn2Ku0kUjbLrjmCSqPc
 vthn6FYdyhRwWMAP5sEElk9unnuhrXhgxLiKthKL+MfAF1H+E2WJ8zEVRemjcGkNpZKu
 MvCsM0HfJ3T5K/Ri9MAeRxtlfShsfta8mPjDIvcW3HVfoJH5OQzr4XIS/TKNwvLS7JAm
 1TwlFYQf3ixZJuv15a8YNAKj2vgNFqJVFF6qZf/LL+Ly4gN4cP9afbsskrCumLkho/WD
 pccg==
X-Gm-Message-State: ACrzQf1bqkhzLb1X0lBSRF7moGZ9MhXuja5HnB7Zcfwxw3MQIZtUO+8N
 jNupg3zTy5X7eN4td91e2vBa/5aF2Bko4HNQSBxn3wGug9/IEDEIQSWKOuKQc0fOn+PZUjD/b0A
 3x2fo7ejcQR+q+h9vFN/2+fPfJh6xS+3IlBiHJM8pOQ==
X-Received: by 2002:a5d:4581:0:b0:228:a8e5:253c with SMTP id
 p1-20020a5d4581000000b00228a8e5253cmr16709132wrq.506.1665573072676; 
 Wed, 12 Oct 2022 04:11:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4M2UeBQqsLu/YgEb0FS7XO2FtVoGI+qgl10zlKDVC740GbGZGoVVc16JkgQ8fSzCwcytvnSw==
X-Received: by 2002:a5d:4581:0:b0:228:a8e5:253c with SMTP id
 p1-20020a5d4581000000b00228a8e5253cmr16709111wrq.506.1665573072445; 
 Wed, 12 Oct 2022 04:11:12 -0700 (PDT)
Received: from redhat.com ([2.54.162.123]) by smtp.gmail.com with ESMTPSA id
 y8-20020a05600c364800b003c6bd91caa5sm1493777wmq.17.2022.10.12.04.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Oct 2022 04:11:11 -0700 (PDT)
Date: Wed, 12 Oct 2022 07:11:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [GIT PULL] virtio: fixes, features
Message-ID: <20221012070532-mutt-send-email-mst@kernel.org>
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <87r0zdmujf.fsf@mpe.ellerman.id.au>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xiujianfeng@huawei.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 wangdeming@inspur.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>, angus.chen@jaguarmicro.com,
 lingshan.zhu@intel.com, linuxppc-dev@lists.ozlabs.org, gavinl@nvidia.com
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

On Wed, Oct 12, 2022 at 05:21:24PM +1100, Michael Ellerman wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:
> >
> >   Linux 6.0 (2022-10-02 14:09:07 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> >
> > for you to fetch changes up to 71491c54eafa318fdd24a1f26a1c82b28e1ac21d:
> >
> >   virtio_pci: don't try to use intxif pin is zero (2022-10-07 20:00:44 -0400)
> >
> > ----------------------------------------------------------------
> > virtio: fixes, features
> >
> > 9k mtu perf improvements
> > vdpa feature provisioning
> > virtio blk SECURE ERASE support
> >
> > Fixes, cleanups all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Alvaro Karsz (1):
> >       virtio_blk: add SECURE ERASE command support
> >
> > Angus Chen (1):
> >       virtio_pci: don't try to use intxif pin is zero
> 
> This commit breaks virtio_pci for me on powerpc, when running as a qemu
> guest.
> 
> vp_find_vqs() bails out because pci_dev->pin == 0.
> 
> But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
> succeed if we called it - which is what the code used to do.
> 
> I think this happens because pci_dev->pin is not populated in
> pci_assign_irq().
> 
> I would absolutely believe this is bug in our PCI code, but I think it
> may also affect other platforms that use of_irq_parse_and_map_pci().
> 
> cheers

How about fixing this in of_irq_parse_and_map_pci then?
Something like the below maybe?

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 196834ed44fe..504c4d75c83f 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -446,6 +446,8 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 	if (pin == 0)
 		return -ENODEV;
 
+	pdev->pin = pin;
+
 	/* Local interrupt-map in the device node? Use it! */
 	if (of_get_property(dn, "interrupt-map", NULL)) {
 		pin = pci_swizzle_interrupt_pin(pdev, pin);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
