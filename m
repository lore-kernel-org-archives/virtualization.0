Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD691849C
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270071; cv=none; b=e4advwc4Ps5Te6atMo6t4fPRkN2/qaXJB4dI1UODUO/gJ6ofkaIx6wrUSB/19ZJQlWh66SEyiL2tFja9i5vd4Or/s9Kestk3kO9dJwyoHUprAUeurR30wxN/dMohCpjtPd3rzcHrhj/gY2qn2Rt1v5jVoHruD3Yjtj9A8siDMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270071; c=relaxed/simple;
	bh=Qu4BKUUZZQUC3bM147FV56y9K9VT5HonDkFSvdwo1nU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y5Z5enk0LLcIMCAhFIoMjmV32A8vVkuwh6nYEJnWjI6RKWF9sp/FInwL2xhku43tX1D8w2SB/q0xfhra+IqK/I8QGJG4/nywYUF/wnE2kYvtL8xExBZ4TPIgdr8KUDmnWXgqUkfUaGIbZFihHJ08w8oc5xRYxObGEG3XyGXS5Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b80HX/iz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b80HX/iz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23633a6ac50so51123395ad.2
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751270069; x=1751874869; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2husDRPyYglRpELzS6mWxDDH6zO8JWO9HlqXQ8aytvQ=;
        b=b80HX/iz+G9/11ogo9yKW31Wd4nJnGi35BP0JdSQZTBrjsN3xmkN+hGMCNSjU2xPh+
         8mHd2/St3Y3HNED56nFlliIzdSv8z469Bf9LlzZVAXAsYKHuibQbp/9JaHE1Lq0KWNFV
         msNfZpbDfv6CSv1z+i0YRrGzo9gnvnWkg23uTbwh8Ie5EKmvoUHVObpgHGxblJJhVMJ5
         YDLLuHb9KhOE3EwFZncWKIdC+sa6wI0BmFW6EJ/cu95p1jMM46jIb927fFYtt4fenIt0
         GK2kE2DW9FlVZjxa9ci018ewNlX39vZRT5aNox1bZeO0lDyjigQkMGl9YlbHYswlF0C3
         tE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270069; x=1751874869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2husDRPyYglRpELzS6mWxDDH6zO8JWO9HlqXQ8aytvQ=;
        b=iN+PHBQ8a5mIJqXvC45eFudhWMgfGwRZWNpLSCrke40rCbmXheTMrDRVUhR8ZtTBwx
         BZ7IWTc8UfyB9ucNgdyjH6aoiVZhuHvjNAIM4PhywhmuGpk0UpgxdkE6qutRG/j9W4ks
         YT1UYlDRuZtDVO7GTeQxk9maml4DilH/Jk+EvcN/G7JcliwyRj3eIi7O2x4DamoAysQx
         V/toVPjXHQ1WtsM/ivIcD8iXx9mBic/P5hoVCedOupIY9swqP5eNetByS28LdDqNRptO
         /BHi0eNTzhSBlpViqqqc3q/lw6+5yrRcqjMvTxAayvot2imFC4QDrKHBy+OdXLW8yLrC
         I10Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzB1rW638bDwoANgtPDpVa08QpNQWqTqTNtFrgU4P3W9YDZuMRLIYJT7XsExm3wtAofpPm+7ElL0LTXFFuWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb5TnuenyzQEYB8dZK3q6R6JxUUirdnRP03n0HK/sJyluRX5fl
	KU3IL4CfLMTfa2/WXxC57msCKf6W+Mv227Ri5pl+s/x2XBtJHQTlwwVT
X-Gm-Gg: ASbGncvqMdxgl6FszNreWnkJtS3jo3XcZPN/9R+D4n+VqS2uMELVxrmejSa2A+FSywL
	xOFXW+IEfTFOM5keTOdueXeutHusIum6dKzSyJW1HnfbVe/IYBRk1Y1CNR/SA6Nk62oAEecqvrL
	2wV/1LqXb7QLUy9EYek43Az/+SnYJ8OSC2zeo3GE3AWHJY1oq4CFaIq9USeJWOyDzoOmsR3MRtm
	DHZKPIJVJ9gK8of3+5rGnFeUkYkRIliZMLHDnESMlsK64wn3L+s3Ch/7fBB9zzAW4pRtIlhKOyj
	xeQKGTK5CIvqLRc7N90fCw5py3z+ZH74rtqLjNy6JwWV630bn7WGJUt7TyyrtDgFHZWZO+l52dk
	qFlGluWHA
X-Google-Smtp-Source: AGHT+IEZr3xbQKLTkP0IjxZrSMRNxBeFyMR2/3Jbw4FnoAZ37eaI6AARNvB9QQwQ1MQVoMMLZszg1A==
X-Received: by 2002:a17:902:e746:b0:234:d292:be7a with SMTP id d9443c01a7336-23ac3bffdbdmr186477195ad.1.1751270069004;
        Mon, 30 Jun 2025 00:54:29 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f544050csm13450541a91.42.2025.06.30.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:54:28 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	decui@microsoft.com,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	leonardi@redhat.com,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next v4 0/3] vsock: Introduce SIOCINQ ioctl support
Date: Mon, 30 Jun 2025 15:54:11 +0800
Message-Id: <20250630075411.209928-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <gv5ovr6b4jsesqkrojp7xqd6ihgnxdycmohydbndligdjfrotz@bdauudix7zoq>
References: <gv5ovr6b4jsesqkrojp7xqd6ihgnxdycmohydbndligdjfrotz@bdauudix7zoq>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Mon, Jun 30, 2025 at 03:38:24PM +0800, Xuewei Niu wrote:
> >Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
> >bytes.
> 
> I think something went wrong with this version of the series, because I 
> don't see the patch introducing support for SIOCINQ ioctl in af_vsock.c, 
> or did I miss something?

Oh yes. Since adding a patch for hyper-v, I forgot to update the `git
format-patch` command...

Please ignore this patchset and I'll resend a new one.

Thanks,
Xuewei

> >Similar with SIOCOUTQ ioctl, the information is transport-dependent.
> >
> >The first patch adds SIOCINQ ioctl support in AF_VSOCK.
> >
> >Thanks to @dexuan, the second patch is to fix the issue where hyper-v
> >`hvs_stream_has_data()` doesn't return the readable bytes.
> >
> >The third patch wraps the ioctl into `ioctl_int()`, which implements a
> >retry mechanism to prevent immediate failure.
> >
> >The last one adds two test cases to check the functionality. The changes
> >have been tested, and the results are as expected.
> >
> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >
> >--
> >
> >v1->v2:
> >https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
> >- Use net-next tree.
> >- Reuse `rx_bytes` to count unread bytes.
> >- Wrap ioctl syscall with an int pointer argument to implement a retry
> >  mechanism.
> >
> >v2->v3:
> >https://lore.kernel.org/netdev/20250613031152.1076725-1-niuxuewei.nxw@antgroup.com/
> >- Update commit messages following the guidelines
> >- Remove `unread_bytes` callback and reuse `vsock_stream_has_data()`
> >- Move the tests to the end of array
> >- Split the refactoring patch
> >- Include <sys/ioctl.h> in the util.c
> >
> >v3->v4:
> >https://lore.kernel.org/netdev/20250617045347.1233128-1-niuxuewei.nxw@antgroup.com/
> >- Hyper-v `hvs_stream_has_data()` returns the readable bytes
> >- Skip testing the null value for `actual` (int pointer)
> >- Rename `ioctl_int()` to `vsock_ioctl_int()`
> >- Fix a typo and a format issue in comments
> >- Remove the `RECEIVED` barrier.
> >- The return type of `vsock_ioctl_int()` has been changed to bool
> >
> >Xuewei Niu (3):
> >  hv_sock: Return the readable bytes in hvs_stream_has_data()
> >  test/vsock: Add retry mechanism to ioctl wrapper
> >  test/vsock: Add ioctl SIOCINQ tests
> >
> > net/vmw_vsock/hyperv_transport.c | 16 +++++--
> > tools/testing/vsock/util.c       | 32 +++++++++----
> > tools/testing/vsock/util.h       |  1 +
> > tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
> > 4 files changed, 117 insertions(+), 12 deletions(-)
> >
> >-- 
> >2.34.1
> >
