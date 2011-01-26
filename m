From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 7/8] staging: hv: Convert camel cased struct fields in
	vmbus_packet_format.h to lower cases
Date: Wed, 26 Jan 2011 20:09:47 +0000
Message-ID: <A1F3067C9B68744AA19F6802BAB8FFDC02482D@TK5EX14MBXC227.redmond.corp.microsoft.com>
References: <1296064206-11372-1-git-send-email-haiyangz@microsoft.com>
	<1296064206-11372-2-git-send-email-haiyangz@microsoft.com>
	<1296064206-11372-3-git-send-email-haiyangz@microsoft.com>
	<1296064206-11372-4-git-send-email-haiyangz@microsoft.com>
	<1296064206-11372-5-git-send-email-haiyangz@microsoft.com>
	<1296064206-11372-6-git-send-email-haiyangz@microsoft.com>
	<1296064206-11372-7-git-send-email-haiyangz@microsoft.com>
	<20110126180400.GS2721@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110126180400.GS2721@bicker>
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
To: Dan Carpenter <error27@gmail.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

> From: Dan Carpenter [mailto:error27@gmail.com]
> > +	VM_PKT_INVALID				= 0x0,
> > +	VM_PKT_SYNCH				= 0x1,
> > +	VM_PKT_ADD_XFER_PAGESET		= 0x2,
> > +	VM_PKT_RM_XFER_PAGESET		= 0x3,
>                                           ^^^^
> > +	VM_PKT_ESTABLISH_GPADL			= 0x4,
> > +	VM_PKT_TEARDOWN_GPADL			= 0x5,
> > +	VM_PKT_DATA_INBAND			= 0x6,
> > +	VM_PKT_DATA_USING_XFER_PAGES		= 0x7,
> > +	VM_PKT_DATA_USING_GPADL			= 0x8,
> > +	VM_PKT_DATA_USING_GPA_DIRECT		= 0x9,
> > +	VM_PKT_CANCEL_REQUEST			= 0xa,
> > +	VM_PKT_COMP			= 0xb,
>                                         ^^^^^^
> > +	VM_PKT_DATA_USING_ADDITIONAL_PKT	= 0xc,
> > +	VM_PKT_ADDITIONAL_DATA			= 0xd
> 
> 
> These don't line up with the others.

I have corrected and resubmitted them.

Thanks,
- Haiyang
