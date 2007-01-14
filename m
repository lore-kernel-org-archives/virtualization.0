From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block
 device driver.
Date: Sun, 14 Jan 2007 12:37:46 +0000
Message-ID: <C1CFD49A.7286%Keir.Fraser@cl.cam.ac.uk>
References: <Pine.LNX.4.61.0701141202050.26276@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <Pine.LNX.4.61.0701141202050.26276@yvahk01.tjqt.qr>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On 14/1/07 11:05 am, "Jan Engelhardt" <jengelh@linux01.gwdg.de> wrote:

>> The block device frontend driver allows the kernel to access block
>> devices exported exported by a virtual machine containing a physical
>> block device driver.
> 
> Is this significantly different from ubd/hostfs that it actually warrants a
> reinvention?

It is certainly unlike hostfs because hostfs provides file-level access to
host storage, not block-level. It's unlike both ubd and hostfs in that both
of those (I believe) make significant use of the syscall interface (and so
assume they run in a process on a Linux host). Also our driver appears to be
lower level, pushing more responsibility for features like CoW into the VMM.
Arguably that's a more generically reusable and flexible strategy although
it requires more VMM run-time support (which a Xen system provides).

>> + (void)xenbus_switch_state(info->xbdev, XenbusStateConnected);
> 
> Cast remove, if xenbus_switch_state does not have __must_check.
> Also elsewhere.

Okay, we should certainly follow the general rule here.

 Thanks,
 Keir
