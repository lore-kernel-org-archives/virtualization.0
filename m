Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CE1E5702;
	Sun, 10 May 2026 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778396643; cv=none; b=awJTmcz3SDgazSNuFrZwY43qi4Sbpo0kp+XyIbTYOGOSBWpmhIfkbV14ziv2WDM9KmZZa0pvtaLZg0imjj3NV1KKRHtmUb6fFVR/6A051hlt9Pms9zXxmDWmkTxXMPFyvWm0Hmeo+HjpjI1yakxj1dj50VquwRnWx3UP7ZnKYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778396643; c=relaxed/simple;
	bh=RwH/54gs+YrOj3HXbY9p+I3vMzFonUdHH2SDCWiM39k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhb8ZsUKiyCZTwcqj+pUtbRfYsRY5DuCBIZi6cNd4fwZV5J6lbFe6ifUj5t7IE4p+SyLnAGWpGbemsrWloHSk2uPYK9pdD76elB0gGse773vUVHq++8HDtuhqN2jbb/7zsKNPEVnMlBfVCntja0nDFmX70Sp02bf8nkNORoDS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=LxqluCcN; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="LxqluCcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778396629;
	bh=RwH/54gs+YrOj3HXbY9p+I3vMzFonUdHH2SDCWiM39k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LxqluCcND+gz4fdJCOGN198RssBIK4CO2FbMlKLZR3kejds7aFabkYB2q8x17E3Co
	 izE3+c7g8KktptTbRRkPIV/5N1mMFZvBiZziJRsXp78am9OJuys4jGwZC2JlZiLAAG
	 zxLGNXEd9l0hydnEZ6B6965bRzkTDOkr+ySVlBnc=
Received: from [192.168.178.180] (pd9eaa57d.dip0.t-ipconnect.de [217.234.165.125])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 64A73kXP016859
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 09:03:47 +0200 (CEST)
Message-ID: <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
Date: Sun, 10 May 2026 09:03:46 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260509183518-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/26 00:44, Michael S. Tsirkin wrote:
> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
>> On 5/8/26 17:10, Simon Schippers wrote:
>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
>>>  {
>>>  	void *ptr;
>>>  
>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
>>>  		tun_ptr_free(ptr);
>>>  
>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
>>
>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
>> operates on a tfile that is being torn down. Its queue_index is no
>> longer valid. After the swap in __tun_detach(), it points to the
>> netdev subqueue of a different tfile.
>> --> We should not wake there.
> 
> Does it not exactly point at ntfile which is what we want to wake?
> 

I see your point. But calling tun_ring_consume() as done here is
wrong, because it does not wake if the tx_ring of the tfile 
(that is currently torn down) is empty. We could change
tun_ring_consume() to call __tun_wake_queue()
with consumed=0 if !ptr but I think this would slow down the consumer
path.

> 
>> I will swap tun_ring_consume() with ptr_ring_consume() again and
>> submit a v12 :)
> 
> If so then maybe
> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
> 

But we should only do this if there is space in the ntfile.
My approach:

@@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
 		BUG_ON(index >= tun->numqueues);
 
 		rcu_assign_pointer(tun->tfiles[index],
 				   tun->tfiles[tun->numqueues - 1]);
 		ntfile = rtnl_dereference(tun->tfiles[index]);
+		spin_lock(&ntfile->tx_ring.consumer_lock);
 		ntfile->queue_index = index;
 		ntfile->xdp_rxq.queue_index = index;
+		ntfile->cons_cnt = 0;
+		if (__ptr_ring_empty(&ntfile->tx_ring)) {
+			netif_wake_subqueue(tun->dev, index);
+		}
+		spin_unlock(&ntfile->tx_ring.consumer_lock);
 		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
 				   NULL);

ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
That is the reason why I reset it to 0.
