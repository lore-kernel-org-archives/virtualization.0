From: H L <swdevyid@yahoo.com>
Subject: Re: [PATCH 0/16 v6] PCI: Linux kernel SR-IOV support
Date: Thu, 6 Nov 2008 08:41:53 -0800 (PST)
Message-ID: <894107.30288.qm__15117.5082115971$1225989943$gmane$org@web45108.mail.sp1.yahoo.com>
References: <20081106154351.GA30459@kroah.com>
Reply-To: swdevyid@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081106154351.GA30459@kroah.com>
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
Cc: randy.dunlap@oracle.com, grundler@parisc-linux.org, achiang@hp.com, matthew@wil.cx, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

I have not modified any existing drivers, but instead I threw together a bare-bones module enabling me to make a call to pci_iov_register() and then poke at an SR-IOV adapter's /sys entries for which no driver was loaded.

It appears from my perusal thus far that drivers using these new SR-IOV patches will require modification; i.e. the driver associated with the Physical Function (PF) will be required to make the pci_iov_register() call along with the requisite notify() function.  Essentially this suggests to me a model for the PF driver to perform any "global actions" or setup on behalf of VFs before enabling them after which VF drivers could be associated.

I have so far only seen Yu Zhao's "7-patch" set.  I've not yet looked at his subsequently tendered "15-patch" set so I don't know what has changed.    The hardware/firmware implementation for any given SR-IOV compatible device, will determine the extent of differences required between a PF driver and a VF driver.

--
Lance Hartmann


--- On Thu, 11/6/08, Greg KH <greg@kroah.com> wrote:


> Date: Thursday, November 6, 2008, 9:43 AM
> On Thu, Nov 06, 2008 at 07:40:12AM -0800, H L wrote:
> > 
> > Greetings (from a new lurker to the list),
> 
> Welcome!
> 
> > To your question Greg, "yes" and "sort
> of" ;-).  I have started taking
> > a look at these patches with a strong interest in
> understanding how
> > they work.  I've built a kernel with them and
> tried out a few things
> > with real SR-IOV hardware.
> 
> Did you have to modify individual drivers to take advantage
> of this
> code?  It looks like the core code will run on this type of
> hardware,
> but there seems to be no real advantage until a driver is
> modified to
> use it, right?
> 
> Or am I missing some great advantage to having this code
> without
> modified drivers?
> 
> thanks,
> 
> greg k-h
