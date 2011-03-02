From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 6/6] Staging: hv: Cleanup hyperv_driver variable names
Date: Wed, 2 Mar 2011 01:44:11 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048016633@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1298686078-30945-1-git-send-email-kys@microsoft.com>
	<20110301025859.GG1663@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110301025859.GG1663@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, February 28, 2011 9:59 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang; Hank
> Janssen
> Subject: Re: [PATCH 6/6] Staging: hv: Cleanup hyperv_driver variable names
> 
> On Fri, Feb 25, 2011 at 06:07:58PM -0800, K. Y. Srinivasan wrote:
> > The title says it all.
> 
> That's a horrible changelog comment.  So bad that I would rather see an
> empty message than this one.  Seriously, it give no description, and
> makes us think that the whole patch is obvious, when it really isn't.
> 
> What did you change them to?
> What did you change them from?
> What was your motivation in changing them?
> How were you feeling when the names changed?
> 
> Ok, maybe not the last one, but you get the idea.

Greg, these changes (patches 1 through 6) change so much in this
sub-system that until these changes go in, our cleanup efforts are stalled. That
is the main reason I was so hasty in submitting these patches.
Clearly, I need to provide a better changelog comment; and I will. Looking at your 
other comments, I am wondering if the granularity I chose for breaking up the 
changes that had to be done  is also a significant part of the problem. If it is ok with you,
I could generate a  patch that deals with all device related issues and a patch that deals with
all driver related issues. These patches obviously will  do more than one thing (however
they will all be related); but at least they
won't have intermediate state that would be objectionable. Let me know.

Regards,

K. Y
