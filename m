From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 09/20] Staging: hv: storvsc: Get rid of
 storvsc_dev_add() by inlining the code
Date: Tue, 13 Sep 2011 18:52:23 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081E4CB0@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-9-git-send-email-kys@microsoft.com>
 <20110913183941.GA23318@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110913183941.GA23318@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Tuesday, September 13, 2011 2:40 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 09/20] Staging: hv: storvsc: Get rid of storvsc_dev_add() by
> inlining the code
> 
> On Tue, Sep 13, 2011 at 10:59:45AM -0700, K. Y. Srinivasan wrote:
> > Get rid of storvsc_dev_add() by inlining the code.
> 
> This also means struct storvsc_device_info can go away, doesn't it?
> 
Yes;  PATCH 11/20 gets rid of struct storvsc_device_info definition and other unneeded state.

Regards,

K. Y
