Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE98333433
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048556; cv=pass; b=Xssq6pk3IlMTmWXopO2GEwvXyUj1SsAiRCVUOR0yICnW9KAHsKyqHHhd4kLSL3R2tI7B858K6VuL+MSKxhdq+e9PTc1ehEcR4TIlm4hVwQX9foD9NBCz/Krmu6fFsgfnimOWmeAesNkspsaSMkhLeXzroH49P5MapX1A9xOT8uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048556; c=relaxed/simple;
	bh=k/JBKH2vI1/UCFnQkOHqpD/NJyrEHN8KXki2dB6QmkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJbrZI5QisxwKmr0TYNFYlkmFgqrF0P/LcRthAPtgdekkevA4h14SjQNgs7Uywc8bIf3pSylgwN7S0Dr2wiitSL7nSaSLebenkfsR49pFJARLaobNFoHeodBxX27GKaWaYlPz2Zi85KkfzUYLXu1VAL03HXuvWQPKVDiHVx7lmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=obbZIBHf; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=TM1wM7Xl; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="obbZIBHf";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="TM1wM7Xl"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-7pjs.prod.antispam.mailspamprotection.com; s=arckey; t=1761048554;
	 b=qiDxKk3T7n59AEYKB7+vYI7PIzlv1cPSlrEKKIvlWlF57o3iyXZXCctdXrnDpv775pCBTO26Pw
	  rWLonoEsPNebxTEBcrMsRYWxI4stTF+T56vvXHiQfq0iURc3kCrp59h9ukGiHp9PW2fjgvF6sE
	  hQF09gz3vDc5LAUchF0+JgLSH6rQwm/JmQX74A+O15nHXs6bsaij7rKuWIgqFAlEjj40597bLi
	  UWEPw3rmR81CyISY0INiDa24Q1C4K+HwL7Swj56F5SirWR1Kows6Ms51cFtx245kNYHSz1l2BM
	  5qRiTsjuGBwuLyJZEWrBijro/uW+tzq5AA1EC9yosJxcrQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-7pjs.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-7pjs.prod.antispam.mailspamprotection.com; s=arckey; t=1761048554;
	bh=k/JBKH2vI1/UCFnQkOHqpD/NJyrEHN8KXki2dB6QmkE=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=0OjVYIqTmpBil+jIb0Qm9HWIrQe4/A0y6Sk8PQgS+BzPw7yT6Lo0d+9LmYaMq4YeXIraBUvqoE
	  6rCIEgKi/NYRZGCvLsAqMMQ0GK14dZjB4jjp08KtXgSPpVGoy7q7/Rao9NIM0r4+IdLucWlf6G
	  09LjKhuhPutOdav96H0SN+LD4cztZN3YksEWPbWIq1dBz0Qaf1njvlsFZqw9OIB06yRgn4pogM
	  fv06sN2r6ozMo8p5PjcQTD3xptAmperoUir00taRZ0532z64jW9AhmDU0dsy2hVM797fd0qbrB
	  9dev6aZHuuiBXT1Osxd2DJ9qLb0SWx2IOriQ8d3v6ecoEg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=pNzAWqaeaTCPO3gF7PZWEYVRaidTc0Ewfr2jBPVAsgE=; b=obbZIBHfTUe54ZeQHtHXaRlydB
	GBm/FzWo6vxBFm35dwvQ6ypVE7JufGci1J8rYGOhuqdUKpu6Ftg/xqe1PqEpDvf13bMYB6uRVto7A
	5vU1VAdlWFeMUpAFVbBR7SihrBf9z6ZogygvIW+f1NpU2LG/SEGJ+obUzw9TewyPnHjQ=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-7pjs.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBBAl-000000079p9-2wWs
	for virtualization@lists.linux.dev;
	Tue, 21 Oct 2025 12:09:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=pNzAWqaeaTCPO3gF7PZWEYVRaidTc0Ewfr2jBPVAsgE=; b=TM1wM7XlESEhidmw9p+vMbQbvs
	FYpcCmLo+5qjG832TYone0TFwBdK5DrshS12VcVTmwDb7vr+CS3buAlpwx45LkuVncbpEpqDSkM06
	RcZAqmW6nWEmpK0CZIGXvZRuRYrP1MIn3c6wwf+jTjuBsXHiQGZNR8ijwJubwG8k6So4=;
Received: from [95.239.58.48] (port=60828 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vBBAL-00000000J0Y-1zlx;
	Tue, 21 Oct 2025 12:08:37 +0000
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Harald Mommer <harald.mommer@opensynergy.com>,
 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 Wolfgang Grandegger <wg@grandegger.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Date: Tue, 21 Oct 2025 14:08:35 +0200
Message-ID: <28156189.1r3eYUQgxm@fedora.fritz.box>
In-Reply-To: <aPdU93e2RQy5MHQr@fedora>
References:
 <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <27327622.1r3eYUQgxm@fedora.fritz.box> <aPdU93e2RQy5MHQr@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 4d745c039bbbc077ace614673fd9ab53
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vBBAl-000000079p9-2wWs-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-7pjs.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Tuesday, 21 October 2025 at 11:40:07 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> On Mon, Oct 20, 2025 at 11:24:15PM +0200, Francesco Valla wrote:
> > On Monday, 20 October 2025 at 16:56:08 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> > > > On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > > > > Hello Mikhail, Harald,
> > > > > > 
> > > > > > hoping there will be a v6 of this patch soon, a few comments:
> > > > > > 
> > > > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > > > 
> > > > > > [...]
> > > > > > > +
> > > > > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > > > > +{
> > > > > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > > > > +	struct net_device *dev = can_priv->dev;
> > > > > > > +	struct virtio_can_tx *can_tx_msg;
> > > > > > > +	struct net_device_stats *stats;
> > > > > > > +	unsigned long flags;
> > > > > > > +	unsigned int len;
> > > > > > > +	u8 result;
> > > > > > > +
> > > > > > > +	stats = &dev->stats;
> > > > > > > +
> > > > > > > +	/* Protect list and virtio queue operations */
> > > > > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > > > > +
> > > > > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > > > > +	if (!can_tx_msg) {
> > > > > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > > > > +		return 0; /* No more data */
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > > > > +	} else {
> > > > > > > +		result = can_tx_msg->tx_in.result;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > > > > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > > > > > > +		 * echoed. Intentional to bring a waiting process in an upper
> > > > > > > +		 * layer to an end.
> > > > > > > +		 * TODO: Any better means to indicate a problem here?
> > > > > > > +		 */
> > > > > > > +		if (result != VIRTIO_CAN_RESULT_OK)
> > > > > > > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> > > > > > 
> > > > > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> > > > > > 
> > > > > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
> > > > > a problem in the rx path and this is the tx path. I think the comment
> > > > > refers to improving the way the driver informs this error to the user
> > > > > but I may be wrong.
> > > > > 
> > > > 
> > > > Since we have no detail of what went wrong here, I suggested
> > > > CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled with a
> > > > controller error with id CAN_ERR_CRTL; however, a different error might be
> > > > more appropriate.
> > > > 
> > > > For sure, at least in my experience, having a warn printed to kmsg is *not*
> > > > enough, as the application sending the message(s) would not be able to detect
> > > > the error.
> > > > 
> > > > 
> > > > > > For sure, counting the known errors as valid tx_packets and tx_bytes
> > > > > > is misleading.
> > > > > > 
> > > > > 
> > > > > I'll remove the counters below.
> > > > > 
> > > > 
> > > > We don't really know what's wrong here - the packet might have been sent and
> > > > and then not ACK'ed, as well as any other error condition (as it happens in the
> > > > reference implementation from the original authors [1]). Echoing the packet
> > > > only "to bring a waiting process in an upper layer to an end" and incrementing
> > > > counters feels wrong, but maybe someone more expert than me can advise better
> > > > here.
> > > > 
> > > > 
> > > 
> > > I agree. IIUC, in case there has been a problem during transmission, I
> > > should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC package with
> > > netif_rx() and 2) use can_free_echo_skb() and increment the tx_error
> > > stats. Is this correct?
> > > 
> > > Matias
> > > 
> > > 
> > 
> > That's my understanding too! stats->tx_dropped should be the right value to
> > increment (see for example [1]).
> > 
> > [1] https://elixir.bootlin.com/linux/v6.17.3/source/drivers/net/can/ctucanfd/ctucanfd_base.c#L1035
> > 
> 
> I think the counter to increment would be stats->tx_errors in this case ...
> 

I don't fully agree. tx_errors is for CAN frames that got transmitted but then
lead to an error (e.g.: no ACK), while here we might be dealing with frames
that didn't even manage to reach the transmission queue [1].

An exception to this may arise when the VIRTIO_CAN_F_CAN_LATE_TX_ACK feature
is negotiated; in this case, a VIRTIO_CAN_RESULT_NOT_OK may indicate either a
dropped frame (tx_dropped) or a failed transmission (tx_error) [2].



[1] https://github.com/oasis-tcs/virtio-spec/blob/master/device-types/can/description.tex#L139 
[2] https://github.com/oasis-tcs/virtio-spec/blob/master/device-types/can/description.tex#L196


BR,
Francesco




