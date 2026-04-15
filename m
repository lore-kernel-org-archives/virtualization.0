Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1786E332919
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258686; cv=none; b=F4kMqlsNo0IvaZ+nq/s7K6VkIXpobfIcx6Pq04Z/2XIpif4ESqQL3FqGNwrh05lus2lK2SSk2B+YseT4PwAQLaiOHIoGcuyebFufzUF79FW9ylZTmTUbmwvedK+ZlW0AuELXsZ5pl6nNAs6G3rJEPeol6ZTWQCl8iXdGP71nSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258686; c=relaxed/simple;
	bh=HOy4QBTiHtu5pZJktO361ZlyF5xmQN/JVgQvXBzyBow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bHMNia6oC7wXl6U17OZGuK/tX2Y1WkK77siDNIWv4C3mC4wfPnLPGB7Qca/9xVK/o7hnCZHXcgEG2w7EAG25un52cCDkKgirtKM8tIAC9Dx4bHlaXJ6ABnnbJdREQmkk28DMNxhRfl0VnnDB5AHRjaN+a4AjxbFwy8GK5LW99dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OC0cUE0G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OC0cUE0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776258683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WL2SJseQynMpG1hsJR3ThfhQkhlDiJgfMk9Ad5tgV64=;
	b=OC0cUE0GibiyV5D9TNdQaTeYxHt2GmaRLg2/cO7SkptEPo8PIzK5+kagAUbGT7WeC7FLAp
	jzN+MuouDFqYXu84hsnhR9xM5Et8vjfiMcILOGKZ5BATwYy7bw6ZMTT0+u4ZUBe7N2fgZq
	tOUHM3wrmE3tQFWmAg0rQeNQT9hjiic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-knHUGWerMoWryXj83LUanw-1; Wed, 15 Apr 2026 09:11:21 -0400
X-MC-Unique: knHUGWerMoWryXj83LUanw-1
X-Mimecast-MFC-AGG-ID: knHUGWerMoWryXj83LUanw_1776258681
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d4ac6ff9so38950465e9.1
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 06:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258680; x=1776863480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WL2SJseQynMpG1hsJR3ThfhQkhlDiJgfMk9Ad5tgV64=;
        b=kqAs2ErLFQ9GMdmWBOU85ZjqKi3fN48wkL3w/WpjMiqxZODelnz/4th4wD/TzuQLte
         WLgiTGdgpjkNN3LC6cinJgjtph35Y1gz873h9hE0PLBtpJrhSBPMuHm8FYYa3Qu3yYa/
         OlfKUN4OchSfyiHbbQ9KPQe6qpu4pOtAqoPt27U6TgLmqPnUpkBGJKNNqwWX2pgLwzBA
         XukVdWn9AQnXh019UkPMuw2zVkILegHT1GG+PaVds9LT0IB7XmTDENJbT/+nDmOsEctS
         rkDJL+MQuCleiq53PPgNUCW/5CEkXb84INMsc0QJf+QGJ0M7LO0t2lZcA/OODCnKEIfk
         +Z3Q==
X-Forwarded-Encrypted: i=1; AFNElJ/1eEAdu78NjvyW2IhG55P52CfqpSkIU8lhcwTU7BDfT4CmLAWk16XzW4EjmP/EUszobnjuJOp2kTr5ex9hpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg2UQzYNEdOCvaPaBstrTaHRsI2MK1MjiCaiX1zeCT9l2tEMPO
	osi5GxK+OHCD3+8CdkFIu+Ovw7Ut/yhet2DlL6To6q2zXxuhq/OPcZi7V+n2jEbk1DGJ0ZcNelB
	ocabMC6vPuTYIWzR20f/rcbwLQNRMQuzkwap1XLkDiQTWQMx5iMMJiL8RD4n+p4/1iezJ
X-Gm-Gg: AeBDievEeWRehnM93mFxjySWzZtd2dSu1vCFjAkMVbOLQCNKZZMu0eSfk6ei0hin4PW
	YB17a0oEjC2sSO12Si7vp85TYdQ1BYfeCUsmMFQZN0afilbWomhPDaXLbuEnF6ztagHMr9ctGgZ
	IrH2e3InlnwotSLCCinKafcUE3h/sikrtJSIY6y5St0K3mBvL1usnAgaOaGXq7Wi0uI1yVzDvUw
	8WyshKnDp/jSOACFFMgebnzC4a6CkK1bfnRRjPkJu565H54CSBVK+2tlF9+sODS6x9rHnOFhKM6
	NW0QHqjlTheemlcKZpDPGZeCutEmoyLtmeGSNWbZ1L+uc8EZGyBrqraR4NjPGhBjfXBC4DCjJgS
	IPgdSFq6VuqNbtC6WAX9KBDA8c9Y=
X-Received: by 2002:a05:600c:6994:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-488d67bbcbamr306254135e9.3.1776258680473;
        Wed, 15 Apr 2026 06:11:20 -0700 (PDT)
X-Received: by 2002:a05:600c:6994:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-488d67bbcbamr306253665e9.3.1776258679964;
        Wed, 15 Apr 2026 06:11:19 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0ebd0e1sm20362525e9.28.2026.04.15.06.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:11:19 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:11:16 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] vsock/test: fix MSG_PEEK handling in
 recv_buf()
Message-ID: <ad-OSiCXGAXKgxrx@leonardi-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
 <ad9uYrUjgCkW1D_k@sgarzare-redhat>
 <ad96TgXHW_jKitls@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ad96TgXHW_jKitls@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J3VT2wqMSOmxW5eVsu8Yvw8DQKFLfdP9-O4UnF_zK7w_1776258681
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 15, 2026 at 01:54:43PM +0200, Stefano Garzarella wrote:
>On Wed, Apr 15, 2026 at 01:31:11PM +0200, Stefano Garzarella wrote:
>>On Tue, Apr 14, 2026 at 06:10:22PM +0200, Luigi Leonardi wrote:
>>>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>>>`recv` until all requested bytes are available or an error occurs.
>>>
>>>The problem is how it calculates the amount of bytes read: MSG_PEEK
>>>doesn't consume any bytes, will re-read the same bytes from the buffer
>>>head, so, summing the return value every time is wrong.
>>>
>>>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
>>>requested amount is more than the bytes available, the loop will never
>>>terminate, because `recv` will never return EOF. For this reason we need
>>>to compare the amount of read bytes with the number of bytes expected.
>>>
>>>Add a check, and if the MSG_PEEK flag is present, update the counter of
>>>read bytes differently, and break if we read the expected amount.
>>
>>nit: "..., update the counter for bytes read only after all expected
>>bytes have been read and break out of the loop; otherwise, try again
>>after a short delay to avoid consuming too many CPU cycles."
>>
>>>
>>>This allows us to simplify the `test_stream_credit_update_test`, by
>>>reusing `recv_buf`, like some other tests already do.
>>>
>>>This also fixes callers that pass MSG_PEEK to recv_buf().
>>
>>nit: this is implicit from the first part of the description.
>>
>>>
>>>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>>---
>>>tools/testing/vsock/util.c       | 15 +++++++++++++++
>>>tools/testing/vsock/vsock_test.c | 13 +------------
>>>2 files changed, 16 insertions(+), 12 deletions(-)
>>>
>>>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>>>index 1fe1338c79cd..2c9ee3210090 100644
>>>--- a/tools/testing/vsock/util.c
>>>+++ b/tools/testing/vsock/util.c
>>>@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
>>>	}
>>>}
>>>
>>>+#define RECV_PEEK_RETRY_USEC 10
>>
>>10 usec IMO are a bit low, it could be the same order of the 
>>syscalls involved in the loop, I'd go to some milliseconds like we 
>>do for SEND_SLEEP_USEC.
>>
>>>+
>>>/* Receive bytes in a buffer and check the return value.
>>>+ *
>>>+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
>>>+ * reads cannot be summed. Instead, the function retries until recv() returns
>>>+ * exactly expected_ret bytes in a single call.
>>
>>I'd replace with something like this:
>>
>>  * When MSG_PEEK is set, recv() is retried until it returns exactly
>>  * expected_ret bytes. The function returns on error, EOF, or timeout
>>  * as usual.
>>
>>Thanks,
>>Stefano
>>
>>>*
>>>* expected_ret:
>>>*  <0 Negative errno (for testing errors)
>>>@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
>>>		if (ret <= 0)
>>>			break;
>>>
>>>+		if (flags & MSG_PEEK) {
>>>+			if (ret == expected_ret) {
>
>On second thought, I think it would be more appropriate to check for
>`ret >= expected_ret` here, because all subsequent recv() will
>definitely return more bytes, so there’s no point in continuing the
>loop... and anyway, we’ll check the result later, so just that change
>should be fine.
>
>And of course I'd update the comment on top in this way:
>
>   * When MSG_PEEK is set, recv() is retried until it returns at least
>   * expected_ret bytes. The function returns on error, EOF, or timeout
>   * as usual.
>
>Thanks,
>Stefano
>

Good idea, will do.

Thanks!
Luigi

