Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C943DA23
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836869; cv=none; b=e8bMIsoGFngKAY5YdvNddPYZlAPw06LRdxBOMFffmqiCvKjFL+JHIZ2iIxFqxYsfLzfdJsN/Ocvu1MRwsqBGp+raoGGqPlg/oRB6mLr9XLNuWHkl4QxxtUffWBk5Oro+TboW4eLLE2T/bWloiXViBs7FSBWnnU+lSes1+6EYcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836869; c=relaxed/simple;
	bh=kvhGlFT183z46f4prQv9UsB0406P5Y8xm81IA80kJuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Pe6cFV5WTXceK4Ej+XsduG+j7swAskT0zN9JZGTc7p2SnVwk38zco/sAuUaJl49ykc7iJlgVvEONjT6+VowC3jvnuOpcVu2VGU7pf1o676giobGqgcTc54qY4IUkKTUJm/YVHIBXp5Y/KcRfYqCu1X6R1euF7FvDfDduzeuLxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMWI7QoZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMWI7QoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778836865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=coiGVgNORCz4Zh3xYVYNCYPRQwJYgr83BYwKKI9/FxM=;
	b=MMWI7QoZJiBEnfxzaPj6M48nklJyv4QBeghrEtuPeXJ+cWoKZ4CaKEB0okGTlP0saEt2Je
	wK6ScJ62yyACE2HdDFF19dWvNyeqWCWy1j49oPgT7MpE+LEsKocMvPVP1dhUO+u6zOSk4h
	G6U1uP3hVRVL181rGdvrTLRCvdFtJsY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-g_qB6IJnNraNTIWCNaFTjA-1; Fri, 15 May 2026 05:21:00 -0400
X-MC-Unique: g_qB6IJnNraNTIWCNaFTjA-1
X-Mimecast-MFC-AGG-ID: g_qB6IJnNraNTIWCNaFTjA_1778836859
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45aeac88af4so3195935f8f.3
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 02:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778836859; x=1779441659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coiGVgNORCz4Zh3xYVYNCYPRQwJYgr83BYwKKI9/FxM=;
        b=iui/TkC3tBH/FjInOlChobKVdqR2c1ya/u5Fa909aQSwbrs82Satr/F4H22NfEQ/ax
         3M7G83tt1w9SiUikrjwv6xLnfLom5Qrorb/UD3AGqNmghrf4bYPemjl0Yk1QM4bDkw0k
         TJyCaqW6hGgWxJiR2YVt3/in+STdEPacHSidw48Tjnqz5cGhjf8HKtkwXQQI1MKbFb7l
         nXwkFFpPcn+60WzHvYhTxqOUunOUet+KKXRiTFW1AaQjjHQlJEwhEKeiPIKCIAe2tjo4
         Z22C39dQvjbSRb1CF61htLi/1E0Hx+r3SqIHFWxlhimkkywsdcyLBO2kyBgUULr2k8AS
         /Byg==
X-Forwarded-Encrypted: i=1; AFNElJ8dDGRiowf6XEMTpQbQtfNWtKZCJ9aRBq04of5k1MGM9JJnyCfP/VQUK/Rh19cviPLFjPaRXGOvx5BRx04MeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEzjYDZSWlAdaxzk3Bsrff5XH86j2u04OXQEM42HjY3KTXBfBN
	b1s/H/1KqSsnVQPtPf3aPNKnRbuiX0I+IhEkuVCiW3IgfqZVEEK9qP3UXi2hspUzUB3nnTuBdlh
	+WvvkjtFC3ENujWI+0+rvpVoOAartOqk5mCNDxYu3UIEnoBuuCBhHPfQtrZuC9I1rvIehvPfO7o
	xq
X-Gm-Gg: Acq92OHKkLeKDu1sDyAFoZhU/w2IBVp4/uDs74KaY/Y0i+QQwD4VWrPl/6UJLE24TfU
	y0SKYsLY/tW6bj/VnEKlJA6j1mDrAhMqQ9b8RBgtdg4Y+aPV5v50Dpbt5ndG3Wjaa09WhKX5N4s
	bezvg8JTy2DqqwJ1Qurvx5pWbrFAO7lEGa6sUHSwVSGu56K5YfER05E5a3LN0wUF6wyF8Dv4Edf
	Y9VT0+ILZCfYnUa6lhM9Dn1JnVAGmWXMZ4WqUaUpymWjv++52GvTAv5+GWOTbemmSxoW9OF0XlG
	9lDMCWXmLuEAWazQam4QY0CBVjvXNthJlnHqmAsfOrPvobaJwi67SOELHcym5PHgx75oTU+2hwf
	Er6Qa4p2SQlUhAKe9C6kwmyZq5Lc5Zu7HVf33/XuCW6xxol9Cezk=
X-Received: by 2002:a05:6000:22c5:b0:43c:f5a0:4e56 with SMTP id ffacd0b85a97d-45e5c5f9d94mr3855117f8f.42.1778836858717;
        Fri, 15 May 2026 02:20:58 -0700 (PDT)
X-Received: by 2002:a05:6000:22c5:b0:43c:f5a0:4e56 with SMTP id ffacd0b85a97d-45e5c5f9d94mr3854928f8f.42.1778836856499;
        Fri, 15 May 2026 02:20:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm13634930f8f.10.2026.05.15.02.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:20:56 -0700 (PDT)
Date: Fri, 15 May 2026 05:20:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <20260515051829-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
 <20260514134347-mutt-send-email-mst@kernel.org>
 <agbWNqhzvEHVBvC2@sgarzare-redhat>
 <20260515043940-mutt-send-email-mst@kernel.org>
 <agbg-pUhBRB89aEX@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agbg-pUhBRB89aEX@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3FBwdTcRZy74rX-bLLQcTrGtb04w9Pjr4Og0eWc6anw_1778836859
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2026 at 11:06:42AM +0200, Stefano Garzarella wrote:
> On Fri, May 15, 2026 at 04:57:41AM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 15, 2026 at 10:29:55AM +0200, Stefano Garzarella wrote:
> > > On Thu, May 14, 2026 at 01:44:53PM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
> > > > > On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> [...]
> 
> > > > > >
> > > > > >
> > > > > > And so the bag of hacks grows. I feel this is energy not well spent.
> > > > > > Please, let us fix this properly *first*. And then worry about how to
> > > > > > backport.  Maybe it will not be so terrible to backport after all.
> > > > > >
> > > > >
> > > > > TBH I don't think this is an hack, but an issue we should fix in any case.
> > > > > Regarding the second patch, I see your point, but it's a big change
> > > > > that worries me. I'd like some more time to fix it properly without
> > > > > rushing. Staying calm without realizing that userspace is broken like
> > > > > we are now without this series :-(
> > > > >
> > > > > That said, evaluating further, I think we have a similar issue also
> > > > > with STREAM on the host side where the skb usually doesn't free space,
> > > > > so we need a merge strategy also there.
> > > > >
> > > > > So, I'd like to have time to fix both definitely. If you have time and
> > > > > want to go ahead, please do.
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Well my patch was a start, we just need a strategy how to avoid copying
> > > > everything, right?
> > > 
> > > Yep, and then there's the question of how to handle EOM without a payload,
> > > but I think that's a special case. In theory, we don't support sending it,
> > > but I'm not sure if POSIX allows it or not.
> > 
> > It seems to, but given we didn't allow it in the past, we probably
> > should not start now without a good solution.
> 
> Agree.
> 
> > Really we should add a feature bit for EOM to steal a byte from
> > buf_alloc. Or several bytes)
> 
> Yes, I agree. At this point, though, could we define a new protocol that
> also takes overhead into account, or would it be too complicated to
> synchronize both?

Well isn't it just X bytes per EOM? The rest can be fixed with
merging?

> > 
> > > That said, is it okay if I send a v4 of this series?
> > > 
> > > (I'm not sure if I'll be able to work on the merging next week)
> > > 
> > > Stefano
> > 
> > 
> > I do worry we are piling up hacks and we'll end up with races
> > for all our troubles. That said, up to you.
> > 
> 
> I see it differently; Patch 1 should have been there from the start.
> Patch 2, unless we completely remove the overhead, we should keep it, or use
> it to trigger merging (e.g., when the overhead reaches a threshold that
> depends on `buf_alloc`).

I'm not sure we need to merge retroactively though. Maybe just start
merging new stuff when over a threshold. Should be simpler.


> I prefer to send a v4.
> 
> Thanks,
> Stefano

