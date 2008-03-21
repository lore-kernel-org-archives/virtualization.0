From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [RFC/PATCH 15/15] guest: virtio device support, and
	kvm hypercalls
Date: Fri, 21 Mar 2008 08:12:15 +0100
Message-ID: <47E35FCF.80306__24268.1555486799$1206083717$gmane$org@de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030328.6690.66.camel@cotte.boeblingen.de.ibm.com>
	<200803211124.49829.rusty@rustcorp.com.au>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803211124.49829.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Ehrhardt <EHRHARDT@de.ibm.com>, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntrae@linux.vnet.ibm.com, rvdheij@gmail.com, Olaf Schnapper <os@de.ibm.com>, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>> +static int __init kvm_devices_init(void)
>> +{
>> +	if (!MACHINE_IS_KVM)
>> +		return -ENODEV;
>> +
>> +	if (device_register(&kvm_root) != 0)
>> +		panic("Could not register kvm root");
>> +
>> +	if (add_shared_memory((max_pfn) << PAGE_SHIFT, PAGE_SIZE)) {
>> +		device_unregister(&kvm_root);
>> +		return -ENOMEM;
>> +	}
> 
> Hmm, panic on device_register fail, but -ENOMEM on add_shared_memory fail?
> My theory was that since this is boot time, panic() is the right thing.
We can't tell whether or not this is an important device or not. Maybe 
the guest is running with ramdisk as rootfs and can have a happy life 
if we don't kill it here. Return the rc from device register seems to 
be the right thing to me, if it was an important device we'll see 
"panic: cannot mount rootfs" or something later.
