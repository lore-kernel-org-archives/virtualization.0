From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] staging: hv: Removed unneeded call to
	netif_stop_queue() in hv_netvsc
Date: Fri, 7 Jan 2011 10:08:41 -0800
Message-ID: <20110107180841.GA14093@suse.de>
References: <1294421139-18657-1-git-send-email-hjanssen@microsoft.com>
	<20110107173139.GA12343@suse.de>
	<8AFC7968D54FB448A30D8F38F259C56233F397CF@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56233F397CF@TK5EX14MBXC114.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 07, 2011 at 05:48:11PM +0000, Hank Janssen wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@suse.de]
> > Sent: Friday, January 07, 2011 9:32 AM
> > 
> > What kernel is this needed for, .37?  .38?  older than .37?
> > 
> > thanks,
> > 
> > greg k-h
> 
> This is needed for kernels 2.6.37 and newer.

Ok.

> Btw, I have not seen KVP patches that where submitted in linux next yet.
> I have not seen any other requests for changes to them, is there anything else needed for acceptance?

No, they are in my "to-apply" queue, they missed the deadline for .38,
sorry, due to the holiday break.  I'll queue them up when .38-rc1 is
out.

thanks,

greg k-h
