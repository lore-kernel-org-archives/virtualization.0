From: "Christopher S. Aker" <caker@theshore.net>
Subject: Re: Xen paravirt frontend block hang
Date: Sat, 01 Mar 2008 19:43:04 -0500
Message-ID: <47C9F818.4020200__20954.4934718453$1204418764$gmane$org@theshore.net>
References: <4772AC8E.7010007@theshore.net> <47C712EF.1060703@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47C712EF.1060703@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> I've been running this all night without seeing any problem.  I'm using 
> current x86.git#testing with a few local patches, but nothing especially 
> relevent-looking.

Meh .. what backend are you using?  We're using LVM volumes exported 
directly into the domUs like so:

disk =[ 'phy:vg1/xencaker-56392,xvda,w', ... ]

> Could you try the attached patch to see if it makes any difference?

Unfortunately we're still in the same place... pv_ops kernels are still 
hanging after heavy disk IO:

works - 2.6.18.x (from xen-unstable)
hangs - 2.6.25-rc3-git3
hangs - 2.6.25-rc3-git3 + your patch

Any other suggestions or debugging I can provide that would be useful to 
squash this?

-Chris
