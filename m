From: Greg KH <greg@kroah.com>
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block device driver.
Date: Sat, 13 Jan 2007 23:43:08 -0800
Message-ID: <20070114074308.GC10585@kroah.com>
References: <20070113014539.408244126@goop.org>
	<20070113014649.256179743@goop.org>
	<1168736848.3123.352.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1168736848.3123.352.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jan 13, 2007 at 05:07:28PM -0800, Arjan van de Ven wrote:
> > +
> > +#define DPRINTK(_f, _a...) pr_debug(_f, ## _a)
> =

> why this silly abstraction? Just use pr_debug in the code directly

Actually, for drivers, like this one, you should use the dev_printk()
and friends (dev_dbg, dev_err, etc.) instead so that userspace knows
exactly which device and driver the message comes from.

thanks,

greg k-h
