Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35D3D8104
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780913; cv=none; b=pc+HH+zToPu5t9/lsXh4xyMal26ygOWsXN8OsZSiDqUiH2wwpQYaIeSqIXTd5oRXUddupIXi/fS0NTjEjgwFmCMV0aq8iKtK68GDzxsmKtLYyuvUWJO85RofBO2kV38oGc3ot6MZY2d9huquW8vFYBauCetJTd3yjYnNzys7Moc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780913; c=relaxed/simple;
	bh=XiLcP/LPrCdCh3xpZQsGzM+Q8XAFL4cckbFaJxwRI1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=W3px1g9/V8dCKeJQx8sRmkOqN+r53yuk01TGnckr8aMtBUgdPM+LjNsmprDpD1vWfy5AjFijecT9FobPYGga7tUeOMMtVWu3PkwWTPy8GAOUX6kc+we06hbgwQWYryi6mqgKgbGzhMwaiW7U+nGc/R8tnkN6H6WzP8+o0WWpP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGQVek5J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGQVek5J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776780910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sBspbL/u+4h/YiAyL1HV/VPAyarYaOL540HM7IEPE4s=;
	b=BGQVek5JdQ8sPAcCIQyS9bw6gdjW/19DYiMgSmb5BeRmXxZGhG8FUhQpbNmu/e6MBGmeF9
	Cd95Hhe9FNaFhyN53SH423yw/ZFFP63TU9xIMTi4IQRxHW6B++yyMFQADMcmWOb35Muxn+
	9GRU2U+nnn+EbmqC3k883haR8R3fXWQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Y3MEqpq-OHWJPIC3pZcJJw-1; Tue, 21 Apr 2026 10:15:09 -0400
X-MC-Unique: Y3MEqpq-OHWJPIC3pZcJJw-1
X-Mimecast-MFC-AGG-ID: Y3MEqpq-OHWJPIC3pZcJJw_1776780908
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a55ecc249so5353665e9.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 07:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776780908; x=1777385708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBspbL/u+4h/YiAyL1HV/VPAyarYaOL540HM7IEPE4s=;
        b=L4qszbnI7RkO3qJR0TQaTDT1hsC2cuDV0PLKzGz2oR5TrIpUj8Wo4Q1GSGUTziz3SH
         L8ofSomcutdo54ze4jroI2QUHt52LDc49/M214CaXVrjJR2IJqXKBEMeZxP6tI5FLNm/
         q8+cd2ARM8qxiMwH32+2cR+/su3GuC9dDyxL/m3d4fhXL2txnG8cvqqT/MUZ7gj8oJks
         ozdoKLQIgw5d35tZ6IBjjy3Zn4rtz83m089AufV96fXyAre98LdCX9cLOHfEjA0w+wjx
         vC0Hsajfob4rqlICPabo7IBVwTUDBPPCW3JmdI7VEDzFpWhmRVkaZx3II7f4BYv968bY
         6PBw==
X-Forwarded-Encrypted: i=1; AFNElJ8ZK2/DXD1pJwN4Mtaosi54dae9c/q0XT1+mZsLsj16wylO/V03BchhFuSiG6lD2F53kmvYXNDQFicN0eVviQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqE0+8s094UDNp/1EtE1dQ37ynVQyggIGjegMN+ChAmTH7DMfj
	qYJ7b2fJleH7MSpQ23eAm62/TNiWzEVLByEsyzPwFEKI4lgRs5AVmwHlr+G7+4j+3Pw9HJCts3J
	TA61/Irca/bVmQKZuJvahpqNLHMiJFgKJaM8T80jGM/4gDziRnB/g/GVoOm60nsxhLMuY
X-Gm-Gg: AeBDieukHzUWRIEOoJt2jp05abjtwhaWXnhxroDtPSKTfHrlPRVDCO3wZiqcBVuFTa+
	EbaLcYprB7ce9fPXraiZfMOXNfxLD6tTExSF0L4Yn8GLNWZKBXfDofNmWMtO8dgrCvCLJBc2Ijc
	ChjIrWjzddJRh6WMmfXWNtqbQXRtbyqp4fIMx3KiOMjlGm1dQDrwofepkpOyUnSzmK4t653kaxf
	mzHhmZEGMa6Md4si5M9WRcxo3jaPndsl9vWrzfudROJMnYKTvuGNmEJUPFIbGXjh8jigaweT3nL
	RsUbESZJcwKd6tB7NcnP8Fe2i4ReEpGmmq4JBkp67TwoxBp3O+oVh3hu+ldXVkOXTIe2F1VxCsL
	+0hnI9kElVZNfOrnAsgigTawuyqYhh0nop0OaBZjYVXfzYLwKgKFYBw==
X-Received: by 2002:a05:600c:3b11:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-48a525be2f8mr82580165e9.4.1776780908082;
        Tue, 21 Apr 2026 07:15:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3b11:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-48a525be2f8mr82579225e9.4.1776780907341;
        Tue, 21 Apr 2026 07:15:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb796ea2sm166370405e9.7.2026.04.21.07.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:15:06 -0700 (PDT)
Date: Tue, 21 Apr 2026 10:15:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH RFC v2 00/18] mm/virtio: skip redundant zeroing of
 host-zeroed reported pages
Message-ID: <20260421101409-mutt-send-email-mst@kernel.org>
References: <cover.1776689093.git.mst@redhat.com>
 <c199e47d-b2fd-42f3-9e50-c47c848dc72f@kernel.org>
 <20260420192037-mutt-send-email-mst@kernel.org>
 <aebjG-qMLr0joG61@gourry-fedora-PF4VCD3F>
 <0bb2d565-4b3e-4b0b-8e81-57898d8a2a21@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0bb2d565-4b3e-4b0b-8e81-57898d8a2a21@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vov7Ym2Dn5mrAbTk5dWsf6I5mJ-zGM9ab1ZdUwdifPE_1776780908
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2026 at 12:04:49PM +0200, David Hildenbrand (Arm) wrote:
> On 4/21/26 04:38, Gregory Price wrote:
> > On Mon, Apr 20, 2026 at 07:33:38PM -0400, Michael S. Tsirkin wrote:
> >> On Mon, Apr 20, 2026 at 08:20:57PM +0200, David Hildenbrand (Arm) wrote:
> >>
> >>>
> >>> Which would *already* be the case of you use folio_alloc(GFP_ZERO)
> >>> instead of magical vma_alloc_folio() + folio_zero_user().
> >>>
> >>> I don't really see how vma_alloc_folio_hints() -- that also consumes the
> >>> address -- is any better in that regard?
> >>
> >> By itself, it is not. But the issue is propagating the address from
> >> there all over mm. If we miss even one place - we get a subtle cache
> >> corruption on non x86.
> >>
> > 
> > Why does it need to propogate?
> > 
> > Can we leave folio_zero_user() callers the same, but add a PG_zeroed
> > check in folio_zero_user() that skips the zeroing (but not the cache
> > flush) and clear the PG_zeroed bit?
> 
> folio_zero_user() is just an abomination, really.

We can't completely replace it with GFP_ZERO though e.g. because hugetlbfs
has its own pool and needs to zero that.

> -- 
> Cheers,
> 
> David

