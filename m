From: KY Srinivasan <kys@microsoft.com>
Subject: RE: 0xB16B00B5? Really? (was Re: Move hyperv out of the
 drivers/staging/ directory)
Date: Fri, 13 Jul 2012 13:21:26 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9223B580C@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1316708240-25048-1-git-send-email-kys@microsoft.com>
 <20110922170450.GA4490@suse.de>
 <6E21E5352C11B742B20C142EB499E048081E935D@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110922173618.GA5624@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004170415.GA1320@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB86F@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004193414.GA15672@suse.de> <4FFFF711.8040003@redhat.com>
 <426367E2313C2449837CD2DE46E7EAF9223B57EC@SN2PRD0310MB382.namprd03.prod.outlook.com>
 <50001F71.9070806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50001F71.9070806@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg KH <gregkh@suse.de>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> Sent: Friday, July 13, 2012 9:15 AM
> To: KY Srinivasan
> Cc: Greg KH; devel@linuxdriverproject.org; linux-kernel@vger.kernel.org;
> virtualization@lists.osdl.org
> Subject: Re: 0xB16B00B5? Really? (was Re: Move hyperv out of the
> drivers/staging/ directory)
> 
> Il 13/07/2012 15:13, KY Srinivasan ha scritto:
> >> >
> >> > Somone was trying to be funny, I guess.
> >> >
> >> > KY, I suppose you have access to Hyper-V code or can ask someone who
> does.
> >> > Is this signature actually used in the Hyper-V host code?
> > It is still early in the morning here and pardon me if I am not seeing the issue.
> 
> [offlist]
> 
> 0xB16B00B5 = big boobs

Ok! I don't know how easy it is to change this. If I remember correctly, I think on our Cloud
(Azure), the guest ID may be currently used in our management stack.

Regards,

K. Y
