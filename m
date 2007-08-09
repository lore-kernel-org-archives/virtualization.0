From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Thu, 09 Aug 2007 10:44:55 +1000
Message-ID: <1186620295.17752.23.camel__7624.26142250678$1186620427$gmane$org@localhost.localdomain>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<5d6222a80708080749t35c5c0ceo8b3b8f0cce50c666@mail.gmail.com>
	<1186615137.17470.100.camel@localhost.localdomain>
	<200708090224.16328.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708090224.16328.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-08-09 at 02:24 +0200, Andi Kleen wrote:
> Not sure what's best. Ok using a normal export is easiest and not
> that big an issue.

Yeah, there's also been talk of breaking up paravirt_ops into multiple
structs by area, which would lead naturally into finer-grained export
control.

Cheers,
Rusty.
