Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3C495E5
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170922; cv=none; b=l+uP37foh/g/+MGocANQ292X11z91yAjMxj4F2T5g1m5Uh4lYBdWgbCpynGz6AX7/BsT6gUVl7iMGSEvtqZ4ldqL8jODNayadhDrVRpjKMi1yM2mF2IwBtjWwSlsG412Ait8lWwo83XaH8DkMiUUO46xx4eedpjzSsd0+I6pO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170922; c=relaxed/simple;
	bh=vob1+8i62fgnz/ZPtPuh8EZn1j5rr+AtcYWifEiZz/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DGK5Kz4ywaHF1eFaUOyJdlP5focEusq1qq7ei2qX6W9z2sFqju1xkisbpKVOIeUeKZ6jOAQ0vvdRjBjwFgp2Hm6FnRLiUJLWumBG2rgmV/1MVo38rsaAa0msVGuqOgYVf4zq5eU5vNZ5bDNlaUXfoDhPidjQSEsn+PhlW/SmizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=My5fQUCD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="My5fQUCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781170919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr0hD7XVU0wbZWKiqIjbBktqlOmfsvZ41wP4H3+JU7k=;
	b=My5fQUCDMZWBkrfU49C/mlInBPBhL1tET9AsbhlOOHVdU7Nb+Ah1CGHVXkmPLd9WdDsTma
	PEmPClUIEc6iY5kCPshCW2ivkO/1ZMIULapkgB7eBQblVARst3GqImRXHeBgeO52TdLCDy
	uA9Jq/Z/IBn6zZ951KAxO3eL02FSSB4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-tXSgngsUOV2oGQIl3ITqow-1; Thu, 11 Jun 2026 05:41:58 -0400
X-MC-Unique: tXSgngsUOV2oGQIl3ITqow-1
X-Mimecast-MFC-AGG-ID: tXSgngsUOV2oGQIl3ITqow_1781170918
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46011aa5000so3423118f8f.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170917; x=1781775717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dr0hD7XVU0wbZWKiqIjbBktqlOmfsvZ41wP4H3+JU7k=;
        b=MaJ7ff5ony3A3ynuk6csNhDiMesMyectE3A+E5J6e+yEtaZJGkg0oa28wXv+lBpMBy
         G6InIVdLukc9IxRpfB4PfaaWWBjsksXa4t9iAqdDdeBve8f9/Srzox2p3pZThN+MkUBR
         OC53Ba0Dvd48EXxi9gosYJbTpSTs+YuCJpRhReeJjOLufizy7ZvADyuJyuGSZzLusNMw
         VqtBxF1dUcEhia0tDON43XWCXva0UI5MYJIHDz0ms+LbQQoIjCrmDa70OHP5yGqxMbYe
         UbJ2dzk4+xqHSutykkUU2gHjJ1rhlWUIVBXQt1k/meCYQadfQcZdisjkYHyCPqzDJsDs
         T7IQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oQZzkbhSGH3Oiidr0m4tl/E+OtIkOm9n0W/kAIDM/lKmNHVY5GpXCgw6Ft0VW5QR0j3PK9A5ycoO0mipeDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyL6l1ubX3jPj3zYpimbIhR0hjXTfvOKxDKI4gL3dTpV3fGO+w5
	0D9pccpMxkUElb1CHwT3wy70XG7Y5nFTEZ1J+FVIUO3zeIWPJXKf0WIOXDCAGb+rTPUUXGYNBeh
	5rmSqyc/7A0DkldyUfXSp951a73E7xTn/wgfH7XBn2pOuRqyIymf/K0mO2JXLCVW9q/64
X-Gm-Gg: Acq92OFYH58YZg6hKnsUMntIDiex8BGd6aNG2yrs4qpIW9MLauzGqUU9oI02i6LpqJU
	ezBm8WuCQ9Wggvylo2A9uRmzLKC+p/F44Eox+X4UPhmRpkEozpIIbOW7YN/F5k5zZcem2LTIgkr
	w5TtY33SpBDv/cHgbayU20XM4UwrZwqMW2PdCpUJz+dH/SpoAoiU506pcSCcMJy/5VVyK3fzGUs
	AY0bVujn3tkMMbV4NB7N8KT9bFCSYcSkOktAz7qfDGlgOaY6Ou+eU3XbmWU6B/95gdCjsYZqnkM
	Wr3KSyK8w/nrFK99cix8tbITyjOuTgy06lvFDvvqD67uK+h8KV+aENANzxhBY9XT6tZq0bf7cw0
	9+VmJrXUQAfgLqFHTPVyyd+2m0g7SgO0+E8ew6yQJJCf4GcF1beMArDVqZF8manhI6ZL6NY98Na
	4yTwoT4A==
X-Received: by 2002:a5d:5f81:0:b0:460:51ef:f81f with SMTP id ffacd0b85a97d-4606758d308mr2841359f8f.6.1781170917531;
        Thu, 11 Jun 2026 02:41:57 -0700 (PDT)
X-Received: by 2002:a5d:5f81:0:b0:460:51ef:f81f with SMTP id ffacd0b85a97d-4606758d308mr2841315f8f.6.1781170917121;
        Thu, 11 Jun 2026 02:41:57 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm80878148f8f.33.2026.06.11.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:41:56 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:41:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aiqCQCdPHw7Ja3tM@sgarzare-redhat>
References: <aiptrtQIC5ivKjem@sgarzare-redhat>
 <20260611085537.622665-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260611085537.622665-1-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uh53eccXjVRIl26U5JQSyGVQSy66yckyr5g6IawsY_c_1781170918
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 11, 2026 at 08:55:37AM +0000, Raf Dickson wrote:
>On Thu, Jun 11, 2026 at 10:27:42AM +0200, Stefano Garzarella wrote:
>> Maybe adding a new function that moves a socket from the pending queue
>> to the accept queue avoiding also sock_put/sock_hold dance and
>> sk_acceptq_removed()/sk_acceptq_added().
>>
>> To be called in vmci_transport_recv_connecting_server().
>>
>> So can we move sk_acceptq_added() also in vsock_add_pending()?
>
>I like the vsock_pending_to_accept() approach, it makes the vmci
>path clean without the double-accounting issue. Will send a v3 series
>with that as patch 1, followed by folding sk_acceptq_added() into
>vsock_add_pending() and sk_acceptq_removed() into vsock_remove_pending()
>as separate patches.

Okay, but VMCI still need to call vsock_add_pending() and 
sk_acceptq_added() in vmci_transport_recv_listen(), no?

>
>Any preference on the name xd? vsock_pending_to_accept() works for me.

Also for me :-)

Stefano

