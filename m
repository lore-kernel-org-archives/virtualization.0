From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 08/14] Tools: hv: Gather DNS information
Date: Fri, 17 Aug 2012 09:55:39 -0700
Message-ID: <20120817165539.GB12361@kroah.com>
References: <1345167068-5461-1-git-send-email-kys@microsoft.com>
 <1345167145-5513-1-git-send-email-kys@microsoft.com>
 <1345167145-5513-8-git-send-email-kys@microsoft.com>
 <20120817165109.GA11323@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120817165109.GA11323@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: olaf@aepfle.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, apw@canonical.com, devel@linuxdriverproject.org, ben@decadent.org.uk
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 17, 2012 at 09:51:09AM -0700, Greg KH wrote:
> On Thu, Aug 16, 2012 at 06:32:19PM -0700, K. Y. Srinivasan wrote:
> > Now, gather DNS information. Invoke an external script (that can be
> > distro dependent) to gather the DNS information.
> 
> Where is that script?  Why a script, this really isn't in a standard
> method for all Linux distros?  If not, why not work to do that like the
> freedesktop.org people have done for other system configuration items?

And please, don't include <virtualization@lists.osdl.org> in your
patches anymore, it just constantly bounces as it's no longer valid (and
hasn't been for over 6 months).

It's really annoying.

greg k-h
