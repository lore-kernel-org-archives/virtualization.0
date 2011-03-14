From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 11/21] Staging: hv: Make vmbus driver a platform pci driver
Date: Sun, 13 Mar 2011 20:24:37 -0700
Message-ID: <20110314032437.GA18645@suse.de>
References: <1299794912-1233-1-git-send-email-kys@microsoft.com>
	<20110310222034.GA19323@suse.de>
	<6E21E5352C11B742B20C142EB499E048018AA3@TK5EX14MBXC128.redmond.corp.microsoft.com>
	<20110310223256.GA8669@suse.de>
	<6E21E5352C11B742B20C142EB499E048018F4D@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E048018F4D@TK5EX14MBXC128.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Mike Sterling <Mike.Sterling@microsoft.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Mar 12, 2011 at 11:23:05PM +0000, KY Srinivasan wrote:
> Greg, I have redone this patch as well as [PATCH 12/21]. Do you want
> me send you just these two patches or the entire series including
> these two.

Just resend those two patches if that is easier.

> Also, does this patch-set address all of architectural issues you had
> noted earlier in the vmbus core. Please let us know what else needs to
> be done to exit staging as far as the vmbus driver is concerned. I
> want get a head start before the new week begins! Also, we have
> patches ready for all DPRINT cleanup. Hank is holding them off until
> we finish addressing the architectural issues first.

I do not know if this addresses everything, sorry, I have not had the
time to review all of them yet.  Give me a few days at the least to go
over them and apply them before I will be able to tell you this.

Also note that there shouldn't be anything holding back the DPRINT
stuff, why wait?  If they apply on top of yours that should be fine,
right?

thanks,

greg k-h
