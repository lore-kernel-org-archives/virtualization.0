From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 15/16 v6] PCI: document the SR-IOV sysfs entries
Date: Wed, 5 Nov 2008 20:46:13 -0800
Message-ID: <20081106044613.GA30397__32085.1188771941$1225947072$gmane$org@kroah.com>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084515.GO3773@yzhao12-linux.sh.intel.com>
	<20081106043318.GB30292@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081106043318.GB30292@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 05, 2008 at 08:33:18PM -0800, Greg KH wrote:
> On Wed, Oct 22, 2008 at 04:45:15PM +0800, Yu Zhao wrote:
> > Document the SR-IOV sysfs entries.
> > 
> > Cc: Alex Chiang <achiang@hp.com>
> > Cc: Grant Grundler <grundler@parisc-linux.org>
> > Cc: Greg KH <greg@kroah.com>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> > Cc: Matthew Wilcox <matthew@wil.cx>
> > Cc: Randy Dunlap <randy.dunlap@oracle.com>
> > Cc: Roland Dreier <rdreier@cisco.com>
> > Signed-off-by: Yu Zhao <yu.zhao@intel.com>
> > 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci |   33 +++++++++++++++++++++++++++++++
> >  1 files changed, 33 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> > index ceddcff..41cce8f 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -9,3 +9,36 @@ Description:
> >  		that some devices may have malformatted data.  If the
> >  		underlying VPD has a writable section then the
> >  		corresponding section of this file will be writable.
> > +
> > +What:		/sys/bus/pci/devices/.../iov/enable
> 
> Are you sure this is still the correct location with your change to
> struct device?

Nevermind, this is correct.

But the bigger problem is that userspace doesn't know when these
attributes show up.  So tools like udev and HAL and others can't look
for them as they never get notified, and they don't even know if they
should be looking for them or not.

Is there any way to tie these attributes to the "main" pci device so
that they get created before the device is announced to the world?
Doing that would solve this issue.

thanks,

greg k-h
