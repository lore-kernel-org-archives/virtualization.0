Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AC175D39
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232377; cv=none; b=TYTQxYAnICoLHjMHcJosi2JqJvVUx5LdKDwdCJfIphqHf17Qa//sMrkoSQ0LDVxX547N/e3qFwnPJgb26AMF/Ll4/XalrJ9dTFwEX+NHZrqi6kmhN1hyxZ+CjC8hOB4/YGFn2ypdmWH8xytQKxsL+P5Upzx0Tnh/oal9S5x+dLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232377; c=relaxed/simple;
	bh=wHZtwYVBdWmnMUx0cwwuokgFALLF/00lQUCEl6373K4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qibI7PVVKTRrpu1GvT7tu4X9c9zacfMIZr1zj0nXz9QC6wILyHPp8o/1yy+dAA70nXKm5kCXELyDtVWlbXbfXWEXNZouEWdZHXduXbovxp2t+bgA3HI/Gez2GuaTTs5zR3prWGI5miiWR8OadIwN26Xk5Rb7O6IatBEoAMkla6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkskWFCl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkskWFCl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uRB4qyyeZ6d2cPqOCAW0MqMh5plkjaYv5Rx4lmPx+E4=;
	b=EkskWFClcBMMBuvKPaXGBQgM3vI6jqnY3239jd9eemWTS4DveXhoXw6bz2qXplKjJQjTYM
	fJFl3XRUvfwyW/PS2S0PUQLC6z1jT+NhPiUASDMPqHsTaVHjGWl3pKQWoJNLD417qvhgCd
	HARJLAtTpu41pPFBII4n88V8Y3Tvh18=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-jZN3tk_gPriZOFl2-bqong-1; Wed, 14 May 2025 10:19:33 -0400
X-MC-Unique: jZN3tk_gPriZOFl2-bqong-1
X-Mimecast-MFC-AGG-ID: jZN3tk_gPriZOFl2-bqong_1747232372
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so42329875e9.2
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 07:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232372; x=1747837172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRB4qyyeZ6d2cPqOCAW0MqMh5plkjaYv5Rx4lmPx+E4=;
        b=lpEo8EFnhV4uGtJMEmfYmjLEDqUdqvIvKRh+CvgQa/zk5JRrwztdfrVvaerd+WNYBL
         9JtwKa1XdZo3gxJbPSDbiFNuNdkgNnKMBuxlXxTP2zqeUFwSqarNnLfVd9s4hZa7Qv9t
         uw4wGRYr5MXO92elG0gqsj/8jGcJafd9dqfoimPBn70sYQk/ZqwOstwTxCO5cdisOh0y
         aNYOtm8mFgfy1fwTbZHkQSxxLp21x5o6Xynos4N/l7WKA/c8IyePrryyTT8IHIf4Lc+k
         gsip286kCXx2BkFMlvdip72v8eGANMmqi95GPS/W+KtlftpjenQbxVRdeG50xdRK4ez3
         92vQ==
X-Gm-Message-State: AOJu0YwKGJtE4qllunly0FmmzM9IEgX+dKKvAqgAI64OhMjMd4vgeDIr
	saAPSHWVMcRrfFAmLFXvKKI+gmM+da2hxs3vzz9WEWGFPmrQipZxjv2xqABPwJmXnxH3itya2HK
	usuQpIoNACoC+mHrK2JliD3msuoT6kcFKmxQYgX9SOR0+uhj3wLcEZJxEvXcOlvAI
X-Gm-Gg: ASbGncv/pV+n27lNSJY2uERHXZcySLYxEPVZTjdKyX1fCKvkaey5JxGOTRrUAbOBKI6
	oCQVD/u1YYn3ZpoholINsvJkLJR4obo4NkIfuhE39hQvpX+1LuH/X4e0wkypkkwZWGhTamoCIO3
	4bp5UQSAJm08+WilmdT5o5SxwJ0RFZGjrjxGjT+Yj35MJDZN3LUB2oj+plUarPeZRh+SuAshrLA
	U4sdvf8hfadX+g3fVghs7kR0bRzT3us3TBt+Zy4SHuJ9q/aphkSCdO5dq0VaMFCgzx4VUVhMTOU
	Ax/T9aDylrPiUbfOWg==
X-Received: by 2002:a05:600c:c0c3:10b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-442f217983bmr24467815e9.31.1747232372361;
        Wed, 14 May 2025 07:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZQdAMWLppZvJZaxFmIVmRmAM7GRP6r6dCT4sSkMl77fpFp0Bh3DH3ymMTUNtVtBMPIQvRow==
X-Received: by 2002:a05:600c:c0c3:10b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-442f217983bmr24467415e9.31.1747232371811;
        Wed, 14 May 2025 07:19:31 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.203.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ec98dsm19667975f8f.25.2025.05.14.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:19:31 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] vsock/test: improve sigpipe test reliability
Date: Wed, 14 May 2025 16:19:24 +0200
Message-ID: <20250514141927.159456-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OJrf00XlTEpJYptEi9zMjEqo1uqGeb3Ssb456e1uC7g_1747232372
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Running the tests continuously I noticed that sometimes the sigpipe
test would fail due to a race between the control message of the test
and the vsock transport messages.

While I was at it I also improved the test by checking the errno we
expect.

Changelog:
v2:
- added a patch to provide timeout_usleep() and avoid issues with signals
  in timeout section
- add little sleep to avoid flooding the other peer [Paolo]
- fixed loop exit condition [Paolo]

v1: https://lore.kernel.org/netdev/20250508142005.135857-1-sgarzare@redhat.com/

Stefano Garzarella (3):
  vsock/test: add timeout_usleep() to allow sleeping in timeout sections
  vsock/test: retry send() to avoid occasional failure in sigpipe test
  vsock/test: check also expected errno on sigpipe test

 tools/testing/vsock/timeout.h    |  1 +
 tools/testing/vsock/timeout.c    | 18 +++++++++++++
 tools/testing/vsock/vsock_test.c | 46 ++++++++++++++++++++++++++------
 3 files changed, 57 insertions(+), 8 deletions(-)

-- 
2.49.0

