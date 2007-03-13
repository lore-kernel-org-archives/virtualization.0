From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 2/9] Sched clock paravirt op fix.patch
Date: Tue, 13 Mar 2007 09:07:09 -0700
Message-ID: <20070313160709.GH10574@sequoia.sous-sol.org>
References: <200703020254.l222sOaM009656@zach-dev.vmware.com>
	<20070313140129.GB92373@muc.de> <45F6C2A3.4040305@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45F6C2A3.4040305@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Daniel Walker <dwalker@mvista.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> In other words, regardless of whether this particular pv_op lives or
> dies, we're going to need to have to deal with stolen time properly.  I
> think this hook is reasonable and useful step towards doing that.

Exactly.  Normal interrupts we can handle.  Having CPU completely
disappear for unkown time periods we can't, and will need to.

thanks,
-chris
