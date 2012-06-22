From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 00/13] drivers: hv: kvp
Date: Fri, 22 Jun 2012 13:06:53 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9155EC47A@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1340314200-27078-1-git-send-email-kys@microsoft.com>
 <20120621224737.GA5933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120621224737.GA5933@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "ohering@suse.com" <ohering@suse.com>, "apw@canonical.com" <apw@canonical.com>
List-Id: virtualization@lists.linuxfoundation.org

Are you still missing it; do you want me to resend the whole set?

K. Y

> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, June 21, 2012 6:48 PM
> To: KY Srinivasan
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.osdl.org; ohering@suse.com; apw@canonical.com
> Subject: Re: [PATCH 00/13] drivers: hv: kvp
> 
> On Thu, Jun 21, 2012 at 02:30:00PM -0700, K. Y. Srinivasan wrote:
> > This patchset expands the KVP (Key Value Pair) functionality to
> > implement the mechanism to get/set IP addresses in the guest. This
> > functionality is used in Windows Server 2012 to implement VM
> > replication functionality. The way IP configuration information
> > is managed is distro specific. The current implementation supports
> > RedHat way of doing things. We will expand support to other distros
> > incrementally.
> 
> I'm missing 09/13, did it get stuck somewhere?
> 
> 
