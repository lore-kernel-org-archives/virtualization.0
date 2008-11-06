From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Thu, 6 Nov 2008 07:43:51 -0800
Message-ID: <20081106154351.GA30459__6761.46611008352$1225987935$gmane$org@kroah.com>
References: <20081106044828.GA30417@kroah.com>
	<909674.99469.qm@web45112.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <909674.99469.qm@web45112.mail.sp1.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: H L <swdevyid@yahoo.com>
Cc: randy.dunlap@oracle.com, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 06, 2008 at 07:40:12AM -0800, H L wrote:
> 
> Greetings (from a new lurker to the list),

Welcome!

> To your question Greg, "yes" and "sort of" ;-).  I have started taking
> a look at these patches with a strong interest in understanding how
> they work.  I've built a kernel with them and tried out a few things
> with real SR-IOV hardware.

Did you have to modify individual drivers to take advantage of this
code?  It looks like the core code will run on this type of hardware,
but there seems to be no real advantage until a driver is modified to
use it, right?

Or am I missing some great advantage to having this code without
modified drivers?

thanks,

greg k-h
