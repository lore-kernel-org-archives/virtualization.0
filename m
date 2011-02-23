From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 1/6] Staging: hv: vmbus_drv.c Replaced DPRINT with
	native pr_XXX
Date: Wed, 23 Feb 2011 20:20:32 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56233FADBBA@TK5EX14MBXC118.redmond.corp.microsoft.com>
References: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
	<20110223191135.GA1030@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110223191135.GA1030@kroah.com>
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
> Sent: Wednesday, February 23, 2011 11:12 AM
> To: Hank Janssen
> Why say this in the 1/6 patch?  It should be in the 0/6 introduction.
> 
> >
> > All DPRINT calls have been removed, and where needed have been
> > replaced with pr_XX native calls. Many debug DPRINT calls have
> > been removed outright.
> 
> I think a lot of these pr_XX calls can be switched to dev_XX calls
> instead, right?

Not in this case, this patch set is for vmbus only. The next patch
set will use netdev_* and dev* for netvsc, scsi and IDE.

> How about you break this up into a different series of patches to make
> it more readable:
> 	- remove unneeded DPRINT calls
> 	- convert remaining DPRINT calls to pr_XX or dev_XX as needed
> 
> That would make it easier to review, as it is, it's quite difficult.

Will do.

Hank.
