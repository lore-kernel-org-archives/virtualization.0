Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F325D1E6
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356129; cv=none; b=PT7gGK1DpHxk+AeRAyBJwlDqhpfzm6o8n7vsoAxaS/80K1amdKcIpBZfCCysehPTJDDnQQb8Za1AalQM4M6N4UHYPetpvKbFchCA8NSFZrhmX4jLBZhjE0Djz7pHxsGdzvm7p6YyCCy9gnjonVxURuiQFKfLOgMHCckNeC02Dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356129; c=relaxed/simple;
	bh=yfyVRPQTE8JqiDbaOUKxGFIbx1q4UehpJFGONWIiHbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8PjqG/ZQN8786n8z68PXeB0axaa89Vt4E1KW/u6aO05InlAGJ462snkf/DtykvrwuYr+/tWB72ZAkn8WfUFUi3Asv17dlB9vxDRG0luEMLaJ4nPgXSZNS4h9RnAYWpDEY3AFMzJsO8wRVfNx11pmzFMSNdsVC2kurtmDlcBarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j8x3i2z9; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j8x3i2z9"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31c6c9959cso3694149a12.1
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 00:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751356127; x=1751960927; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEpFKt7YYcFzTPMsl+PrVIXjmxXbTAxWQl834MFcBTI=;
        b=j8x3i2z9+hJ48HXat4Qw/N3sx7qheZoMJ3CjLe62kdJKF8B0rQdMGoUo7OwKSi+rp1
         CILGjRrFzbq9Vn71HN/DVIKyQ+DjkqnwWN0rRK9o4Was3hOWDn6C4+sUuQS+ypCTmOC7
         jO2HbPkPj7Q7V5mRAOgxEQkpcVoz2crrIEc1QnNMS+kvY5zInDfX9CQhVVwJ8oAegG2h
         YxHDQry0eJizDUILTkNhTi8TLfRhDcIX+N9jmDdEeAr991TVRWKXkNf/qu2HXP3QOhLT
         kjIfkcsBoCMd7haTV4fHIECxYJUycmRVuEFA2BRsN57ZiJwHohYvZsgv5m7Jvvroq8bu
         3cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356127; x=1751960927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEpFKt7YYcFzTPMsl+PrVIXjmxXbTAxWQl834MFcBTI=;
        b=A0YRpAUdR+iLSTneBouAp3EbHtybvt/Gys9RifxzTRTKSNLF2vDnA3zacDsvtqOlz9
         OfcdDkuFzanUUdN/atAKjRWhdT1hfEV6aLnOYH1OeycdM0LMh+kZe0Ws0cX844UGXpkF
         zmssMHgIWXIoLohQQHVfENzjLWcVWRndvd0Deny0DciwKezef7jnUMvw7KffsSV5+pee
         emDmF/s61R8Tuqbr0+0ncybxVSl3+aDVQcrSz9rO8zXcZ29Xg0E1BSth93bBrpd7rCSz
         gQLfHrU4ekj0p0ASNu0IUQ3/v5RVTnjINjTt2yvl7tc3S483ZBGe9Ljas2LwAR7qvis4
         NO9A==
X-Forwarded-Encrypted: i=1; AJvYcCWSWJQ4fsBn54CwnulJbpi/vMiBveHx8xEE7FMilfRpC/9qv5TwK0nxj7GU+ZEGs481ykUIPOfLezSb3CRFIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrpKlbXzAPK4jYrBc8oF+CMOvZKXJTipBVKGyaTM7r9DlPmEJm
	1jWooxp08akfyJCTYqMKHOY1+IMGWqpyG43pzCP75HWSdZvgHR6/pT20rMOTn4xQPx0=
X-Gm-Gg: ASbGncuif3nu88/6Cwty0UZH5FEnVWRMEvp9mlsqxcMeQt0bBi1MCftJd/EVrooJaan
	fI9VKDSq5RVehm0YBI/3swo021ddp8P4mvhmYUvcwy87Y4MEGwTIryEQCU70M1x543r+PUxbfB+
	/4AjzI/qutY+nCOk+MxOSixAs9orlMJCc0J0QpIIUXOwhj8ZnBTTsXq0Rmst98FgJ2NleYnplq/
	A6JA2v1cNmzmMFWAaV2GV2RyP7vndiAGEIgYPfazl602dPEKq+j9DQcarJGxqAN+WoPGVNYxCLz
	T2vU2GmSXIT8yHlEhRiQufOY1JhMSc8UbJ3Iu6hsv9sYDQanVD5pINzWyf4necaIaTvC62QRqdZ
	WfCoS
X-Google-Smtp-Source: AGHT+IEkSOMFIWuHzTsl3h9jkYp4/Xk30pqD6Wb6IEepi4SrOE2ToSdyXBQqLIMA/PtSl0WH+SMRvA==
X-Received: by 2002:a17:90b:2dd0:b0:312:db8:dbd1 with SMTP id 98e67ed59e1d1-318c8ff231fmr21355546a91.5.1751356127275;
        Tue, 01 Jul 2025 00:48:47 -0700 (PDT)
Received: from [10.74.31.243] ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13a16besm10785331a91.14.2025.07.01.00.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 00:48:47 -0700 (PDT)
Message-ID: <f1f68fbd-e2cf-40c5-a6b8-533cb3ec798f@bytedance.com>
Date: Tue, 1 Jul 2025 15:48:41 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net] virtio-net: fix a rtnl_lock() deadlock
 during probing
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250630095109.214013-1-zuozhijie@bytedance.com>
 <20250630103240-mutt-send-email-mst@kernel.org>
 <20250630105328-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Zigit Zo <zuozhijie@bytedance.com>
In-Reply-To: <20250630105328-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 10:54 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 30, 2025 at 10:50:55AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Jun 30, 2025 at 05:51:09PM +0800, Zigit Zo wrote:
>>> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
>>> the virtio-net driver is still probing with rtnl_lock() hold, this will
>>> cause a recursive mutex in netdev_notify_peers().
>>>
>>> Fix it by skip acking the annouce in virtnet_config_changed_work() when
>>> probing. The annouce will still get done when ndo_open() enables the
>>> virtio_config_driver_enable().
>>
>> I am not so sure it will be - while driver is not loaded, device does
>> not have to send interrupts, and there's no rule I'm aware of that says
>> we'll get one after DRIVER_OK.

Yep, at first we're thinking that when the VIRTIO_NET_S_ANNOUNCE flag set,
we can always assure an interrupt has fired by VMM, to notify the driver
to do the announcement.

But later we realized that the S_ANNOUNCE flag can be sent before the
driver's probing, and for QEMU seems to set the status flag regardless of
whether driver is ready, so the problem you're talking still may happens.
>> How about, we instead just schedule the work to do it later?I'm not sure if scheduling the work later will break df28de7b0050, the work
was being scheduled before that commit, and we have no much idea of why that
commit removes the schedule_work, we just keep it for safe...

Then, for plan A, we change the check_announce to schedule_announce, and if
that's true, we do another schedule_work to call virtnet_config_changed_work
again to finish the announcement, like

	if (v & VIRTIO_NET_S_ANNOUNCE) {
		if (unlikely(schedule_announce))
			schedule_work(&vi->config_work);
		else {
			netdev_notify_peers(vi->dev);
			virtnet_ack_link_announce(vi);
		}
	}

>>
>> Also, there is another bug here.
>> If ndo_open did not run, we actually should not send any announcements.
>>
>> Do we care if carrier on is set on probe or on open?
>> If not, let's just defer this to ndo_open?
> 
> Hmm yes I think we do, device is visible to userspace is it not?
> 
> Hmm.  We can keep the announce bit set in vi->status and on open, check
> it and then schedule a work to do the announcement.

Okay, so there's a plan B, we save the bit and re-check it in ndo_open, like

	/* __virtnet_config_changed_work() */
	if (v & VIRTIO_NET_S_ANNOUNCE) {
		vi->status |= VIRTIO_NET_S_ANNOUNCE;
		if (unlikely(!check_announce))
			goto check_link;

		netdev_notify_peers(vi->dev);
		virtnet_ack_link_announce(vi);
		vi->status &= ~VIRTIO_NET_S_ANNOUNCE;
	}

	/* virtnet_open() */
	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
		if (vi->status & VIRTIO_NET_S_LINK_UP)
			netif_carrier_on(vi->dev);
		if
		if (vi->status & VIRTIO_NET_S_ANNOUNCE)
			schedule_work(&vi->config_work);
		virtio_config_driver_enable(vi->vdev);
	}

This is a dirty demo, any ideas are welcomed :)

(I think in virtnet_open() we can make the S_LINK_UP being scheduled as well?)
