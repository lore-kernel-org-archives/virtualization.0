From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH] staging: hv: Fix GARP not sent after Quick Migration
Date: Tue, 5 Apr 2011 15:54:54 +0000
Message-ID: <A1F3067C9B68744AA19F6802BAB8FFDC03FB03A6@TK5EX14MBXC223.redmond.corp.microsoft.com>
References: <1302017268-22913-1-git-send-email-haiyangz@microsoft.com>
 <20110405154133.GA30923@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110405154133.GA30923@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Hank Janssen <hjanssen@microsoft.com>, KY Srinivasan <kys@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Mike Surcouf <mike@surcouf.co.uk>, stable <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Tuesday, April 05, 2011 11:42 AM
> But that's a hypervisor bug, right?  It shouldn't be sending a "connect"
> event on the ethernet device if the network really isn't present.  How
> about getting it fixed there, which will resolve the issues for all
> guest operating systems, not just Linux.
>
> Or, if this is something that the hyperv developers are not going to
> fix, we need to document it in the code itself so that people don't try
> to remove it in a few years as an "optimization".

Fix on the Hyper-V side is not available for now at least. I will add the
comments into code.

Thanks,
- Haiyang
