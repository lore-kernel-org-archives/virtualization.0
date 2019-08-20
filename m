From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V5 1/5] iommu/amd: Remove unnecessary locking from AMD
	iommu driver
Date: Tue, 20 Aug 2019 02:41:43 -0700
Message-ID: <20190820094143.GA24154__27661.8070014351$1566294124$gmane$org@infradead.org>
References: <20190815110944.3579-1-murphyt7@tcd.ie>
	<20190815110944.3579-2-murphyt7@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190815110944.3579-2-murphyt7@tcd.ie>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tom Murphy <murphyt7@tcd.ie>
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Andy Gross <agross@kernel.org>, linux-s390@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBBdWcgMTUsIDIwMTkgYXQgMTI6MDk6MzlQTSArMDEwMCwgVG9tIE11cnBoeSB3cm90
ZToKPiBXZSBjYW4gcmVtb3ZlIHRoZSBtdXRleCBsb2NrIGZyb20gYW1kX2lvbW11X21hcCBhbmQg
YW1kX2lvbW11X3VubWFwLgo+IGlvbW11X21hcCBkb2VzbuKAmXQgbG9jayB3aGlsZSBtYXBwaW5n
IGFuZCBzbyBubyB0d28gY2FsbHMgc2hvdWxkIHRvdWNoCj4gdGhlIHNhbWUgaW92YSByYW5nZS4g
VGhlIEFNRCBkcml2ZXIgYWxyZWFkeSBoYW5kbGVzIHRoZSBwYWdlIHRhYmxlIHBhZ2UKPiBhbGxv
Y2F0aW9ucyB3aXRob3V0IGxvY2tzIHNvIHdlIGNhbiBzYWZlbHkgcmVtb3ZlIHRoZSBsb2Nrcy4K
CkkndmUgYmVlbiBsb29raW5nIG92ZXIgdGhlIGNvZGUgYW5kIHRyeWluZyB0byB1bmRlcnN0YW5k
IGhvdyB0aGUKc3luY2hyb25pemF0aW9uIHdvcmtzLiAgSSBndWVzIHdlIHRoZSBjbXB4Y2hnNjQg
aW4gZnJlZV9jbGVhcl9wdGUKaXMgdGhlIGltcG9ydGFudCBwb2ludCBoZXJlPyAgSSBoYXZlIHRv
IGFkbWl0IEkgZG9uJ3QgZnVsbHkgdW5kZXJzdGFuZAp0aGUgY29uY3VycmVuY3kgaXNzdWVzIGhl
cmUsIGJ1dCBuZWl0aGVyIGRvIEkgdW5kZXJzdGFuZCB3aGF0IHRoZQptdXRleCB5b3UgcmVtb3Zl
ZCBtaWdodCBoYXZlIGhlbHBlZCB0byBzdGFydCB3aXRoLgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
