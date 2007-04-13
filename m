From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/4] i386 - pte update optimizations
Date: Fri, 13 Apr 2007 08:34:06 -0700
Message-ID: <461FA2EE.5090103@zytor.com>
References: <C2452891.D417%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <C2452891.D417%keir@xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Keir Fraser <keir@xensource.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <andi@firstfloor.org>, Chris Wright <chrisw@sous-sol.org>, David Rientjes <rientjes@google.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Hugh Dickins <hugh@veritas.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Keir Fraser wrote:
> On 13/4/07 13:27, "Andi Kleen" <andi@firstfloor.org> wrote:
> =

>>> LOCKed instruction suck really badly on the netburst microarchitecture =
(like
>>> factor of 10x, or not far off). I think it's probably because of their =
side
>>> effect of serialising memory accesses, causing horrible pipeline stalls.
>> Unfortunately they tend to be HyperThreaded usually (except for early on=
es
>> and Celerons) and need the LOCK anyways.
> =

> Fair point, although quite a few people disable HT.

Note we're talking a UP-only hack.

	-hpa
