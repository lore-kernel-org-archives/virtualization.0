From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH V3 08/14] Tools: hv: Gather DNS information
Date: Wed, 22 Aug 2012 15:45:31 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9236C3FF4@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1345167068-5461-1-git-send-email-kys@microsoft.com>
 <1345167145-5513-1-git-send-email-kys@microsoft.com>
 <1345167145-5513-8-git-send-email-kys@microsoft.com>
 <20120817165109.GA11323@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120817165109.GA11323@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "ben@decadent.org.uk" <ben@decadent.org.uk>, "Thomas Graf (tgraf@redhat.com)" <tgraf@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Friday, August 17, 2012 12:51 PM
> To: KY Srinivasan
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.osdl.org; olaf@aepfle.de; apw@canonical.com;
> ben@decadent.org.uk
> Subject: Re: [PATCH V3 08/14] Tools: hv: Gather DNS information
> 
> On Thu, Aug 16, 2012 at 06:32:19PM -0700, K. Y. Srinivasan wrote:
> > Now, gather DNS information. Invoke an external script (that can be
> > distro dependent) to gather the DNS information.
> 
> Where is that script? 

If you think it is useful, I could send you the scripts that I have used to test this
functionality as example scripts. 
  
> Why a script, this really isn't in a standard
> method for all Linux distros?  If not, why not work to do that like the
> freedesktop.org people have done for other system configuration items?

When discussing this while preparing the patches it was clear that there
really is no single way to obtain the network information, if you are
using network manager you need to use dbus, basic debian networking as
on a server you need to look in /etc/resolv.conf, if you have dnsmasq
installed you need to look in a third place.  On the SLES side that I am somewhat 
familiar with, if I recall correctly, none of the appliance images have Network Manager installed.
The consensus was that  we should avoid pulling a vast pile of distro smarts into the source which
lead to the hook API proposed in these patches.

The approach chosen here does not preclude using Network Manager in the external scripts
if a particular distro chooses to go that route. The current implementation supports maximum
flexibility without sacrificing anything. While the current scripts I have do not use NM APIs, we could
work on external scripts using DBUS APIs.

If it is ok with you, I could send you the remaining 7 patches along with the scripts I am
currently using to test this code. These scripts should be viewed just example code. 

Regards,

K. Y

 
