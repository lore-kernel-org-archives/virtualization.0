From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH] staging: hv: Fix GARP not sent after Quick Migration
Date: Tue, 5 Apr 2011 17:32:07 +0000
Message-ID: <A1F3067C9B68744AA19F6802BAB8FFDC03FB0458@TK5EX14MBXC223.redmond.corp.microsoft.com>
References: <1302020655-27133-1-git-send-email-haiyangz@microsoft.com>
 <20110405162306.GA1800@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110405162306.GA1800@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Hank Janssen <hjanssen@microsoft.com>, KY Srinivasan <kys@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, stable <stable@kernel.org>, Mike Surcouf <mike@surcouf.co.uk>
List-Id: virtualization@lists.linuxfoundation.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, April 05, 2011 12:23 PM
> Instead, use a proper timer as you do know how long you need to wait,
> right?  Don't abuse workqueues for something they were not designed for.

Thanks for the suggestion, I will add an msleep. And, yes, this delay will
be removed if the Hyper-V side is fixed.

Thanks,
- Haiyang
