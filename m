Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC81DF975
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Apr 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628719; cv=none; b=hKP2kHc2Okc0mKDb2fvDjj53gjHLVw4IN58xuCnFYZSFNKQbU8vOq9Cm/Pwb6+JC4KtVjEhb66Czwu42C/d2UX2tLUWvzPZpgr/mGQQyxGawjOYUZWh5ppsbFjLZLCBqtvQvxrqEJfAZtlFYK/u5ljBgDsZubnohZMrZea3qcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628719; c=relaxed/simple;
	bh=TRKe2C2yWQUuu/9WP0Vtkv/UsPx1qc3XdDhBsmf2WZs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Wa5aoscKWgrAX24asCoWkAYPGZ46M8ouw6gNx9biIJR/VEJiykU0+40kaWI/tUG68embEeJWevvBr0nzwj68LWFoY0ptsnOt5Xwa1dnB07AwU8rgcoEKOJI4tSFAHGqOaUpuDtkqkTJOJZvT83/PCVr8tRudqHR00P5bovwoNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1FFE3405BD
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Apr 2025 21:18:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.591
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q7wLugJiGB4Z for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Apr 2025 21:18:36 +0000 (UTC)
X-Greylist: delayed 365 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 02 Apr 2025 21:18:35 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E50D240280
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=webked.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E50D240280
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=159.69.203.94; helo=webmail.webked.de; envelope-from=markus.fohrer@webked.de; receiver=<UNKNOWN> 
Received: from webmail.webked.de (webmail.webked.de [159.69.203.94])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E50D240280
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Apr 2025 21:18:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C65AF62B75;
	Wed,  2 Apr 2025 23:12:13 +0200 (CEST)
Message-ID: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
Subject: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
From: Markus Fohrer <markus.fohrer@webked.de>
To: virtualization@lists.linux-foundation.org
Cc: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
 edumazet@google.com,  netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Apr 2025 23:12:07 +0200
Organization: WEBKED IT Markus Fohrer
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

Hi,

I'm observing a significant performance regression in KVM guest VMs using v=
irtio-net with recent Linux kernels (6.8.1+ and 6.14).

When running on a host system equipped with a Broadcom NetXtreme-E (bnxt_en=
) NIC and AMD EPYC CPUs, the network throughput in the guest drops to 100=
=E2=80=93200 KB/s. The same guest configuration performs normally (~100 MB/=
s) when using kernel 6.8.0 or when the VM is moved to a host with Intel NIC=
s.

Test environment:
- Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
- Guest: Linux with virtio-net interface
- NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host level)
- CPU: AMD EPYC
- Storage: virtio-scsi
- VM network: virtio-net, virtio-scsi (no CPU or IO bottlenecks)
- Traffic test: iperf3, scp, wget consistently slow in guest

This issue is not present:
- On 6.8.0=20
- On hosts with Intel NICs (same VM config)

I have bisected the issue to the following upstream commit:

  49d14b54a527 ("virtio-net: Suppress tx timeout warning for small tx")
  https://git.kernel.org/linus/49d14b54a527

Reverting this commit restores normal network performance in affected guest=
 VMs.

I=E2=80=99m happy to provide more data or assist with testing a potential f=
ix.

Thanks,
Markus Fohrer

