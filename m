From: "Dong, Eddie" <eddie.dong@intel.com>
Subject: RE: [PATCH 6/6 v3] PCI: document the change
Date: Tue, 14 Oct 2008 12:18:40 +0800
Message-ID: <08DF4D958216244799FC84F3514D70F00235CF5E@pdsmsx415.ccr.corp.intel.com>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F6@pdsmsx502.ccr.corp.intel.com>
	<20081001160706.GI13822@parisc-linux.org>
	<08DF4D958216244799FC84F3514D70F00235CC69@pdsmsx415.ccr.corp.intel.com>
	<20081014010827.GX25780@parisc-linux.org>
	<08DF4D958216244799FC84F3514D70F00235CE27@pdsmsx415.ccr.corp.intel.com>
	<20081014021435.GA1482@yzhao12-linux.sh.intel.com>
	<20081014040105.GA25780@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20081014040105.GA25780@parisc-linux.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>, "Zhao, Yu" <yu.zhao@intel.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Grant Grundler <grundler@parisc-linux.org>, Alex Chiang <achiang@hp.com>, linux-pci@vger.kernel.org, Roland Dreier <rdreier@cisco.com>, "Dong,
	Eddie" <eddie.dong@intel.com>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

Matthew Wilcox wrote:
> On Tue, Oct 14, 2008 at 10:14:35AM +0800, Yu Zhao wrote:
>>> BTW, the SR-IOV patch is not only for network, some
>>> other devices such as IDE will use same code base as
>>> well and we image it could have other parameter to set
>>> such as starting LBA of a IDE VF.   
>> 
>> As Eddie said, we have two problems here:
>> 1) User has to set device specific parameters of a VF
>> when he wants to use this VF with KVM (assign this
>> device to KVM guest). In this case, 
>> VF driver is not loaded in the host environment. So
>> operations which 
>> are implemented as driver callback (e.g.
>> set_mac_address()) are not supported.
> 
> I suspect what you want to do is create, then configure
> the device in the host, then assign it to the guest.

That is not true. Rememver the created VFs will be destroyed no matter
for PF power event or error recovery conducted reset.
So what we want is:

Config, create, assign, and then deassign and destroy and then
recreate...

> 
>> 2) For security reason, some SR-IOV devices prohibit the
>> VF driver configuring the VF via its own register space.
>> Instead, the configurations must be done through the PF
>> which the VF is associated with. This means PF driver
>> has to receive parameters that are used to configure its
>> VFs. These parameters obviously can be passed by
>> traditional tools, if without modification for SR-IOV. 
> 
> I think that idea also covers this point.
> 
Sorry can u explain a little bit more? The SR-IOV patch won't define
what kind of entries should be created or not, we leave network
subsystem to decide what to do. Same for disk subsstem etc.

Thx, eddie
