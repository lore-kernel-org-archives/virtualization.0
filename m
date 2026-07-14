Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64C53D9030
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 06:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008850; cv=none; b=qcHF6C7l4Mq8Ogoihi2D854UH7P3369sWicP4DOijBryY8Onw7q8DNn4rirJ/8hqeeiXKCJcg/tepW+xl5dSb3bmOrbY/IZz/4wqYeR4hzhcoBqYhbiioVVKeg0htYaTgCA05l5If/39JzWXy21Y4NXhcjK+gNKwqy0H0nRWDqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008850; c=relaxed/simple;
	bh=O6RwwgHd3B813cyV4/W+ZRacuKP/I76ufMlGZcK9+zg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=iQ/dgIzGKJoK9ySy8lvgTw7MwdRtNpS3TTxIqKTRvs9D9aSn7I1l0AzmBm/USdORttfUoinl/0YGHrZfedqSIxRrOV43Z0k1Y38sXGcoWmRdiCbAs8Dbt3xL4sVW6UH/R7s6CXKwRipB0a4uTvG6rDRJC7I9mIe/XKdPBhE+5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qDtLk+AM; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qDtLk+AM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=O6RwwgHd3B813cyV4/W+ZRacuKP/I76ufMlGZcK9+zg=; b=q
	DtLk+AMizn2fP5iB48DPjvwHJlW7kQO69FiYIpDYWE/wTE4qBdTNKm1PZ/IdphfK
	da7k5K5QiH0LN59AvfwsxpxW8WvE0B94k1c1kQw5zAt3lTXiZfe/4O6Z6/01iXNK
	OXbrdGB+3e48x0xEVyRyix7IC/Z/c4Zvm3VTMSFqUc=
Received: from xiongwm2026$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-146 (Coremail) ; Tue, 14 Jul 2026 14:00:29 +0800
 (CST)
Date: Tue, 14 Jul 2026 14:00:29 +0800 (CST)
From: xiongwm2026  <xiongwm2026@163.com>
To: "Parav Pandit" <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
	"jasowangio@gmail.com" <jasowangio@gmail.com>,
	"david@redhat.com" <david@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: Re:RE: [PATCH] virtio_mem: fix typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <SJ0PR12MB6806262FB6F99ADA13EC127CDCF92@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <20260714032417.201353-1-xiongwm2026@163.com>
 <SJ0PR12MB6806262FB6F99ADA13EC127CDCF92@SJ0PR12MB6806.namprd12.prod.outlook.com>
X-NTES-SC: AL_Qu2TBvybt0Ap7ymbY+kckk8Ugeg8Xsewsvgh249ec+0Gsxzp5AcFR31lDFzH1OSCAiOPthaQSCF27OBiZLR+LYoGwglgRElOy1/hYlcIuw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <2f2e17ce.4699.19f5f366bfd.Coremail.xiongwm2026@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kigvCgDHX_l_0FVqi3QdAA--.4271W
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzh5D0mpV0H5tzAAA3x
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBQYXJhdiwKClRoYW5rcyBmb3IgdGhlIHJldmlldyEKCkJlc3QgcmVnYXJkcywKV2VpbWlu
CgpBdCAyMDI2LTA3LTE0IDEyOjI3OjQ1LCAiUGFyYXYgUGFuZGl0IiA8cGFyYXZAbnZpZGlhLmNv
bT4gd3JvdGU6Cj4KPgo+PiBGcm9tOiB3ZWltaW4geGlvbmcgPHhpb25nd20yMDI2QDE2My5jb20+
Cj4+IFNlbnQ6IDE0IEp1bHkgMjAyNiAwODo1NCBBTQo+PiAKPj4gW1lvdSBkb24ndCBvZnRlbiBn
ZXQgZW1haWwgZnJvbSB4aW9uZ3dtMjAyNkAxNjMuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBv
cnRhbnQgYXQKPj4gaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9u
IF0KPgo+PiAKPj4gRnJvbTogeGlvbmd3ZWltaW4gPHhpb25nd2VpbWluQGt5bGlub3MuY24+Cj4+
IAo+PiBDb3JyZWN0ICJhY3RpcG4iIHRvICJhY3Rpb24iLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTog
eGlvbmd3ZWltaW4gPHhpb25nd2VpbWluQGt5bGlub3MuY24+Cj4+IC0tLQo+PiAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX21lbS5jIHwgMiArLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX21lbS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jCj4+IGluZGV4IDExYzQ0MTUw
MS4uOTBkOGVmMGI5IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbWVtLmMK
Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jCj4+IEBAIC0xMDgwLDcgKzEwODAs
NyBAQCBzdGF0aWMgaW50IHZpcnRpb19tZW1fbWVtb3J5X25vdGlmaWVyX2NiKHN0cnVjdCBub3Rp
Zmllcl9ibG9jayAqbmIsCj4+ICAgICAgICAgICAgICAgICBhdG9taWM2NF9zdWIoc2l6ZSwgJnZt
LT5vZmZsaW5lX3NpemUpOwo+PiAgICAgICAgICAgICAgICAgLyoKPj4gICAgICAgICAgICAgICAg
ICAqIFN0YXJ0IGFkZGluZyBtb3JlIG1lbW9yeSBvbmNlIHdlIG9ubGluZWQgaGFsZiBvZiBvdXIK
Pj4gLSAgICAgICAgICAgICAgICAqIHRocmVzaG9sZC4gRG9uJ3QgdHJpZ2dlciBpZiBpdCdzIHBv
c3NpYmx5IGR1ZSB0byBvdXIgYWN0aXBuCj4+ICsgICAgICAgICAgICAgICAgKiB0aHJlc2hvbGQu
IERvbid0IHRyaWdnZXIgaWYgaXQncyBwb3NzaWJseSBkdWUgdG8gb3VyIGFjdGlvbgo+PiAgICAg
ICAgICAgICAgICAgICogKGUuZy4sIHVzIGFkZGluZyBtZW1vcnkgd2hpY2ggZ2V0cyBvbmxpbmVk
IGltbWVkaWF0ZWx5IGZyb20KPj4gICAgICAgICAgICAgICAgICAqIHRoZSBjb3JlKS4KPj4gICAg
ICAgICAgICAgICAgICAqLwo+PiAtLQo+PiAyLjQzLjAKPj4gCj4+IAo+PiBObyB2aXJ1cyBmb3Vu
ZAo+PiAgICAgICAgICAgICAgICAgQ2hlY2tlZCBieSBIaWxsc3RvbmUgTmV0d29yayBBbnRpVmly
dXMKPj4gCj4KPlJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cg==

