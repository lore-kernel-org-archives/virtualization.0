Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4C53B613
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918569; cv=none; b=sR3ZezsZjD/B/S3N5CAqgNB21NoG1W/d/l9QDOkdFYuAQgk1qinDUh8Ifihzbs5PsiJfvqE6T5l5m+kSua/comOJEvZprHk7d3Z+OCMppFhOzk0NiiSv3Uv9g92EV6ZSdLHnK1+TeTE9mZ3s07QqWKO96PZr/cQC7CBubxlRTRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918569; c=relaxed/simple;
	bh=KnY7puTEBrlSoKgf5txDwkeSvVbTfaBxMhDuJBqd4KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S94X57ljb9MATLrB2Clui97a6HR67F3uwhHliVzGPcMjz68/ZmbwoWIhxdd2xLxK0zrecg/36XTn0c02oX4fNRH6Gq81RqODocqKQAFZHWYDR5V3HZmYHNzw/AW6vdb6bwRUwJPifNKhKu0hM1waHQ9wqUaGm+VBZB0pH2H/AbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dt9JD4IW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dt9JD4IW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791918566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N5zgZEyxVzojLlUpj6Xv5ojPWw9NEstp7+yq+nb41Is=;
	b=dt9JD4IWLIDc7a9+DIQFtuE+2v8k16JhvQyeNXsFaXIGvAPQUkeQF08XjO6UlNEcKY7osM
	kEn9s5pXX302pi39ruXgS8mdBKVzXbXjmO2pd7jrXajVdixwig7vqROtS2ctcP4WqKT2AC
	lT1l5eNkW90F9NfnkT31wJLEDXbWJMk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-Nk0ZBTR6OoWWEr9xIRiitA-1; Tue,
 13 Oct 2026 19:09:22 +0000
X-MC-Unique: Nk0ZBTR6OoWWEr9xIRiitA-1
X-Mimecast-MFC-AGG-ID: Nk0ZBTR6OoWWEr9xIRiitA_1791918561
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF64B182FA5A;
	Tue, 13 Oct 2026 19:09:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F31A5769;
	Tue, 13 Oct 2026 19:09:19 +0000 (UTC)
Date: Tue, 13 Oct 2026 15:09:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: add Bobby Eshleman as vsock reviewer
Message-ID: <20261013190919.GB1301500@shajnocz.csb>
References: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261012-add-maintainers-v1-1-ef0488f460db@meta.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: lVt3szukB-cYBOX4YufcyhMvYp_EC1g0MI2i6YVeV4s_1791918561
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 12, 2026 at 12:58:08PM -0700, Bobby Eshleman wrote:
> I've been reviewing vsock via lore+lei for a while now.
> 
> Finally adding myself as a formal reviewer, since vsock will continue
> being stuck with me for the foreseeable future.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

