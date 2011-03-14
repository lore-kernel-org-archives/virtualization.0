From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 11/21] Staging: hv: Make vmbus driver a platform pci
 driver
Date: Mon, 14 Mar 2011 12:43:33 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480191D2@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1299794912-1233-1-git-send-email-kys@microsoft.com>
 <20110310222034.GA19323@suse.de>
 <6E21E5352C11B742B20C142EB499E048018AA3@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20110310223256.GA8669@suse.de>
 <6E21E5352C11B742B20C142EB499E048018F4D@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20110314032437.GA18645@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110314032437.GA18645@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Sunday, March 13, 2011 11:25 PM
> To: KY Srinivasan
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.osdl.org; Haiyang Zhang; Mike Sterling; Abhishek Kane
> (Mindtree Consulting PVT LTD); Hank Janssen
> Subject: Re: [PATCH 11/21] Staging: hv: Make vmbus driver a platform pci driver
> 
> On Sat, Mar 12, 2011 at 11:23:05PM +0000, KY Srinivasan wrote:
> > Greg, I have redone this patch as well as [PATCH 12/21]. Do you want
> > me send you just these two patches or the entire series including
> > these two.
> 
> Just resend those two patches if that is easier.

Will do.
> 
> > Also, does this patch-set address all of architectural issues you had
> > noted earlier in the vmbus core. Please let us know what else needs to
> > be done to exit staging as far as the vmbus driver is concerned. I
> > want get a head start before the new week begins! Also, we have
> > patches ready for all DPRINT cleanup. Hank is holding them off until
> > we finish addressing the architectural issues first.
> 
> I do not know if this addresses everything, sorry, I have not had the
> time to review all of them yet.  Give me a few days at the least to go
> over them and apply them before I will be able to tell you this.

Thanks for taking the time to look at this.

> 
> Also note that there shouldn't be anything holding back the DPRINT
> stuff, why wait?  If they apply on top of yours that should be fine,
> right?

You are right. We will submit the DPRINT patches soon.

Regards,

K. Y 
