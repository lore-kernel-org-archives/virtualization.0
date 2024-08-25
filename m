Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9713DDA7
	for <virtualization@lists.linux-foundation.org>; Sun, 25 Aug 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593917; cv=none; b=K/FhNHyOa7ZNO2fy0hf48/7E651mirIY7WHAKrvWZh6UDqB8EPCxMPuaPUWfPiJ6Cla3Kh74BdKrh9oCh7pSMJBvuHjCMU1QAyMRIxDM+vmWAHRQe8o9bWLryqIJ9+5MBQqY2zvBGQKwCXbQvqRXsICDVu7+b8X423LEe/A2w9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593917; c=relaxed/simple;
	bh=cxEMb15cvEJg1PIhEqMrDmascCh1VmMYsmZCf7+60cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTzcY/Hx1Fiz4I/XkqOnRVzVeCV8rIDnJu52E/Et5cIpFgM/9mAwF74+zomwDJvb1pxKDOXt0meNg2rcBJva8G5SnEnMZp0zJiayc3xGSbzOdlnLP3g7Wa/8nIj8Ee0i5HoApwkQKSdN2Kb95M2WxHBTKn8zzUgn5zs9zi1nsUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaWLpZmp; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaWLpZmp"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEF02810C9
	for <virtualization@lists.linux-foundation.org>; Sun, 25 Aug 2024 13:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uV_yn6HWMPxO for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Aug 2024 13:51:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F1C9E810C8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1C9E810C8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XaWLpZmp
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F1C9E810C8
	for <virtualization@lists.linux-foundation.org>; Sun, 25 Aug 2024 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724593913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cxEMb15cvEJg1PIhEqMrDmascCh1VmMYsmZCf7+60cw=;
	b=XaWLpZmpzLUZFRsCCVBoGsu7zuafa9vwNJG63X661Jo3lLKMTT2xOolDRSu993No5mJcXF
	TZyVAIWAkr8Qvqc2uDw3jXIR9AkgGIaEyo3akR/CyzBlB/I28EdnYAdsIKOWIp6/TMHNeM
	yra9q/TH1abzPDOkzUAAl31hV4eZQYQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-mTUHUepeMZ20BqvsgaSXlA-1; Sun, 25 Aug 2024 09:51:51 -0400
X-MC-Unique: mTUHUepeMZ20BqvsgaSXlA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-371845055aaso2100014f8f.3
        for <virtualization@lists.linux-foundation.org>; Sun, 25 Aug 2024 06:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724593910; x=1725198710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxEMb15cvEJg1PIhEqMrDmascCh1VmMYsmZCf7+60cw=;
        b=AtSwkjbKunTTDnlYuIciPzSiHxbUGnRQ2aQHLnmdbBDlc6GQvsM0sJGQQZ2d3gzZNM
         f3wdoETT2IG+tEzb2Ase5+GSo2qpNmFES0rOK+MxavDT6W5lS4DuMc4vaq1eZwchXo8C
         kjSmnRta6lxX6pMu/dwnyHvd8n7ZjRruuK5ZaLnEzAn0vJgp36Ot86dBe+NzrdQ3926f
         /eYYAUTqTQMKzC8S3RH7uhXmvXtcqYhepQ7AdIRFvxYwAH7TXziPJrq+dq9Ekfv7aC3M
         RhdVSNTMt4niKAKAbGGU8usahUvUAi4Q09TSYPGbABraYhK6D67wXO3bsDNhv9gn8dMt
         wfeA==
X-Forwarded-Encrypted: i=1; AJvYcCWEmTFCcv0/rqk62KCqmOXb2JDvZRoqVDmyZi+Apz52RQ/tIGaBxB259tebVM1X4L2J9C7rmF5eHVD1ar/BOg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yyn/oF2eE3DdtXQDq/fPqIRapIB1xgLN3tIGie+VqjKVsZwO9Jt
	9Ie5pVc/sTv5W4WHGJwMa0zF8sEcTYKP3EMZTNfRc3yQjQf1kylvm/IoXcbZjNbLQ57h0BKtqxc
	GzVr4cp2CwV0YkLBwsUq0db9iBWR689XocnP/ezcUehsr9QgEhhr/lWpMvK1ZExPH9cHNb/EA0r
	Dt0wllv8oDiF3CJqBCusKekpya23E12Hqev/mGNQIDKnkGb5aQX+4sOA==
X-Received: by 2002:a5d:6247:0:b0:371:8d47:c17b with SMTP id ffacd0b85a97d-373118b8b17mr4459168f8f.30.1724593910364;
        Sun, 25 Aug 2024 06:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO5Rt2ZGQtty1SlsmajcJ+wRy/l+/mv03lE2W14jpsoR7vK/6p6UGJpKH8n5n/fwUQIRtgECnR6MJjKUVjvz0=
X-Received: by 2002:a5d:6247:0:b0:371:8d47:c17b with SMTP id
 ffacd0b85a97d-373118b8b17mr4459156f8f.30.1724593909881; Sun, 25 Aug 2024
 06:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
 <ZsV17ACIEelIQuKx@infradead.org>
In-Reply-To: <ZsV17ACIEelIQuKx@infradead.org>
From: Cindy Lu <lulu@redhat.com>
Date: Sun, 25 Aug 2024 21:51:13 +0800
Message-ID: <CACLfguX6-q3=ydUsCcaPsS42NiOph6j0zNHVrmpMk2zcMgwQrA@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Christoph Hellwig <hch@infradead.org>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 13:07, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 19, 2024 at 05:27:33PM +0800, Cindy Lu wrote:
> > Add a new UAPI to support setting the vhost device to
> > use kthread mode. The user space application needs to use
> > VHOST_SET_USE_KTHREAD to set the mode. This setting must
> > be set before VHOST_SET_OWNER is set.
>
> Usage of an API is a complete kernel internal detail that has absolutely
> no business being exposed to applications.
>
> What is the application visible behavior that the API use is the proxy
> for?
>
The userspace application may need to know the details of the kernel.
For example, some userspaces may use a script to track threads. If
they use task mode, the script may not work properly. In that case,
they can choose Kthread mode.
Thanks
Cindy
>

