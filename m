From: Peter Foley <pefoley2@verizon.net>
Subject: Re: Hyper-V TODO file
Date: Wed, 31 Aug 2011 19:11:39 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1108311907130.20924@linux>
References: <1314829011-28922-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1314829011-28922-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 31 Aug 2011, K. Y. Srinivasan wrote:
> Greg, as I have been pestering you for some time now, we are very interested in
> exiting staging and we are willing to dedicate the necessary development 
> resources to address whatever issues that may still be pending. So, your help
> in identifying what needs to be done will be greatly appreciated. To that end,
> I think it will be useful to update the TODO file to reflect the current state of
> the drivers. Let us know how we should proceed here. 
 
An issue I've come across in the hyper-v drivers is the forced modular 
build. You might want to see if the "depends on m" is still needed.

Thanks,

Peter Foley
