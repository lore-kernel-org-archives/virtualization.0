Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357582E4241
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169535; cv=none; b=Qw94fZAmpJaHG8ClMNdk61tOKm+3Bt/LhzbGX8d5D8Z4etTeTfpqq5E3mto9typA4ylxlV0j4Wtm1uO5eo8amzCwko17Tpa5DEe7BbRMlR7zJLR2+yd/6dlqIAyJs+w/+qfPfvT38NBHMCpdBl8BcUPs4zQd/m9zUfYk74XdvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169535; c=relaxed/simple;
	bh=p01vA1PBCXZmwTD9ipYGalgea25sUjLAH06zPyyCzos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Py8sFi/o/R3+Tcwo16l8fv3FWeFHKNhwHcXdkrZnHGIhiw8cqc2HP39h3OxVW9bn2RzQQCZFLFoYMAzQpPyImkKUA1WoZAqG6bd+2BW6R3jP7W1k2h1WxSFn+1YbQmdjnb8eyahI0YINxzyw9aviy+ygGfHYS/7KehsF+aau7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKhai9B4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKhai9B4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750169532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tDQawTMiyaVh5j2oaJP/el64wEr3+7ENbyMBrC9glDw=;
	b=aKhai9B4nmPVauJAZv/+wn0p/niywjUrYwEcipRPvjWLyERTDlB061/XzOR/0T4sjALjMR
	LARs+n55Qt36EISiRRYlQklY8nKJheLPa+PN6Yd70X5f6yLXn2grRxk3A92UqEkPVM4OF4
	wbj6tdaa5PJudr6BD8aSxrcy2Pmp99k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-hSL1oQECNi2_TV8dFqPfTA-1; Tue, 17 Jun 2025 10:12:09 -0400
X-MC-Unique: hSL1oQECNi2_TV8dFqPfTA-1
X-Mimecast-MFC-AGG-ID: hSL1oQECNi2_TV8dFqPfTA_1750169528
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so32357245e9.0
        for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 07:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169528; x=1750774328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDQawTMiyaVh5j2oaJP/el64wEr3+7ENbyMBrC9glDw=;
        b=XsVtnZ1mCtA49Q8iItMsnTyGIENbO+ZZhQGgPsxcII4VBzXnHhY1+YRBv10Od6b3kp
         7jurZhttvHgy0IuVSUY1JStT0D+ddubvWt8NgCg460SvNSMH4CMTFmzo914v9Rt7TPCu
         ouAb2gsYLBdo5q509m7/NSoyRyQYCxLMzkCdNYK1JDszLuyt6EJ7iLR9JACwVcu4lsri
         tWFa6PprE448anqfb4Vp8Hketrs5ojMEw8b+fh9Aq+3CWC1TssKr6mmi8+LwvGlx2DWx
         TCzRClzvlhhiKOhspwd8MxsfbGRmlR01qDYutATfs9BSUV0YYIbdkCysa6rz8FnCURCY
         wc3Q==
X-Gm-Message-State: AOJu0Ywjrmv/e/vqoBA1+rpUkOgaUGygRRk6Ike/WsCzCFwCNGiAkfap
	wC2U3fKPeNqAP+WRxQl+F8KdF68VwQEuv9V3FULg7J9cOVH4mHKozpo1Dn9cLxQwuyd+A/M/0v4
	Jf3yvUoX4f2xFIruBWm4mTw1kWY4d/QTJVN3c3Z35PUGj1l+3mOnd+/cIc8WjTk0/BoXN
X-Gm-Gg: ASbGncvn3vIdnXQNT+Yxzp2PztQ9bzR+UD++I+MSsNopgOXx72w00cvyXz5e7yRuhWz
	w7fmzCTehZV705KcjMD/Tdb+wreHxDcMPpHbbNwfsv2LWA5xT0qtFOb2asNheZD7PQRgBGZXsCP
	tnq2tqvm2AvbMn17n2GV5oDk6jrjA5Q9l1Lh06nRxMhqbJAnQecTcLmLmspm5mInSE/V/IEZU1M
	NYExa66AClDLERXdE4Pj7J8MS1QFJhhx7JLMMt1Mb3hmtet7goD2KuDNp2s30x+BPDXIc5o2yzV
	ZE5kcFcAopXQuK2Oy5iJHD+tLE1V
X-Received: by 2002:a05:600c:1f94:b0:450:d019:263 with SMTP id 5b1f17b1804b1-4533cad3c9cmr144825145e9.18.1750169528363;
        Tue, 17 Jun 2025 07:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpOFjhK6ipEOxmVfRV3fbYV+dQY5pR+5sd2WS6/OERnStK2AUSFKitcs+M6aAjkClrM9e7nQ==
X-Received: by 2002:a05:600c:1f94:b0:450:d019:263 with SMTP id 5b1f17b1804b1-4533cad3c9cmr144824595e9.18.1750169527774;
        Tue, 17 Jun 2025 07:12:07 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e156e8dsm183349865e9.31.2025.06.17.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:12:06 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:12:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] vsock/test: Introduce get_transports()
Message-ID: <sbfcl6s233hmkry3ecq6rwzvpl2gw2z23g2dsymruetn436ou7@znv2hen5wkde>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
 <20250611-vsock-test-inc-cov-v3-2-5834060d9c20@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250611-vsock-test-inc-cov-v3-2-5834060d9c20@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PgF6mW15B9uhWXM8GPT33EU9wnUwjCQ--bfzUtpe49g_1750169528
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 11, 2025 at 09:56:51PM +0200, Michal Luczaj wrote:
>Return a bitmap of registered vsock transports. As guesstimated by grepping
>/proc/kallsyms (CONFIG_KALLSYMS=y) for known symbols of type `struct
>vsock_transport`, or `struct virtio_transport` in case the vsock_transport
>is embedded within.
>
>Note that the way `enum transport` and `transport_ksyms[]` are defined
>triggers checkpatch.pl:
>
>util.h:11: ERROR: Macros with complex values should be enclosed in parentheses
>util.h:20: ERROR: Macros with complex values should be enclosed in parentheses
>util.h:20: WARNING: Argument 'symbol' is not used in function-like macro
>util.h:28: WARNING: Argument 'name' is not used in function-like macro
>
>While commit 15d4734c7a58 ("checkpatch: qualify do-while-0 advice")
>suggests it is known that the ERRORs heuristics are insufficient, I can not
>find many other places where preprocessor is used in this
>checkpatch-unhappy fashion. Notable exception being bcachefs, e.g.
>fs/bcachefs/alloc_background_format.h. WARNINGs regarding unused macro
>arguments seem more common, e.g. __ASM_SEL in arch/x86/include/asm/asm.h.
>
>In other words, this might be unnecessarily complex. The same can be
>achieved by just telling human to keep the order:
>
>enum transport {
>	TRANSPORT_LOOPBACK = BIT(0),
>	TRANSPORT_VIRTIO = BIT(1),
>	TRANSPORT_VHOST = BIT(2),
>	TRANSPORT_VMCI = BIT(3),
>	TRANSPORT_HYPERV = BIT(4),
>	TRANSPORT_NUM = 5,
>};
>
> #define KSYM_ENTRY(sym) "d " sym "_transport"
>
>/* Keep `enum transport` order */
>static const char * const transport_ksyms[] = {
>	KSYM_ENTRY("loopback"),
>	KSYM_ENTRY("virtio"),
>	KSYM_ENTRY("vhost"),
>	KSYM_ENTRY("vmci"),
>	KSYM_ENTRY("vhs"),
>};
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
> tools/testing/vsock/util.h | 29 ++++++++++++++++++++++++
> 2 files changed, 85 insertions(+)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index b7b3fb2221c1682ecde58cf12e2f0b0ded1cff39..803f1e075b62228c25f9dffa1eff131b8072a06a 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -7,6 +7,7 @@
>  * Author: Stefan Hajnoczi <stefanha@redhat.com>
>  */
>
>+#include <ctype.h>
> #include <errno.h>
> #include <stdio.h>
> #include <stdint.h>
>@@ -23,6 +24,9 @@
> #include "control.h"
> #include "util.h"
>
>+#define KALLSYMS_PATH		"/proc/kallsyms"
>+#define KALLSYMS_LINE_LEN	512
>+
> /* Install signal handlers */
> void init_signals(void)
> {
>@@ -854,3 +858,55 @@ void enable_so_linger(int fd, int timeout)
> 		exit(EXIT_FAILURE);
> 	}
> }
>+
>+static int __get_transports(void)
>+{
>+	char buf[KALLSYMS_LINE_LEN];
>+	const char *ksym;
>+	int ret = 0;
>+	FILE *f;
>+
>+	f = fopen(KALLSYMS_PATH, "r");
>+	if (!f) {
>+		perror("Can't open " KALLSYMS_PATH);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	while (fgets(buf, sizeof(buf), f)) {
>+		char *match;
>+		int i;
>+
>+		assert(buf[strlen(buf) - 1] == '\n');
>+
>+		for (i = 0; i < TRANSPORT_NUM; ++i) {
>+			if (ret & BIT(i))
>+				continue;
>+
>+			/* Match should be followed by '\t' or '\n'.
>+			 * See kallsyms.c:s_show().
>+			 */
>+			ksym = transport_ksyms[i];
>+			match = strstr(buf, ksym);
>+			if (match && isspace(match[strlen(ksym)])) {
>+				ret |= BIT(i);
>+				break;
>+			}
>+		}
>+	}
>+
>+	fclose(f);
>+	return ret;
>+}
>+
>+/* Return integer with TRANSPORT_* bit set for every (known) registered vsock
>+ * transport.
>+ */
>+int get_transports(void)
>+{
>+	static int tr = -1;
>+
>+	if (tr == -1)
>+		tr = __get_transports();
>+
>+	return tr;
>+}
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 0afe7cbae12e5194172c639ccfbeb8b81f7c25ac..71895192cc02313bf52784e2f77aa3b0c28a0c94 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -3,8 +3,36 @@
> #define UTIL_H
>
> #include <sys/socket.h>
>+#include <linux/bitops.h>
>+#include <linux/kernel.h>
> #include <linux/vm_sockets.h>
>
>+/* All known vsock transports, see callers of vsock_core_register() */
>+#define KNOWN_TRANSPORTS(x)		\
>+	x(LOOPBACK, "loopback")		\
>+	x(VIRTIO, "virtio")		\
>+	x(VHOST, "vhost")		\
>+	x(VMCI, "vmci")			\
>+	x(HYPERV, "hvs")
>+
>+enum transport {
>+	TRANSPORT_COUNTER_BASE = __COUNTER__ + 1,
>+	#define x(name, symbol)		\
>+		TRANSPORT_##name = BIT(__COUNTER__ - TRANSPORT_COUNTER_BASE),
>+	KNOWN_TRANSPORTS(x)
>+	TRANSPORT_NUM = __COUNTER__ - TRANSPORT_COUNTER_BASE,
>+	#undef x
>+};
>+
>+static const char * const transport_ksyms[] = {
>+	#define x(name, symbol) "d " symbol "_transport",
>+	KNOWN_TRANSPORTS(x)
>+	#undef x
>+};
>+
>+static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
>+static_assert(BITS_PER_TYPE(int) >= TRANSPORT_NUM);
>+
> /* Tests can either run as the client or the server */
> enum test_mode {
> 	TEST_MODE_UNSET,
>@@ -82,4 +110,5 @@ void setsockopt_timeval_check(int fd, int level, int optname,
> 			      struct timeval val, char const *errmsg);
> void enable_so_zerocopy_check(int fd);
> void enable_so_linger(int fd, int timeout);
>+int get_transports(void);
> #endif /* UTIL_H */
>
>-- 
>2.49.0
>

