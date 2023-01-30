Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BC5C54EAA
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 15:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F0FE81DCB;
	Mon, 30 Jan 2023 15:58:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F0FE81DCB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N1sVZPHz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-Yhy8-AwxSD; Mon, 30 Jan 2023 15:58:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4253A81D47;
	Mon, 30 Jan 2023 15:58:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4253A81D47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C9F1C0032;
	Mon, 30 Jan 2023 15:58:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEA72C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 15:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8946960FD5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 15:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8946960FD5
Authentication-Results: smtp3.osuosl.org;
 dkim=fail reason="signature verification failed" (1024-bit key)
 header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=N1sVZPHz
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k9xjYY6PJgyP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 15:58:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F382460FBF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F382460FBF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675094295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qLfIaYqKY5h8p0flnUU+ZUSKaufFe4Nci0Ya2wtNYRE=;
 b=N1sVZPHz5/rxX3ihnXitM3riYuqygnhBh+m67P5aQSpvnHPt7n/1lp+ZFZ6VpPQtZM1EBi
 aacS7R2DWEQsNoP8erF92AgCuEo/ZYQ8YjMFOtaLZky/a5jl0EAif5uEJl03NMrYzSkW9E
 P6mFa3B0vxKrrJD8tgtOViDHV/s50Z0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-LQbhBSgfPCWz-AZqI1IBMQ-1; Mon, 30 Jan 2023 10:58:12 -0500
X-MC-Unique: LQbhBSgfPCWz-AZqI1IBMQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64B4B3848C21;
 Mon, 30 Jan 2023 15:58:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29BD5492B05;
 Mon, 30 Jan 2023 15:58:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230130092157.1759539-21-hch@lst.de>
References: <20230130092157.1759539-21-hch@lst.de>
 <20230130092157.1759539-1-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 20/23] rxrpc: use bvec_set_page to initialize a bvec
MIME-Version: 1.0
Content-ID: <3499862.1675094288.1@warthog.procyon.org.uk>
Date: Mon, 30 Jan 2023 15:58:08 +0000
Message-ID: <3499863.1675094288@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Cc: linux-block@vger.kernel.org, linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-cifs@vger.kernel.org, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, dhowells@redhat.com,
 linux-fsdevel@vger.kernel.org, target-devel@vger.kernel.org,
 linux-mm@kvack.org, io-uring@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>, ceph-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, devel@lists.orangefs.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Christoph Hellwig <hch@lst.de> wrote:

> Use the bvec_set_page helper to initialize a bvec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Howells <dhowells@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
