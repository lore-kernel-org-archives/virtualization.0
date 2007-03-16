From: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 2/9] Sched clock paravirt op fix.patch
Date: Fri, 16 Mar 2007 16:29:48 -0500
Message-ID: <20070316212948.GH10459@waste.org>
References: <200703020254.l222sOaM009656@zach-dev.vmware.com>
	<20070313140129.GB92373@muc.de> <45F6C2A3.4040305@goop.org>
	<20070313160709.GH10574@sequoia.sous-sol.org>
	<20070313161656.GA12128@muc.de> <45F6D361.8080106@redhat.com>
	<20070313205628.GB46469@muc.de> <45F71207.8050605@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <45F71207.8050605@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, Daniel Walker <dwalker@mvista.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 13, 2007 at 02:05:11PM -0700, Jeremy Fitzhardinge wrote:
> Andi Kleen wrote:
> > It depends -- under heavy network load you can spend a long time
> > just processing interrupts.
> =

> Well, in that case you probably don't want to charge them to the process
> which happens to be running at the time.

It's actually a good first-order approximation of the right thing to
do, as it will generally correlate with the userspace process
servicing that network load.

If not (for instance, with routing loads), then you'd basically expect
the charge to get spread around evenly in proportion to an
application's CPU usage.

The -rt kernel pushes most of the interrupt work off to threads, which
of course follow the same scheduling and accounting rules as
everything other thread.

-- =

Mathematics is the supreme nostalgia of our time.
