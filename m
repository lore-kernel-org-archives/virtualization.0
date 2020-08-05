Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE3C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:13:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32AE422D75
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tfkx1kac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32AE422D75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C7ADC86742;
	Wed,  5 Aug 2020 13:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jVlk-ty3DbpK; Wed,  5 Aug 2020 13:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0BD3186030;
	Wed,  5 Aug 2020 13:13:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2E19C0051;
	Wed,  5 Aug 2020 13:13:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A96A1C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 96E0588158
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LKg2ONrxXseP
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:13:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F08EF880C8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596633184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvvVbA3neuStjhovJpqPYB6dYLf6War6ZdtpyVOVpoo=;
 b=Tfkx1kacuhtj9Nvu4raduT9MnkNu07SEM+Wl6dr3QKBwhyu0t2Pfe4uQpWr96qH8K6u79G
 2PeStPeeoCvO6AunCxlUd27nm4i9Py/tSgCwPK4Ny4z/kikgF8EkNDOGhhS31hHmPyFk0P
 mb8pjd54reEyvA4vc1XmHrvf+XgiWnM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-reTWhOWsOrG2CkVWFfWeSQ-1; Wed, 05 Aug 2020 09:13:03 -0400
X-MC-Unique: reTWhOWsOrG2CkVWFfWeSQ-1
Received: by mail-wm1-f69.google.com with SMTP id h205so2711036wmf.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wvvVbA3neuStjhovJpqPYB6dYLf6War6ZdtpyVOVpoo=;
 b=MDRy3le0a1FrYwGPt2t7CtzYvoIO1mwiAsGo1bC+sr2Sl8FjOrVa3Nt0vAFn+7CCao
 Z93wnxRO7vHRradmAWKmRqKRQ6y5Z0LheJ7GGHvhTyPS4/Gm6UPs9lUMdT5/QdroHC0W
 jyAFupCjuiF9MQ8bd6tWfKVCNKGbiEuttc8OPbLp6ZiGEDFUusqux+WIb6GPPtmtgwTJ
 G80ZiGMvKuzPOoUHD0ZGgZGW9DPa6R8qVTt8gV2cKlHcZaL3ayicINgU3jQ9eHm7AgcD
 UDuN8vraAwJ2Nlc1ydvjiDtqeRIdo6YBsZrylxL1xGc/fQ2vID9r2UEHeHuxd6xLx1mj
 BNCg==
X-Gm-Message-State: AOAM531HAFadXkrEXcPXZqVbbJ8kbDxcpS3CiK6MzuGHr0UjxwkQEaxr
 jynchpj1nQ9SlphlcagutrxwKLh0Q55CFnbVvX9cF2z2royYXpL52sNd9kntpKJ93FAb/nzrEJC
 jvstM8U4HqXcTNN2XQZYuENlihPqs7kxyPrGfRpAz6w==
X-Received: by 2002:a1c:1d91:: with SMTP id d139mr3411887wmd.144.1596633182189; 
 Wed, 05 Aug 2020 06:13:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9coyERUcXT3yxN24ZYMf+XfyA2+T1qmyE4JuGsj7TRNRDbULVwH+0UMH6Eic7iEdmMl0Cjg==
X-Received: by 2002:a1c:1d91:: with SMTP id d139mr3411871wmd.144.1596633182015; 
 Wed, 05 Aug 2020 06:13:02 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 31sm2746951wrp.87.2020.08.05.06.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:13:01 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:12:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805090304-mutt-send-email-mst@kernel.org>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200805075856-mutt-send-email-mst@kernel.org>
 <20200805124054.GA125576@mtl-vdi-166.wap.labs.mlnx>
 <20200805084604-mutt-send-email-mst@kernel.org>
 <20200805130158.GA126406@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200805130158.GA126406@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, parav@mellanox.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, saeedm@mellanox.com
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

On Wed, Aug 05, 2020 at 04:01:58PM +0300, Eli Cohen wrote:
> On Wed, Aug 05, 2020 at 08:48:52AM -0400, Michael S. Tsirkin wrote:
> > > 
> > > Did you merge this?:
> > > git pull git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next
> > 
> > 
> > I can only merge this tree if no one else will. Linus does not like
> > getting same patches through two trees.
> > 
> > Is this the case? Is mlx5-next going to be merged through
> > my tree in this cycle?
> > 
> 
> Saeed Mahameed from Mellanox (located in California) usuaally sends out
> net patches. So he's supposed to send that to Dave Miller.
> 
> I think Saeed should answer this. Let's wait a few more hours till he
> wakes up.

Alternatives:
- merge vdpa through Saeed's tree. I can ack that, we'll need to
  resolve any conflicts by merging the two trees and show the
  result to Linus so he can resolve the merge in the same way.
- extract just the necessary patches that are needed for vdpa and
  merge through my tree.
- if Saeed sends his pull today, it's likely it will be merged
  early next week. Then I can rebase and send a pull with your patches
  on top. A bit risky.
- do some tricks with build. E.g. disable build of your code,
  and enable in Saeed's tree when everything is merged together.
  Can be somewhat hard.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
