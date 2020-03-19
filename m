From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH 63/70] x86/vmware: Add VMware specific handling for
 VMMCALL under SEV-ES
Date: Thu, 19 Mar 2020 10:18:08 +0000
Message-ID: <5abc70ce42e1445b8ae097a38951b0aa6f67bac8.camel@vmware.com>
References: <20200319091407.1481-1-joro@8bytes.org>
         <20200319091407.1481-64-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200319091407.1481-64-joro@8bytes.org>
Content-Language: en-US
Content-ID: <AD4E5ECE942544418011A3A4E96E3198@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "joro@8bytes.org" <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "keescook@chromium.org" <keescook@chromium.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "jgross@suse.com" <jgross@suse.com>, Doug Covelli <dcovelli@vmware.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, "jroedel@suse.de" <jroedel@suse.de>, "jslaby@suse.cz" <jslaby@suse.cz>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCAyMDIwLTAzLTE5IGF0IDEwOjE0ICswMTAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
IEZyb206IERvdWcgQ292ZWxsaSA8ZGNvdmVsbGlAdm13YXJlLmNvbT4NCj4gDQo+IFRoaXMgY2hh
bmdlIGFkZHMgVk13YXJlIHNwZWNpZmljIGhhbmRsaW5nIGZvciAjVkMgZmF1bHRzIGNhdXNlZCBi
eQ0KPiBWTU1DQUxMIGluc3RydWN0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERvdWcgQ292
ZWxsaSA8ZGNvdmVsbGlAdm13YXJlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVG9tIExlbmRhY2t5
IDx0aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCj4gWyBqcm9lZGVsQHN1c2UuZGU6IC0gQWRhcHQg
dG8gZGlmZmVyZW50IHBhcmF2aXJ0IGludGVyZmFjZSBdDQo+IENvLWRldmVsb3BlZC1ieTogSm9l
cmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEpvZXJnIFJvZWRl
bCA8anJvZWRlbEBzdXNlLmRlPg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvdm13YXJl
LmMgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAtLS0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQoNCkFja2Vk
LWJ5OiBUaG9tYXMgSGVsbHN0cm9tIDx0aGVsbHN0cm9tQHZtd2FyZS5jb20+DQoNCg==
