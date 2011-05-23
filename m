From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: vmbus driver
Date: Mon, 23 May 2011 15:51:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1105231550360.3078@ionos>
References: <1305842785-30206-1-git-send-email-kys@microsoft.com> <20110520122649.GA550@infradead.org> <6E21E5352C11B742B20C142EB499E0481FC2ED@TK5EX14MBXC122.redmond.corp.microsoft.com> <20110522105941.GB8346@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481FC6DF@TK5EX14MBXC122.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481FC6DF@TK5EX14MBXC122.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 23 May 2011, KY Srinivasan wrote:
> I am working on getting Hyper-V drivers (drivers/staging/hv/*) out of staging.
> I would like to request you to look at the Hyper-V timesource driver:
> drivers/staging/hv/hv_timesource.c. The supporting code for this driver
> is already part of the base kernel. Let me know if this driver is ready to exit staging.

Can you please send a patch against drivers/clocksource (the staging
part is uninteresting for review).

Thanks,

	tglx
