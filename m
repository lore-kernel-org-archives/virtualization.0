From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [vmw_vmci 11/11] Apply the header code to make VMCI build
Date: Fri, 27 Jul 2012 21:53:20 +0200
Message-ID: <20120727195320.GA5822@merkur.ravnborg.org>
References: <20120727103455.GA4639@merkur.ravnborg.org>
	<1693394101.5749000.1343409643934.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1693394101.5749000.1343409643934.JavaMail.root@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Stiegmann <astiegmann@vmware.com>
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, vm-crosstalk@vmware.com, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

> > > +
> > > +#define CAN_BLOCK(_f) (!((_f) & VMCI_QPFLAG_NONBLOCK))
> > > +#define QP_PINNED(_f) ((_f) & VMCI_QPFLAG_PINNED)
> > 
> > Looks like poor obscufation.
> > Use a statis inline function if you need a helper for this.
> 
> These definitions are intended more as a helper to make reading the code easier.  IMHO ts a lot easier to read
> 
> if (CAN_BLOCK(flags))
> 
> compared to 
> 
> if (!(flags & VMCI_QPFLAG_NONBLOCK))
> 
> Wouldn't you agree?  I'm not sure something this simple warrants a static inline
> function but I don't see any harm in converting it over to that.

I would put it the other way around. I cannot see that such simple stuff warrants a #define.
A static inline is (almost) always preferable to hide code in a macro.

For once you get better type-checks.
And semantics are also much simpler. With a macro you can do so many silly things.

	Sam
