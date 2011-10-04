From: KY Srinivasan <kys@microsoft.com>
Subject: RE: Move hyperv out of the drivers/staging/ directory
Date: Tue, 4 Oct 2011 21:22:52 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081EBAB7@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1316708240-25048-1-git-send-email-kys@microsoft.com>
 <20110922170450.GA4490@suse.de>
 <6E21E5352C11B742B20C142EB499E048081E935D@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110922173618.GA5624@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB789@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004170415.GA1320@suse.de>
 <6E21E5352C11B742B20C142EB499E048081EB86F@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20111004193414.GA15672@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111004193414.GA15672@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Tuesday, October 04, 2011 3:34 PM
> To: KY Srinivasan
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.osdl.org
> Subject: Move hyperv out of the drivers/staging/ directory
> 
> KY, how about the following patch?

Looks good Greg. This morning Thomas informed me that he has checked in
my patch to integrate the time source driver with the Hyper-V detection code.
Thomas indicated that this patch has been applied to the tip already. How will this
be reflected in the staging tree?
 
> 
> Any objection from the virt developers about this?
> 
> KY, I'd like to get your signed-off-by before committing this, care to
> test this out and pass it around the other hyperv developers and then
> sign off on it?  Then I will be glad to commit this to my tree.

I have started the test cycle; I will let you know shortly what we discover.

Regards,

K. Y
