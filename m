From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Staging: hv: Move the mouse driver out of staging
Date: Sat, 29 Oct 2011 14:09:55 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481AA5443E@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1319645321-9770-1-git-send-email-kys@microsoft.com>
	<alpine.LNX.2.00.1110282026360.3541@pobox.suse.cz>
	<6E21E5352C11B742B20C142EB499E0481AA531D4@TK5EX14MBXC122.redmond.corp.microsoft.com>
	<20111028200315.GA30918@suse.de>
	<6E21E5352C11B742B20C142EB499E0481AA53219@TK5EX14MBXC122.redmond.corp.microsoft.com>
	<20111029063409.GB2207@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20111029063409.GB2207@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Greg KH <gregkh@suse.de>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "ohering@suse.com" <ohering@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Saturday, October 29, 2011 2:34 AM
> To: KY Srinivasan
> Cc: Jiri Kosina; linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.osdl.org; ohering@suse.com; Dmitry Torokhov
> Subject: Re: [PATCH 1/1] Staging: hv: Move the mouse driver out of staging
> 
> On Fri, Oct 28, 2011 at 08:28:11PM +0000, KY Srinivasan wrote:
> > > > The guest cannot survive a malicious host; so I think it is safe to say that the
> > > > guest can assume the host is following the protocol.
> > >
> > > That's not good for a very large number of reasons, not the least being
> > > that we have no idea how secure the hyperv hypervisor is, so making it
> > > so that there isn't an obvious hole into linux through it, would be a
> > > good idea.
> > >
> > > And yes, I'd say the same thing if this was a KVM or Xen driver as well.
> > > Please be very defensive in this area of the code, especially as there
> > > are no performance issues here.
> >
> > In the chain of trust, the hypervisor and the host are the foundations
> > as far as the guest is concerned, since both the hypervisor and the host
> > can affect the guest in ways that the guest has no obvious way to protect itself.
> 
> That's true.
> 
> > If the hypervisor/host have security holes, there is not much you can do in the
> guest
> > to deal with it.
> > In this case, I can add checks but I am not sure how useful it is.
> 
> I would prefer to see them here, just to be safe, it can not hurt,
> right?

I have added a check in the patches I sent out yesterday.

Regards,

K. Y
> 
> 
> greg k-h
