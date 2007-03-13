From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 2/9] Sched clock paravirt op fix.patch
Date: Tue, 13 Mar 2007 12:37:53 -0400
Message-ID: <45F6D361.8080106@redhat.com>
References: <200703020254.l222sOaM009656@zach-dev.vmware.com>	<20070313140129.GB92373@muc.de>
	<45F6C2A3.4040305@goop.org>	<20070313160709.GH10574@sequoia.sous-sol.org>
	<20070313161656.GA12128@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070313161656.GA12128@muc.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@muc.de>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Daniel Walker <dwalker@mvista.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> On Tue, Mar 13, 2007 at 09:07:09AM -0700, Chris Wright wrote:
>> * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
>>> In other words, regardless of whether this particular pv_op lives or
>>> dies, we're going to need to have to deal with stolen time properly.  I
>>> think this hook is reasonable and useful step towards doing that.
>> Exactly.  Normal interrupts we can handle.  Having CPU completely
>> disappear for unkown time periods we can't, and will need to.
> =

> But that is just what a interrupt is.

Interrupts tend to be reasonably short though.

Steal time can be several hypervisor/host time slices long.

As an aside, normal interrupts *are* accounted for separately
in /proc/stat, so why not steal time too?

-- =

Politics is the struggle between those who want to make their country
the best in the world, and those who believe it already is.  Each group
calls the other unpatriotic.
