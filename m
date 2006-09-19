From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: Tue, 19 Sep 2006 14:08:20 -0700
Message-ID: <20060919210820.GC7474@sequoia.sous-sol.org>
References: <1158635617.21726.8.camel@localhost.localdomain>
	<20060919203757.GA7474@sequoia.sous-sol.org>
	<451055AC.4050407@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <451055AC.4050407@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Chris Wright wrote:
> > Seems you or Jeremy pushed an unmerged head to the queue.  Please don't
> > do that, it makes life going forward a mess.  I'm merging it, will push
> > the result so best double check it.
> =

> I don't think we should merge it now.  There are enough other things =

> broken before adding more complexity.

No, I just mean merge in the queue (which means I'll drop the series
changes that Rusty made, otherwise it should have zero overlap).
Otherwise mercurial gets unhappy with unmerged heads.

thanks,
-chris
