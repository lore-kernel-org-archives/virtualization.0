From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 0/6] powerPC/pSeries use pv-qpsinlock as the default
	spinlock implemention
Date: Thu, 02 Jun 2016 17:47:47 +0800
Message-ID: <575000C3.2020708@linux.vnet.ibm.com>
References: <1464859590-5292-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160602093350.GY3190@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160602093350.GY3190@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org, waiman.long@hpe.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE25bm0MDbmnIgwMuaXpSAxNzozMywgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6Cj4KPgo+
IEknbSB0aGlua2luZyBvbmUgY29weSBhIGRheSBpcyBxdWl0ZSBlbm91Z2guLi4KPgpzb3JyeSBm
b3Igbm9pc2UuCkluIHJlY2VudCBkYXlzLCBvdXIgc210cCBzZXJ2ZXIgaGFzIHNvbWUgYnVncyB0
aGF0IG1haWxzJyBNZXNzYWdlLUlkIGlzIGNoYW5nZWQgYnkgYWNjaWRlbnQuClNvIEkgcmVzZW5k
IHRoZW0ganVzdCBmb3Igc3VyZS4Kc29ycnkgYWdhaW4uLi4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
