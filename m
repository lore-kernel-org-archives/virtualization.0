From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 08/14] Tools: hv: Gather DNS information
Date: Fri, 17 Aug 2012 09:51:09 -0700
Message-ID: <20120817165109.GA11323@kroah.com>
References: <1345167068-5461-1-git-send-email-kys@microsoft.com>
 <1345167145-5513-1-git-send-email-kys@microsoft.com>
 <1345167145-5513-8-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1345167145-5513-8-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com, ben@decadent.org.uk
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 16, 2012 at 06:32:19PM -0700, K. Y. Srinivasan wrote:
> Now, gather DNS information. Invoke an external script (that can be
> distro dependent) to gather the DNS information.

Where is that script?  Why a script, this really isn't in a standard
method for all Linux distros?  If not, why not work to do that like the
freedesktop.org people have done for other system configuration items?

greg k-h
