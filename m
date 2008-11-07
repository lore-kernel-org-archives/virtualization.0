From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Thu, 6 Nov 2008 22:17:00 -0800
Message-ID: <20081107061700.GD3860__42452.2242545665$1226039715$gmane$org@kroah.com>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
	<20081106164919.GA4099@kroah.com>
	<20081106174741.GC11773@parisc-linux.org>
	<20081106175308.GA17027@kroah.com> <49137255.9010104@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49137255.9010104@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: randy.dunlap@oracle.com, Chris Wright <chrisw@sous-sol.org>, grundler@parisc-linux.org, achiang@hp.com, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 06, 2008 at 04:40:21PM -0600, Anthony Liguori wrote:
> Greg KH wrote:
>> On Thu, Nov 06, 2008 at 10:47:41AM -0700, Matthew Wilcox wrote:
>>   
>>> I don't think we really know what the One True Usage model is for VF
>>> devices.  Chris Wright has some ideas, I have some ideas and Yu Zhao has
>>> some ideas.  I bet there's other people who have other ideas too.
>>>     
>>
>> I'd love to hear those ideas.
>>   
>
> We've been talking about avoiding hardware passthrough entirely and
> just backing a virtio-net backend driver by a dedicated VF in the
> host.  That avoids a huge amount of guest-facing complexity, let's
> migration Just Work, and should give the same level of performance.

Does that involve this patch set?  Or a different type of interface.

thanks,

greg k-h
