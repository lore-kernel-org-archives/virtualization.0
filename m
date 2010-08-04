From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/6] staging: hv: Fixed bounce kmap problem by using
	correct index
Date: Wed, 4 Aug 2010 10:04:06 -0700
Message-ID: <20100804170406.GA28217@suse.de>
References: <8AFC7968D54FB448A30D8F38F259C56223FD0D21@TK5EX14MBXC114.redmond.corp.microsoft.com>
	<20100803173732.GA1455@suse.de>
	<8AFC7968D54FB448A30D8F38F259C56223FE8B19@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56223FE8B19@TK5EX14MBXC114.redmond.corp.microsoft.com>
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
Cc: "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 04, 2010 at 04:35:06AM +0000, Hank Janssen wrote:
> 
> And then Greg spoke:
> >>On Tue, Aug 03, 2010 at 05:31:51PM +0000, Hank Janssen wrote:
> >> From: Hank Janssen <hjanssen@microsoft.com>
> >> 
> > >Fixed bounce offset kmap problem by using correct index
> >
> >Is this a bugfix that needs to go to previous kernel releases?  If so, which ones?  What is the symptom of the problem here?
> 
> Yes, this should be backported to all stable kernel releases that have the Hyper-V drivers In them.  
> 
> The symptom of the problem is that in some NAS appliances this problem represents
> Itself by a unresponsive VM under a load with many clients writing small files.
> 
> I actually goofed up in my previous code and used an incorrect index number
> For this part of the code. It should have shown up in more situations than what
> I have seen oddly enough.

Please provide this type of information in the changelog section.

If you want something backported to older stable kernels, add a:
	Cc: stable <stable@kernel.org>
to the signed-off-by area of the patch and it will be automatically sent
to the stable alias when it gets included in Linus's tree so I know to
pick it up then.

Care to resend all of these patches based on these comments?

thanks,

greg k-h
