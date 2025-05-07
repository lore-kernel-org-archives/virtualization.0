Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F128C2AB
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634712; cv=none; b=PanyYsFJvRVzFNaDZrqFpIl8z/atRc20Utmi6o1gkA1pTt+EjWb+SP7jvlD+QMKSfTSiNsJflyU/EVVBtxDU2A49xtQ+9IdEX1Xg9gNdNFp2v6adnbKVmBij7muukgJxcOQRJgsCRSr3JBphrJyD24psuvMozoyPniiMKf6og4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634712; c=relaxed/simple;
	bh=bWVXWi6FNTmsC6XQcQl5QLoeoLqMPPpdOvDyzqsEHVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Cap99fL/g3DY0XrP5ZEzMN8BLzrBb/mB+oppWZaU/MnHPZRo5E7kUoODA15urD9037+88ZmP+zuuo4GBcQMKEqiliEpZJBRvulDD+5XQcxnSoMZ93m9GLKhLwoXZyITylBapn6GB1r5Uajyv7KQ5ElS5H3QAA8/jh4sHqF4HMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H61aVhr6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H61aVhr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746634707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39nLFDBfyFezv/758tbb1M4Ol4SxY7Fer6M45n6qLAM=;
	b=H61aVhr6a4C06legg8oIs6BV5Oy10L0zbDMeDORlpI7EYjmpb3brmVXCkQmnkuY0F9T2+b
	O31b3r2HB2q/5zalnpzLSSdsGob1yCmSaMSNpQUnQW4I5V87+X6jkdP0Ub0fSbYi737D85
	ZWlmN0A/gGTCy0aAPn7nSGfpjgT1KDo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-RM_PGrx1Nty5nHrrRJQkIw-1; Wed, 07 May 2025 12:18:26 -0400
X-MC-Unique: RM_PGrx1Nty5nHrrRJQkIw-1
X-Mimecast-MFC-AGG-ID: RM_PGrx1Nty5nHrrRJQkIw_1746634705
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ace942ab877so487395566b.1
        for <virtualization@lists.linux.dev>; Wed, 07 May 2025 09:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746634705; x=1747239505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39nLFDBfyFezv/758tbb1M4Ol4SxY7Fer6M45n6qLAM=;
        b=aA9ZlHKiTqM+qBRjoWZlI8/RY+yy65IEd08hoZGwIaoVhlHUgtGQvqLiPnW601VLkP
         pC2ES15l0YT7KRdQGjV1oi8/Bd7RKwViA/y3Q12VySWuA+WsYgjFYKN3sOCVsLlwIkEX
         FB+StUPXkAuyn2QDo5G9SYYtKmQ2lRTZ14/u4PcgszBVzg3SvcAImROL7oTgP6z7dr6y
         5NE4PT6MXrCHNQNGTbIhDF2UiTuKB/z9DegfvoLYtC8M69NDk3o/UINv4ja0JUi/438g
         ZnDhGfHTVbY32CN0WS4JHvhOsb8WLrXRgUQAVLZdYmKgzEFZ7nKpcxU0TjYHiH1Zo+O1
         KisA==
X-Gm-Message-State: AOJu0YxNYtvAJsP6gFPsMWXCWH2VAJ/UqFY+M8LzvtW1cY50gb2dLyh8
	SOi1ShNLFE1TIaoMHmaoYb3tV7wvBjrHhu+7rm7JK7hPFkpd+EL1CjaKtBHOqCbdo2UVqbcmcpY
	eSgqLn+rfk/NxKJzGEnIQ9RB6lnnJsL9XpOmbEdbsUN//Z7mewui17eVxDKP/Xa76
X-Gm-Gg: ASbGncv/OUDVutV+2NKv65vD8fvtZWP26RwJ+m6B++6HEYOUYrW8VbqHq1SMWIxMs/Z
	7+64tvM+lIDdT/VYZAvxXOceYpR7/pRo2R8WdpHpC/4YhwbNUTFYy4p+csBDY0dEM7tQMQUBqf1
	CfMh/DDV+UyJg2Wov/oI7fPTBuHszs5Zn32uoHDQrl7GogZwqaUf/doARdnUWKnLfTI/TavOkJS
	A4onElciNSlPRx/3KZfB+ApztiqIOWyGtD7F5H7WkbjoaycxK2GkKEAOFNr2Okq0nhB8JKUAlSK
	L1y85l0tdl9X8SYk
X-Received: by 2002:a17:906:6a21:b0:ac3:5c8e:d3f5 with SMTP id a640c23a62f3a-ad1e8bf2298mr431573666b.27.1746634705137;
        Wed, 07 May 2025 09:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcpsNEPHJMDyuwXMw9YaT6C3LUO/0nHh1kX9E1tgCGACOK+8BvvpnBj9Yg4yGqdZN/AhWgIA==
X-Received: by 2002:a17:906:6a21:b0:ac3:5c8e:d3f5 with SMTP id a640c23a62f3a-ad1e8bf2298mr431569666b.27.1746634704432;
        Wed, 07 May 2025 09:18:24 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.183.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891e980bsm920838266b.76.2025.05.07.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 09:18:23 -0700 (PDT)
Date: Wed, 7 May 2025 18:18:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SIOCOUTQ
 tests
Message-ID: <CAGxU2F5XeRs+4Fwrf_LhOjhjxaWOocpZDQanOc+mcDyPFRHCfQ@mail.gmail.com>
References: <20250507151456.2577061-1-kshk@linux.ibm.com>
 <CAGxU2F6ssoadHjCH9qi6HdaproC3rH=d-CdYh2mvK+_X4-C4nw@mail.gmail.com>
 <689ab62a-7800-497d-a9a6-3a81e256f98d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <689ab62a-7800-497d-a9a6-3a81e256f98d@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tZn7o3TjVRccYYrEDmL84JrJpD0QP_zJ3r0bC1T82x0_1746634705
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, 7 May 2025 at 18:01, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>
> On 07-May-25 10:41, Stefano Garzarella wrote:
> > On Wed, 7 May 2025 at 17:15, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
> >>
> >> These tests:
> >>      "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
> >>      "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
> >> output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
> >>
> >> They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
> >> have been received by the other side. However, sometimes there is a delay
> >> in updating this "unsent bytes" counter, and the test fails even though
> >> the counter properly goes to 0 several milliseconds later.
> >>
> >> The delay occurs in the kernel because the used buffer notification
> >> callback virtio_vsock_tx_done(), called upon receipt of the data by the
> >> other side, doesn't update the counter itself. It delegates that to
> >> a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
> >> more than the test expects.
> >>
> >> Change the test to poll SIOCOUTQ until it returns 0 or a timeout occurs.
> >>
> >> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> >> ---
> >> Changes in v2:
> >>   - Use timeout_check() to end polling, instead of counting iterations.
> >
> > Why removing the sleep?
>
> I just imagined that whoever uses SIOCOUTQ might want to repeat it
> without a delay, so why not do it, it's a test. Is there a reason to
> insert a sleep?
>

Okay, now that I think back on it, it's the same thing I thought of when 
I did this.

I guess in v1 the sleep was just to limit the number of cycles.

LGTM:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


