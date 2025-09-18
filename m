Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB230DEC5
	for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217236; cv=none; b=dvybuPe+s6gskcjR1eHe0J08mPHG22hIsGxz2lXpmvnmnWzeYv+uTeL/vtSUNU3snDzQL6Iz2xWDxlt36gou4vO5dNIUvBEV2p6sCTD1FoNDHDU7RB0yczxoMpnzdgji15AX7hStwXTK75cKzv9+GNPCQ9FBeCIC+Cm7AcwHAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217236; c=relaxed/simple;
	bh=PAJGdxzVh+hSxDOx5VKS60t2Dt2GkMypMDcKSqxK0Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nq4dY32ngFiLxRNkYXKQdrSIw+ejsJdGLUOAtIOZjmbnAYmTCHCaF/Bh+WdlNT8c0OXUrWMaf34/nQcJWtx7s3dGybDbXAEixlkEsNURuMr+seT3G+CeN0XtMxKFwFagX7Wq052s5b0PDFaRo3R6kq78FDU9S78eDW1Unpe0WMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UP/RZYwM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UP/RZYwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758217233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t1W/1phtqwQuVUIVURl6ScoEnd5TdTDKATokoKxzRnw=;
	b=UP/RZYwM+LUN+9Ji8r6IBL1lsjeNvdQst7HVikKRnBqGpvWIsiASg8sYh+9zknMq4+Ywi7
	DruTl9tPYE6JLLqTxaPUAErII6ch61EYN3vH/Pf81co2Ms0M8YimF60Shr0tPKvn+xu+wC
	17q2qIdSn9kjgs/GkIPTRTNKUQLz93w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-kD2M3Ee0OwWo31o0BWoW6w-1; Thu, 18 Sep 2025 13:40:30 -0400
X-MC-Unique: kD2M3Ee0OwWo31o0BWoW6w-1
X-Mimecast-MFC-AGG-ID: kD2M3Ee0OwWo31o0BWoW6w_1758217229
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45de07b831dso6305535e9.1
        for <virtualization@lists.linux.dev>; Thu, 18 Sep 2025 10:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758217229; x=1758822029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1W/1phtqwQuVUIVURl6ScoEnd5TdTDKATokoKxzRnw=;
        b=pMoTlqQjmCcPEKuM1ZG+nToVIZ0jyRodryKJ8a6EQAPlz4Bsh+yjyPJDO+jVsXhfmB
         oENN139C9XqRPBOnbBExQAF0DQIEiCQCUueBfT31A1Le9SQTG5I/q4kGulhDb1LQoqvO
         9/MLw/9K0GBfJ5JzJHpK8EJCd8L32Rks12RP0OQx5se+/Wp2MKaRYouBGwsA8tXP6zW9
         jHPHtu5rIu/aO+zIHLuEI2TLCVA16Bk8cDs/ARS55zCzqtDFZxEZhJDae1WHw5L7wL47
         l5+juB9O5wlw4MqsGPk97zNjF/63LmHSF0frgRM5rqMwl4GSwettNxdY/pXEEwHFjcFH
         kVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeGTTZBklwnAupjNW2D5J+Gj6c/O7CGNeQb4047gtwL82eC5ByF1RYBEBCMGub/4p2G/rLm+EkvtTuwxXF1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHrPI4SFv5rk2J6zAVPVxA+FZIecOSvjaCCq7LHGvW+OZYWhwK
	bSurvhjNYT+JpfXXsAeabPvYted7nNa0IxwcK8ofzv5Qj0rTI2pImTMAQremBIH20AMrrCRJdki
	Fbw8XfbwjgxseC7uGHaFLaDy+ypgb2Q/U7Yq6jaEs9ywUKAriswONuff84mF0XiMK7IP4
X-Gm-Gg: ASbGnctoOdjQyvpbvd51D9orIxBChln9EekgiBQQpMfztzj5Ke+FfwbG9w4daO0pRpq
	P2EWYfiGh0NhbVWlRx2udfpiL9pR9IDNAzZrM0Es4dIR0mMK5QGX9xUsQJzv3RnnyxC9QsDt7NG
	HmwvXLSOR3EE83AwwF4nfpQ2MDl4Tb4JXXLewwjeqvDQxNuEi2j2k6chWpG0B1rimI6FEbMHo22
	br14NGTOHglOYtCxhSu3XpDWGX3cMbAG0NC6RbQmMxEOWcWyTnuD6KuUvi1TgeQvubmZS+DsnLE
	HtipITVHzEklFyZOB7W7zvdlAW005OodAg0=
X-Received: by 2002:a05:600c:48a5:b0:45f:28ed:6e1e with SMTP id 5b1f17b1804b1-467e8afde63mr763635e9.16.1758217228700;
        Thu, 18 Sep 2025 10:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOoCiSMZx3r6ahJEsPst7vmWcAL9LRHA1I1NtHk23nXFndZVGSronTsEuZNCUr5eL1KdExGQ==
X-Received: by 2002:a05:600c:48a5:b0:45f:28ed:6e1e with SMTP id 5b1f17b1804b1-467e8afde63mr763425e9.16.1758217228248;
        Thu, 18 Sep 2025 10:40:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613e93dd85sm103570545e9.22.2025.09.18.10.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:40:27 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:40:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918133938-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <aMwtd40q44q5uqwr@google.com>
 <20250918120658-mutt-send-email-mst@kernel.org>
 <aMw4wx5ENt-odhYS@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aMw4wx5ENt-odhYS@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M2G7mDlyDukqkd_ww1Dt_yYXgoHeJOHsH31V1Gvl91o_1758217229
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2025 at 09:52:19AM -0700, Sean Christopherson wrote:
> On Thu, Sep 18, 2025, Michael S. Tsirkin wrote:
> > On Thu, Sep 18, 2025 at 09:04:07AM -0700, Sean Christopherson wrote:
> > > On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> > > > On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > > > > So how about switching to this approach then?
> > > > > Instead of piling up fixes like we seem to do now ...
> > > 
> > > I don't have a strong preference for 6.17, beyond landing a fix of some kind.
> > > I think there are three options for 6.17, in order of "least like to break
> > > something":
> > > 
> > >  1. Sebastian's get_task_struct() fix
> > 
> > 
> > I am just a bit apprehensive that we don't create a situation
> > where we leak the task struct somehow, given the limited
> > testing time. Can you help me get convinced that risk is 0?
> 
> I doubt it, I share same similar concerns about lack of testing.  So I guess
> thinking about this again, #2 is probably safer since it'd only impact KVM?

I can't say I understand completely how we get that state though?
Why did the warning trigger if it's not a UAF?

> > >  2. This series, without the KILLED sanity check in __vhost_task_wake()
> > >  3. This series, with my fixup (with which syzbot was happy)

