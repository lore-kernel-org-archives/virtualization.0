From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Sun, 9 Nov 2008 08:41:48 +0200
Message-ID: <20081109064147.GD7123__9300.73422282494$1226213114$gmane$org@il.ibm.com>
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
Cc: randy.dunlap@oracle.com, Chris Wright <chrisw@sous-sol.org>, grundler@parisc-linux.org, achiang@hp.com, Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 06, 2008 at 04:40:21PM -0600, Anthony Liguori wrote:

> We've been talking about avoiding hardware passthrough entirely and
> just backing a virtio-net backend driver by a dedicated VF in the
> host.  That avoids a huge amount of guest-facing complexity, let's
> migration Just Work, and should give the same level of performance.

I don't believe that it will, and every benchmark I've seen or have
done so far shows a significant performance gap between virtio and
direct assignment, even on 1G ethernet. I am willing however to
reserve judgement until someone implements your suggestion and
actually measures it, preferably on 10G ethernet.

No doubt device assignment---and SR-IOV in particular---are complex,
but I hardly think ignoring it as you seem to propose is the right
approach.

Cheers,
Muli
-- 
The First Workshop on I/O Virtualization (WIOV '08)
Dec 2008, San Diego, CA, http://www.usenix.org/wiov08/
                       <->
SYSTOR 2009---The Israeli Experimental Systems Conference
http://www.haifa.il.ibm.com/conferences/systor2009/
