From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Thu, 19 Apr 2007 22:10:24 -0700
Message-ID: <46284B40.5010106@goop.org>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070420015304.74394BFC@zach-dev2.vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <petr@vmware.com>, Chaz Masden <zamsden@gmail.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Now that paravirt-ops is a fully patched, purely functional interface,
> which appropriately generates bugs when patches fail to get applied,
> it need no longer be exported to modules.  Modules will be patched at
> load time, and need no boot time fallback which references paravirt-ops.
>   

Hm, OK, I see what you're getting at.

I guess the BUG_ON()s need only fire if they're failing to patch over a
ud2a instruction.


I'm in two minds about this.  On the one hand, it's a clever hack which
does achieve the desired outcome.  On the other hand, it turns an
optimisation mechanism into a special-purpose ad-hoc linker which
doesn't seem like quite the right way to go.  The conversion from "best
effort, doing nothing is OK" to "doing nothing is a BUG" behaviour is a
good indication of this.

    J
