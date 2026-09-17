Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B014ABBAD
	for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659609; cv=none; b=UoVdnlBGZNuWDNqUI9oZ/qit3pt/woMo1zUVsw8tMvMLWzFHfQ5kIYpJ6ku8l+5LHyuj2W/0hcOTqiPVNjdYbDJBEzAoHynWXvAujCKLFzPoXFyllCget3Mmrf2MmW+QILlxZ10S0G+ckWrnGYOk/m8KZIdosnvGitzqMMaEXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659609; c=relaxed/simple;
	bh=ZEPRZWQSbrRLK6spoQmF7XlsJWpr55fNU8xc6W79Ubc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TcmJq+Tp+p4YD/aAeDtATdrNqof28q2sTKk05FFmmtbZCnD+mkxTRCILOIvABNCNfk1OYW4QjPS2rrzy9RPJ4+gXExZpfxcbUu1NJ034V21y2IGPf7mTaqrBMhEeDH8c9ye18wj5qa/6TDiMfmh4VTNgvE/T4tYZiVcFoZzSVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1Z7TWC2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1Z7TWC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789659597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksHKsD+rPQygiKBYrLWLevL1zmQIyZm3/sEyFnk8qqU=;
	b=E1Z7TWC2wbaPU8BywJLek7nEPK/uL3+2kCsZ/xJolYQC/tDTJgHGO8Qv5st6I4drPtMv5Y
	I25bndemQogU9YPiICcl3FwqxknyQHSy4PefE9uz2j0JmDOcy85P7sk+FDfWz3EhRPM76f
	h6RDIcuVAldwypiufidLLj5tR54wb20=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-W7T9hV6COtys0gSX6NLsiw-1; Thu, 17 Sep 2026 11:39:56 -0400
X-MC-Unique: W7T9hV6COtys0gSX6NLsiw-1
X-Mimecast-MFC-AGG-ID: W7T9hV6COtys0gSX6NLsiw_1789659595
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e6862e924so7790155e9.0
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 08:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659595; x=1790264395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ksHKsD+rPQygiKBYrLWLevL1zmQIyZm3/sEyFnk8qqU=;
        b=dXahGOfMCC2mnPJSJ1nxJUMdtH7zA4++gqCLWKtaRNzl1bQ/WUjkcforSCP444hBLO
         8QNdHMU2FE96jYuCSQcJ51VIH5HQ3DMiNK005CXTOKfHzQog/3T4QDsaJw66Zn+9y9PT
         1LQXWvGNublS0dSM59nw2rY/wtdW3QdsfLH7Ew6CtISsaPZoQH0R5eoV531lD9DWdFrs
         Lv6cBpana2wMy2uNFWKLB5sQKyBQN8DwDBeyPi+wj+UjKtyRMTzKbLNXvINoVeMOyTfw
         t6fjEjlk/AmB+7bSg+28fJnVF4dQF3Mud1Hbk9w/3cTsInkRXBoKd3lRQjBpRUP98/YZ
         Wh5w==
X-Forwarded-Encrypted: i=1; AKwUvBxmz17wkZ2wAbKg3eeqUL6CHTpown92W3Vn5HaThDxRD9SCMxCUwfi3lO6aPQAsc1+Z1f/GqdfZdM9izJJg+A==@lists.linux.dev
X-Gm-Message-State: AFuF++n6zddPAMTdyaHfY0fZNsAhMGGurOOgPj1TqQVL47nV6+T5qSU7
	i4I8xouHZm8uarxa8UuQw7O8+4k+TrGgERhceW5P8edrEE9V/L6Cs0CYkHJ6QsglWLtG9HXQ22q
	3c7ChBnhKdnRuuDsw3X0cRDQv5rse1NPzy/wExd3YQABQgEcA/WQ9O9NJ/GaVdJbJS52X
X-Gm-Gg: AYBFou0/2ErSBRwFgJmtD2PXkyhvT/0pM2Qr8xvaGKMjdbtpmewa62DZ1xJ6uQPc0cI
	r2RI2KHamt+2+RuKsF4We4+wFXnS55q3MiiY033hsTP5PhQO6JPppe/P09OUPvm85Sf7EQ6kjsu
	ZhNlc1qhpUUFsGlvQvDxbQzxtZS0BuyfjLyfujwoRn8KvGKl2Dj8EZLSSx3YjPy60GHM1SBCBaj
	FB67fwxZan82G2pBqdFcO3BCk43hH2597SbrGnsebQLthuz+OfH3Vno18Dh7JH99/mM1ZJ8181M
	0DUuHbztezgy642lUHYFqipmfuqz0Gh2fRo9DnRVlMqFgAc9OkaDzhnbFv/iqufHCMUvVDmIMFT
	AXr09yU2rbz5mR2XbYWCld9Y=
X-Received: by 2002:a05:600c:4e86:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49eb72f3d08mr88668645e9.10.1789659595194;
        Thu, 17 Sep 2026 08:39:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4e86:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49eb72f3d08mr88668225e9.10.1789659594734;
        Thu, 17 Sep 2026 08:39:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf342a0sm16364931f8f.24.2026.09.17.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:39:53 -0700 (PDT)
Date: Thu, 17 Sep 2026 11:39:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	sgarzare@redhat.com, stefanha@redhat.com, dongli.zhang@oracle.com,
	maciej.szmigiero@oracle.com, bchaney@akamai.com,
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v6 0/5] vhost/vsock: add support for VHOST_RESET_OWNER
 and CPR migration
Message-ID: <20260917113941-mutt-send-email-mst@kernel.org>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
 <20260730194858-mutt-send-email-mst@kernel.org>
 <f8646e25-7e81-4f19-aecc-a040caac1103@virtuozzo.com>
 <ea805767-9e3f-455a-a4d6-828063aaf2f4@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ea805767-9e3f-455a-a4d6-828063aaf2f4@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bTgxFW-hq7bR2H91C6nBVDyio94hfgv7SrbMwM2r0YY_1789659595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2026 at 12:09:35PM +0300, Andrey Drobyshev wrote:
> On 7/31/26 11:31 AM, Andrey Drobyshev wrote:
> > On 7/31/26 2:49 AM, Michael S. Tsirkin wrote:
> >> On Fri, Jul 24, 2026 at 02:45:37PM +0300, Andrey Drobyshev wrote:
> >>> v5 -> v6:
> >>>
> >>>   * Patch 4:
> >>>     - make sync+flush conditional by adding a bool 'sync' param to the
> >>>       chain, as suggested by Michael:
> >>>         vhost_dev_reset_owner()
> >>>           vhost_dev_cleanup()
> >>>             vhost_workers_free()
> >>>
> >>>     - reword commit message and comment;
> >>>     - drop Fixes;
> >>>
> >>>   * Patch 5:
> >>>     - add 'sync' param to vhost_dev_reset_owner() call.
> >>>
> >>> v5: https://lore.kernel.org/virtualization/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com
> >>
> >> does not apply for me is this for net next?
> >> in that case
> >>
> >> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>
> > 
> > The series is based on tag v7.2-rc1.  However I think the reason it
> > doesn't apply is you already have v5 of this series queued in
> > mst/linux-next, commits ddb0918e36c4^..ad5b642c84d0, with your S-o-b.
> > 
> > So you might roll it back and take v6 instead (only commits 4 and 5
> > differ), or leave v5 in the tree, or I can send you v5->v6 difference
> > separately.  Whichever you prefer.
> 
> Friendly ping.
> 
> I noticed that these patches were queued in your linux-next tree, but
> got dropped afterwards and never made it to your last PR (used to be
> ddb0918e36c4^..ad5b642c84d0).  To be clear: the series targets your
> vhost tree, not net-next tree.  Since it applies cleanly on your current
> vhost branch - please let me know if it's ready or there's smth else
> that should be fixed.
> 
> Thanks,
> Andrey

I'll put this in next, thanks!

