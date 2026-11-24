Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552981;
	b=1sFhq38NZUbvu5XO4Kg8Y5cj8qn5ujwZd6SfJNYTA6YO+VdJE0m0ajQBgbBfYDQqNjGH
	 g5+eVOkF4d5BLbqqqyne46pst2SR/ty3vQlqc9eggBaSNLA82u9m2dEdzdpBnFKhh6ap+
	 yz6WNF+/XQOn4xS/yYibmgfloqPoUApqV3xm5fkAfAUZssLmbr9uVw2vxZI5gk2V1W1Xb
	 4EqW+L/IgAiMx2iuwrt0T47UB34fJxRJmyUOtBr/p4Hg+I/A973ryBirm4RQhDUXVUXqF
	 8sG4P9ns65Glbp3qUPOQYZsjkLFCMDR8qpM7Amn62SWx2F6m9EpV6sUpACq2ZBJdzyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552981;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version;
	bh=TJTOznuo4rg6YTs6ACzDs9qiFTx3YTUbrecDZyUODsE=;
	b=ZyMR8fROEimQoZAP/d1jDsRSLqE0aZripbw+QUrsB7O/oRJ5tzKvovDovpFZpfADR+K4
	 4bvNB0GJu0uE0vi+xzNX88lUViw9DnQbKB6oCyJClU/ISXGeq6xlCV2WQhcby7fF405Qi
	 sxU9VhqNmn3oXlI5dJPk1R3MBtyhctiXANWaDY/1I5PAHMIOHSSx09ETd8iBC5v/7HFSJ
	 fezwgA+TX2Hlff9VrQFR2MxlbJfFVMVdNFlVIcmTlrcD8YOL/KRN661u8OPM5Qwo0ThAc
	 Q5uISpaHXw7Qi1EfpMn4dAXlkdktVNmKughhMBoduv31YWOco0UfX8DGBC6X+smzpKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=OgcaelHf;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EA1606A321
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 20:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4EA1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=OgcaelHf
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOIXbWD3010600;
	Tue, 24 Nov 2026 12:42:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=TJTOznuo4rg
	6YTs6ACzDs9qiFTx3YTUbrecDZyUODsE=; b=OgcaelHf+2Q3T0Oz4javisDDG0o
	5FsMdExVO5edrrUsP91V5kMe6iu+7Ama3l4j+aIzkEVNyxYuoKmW8+MCl7edywVr
	msUB/W9lQ2crESsT6WNWBSQof7dSnQU1QEbDJS1Ew2VPHEQTSzLfVbMFbSVE4bTK
	KyURHQto6MHK6yDrL16bfI4cDlaMgqtT63bQ7Sk3XXsrWPo1qGq1uOjVgUdbIPgc
	rhnLAh3S3rpxCBUBK0oN+3oJN/NdSTZU9cwkRAKFxm9ptD5NKmP6gOhgtjGnpoX6
	sXLatfTsDRejsMt4ulCtYsODmhHSfal21m7Oq402DQuTkmWkY2Hz2DKL7TQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j5d78tqqf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 24 Nov 2026 12:42:49 -0800 (PST)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 24 Nov
 2026 20:42:08 +0000
Date: Tue, 24 Nov 2026 12:42:08 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Michal Luczaj <mhal@rbox.co>
CC: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        George Zhang <georgezhang@vmware.com>, Andy King
	<acking@vmware.com>,
        Dmitry Torokhov <dtor@vmware.com>, <virtualization@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH net v2] vsock: only undo SS_CONNECTING when connect()
 fails
Message-ID: <awX2oDI/Mbt+z6J2@devvm29614.prn0.facebook.com>
References: <20261117-vsock-connect-close-v2-1-db5388323770@meta.com>
 <ed28d36a-682e-4db5-abf4-1339734e7c57@rbox.co>
 <awTJ8EOl52W0ph1K@devvm29614.prn0.facebook.com>
 <ca274ecf-3525-4bf0-a525-0460b5ea2d28@rbox.co>
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
In-Reply-To: <ca274ecf-3525-4bf0-a525-0460b5ea2d28@rbox.co>
X-Authority-Analysis: v=2.4 cv=d/1gWhjE c=1 sm=1 tr=0 ts=6b05f6c9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=1VYWGLTBVueK_bN5QLMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: CqelremLUJm3iV44nSTsEqrzg9xD2qBP
X-Proofpoint-ORIG-GUID: CqelremLUJm3iV44nSTsEqrzg9xD2qBP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4MSBTYWx0ZWRfXwed8aIvcZn1p
 7GczAYkcYKauoDEenpRpfAY0QfJUa2TfnCv2OCsLEFyO4VWCAV96cZX6bfmwoDZiP+03M9wEPk9
 2QvOIBNLR+kp0MpZY0epLlxJ/he4ToQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4MSBTYWx0ZWRfX/b2rd6kxTpdS
 xIkkXuU+v/YiTQOsew996kiXGLU3kmMnE+W1rZELbglhSEko/GIAJzLPV8PygG32AFDMPu6ixz+
 eWE1KHrXS4wrruh+59VP/nE6wigm/Oyo/w8gWdRkfvRSRBfXJ2r/yuneWrifTUAsIf8Z+W3U9yJ
 lp1uaZB7LVIMsuv7aeu5Iv54z8dB3qbEFZ29LSLdk/TPx6SaJAoJTSDFeRrd5TaaTz0S5QPGFxM
 OZGVT+h+bo7omOaasAAYFOKJJSIaF5KsOWNANb1EvCHckzOyEdh1CcGEaBzBwwLS1KGw61J+7eX
 MPJbnbEbObo4zybd2F2O2aV4FoyOPHgPzfQG+EjfzRAQhH5zCHf0vgTNSOPooIQUjgokxoxs1m+
 jGKHmAdy6jKpun3a6aiD21qjaGgI71Q3A4/YHAm03Pf1qd+OZbAjC/dNVdhSX+mhjiuEoZxECVH
 LZN2OpXrJjwmLzPQ9/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01

On Tue, Nov 24, 2026 at 05:17:56PM +0100, Michal Luczaj wrote:
> On 11/24/26 00:19, Bobby Eshleman wrote:
> > On Sat, Nov 21, 2026 at 07:32:15PM +0100, Michal Luczaj wrote:

[...]

> > So the attempt never times out, and a late OP_RESPONSE connects a
> > socket the user already shut down, overwriting SS_DISCONNECTING with
> > SS_CONNECTED. I think that's a separate bug for a separate patch,
> > though.
> 
> Great, I'm all in favour of consolidation. So in the scenario above,
> invoking vsock_connect_close() on vsock_connect_timeout() (with sk_shutdown
> check dropped) would result in CLOSE/DISCONNECTING, and no more late
> virtio_transport_recv_connecting(), right?

Right, that late response will fall through and get an RST back.  I'm
not 100% sure yet about how to rework the sk_shutdown check yet
though. I mention TCP's approach to shutdowns in my reply to Paolo and
I'm thinking thats probably the right way to go about it, but not 100%
sure yet...

Do we agree that touching vsock_connect_timeout() should not happen in
this patch? Is there anything pending on this one from your perspective
Michal?

[...]

> One more detail: currently a sock that went through a failed connect() can
> still become a listener. A transport-bearing listener, which I don't think
> is good. So, except for the connect+shutdown case, this does not change
> with your patch, right?

Yeah I don't think this changes here.

Best,
Bobby
