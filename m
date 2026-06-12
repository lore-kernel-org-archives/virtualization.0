Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547B3A9631
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260888; cv=none; b=E+Ns7p5wAXL1RuLLXFIWISc5ggq5MTHf6NZit9F3KmgY1Gqw5Y/KVUc5wdW5SUCJxEmV7+IctMA/1e0YWSj70Db9iSPbCWTV1PO0jt5A/MUPlIVe0WogQcJPlj/Rn3yZSPvNzRwir3KGFYf8D7Q4O7zSy2ianiwITx+/LtCpRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260888; c=relaxed/simple;
	bh=5rn91acBsm08u48pralh41ZJgakPaI+PEvZtOgQ92sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OFFZvOAS4JcRrfiQMO0AqEyVgJG8T+lfS5kAb1f7NhrZEh2igUGKM4uQChxL1LTSPaA6a09JY6AdATOy4UaD7PBMga/BHNp9X76yYWUzlwX2OaL5LrCjHveJUrTm31j7AU+tHK4IL8a2EnFl+NXH2i1gRB9GvLXEr5mTOQNMhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0IrGygV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0IrGygV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781260883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xu4LvRoaZhXPB8pYhXmsm0zVQACpffE7HNmCn1yjRzE=;
	b=O0IrGygVmYEqqi3sT3bTUvJwT2STsGxzvpGE899qWgTSRp8djuM3A3awAfYGptVP9/zsok
	CcycSYs8S5fNDYDAEaJhAxW3ZtMcZ+uGBVv9pTzFEiMUf6j/kgr1oyFJlwU3L5utgH1H1E
	5tIYOztgAa0vCPKQ/pRBnhpoX2zjJP8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-PlSRii3cPbiyZ3FnudDbqw-1; Fri, 12 Jun 2026 06:41:20 -0400
X-MC-Unique: PlSRii3cPbiyZ3FnudDbqw-1
X-Mimecast-MFC-AGG-ID: PlSRii3cPbiyZ3FnudDbqw_1781260879
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4601daf4c65so537206f8f.2
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 03:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781260879; x=1781865679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu4LvRoaZhXPB8pYhXmsm0zVQACpffE7HNmCn1yjRzE=;
        b=aVwYz2BMOKoPOlMrJ+r79PPIsqxp9S7kFDQDeFrtAopEcGGYhzSLboponqb6hj325P
         7W2Ezkx6Iafz7FjmrWTHv6oENshAtRrPPlbv+4TZ922NGQJPV/dci4YE49/dkdiLEipB
         mn+56vkQQYnbfTLs9o19YTI562X3l3PkwiNORi5LwgmsJmZ3W+i7ucIfB66TVnjoM49g
         BkFd+avnQ+AudShK9Uoc3XN6qaTe6rxaLgVBwZ+9YP+VVhQ/16pfSiJC+q42Awy9I5BX
         Kz9kmkmnVcGw3+Evu2G/ZrLTMfZxCEauxkK53OD713ym4WTiEW8nb0Y7F524vK88/dPy
         fzwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mVncV3FIGAz18pft60BwyyXZ1U0dyvsE3YQDgd+Ip5fvzygU4/DZ2OHDu17NPdET3H6NBrIbvLC5VHQ6DHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTurpe1iyjMRft77RncS3X1nw4vaOoE3moHcbfREBt3BzcfP+C
	qbhsruFEDfxeBuUP6llfyiUiAlHGCGm6fU2gmQ5Bvp9ai3sKJLMAC0FmqfzA0WkljkPd0W/FWc6
	wfceCL2fgLgx5KNPIp0zPpbwFR5tsVdew/masqgxVh0h57U/gjNmVoMW45DyhfZAvXJYm4G/Hmx
	/B
X-Gm-Gg: Acq92OHUwSC6emLQaFuCBPnyEIUW0G6GknDej2MRT+mueoAu87SIyX45vhTjZVRJZWx
	BG7IoQJGihsq+p0e/J5xpuCB2Dpgm9TrSW47yWodnhaWiDdSYRHMS3VUuYtzrwPBRdGY6SoM3Rd
	usIrM9wDfbCDV1+IfERFKlwAngVnwVviXdfVGhtTIekhJCf8SPKyxPnnsA2xJ4qx/DoyqrLyYgd
	XX4/Hr4COUWoyk1Kyu0if3+J2bsAteb3IxJvoLP4wvjDje+aJLcNroNHl9S6lpR+FyTIEKqsdBK
	+kjA7QSk1hTzLlOfqjdBr3y1TdaH9XROW8cg23qJ1kL1z/IvybaaoPCZsT3sg0VW2TDJ+T/UNET
	htCcNCkdjAKh0TPZzGnC/RjzOHThNyXkx8ND8pwh3RTpMYQWsgkQ5RC6o4v1CByONisqQM3g=
X-Received: by 2002:a05:600c:1511:b0:490:ce99:d2ee with SMTP id 5b1f17b1804b1-490ec4df7b5mr15956415e9.15.1781260879097;
        Fri, 12 Jun 2026 03:41:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1511:b0:490:ce99:d2ee with SMTP id 5b1f17b1804b1-490ec4df7b5mr15956155e9.15.1781260878658;
        Fri, 12 Jun 2026 03:41:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea83d8dasm72684005e9.11.2026.06.12.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 03:41:18 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:41:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com, 
	leonardi@redhat.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 1/4] vsock: introduce
 vsock_pending_to_accept() helper
Message-ID: <aiviO__2-a-1TZLC@sgarzare-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612045216.105796-2-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ab6wQP8Fhjr6hVChEeD2D-nd7FXvNOD4wW0t3vym2dM_1781260879
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 04:52:13AM +0000, Raf Dickson wrote:
>Add vsock_pending_to_accept() to move a socket directly from the
>pending list to the accept queue in a single operation, avoiding
>the sock_put/sock_hold dance and the sk_acceptq_removed()/
>sk_acceptq_added() pair that would otherwise be needed when
>calling vsock_remove_pending() followed by vsock_enqueue_accept().
>
>Use it in vmci_transport_recv_connecting_server() where a completed
>handshake transitions the socket from pending to accept queue.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> include/net/af_vsock.h         |  1 +
> net/vmw_vsock/af_vsock.c       | 10 ++++++++++
> net/vmw_vsock/vmci_transport.c |  3 +--
> 3 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

