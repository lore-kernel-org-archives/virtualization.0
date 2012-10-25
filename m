From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Pv-drivers] [PATCH 04/10] VMCI: device driver implementaton.
Date: Thu, 25 Oct 2012 13:31:48 -0700
Message-ID: <20121025203148.GA28096@kroah.com>
References: <20121025192851.GA26627@kroah.com>
	<574849395.2604157.1351196160882.JavaMail.root@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <574849395.2604157.1351196160882.JavaMail.root@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy King <acking@vmware.com>
Cc: pv-drivers@vmware.com, vm-crosstalk@vmware.com, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 25, 2012 at 01:16:00PM -0700, Andy King wrote:
> Hi Greg,
> 
> > > +EXPORT_SYMBOL(vmci_device_get);
> > 
> > EXPORT_SYMBOL_GPL() for this, and all other exports?
> 
> We'd prefer to leave them as vanilla exports.  While we're committed
> to open-sourcing everything, including our non-upstreamed drivers,
> we don't really have a strong opinion regarding consuming our exports
> in closed-source (general GPL issues aside).

You can't just say "general GPL issues aside".  Honestly, given your
company's prior actions in regards to Linux kernel drivers and the
licenses of them, I don't trust them at all.  To help gain that trust
back, marking the exports in this manner will be a great improvement.

To insist otherwise is to only reinforce my doubts, and reduce my
wanting to even review or accept this code at all.  Sorry about that.

> > And it seems that you have a bunch of "unused" parameters for this,
> > and other public functions.  Please just remove them entirely.
> 
> Will do.
> 
> Also, regarding that particular public function, it seems to have slipped
> through the cracks.  It's an artifact of the API being cross-platform
> prior to upstreaming.  On Linux, it makes no sense whatsoever, so we'll
> just yank it completely.

What other calls can be removed?  Did you run sparse on all of these
files to ensure that things are "clean" with regards to static functions
and the like?

thanks,

greg k-h
