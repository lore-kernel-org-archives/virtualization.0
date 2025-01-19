Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490A61DDC2B
	for <virtualization@lists.linux.dev>; Sun, 19 Jan 2025 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737284085; cv=none; b=Pdo1x70/07Qr2k0FCOzZIojGFzBa06HfvnDe8De1q/ED6pji0fYNQcWMGfcGinG50yTAoGEjQh7gMZs9M9ZOeG9iBIC4d+IjpfBOk4+THfQ0lQP0vUFmMZKqHmgzqXM+tbGkZY2dBnuf4DP95DWU/z5FrkxmxoiqvqTxb3R67zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737284085; c=relaxed/simple;
	bh=MlESe3dgp/FFiNx//OK7b7uZBjNkfsdX7dquuja6okI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=rXvXfOcDIlUdALmoxsyI2gbBpHyyUD5o9Lm5vv5eUdH9afwxIeOFG+BpAcm0lxrMyfWocpA210ls2suD0hmPVim9PTjCgWZExHtcA8rKkgyua+WPoV1T5vja7eO6AkNZ1u/Pimm1dAgM3GWeAjB31nrvh9t5lDhDxL1XJtqDYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [117.161.58.149])
	by mtasvr (Coremail) with SMTP id _____wCHUubY2YxnfUIiAA--.39456S3;
	Sun, 19 Jan 2025 18:54:18 +0800 (CST)
Received: from wh1sper$zju.edu.cn ( [117.161.58.149] ) by
 ajax-webmail-mail-app4 (Coremail) ; Sun, 19 Jan 2025 18:54:15 +0800
 (GMT+08:00)
Date: Sun, 19 Jan 2025 18:54:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5byg5rWp54S2?= <wh1sper@zju.edu.cn>
To: "Mike Christie" <michael.christie@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] vhost/scsi: Fix improper cleanup in
 vhost_scsi_set_endpoint()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241206(f7804f05) Copyright (c) 2002-2025 www.mailtech.cn zju.edu.cn
In-Reply-To: <41925d66-f4b5-4f96-93f6-b29437399005@oracle.com>
References: <e418a5ee-45ca-4d18-9b5d-6f8b6b1add8e@oracle.com>
 <20250117114400.79792-1-wh1sper@zju.edu.cn>
 <d00be9fa-364c-4b9e-a14e-a3b403e7bd6c@oracle.com>
 <41925d66-f4b5-4f96-93f6-b29437399005@oracle.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <3dde608f.568.1947e32f3b0.Coremail.wh1sper@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zi_KCgCHbcjY2YxnxEYXAA--.4010W
X-CM-SenderInfo: asssliaqzvq6lmxovvfxof0/1tbiAhMLB2eMLiglLgAAs7
X-CM-DELIVERINFO: =?B?rQFpjwXKKxbFmtjJiESix3B1w3u7BCRQAee6E0rsv8LVXQpn+jaR4luXxag8yWi2LJ
	86hqLH9YqTRpyMEfmF+fuNyi1SkyR3EJI6y6sKLmy1+HNZh3osqYlt+32UgOxtS3L1mUTm
	T7B8tVG4pduqGcv0jMBBglEEnMJRP57INIwP3qYLLJWITwCMM03UxrqoSr/9XA==
X-Coremail-Antispam: 1Uk129KBj9xXoW7GF15Kw17tF45Kr1fKFW7GFX_yoWDuFb_Wr
	97Za4xX3y5Xry7Ja1UZr1Ykr13WFWF9a47Cr1kKF9xt348JFsrWr13WF97u3WakF13Krn8
	G3W5tw15Ja13uosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbyxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFcxC0VAYjxAxZF0Ew4CEw7xC0wACY4xI67k04243AVC20s07MxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4xI67k04243AbIYCTnIWIevJa73UjIFyTuYvj
	xU7GYpUUUUU

T24gMjAyNS0wMS0xOCAwMToxMTowMSwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPiBJIGNhbid0IHRl
bGwgaWYgYmVpbmcgYWJsZSB0byBjYWxsIFZIT1NUX1NDU0lfU0VUX0VORFBPSU5UIG11bHRpcGxl
Cj4gdGltZXMgd2l0aG91dCBjYWxsaW5nIFZIT1NUX1NDU0lfQ0xFQVJfRU5EUE9JTlQgYmV0d2Vl
biBjYWxscyBpcyBhbgo+IGFjdHVhbCBmZWF0dXJlIHRoYXQgdGhlIGNvZGUgd2FzIHRyeWluZyB0
byBzdXBwb3J0IG9yIHRoYXQgaXMgdGhlCj4gcm9vdCBidWcuIEl0J3Mgc28gYnVnZ3kgSSBmZWVs
IGxpa2UgaXQgd2FzIG5ldmVyIG1lYW50IHRvIGJlIGNhbGxlZAo+IGxpa2UgdGhpcyBzbyB3ZSBz
aG91bGQganVzdCBhZGQgYSBjaGVjayBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBmdW5jdGlvbi4K
ClN1cmUsIHByb2NlZWQgYXMgeW91IHByZWZlciAoTWFpbnRhaW5pbmcgYSAxMi15ZWFyLW9sZCBj
b2RlYmFzZSBzZWVtcyBxdWl0ZSB0cm91Ymxlc29tZSkuIE15IHN1Z2dlc3Rpb24gd291bGQgYmUg
dG8gaW5jcmVhc2UgdGhlIGNvbnN0YW50IFZIT1NUX1NDU0lfQUJJX1ZFUlNJT04gaWYgdGhlcmUg
YXJlIEFQSSBjaGFuZ2VzLCBzbyB0aGF0IHVzZXJzcGFjZSBjYW4gcmVjb2duaXplIHRoZSBuZXcg
dmVyc2lvbiB0aHJvdWdoIHRoZSBWSE9TVF9TQ1NJX0dFVF9BQklfVkVSU0lPTiBjb21tYW5kIG9m
IGlvY3RsLgoKPiBUaGUgd29ycnkgd291bGQgYmUgdGhhdCBpZiB0aGVyZSBhcmUgdXNlcnNwYWNl
IHRvb2xzIGRvaW5nIHRoaXMKPiBhbmQgbGl2aW5nIHdpdGggdGhlIGJ1Z3MgdGhlbiB0aGUgYWJv
dmUgcGF0Y2ggd291bGQgYWRkIGEgcmVncmVzc2lvbi4KPiBIb3dldmVyLCBJIHRoaW5rIHRoYXQn
cyBoaWdobHkgdW5saWtlbHkgYmVjYXVzZSBvZiBob3cgdXNlbGVzcy9idWdneQo+IGl0IGlzLgoK
CgpBZ3JlZWQuIENWRS0yMDI0LTQ5ODYzIGhhcyBzaG93biB0aGF0IG5vIHN1Y2Nlc3NmdWwgU0NT
SSBBTiByZXF1ZXN0cyBoYXZlIGJlZW4gc2VudCBmcm9tIGEgZ3Vlc3QgdG8gYSB2aG9zdC1zY3Np
IGRldmljZSBmb3IgeWVhcnMuIA==

