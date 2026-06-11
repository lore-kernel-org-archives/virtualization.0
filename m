Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9976E3BA229
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168143; cv=none; b=ifzk2oFo3Bv+H6OQWY3ufLEtvv799VIuf58giSIohpx0FmJdMtviB9ZLXpdvKHnNtKbym9sLlS3UU3PCfAXbhkitq+2dFHXFsqS0G3u3abKi0T1GtikqiIb72PNi4gJkdeUSInBFJs640hnT4SwBwLRZES5oDDIvz8wXRAKtiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168143; c=relaxed/simple;
	bh=Tg4DS3sWauM/HROr0zbXdV0eQLMGagO8flVocf/2Wks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eyxcq2wXcd+1ZYw3IF0I1Hr8x8vsyE5WcsH6Ar+GhmR03KdVp5AIRaSU0lppbE+oc63UHoRerO6oUSuYqs4diiPba1W1pT57Qs4KbwdS/NfRhwj7llfmndyFzqjNRRAj4ByJ+F4DOlSyo7pBwwAZfzGFusZkNcs2am+0ERJM7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajUdOzU+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajUdOzU+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c3546924so51691535ad.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168142; x=1781772942; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg4DS3sWauM/HROr0zbXdV0eQLMGagO8flVocf/2Wks=;
        b=ajUdOzU+aJIt099LmVPFiwp30G7Tt7x0uq5mAAtXdceWGC4ePJfA/+Zx2e6NU8P8tC
         eYTynN8L/BZ6/O956mUbGvdC7cC3jW44K628dTeMjQoICPnbMzxFrP3XeLegQdL2Ii7B
         dgVgvZiJj04ViigNa4gAGYPtexRUoCSon9Jz9IBAIl3t12SpKhZghdt0QXkfRRCD8+aW
         sdB7tpq4JjXPrGHJbXB/I1uhBUhLZOOOEOPoLYsq6sZMGicV2bXu8TSE7LpIhLbl7UBU
         PNFDjXQGEW1wyynC+eqvsWVTN16JgDXwEG832lsrgDgmIdMReeEh9ioVltn1aSZg+25h
         Li6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168142; x=1781772942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tg4DS3sWauM/HROr0zbXdV0eQLMGagO8flVocf/2Wks=;
        b=EVKe5CokIGKAk3OkZ5T56N4gWzVb7hI0hzL/v2bOaKuqdvnKA1l6Ol8L1Sspm8gp3b
         xo5VqRF+uqM0Jg5NBDtdDwCIBTlqm9QvSusE3Pod0xgZRKGjRWGtFvV+CQpG1YbC0p4o
         hu/1ecUxqlNeWWahBCgDC8+kHVFZ6fATyBPn6HvX7dDazoY38mlQHydRYVr1PbvlkiIN
         mudE/ulxPk7wF8Clr/wxD/s/7g2a/FyOMVdWkhNSDk2lS8GrTQsQeoXFG7LumqSapF2W
         AquuSirVJjyYmiphm40pUbrNWQUtdwcrjASi2U/F3Tz2Euj/E5Ld9KC1Tcw3DHolAkr+
         IyvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+p27DEzG5h9+GoImbNnsoqQxuRDGHUgNN8V6OgVwDHGU4WPmGeQZqnNKu7H5FBaDVO0wwGnMQ5nKjUobNq1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxccQy6nw08SBvf2iijXL7O/xPKtGUYx1h78kWws6OBKzR3iCpF
	vN0HfleaxQAt70FrqD5jrg1eU8/61/pKM10oXAWWdstZtiYhHk+ligI=
X-Gm-Gg: Acq92OEnerkOS6aOwvj+v5bDEW/87+RT2z3808i+Sf4wwNyP42JmaurMVKeCFGppD6D
	5YfVN+shDiRzJBv02OhQXtm+pszVTwXcwG4sjymvRHNavlDDtHD09QwNR0ln3qmfh6H7Cxd5FoR
	BptRfFwrtWUeWzAehj+cQzd1ufhbasJ29iToztXEA3WVpR1zVr0Gcto9fCZKQSCWrEdlZ5u1ZuB
	gSPDaZTfhWDi5usanbJf8XZAn87s63bjXNoL9iQ5kXcXbeOeERoU/w4RjQrPMg2wovHvpkmSwFD
	YYBWK8PVaw7/jRqDFPj4j1+g210EL7p5K9DG3BzmgC53VoRfzMgdBs17LqE+YofoMu/tE6t/gso
	oAvnGIeCB4eHgiHkCwLIZ3nxxKlZCqOwrR8ciMTvUQCytj8BI5IprwXD6CcFy8lOG0jxq1c0AAZ
	F/+8ZLCrPpCh2zAZU1g9HumNqYoPLCRXQNBpzCmbZpCVEDD8mOEFBpqfAl3qS7ZZEmFaNYrEAZd
	5S/ug==
X-Received: by 2002:a17:903:f8e:b0:2be:fefc:d5b9 with SMTP id d9443c01a7336-2c2f04403b4mr24903925ad.5.1781168141982;
        Thu, 11 Jun 2026 01:55:41 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6dc92sm248412915ad.13.2026.06.11.01.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:55:40 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
Date: Thu, 11 Jun 2026 08:55:37 +0000
Message-ID: <20260611085537.622665-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aiptrtQIC5ivKjem@sgarzare-redhat>
References: <aiptrtQIC5ivKjem@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 10:27:42AM +0200, Stefano Garzarella wrote:
> Maybe adding a new function that moves a socket from the pending queue
> to the accept queue avoiding also sock_put/sock_hold dance and
> sk_acceptq_removed()/sk_acceptq_added().
>
> To be called in vmci_transport_recv_connecting_server().
>
> So can we move sk_acceptq_added() also in vsock_add_pending()?

I like the vsock_pending_to_accept() approach, it makes the vmci
path clean without the double-accounting issue. Will send a v3 series
with that as patch 1, followed by folding sk_acceptq_added() into
vsock_add_pending() and sk_acceptq_removed() into vsock_remove_pending()
as separate patches.

Any preference on the name xd? vsock_pending_to_accept() works for me.

Raf
