From: KY Srinivasan <kys@microsoft.com>
Subject: RE: 0xB16B00B5? Really? (was Re: Move hyperv out of the
 drivers/staging/ directory)
Date: Thu, 19 Jul 2012 21:22:53 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9235475EE@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1316708240-25048-1-git-send-email-kys@microsoft.com>
 <20110922170450.GA4490@suse.de>
 <6E21E5352C11B742B20C142EB499E048081E935D@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110922173618.GA5624@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004170415.GA1320@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB86F@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004193414.GA15672@suse.de> <4FFFF711.8040003@redhat.com>
 <426367E2313C2449837CD2DE46E7EAF923547292@SN2PRD0310MB382.namprd03.prod.outlook.com>
 <20120719210709.GA32031@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120719210709.GA32031@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH (gregkh@linuxfoundation.org)
> [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, July 19, 2012 5:07 PM
> To: KY Srinivasan
> Cc: Paolo Bonzini; devel@linuxdriverproject.org; linux-kernel@vger.kernel.org;
> virtualization@lists.osdl.org
> Subject: Re: 0xB16B00B5? Really? (was Re: Move hyperv out of the
> drivers/staging/ directory)
> 
> On Thu, Jul 19, 2012 at 02:11:47AM +0000, KY Srinivasan wrote:
> >
> >
> > > -----Original Message-----
> > > From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo
> > > Bonzini
> > > Sent: Friday, July 13, 2012 6:23 AM
> > > To: KY Srinivasan
> > > Cc: Greg KH; devel@linuxdriverproject.org; linux-kernel@vger.kernel.org;
> > > virtualization@lists.osdl.org
> > > Subject: 0xB16B00B5? Really? (was Re: Move hyperv out of the
> drivers/staging/
> > > directory)
> > >
> > > Il 04/10/2011 21:34, Greg KH ha scritto:
> > > > diff --git a/drivers/staging/hv/hyperv_vmbus.h
> b/drivers/hv/hyperv_vmbus.h
> > > > similarity index 99%
> > > > rename from drivers/staging/hv/hyperv_vmbus.h
> > > > rename to drivers/hv/hyperv_vmbus.h
> > > > index 3d2d836..8261cb6 100644
> > > > --- a/drivers/staging/hv/hyperv_vmbus.h
> > > > +++ b/drivers/hv/hyperv_vmbus.h
> > > > @@ -28,8 +28,7 @@
> > > >  #include <linux/list.h>
> > > >  #include <asm/sync_bitops.h>
> > > >  #include <linux/atomic.h>
> > > > -
> > > > -#include "hyperv.h"
> > > > +#include <linux/hyperv.h>
> > > >
> > > >  /*
> > > >   * The below CPUID leaves are present if
> > > VersionAndFeatures.HypervisorPresent
> > >
> > > git's rename detection snips away this gem:
> > >
> > > +#define HV_LINUX_GUEST_ID_LO		0x00000000
> > > +#define HV_LINUX_GUEST_ID_HI		0xB16B00B5
> > > +#define HV_LINUX_GUEST_ID		(((u64)HV_LINUX_GUEST_ID_HI
> > > << 32) | \
> > > +					   HV_LINUX_GUEST_ID_LO)
> > >
> > > Somone was trying to be funny, I guess.
> > >
> > > KY, I suppose you have access to Hyper-V code or can ask someone who
> does.
> > > Is this signature actually used in the Hyper-V host code?
> >
> > Paolo,
> >
> > As I noted earlier, this is just a guest ID that needs to be registered with the
> > hypervisor.  Thanks  for reporting this issue and on behalf of Microsoft, I would
> > like to  apologize for this offensive string. I have submitted a patch to fix this
> issue.
> 
> You only changed it to be in decimal, you did not change the id at all.
> Is there some reason why you can not change it?  You said there was a
> reserved range of ids that could be used, perhaps just pick another one?
> What is the valid range that can be used here?

Greg,

As you know, this ID has been in use for a long time now. While the hypervisor
does not interpret the guest ID that is registered, I am not sure what dependencies
there might be on this value. That is the reason I am reluctant to change the value.
Since the hex representation of this constant was what was offensive, changing it to
a decimal number would not break anything while simultaneously addressing the issue
Paolo brought up. 


Regards,

K. Y 
