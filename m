From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 00/13] drivers: hv: kvp
Date: Fri, 22 Jun 2012 18:54:34 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9155EC53B@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1340314200-27078-1-git-send-email-kys@microsoft.com>
 <alpine.LNX.2.00.1206220125410.7671@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <alpine.LNX.2.00.1206220125410.7671@swampdragon.chaosbits.net>
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
To: Jesper Juhl <jj@chaosbits.net>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "ohering@suse.com" <ohering@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Jesper Juhl [mailto:jj@chaosbits.net]
> Sent: Thursday, June 21, 2012 7:31 PM
> To: KY Srinivasan
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; ohering@suse.com;
> apw@canonical.com
> Subject: Re: [PATCH 00/13] drivers: hv: kvp
> 
> On Thu, 21 Jun 2012, K. Y. Srinivasan wrote:
> 
> > This patchset expands the KVP (Key Value Pair) functionality to
> > implement the mechanism to get/set IP addresses in the guest. This
> > functionality is used in Windows Server 2012 to implement VM
> > replication functionality. The way IP configuration information
> > is managed is distro specific. The current implementation supports
> > RedHat way of doing things. We will expand support to other distros
> > incrementally.
> >
> So there is going to be a continuous flow of patches to add support for
> new distros (Arch Linux, Slackware, Linux Mint, SuSE, Debian, etc etc) and
> if different versions of a distro handles things differently then you are
> also going to deal with that? Might be fine, but it just sounds a bit
> scary to me to try to support m different distros, each in n different
> versions from the kernel... Couldn't this somehow be done once and for all
> in a distro neutral way?
> Just asking :-)

Most of the code is not going to be distro specific. Obviously the kernel component
Is not distro specific. To the extent that the way the IP configuration state is managed
differently across distros, the user level component of the KVP code needs to 
accommodate that. Even here most of the code is distro independent. 

Regards,

K. Y
