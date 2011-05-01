From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
Date: Sun, 1 May 2011 18:08:37 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481DF2A0@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <20110426232843.GA31184@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481DD185@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110427064550.GA597@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DD266@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110427121856.GA20633@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DD676@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110429164025.GA7698@kroah.com> <20110501154041.GB15210@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DF253@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110501160721.GA8195@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110501160721.GA8195@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Sunday, May 01, 2011 12:07 PM
> To: KY Srinivasan
> Cc: Christoph Hellwig; Greg KH; gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
> 
> On Sun, May 01, 2011 at 03:46:23PM +0000, KY Srinivasan wrote:
> > What is the issue here? This is no different than what is done in other
> > Virtualization platforms. For instance, the Xen blkfront driver is no
> > different - if you specify the block device to be presented to the guest
> > as an ide device, it will register for the appropriate ide major number.
> 
> No, it won't - at least not in mainline just because it's so buggy.
> If distros keep that crap around I can only recommed you to not use
> them.

Christoph,

Could you elaborate on the problems/issues when the block driver registers for the 
IDE majors. On the Qemu side, we have a mechanism to disable the emulation when 
PV drivers load. I don't think there is an equivalent mechanism on the Windows side.
So, as far as I know, registering for the IDE majors is the only way to also prevent native
drivers in Linux from taking control of the emulated device. 

Regards,

K. Y 
