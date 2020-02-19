From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/ioperm: add new paravirt function update_io_bitmap
Date: Wed, 19 Feb 2020 10:22:45 +0100
Message-ID: <8736b7q6ca.fsf@nanos.tec.linutronix.de>
References: <20200218154712.25490-1-jgross@suse.com>
 <87mu9fr4ky.fsf@nanos.tec.linutronix.de>
 <b0f33786-79b1-f8ee-24ae-ce9f9f4791af@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <b0f33786-79b1-f8ee-24ae-ce9f9f4791af@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, xen-devel@lists.xenproject.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Thomas Hellstrom <thellstrom@vmware.com>, Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

SsO8cmdlbiBHcm/DnyA8amdyb3NzQHN1c2UuY29tPiB3cml0ZXM6Cj4gT24gMTguMDIuMjAgMjI6
MDMsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPj4gQlRXLCB3aHkgaXNuJ3Qgc3R1ZmYgbGlrZSB0
aGlzIG5vdCBjYXRjaGVkIGR1cmluZyBuZXh0IG9yIGF0IGxlYXN0Cj4+IGJlZm9yZSB0aGUgZmlu
YWwgcmVsZWFzZT8gSXMgbm90aGluZyBydW5uaW5nIENJIG9uIHVwc3RyZWFtIHdpdGggYWxsCj4+
IHRoYXQgWEVOIG11Y2sgYWN0aXZlPwo+Cj4gVGhpcyBwcm9ibGVtIHNob3dlZCB1cCBieSBub3Qg
YmVpbmcgYWJsZSB0byBzdGFydCB0aGUgWCBzZXJ2ZXIgKHByb2JhYmx5Cj4gbm90IHRoZSBmcmVz
aGVzdCBvbmUpIGluIGRvbTAgb24gYSBtb2RlcmF0ZSBhZ2VkIEFNRCBzeXN0ZW0uCj4KPiBPdXIg
Q0kgdGVzdHMgdGVuZCBkbyBiZSBtb3JlIHRleHQgY29uc29sZSBiYXNlZCBmb3IgZG9tMC4KCnRv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni9pb1twZXJtfHBsXSBzaG91bGQgaGF2ZSBjYXVnaHQg
dGhhdCBhcyB3ZWxsLApyaWdodD8gSWYgbm90LCB3ZSBuZWVkIHRvIGZpeCB0aGUgc2VsZnRlc3Rz
LgoKVGhhbmtzLAoKICAgICAgICB0Z2x4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
