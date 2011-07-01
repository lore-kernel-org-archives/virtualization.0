From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 24/40] Staging: hv: storvsc: On I/O get the correct IDE
 device
Date: Fri, 1 Jul 2011 13:01:43 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0480816C460@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-1-git-send-email-kys@microsoft.com>
 <1309358377-8537-24-git-send-email-kys@microsoft.com>
 <20110630194055.GC22707@infradead.org>
 <6E21E5352C11B742B20C142EB499E0480816C2CF@TK5EX14MBXC126.redmond.corp.microsoft.com>
 <20110701081725.GC28322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110701081725.GC28322@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Friday, July 01, 2011 4:17 AM
> To: KY Srinivasan
> Cc: Christoph Hellwig; gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang;
> Abhishek Kane (Mindtree Consulting PVT LTD); Hank Janssen
> Subject: Re: [PATCH 24/40] Staging: hv: storvsc: On I/O get the correct IDE device
> 
> On Thu, Jun 30, 2011 at 09:15:54PM +0000, KY Srinivasan wrote:
> > That is what I did initially. Then looking at the way we  were handling scsi
> devices
> > where each scsi controller configured for the guest results in an emulated HBA
> > (scsi host) in the guest and all the block devices under a given controller are
> > handled through this one host, I decided to mimic a similar structure  - one
> > scsi host for all the block devices configured as an IDE device.
> >
> > I can go back to my earlier implementation with one host per disk.
> 
> Was there any downside you noticed from using one host per emulated
> disk?
Nothing I could see from whatever testing I did. However, the guest will have
Scsi hosts that the user did not configure. This is certainly the case in both 
approaches - just the numbers are different!

K. Y 
