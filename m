From: KY Srinivasan <kys@microsoft.com>
Subject: RE: 0xB16B00B5? Really? (was Re: Move hyperv out of the
 drivers/staging/ directory)
Date: Fri, 13 Jul 2012 13:13:42 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9223B57EC@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1316708240-25048-1-git-send-email-kys@microsoft.com>
 <20110922170450.GA4490@suse.de>
 <6E21E5352C11B742B20C142EB499E048081E935D@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110922173618.GA5624@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004170415.GA1320@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB86F@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004193414.GA15672@suse.de> <4FFFF711.8040003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FFFF711.8040003@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg KH <gregkh@suse.de>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo
> Bonzini
> Sent: Friday, July 13, 2012 6:23 AM
> To: KY Srinivasan
> Cc: Greg KH; devel@linuxdriverproject.org; linux-kernel@vger.kernel.org;
> virtualization@lists.osdl.org
> Subject: 0xB16B00B5? Really? (was Re: Move hyperv out of the drivers/staging/
> directory)
> 
> Il 04/10/2011 21:34, Greg KH ha scritto:
> > diff --git a/drivers/staging/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> > similarity index 99%
> > rename from drivers/staging/hv/hyperv_vmbus.h
> > rename to drivers/hv/hyperv_vmbus.h
> > index 3d2d836..8261cb6 100644
> > --- a/drivers/staging/hv/hyperv_vmbus.h
> > +++ b/drivers/hv/hyperv_vmbus.h
> > @@ -28,8 +28,7 @@
> >  #include <linux/list.h>
> >  #include <asm/sync_bitops.h>
> >  #include <linux/atomic.h>
> > -
> > -#include "hyperv.h"
> > +#include <linux/hyperv.h>
> >
> >  /*
> >   * The below CPUID leaves are present if
> VersionAndFeatures.HypervisorPresent
> 
> git's rename detection snips away this gem:
> 
> +#define HV_LINUX_GUEST_ID_LO		0x00000000
> +#define HV_LINUX_GUEST_ID_HI		0xB16B00B5
> +#define HV_LINUX_GUEST_ID		(((u64)HV_LINUX_GUEST_ID_HI
> << 32) | \
> +					   HV_LINUX_GUEST_ID_LO)
> 
> Somone was trying to be funny, I guess.
> 
> KY, I suppose you have access to Hyper-V code or can ask someone who does.
> Is this signature actually used in the Hyper-V host code?

It is still early in the morning here and pardon me if I am not seeing the issue.
Could you elaborate on what you want changed and why. This is a guest
signature that is stashed away in the hypervisor and perhaps can be retrieved
by the host. Other than that, this is not used anywhere else. MSFT has defined a
a namespace for guest IDs and while some ranges are reserved for MSFT operating
systems, there really is nothing special about the guest ID.

Regards,

K. Y
