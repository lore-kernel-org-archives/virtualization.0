From: Greg KH <gregkh@suse.de>
Subject: Re: Regression: patch " hvc_console: display printk messages on
	console." causing infinite loop with 3.2-rc0 + Xen.
Date: Wed, 2 Nov 2011 18:30:12 -0700
Message-ID: <20111103013012.GB3449@suse.de>
References: <20111027053007.GA32765@phenom.dumpdata.com>
	<20111027054806.GA1377@suse.de>
	<20111102121309.4dbb0d2ac90d2879130820dd@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111102121309.4dbb0d2ac90d2879130820dd@canb.auug.org.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, miche@google.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Linus <torvalds@linux-foundation.org>, Anton Blanchard <anton@samba.org>, Amit Shah <amit.shah@redhat.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 02, 2011 at 12:13:09PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Thu, 27 Oct 2011 07:48:06 +0200 Greg KH <gregkh@suse.de> wrote:
> >
> > On Thu, Oct 27, 2011 at 01:30:08AM -0400, Konrad Rzeszutek Wilk wrote:
> > > Hey Miche.
> > > 
> > > The git commit 361162459f62dc0826b82c9690a741a940f457f0:
> > > 
> > >     hvc_console: display printk messages on console.
> > > 
> > > is causing an infinite loop when booting Linux under Xen, as so:
> > 
> > Ick, not good, thanks for letting us know.
> 
> Indeed. I am wondering why it was put in a tree and sent to Linus without
> any Acks or even being replied to by anyone.  It appeared in the tty tree
> between Oct 14 and Oct 25 (while I was unfortunately on vacation).  If
> anyone had tried to boot this on any PowerPC server, it would have been
> immediately obvious (as it was when I booted Linus' tree last night).
> 
> And the original author expressed doubts as to his understanding of how
> it should all work anyway.
> 
> Just a little more care, please.
> 
> I would vote for reverting the original and having it resubmitted with
> corrections at some later date.

You are right, I will go do that, sorry for the problems.

greg k-h
