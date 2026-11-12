Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480835;
	b=aBbcGvTawseX2aG18UgPaPxOol0KI9C/VroYFSSH/99LLy1180j0MYg5xSWc7RMFBMQU
	 QSV1Ix01BQMzo6fqSN6TeD26k8Y6uuYf/X9Bt6PDCPrRdj5hT0lvPDsCy7/cf3MGCiC7u
	 cPtorOAkZEHPx7gLLtcz03GerhfDGlhaVTypSFJw3xlRZPnFa0Xo0ikDRbODXG0VJlTxM
	 hGUvSltrspbuGsDy1NeL3sOAbu47LMXyBd0rwwNeuwkXaTr09XYdTWpWA2jCHRfVXbsOb
	 cpbRTUrMNfXoD8zQ3nApJsN6m3P0b0uDA6f2JTq2wGUrx1g4fBZPQDZyFAeLpdCil5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480835;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
	b=exwqTKOySkY8zGtDdklwjjg128joXbDmcgsQJXdSmn7YBF1CEqccbaqXNHH/fLsoor/u
	 h7x60/yQxjE/fQmYCx6a1+TkjT+Cjppdyzf/RzwYjGKFVSwGI02rl1tCx1twb+KuNZkNn
	 U+Mc1n3B/+x2RUpD0roFQCiuuqA8ghQiqHms3MtK4KxhgV5Jl9xg15lkSWuZiKhrqZfqq
	 xFUhUJ+RZdoZMjIhSJqH5i535ONnglsRVj70FwucWVceJ2WmYxdwPB0FFjd4nL+ZWKzdJ
	 JcqGq2tg6QXRw0GZFy0n5Z9ADiw43UxIKN+HdWVFc9v5IS/9Z8eqv7m9HtkTakwWgag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbIsmZyd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D501606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 10:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D501606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbIsmZyd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794480834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
	b=gbIsmZyd951GkYAeuc5ZVvZPM6iBmnW+NSEqvDeWCvQAXHsX3ABjnR0P4lGihKq90YfK6Q
	muIHNQdA/M0Q1Y76+xl/OBmt0j83U64zG185sJiLibkqkTSIltYKflwrqnOukKVyKoCKs/
	u1a6BAw5KImAlk18fDj78C4Fx2PVzbU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-Zisj6wVzMZWOHwOrkgosmQ-1; Thu, 12 Nov 2026 05:53:52 -0500
X-MC-Unique: Zisj6wVzMZWOHwOrkgosmQ-1
X-Mimecast-MFC-AGG-ID: Zisj6wVzMZWOHwOrkgosmQ_1794480831
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48df02b91f9so389030f8f.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 02:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480831; x=1795085631;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
        b=EW8uKWv1hFamhT1JKxUnbDOKxpIssR0mw35TNjhGyFn/VKoHgJmVaL8WZI2Le6Hivn
         um59jCj9fByQA7K2rlMsK2wbUH4QxwSN33tCd++qtvgXb9qUX3TJ3KtWmNoUgpZzL7r6
         48fSgSpAiObECc8miwxPtLMcWCGnlfwninDfJJlFq0rPXCltYqPNGfggp3F3jy3UldaQ
         m3sll/zoyBshyTWKkSeE945rGG92y/05BR83wIaXicWPxESG4dKJWj2SYTP0/dKKs1BY
         u/w6KzSRkZMz/arKtmg4tMT92etLj6Sn/IKN3lUo86vrnVfgcSH1mVLemU/ky/W8Jpij
         H8hw==
X-Forwarded-Encrypted: i=1; AL+hErFSUXoP9wiWSjING3A0y2qATwJH00QmaweWIGD76jTdqAOcdD/IIJHmVdMV49VtU552gsfv93JW1gVB3EbSmA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8SXY8VpGayaCg2KUJNCqpN727EQhmGXf60Sr78jq2Ks4D4Mw7N
	VNbg1LcWI1Mjz5Vs6qbYMpozD0kIZ74J7BMmX94z++FyCHmaxvniNPSktV6nlKKW0H5zbboeZcX
	CLKCt3/+R//jPTaIJmRyxbU5H2qKv3v5kG0ShJYIwvqvf8otdF2DLDXs/ra5Dfm3TR6/R
X-Gm-Gg: AYBFou3CjQsjmKFAf8NtmqUVwRfQtG1N1ZBLU17QmiTevBsyXRcIKqXud+HhuInx0Ep
	tFtIVwsuPjMtE0s1avmjr79VqXUIkSOC/ivhjgL7bejOjqYpmVC5FzKA12phncUT4jwG2ZmdGW5
	Vv39jJt1/M32S/qUxKwx/dCJ4QQzmf+KmAvJHVo9evRORjHF7KtkLdpMqb/lX/RU0YolGW/O3Fu
	Alq9RkMtkHbqADp2bnbR663PTlY6Qm8LQcbH7fQTkJymkpNHvyzNueirD3VVUlHB9f5aaksGyIR
	1ImiDs0JZD1KMTuXQgdFabV1vxy5+mbSOp7WoNVGIuyL+MdNJGJamOAMbNle05wHlPPo1TlWGIj
	IuVfod6FxzAfsdouZeUIW6rNV5LwcUjyTokeIuI26mw==
X-Received: by 2002:a05:6000:4211:b0:498:364d:7509 with SMTP id ffacd0b85a97d-49b02d4cd48mr4648428f8f.24.1794480831226;
        Thu, 12 Nov 2026 02:53:51 -0800 (PST)
X-Received: by 2002:a05:6000:4211:b0:498:364d:7509 with SMTP id ffacd0b85a97d-49b02d4cd48mr4648361f8f.24.1794480830624;
        Thu, 12 Nov 2026 02:53:50 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbeedsm15992928f8f.43.2026.11.12.02.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:53:49 -0800 (PST)
Date: Thu, 12 Nov 2026 05:53:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Khan Zhao <zhaoguohan@kylinos.cn>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH RFC] vhost: set dirty log bits without pinning pages on x86
Message-ID: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KWlFj-4RznqeYN7sVZwvWyZWzLZ9hwxSDWPyLC62nnU_1794480831
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

vhost had a TODO to replace page pinning with a version
of set_bit that works on userspace memory, since forever.

It is really best to avoid GUP on fast path entirely.
Implement set_user_bit and use it in vhost, to do just that.

Should not be too hard for non-x86 too.

Reported-by: Khan Zhao <zhaoguohan@kylinos.cn>
Link: https://lore.kernel.org/all/20261112085631.128819-1-zhaoguohan@kylinos.cn/
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---


lightly tested. pls test and resubmit with your tool.

 arch/x86/include/asm/uaccess.h | 18 ++++++++++++++++++
 drivers/vhost/vhost.c          |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..ba1e7c3f83c8e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,24 @@ _label:									\
 	__ret;								\
 							})
 
+/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = 0;							\
+	__uaccess_begin();						\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : [errout] "=r" (__err),				\
+		       [ptr] "+m" (*(u8 __user *)(addr))		\
+		     : [mask] "q" ((unsigned char)BIT(nr))		\
+		     : "memory", "cc");				\
+	__uaccess_end();						\
+	__err ? -EFAULT : 0;						\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2f2c45d208832..9ba16cbd788cc 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2405,6 +2405,12 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
 
+#ifdef CONFIG_X86
+static int set_bit_to_user(int nr, void __user *addr)
+{
+	return set_bit_user(nr, addr);
+}
+#else
 /* TODO: This is really inefficient.  We need something like get_user()
  * (instruction directly accesses the data, with an exception table entry
  * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
@@ -2427,6 +2433,7 @@ static int set_bit_to_user(int nr, void __user *addr)
 	unpin_user_pages_dirty_lock(&page, 1, true);
 	return 0;
 }
+#endif /* CONFIG_X86 */
 
 static int log_write(void __user *log_base,
 		     u64 write_address, u64 write_length)
-- 
MST

