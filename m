From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 9/10] Vmi timer update.patch
Date: Tue, 10 Apr 2007 15:38:12 -0700
Message-ID: <20070410223812.GT10574@sequoia.sous-sol.org>
References: <200704100006.l3A06RUR020644@zach-dev.vmware.com>
	<20070410023702.GJ10574@sequoia.sous-sol.org>
	<461BC373.10306@vmware.com>
	<20070410172429.GN10574@sequoia.sous-sol.org>
	<461C084C.9020009@vmware.com> <461C0CB4.9000407@goop.org>
	<461C0F76.1070308@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <461C0F76.1070308@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Thomas Gleixner <tglx@linutronix.de>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

* Zachary Amsden (zach@vmware.com) wrote:
> Jeremy Fitzhardinge wrote:
> >Why not submit a patch to do what you need here?  (The Geode comment is
> >a bit worrying though.)
> =

> Why should VMI add workaround into PIT code?

I'm not sure it's a workaround, seems more like a subtle diff (perhaps
it's just an oversight).  I need to rectify it anyway when merging in
the x86_64 version.  It's the way the x86_64 code is working already.
Shutdown for most clockevents tells device to stop ticking.
