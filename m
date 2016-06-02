From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 0/6] powerPC/pSeries use pv-qpsinlock as the default
	spinlock implemention
Date: Thu, 2 Jun 2016 13:08:09 +0200
Message-ID: <20160602110809.GA3190@twins.programming.kicks-ass.net>
References: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160602093350.GY3190@twins.programming.kicks-ass.net>
	<575000C3.2020708@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <575000C3.2020708@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org, waiman.long@hpe.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBKdW4gMDIsIDIwMTYgYXQgMDU6NDc6NDdQTSArMDgwMCwgeGluaHVpIHdyb3RlOgo+
IAo+IAo+IE9uIDIwMTblubQwNuaciDAy5pelIDE3OjMzLCBQZXRlciBaaWpsc3RyYSB3cm90ZToK
PiA+Cj4gPgo+ID5JJ20gdGhpbmtpbmcgb25lIGNvcHkgYSBkYXkgaXMgcXVpdGUgZW5vdWdoLi4u
Cj4gPgo+IHNvcnJ5IGZvciBub2lzZS4KPiBJbiByZWNlbnQgZGF5cywgb3VyIHNtdHAgc2VydmVy
IGhhcyBzb21lIGJ1Z3MgdGhhdCBtYWlscycgTWVzc2FnZS1JZCBpcyBjaGFuZ2VkIGJ5IGFjY2lk
ZW50Lgo+IFNvIEkgcmVzZW5kIHRoZW0ganVzdCBmb3Igc3VyZS4KPiBzb3JyeSBhZ2Fpbi4uLgoK
SnVzdCBkb24ndCB1c2UgY29ycG9yYXRlIGVtYWlsIGlmIGl0cyBub3QgcmVsaWFibGUgb3IgcGFp
biB0byB1c2U7IGRvCm5vdCBzZW5kIG11bHRpcGxlIGNvcGllcyBqdXN0IGJlY2F1c2UuCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
