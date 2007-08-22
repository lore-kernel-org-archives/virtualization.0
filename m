From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 23:29:14 +0100
Message-ID: <46CCB8BA.6060007@superbug.demon.co.uk>
References: <46CBC842.4070100@vmware.com> <46CCB088.8070606@goop.org>
	<46CCB56F.8090308@superbug.co.uk>
	<20070822222036.GD3672@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070822222036.GD3672@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> * James Courtier-Dutton (James@superbug.co.uk) wrote:
>> If one could directly expose a device to the guest, this feature could
>> be extremely useful for me.
>> Is it possible? How would it manage to handle the DMA bus mastering?
> 
> Yes it's possible (Xen supports pci pass through).  Without an IOMMU
> (like Intel VT-d or AMD IOMMU) it's not DMA safe.
> 
> thanks,
> -chris

Ok, so I need to get a new CPU like the Intel Core Duo that has VT
features? I have an old Pentium 4 at the moment, without any VT features.

Kind Regards

James
