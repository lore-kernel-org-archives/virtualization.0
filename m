Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E4156C9
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0rVHaaj"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A853E60B32
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 10:45:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A853E60B32
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y0rVHaaj
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ichlVfeAY7gL
	for <virtualization@lists.linux-foundation.org>;
	Thu, 11 Jan 2024 10:45:14 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4BFC260B2E
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 10:45:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BFC260B2E
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 239DDB81B7D;
	Thu, 11 Jan 2024 10:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B788C433C7;
	Thu, 11 Jan 2024 10:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704969910;
	bh=otTxhAPvsRjqSlgmiFFIM6ilyM8UWcJKCMTo+H92XN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0rVHaajgApriNuaWA17WZi171hNoFM5LJcggluyOYRxi/n6Mk5oWxp2Y4rUT2RaW
	 MAIwYGBIfjcz4bqyOqGeblCTavgPjPW4ARnQoL8Ssx4XdJgcUrnBQt0V6P11asRKxZ
	 n9qCPIYLSo0orM8T2OJVZNv2HykFEpud7NwhxR0s=
Date: Thu, 11 Jan 2024 11:45:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: stable@vger.kernel.org, Wander Lairson Costa <wander@redhat.com>,
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	virtualization@lists.linux-foundation.org,
	spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10 1/1] drm/qxl: fix UAF on handle creation
Message-ID: <2024011100-marsupial-outshine-e7f5@gregkh>
References: <20240109110827.9458-1-pchelkin@ispras.ru>
 <20240109110827.9458-2-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109110827.9458-2-pchelkin@ispras.ru>

On Tue, Jan 09, 2024 at 02:08:25PM +0300, Fedor Pchelkin wrote:
> From: Wander Lairson Costa <wander@redhat.com>
> 
> commit c611589b4259ed63b9b77be6872b1ce07ec0ac16 upstream.

Now queued up, thanks.

greg k-h
