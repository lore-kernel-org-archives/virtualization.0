From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/1] Staging: hv: Integrate the time source driver with
	Hyper-V detection code
Date: Fri, 2 Sep 2011 13:30:59 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B5ECD@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1312300982-11609-1-git-send-email-kys@microsoft.com>
	<alpine.LFD.2.02.1109021013390.2723@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <alpine.LFD.2.02.1109021013390.2723@ionos>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "andi@firstfloor.org" <andi@firstfloor.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Friday, September 02, 2011 4:14 AM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; andi@firstfloor.org;
> akpm@linux-foundation.org; x86@kernel.org; Haiyang Zhang
> Subject: Re: [PATCH 1/1] Staging: hv: Integrate the time source driver with Hyper-
> V detection code
> 
> On Tue, 2 Aug 2011, K. Y. Srinivasan wrote:
> 
> > The Hyper-V timesource driver is best integrated with Hyper-V detection code
> > since: (a) Linux guests running on Hyper-V need this timesource and (b)
> > by integrating with Hyper-V detection, we could significantly  minimize the
> > code in the timesource driver.
> >
> > Andrew, could you take this patch for the -mm tree. I have sent this patch
> > out multiple times and I have not recived any response or comments.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks Thomas. As you are one of the maintainers, would you be
taking this patch?

Regards,

K. Y 
