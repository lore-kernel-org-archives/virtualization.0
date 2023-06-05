Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A335AC7EE2A
	for <virtualization@archiver.kernel.org>; Mon,  5 Jun 2023 05:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1800140360;
	Mon,  5 Jun 2023 05:44:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1800140360
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fGFQpBRR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WPFFvJ0DCLgV; Mon,  5 Jun 2023 05:44:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A7CCC40114;
	Mon,  5 Jun 2023 05:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7CCC40114
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FCBBC0037;
	Mon,  5 Jun 2023 05:44:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38AB4C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 05:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C81D40360
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 05:44:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C81D40360
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1TgLGdSWHqCX
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 05:44:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A58240114
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4A58240114
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jun 2023 05:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685943876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ejXk37OnpgBfntpQO2hBNILL2g4QMjhCiXN34MbvEk=;
 b=fGFQpBRRMc40C8fWbp/Nrv4DsdtHxKzD4SEaxGaMphPyxjZMJnxgZNoBWMR4jE2FEfTD6b
 fA3eKHFWdsf0rYddOWY60d+M+xnW8HeIduBpgtjxURdOCaZfq80SWSHjWyRmv/UF0W1Xoh
 CWVW8WYSk8yRDqF2S90dsTMCa6JGpVA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Xg8FRWD6MDWhb_h4f2FPAg-1; Mon, 05 Jun 2023 01:44:33 -0400
X-MC-Unique: Xg8FRWD6MDWhb_h4f2FPAg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30c2b38bf87so2386497f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jun 2023 22:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685943873; x=1688535873;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ejXk37OnpgBfntpQO2hBNILL2g4QMjhCiXN34MbvEk=;
 b=WcLYcRroAZHiO1S4KAh0TF0/S7jNTSqmE+QcAGp6rOOuBUK72kXC4gW1u6egBsHD4u
 UW7maErEvFdg+OSUwGKtV+8tpcRwdngTlwpI3lPqgFFJkoRiFZy1+GTTPU9xqi94Ev+1
 yp38z78c7ew6U17lQe/n2vTzgO7q+H4lOpXnf7Y32G9xg1UKTRSTKNlvradTFJzpY0s4
 ce6kkqYNqLSSb7CUGBV++FqC1dF7qnMW/5iKrNKqCNEV+R8CeQoVvG4X0DXlD75mqImg
 4fFESrPkxA2IxftZbfWarX76vVPXU2lsePO3hfViMJvR7Gx8L9/jE0G1j0Cu1Jr/G4L9
 f5bw==
X-Gm-Message-State: AC+VfDz1FEtpVjtkDegkVa06f9JwKY6Ys1IPiyoAe2AVkliB+RP4DXqD
 w/gYFrz1mzH+h2Ar4RBuIOiIhdmgdjoMxR7HHIrjewDUQVoVigDYQLP/QSHSBWGUj+3YcDlhhCV
 esrgoRWJjiHlljnKP10TyeWn9baioJKoZcmeRtlbEgA==
X-Received: by 2002:adf:f687:0:b0:30a:e5e3:ea66 with SMTP id
 v7-20020adff687000000b0030ae5e3ea66mr4818797wrp.14.1685943872852; 
 Sun, 04 Jun 2023 22:44:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5PHhVf9POTk1AmuouTd4HghcP4O8qLZ+32oStK2OroFPJBE288EDHshOL1o8Lb2YOXPb2Bvg==
X-Received: by 2002:adf:f687:0:b0:30a:e5e3:ea66 with SMTP id
 v7-20020adff687000000b0030ae5e3ea66mr4818781wrp.14.1685943872612; 
 Sun, 04 Jun 2023 22:44:32 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003f195d540d9sm13048625wmr.14.2023.06.04.22.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 22:44:31 -0700 (PDT)
Date: Mon, 5 Jun 2023 01:44:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 10/10] virtio_net: support dma premapped
Message-ID: <20230605014154-mutt-send-email-mst@kernel.org>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-11-xuanzhuo@linux.alibaba.com>
 <20230602233152.4d9b9ba4@kernel.org>
 <1685931044.5893385-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1685931044.5893385-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Jun 05, 2023 at 10:10:44AM +0800, Xuan Zhuo wrote:
> On Fri, 2 Jun 2023 23:31:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Fri,  2 Jun 2023 17:22:06 +0800 Xuan Zhuo wrote:
> > >  drivers/net/virtio_net.c | 163 +++++++++++++++++++++++++++++++++------
> >
> > ack for this going via the vhost tree, FWIW, but you'll potentially
> > need to wait for the merge window to move forward with the actual
> > af xdp patches, in this case.
> 
> 
> My current plan is to let virtio support premapped dma first, and then implement
> virtio-net to support af-xdp zerocopy.
> 
> This will indeed involve two branches. But most of the implementations in this
> patch are virtio code, so I think it would be more appropriate to commit to
> vhost. Do you have any good ideas?
> 
> 
> Thanks.

Are you still making changes to net core? DMA core? If it's only
virtio-net then I can probably merge all of it - just a couple of
bugfixes there so far, it shouldn't cause complex conflicts.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
