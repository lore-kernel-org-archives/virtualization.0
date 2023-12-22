Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3817F4
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 03:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0FC034037C
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 03:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FC034037C
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lv_yvOr0uTK7
	for <virtualization@lists.linux-foundation.org>;
	Fri, 22 Dec 2023 03:33:50 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65F39402C3
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Dec 2023 03:33:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65F39402C3
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rGWIB-00Dgpy-KJ; Fri, 22 Dec 2023 11:33:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Dec 2023 11:33:54 +0800
Date: Fri, 22 Dec 2023 11:33:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Gonglei <arei.gonglei@huawei.com>
Cc: linux-crypto@vger.kernel.org, mst@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, lixiao91@huawei.com,
	wangyangxin <wangyangxin1@huawei.com>
Subject: Re: [PATCH 2/2] crypto: virtio-crypto: Fix gcc check warnings
Message-ID: <ZYUDop1Cv1ddrqQf@gondor.apana.org.au>
References: <1702294936-61080-1-git-send-email-arei.gonglei@huawei.com>
 <1702294936-61080-3-git-send-email-arei.gonglei@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702294936-61080-3-git-send-email-arei.gonglei@huawei.com>

On Mon, Dec 11, 2023 at 07:42:16PM +0800, Gonglei wrote:
>
>  static inline int virtio_crypto_get_current_node(void)
>  {
> -	int cpu, node;
> +	int node;
>  
> -	cpu = get_cpu();
> -	node = topology_physical_package_id(cpu);
> +	node = topology_physical_package_id(get_cpu());

This looks like a bogus warning.  I think we should do something
like this instead:

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index ae81a7191c1c..0cb43986061b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -191,7 +191,7 @@ DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 #define cpu_data(cpu)		per_cpu(cpu_info, cpu)
 #else
 #define cpu_info		boot_cpu_data
-#define cpu_data(cpu)		boot_cpu_data
+#define cpu_data(cpu)		((void)cpu, boot_cpu_data)
 #endif
 
 extern const struct seq_operations cpuinfo_op;

Please send this patch to the x86 people.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
