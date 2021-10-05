Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8D5C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:11:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68CA61181
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C68CA61181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 951F2407C2;
	Tue,  5 Oct 2021 11:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pUdvP-z0hQh8; Tue,  5 Oct 2021 11:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 40C9A4077B;
	Tue,  5 Oct 2021 11:11:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A4FEC0011;
	Tue,  5 Oct 2021 11:11:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4940C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86EB483CF5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mV8aX-5xtKNG
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:11:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF25183CE1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633432301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eeArBAcS9Q84SLX+oAxukLYME3k/d29Rm/s+++jGKPE=;
 b=D0jNMDRvaOLQOYU+z/QmI+MztgqYL4VPvYsy/HmR4NY9u45+T99XS2SJ/2iDyvL+vwMlEc
 oGfboPKxDfCH8s7Ow4wXmhVl+6uqvyW/ZqqhFc1nPBM88ZYQuUXeaM/ezehVXX4zRyDqtb
 UarWfdsgO/8jtiO21E1SFYvoRTOLKMg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-4BM2LLEAPjWO7Bi03siGfQ-1; Tue, 05 Oct 2021 07:11:38 -0400
X-MC-Unique: 4BM2LLEAPjWO7Bi03siGfQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 r11-20020aa7cfcb000000b003d4fbd652b9so20258831edy.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 04:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eeArBAcS9Q84SLX+oAxukLYME3k/d29Rm/s+++jGKPE=;
 b=y5jDUPgHjv+2BcMRMYj1iUwVTcfaRmd1SzAsdCLA+pWUKuGgnoKVgHQ9qh6SWCLm5y
 mlhqJGmyh7iJy4icy55BnNwv8F3sm3bE3zebiiTLwdxsP8dsKVHUrRpXJ10C23pbx1ZF
 UCZj9Fd3iT3tt8h/LXUoKU7twYKdlSZt15znLYoFYi4SwTZjx2GJX/BMJ6MtO+tB4F69
 bTiMBaT5lPRAt5czLvvrH5EJdy3+w2vlA497quMp2K5ewYrsaaMbjzlU+PqKl0jtopSq
 m4+FmF4ptEMqHukAcmA8wSgPQ5JLT2ih2w6kVpm1ytKsy45/vI5gDovEF0la70tWkdeS
 LTtA==
X-Gm-Message-State: AOAM531PGqnquPUyumwi/SWtBM/WsAdFLcd3ojRT53DxTNnMJblx5+3/
 +oI3KT5h1Map1WtwgShNiMMLliSNqI0YC4pJt93r65Z2Y3P9FINIk1HnlMmEDeqOX3f+50CsPmm
 n0kRznKua5DZMlEW/+JNqoL3gC4RiMIn2qM+Gve9Tsw==
X-Received: by 2002:a17:906:81da:: with SMTP id
 e26mr23837032ejx.296.1633432297531; 
 Tue, 05 Oct 2021 04:11:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcsiNXEPQdBdUK3S2sCQgXB8aTeyms7C9ktkEXECdOiZs9AxXkmtcIiymlmiwW6qydZSPVfw==
X-Received: by 2002:a17:906:81da:: with SMTP id
 e26mr23837003ejx.296.1633432297372; 
 Tue, 05 Oct 2021 04:11:37 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id q6sm7451568ejm.106.2021.10.05.04.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 04:11:36 -0700 (PDT)
Date: Tue, 5 Oct 2021 07:11:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211005071128-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <20211005092539.145c9cc4.pasic@linux.ibm.com>
 <20211005035014-mutt-send-email-mst@kernel.org>
 <20211005124634.2a774796.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211005124634.2a774796.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Xie Yongji <xieyongji@bytedance.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 virtualization@lists.linux-foundation.org
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

On Tue, Oct 05, 2021 at 12:46:34PM +0200, Halil Pasic wrote:
> On Tue, 5 Oct 2021 03:53:17 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > Wouldn't a call from transport code into virtio core
> > > be more handy? What I have in mind is stuff like vhost-user and vdpa. My
> > > understanding is, that for vhost setups where the config is outside qemu,
> > > we probably need a new  command that tells the vhost backend what
> > > endiannes to use for config. I don't think we can use
> > > VHOST_USER_SET_VRING_ENDIAN because  that one is on a virtqueue basis
> > > according to the doc. So for vhost-user and similar we would fire that
> > > command and probably also set the filed, while for devices for which
> > > control plane is handled by QEMU we would just set the field.
> > > 
> > > Does that sound about right?  
> > 
> > I'm fine either way, but when would you invoke this?
> > With my idea backends can check the field when get_config
> > is invoked.
> > 
> > As for using this in VHOST, can we maybe re-use SET_FEATURES?
> > 
> > Kind of hacky but nice in that it will actually make existing backends
> > work...
> 
> Basically the equivalent of this patch, just on the vhost interface,
> right? Could work I have to look into it :)

yep

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
