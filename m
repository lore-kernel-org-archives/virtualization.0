From: yezengruan <yezengruan@huawei.com>
Subject: Re: [PATCH 1/5] KVM: arm64: Document PV-lock interface
Date: Mon, 23 Dec 2019 10:06:43 +0800
Message-ID: <6d798e02-7ab2-fc58-9f75-ee74de97ae72__39012.2136029945$1577066825$gmane$org@huawei.com>
References: <20191217135549.3240-2-yezengruan@huawei.com>
 <2337a083-499f-7778-7bf3-9f525a04e17a@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2337a083-499f-7778-7bf3-9f525a04e17a@web.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Markus Elfring <Markus.Elfring@web.de>, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Mark Rutland <mark.rutland@arm.com>, "Suzuki K.
 Poulose" <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, James Morse <james.morse@arm.com>, Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>, Julien Thierry <julien.thierry.kdev@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

SGkgTWFya3VzLAoKT24gMjAxOS8xMi8yMCAyMjozMiwgTWFya3VzIEVsZnJpbmcgd3JvdGU6Cj4g
4oCmCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vdmlydC9rdm0vYXJtL3B2bG9jay5yc3QKPiDigKYK
Pj4gK1BhcmF2aXJ0dWFsaXplZCBsb2NrIHN1cHBvcnQgZm9yIGFybTY0Cj4+ICs9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+PiArCj4+ICtLVk0vYXJtNjQgcHJvdmlkcyBz
b21lIOKApgo+IOKApgo+IAo+IEkgc3VnZ2VzdCB0byBhdm9pZCBhIHR5cG8gaGVyZS4KClRoYW5r
cyBmb3IgcG9zdGluZyB0aGlzLgoKPiAKPiBSZWdhcmRzLAo+IE1hcmt1cwo+IAoKVGhhbmtzLAoK
WmVuZ3J1YW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
