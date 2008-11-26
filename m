From: Greg KH <greg@kroah.com>
Subject: Re: [SR-IOV driver example 0/3] introduction
Date: Wed, 26 Nov 2008 08:59:33 -0800
Message-ID: <20081126165933.GB28251__3103.09175770289$1227719039$gmane$org@kroah.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<20081126140303.GA13641@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081126140303.GA13641@yzhao12-linux.sh.intel.com>
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
Cc: xen-devel@lists.xensource.com, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 26, 2008 at 10:03:03PM +0800, Yu Zhao wrote:
> SR-IOV drivers of Intel 82576 NIC are available. There are two parts
> of the drivers: Physical Function driver and Virtual Function driver.
> The PF driver is based on the IGB driver and is used to control PF to
> allocate hardware specific resources and interface with the SR-IOV core.
> The VF driver is a new NIC driver that is same as the traditional PCI
> device driver. It works in both the host and the guest (Xen and KVM)
> environment.
> 
> These two drivers are testing versions and they are *only* intended to
> show how to use SR-IOV API.

That's funny, as some distros are already shipping this driver.  You
might want to tell them that this is an "example only" driver and not to
be used "for real"... :(

greg k-h
