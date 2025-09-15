Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496479EA
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950289; cv=none; b=HNJ6LA65NAG4HNw0pUyXBxdUN8Et4j9V7CQWdHSDZCRhwGD8svNaGpeVYWvdEXsbCUkTFrVkUP2TsJtVVoRERBbVxHXTmFfIcUJR9IdECtUjolmriv6TBJdHsoXxQRJ5LXjBoOY8IvwzqKlWc+0ne/z9DYAEzChArvruob62xno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950289; c=relaxed/simple;
	bh=rEvp9FHMMcl+tnWv6KGWVC/KMLIhdGJDy47CLEOkMgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sOg4OWMH5crSnS79nvpd/qJ/NPeYa2sUg/ZESMeDMC7bGgZJuwWKuWE5W7MAk4qNx/D4ZeUKrxav+eImwGitFrLyCMtGSfew2u73L8pyLf7gwXsnG5gGXM8r0MSSIOwOQk6NfB4yfgUrAUUNXyfZG3NkVEZeR4lx3YKsoEPqOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzeeKO1c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzeeKO1c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757950286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijKjVgsGKrsgKBfC3v4CL8dPf1ojG5PTyoe+k0iOTMY=;
	b=bzeeKO1cmLX3qmyMBf/R4E9Vi9Rr4eadF3hCg9Z92CqiYBpEfNcHUncaNnZjh3htKnCqZR
	EouvkzqgOQyNjMn0wc6yLOS3EHdYYV/d6QA7vNAPhPAOMo3tumgw4wY4QQ8y94T0FWnl5u
	LmK9jLGa4G9klaozBe+8Qt1Nan2jUes=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-O-M2wKqYPCeRKFDEDQwyLQ-1; Mon, 15 Sep 2025 11:31:23 -0400
X-MC-Unique: O-M2wKqYPCeRKFDEDQwyLQ-1
X-Mimecast-MFC-AGG-ID: O-M2wKqYPCeRKFDEDQwyLQ_1757950282
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-62ed423e188so3743863a12.1
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 08:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950282; x=1758555082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijKjVgsGKrsgKBfC3v4CL8dPf1ojG5PTyoe+k0iOTMY=;
        b=sy/oN9BmDzIcbkpJDS/IOq6kOhm+qlkd/ZYlapIK+VlUzHlUnEazaLS5GEZL7u7JO2
         02UM1eJMQouBug3ucTZJrma0kxo8KboucKdNJTMnH38jZEJBXNz6Rj1GJldMVQtUkrWk
         D8k5m0JUirermrX/mBQnup0nxy1QInE+FK8A+gju2Bdca/77yWn7X8uU5B9OOpGW/DQh
         23/lalq9Yr8rM7T4aqIQgLXVz4RCgeMwVAp54lXM+B8xlJlVNUYOgZQXnKX5afcGPtzm
         fHnM3ZkXSuORAeo8qTl8Ib6npC64pwZGFOPtoMQe/rf1oRl101IqBR4RV2VIfuDvxJL7
         XN/w==
X-Forwarded-Encrypted: i=1; AJvYcCXCfEOsc31FIAUxIltbgbaaOU7YUAe0Osbv7RQ9xtKxq61iOPFTgR9Vj3Yv7YcUHKF3MHZjiqwwoMPoZnBceg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1Up1QJBP5eTD8fIaT5f1vooXTX8SPDdoNZ7umCLFNc1DgCMQv
	8Raye9hUIex0uGnahbfbZ2RrPkEH7UIdBFQrQDrOq1awu4X+lHLmNoR+OANE3RCZPrd+xt6Tfcn
	tUhjFjq8XTTfoXMPgOBwlptuTr9qucQr+lJHYhd/4QuQjb39d/1k1Ei52XXlrGMT/gire
X-Gm-Gg: ASbGncvo1FS+dEkPy3dfc0CihSvp8Wo54H76D/xElZ//5eAPu1XbbFx9jrm5Hkwu7JC
	cNgFqIYhHocmguNtAz6pxA+yTaMlGuNcB1BQgMwIHhOR0hJr0hJCz/65A2opH+0Gho7b8D78noU
	lR+Retat6r6cdzBp7bxD6rb7fkUI6gsvbPpn359iCBFbFkD7Sxl09/5t1X5dRyiuRpqQEfJiU+d
	cCOpEAPVAJ10XWCDcnP8cn7if6xdbJ7zDkWY6FJ7rQ/uC92TJ37u+4Nk24U5gLqEu7Boi7c/xph
	pDrfi1vNxyHPfp1Gk//5LLEd8Bxb
X-Received: by 2002:a17:907:7f90:b0:b07:885f:a54e with SMTP id a640c23a62f3a-b07c358281dmr1162944466b.23.1757950282123;
        Mon, 15 Sep 2025 08:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRXSeJUXREAtUBlKhyhYdRLPYRHXV5ewdR0Hl6LPR/OuzMIBY6cRHFcOXc1VipbuyucfuzHA==
X-Received: by 2002:a17:907:7f90:b0:b07:885f:a54e with SMTP id a640c23a62f3a-b07c358281dmr1162941266b.23.1757950281678;
        Mon, 15 Sep 2025 08:31:21 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31292aasm973924166b.44.2025.09.15.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:31:21 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:31:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] Revert "virtio_console: fix order of fields cols and
 rows"
Message-ID: <20250915113004-mutt-send-email-mst@kernel.org>
References: <601edd0a61e9a31d3d4f525a7c0648dbb4baa603.1757667309.git.mst@redhat.com>
 <6da404bc53aeb60f16cdfd1cc0bc70ee68a2ce0a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6da404bc53aeb60f16cdfd1cc0bc70ee68a2ce0a.camel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vXBs0x4S_1K8GJyMjLf0iKB_JD0quY1ACQ2zbNDQ9XI_1757950282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2025 at 04:06:37PM +0200, Filip Hejsek wrote:
> On Fri, 2025-09-12 at 04:56 -0400, Michael S. Tsirkin wrote:
> > when a previous version of this
> > patch series was being discussed here on this mailing list in 2020, it
> > was decided that QEMU should match the Linux implementation, and ideally,
> > the virtio spec should be changed.
> 
> This wording has been copied verbatim from a cover letter I posted to
> qemu-devel and doesn't make much sense for a Linux commit message.

Will change to "to the qemu-devel mailing list". Thanks for pointing
this out!

