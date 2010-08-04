From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/6] staging: hv: Fixed bounce kmap problem by using
	correct index
Date: Wed, 4 Aug 2010 11:23:18 -0700
Message-ID: <20100804182318.GB29046@suse.de>
References: <8AFC7968D54FB448A30D8F38F259C56223FD0D21@TK5EX14MBXC114.redmond.corp.microsoft.com>
	<20100803173732.GA1455@suse.de>
	<8AFC7968D54FB448A30D8F38F259C56223FE8B19@TK5EX14MBXC114.redmond.corp.microsoft.com>
	<20100804170406.GA28217@suse.de>
	<8AFC7968D54FB448A30D8F38F259C56223FE8EF5@TK5EX14MBXC114.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56223FE8EF5@TK5EX14MBXC114.redmond.corp.microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 04, 2010 at 05:17:21PM +0000, Hank Janssen wrote:
> 
> >And then Greg spoke:
> >> And then Greg spoke:
> > >>>On Tue, Aug 03, 2010 at 05:31:51PM +0000, Hank Janssen wrote:
> > >>> From: Hank Janssen <hjanssen@microsoft.com>
> > >>> 
> > >> >Fixed bounce offset kmap problem by using correct index
> > >>
> 
> SNIP
> 
> > > I actually goofed up in my previous code and used an incorrect index 
> > > number For this part of the code. It should have shown up in more 
> > > situations than what I have seen oddly enough.
> >
> >Please provide this type of information in the changelog section.
> >
> >If you want something backported to older stable kernels, add a:
> >	Cc: stable <stable@kernel.org>
> 
> I will re-submit all 5 patches and CC the stable mailing list on it as well.

5?  I see 6 of them here :)

thanks,

greg k-h
