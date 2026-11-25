Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625064;
	b=qvtdztjNDX2DBKHGjkp3eiOLNrocPN3Z8r/zfb45wRJ2zxfsGD6bGndBdkePvaFM5erH
	 ncq8hcqRYyAxEENdJi2OFBurMf73xztvw0BaXU0P+UEJwupKwulyeS6/A+19LNOk7T04u
	 aTpFic9hCWpaZq4ox2WGdhyFN0XdoT+SYfZ3rl9UC+C5rrUB9eAK7s5eZi58K19uTIlkh
	 2T9MCNwk5kfH4nBH+b+Zs7itRXwGg33O/n8NfQgLykJ+11lvt+B7Rp1xNmaKvqyJAQTVH
	 syMaLWYUizctza/n2AI92PDkeYx7Vei/CpDLW1F3R/1k+gjVljl+m3MWjvefBOdHvsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625064;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=5dDh/S56gQqajxudSNfr3HSZig4SbmwpglkYADtH01M=;
	b=cCiwcUXt2CN0kk9WgJ8tASoxkeCAGfWzQBdHOq15iSqxdGZBmMl6MOUnBVKfpD50I8Ac
	 bBXurQlKumfObpzeGcCYu6oAcCgF+QWiPITGFFi7HE4rkxivOqcWUDMXGhZ52whkCfD06
	 261czlYxvGVwqzIh5xxim8WGPjDIgW9PU938hHZOl4AahIyJ2jC6zQejcROAeSq7QmdaR
	 i8NPiUv39QzQiU1oD5TZy5W7Evnxb2jrVTjzsGMUsrsKHeXPJHv1puMukoFiYMQBBNtHH
	 dyeFQ8Br5MJy3ONPXYqdFBAvSYlgDlZ0AtBNj53xFbf+eZuPhoMpIyBjwV1MlSZfx0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y7oHnZdt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771ED606A33C
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 16:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 771ED606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y7oHnZdt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795625062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5dDh/S56gQqajxudSNfr3HSZig4SbmwpglkYADtH01M=;
	b=Y7oHnZdtM24DNPfPge1pcuJFlO7sdHCuB7fY11L+AYBTEEqIQ7j0sIJa9lrIJasdFnnrPd
	DI9ug2RjuWVKr1hkzU5VuuTG3sPxPPBOPCnkuYoHs6vhpm8vAVmT/tnlMlXPgzwxivdPuv
	sPERjwKZZa89gM4ZLbpHanVAUI+oiME=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-_eK7E2UuMoeSjRd7ir7OpA-1; Wed,
 25 Nov 2026 16:44:18 +0000
X-MC-Unique: _eK7E2UuMoeSjRd7ir7OpA-1
X-Mimecast-MFC-AGG-ID: _eK7E2UuMoeSjRd7ir7OpA_1795625052
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7D59195604E;
	Wed, 25 Nov 2026 16:44:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 558971800551;
	Wed, 25 Nov 2026 16:44:11 +0000 (UTC)
Date: Wed, 25 Nov 2026 11:44:10 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alberto Faria <afaria@redhat.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v3 1/2] virtio_blk: add fua write support
Message-ID: <20261125164410.GE10456@shajnocz.csb>
References: <20261125083947.263216-1-afaria@redhat.com>
 <20261125083947.263216-2-afaria@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261125083947.263216-2-afaria@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 2c7vYuaSiaeYVRaYPpjKxny19Cj515WHu3J69NP7314_1795625052
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 25, 2026 at 08:39:46AM +0000, Alberto Faria wrote:
> Add the new virtio-blk request FUA flag uapi definitions and
> corresponding virtio-blk support.
> 
> Signed-off-by: Alberto Faria <afaria@redhat.com>
> ---
>  drivers/block/virtio_blk.c      | 29 +++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h | 13 +++++++++++--
>  2 files changed, 38 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

