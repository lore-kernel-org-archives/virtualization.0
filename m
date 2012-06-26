From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/13] drivers: hv: kvp
Date: Tue, 26 Jun 2012 15:22:05 -0700
Message-ID: <20120626222205.GA5948@kroah.com>
References: <1340314200-27078-1-git-send-email-kys@microsoft.com>
 <20120621224737.GA5933@kroah.com>
 <426367E2313C2449837CD2DE46E7EAF9155EC47A@SN2PRD0310MB382.namprd03.prod.outlook.com>
 <20120622132547.GA2639@kroah.com>
 <426367E2313C2449837CD2DE46E7EAF9155ED14D@SN2PRD0310MB382.namprd03.prod.outlook.com>
 <20120626213954.GA4840@kroah.com>
 <426367E2313C2449837CD2DE46E7EAF9155ED64A@SN2PRD0310MB382.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <426367E2313C2449837CD2DE46E7EAF9155ED64A@SN2PRD0310MB382.namprd03.prod.outlook.com>
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
Cc: "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "ohering@suse.com" <ohering@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 26, 2012 at 10:11:55PM +0000, KY Srinivasan wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Tuesday, June 26, 2012 5:40 PM
> > To: KY Srinivasan
> > Cc: apw@canonical.com; devel@linuxdriverproject.org;
> > virtualization@lists.osdl.org; ohering@suse.com; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 00/13] drivers: hv: kvp
> > 
> > On Tue, Jun 26, 2012 at 02:29:49AM +0000, KY Srinivasan wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > > > Sent: Friday, June 22, 2012 9:26 AM
> > > > To: KY Srinivasan
> > > > Cc: apw@canonical.com; devel@linuxdriverproject.org; ohering@suse.com;
> > > > linux-kernel@vger.kernel.org; virtualization@lists.osdl.org
> > > > Subject: Re: [PATCH 00/13] drivers: hv: kvp
> > > >
> > > > On Fri, Jun 22, 2012 at 01:06:53PM +0000, KY Srinivasan wrote:
> > > > > Are you still missing it; do you want me to resend the whole set?
> > > >
> > > > Nope, it showed up a few hours later, thanks.  You really should get
> > > > that fixed...
> > >
> > > Greg, some additional testing with VM replication on Windows Server
> > > 2012 has revealed some issues with this patch-set. Please drop the
> > > patch set, I will  fix the problem and resend it.
> > 
> > Thanks for letting me know, now dropped.
> > 
> > But, for the next round, I suggest you run this patchset by the netdev
> > developers, as I think you are doing things in an "odd" way for some of
> > the ip determination.
> 
> Will do. Just curious;  can you be more explicit on what part appeared "odd"
> to you.

The fact that it was Red Hat specific was the main part, this should be
done in a standard way, with standard tools, right?

greg k-h
