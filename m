Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC741BA83;
	Tue, 28 Jul 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230805; cv=none; b=i7UwQvqZHRqxCK793efo8xabwi8aDbOrdOy1sXKTTK87nX1L9B5OjQgmS1VZ0yVTLjk1A8Lc/G5YyoV7OawGCdDKeaRD+KYeK3gRkZTpqc4kNJjQZK52RNShSMfx/BqdN1Z/mcs1o7ja6KGoOP1drIA9xlxAUs4uOyWswRrJzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230805; c=relaxed/simple;
	bh=9NKHr3vvCGb44QDAbOyTLgskQvRfq0OYGmCbHrjF9FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i69G+092HhU0zXWXk/sGdVS8oSC9+GLS2vVcrSltaZi0chmT4iZsGtPu4lMj8zw4B17cHZnfvBL4QkarwE/Sae57FXp4kVavA5iOzi0MpMipmEYedQLSAqFcYRLPxYrbuz2pTWpGG71zY3MMko5fVPYFuAAXz2GYFkPjJ/msdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=I3NJ9/az; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="I3NJ9/az"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785230602;
	bh=bJCDUt9i1r51/uxnvPVEkB3WwqM9tdcfgDT8AscAsPk=;
	h=From:To:Cc:Subject:Date;
	b=I3NJ9/azj4NeQJoeGQMX/kPWLDbGMevzO92Z8qFVKsYb0jkaUCvVy5MhaIa6J/s2S
	 SsVMY+Xcq96l3eXD4B2p7KIqdtbkwdBnPaksag+/bmaj13lZAIx9o/ZVBEDr7BSvG4
	 KW10M70k7XG+u6B58QoLjQS9Mf+/eizsxW26ojM0=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.117])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66S9NL4M004577
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 11:23:21 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        Brett Sheffield <brett@librecast.net>, kvm@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net 0/4] Revert "tun/tap & vhost-net: apply qdisc backpressure on full ptr_ring to reduce TX drops"
Date: Tue, 28 Jul 2026 11:22:36 +0200
Message-ID: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop when
a qdisc is present") did not show a relevant performance regression in my
testing, but on Brett Sheffield's librecast testbed it causes a
significant throughput drop in an IPv6 multicast testcase. The regression
can be pinpointed to multiple iperf3 TCP threads sending: for 8 threads
the throughput dropped from 13.5 Gbit/s to 9.13 Gbit/s.

Therefore this series reverts the qdisc backpressure work.

Making the backpressure opt-in via a new IFF_BACKPRESSURE flag was
proposed in [1], but a new IFF_* flag needs more review scrutiny than is
available at the moment, so a revert was requested instead. The opt-in
will be resubmitted for net-next later.

[1] Link: https://lore.kernel.org/netdev/20260709095511.168235-1-simon.schippers@tu-dortmund.de/

Reported-by: Brett Sheffield <brett@librecast.net>
Closes: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/

Simon Schippers (4):
  Revert "tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is
    present"
  Revert "ptr_ring: move free-space check into separate helper"
  Revert "vhost-net: wake queue of tun/tap after ptr_ring consume"
  Revert "tun/tap: add ptr_ring consume helper with netdev queue wakeup"

 drivers/net/tun.c        | 109 +++------------------------------------
 drivers/vhost/net.c      |  21 +++-----
 include/linux/if_tun.h   |   3 --
 include/linux/ptr_ring.h |  20 +------
 4 files changed, 14 insertions(+), 139 deletions(-)


base-commit: b14361aca6350ff7907b0e9903c7b94dc7d5d4a0
-- 
2.43.0

