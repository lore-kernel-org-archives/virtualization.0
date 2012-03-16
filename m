From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 2/4] Drivers: hv: Support the newly introduced KVP
 messages in the driver
Date: Fri, 16 Mar 2012 05:43:14 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481B766648@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1331422331-4381-1-git-send-email-kys@microsoft.com>
 <1331422331-4381-2-git-send-email-kys@microsoft.com>
 <20120311104230.GC3337@mwanda>
 <6E21E5352C11B742B20C142EB499E0481B75B403@TK5EX14MBXC122.redmond.corp.microsoft.com>
 <20120311184916.GD3337@mwanda>
 <6E21E5352C11B742B20C142EB499E0481B75D433@TK5EX14MBXC122.redmond.corp.microsoft.com>
 <20120312052221.GE3337@mwanda>
 <6E21E5352C11B742B20C142EB499E0481B75D4CE@TK5EX14MBXC122.redmond.corp.microsoft.com>
 <20120312130353.GF3337@mwanda>
 <6E21E5352C11B742B20C142EB499E0481B7663B1@TK5EX14MBXC126.redmond.corp.microsoft.com>
 <20120316053829.GG3163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120316053829.GG3163@mwanda>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "ohering@suse.com" <ohering@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Alan Stern <stern@rowland.harvard.edu>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Friday, March 16, 2012 1:38 AM
> To: KY Srinivasan
> Cc: gregkh@linuxfoundation.org; ohering@suse.com; linux-
> kernel@vger.kernel.org; virtualization@lists.osdl.org; Alan Stern;
> devel@linuxdriverproject.org
> Subject: Re: [PATCH 2/4] Drivers: hv: Support the newly introduced KVP
> messages in the driver
> 
> On Thu, Mar 15, 2012 at 11:36:16PM +0000, KY Srinivasan wrote:
> >
> > Dan,
> >
> > Sorry I could not get back to you earlier. You are right, in that I am trusting
> > the host! I am of the firm belief that in a virtualized environment, if you don't
> trust
> > the host, there is not a whole lot you can do in a guest! I have had this
> arguments
> > with other on this mailing list in the past. Having said that, I think we have spent
> more
> > time debating this than we should; your proposal is reasonable and I will go
> ahead and
> > re-spin those patches based on your comments. I should be posting them
> shortly.
> >
> > Regards,
> 
> It's not about trusting the host or not trusting the host.  It's
> about "if you're going to specify a limitter, it can't be off by one
> even if you don't expect to hit the limit".
> 
> But thanks for redoing these.

Thank you, for taking the time to review.

Regards,

K. Y
