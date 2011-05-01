From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
Date: Sun, 1 May 2011 16:53:15 -0400
Message-ID: <20110501205315.GC1017@infradead.org>
References: <6E21E5352C11B742B20C142EB499E0481DD185@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110427064550.GA597@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DD266@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110427121856.GA20633@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DD676@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110429164025.GA7698@kroah.com>
 <20110501154041.GB15210@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DF253@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110501160721.GA8195@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DF2A0@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481DF2A0@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Greg KH <greg@kroah.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, May 01, 2011 at 06:08:37PM +0000, KY Srinivasan wrote:
> Could you elaborate on the problems/issues when the block driver registers for the 
> IDE majors. On the Qemu side, we have a mechanism to disable the emulation when 
> PV drivers load. I don't think there is an equivalent mechanism on the Windows side.
> So, as far as I know, registering for the IDE majors is the only way to also prevent native
> drivers in Linux from taking control of the emulated device. 

What qemu are you talking about for the qemu side?  Upstream qemu
doesn't have any way to provide the same image as multiple devices,
nevermind dynamically unplugging bits in that case.  Nor does it support
the hyperv devices.

When you steal majors you rely on:

 a) loading earlier than the driver you steal them from
 b) the driver not simple using other numbers
 c) if it doesn't preventing it from working at all, also for
    devices you don't "replace" with your PV devices.
 d) that the guest actually uses the minors your claim, e.g. any
    current linux distribution uses libata anyway, so you old IDE
    major claim wouldn't do anything.  Nor would claiming sd majors
    as the low-level libata driver would still drive the hardware
    even if SD doesn't bind to it.

You really must never present the same device as two emulated devices
instead of doing such hacks.
