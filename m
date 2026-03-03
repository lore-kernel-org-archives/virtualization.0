Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22C2848BB
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522362; cv=none; b=AgT41YUC2/l1fLvKyy8rh0UtS1wnDT+t3blaXfijY9u91YzTzAb4TRkvc8Y6IFNSIMFRjLrfreCdbVOqUodgekKr/TOZWRopB8QzsGt4Cq3U4NR3ZvokRxKjqmVF6kBMiclXs/9PVjaG9wvCldDio4z8BvQCLAjM4YBsxsdFlPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522362; c=relaxed/simple;
	bh=Doad24DQs+44GbcO0UUBHSHOY52WSKB2PaJUheAOQlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HQONTMlnPjSlaLnv6GoMxivIUUyddqD1OJQBgKji1WH6Zd13tDJz9wnBlfGfUZgsvzx/pFY02hc0F16r9LZB2SQASOoczfJn7/mIT8+bnqyEbjgOZDZNLGU7wln+ZPj7ia8Vf775b2htWuYhPLCbB+5h4fiYw0Ws4SBbJsXZljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0y0JJdo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0y0JJdo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772522360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RxiMbhEuqFZk0pVPwSev6kKmkvJmnoI+zy4WDYfo0AQ=;
	b=N0y0JJdo3FPwrxx3bNG8hHNYC55Y6876rGHM4Iffdind40EvUOo97hw9B5w925UKFj9gll
	zc05LWC9P59h1y1a60Mix51kdmwYtfZcv+dGlu+hopYD5iy1X/Ye5QXUid7U+l9GmKrL02
	VE2BzHQgV/2nSfPZnzixqqN9du4ZRxM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-TMwaXEBCM22vC2Q8H4Y56Q-1; Tue, 03 Mar 2026 02:19:19 -0500
X-MC-Unique: TMwaXEBCM22vC2Q8H4Y56Q-1
X-Mimecast-MFC-AGG-ID: TMwaXEBCM22vC2Q8H4Y56Q_1772522358
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439aa1d898cso2374812f8f.2
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 23:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772522358; x=1773127158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxiMbhEuqFZk0pVPwSev6kKmkvJmnoI+zy4WDYfo0AQ=;
        b=ZgUa8TgdrobFacQ5n8BJbkc7VfG6XBzg3NlC6gB0Dd8sUdsbmXtjfJLLG+kxZTo47d
         /eK1rn6Sy1jNBBFLKRkesfoD0C5J7lEwU9npXvE9O1YoxMeu7dF1NwFkYebtCQrSEvjw
         VrqUh7caYPzSub4b/6aUFvRN0XfSujQDgGCO9/0HaRKQUjDpkmSJ2sOFqgXcErAUkcrr
         7Ewq7h7dJrpdczOcsqxutUyfMwcg+JTUZjxWzLoDnoUMyv9DnNKKt04N2LbVmJm2W1NJ
         tkeCbU+M3af1Ifutrj5RJnXAp9f5Nc9Z7DwuZnFBmY0qcBezl8lt4K0+Zl4mkrTyiG7Z
         xTQA==
X-Forwarded-Encrypted: i=1; AJvYcCXfS8B/J81zRudxb7PNXITalIm29W9/z++8k+SYYvPyU65ca51JDxceLqAc+og0lrt0wnLipB7XFa7EyNWUcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFw45MoSYjFQgVJFwEvSC/V92LigSbBiCGObUHZS3gNEJmCZWm
	d711UP7YC0m3xbZHhjHvOkzWCMxgWc9D4M/k3bmcQEFZiKtGO2HQAW4qL5a8ENwaRnu2oWzznCz
	ZUxW66FNLSELGDazyOJZ000Ryzl/DEm5nUUEzbwEbGTWo+eiPtFrGzOrg3kz38x5/iHAR
X-Gm-Gg: ATEYQzwJfkYDhic+aEp8cKjP5suxJ4/M1aNioaP4tcsy94MpyJ5EC9Tmo6FDoGuqsfM
	M9yjr+/YuhiyUy9Wa+kq+w5KKgSG1KcVTNphUd735HSK0As8eKJK/Kf39BX4nAFpkoUQYjIDWOq
	COlhf57y4gB7WAnqe8Oe0S/LuR+BOpgFq5FIsYp224UllBfwOlX84Dpc+vn0E1WIE0VEq3LdpPp
	gUesbxVFjoAFfmyStcnCx+W38NyTrOsJARRnxu0tji7PjoVXQJSp4scL2g5xh2z7RMbmgYULoWB
	ONSkbP1bbasEnyWB6tmTq9RF0MzTFFYYHFRiZGxms7BypsyPKP2ij9o1hzWHQ6TaLkCgWkqckG/
	b62YQyFBMibBefBm8s0cmLevWyQI2Cf8k/CrZxuzOhXnWSA==
X-Received: by 2002:a05:600c:46c4:b0:483:7783:537b with SMTP id 5b1f17b1804b1-483c9c0f34cmr256504635e9.24.1772522357668;
        Mon, 02 Mar 2026 23:19:17 -0800 (PST)
X-Received: by 2002:a05:600c:46c4:b0:483:7783:537b with SMTP id 5b1f17b1804b1-483c9c0f34cmr256504245e9.24.1772522357187;
        Mon, 02 Mar 2026 23:19:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485126563ddsm15274465e9.3.2026.03.02.23.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 23:19:16 -0800 (PST)
Date: Tue, 3 Mar 2026 02:19:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, nh-open-source@amazon.com
Subject: Re: [PATCH] vsock: Enable H2G override
Message-ID: <20260303021723-mutt-send-email-mst@kernel.org>
References: <20260302104138.77555-1-graf@amazon.com>
 <aaVrsXMmULivV4Se@sgarzare-redhat>
 <aaV80wWlpjEtYCQJ@sgarzare-redhat>
 <17d63837-6028-475a-90df-6966329a0fc2@amazon.com>
 <20260302145121-mutt-send-email-mst@kernel.org>
 <079fcb93-cd01-45db-9ff7-d6cafd8fb7d5@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <079fcb93-cd01-45db-9ff7-d6cafd8fb7d5@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5L2RM2goP0326k1UevikaB1PUCGTLxU2AxIb-Az9o_o_1772522358
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2026 at 07:51:32AM +0100, Alexander Graf wrote:
> 
> On 02.03.26 20:52, Michael S. Tsirkin wrote:
> > On Mon, Mar 02, 2026 at 04:48:33PM +0100, Alexander Graf wrote:
> > > On 02.03.26 13:06, Stefano Garzarella wrote:
> > > > CCing Bryan, Vishnu, and Broadcom list.
> > > > 
> > > > On Mon, Mar 02, 2026 at 12:47:05PM +0100, Stefano Garzarella wrote:
> > > > > Please target net-next tree for this new feature.
> > > > > 
> > > > > On Mon, Mar 02, 2026 at 10:41:38AM +0000, Alexander Graf wrote:
> > > > > > Vsock maintains a single CID number space which can be used to
> > > > > > communicate to the host (G2H) or to a child-VM (H2G). The current logic
> > > > > > trivially assumes that G2H is only relevant for CID <= 2 because these
> > > > > > target the hypervisor.  However, in environments like Nitro
> > > > > > Enclaves, an
> > > > > > instance that hosts vhost_vsock powered VMs may still want to
> > > > > > communicate
> > > > > > to Enclaves that are reachable at higher CIDs through virtio-vsock-pci.
> > > > > > 
> > > > > > That means that for CID > 2, we really want an overlay. By default, all
> > > > > > CIDs are owned by the hypervisor. But if vhost registers a CID,
> > > > > > it takes
> > > > > > precedence.  Implement that logic. Vhost already knows which CIDs it
> > > > > > supports anyway.
> > > > > > 
> > > > > > With this logic, I can run a Nitro Enclave as well as a nested VM with
> > > > > > vhost-vsock support in parallel, with the parent instance able to
> > > > > > communicate to both simultaneously.
> > > > > I honestly don't understand why VMADDR_FLAG_TO_HOST (added
> > > > > specifically for Nitro IIRC) isn't enough for this scenario and we
> > > > > have to add this change.  Can you elaborate a bit more about the
> > > > > relationship between this change and VMADDR_FLAG_TO_HOST we added?
> > > 
> > > The main problem I have with VMADDR_FLAG_TO_HOST for connect() is that it
> > > punts the complexity to the user. Instead of a single CID address space, you
> > > now effectively create 2 spaces: One for TO_HOST (needs a flag) and one for
> > > TO_GUEST (no flag). But every user space tool needs to learn about this
> > > flag. That may work for super special-case applications. But propagating
> > > that all the way into socat, iperf, etc etc? It's just creating friction.
> > > 
> > > IMHO the most natural experience is to have a single CID space, potentially
> > > manually segmented by launching VMs of one kind within a certain range.
> > > 
> > > At the end of the day, the host vs guest problem is super similar to a
> > > routing table.
> > If this is what's desired, some bits could be stolen from the CID
> > to specify the destination type. Would that address the issue?
> > Just a thought.
> 
> 
> If we had thought of this from the beginning, yes. But now that everyone
> thinks CID (guest) == CID (host), I believe this is no longer feasible.
> 
> 
> Alex


I don't really insist, but just to point out that if we wanted to, we
could map multiple CIDs to host. Anyway.


> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597

