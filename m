From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 05/10] staging: hv: Convert camel cased functions in
 hv.c to lower cases
Date: Tue, 2 Nov 2010 21:06:56 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF728BA55BD7@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1288644369-12958-1-git-send-email-haiyangz@linuxonhyperv.com>
 <1288644369-12958-2-git-send-email-haiyangz@linuxonhyperv.com>
 <1288644369-12958-3-git-send-email-haiyangz@linuxonhyperv.com>
 <1288644369-12958-4-git-send-email-haiyangz@linuxonhyperv.com>
 <1288644369-12958-5-git-send-email-haiyangz@linuxonhyperv.com>
 <20101102170406.GA4557@jenkins.home.ifup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101102170406.GA4557@jenkins.home.ifup.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brandon Philips <brandon@ifup.org>
Cc: Hank Janssen <hjanssen@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

> From: Brandon Philips [mailto:brandon@ifup.org]
> Sent: Tuesday, November 02, 2010 1:04 PM
> > -static int HvQueryHypervisorInfo(void)
> > +static int hvquery_hypervisor_info(void)
> > -static u64 HvDoHypercall(u64 control, void *input, void *output)
> > +static u64 hvdo_hypercall(u64 control, void *input, void *output)
> 
> Should these be hv_do_hypercall and hv_query_hypervisor? That seems to
> be the style in the rest of the patch:

I didn't insert underscore between every word, for example, it's not
added between two short words.

Thanks,
- Haiyang
