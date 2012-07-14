From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 12/15] Tools: hv: Gather DHCP information
Date: Sat, 14 Jul 2012 23:02:24 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9223B7004@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1342297930-12607-1-git-send-email-kys@microsoft.com>
 <1342298060-12662-1-git-send-email-kys@microsoft.com>
 <1342298060-12662-12-git-send-email-kys@microsoft.com>
 <CAFLxGvxkidfN+o8yFsmGm8-YhT4Q5dgzQOAJJXnM=nXoXVpqTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAFLxGvxkidfN+o8yFsmGm8-YhT4Q5dgzQOAJJXnM=nXoXVpqTA@mail.gmail.com>
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
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: richard -rw- weinberger [mailto:richard.weinberger@gmail.com]
> Sent: Saturday, July 14, 2012 5:37 PM
> To: KY Srinivasan
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; olaf@aepfle.de;
> apw@canonical.com
> Subject: Re: [PATCH 12/15] Tools: hv: Gather DHCP information
> 
> On Sat, Jul 14, 2012 at 10:34 PM, K. Y. Srinivasan <kys@microsoft.com> wrote:
> > Collect information on dhcp setting for the specified interface.
> > We invoke an exyernal script to get this information.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  tools/hv/hv_kvp_daemon.c |   33 +++++++++++++++++++++++++++++++++
> >  1 files changed, 33 insertions(+), 0 deletions(-)
> >
> > diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> > index a81ce67..c510283 100644
> > --- a/tools/hv/hv_kvp_daemon.c
> > +++ b/tools/hv/hv_kvp_daemon.c
> > @@ -524,6 +524,9 @@ static void kvp_get_ipconfig_info(char *if_name,
> >                                  struct hv_kvp_ipaddr_value *buffer)
> >  {
> >         char cmd[512];
> > +       char dhcp_info[128];
> > +       char *p;
> > +       FILE *file;
> >
> >         /*
> >          * Get the address of default gateway (ipv4).
> > @@ -580,6 +583,36 @@ static void kvp_get_ipconfig_info(char *if_name,
> >          */
> >         kvp_process_ipconfig_file(cmd, (char *)buffer->dns_addr,
> >                                 (MAX_IP_ADDR_SIZE * 2), INET_ADDRSTRLEN, 0);
> > +
> > +       /*
> > +        * Gather the DHCP state.
> > +        * We will gather this state by invoking an external script.
> > +        * The parameter to the script is the interface name.
> > +        * Here is the expected output:
> > +        *
> > +        * Enabled: DHCP enabled.
> > +        */
> > +
> > +       memset(cmd, 0, 512);
> 
> Why not sizeof(cmd)?

I have a bunch of other cleanups lined up for this user level daemon. If it is
ok with you, I could address this as part of that patch set. However, if 
there are more substantive changes needed in this patch-set, I will
also address this. 

Thank you,

K. Y
