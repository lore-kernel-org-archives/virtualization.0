Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0215C43217
	for <virtualization@archiver.kernel.org>; Fri, 14 Oct 2022 14:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C1684119D;
	Fri, 14 Oct 2022 14:19:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7C1684119D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cJvxm59O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bp4PmNEIX8tQ; Fri, 14 Oct 2022 14:19:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1DD484060E;
	Fri, 14 Oct 2022 14:19:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1DD484060E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED689C0032;
	Fri, 14 Oct 2022 14:19:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFD23C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 14:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC452410E0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 14:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC452410E0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cJvxm59O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id THVNahXJDFjS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 14:19:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D66F4098B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D66F4098B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665757162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPuKJ60cBEpeR02PEA015wmZlw2SVkGuGapsHTI2RRE=;
 b=cJvxm59OzWe4w97onAYEbzcjDpfTUt4BKBWp0nTtGlwPKLS+BDGYs30olMzK2lGMhhMpP2
 3xfov3hJuq8LL7AI5B6S2c4cghYXdQhyzvvVq7aUYZlkhjcvlVGcGxvDxnBeYpjkQrAm16
 YJNJ4vSJDk/NjqACme7VNRA5DUvmT0w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-R174DJWLMAmJDDkAf219Cw-1; Fri, 14 Oct 2022 10:19:21 -0400
X-MC-Unique: R174DJWLMAmJDDkAf219Cw-1
Received: by mail-ej1-f72.google.com with SMTP id
 ho8-20020a1709070e8800b0078db5e53032so2481588ejc.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Oct 2022 07:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPuKJ60cBEpeR02PEA015wmZlw2SVkGuGapsHTI2RRE=;
 b=s9aN5IBrKv5NZLzB6AWo7ojrD6L8B1PCxYVPZjGW0dQXNRsHB8C3F6mEomCSzPQ8k5
 atpG4IXPmCjk5wqyGjyEwBbmE6fHa7db3iM6PylllvWTbdmIiPaxKTnzCTPh7u4We9/Z
 Zv5XbkKQZMkIq/XYfXKSnESE2zvFsUDXYTCLdJC9ZescW/SX4a3bplNUZtebEa565pbc
 faOE7uVsSqPYikPMrraj+JDteWzmoU7oKxeesLYi4jNYNOQQoM/DNDI9q59Cu1GCIQQs
 Z/BgEdG4P6VwS4ZTiXiwf/UrYTzlf/StDLOt1wUBgNmCInOZ4+Olgj4rgXlcV2VPk97e
 CZLg==
X-Gm-Message-State: ACrzQf2jyc2cvD5XHOZrHuq8W9vPuzLbjZDwgolCkNH0eEdQJ5Nqwbhe
 HTMk8h+ASHruKIYE6x5xfi3Lrv4umn7T6D3h591rBgTG8AP9GoLitiO5Ptcvbe5DAv/GchFsM1Z
 I3cfrhLNmauTDs0nn6hAO5vrB6RMwk6lM1p/1bDYdRw==
X-Received: by 2002:a17:906:7304:b0:6ff:a76:5b09 with SMTP id
 di4-20020a170906730400b006ff0a765b09mr3600283ejc.193.1665757159967; 
 Fri, 14 Oct 2022 07:19:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6th+u5AZexbhw7H+ue9OBwy7Sl7MLFHR6h7JcJtbzIfWC+7wpBdE6JaQrJnklJf3BLx4FaDw==
X-Received: by 2002:a17:906:7304:b0:6ff:a76:5b09 with SMTP id
 di4-20020a170906730400b006ff0a765b09mr3600268ejc.193.1665757159737; 
 Fri, 14 Oct 2022 07:19:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e3:3300:b7f8:ebb0:9b02:7d37])
 by smtp.gmail.com with ESMTPSA id
 cq6-20020a056402220600b00458cc5f802asm1882063edb.73.2022.10.14.07.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 07:19:18 -0700 (PDT)
Date: Fri, 14 Oct 2022 10:19:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: Introduce RESUME backend feature bit
Message-ID: <20221014101858-mutt-send-email-mst@kernel.org>
References: <72bdc9ae91ca4ed8a2c9ea2aab53f8e04d4512f6.1665674878.git.sebastien.boeuf@intel.com>
 <CACGkMEt7cEocQp70MgtwWjb0yNv_08qq-aKp8ZTbFbTkW6hxbw@mail.gmail.com>
 <20221014020447-mutt-send-email-mst@kernel.org>
 <CACGkMEtSAbO8U4reoAupuixv4KQw-xutCVt6ZXVSsXgM962eJw@mail.gmail.com>
 <20221014021012-mutt-send-email-mst@kernel.org>
 <14fc89d250788d7bdbd6b522197efc2c19ff6db8.camel@intel.com>
 <20221014053617-mutt-send-email-mst@kernel.org>
 <fb0d70a095a26a8f8adf4d7659787596d2763ef6.camel@intel.com>
 <20221014054201-mutt-send-email-mst@kernel.org>
 <129e9d73551e53c3704a1dcdb3626c0e712eed99.camel@intel.com>
MIME-Version: 1.0
In-Reply-To: <129e9d73551e53c3704a1dcdb3626c0e712eed99.camel@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Oct 14, 2022 at 09:48:57AM +0000, Boeuf, Sebastien wrote:
> Ok thanks for the clarification. So I can remove this piece of
> validation from the code, and ultimately, each backend implementation
> could decide to complain (or not) if the userspace calls resume() when
> suspend() isn't supported. Is that a fair summary?

that's my opinion, yes.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
