From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 2/6] PCI: Scan all functions when running over Jailhouse
Date: Wed, 28 Feb 2018 11:01:05 +0100
Message-ID: <8adf7f98-3b05-2a76-48ec-111921219920__6480.14928815446$1519811993$gmane$org@siemens.com>
References: <cover.1519799691.git.jan.kiszka@siemens.com>
	<021d3dde4276c9bf4325f7bdc37e3c47069e48fc.1519799691.git.jan.kiszka@siemens.com>
	<alpine.DEB.2.21.1802280938380.1886@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1802280938380.1886@nanos.tec.linutronix.de>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: jailhouse-dev@googlegroups.com, Benedikt Spranger <b.spranger@linutronix.de>, linux-pci@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2018-02-28 09:44, Thomas Gleixner wrote:
> On Wed, 28 Feb 2018, Jan Kiszka wrote:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Per PCIe r4.0, sec 7.5.1.1.9, multi-function devices are required to
>> have a function 0.  Therefore, Linux scans for devices at function 0
>> (devfn 0/8/16/...) and only scans for other functions if function 0
>> has its Multi-Function Device bit set or ARI or SR-IOV indicate
>> there are more functions.
>>
>> The Jailhouse hypervisor may pass individual functions of a
>> multi-function device to a guest without passing function 0, which
>> means a Linux guest won't find them.
>>
>> Change Linux PCI probing so it scans all function numbers when
>> running as a guest over Jailhouse.
> 
>>  void pcibios_scan_specific_bus(int busn)
>>  {
>> +	int stride = jailhouse_paravirt() ? 1 : 8;
>>  	int devfn;
>>  	u32 l;
>>  
>>  	if (pci_find_bus(0, busn))
>>  		return;
>>  
>> -	for (devfn = 0; devfn < 256; devfn += 8) {
>> +	for (devfn = 0; devfn < 256; devfn += stride) {
>>  		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
>>  		    l != 0x0000 && l != 0xffff) {
>>  			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
> 
> Shouldn't that take the situation into account where the MFD bit is set on
> a regular devfn, i.e. (devfn % 8) == 0? In that case you'd scan the
> subfunctions twice.

Good point, and it also applies to pci_scan_child_bus_extend. Will add
some filters.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
