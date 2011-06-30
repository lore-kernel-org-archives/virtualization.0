From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 00/40] Staging: hv: Driver cleanup
Date: Thu, 30 Jun 2011 23:32:34 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480816C384@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<20110630193346.GA22707@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110630193346.GA22707@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
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
> 
> For now your patches should probably go in as-is, but mid-term you
> should be able to completely remove that code on the storage side.
> 

Greg,

I am thinking of  going back to my original implementation where I had one scsi host
per IDE device. This will certainly simply the code. Let me know what you think. If you
agree with this approach, please drop this patch-set, I will send you a new set of patches.

Regards,

K. Y
