Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE757873
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836078; cv=none; b=cHGAVv2Vo7IsvDhjnKBWlVse5yZbP/s0tyzhBZZ4z9dIE0Pd+5y9LpstX1IhFevG+oi/W4dGkPt2f5ypbdzkYqqdxfnE56zOzyLUHdEBB/fBjuS4XCMQgoibUAMYs6qzmVI4oQRE+37HzIhGBaBAFU4R9zICxPItlf5KfN9xFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836078; c=relaxed/simple;
	bh=G4LX9kvo4BgwHGeUq7JLs9/XHpEGSlotttquVOhu24o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1VmWPORBDKPa26kJF+ECRWiIYX4puDCDzxDn5SfwyL32ec8ppogOKLZIRONSlKX5WPQySoM89J8Fn7AXbyYe1s/a06DBD54TE2jIcVMPnn7MIrxoS6ZWLYL/S8tmBXBY2m0YWJvtAUGSLMGSd+fYSMn82IS2/6x9112z/y4dxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=js+XN5kI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="js+XN5kI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 127EC401EB
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 14:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ERL290K-p98
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 14:54:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 37FFB401D3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37FFB401D3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=js+XN5kI
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 37FFB401D3
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 14:54:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3ADC0CE1C9D;
	Tue, 13 Feb 2024 14:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05104C43399;
	Tue, 13 Feb 2024 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707836070;
	bh=G4LX9kvo4BgwHGeUq7JLs9/XHpEGSlotttquVOhu24o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=js+XN5kIZ2oj49KFq7EeQPD3BbeGrnnYa+LVtQvb+QaepYq6jIdyLRR7/tlQIf3W2
	 1Ij4Nqv8Ks33RuRMDmxroWfMDoOv1XgKZvCRhiDx3DeRtr6+djHMeQfUT69sVtE3nM
	 9VNTEtTUQjJIi1kgpqzOHU1uvkIOwDX/lr2NhCM8=
Date: Tue, 13 Feb 2024 15:54:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: stable@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Prathu Baronia <prathubaronia2011@gmail.com>
Subject: Re: [PATCH v6.1.y-v4.19.y] vhost: use kzalloc() instead of kmalloc()
 followed by memset()
Message-ID: <2024021348-always-splendid-c1f8@gregkh>
References: <1707110377-1483-1-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707110377-1483-1-git-send-email-ajay.kaher@broadcom.com>

On Mon, Feb 05, 2024 at 10:49:37AM +0530, Ajay Kaher wrote:
> From: Prathu Baronia <prathubaronia2011@gmail.com>
> 
> From: Prathu Baronia <prathubaronia2011@gmail.com>
> 
> commit 4d8df0f5f79f747d75a7d356d9b9ea40a4e4c8a9 upstream
> 
> Use kzalloc() to allocate new zeroed out msg node instead of
> memsetting a node allocated with kmalloc().
> 
> Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
> Message-Id: <20230522085019.42914-1-prathubaronia2011@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> [Ajay: This is a security fix as per CVE-2024-0340]

And this is why I am so grumpy about Red Hat and CVEs, they know how to
let us know about stuff like this, but no.  Hopefully, someday soon,
they will soon not be allowed to do this anymore.

{sigh}

Now queued up, thanks.

greg k-h
