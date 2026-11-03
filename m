Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740470;
	b=Ais3SaDj+cvHbuVUcouErEw6u95OdJgPnf8j4msvYcEcaih3tEDSfFqeCU3fuEZtoWyw
	 SSfMpNDY0cZ8WjGyBAu3f7lXDXmS0wT+afZPji6m20KDJsMmZgbNlWqM6oTjlZTCVnYtc
	 zDhAWaJqwRO03nh3pPgDhHpJDiloQZyGce4tmAF2G20MxDJdZDcSR3LGt6We7qFuSmKvT
	 2Wh6QCdl4nUZEB4SFDV8LEc8VOY6n0xnlEVpO0waIwsyMCr8lNMU76/RfX0DFtcST6cr8
	 bAGZBgb23tOwV6ERlS2Z0rx037VvUdH7ITFI4Y2BdFELKPoPVMN9uCpyHwaH5lFmnIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Mqx62j/MS4Vpw2prk2XGbtfQUzR6R3P7OHsZIxuKjsE=;
	b=chgNZgh5i6ZqaDisLQew+wr8jepwhSA13Y0+u/IwIC3rmFrx07lrQuKIXpaIUhrDCSxj
	 UkNyvHuu4yZuPNpuQu6kCDDj7rYN1gbMICHq+EyrVfFF/hUmpZVyFgipUuEkpEvH1fDPu
	 I++3Wi4rjRknpD9YZHmSu86fteGC22yA1s2eeOde6G4LM8zRvPrStIK+54XkrMgNsqy73
	 u/NTEnhkXqHq5zEtAyY1YgqcoszzVXmLZjIGviiKd2xATQi1BJ3cujkA0oznvcL2c6AUG
	 cgSd9RUG7HjyZRxrV48nVVSJeN7tzZZcPCkohh+Wtvb2iAyECgIXM3ijNc/s7P4rr+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MbzAie5B;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EAE606D82D
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 21:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12EAE606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MbzAie5B
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3698bd5392cso1000979eec.1
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 13:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793740469; x=1794345269; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mqx62j/MS4Vpw2prk2XGbtfQUzR6R3P7OHsZIxuKjsE=;
        b=MbzAie5BFuEONZ8D60DzG+Eu/K0KWiYvnZLEKWRIs3AxKMUG6K8COq8uaKndPVl94k
         DTfsNDxw75ogqbtEUTg2DJKOKwnTiNFJ7RF4RR2kmu7PBOQuiDEqgO+cLFQuaG+Gg3MS
         Ukil3N/cSaFlHHyw+ndhHVXV1eLDc8116onqm1qJoJkukLTylNOc/zUe7D/qyOvnxDR7
         ajP5OlAdF7CpEzUsJjBFSoxXUYVRheeEwM58uTC+IN8xH8hIoTc5Ok+oMUE3bCSRQlU9
         7iJwYTNJM9u5A3Vs9bPywVVGSwk/Mh37EJlmlmsvf8vBDrbZytEHzdThTjaAV52VkF2n
         w+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793740469; x=1794345269;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mqx62j/MS4Vpw2prk2XGbtfQUzR6R3P7OHsZIxuKjsE=;
        b=GIfMNsEFjQ44NNuMn/7In+HdJNyKIrLAhpTuwVD+NT/iOX/n3uQIsDNYkVTjDr/B5p
         XG3y6OIBGFrvieXRkibq6FZ+Ta3g1M1JMju7oiCazDJ0tecNDYPEK2s/tBS0CsPdSAby
         +5aqVmjfpKMEp2AWfvATFk5ATh1k990d1+pmhhGbLrHqqZcm5l2Bim+ACU/uHIGX+y7h
         H2/i9s82WCfkwo6CcYtYR/MBnGNdKZRvPes33rM2c+ouKOPHU/3raW5fL76HHqQQQBwY
         FwhTqhcCKVPlAFe0s/JgcAkRLSUdgLGxblbQa8AF0N48ML1asMQnfc/Ya+3th8KN84vk
         Ss/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxXCgX6EAp89GkkQmHwYvm+T9yoGLZoiCPDnDWgANBYyrU0Gcwl7fvefy/MOrvf8Eq9ZkoLHw4xfhL1tafkvQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9JIV/Jh0XM/Mfzb+yxRgsHKOE5AmOMOmEK9U80j5wd8KkTPeAK
	LjxVUrCBDYIBEVRecP6V7HY69RxLvE5taYo5O4qpZpNzpFQWGoCmjQieoU+HEfbLlbYU5Vsy4SG
	HeqSZryr/Qkpl9Lyni864r9lrNg==
X-Received: from dycmb15-n2.prod.google.com ([2002:a05:693c:20cf:20b0:369:f67f:7a43])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:20d2:20b0:368:2c6d:ddfe with SMTP id 5a478bee46e88-36a30008535mr24191511eec.9.1793740468575;
 Tue, 03 Nov 2026 13:14:28 -0800 (PST)
Date: Tue,  3 Nov 2026 21:14:21 +0000
In-Reply-To: <20261103211424.127627-1-almasrymina@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261103211424.127627-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103211424.127627-3-almasrymina@google.com>
Subject: [PATCH net-next v1 2/5] net: skbuff: refcount spliced page_pool frags
 via skb_pipe_buf_ops
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, imx@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Willem de Bruijn <willemb@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Pavel Begunkov <asml.silence@gmail.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Johannes Berg <johannes@sipsolutions.net>, Byungchul Park <byungchul@sk.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Wen Gu <guwen@linux.alibaba.com>, Philo Lu <lulie@linux.alibaba.com>, 
	Justin Chen <justin.chen@broadcom.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Vikas Gupta <vikas.gupta@broadcom.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Nicolai Buchwitz <nb@tipi-net.de>, Satish Kharat <satishkh@cisco.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Fan Gong <gongfan1@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
	Felix Fietkau <nbd@nbd.name>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Yibo Dong <dong100@mucse.com>, 
	Brett Creeley <brett.creeley@amd.com>, Justin Lai <justinlai0215@realtek.com>, 
	Larry Chiu <larry.chiu@realtek.com>, 
	"=?UTF-8?q?Niklas=20S=C3=B6derlund?=" <niklas.soderlund@ragnatech.se>, Paul Barker <paul@pbarker.dev>, 
	Masahisa Kojima <kojima.masahisa@socionext.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Ronak Doshi <ronak.doshi@broadcom.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>, Eric Joyner <eric.joyner@amd.com>, 
	Mohammad Heib <mheib@redhat.com>, Prabu Thayalan <prabu.ponrajthayalan@amd.com>, 
	Chintan Vankar <c-vankar@ti.com>, Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
	Alexander Sverdlin <alex@sverdlin.org>, Kevin Hao <haokexin@gmail.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Meghana Malladi <m-malladi@ti.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

Update skb_splice_bits() (spd_fill_page(), sock_spd_release(), and
skb_pipe_buf_ops) and skb_append_pagefrags() to acquire and release
references via netmem_inc_ref(), netmem_dec_ref(), and skb_frag_ref()
so page_pool RX fragments spliced into a pipe remain pinned in the pool
while in the pipe and pair with skb_append_pagefrags() and
skb_release_data() when spliced into a TX socket once netmem_inc_ref()
and netmem_dec_ref() handle page_pool netmems.

Caveats:
- Because pipe buffers created by skb_splice_bits() hold pp_ref_count
  until released (including across tee()), user pipes holding
  unconsumed spliced data keep those page_pool pages in-flight and
  DMA-mapped in the pool (bounded by pipe capacity and RLIMIT_NOFILE
  rather than sk_rcvbuf) until the pipe buffers are consumed or closed,
  with page_pool_destroy() deferring pool release via its periodic
  workqueue and page_pool_scrub() unmapping DMA.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 net/core/skbuff.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f6764117243..32a9dcdf2cb22 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3114,9 +3114,27 @@ EXPORT_SYMBOL(skb_copy_bits);
  */
 static void sock_spd_release(struct splice_pipe_desc *spd, unsigned int i)
 {
-	put_page(spd->pages[i]);
+	netmem_dec_ref(page_to_netmem(spd->pages[i]));
 }
 
+static void skb_pipe_buf_release(struct pipe_inode_info *pipe,
+				 struct pipe_buffer *buf)
+{
+	netmem_dec_ref(page_to_netmem(buf->page));
+}
+
+static bool skb_pipe_buf_get(struct pipe_inode_info *pipe,
+			     struct pipe_buffer *buf)
+{
+	netmem_inc_ref(page_to_netmem(buf->page));
+	return true;
+}
+
+static const struct pipe_buf_operations skb_pipe_buf_ops = {
+	.release	= skb_pipe_buf_release,
+	.get		= skb_pipe_buf_get,
+};
+
 static struct page *linear_to_page(struct page *page, unsigned int *len,
 				   unsigned int *offset,
 				   struct sock *sk)
@@ -3165,7 +3183,7 @@ static bool spd_fill_page(struct splice_pipe_desc *spd, struct page *page,
 		spd->partial[spd->nr_pages - 1].len += *len;
 		return false;
 	}
-	get_page(page);
+	netmem_inc_ref(page_to_netmem(page));
 	spd->pages[spd->nr_pages] = page;
 	spd->partial[spd->nr_pages].len = *len;
 	spd->partial[spd->nr_pages].offset = offset;
@@ -3281,7 +3299,7 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 		.pages = pages,
 		.partial = partial,
 		.nr_pages_max = MAX_SKB_FRAGS,
-		.ops = &nosteal_pipe_buf_ops,
+		.ops = &skb_pipe_buf_ops,
 		.spd_release = sock_spd_release,
 	};
 	int ret = 0;
@@ -4692,8 +4710,8 @@ int skb_append_pagefrags(struct sk_buff *skb, struct page *page,
 		skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], size);
 	} else if (i < max_frags) {
 		skb_zcopy_downgrade_managed(skb);
-		get_page(page);
 		skb_fill_page_desc_noacc(skb, i, page, offset, size);
+		skb_frag_ref(skb, i);
 	} else {
 		return -EMSGSIZE;
 	}
-- 
2.56.0.385.gac671c819a-goog

