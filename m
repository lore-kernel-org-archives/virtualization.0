From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Pv-drivers] [PATCH 12/12] VMCI: Some header and config files.
Date: Fri, 30 Nov 2012 12:44:06 -0800
Message-ID: <20121130204406.GB32321__40458.5167103962$1354308313$gmane$org@kroah.com>
References: <20121127002357.GA27683@core.coreip.homeip.net>
	<27667508.9ZL27Yq4ZC@dtor-d630.eng.vmware.com>
	<20121130185755.GA26841@kroah.com>
	<20121130200940.GA12740@dtor-ws.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121130200940.GA12740@dtor-ws.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dtor@vmware.com>
Cc: pv-drivers@vmware.com, Andy King <acking@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 30, 2012 at 12:09:40PM -0800, Dmitry Torokhov wrote:
> On Friday, November 30, 2012 10:57:55 AM Greg KH wrote:
> > On Fri, Nov 30, 2012 at 10:45:44AM -0800, Dmitry Torokhov wrote:
> > > However you snipped the rest of my reply: do we really need to renumber
> > > ioctls? There is no benefit for the driver as its ioctl handler does
> > > not parse the numbers into components.
> > 
> > I don't know if you need to renumber, I really don't understand what you
> > were trying to do with this code, and as it was acting differently from
> > all other kernel ioctl declarations, I asked for some clarity.
> > 
> > If you can rewrite it to look sane, and keep the same numbers, that's
> > fine with me.
> 
> OK, it looks like we can redo them as:
> 
> #define IOCTL_VMCI_VERSION		_IO(7, 0x9f)    /* 1951 */
> #define IOCTL_VMCI_INIT_CONTEXT		_IO(7, 0xa0)    /* 1952 */
> 
> Is this acceptable?

Sure, that's better.  You also got lucky, '7' happens to be unused right
now.

greg k-h
