Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607507;
	b=VSZv707O7nDogYqltFHf8OgdqFeaXsyBVt94VhMS3HIqNbTE4nKKt9fSAvgbOuMvSwLd
	 P1cNIpGuqOR4BuGp4POE+2UMhEjBOJKRNsrBmDx+I2wEfT94D1rvvmB9MCcSUPG+j1zye
	 Sw39xliUGFjRzotxTDcwGzqyvYGnLqmeNbcGVvQOGH1zJn06sZk+C8280RU6gMxZ5tHSu
	 /pT9n80bkclocfb00YWhYlCNgks6AZPupa1HJCESgGxqi0JHeSl9TzIVk2BYSPtxs3qwz
	 xE+VxN5+7k/PVA4lP1uRvWmko+iFk9BFdMZHuDWCJ/143OEzjnxi+vPgzJ8tiFo4n7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607507;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=LQ+/kIXsnEf+/yMaf4JHdayssXt0IvTFx291yCAqN0I=;
	b=uRBnJFaA+zYClJQKU6hbjflpY5rFlg6S9joBlwWCYmC6mwuE2VHfsFyYkEK/KI6bXgYW
	 d+P42mMbWvjYRdnwcR5GOjRHRTW2Lbr9WKciknneRB/U2wO5tIJE7Je02ver/Lw3wfMF1
	 I5gyWPeK0ywi+B2V09FSkqdH+Jkd4qb+V323x5nlCQFLT36tdFO5RIqmru+ADtH8sRLqt
	 uIHTrjmTo1ch7SEPuo2pU2TBkoDS2P9Me65i1I5SdNf0t2AHtu4ErIcBkkH3YYBfKTfdu
	 FI6EPM2esyE/2/FHxYmosJ6z/HpsE7c/Q4o14k5nLfm+tBtjaSqRcanbLsdKcbdbOrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ekBqO5Sg;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC9606A327
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 22:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3AC9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ekBqO5Sg
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADLf47i3995318;
	Fri, 13 Nov 2026 14:05:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=LQ+/kIXsnEf
	+/yMaf4JHdayssXt0IvTFx291yCAqN0I=; b=ekBqO5SggzMgzbKwGyt6fptv864
	N4LXbRyW15gmC7gUWvXJowDX4G3SshEFUGxrLcJ88YQxmzIlA6I6/ee9yr6wJ5J8
	HjTl64VZy87KiwNYZzrp4TPSrpNMUmPiYxYZg7guX22S+flq6mVd4ITGOfFQ80S9
	dIBDXFP24JhurZG7iU8rFXoDspUxQmJSiryDhvvOHMV99QyCp+hiWmm0O8Dcydf8
	1QKueefN92sy0MNB7IIKliZIQsV+AP0a3yCrr8OgCO2ndjiV5PMwwvTCQ+nShgxO
	pkYru+XaO9VfsqOJGoiF0zSnICLZ1JQqTVBA5mfCz4NBCsujjhSglGl1ocA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwkk9gbsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 14:05:01 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 22:05:00 +0000
Date: Fri, 13 Nov 2026 14:04:59 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Sergio Lopez <slp@redhat.com>
CC: Bryan Tan <bryan-bt.tan@broadcom.com>,
        Vishnu Dasa
	<vishnu.dasa@broadcom.com>,
        Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>,
        Stefano Garzarella
	<sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "Michael S. Tsirkin"
	<mst@redhat.com>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] vsock/vmci: reject datagram binds in local network
 namespaces
Message-ID: <aveJi+ehBghZ6/Fy@devvm29614.prn0.facebook.com>
References: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
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
In-Reply-To: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4NyBTYWx0ZWRfX8TSVGHeGuwZl
 DuiN1xwAtImumV8S+JQqecYnRC9HjIXqdRVRCkZWaR8chGd7+vreV74cGajVcMFvc6E9Kkk/RkI
 2PrOKX1JNjXBsQyfYXM5iVUkTcQu4IuLOERUgfFkhf4P8xdoY7Ys8pyyw5j/muVowq6CtFKwjkP
 FyCQPBlToG/ZTQdQvEMN4beKoAJp6VCR7Sb5deM/lvBuafUXGCB4jmgJqvoFS9vtpLbzm8OWPNl
 lNFr43hJ725oauVwaH83ujXfYItfoEO78vvrWjIdhUOsi2JonK0so/gHKLy+6p7UOnN9Ou2sAjv
 4/6VEvro5MeasKjM3dvHOtwtf4ctf1iutFPNwG9Hfz9P8LfeCZ2W3oA+6RAMyWZF2imYoVKOJWE
 69i6MVeVGU01Ino+ESnuocuHTDcJFPih1DRX2sf2wSbDKO1yZQE3mPwH3NO3L435lBNdkTG3gCB
 SCzTK1k/8Wzsz2Y2ypA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4NyBTYWx0ZWRfXxA+5hsMAS/Sp
 t4lE80PUamLj5rfnGSQuH8pd76cq+ZESQiz54zQdq6OltbWek9T1KVNiffACqO5QZCvx6ZDXrHg
 bhxJq0ztWIb6nrWFRzrFBxfEYvSvDa0=
X-Proofpoint-GUID: 3Di65TljFpEGONzW2DDRCtPX2nAP-ZZQ
X-Proofpoint-ORIG-GUID: 3Di65TljFpEGONzW2DDRCtPX2nAP-ZZQ
X-Authority-Analysis: v=2.4 cv=GrXXaU1C c=1 sm=1 tr=0 ts=6af7898d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=i7-SfpROG94AJB53qLoA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01

On Fri, Nov 13, 2026 at 06:04:40PM +0100, Sergio Lopez wrote:
> VMCI already rejects datagram sends from local network namespaces, but a
> datagram bind still creates a receive handle in VMCI's global port space.
> A VMCI sender outside the namespace can therefore deliver to the local
> socket. Its handle also prevents a global-namespace socket from binding
> the same port.
> 
> Reject VMCI datagram binds in local namespaces. No namespace-local
> datagram transport exists, so EOPNOTSUPP reflects the available receive
> paths. The receive callback also rejects any local-mode socket as a
> defensive check.
> 
> In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
> delivery and the global port collision before the fix. After the fix,
> local bind returns EOPNOTSUPP, the global bind succeeds, and a global
> VMCI datagram still reaches the global socket.
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  net/vmw_vsock/vmci_transport.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 1f186e8f8364..282131544c42 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -627,6 +627,8 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
>  	 * outside of the create and destruct socket functions.
>  	 */
>  	vsk = vsock_sk(sk);
> +	if (!vsock_net_mode_global(vsk))
> +		return VMCI_ERROR_NO_ACCESS;
>  	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
>  		return VMCI_ERROR_NO_ACCESS;
>  
> @@ -1697,6 +1699,10 @@ static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
>  	u32 flags;
>  	int err;
>  
> +	/* VMCI handles are global and cannot serve local namespaces. */
> +	if (!vsock_net_mode_global(vsk))
> +		return -EOPNOTSUPP;
> +
>  	/* VMCI will select a resource ID for us if we provide
>  	 * VMCI_INVALID_ID.
>  	 */
> 
> ---
> base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
> change-id: 20261113-vsock-vmci-netns-isolation-7e46732dcd73
> 
> Best regards,
> -- 
> Sergio Lopez <slp@redhat.com>
> 

Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
