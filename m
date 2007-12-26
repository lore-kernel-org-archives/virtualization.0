From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 02/16] adapt lguest launcher to per-cpuness
Date: Wed, 26 Dec 2007 09:24:10 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0712260915090.28862__20151.8407477581$1198679209$gmane$org@gandalf.stny.rr.com>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<11981576442148-git-send-email-gcosta@redhat.com>
	<11981576492807-git-send-email-gcosta@redhat.com>
	<200712261035.46939.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712261035.46939.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On Wed, 26 Dec 2007, Rusty Russell wrote:

> On Friday 21 December 2007 00:33:42 Glauber de Oliveira Costa wrote:
> > +		if (!vcpu_id) {
> > +			/*
> > +			 * Service input, then unset the BREAK to
> > +			 * release the Waker.
> > +			 */
> > +			handle_input(lguest_fd);
> > +			if (pwrite(lguest_fd, args, sizeof(args), 0) < 0)
> > +				err(1, "Resetting break");
> > +		}
>
> I hate winged comments: those two extra lines, wasted!
>

For multiple lines, wings are a Good Thing (TM). Otherwise it looks
sloppy.

  /* Service input, then unset the BREAK to
   * release the Waker. */

extra asterisk! ok then

  /* Service input, then unset the BREAK to
     release the Waker. */

Yuck, that "release" looks like it can be code, especially with parsers
that look for comments that start with some sort of /* or *

Those little wings do IMHO make the code look nicer. I know in the Linux
community, my weight compared to you is a chihuahua compared to a
St. Bernard.  But in this case, I believe others think that my collar is
prettier than yours. ;-)

Some one buy Rusty a bigger hard-drive to store those extra lines.

-- Steve
