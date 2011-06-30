From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 00/40] Staging: hv: Driver cleanup
Date: Thu, 30 Jun 2011 23:28:27 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480816C36D@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <20110630193346.GA22707@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110630193346.GA22707@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Thursday, June 30, 2011 3:34 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 00/40] Staging: hv: Driver cleanup
> 
> On Wed, Jun 29, 2011 at 07:38:21AM -0700, K. Y. Srinivasan wrote:
> > Further cleanup of the hv drivers:
> >
> > 	1) Cleanup the reference counting mess for both stor and net devices.
> 
> I really don't understand the need for reference counting on the storage
> side, especially now that you only have a SCSI driver.  The SCSI
> midlayer does proper counting on it's objects (Scsi_Host, scsi_device,
> scsi_cmnd), so you'll get that for free given that SCSI drivers just
> piggyback on the midlayer lifetime rules.

The reference counting allows us to properly deal with messages coming back from the host
to the guest with a racing remove of the device. I am told these messages could potentially be
not a response to a message sent from the guest.

> 
> For now your patches should probably go in as-is, but mid-term you
> should be able to completely remove that code on the storage side.
> 

Thanks. Sure, we will always try to simplify the code.

Regards,

K. Y
