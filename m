From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
Date: Fri, 29 May 2020 05:45:23 -0700
Message-ID: <20200529124523.GA11817@infradead.org>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>, linux-mediatek@lists.infradead.
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBNYXkgMjgsIDIwMjAgYXQgMDY6MDA6NDRQTSAtMDYwMCwgTG9nYW4gR3VudGhvcnBl
IHdyb3RlOgo+ID4gVGhpcyBpc3N1ZSBpcyBtb3N0IGxpa2VseSBpbiB0aGUgaTkxNSBkcml2ZXIg
YW5kIGlzIG1vc3QgbGlrZWx5IGNhdXNlZCBieSB0aGUgZHJpdmVyIG5vdCByZXNwZWN0aW5nIHRo
ZSByZXR1cm4gdmFsdWUgb2YgdGhlIGRtYV9tYXBfb3BzOjptYXBfc2cgZnVuY3Rpb24uIFlvdSBj
YW4gc2VlIHRoZSBkcml2ZXIgaWdub3JpbmcgdGhlIHJldHVybiB2YWx1ZSBoZXJlOgo+ID4gaHR0
cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvN2UwMTY1YjJmMWE5MTJhMDZlMzgx
ZTkxZjBmNGU0OTVmNGFjMzczNi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9nZW0vaTkxNV9nZW1fZG1h
YnVmLmMjTDUxCj4gPiAKPiA+IFByZXZpb3VzbHkgdGhpcyBkaWRu4oCZdCBjYXVzZSBpc3N1ZXMg
YmVjYXVzZSB0aGUgaW50ZWwgbWFwX3NnIGFsd2F5cyByZXR1cm5lZCB0aGUgc2FtZSBudW1iZXIg
b2YgZWxlbWVudHMgYXMgdGhlIGlucHV0IHNjYXR0ZXIgZ2F0aGVyIGxpc3QgYnV0IHdpdGggdGhl
IGNoYW5nZSB0byB0aGlzIGRtYS1pb21tdSBhcGkgdGhpcyBpcyBubyBsb25nZXIgdGhlIGNhc2Uu
IEkgd2FzbuKAmXQgYWJsZSB0byB0cmFjayB0aGUgYnVnIGRvd24gdG8gYSBzcGVjaWZpYyBsaW5l
IG9mIGNvZGUgdW5mb3J0dW5hdGVseS4gIAoKTWFyayBkaWQgYSBiaWcgYXVkaXQgaW50byB0aGUg
bWFwX3NnIEFQSSBhYnVzZSBhbmQgaW5pdGlhbGx5IGhhZApzb21lIGk5MTUgcGF0Y2hlcywgYnV0
IHRoZW4gZ2F2ZSB1cCBvbiB0aGVtIHdpdGggdGhpcyBjb21tZW50OgoKIlRoZSBiaWdnZXN0IFRP
RE8gaXMgRFJNL2k5MTUgZHJpdmVyIGFuZCBJIGRvbid0IGZlZWwgYnJhdmUgZW5vdWdoIHRvIGZp
eAogaXQgZnVsbHkuIFRoZSBkcml2ZXIgY3JlYXRpdmVseSB1c2VzIHNnX3RhYmxlLT5vcmlnX25l
bnRzIHRvIHN0b3JlIHRoZQogc2l6ZSBvZiB0aGUgYWxsb2NhdGUgc2NhdHRlcmxpc3QgYW5kIGln
bm9yZXMgdGhlIG51bWJlciBvZiB0aGUgZW50cmllcwogcmV0dXJuZWQgYnkgZG1hX21hcF9zZyBm
dW5jdGlvbi4gSW4gdGhpcyBwYXRjaHNldCBJIG9ubHkgZml4ZWQgdGhlCiBzZ190YWJsZSBvYmpl
Y3RzIGV4cG9ydGVkIGJ5IGRtYWJ1ZiByZWxhdGVkIGZ1bmN0aW9ucy4gSSBob3BlIHRoYXQgSQog
ZGlkbid0IGJyZWFrIGFueXRoaW5nIHRoZXJlLiIKCml0IHdvdWxkIGJlIHJlYWxseSBuaWNlIGlm
IHRoZSBpOTE1IG1haW50YWluZXJzIGNvdWxkIGhlbHAgd2l0aCBzb3J0aW5nCnRoYXQgQVBJIGFi
dXNlIG91dC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
