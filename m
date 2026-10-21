Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622835;
	b=M1o9V8W9so1bvxq07wgGxzCKR9+IcBqMq/R5GAW3T8/NMBFKrSw6YmPKWeF9yzNousZE
	 jbtbumhBuhLok3lHTuLTSK2H9HnZGi/EsIRaylq6ZrUEK2+HUQTN5YMUt5YfjgMAfYt96
	 +BQYkSW8dykQR6L6vNy2y5zwbaE6dxIZ94nH0LzCfcaCm6ln4GtKdFYuEHsmbU0Yl+IIi
	 cmq/1BPat30PYFxzvnkxgkWv2+C0o+CwC28IxbLB4unIoWYYA9sqC+da2Ebe3UbkbJMB8
	 AGy5PyhSK559DfpQitbeAvuLMIMJJAFywft97EEMVfNNMZ89iDma+TlHVZ24JvGciyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622835;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=9YZUSY6tsOAA9JK8qKUqDFm9nR+q+1jZAAcOqNYqyxE=;
	b=o8RLiF7fm/zruzrckudmQ1H7PDeGy+cQfabkykg2RjtUEADoASROxqN7kpHAH9Ubxoto
	 /nL9cPpA2aqkRf6IVCrMBSNafQkmwt1I3SHHGgvsgBWdXsHoGUAD0JFBsB5Smrig7Urrp
	 tCJtXd4i1drjgPju0fV4H4JRhDxb3PgvjBI0ibQhYnnTJW02CmhXIV3lBTemeydwOaRMd
	 uxKEQU/WIz8iDOGnd0FIVtL8dlu307N+bYFCqJIXmG3n5CVTaTS6EJCBkTsRhF3Fe2lOn
	 tNzSloQjqlxr4Mkaj8q9x6OxQwzM3ijZ6iUwBQPhPOgt59m3QvdutSOeA1nNcaLcLUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=WSzgAI9b;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E465606A319
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 22:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E465606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=WSzgAI9b
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69LMgYvc2120816;
	Wed, 21 Oct 2026 15:46:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=9YZUSY6tsOA
	A9JK8qKUqDFm9nR+q+1jZAAcOqNYqyxE=; b=WSzgAI9bm95kBClJDwXq8oWDw9m
	d3AkDmQqbOtQ7IPNLD8j2ByvpQ/Ey6Kw8IchUUXZmGJy8gZ4up2gK91hD6yAgYzm
	rGRnpyA7qaUuLj96ThCkQOntRmskAkqt1HPRBvGvBoKvrpPUurtRCkmLzkHOEVAh
	zPFJcx7piE7j2COvY/CqyBVXGOgSUzJwlWkKcpekOBtHqbpGvUR/G6Gwo96a4bBE
	vTI2sQWqIX/zN6VeaC4aUARHqWIUGnHR98Y5phKk4xA4YM2z+TJpybVDEddigb1i
	iPxfENmJToVq4CKsHrxTpz8WAfIAfCf6EkP2OuqoEHD8cjCVcVXOngpK1sA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hdw570u5h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Oct 2026 15:46:59 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::30) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 21 Oct
 2026 22:46:58 +0000
Date: Wed, 21 Oct 2026 15:46:57 -0700
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Stefan
 Hajnoczi" <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowangio@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Shuah Khan
	<shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Donald Hunter
	<donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <sargun@sargun.me>,
        <jlinbox@meta.com>
Subject: Re: [PATCH net-next v4 0/7] vsock: assign the guest vsock device to
 a network namespace
Message-ID: <atlA4V3zz/4MBryS@devvm29614.prn0.facebook.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <atiKKS3piuBLEiSd@sgarzare-redhat>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atiKKS3piuBLEiSd@sgarzare-redhat>
X-Proofpoint-GUID: nWrOyA-SJSPgF7XuQWR4VsnDvf0Fl8wb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MCBTYWx0ZWRfX5Cbq+OsJHbdB
 0T5M+wE1r0rnip3M+11WDnOQCRV1QNOfYZJP/Sp5ThnJlxeoaUIla2oqerRejohEIAGgV+8mzrj
 ubqt9/klN9GDIoTDsgckbYpLgJDMpnre8PhDi0FCLD0+hWlXJYCBniMIWFMXZc5IwfbxcAbv0N5
 8k4c1hPUMHfyRA2oqJAbxgcp3WxQccxfr42PoV0TKnpfJm5QrUJI5IINpu/YdqpaI49By2gwRbh
 vLxInws8v6sZKzgZllnjLgtAqPRWhkU95aCY6IZy0AhwPEgBLSzMkqFAMF/blGmAtcMBTmcHds+
 XI3WXFWUGzwooKNAiTQsUb5SeOzJqAH/MMOxyyqHLZtYgBxCu0eD+dSnBrXCrRUSZCACIkaS1v9
 QboLEe1lh+qO6wWkofmONttCKTb5ocmOXpU3h2iUROM8GntXX1JqxUm0+n75nb9+JLX39BoQM5Y
 Y1J1Y/AId9iLQFySzjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MCBTYWx0ZWRfX8cEX+8H2dRJS
 xyBX1JFThT0Ed2kUq4Ck/+j+N+VTSXpzrhoxUXkj91Yw6Bpf7iszxhtNH8TGL8tLGnv84GU6mYQ
 M/27hhvrnBAtlqrh75YBB8CugBVgQcg=
X-Authority-Analysis: v=2.4 cv=J+Q/fwnS c=1 sm=1 tr=0 ts=6ad940e3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=-gvGxQiiqzhQZzCLQcIA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: nWrOyA-SJSPgF7XuQWR4VsnDvf0Fl8wb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01

On Wed, Oct 21, 2026 at 11:48:30AM +0200, Stefano Garzarella wrote:
> On Tue, Oct 20, 2026 at 06:15:03PM -0700, Bobby Eshleman wrote:
> > vsock network namespaces let a host put each VM in a namespace of its
> > own. A guest has no equivalent yet. It has a single G2H device that
> > cannot be assigned to a network namespace.
> > 
> > This series lets a guest move that device into a network namespace. A
> > new generic netlink family, "vsock", supports the command
> > VSOCK_CMD_DEV_NETNS_SET which assigns the device to the namespace the
> > request was sent from. The namespace's existing ns_mode then decides who
> > may use it: a "global" namespace shares the device with every other
> > global namespace, and a "local" namespace keeps the host connection to
> > itself. The device starts out in the initial namespace, so until the
> > command is issued nothing has moved and no mode has changed. There is no
> > explicit unassign as assigning the device back to the initial namespace
> > is equivalent.
> > 
> > The command requires CAP_NET_ADMIN in the initial user namespace, so
> > that an unprivileged user namespace cannot claim the device.
> > 
> > Connections that can no longer reach the device after a move are reset,
> > so that a namespace which has lost access cannot keep using a socket it
> > opened while it still had access. The assignment holds a reference on
> > the namespace, so deleting that namespace does not move the device; only
> > another assignment does.
> > 
> > Transports opt in through a new netns_assign_allow flag. Only
> > virtio-vsock sets it here, because it is the only guest transport
> > that I am able to test against.
> > 
> > Based off of Stefano's original series:
> > https://lore.kernel.org/all/20200116172428.311437-1-sgarzare@redhat.com/
> > 
> > Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> > Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v4:
> > - All Sashiko fixes (see individual patch change lists)
> > - Link to v3: https://lore.kernel.org/r/20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com
> > 
> 
> Sorry, yesterday I started to review v3, but didn't post comments :-(
> I'll send on this series.
> 
> Thanks,
> Stefano

Hey Stefano, no problem. Sashiko kept me pretty busy. Hopefully we
landed in a better position for your review.

Best,
Bobby
