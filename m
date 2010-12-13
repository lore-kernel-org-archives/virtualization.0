From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 1/1] hv: Use only one receive buffer and kmalloc on
 initialize
Date: Mon, 13 Dec 2010 20:06:20 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C5622C0BC809@TK5EX14MBXC116.redmond.corp.microsoft.com>
References: <1292262350-29001-1-git-send-email-hjanssen@microsoft.com>
 <20101213183448.GA11745@kroah.com>
 <8AFC7968D54FB448A30D8F38F259C5622C0BB71F@TK5EX14MBXC116.redmond.corp.microsoft.com>
 <20101213194101.GA18431@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101213194101.GA18431@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, December 13, 2010 11:41 AM
> > The current versions of Hyper-V support interrupt handling on CPU0 only.
> > I can make multiple buffers per channel, but because of Hyper-V
> > implementation It does not really make a difference.
> 
> Then put a big fat note in there saying this, and that it will have to change if
> the hyperv channel ever changes.
> 
> Hm, how will you handle things if the hyperv core changes and an old kernel
> is running this code where things were "assumed" about the reentrancy
> happening here?

I will re-roll this patch to have a buffer per channel. It is a more elegant design
Even though Hyper-V behavior is not changing in Win8 for this.

Hank.
