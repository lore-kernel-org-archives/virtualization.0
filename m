Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED9830E834
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764128424; cv=none; b=Piq7N8oLwX3eNogcbW3UCC0KFKOHNovi9/sIwEvuY+Im/dfjO2nnr/vEicNBEXXFbySxxjyoYmsA1kVaXWGSm3o37mOWYuMYNDn/n31op6QknmQ66h7Bau+/up9ZTNy8aVBO2UmdzBI7h05Z7mBXpj7L6er8/xUAtuvas+jS+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764128424; c=relaxed/simple;
	bh=eO+/pRsiIyMggKULQ3OLvRr6dXc2hBN8SftnMWhJLtY=;
	h=Date:From:To:Cc:Subject:Mime-Version:Message-ID:Content-Type; b=NafxoTbXW40asHu/xrbVzBVjrRourSyjE86LqL5fQofEW/AHavrDlTsSZg9gisZq/Jp9co2JgbOJ9cbFUx8owojF8ovVY22nptEeE0fckgo6EcRCXLp0iVfZZB+gqAJM30x092WxDBDoRSKlneuq3catfRqEM9bMJBtHq5S0BH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0001865LT (unknown [10.64.96.87])
	by app2 (Coremail) with SMTP id TQJkCgB3u66gdiZpj3Z+AA--.7816S2;
	Wed, 26 Nov 2025 11:40:16 +0800 (CST)
Date: Wed, 26 Nov 2025 11:40:16 +0800
From: "zhangdongchuan@eswincomputing.com" <zhangdongchuan@eswincomputing.com>
To: mst <mst@redhat.com>, 
	jasowang <jasowang@redhat.com>, 
	xuanzhuo <xuanzhuo@linux.alibaba.com>, 
	eperezma <eperezma@redhat.com>
Cc: virtualization <virtualization@lists.linux.dev>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	zhangdongchuan <zhangdongchuan@eswincomputing.com>
Subject: [PATCH] virtio_ring: code cleanup in detach_buf_split
X-Priority: 3
X-GUID: DEF252B6-7D74-46CB-8B1F-A9A1F987F6AA
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.306[cn]
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Message-ID: <202511261140162936986@eswincomputing.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-CM-TRANSID:TQJkCgB3u66gdiZpj3Z+AA--.7816S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKFWDGr4fAF4kKry5CFWUXFb_yoW8JF13pr
	4jkry5Kw15C3srKa98CF4jqr1Y9a93K34I9Fy7W347Krn8ZF1UtFy8Cay8KF1UCry7Zr10
	yF4Fqa43G34qvFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFcxC0VAYjxAxZF0E
	w4CEw7xC0wCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJwCE64xvF2IEb7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x0JUAGYJUUUUU=
X-CM-SenderInfo: x2kd0w5grqwuhkxd0qphvzx0xfrp13pwlqwhhfrp/

U2luY2UgdGhlIHJldHVybiB2YWx1ZSBvZiB2cmluZ191bm1hcF9vbmVfc3BsaXQoKSBpcyBleGFj
dGx5CnZxLT5zcGxpdC5kZXNjX2V4dHJhW2ldLm5leHQsICdpID0gdnEtPnNwbGl0LmRlc2NfZXh0
cmFbaV0ubmV4dCcgaXMKcmVkdW5kYW50LiBBc3NpZ24gdnJpbmdfdW5tYXBfb25lX3NwbGl0KCkg
dG8gaSBpbnN0ZWFkLgoKU2luY2UgdnEtPnNwbGl0LmRlc2NfZXh0cmEgaXMgYXNzaWduZWQgdG8g
ZXh0cmEsIHVzZSBleHRyYVtpXS5uZXh0Cmluc3RlYWQgb2YgdnEtPnNwbGl0LmRlc2NfZXh0cmFb
aV0ubmV4dCB0byBpbXByb3ZlIHJlYWRhYmlsaXR5LgoKTm8gY2hhbmdlIGluIGZ1bmN0aW9uYWxp
dHkuCgpTaWduZWQtb2ZmLWJ5OiB6aGFuZ2RvbmdjaHVhbiA8emhhbmdkb25nY2h1YW5AZXN3aW5j
b21wdXRpbmcuY29tPgotLS0KIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA1ICsrLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCmluZGV4IDdiNjIwNTI1M2I0Ni4uMGNiZjM0MTlhNjQ1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCisrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMKQEAgLTc2NCwxMyArNzY0LDEyIEBAIHN0YXRpYyB2b2lkIGRldGFjaF9idWZfc3BsaXQo
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsIHVuc2lnbmVkIGludCBoZWFkLAogCWkgPSBoZWFk
OwogCiAJd2hpbGUgKHZxLT5zcGxpdC52cmluZy5kZXNjW2ldLmZsYWdzICYgbmV4dGZsYWcpIHsK
LQkJdnJpbmdfdW5tYXBfb25lX3NwbGl0KHZxLCAmZXh0cmFbaV0pOwotCQlpID0gdnEtPnNwbGl0
LmRlc2NfZXh0cmFbaV0ubmV4dDsKKwkJaSA9IHZyaW5nX3VubWFwX29uZV9zcGxpdCh2cSwgJmV4
dHJhW2ldKTsKIAkJdnEtPnZxLm51bV9mcmVlKys7CiAJfQogCiAJdnJpbmdfdW5tYXBfb25lX3Nw
bGl0KHZxLCAmZXh0cmFbaV0pOwotCXZxLT5zcGxpdC5kZXNjX2V4dHJhW2ldLm5leHQgPSB2cS0+
ZnJlZV9oZWFkOworCWV4dHJhW2ldLm5leHQgPSB2cS0+ZnJlZV9oZWFkOwogCXZxLT5mcmVlX2hl
YWQgPSBoZWFkOwogCiAJLyogUGx1cyBmaW5hbCBkZXNjcmlwdG9yICovCi0tIAoyLjM0LjEKCgo=

