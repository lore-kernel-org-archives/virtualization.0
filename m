From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] Staging: hv: Move the mouse driver out of staging
Date: Sat, 29 Oct 2011 08:34:09 +0200
Message-ID: <20111029063409.GB2207@suse.de>
References: <1319645321-9770-1-git-send-email-kys@microsoft.com>
	<alpine.LNX.2.00.1110282026360.3541@pobox.suse.cz>
	<6E21E5352C11B742B20C142EB499E0481AA531D4@TK5EX14MBXC122.redmond.corp.microsoft.com>
	<20111028200315.GA30918@suse.de>
	<6E21E5352C11B742B20C142EB499E0481AA53219@TK5EX14MBXC122.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481AA53219@TK5EX14MBXC122.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "ohering@suse.com" <ohering@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 28, 2011 at 08:28:11PM +0000, KY Srinivasan wrote:
> > > The guest cannot survive a malicious host; so I think it is safe to say that the
> > > guest can assume the host is following the protocol.
> > 
> > That's not good for a very large number of reasons, not the least being
> > that we have no idea how secure the hyperv hypervisor is, so making it
> > so that there isn't an obvious hole into linux through it, would be a
> > good idea.
> > 
> > And yes, I'd say the same thing if this was a KVM or Xen driver as well.
> > Please be very defensive in this area of the code, especially as there
> > are no performance issues here.
> 
> In the chain of trust, the hypervisor and the host are the foundations
> as far as the guest is concerned, since both the hypervisor and the host
> can affect the guest in ways that the guest has no obvious way to protect itself.

That's true.

> If the hypervisor/host have security holes, there is not much you can do in the guest
> to deal with it. 
> In this case, I can add checks but I am not sure how useful it is.

I would prefer to see them here, just to be safe, it can not hurt,
right?


greg k-h
