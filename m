From: Mark McLoughlin <markmc@redhat.com>
Subject: Re: [PATCH] xen: Enable Xen console by default in domU
Date: Fri, 11 Apr 2008 09:59:16 +0100
Message-ID: <1207904356.26445.8.camel@muff>
References: <87hcehshyc.fsf@pike.pond.sub.org>
	<87d4oxvhk0.fsf@pike.pond.sub.org>  <1207903945.26445.4.camel@muff>
Reply-To: Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1207903945.26445.4.camel@muff>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Markus Armbruster <armbru@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, mingo@redhat.com, adaplas@pol.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2008-04-11 at 09:52 +0100, Mark McLoughlin wrote:
> On Thu, 2008-04-10 at 17:46 +0200, Markus Armbruster wrote:
> > diff --git a/kernel/printk.c b/kernel/printk.c
> > index c46a20a..c07bfc1 100644
> > --- a/kernel/printk.c
> > +++ b/kernel/printk.c
> > @@ -118,6 +118,7 @@ struct console_cmdline
> >  static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
> >  static int selected_console = -1;
> >  static int preferred_console = -1;
> > +int console_set_on_cmdline;

You'd also need to export this symbol for the unusual case where fbfront
is a module ...

Cheers,
Mark.
