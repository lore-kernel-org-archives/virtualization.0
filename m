From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 00/21] Xen-paravirt: Xen guest
 implementation for paravirt_ops interface
Date: Thu, 15 Feb 2007 23:20:46 -0800
Message-ID: <45D55B4E.4000008@goop.org>
References: <20070216022449.739760547@goop.org>
	<20070215225932.11a1b43e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070215225932.11a1b43e.akpm@linux-foundation.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Thu, 15 Feb 2007 18:24:49 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> This patch series implements the Linux Xen guest in terms of the
>> paravirt-ops interface.
>>     
>
> The whole patchset exports 67 symbols to modules.  How come?
>
> Are they all needed?

Yep, pretty much.  They're all generally to do with Xen's virtual device
model, and are needed by modular frontend/backed drivers.  This series
only includes the basic block and network frontend devices, but there
are more waiting in the wings.

The breakdown, roughly, is:

    * event channel management
    * pseudophysical <-> machine addresses
    * grant-table management
    * xenbus, which includes
          o which has a filesystem-like namespace
          o the means to monitor changes in objects in the namespace
          o shared resource management
          o suspend/resume



    J
