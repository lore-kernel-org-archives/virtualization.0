Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45279C433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 06:56:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA27610E6
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 06:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CCA27610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89C2740636;
	Wed, 20 Oct 2021 06:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id geHDrH5C_0Jz; Wed, 20 Oct 2021 06:56:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25E7340638;
	Wed, 20 Oct 2021 06:56:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA943C0011;
	Wed, 20 Oct 2021 06:56:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D93FC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 06:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45208400DA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 06:56:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 62AzPMxR55Qz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 06:56:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62EB7400C4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 06:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634712994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4AkzbJIuIOJAHop1s/JVJ6BQuEIDhfjRfELf4n/z/2I=;
 b=R4LrYzsf3pcOJrC8Qx8QoUfhxH7n2gr9YSue3oFfQbp+7O1YW7ccz4N/fdXTOOHRYC8nOj
 9GJtLliaFqX/7iG9lmFxoH9WIiTF2v9vhF3d2EedBbB76Dip9q/GnmuipW9zsQ2ISVilXX
 ZB9PxmIniUWEgfOMp86dC+EZ3H0DfCI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-HTEDU9HEPlyI23EjWh0WAQ-1; Wed, 20 Oct 2021 02:56:32 -0400
X-MC-Unique: HTEDU9HEPlyI23EjWh0WAQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 n9-20020a1c7209000000b0030da7d466b8so2552815wmc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 23:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4AkzbJIuIOJAHop1s/JVJ6BQuEIDhfjRfELf4n/z/2I=;
 b=cie4TrIW6+7XdF+jckLo8hUN/cAVpaBTtQXFBNDN5kP/9U4Wptss9qhXtnWA23mL/L
 8xarcbeBGmZ96d21Y8jrawNbXA46pbdXNu5M/TwvyHEEOw0nKDqWKVeafNzqFzItcVOM
 JOIjo6UMmg9gi4oP9AHB2Gq2h0PSUUE3TNXCVsFOGxUtATDYPpPB3VFzGRmcEG/xQX0G
 y0E10zGlR/bdLQcJcSO7lTZxAxsVvGDrEV1K/LLoVmH1gN62loeheEQsFKQzQrw0SFpi
 jTPpFDqHFAFJt5q+hCCb6s1J/HsmtXFcYTTzSIEkLzcAXUwO3qKTpYrDfaH0zkTRGPwL
 bMng==
X-Gm-Message-State: AOAM530yN/lEhvRW57eRPKNJ3zYn+YQvvWPcjoRT8dVI0/GM7Q6Xl8s4
 4m61fsE1iESPzvZ1JgAWsOiIP0XpNxNcn87su+7vu0qKHtfgYoE5/A0FdaxMcKBZjJHxJPX30GM
 sOYXO7kAzUxw6gy+SCCEYrxmKEvPzXQ8Whj8myhMsdA==
X-Received: by 2002:a05:600c:3511:: with SMTP id
 h17mr11395059wmq.144.1634712991608; 
 Tue, 19 Oct 2021 23:56:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5SkgS8SqfS8Adhn6/vlFcugcP4JX/aBBXBKoEulQcrWp4NjXFrc67Bvqi3WdGXtuiT74YGA==
X-Received: by 2002:a05:600c:3511:: with SMTP id
 h17mr11395040wmq.144.1634712991425; 
 Tue, 19 Oct 2021 23:56:31 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id a127sm4151894wme.40.2021.10.19.23.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 23:56:30 -0700 (PDT)
Date: Wed, 20 Oct 2021 02:56:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 06/12] virtio_pci: harden MSI-X interrupts
Message-ID: <20211020022529-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-7-jasowang@redhat.com>
 <c6641b6a-6204-2b41-e775-ad329314711c@oracle.com>
 <20211015132639-mutt-send-email-mst@kernel.org>
 <CACGkMEujcgMTtLiJWx5ZazVgM5qopB0ZVDkvg6cEuyRGAL31AA@mail.gmail.com>
 <c51930a2-3f47-407a-2b1a-fdd1d23ca7c2@oracle.com>
 <CACGkMEvSVA=qx6m7BvM-P9mm=KpPihWhVWUycj2WGnwxfa+HAA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvSVA=qx6m7BvM-P9mm=KpPihWhVWUycj2WGnwxfa+HAA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E . McKenney" <paulmck@kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Oct 20, 2021 at 09:33:49AM +0800, Jason Wang wrote:
> > In my own opinion, the threat model is:
> >
> > Attacker: 'malicious' hypervisor
> >
> > Victim: VM with SEV/TDX/SGX
> >
> > The attacker should not be able to steal secure/private data from VM, when the
> > hypervisor's action is unexpected. DoS is out of the scope.
> >
> > My concern is: it is very hard to clearly explain in the patchset how the
> > hypervisor is able to steal VM's data, by setting queue=0 or injecting unwanted
> > interrupts to VM.
> 
> Yes, it's a hard question but instead of trying to answer that, we can
> just fix the case of e.g unexpected interrupts.
> 
> Thanks

I think this it's still early days for TDX. So it's a bit early to talk
about threat models, start opening CVEs and distinguishing between
security and non-security bugs.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
