From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Staging: hv: util: Invoke cn_netlink_send() in a
 work context
Date: Mon, 10 Oct 2011 14:10:13 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081EC7C5@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1318214548-22572-1-git-send-email-kys@microsoft.com>
 <20111010114358.GA12665@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111010114358.GA12665@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "ohering@suse.com" <ohering@suse.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Monday, October 10, 2011 7:44 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; ohering@suse.com;
> Haiyang Zhang
> Subject: Re: [PATCH 1/1] Staging: hv: util: Invoke cn_netlink_send() in a work
> context
> 
> On Sun, Oct 09, 2011 at 07:42:28PM -0700, K. Y. Srinivasan wrote:
> > Invoke cn_netlink_send() in a work context as opposed being called
> > in the context of  channel callback. On entry into the channel callback
> > code the channel inbound spin lock is held and deferring to a work
> > context avoids having to invoke cn_netlink_send() while holding
> > the inbound lock. As part of this adjustment, also increase the
> > timeout value for waiting for the user level component of KVP.
> 
> As told a few times you really need to move away from the connector
> before sumitting the KVP support.  What about tackling that instead of
> band aiding it?

Christoph, I am still not sure what the issues with the connector are that you mention.
When I was initially designing the KVP feature, we did have a discussion of what the kernel/
user-mode transport should be and the connector interface was the consensus then. 
The changes in this patch, I would probably make no matter what the transport mechanism was;
nothing connector specific.

Regards,

K. Y


 
