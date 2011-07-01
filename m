From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 24/40] Staging: hv: storvsc: On I/O get the correct IDE
	device
Date: Fri, 1 Jul 2011 04:17:25 -0400
Message-ID: <20110701081725.GC28322@infradead.org>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-24-git-send-email-kys@microsoft.com>
	<20110630194055.GC22707@infradead.org>
	<6E21E5352C11B742B20C142EB499E0480816C2CF@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0480816C2CF@TK5EX14MBXC126.redmond.corp.microsoft.com>
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
Cc: "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 30, 2011 at 09:15:54PM +0000, KY Srinivasan wrote:
> That is what I did initially. Then looking at the way we  were handling scsi devices
> where each scsi controller configured for the guest results in an emulated HBA
> (scsi host) in the guest and all the block devices under a given controller are
> handled through this one host, I decided to mimic a similar structure  - one
> scsi host for all the block devices configured as an IDE device.
> 
> I can go back to my earlier implementation with one host per disk.

Was there any downside you noticed from using one host per emulated
disk? 
