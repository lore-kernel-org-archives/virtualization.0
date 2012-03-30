From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Xen-devel] [PATCH RFC V5 1/6] debugfs: Add support to print u32
	array in debugfs
Date: Fri, 30 Mar 2012 14:11:20 -0700
Message-ID: <20120330211120.GA15000__43616.4260762327$1333381133$gmane$org@kroah.com>
References: <20120323080503.14568.43092.sendpatchset@codeblue>
	<20120323080606.14568.31335.sendpatchset@codeblue>
	<20120330204912.GA29329@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120330204912.GA29329@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Xen <xen-devel@lists.xensource.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, X86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization <virtualization@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 30, 2012 at 04:49:12PM -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Mar 23, 2012 at 01:36:28PM +0530, Raghavendra K T wrote:
> > From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
> > 
> > Move the code from Xen to debugfs to make the code common
> > for other users as well.
> > 
> > Signed-off-by: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
> > Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
> > Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Greg,
> 
> I was thinking to stick this patch in my queue, but I need your
> OK since it touches fs/debugfs/file.c.

That's fine with me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
