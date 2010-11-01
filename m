From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 03/10] staging: hv: Convert camel cased struct fields	in
 hv.h to lower cases
Date: Mon, 1 Nov 2010 20:48:24 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF728BA1BFA2@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1288630429-12330-1-git-send-email-haiyangz@linuxonhyperv.com>
 <20101101174310.GA12632@suse.de>
 <1FB5E1D5CA062146B38059374562DF728BA19E86@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20101101183918.GA453@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101101183918.GA453@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Hank Janssen <hjanssen@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Monday, November 01, 2010 2:39 PM
> How about you fix this patch in the series and resend them?
> 
> And if you look at the kernel, there is no "g_" for global variable
> names, so I don't want to see that as part of the history at all.
> 
> I'll drop these series and wait for an updated one.

I have fixed the "g_" variable, and re-sent the patch set.

Thanks,

- Haiyang
