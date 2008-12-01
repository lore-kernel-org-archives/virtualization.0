From: Yu Zhao <yu.zhao@intel.com>
Subject: Re: [SR-IOV driver example 2/3] PF driver: integrate with SR-IOV core
Date: Tue, 2 Dec 2008 00:44:27 +0800
Message-ID: <20081201164427.GB1464__7292.16426047987$1228135458$gmane$org@yzhao12-linux.sh.intel.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<20081126140303.GA13641@yzhao12-linux.sh.intel.com>
	<20081126142156.GB13668@yzhao12-linux.sh.intel.com>
	<20081126165859.GA28251@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081126165859.GA28251@kroah.com>
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
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 27, 2008 at 12:58:59AM +0800, Greg KH wrote:
> On Wed, Nov 26, 2008 at 10:21:56PM +0800, Yu Zhao wrote:
> > +			my_mac_addr[5] = (unsigned char)i;
> > +			igb_set_vf_mac(netdev, i, my_mac_addr);
> > +			igb_set_vf_vmolr(adapter, i);
> > +		}
> > +	} else
> > +		printk(KERN_INFO "SR-IOV is disabled\n");
> 
> Is that really true?  (oh, use dev_info as well.)  What happens if you
> had called this with "5" and then later with "0", you never destroyed
> those existing virtual functions, yet the code does:
> 
> > +	adapter->vfs_allocated_count = nr_virtfn;
> 
> Which makes the driver think they are not present.  What happens when
> the driver later goes to shut down?  Are those resources freed up
> properly?

For now we hard-code the tx/rx queues allocation so this doesn't
matter. Eventually this will become dynamic allocation: when number
of VFs changes the corresponding resources need to be freed.

I'll put more comments here.

Thanks,
Yu
