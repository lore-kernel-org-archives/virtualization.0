Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCFAC04A95
	for <virtualization@archiver.kernel.org>; Thu, 29 Sep 2022 07:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5674D61050;
	Thu, 29 Sep 2022 07:01:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5674D61050
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=axPKG5JF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7wHUt2XcGadH; Thu, 29 Sep 2022 07:01:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CD2DE60E63;
	Thu, 29 Sep 2022 07:01:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD2DE60E63
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7C3DC0032;
	Thu, 29 Sep 2022 07:01:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A1CCC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:01:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61CDB419D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:01:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61CDB419D6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=axPKG5JF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vEnA9A7OWPBA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:01:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5F69E419CD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F69E419CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 07:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664434872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AxK08tpN1f4WSm3Qo4h/uwm/D3uFgyKZ3mg/sBcp48w=;
 b=axPKG5JF/OHMaeU8ntK28fI65xj8AkTESeNqjc48Tsma5NqCvDxw/y+hUHsA5hY/Xi9Jpr
 vmQ/WeIVl/zqR2TMuwnUabz46tCDs43ypi4QicRZBIRLXjvofXvfY1+0FN6ONrIsbwNFlp
 rD/XVx+8uCqOuOiTVeKX49D+9TvEUUs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-278-yK06dq2oM9SeMJUlAi_CVw-1; Thu, 29 Sep 2022 03:01:09 -0400
X-MC-Unique: yK06dq2oM9SeMJUlAi_CVw-1
Received: by mail-wm1-f70.google.com with SMTP id
 h187-20020a1c21c4000000b003b51369ff1bso2552202wmh.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Sep 2022 00:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=AxK08tpN1f4WSm3Qo4h/uwm/D3uFgyKZ3mg/sBcp48w=;
 b=qdWyZGW5gqJlMAD8gV45xsHHoQ9hq1L6K5ST/f/w2hxFf/QcIfeZjk1vKh6LQV2LEA
 JfYZlMzZ37xHB/+XYazByEDNr2htLZVNudawvDOKYgs6YD6kBAE6eFqevYchfiqeroXI
 jryd6OVbInR7f/Fsii+7IwIGXADhY6zWgFZNFkFVlTEQfrtxyKAiCqtZcNeX6wZKnyLG
 7kUSvejZjGT2zkoOxiHaaFuYNpOz6nkONHyv8ylsoNp0X1piF2/VdPEtdGLdZdaPPOGE
 bIzTc7Aa6dyWKNwnxwODrx7Nt1A1ZJKRjY/IWja3F8iPvUYfJNJ8DGOxh1qQ44cjgjvi
 fVTw==
X-Gm-Message-State: ACrzQf1Vt78bbO2zCPcc2btToJ2AO/pTPldhi3zyUVcEx3lBkQT475AW
 Mg+M0mp72s+FDaw61ux7KQ4LEjKJ4+2q5ItbREMqoLv9uPzTKObKe0W4cJ9Su6m7cxmuWH5czqO
 P9oPpwGQ9cQ96Bcs5O2StM/kckAyU9FGluES58WAlSA==
X-Received: by 2002:adf:e4ca:0:b0:228:d8b7:48a7 with SMTP id
 v10-20020adfe4ca000000b00228d8b748a7mr998855wrm.300.1664434867941; 
 Thu, 29 Sep 2022 00:01:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ZbRji7MbNVQKoWmesvvZxQ9b3Cpq1Lt79TWy3szetsqpegw4eZnLiCCE6V5WfZSRm2OWveg==
X-Received: by 2002:adf:e4ca:0:b0:228:d8b7:48a7 with SMTP id
 v10-20020adfe4ca000000b00228d8b748a7mr998833wrm.300.1664434867646; 
 Thu, 29 Sep 2022 00:01:07 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c4f8200b003b27f644488sm3861501wmq.29.2022.09.29.00.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Sep 2022 00:01:07 -0700 (PDT)
Date: Thu, 29 Sep 2022 03:01:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavinl@nvidia.com>
Subject: Re: [virtio-dev] [PATCH v6 0/2] Improve virtio performance for 9k mtu
Message-ID: <20220929030022-mutt-send-email-mst@kernel.org>
References: <20220914144911.56422-1-gavinl@nvidia.com>
 <68934c1a-6c75-f410-2c29-1a7edc97aeb9@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <68934c1a-6c75-f410-2c29-1a7edc97aeb9@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-dev@lists.oasis-open.org, sridhar.samudrala@intel.com,
 jesse.brandeburg@intel.com, virtualization@lists.linux-foundation.org,
 stephen@networkplumber.org, loseweigh@gmail.com, netdev@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net
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

On Thu, Sep 29, 2022 at 02:50:00PM +0800, Gavin Li wrote:
> 
> On 9/14/2022 10:49 PM, Gavin Li wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > This small series contains two patches that improves virtio netdevice
> > performance for 9K mtu when GRO/ guest TSO is disabled.
> > 
> > Gavin Li (2):
> >    virtio-net: introduce and use helper function for guest gso support
> >      checks
> > ---
> > changelog:
> > v4->v5
> > - Addressed comments from Michael S. Tsirkin
> > - Remove unnecessary () in return clause
> > v1->v2
> > - Add new patch
> > ---
> >    virtio-net: use mtu size as buffer length for big packets
> > ---
> > changelog:
> > v5->v6
> > - Addressed comments from Jason and Michael S. Tsirkin
> > - Remove wrong commit log description
> > - Rename virtnet_set_big_packets_fields with virtnet_set_big_packets
> > - Add more test results for different feature combinations
> > v4->v5
> > - Addressed comments from Michael S. Tsirkin
> > - Improve commit message
> > v3->v4
> > - Addressed comments from Si-Wei
> > - Rename big_packets_sg_num with big_packets_num_skbfrags
> > v2->v3
> > - Addressed comments from Si-Wei
> > - Simplify the condition check to enable the optimization
> > v1->v2
> > - Addressed comments from Jason, Michael, Si-Wei.
> > - Remove the flag of guest GSO support, set sg_num for big packets and
> >    use it directly
> > - Recalculate sg_num for big packets in virtnet_set_guest_offloads
> > - Replace the round up algorithm with DIV_ROUND_UP
> > ---
> > 
> >   drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++--------------
> >   1 file changed, 32 insertions(+), 16 deletions(-)
> > 
> > --
> > 2.31.1
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> Did you get a chance to pull these short series?

Not in net-next yet for some reason, I was hoping it
will get some testing here. I'll put it in my tree
for next for now so it gets tested. Thanks!

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
