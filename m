Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907050;
	b=1MweU+wyCK+7vEjGhrRvyfrT1bcVoyNTK0g9nxnEkse/Ma5sTqxT1yUt/7Etu9BVjIzr
	 nQszp3qywS7gBC1eKlrwc9uGjhiTAS0R02JFwr8z0o3HiP+x2kczseqLeu9v+debaCzBl
	 afKqiCooAF2REAOyAeP+2k1SA9pg/y1i0GO3kygeNMiiwb5AnK95ekDTJ/ys3MEBUFGsI
	 Q7f5MwcZEPkD8P0Vsr2K7Eu3tr0z/zrrjysufuLp91OgqLQqaQLfttPM+3Zw7qAWJZJ4U
	 zqWf7ZLBk2Sw2EwUTV1ZOGMAzaywajIXoNal5bKs90/syUY/LcEiGMAag7HGDyZrsNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907050;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=SWWPSVLLVKvkpC4tnGOX971RJR6r0apghAA3uHz/fzA=;
	b=qzcgEaAKZf0PMe8x24MoQ0XwtcYLdcdksbGf6LeO3m17uUc3RHft4BB9r6+kJYlHEz8A
	 V6ICpQHxYbAWTWBmtj/Js//p8VfSjTFNgNh5OZaYOvN+ilpxCPbY1Lktvdno1OcjsVRnH
	 4yF6jCIhAnhCbcQ7S1/xDqoMeuyVrRK8K+ubwL8ys4sSV4SZwSIX4KA9/uxV/LFtTVYa5
	 j16OUXZIiVUfZYfURz3i1PlA8mANTz+OXcG9+ZcfXV4Rd0g1frr9iNhcnKshg41JQ2Yt+
	 clcQ960fr+nzoUTiDE9tQfWZL6IC63uU5i9vnqs5RppLQ62b6VnOuTnESR/TZt8RCbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=dClOlS5X;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6169606D529
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 19:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6169606D529
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=dClOlS5X
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5J5oDr576959;
	Thu, 5 Nov 2026 11:30:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=SWWPSVLLV
	KvkpC4tnGOX971RJR6r0apghAA3uHz/fzA=; b=dClOlS5XS2tUnWmDDIZNuvHGA
	jc5CbyX2nHcG0QpdrY1A1GGCf1tCulQil8vqLMtgkjn3N8oTYIF6IGZDPfN5YEw2
	UUZ9YO2Q8DsfRlfvinRXF3TEJE6ZHKtDuGR2beLaRkWIpM6ajGuxGEDnT76PcXXT
	r9ICg9do4q4FHr26d3Bodj2KX2ed3WsvsdR7eg1LM7gjxz7hQNBy2cYct3Ny6CX1
	KKw1BgaFAYGmYQwFU40l2fUJFXr/bi/PdVLBvhiTaSZbhPDMNM3Tf4Rwr9XJ+1so
	sn2le1lRCQKDNfFc1r1/MMEp31Rea9+o7rVJ0rASL5n7GnhHmpysDCwMuejSA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrbck8mxf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Nov 2026 11:30:46 -0800 (PST)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Thu, 5 Nov
 2026 19:30:45 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH RFC iproute2-next 0/2] ip: add "ip vsock" to move the guest
 vsock device to a netns
Date: Thu, 5 Nov 2026 11:30:34 -0800
Message-ID: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFvZ7GoC/x3MQQqDMBAF0KuEv3bAhFgh20IP0K100aajHQqJZ
 KII4t2L3b7F26FchBXB7Ci8ikpOCMY2BvHzTBOTvBEMXOsu1rYdrZrjl6aFtVJS8q/RRu597x2
 jMZgLj7L9wwH32/U0mUteKjtKvFU8juMHTqkwmXYAAAA=
X-Change-ID: 20261105-vsock-guest-ns-4bf1ce74742e
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>,
        Stephen Hemminger
	<stephen@networkplumber.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        <virtualization@lists.linux.dev>,
        Bobby Eshleman <bobbyeshleman@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX9AFgeEAuM27d
 KLLA14hTLQuIuaVg9LFSVjRvpvfml2lOQguk7lkxfgNExkSgb+nc0pHzDWN4mY3wX95m6ZlWcta
 cBzxKcn9c+F3yK2Mhfbcryfg9i6Y8R3gKK+vkMbPGV3RdEqMksbjP5koz3zX0322gwdsJ+/RU3r
 R3gHsNnDEjUd0CVCptoN3J9WMqhaQFc+IGtOb67rLc88SL8qeOHU5S/olvWu47XHDA2ux9u91Rf
 H2GgZvGdo9loZZTUVzm6RA0Z0zN+aoNNdix48Ht6zvbrXoVBrTMUrt32f+nyj0A4/4YYNycFx4V
 cBRmnPQBe9plCkzHAmyWyUFkiJkJZFtCWJw8lgfzThegDUZmt9aYhIXu74sA2QyDD1NBvgMJVQm
 S3LfRVhBPQh5K8Nd6nzX52iqEQCxIcGma6PQPVFs4sj1uRorGAUCAMp4QnIfHw7uWwIY9UQtp/b
 Cp3PgDVwWR3LcF2qJKQ==
X-Proofpoint-ORIG-GUID: MK8M69-W0cL1ieTmctf0U3ytc-1AYzUR
X-Authority-Analysis: v=2.4 cv=bp/Zl0ai c=1 sm=1 tr=0 ts=6aecd966 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=VEq9NWtHcDJz48dA:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=vV-DuPaObkBpmeysVfEA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: MK8M69-W0cL1ieTmctf0U3ytc-1AYzUR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NyBTYWx0ZWRfX8Ka24nF8Im/e
 A7ILubJi4Kqb70ty3n14YYFJXQKeUwXK7RaqohsGOcXeSsKsy+knRY128JzeMxzzCqv9Fi6YPs7
 o4WUIu0HLHVxStC7qCoS82NrzzHtRVs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01

This adds iproute2 support for the "vsock" generic netlink family from
the kernel series "vsock: assign the guest vsock device to a network
namespace":

  https://lore.kernel.org/all/20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com/

The guest's vsock device is not a netdev, so it cannot be moved with
"ip link set DEV netns". The kernel series adds VSOCK_CMD_DEV_NETNS_SET,
which assigns the device to the namespace the request was sent from, and
VSOCK_CMD_DEV_NETNS_GET, which reports where it is. This series exposes
both through a new "ip vsock" object:

  # ip netns add guest
  # ip vsock set netns guest
  # ip vsock show
  vsock netns guest
  # ip -n guest vsock show
  vsock

I considered using "ip link", but I opted away from that option to avoid
the scenario (however unlikely) of masking out / colliding with a netdev
with the name "vsock".

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (2):
      uapi: add vsock_netlink.h
      ip: add "ip vsock" to move the guest vsock device to a netns

 include/uapi/linux/vsock_netlink.h |  28 +++++
 ip/Makefile                        |   2 +-
 ip/ip.c                            |   3 +-
 ip/ip_common.h                     |   1 +
 ip/ipvsock.c                       | 205 +++++++++++++++++++++++++++++++++++++
 man/man8/ip-vsock.8                | 121 ++++++++++++++++++++++
 man/man8/ip.8                      |   7 +-
 7 files changed, 364 insertions(+), 3 deletions(-)
---
base-commit: 204a721033556114c81c47d00375f2d52e98e463
change-id: 20261105-vsock-guest-ns-4bf1ce74742e

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

