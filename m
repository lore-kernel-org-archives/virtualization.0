From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 02/16] adapt lguest launcher to per-cpuness
Date: Thu, 27 Dec 2007 11:08:24 +1100
Message-ID: <200712271108.25173.rusty__7461.06844530932$1198714242$gmane$org@rustcorp.com.au>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<200712261035.46939.rusty@rustcorp.com.au>
	<Pine.LNX.4.58.0712260915090.28862@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.58.0712260915090.28862@gandalf.stny.rr.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 27 December 2007 01:24:10 Steven Rostedt wrote:
> On Wed, 26 Dec 2007, Rusty Russell wrote:
> > On Friday 21 December 2007 00:33:42 Glauber de Oliveira Costa wrote:
> > > +		if (!vcpu_id) {
> > > +			/*
> > > +			 * Service input, then unset the BREAK to
> > > +			 * release the Waker.
> > > +			 */
> > > +			handle_input(lguest_fd);
> > > +			if (pwrite(lguest_fd, args, sizeof(args), 0) < 0)
> > > +				err(1, "Resetting break");
> > > +		}
> >
> > I hate winged comments: those two extra lines, wasted!
>
> For multiple lines, wings are a Good Thing (TM). Otherwise it looks
> sloppy.
>
>   /* Service input, then unset the BREAK to
>    * release the Waker. */
>
> extra asterisk! ok then

No, that is correct.  See all the rest of the lguest comments, or ask Dave 
Miller :)

Of course, if you can keep a comment concisely in one line, it's even better.  
But since colorizing editors are so common, the extra wings just steal 
vertical space.

> Some one buy Rusty a bigger hard-drive to store those extra lines.

More importantly, a bigger screen to hold the code :)

Cheers,
Rusty.
