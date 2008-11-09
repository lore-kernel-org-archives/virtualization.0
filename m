From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Sun, 09 Nov 2008 14:58:06 +0200
Message-ID: <4916DE5E.6070805__49569.236362777$1226235658$gmane$org@redhat.com>
References: <20081106154351.GA30459@kroah.com>
	<894107.30288.qm@web45108.mail.sp1.yahoo.com>
	<20081106164919.GA4099@kroah.com>
	<20081106174741.GC11773@parisc-linux.org>
	<20081106175308.GA17027@kroah.com> <49137255.9010104@codemonkey.ws>
	<20081107061700.GD3860@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081107061700.GD3860@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>
Cc: randy.dunlap@oracle.com, Chris Wright <chrisw@sous-sol.org>, grundler@parisc-linux.org, achiang@hp.com, Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Greg KH wrote:
>> We've been talking about avoiding hardware passthrough entirely and
>> just backing a virtio-net backend driver by a dedicated VF in the
>> host.  That avoids a huge amount of guest-facing complexity, let's
>> migration Just Work, and should give the same level of performance.
>>     
>
> Does that involve this patch set?  Or a different type of interface.
>   

So long as the VF is exposed as a standalone PCI device, it's the same 
interface.  In fact you can take a random PCI card and expose it to a 
guest this way; it doesn't have to be SR-IOV.  Of course, with a 
standard PCI card you won't get much sharing (a quad port NIC will be 
good for four guests).

We'll need other changes in the network stack, but these are orthogonal 
to SR-IOV.

-- 
error compiling committee.c: too many arguments to function
